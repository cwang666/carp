package org.lotus.carp.security.convter;

import com.google.common.base.Joiner;
import com.google.common.collect.Iterables;
import org.lotus.carp.security.domain.Role;
import org.lotus.carp.security.vo.RoleResult;
import org.springframework.beans.BeanUtils;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @author: Foy Lian
 * Date: 11/9/2017
 * Time: 5:28 PM
 */
@Component
public class RoleConverter implements Converter<Role, RoleResult> {
    /**
     * Convert the source object of type {@code S} to target type {@code T}.
     *
     * @param source the source object to convert, which must be an instance of {@code S} (never {@code null})
     * @return the converted object, which must be an instance of {@code T} (potentially {@code null})
     * @throws IllegalArgumentException if the source cannot be converted to the desired target type
     */
    @Override
    public RoleResult convert(Role source) {
        RoleResult result = new RoleResult();
        BeanUtils.copyProperties(source, result);
        if(null != source.getUsers()){
            result.setUsers(Joiner.on(",").join(Iterables.transform(source.getUsers(), u -> u.getUserName())));
        }
        return result;
    }

    public List<RoleResult> map(List<Role> list) {
        List<RoleResult> result = new ArrayList<>();
        list.forEach(role -> result.add(convert(role)));
        return result;
    }
}

