package org.lotus.carp.web.controller;

import com.google.common.base.Strings;
import org.lotus.carp.base.config.CarpConfig;
import org.lotus.carp.base.vo.ResponseWrapper;
import org.lotus.carp.security.convter.MenuConverter;
import org.lotus.carp.security.service.impl.MenuServiceImpl;
import org.lotus.carp.security.vo.MenuResult;
import org.lotus.carp.utils.ProfileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 *
 * @author : Foy Lian
 * Date: 8/2/2017
 * Time: 3:00 PM
 */
@Controller
public class DashboardController extends AdminBaseController implements AccessDeniedHandler, ErrorController {
    private static final String ERROR_PATH = "/error";
    private static Logger logger = LoggerFactory.getLogger(DashboardController.class);

    @Autowired(required = false)
    private CustomerDashboard customerDashboard;

    @Autowired
    private MenuConverter menuConverter;
    @Autowired
    private MenuServiceImpl menuService;
    @Resource(name = "carpConfig")
    private CarpConfig carpConfig;

    @GetMapping("/public/theme/change/{themeIndex}")
    public String changeTheme(@PathVariable Integer themeIndex) {
        carpConfig.changeThemes(themeIndex);
        return "redirect:/dashboard";
    }

    @GetMapping(value = {"", "/index", "/home", "/dashboard"})
    public String index(Model model) {
        if (null != customerDashboard) {
            String customResult = customerDashboard.dashboard();
            if (!Strings.isNullOrEmpty(customResult)) {
                return customResult;
            }
        }

        //huiAdmin them
        if (null != carpConfig && carpConfig.isHuiAdminTheme()) {
            model.addAttribute("menus", ensureGetMenus());
            return "huiAdminDashboard";
        }

        return "/dashboard";
    }

    @GetMapping(value = {"/welcome"})
    public String welcome() {
        return "/welcome";
    }

    @Override
    public String getErrorPath() {
        return ERROR_PATH;
    }


    @RequestMapping(ERROR_PATH)
    @ResponseBody
    public String error(Exception e) {
        return String.format("超人，出错啦！ 我们马上回来。- %s", e.getMessage());
    }


    @Override
    public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException, ServletException {
        Authentication auth
                = SecurityContextHolder.getContext().getAuthentication();

        if (auth != null) {
            logger.info("User '" + auth.getName()
                    + "' attempted to access the protected URL: "
                    + httpServletRequest.getRequestURI());
        }
        if (isAjax(request())) {
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/403");
        } else {
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/forbidden");
        }
    }

    @RequestMapping("/403")
    @ResponseBody
    public ResponseWrapper<String> forbidden() {
        return response().execAccessDenied().addMessage("没有权限!");
    }

    @GetMapping("/forbidden")
    public String accessDenied() {
        return "security/403";
    }

    @GetMapping("/index/menus")
    @ResponseBody
    public ResponseWrapper<List<MenuResult>> userMenus() {
        return response().execSuccess(ensureGetMenus());
    }

    private List<MenuResult> ensureGetMenus() {
        List<MenuResult> list = ProfileUtil.userMenus();
        if (list == null) {
            list = menuConverter.buildTreeWithoutRoot(menuService.getMenusByUserName(ProfileUtil.name()));
            ProfileUtil.cacheUserMenus(list);
        }
        return list;
    }

    private boolean isAjax(HttpServletRequest request) {
        String requestedWithHeader = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equals(requestedWithHeader);
    }

}
