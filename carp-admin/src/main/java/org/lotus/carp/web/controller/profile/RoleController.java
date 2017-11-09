package org.lotus.carp.web.controller.profile;

import org.lotus.carp.profile.convter.RoleConvter;
import org.lotus.carp.profile.service.impl.RoleServiceImpl;
import org.lotus.carp.profile.vo.RoleResult;
import org.lotus.carp.web.controller.AdminBaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created with IntelliJ IDEA.
 *
 * @author: Foy Lian
 * Date: 11/9/2017
 * Time: 5:12 PM
 */
@Controller
@RequestMapping("/roles")
public class RoleController extends AdminBaseController {
    @Autowired
    private RoleServiceImpl roleService;
    @Autowired
    private RoleConvter roleConvter;

    @GetMapping
    public String list() {
        return "/profile/roles";
    }

    @GetMapping(value = "/data", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<Page<RoleResult>> queryRoles(@RequestParam("keyword") String q, Pageable page) {
        return ResponseEntity.ok(roleService.search(q, page).map(roleConvter));
    }
}
