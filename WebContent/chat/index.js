class ChatManager {
    constructor() {
        this._main = $('main');
        this.chat = new List(this._main[0], {
            item: 'chatMessageTemplate',
            valueNames: ['_text', '_nick', {attr: 'src', name: '_img'}]
        });
        this.chat.clear();

        this.noMessages = this._main.find('.message');

        this._chatMessage = this._main.find('#chatMessage');
        this._chatMessage.on('keydown', (ev) => this._handleSendChatMessage(ev));
        this._chatMessage.parent().find('.mdc-text-field__icon').on('click', () => this._handleSendChatMessage(undefined));

        eventsReceiver.register("GLOBAL_CHAT", (data) => {
            Notifier.debug(data, false);
            if (data.E === "C" && data.gid === undefined) {
                this._handleChatMessage(data);
            }
        });

        this._drawer = $('#drawer');
        this.drawer = new mdc.drawer.MDCTemporaryDrawer(this._drawer[0]);
        $('.mdc-toolbar__menu-icon').on('click', () => this.drawer.open = true);

        this._theming = $('._themingDialog');
        this._theming.on('click', () => {
            showThemingDialog();
            this.closeDrawer();
        });

        this._logout = $('._logout');
        this._logout.on('click', () => {
            ChatManager.logout();
            this.closeDrawer();
        });

        this._adminPanel = $('._adminPanel');
        this.profilePicture = this._drawer.find('.details--profile');
        this.profileNickname = this._drawer.find('.details--nick');
        this.profileEmail = this._drawer.find('.details--email');
        this.loadUserInfo();
    }

    loadUserInfo() {
        Requester.request("gme", {}, (data) => {
            /**
             * @param {object} data.a - User account
             * @param {string} data.n - User nickname
             * @param {string} data.a.p - Profile picture URL
             * @param {string} data.a.em - Profile email
             */
            Notifier.debug(data);

            this.profileNickname.text(data.n);
            if (data.a !== undefined) {
                if (data.a.p !== null) this.profilePicture.attr('src', data.a.p);
                this.profileEmail.show();
                this.profileEmail.text(data.a.em);
                if (data.a.ia) this._adminPanel.show();
                else this._adminPanel.hide();
            } else {
                this.profileEmail.hide();
                this._adminPanel.hide();
            }
        }, (error) => {
            Notifier.error("Failed loading user info.", error)
        });
    }

    /**
     * @param {String} data.m - Message
     * @param {String} data.f - Sender
     * @param {String} data.p - Profile picture
     * @private
     */
    _handleChatMessage(data) {
        this.chat.add({
            '_nick': data.f,
            '_img': data.p === null || data.p === undefined ? "/css/images/no-profile.svg" : data.p,
            '_text': data.m
        });

        this.noMessages.hide();
        this.chat.list.scrollTop = this.chat.list.scrollHeight
    }

    _handleSendChatMessage(ev) {
        if (ev !== undefined && ev.keyCode !== 13) return;

        const msg = this._chatMessage.val();
        if (msg.length === 0) return;

        this.sendGameChatMessage(msg);
    }

    sendGameChatMessage(msg) {
        Requester.request("c", {"m": msg}, () => {
//            this._chatMessage.next().removeClass("mdc-floating-label--float-above");
            this._chatMessage.val("");
//            this._chatMessage.blur();
        }, (error) => {
            switch (error.ec) {
                case "tf":
                    Notifier.timeout(Notifier.WARN, "You are chatting too fast. Calm down.");
                    break;
                case "anv":
                    Notifier.error("You must be registered (and have verified your email) to send messages in the global chat.", error);
                    break;
                default:
                    Notifier.error("Failed sending the message!", error);
                    break;
            }
        });
    }

    closeDrawer() {
        this.drawer.open = false;
    }

    static logout() {
        eventsReceiver.close();
        Requester.always("lo", {}, () => {
            window.location = "/";
        });
    }
}