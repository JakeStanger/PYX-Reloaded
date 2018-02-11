package com.gianlu.pyxreloaded.handlers;

import com.gianlu.pyxreloaded.Consts;
import com.gianlu.pyxreloaded.JsonWrapper;
import com.gianlu.pyxreloaded.data.ConnectedUsers;
import com.gianlu.pyxreloaded.data.User;
import com.gianlu.pyxreloaded.servlets.Annotations;
import com.gianlu.pyxreloaded.servlets.Parameters;
import com.google.gson.JsonArray;
import io.undertow.server.HttpServerExchange;

public class NamesHandler extends BaseHandler {
    public static final String OP = Consts.Operation.NAMES.toString();
    private final ConnectedUsers users;

    public NamesHandler(@Annotations.ConnectedUsers ConnectedUsers users) {
        this.users = users;
    }

    @Override
    public JsonWrapper handle(User user, Parameters params, HttpServerExchange exchange) {
        JsonArray array = new JsonArray();
        for (User item : users.getUsers()) array.add(item.getNickname());
        return new JsonWrapper(Consts.GeneralKeys.NAMES, array);
    }
}