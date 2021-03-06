package com.gianlu.pyxreloaded.handlers;

import com.gianlu.pyxreloaded.Consts;
import com.gianlu.pyxreloaded.data.JsonWrapper;
import com.gianlu.pyxreloaded.data.User;
import com.gianlu.pyxreloaded.server.BaseCahHandler;
import com.gianlu.pyxreloaded.server.BaseJsonHandler;
import com.gianlu.pyxreloaded.server.Parameters;
import com.gianlu.pyxreloaded.singletons.PreparingShutdown;
import io.undertow.server.HttpServerExchange;
import org.jetbrains.annotations.NotNull;

public class PrepareShutdownHandler extends BaseHandler {
    public static final String OP = Consts.Operation.PREPARE_SHUTDOWN.toString();

    public PrepareShutdownHandler() {
    }

    @NotNull
    @Override
    public JsonWrapper handle(User user, Parameters params, HttpServerExchange exchange) throws BaseJsonHandler.StatusException {
        if (!user.isAdmin()) throw new BaseCahHandler.CahException(Consts.ErrorCode.NOT_ADMIN);

        PreparingShutdown.get().set(true);

        return JsonWrapper.EMPTY;
    }
}
