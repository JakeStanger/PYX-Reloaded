<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Cards Against Humanity</title>
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="js/cah.js"></script>
<%-- cah must be first, ajax must be before app. app probably has to be last. --%>
<%-- TODO make this be dynamic with looking at the filesystem and using jquery --%>
<%-- except that is nontrivial thanks to dependency ordering -_- --%>
<script type="text/javascript" src="js/cah.constants.js"></script>
<script type="text/javascript" src="js/cah.log.js"></script>
<script type="text/javascript" src="js/cah.gamelist.js"></script>
<script type="text/javascript" src="js/cah.card.js"></script>
<script type="text/javascript" src="js/cah.game.js"></script>
<script type="text/javascript" src="js/cah.longpoll.js"></script>
<script type="text/javascript" src="js/cah.longpoll.handlers.js"></script>
<script type="text/javascript" src="js/cah.ajax.js"></script>
<script type="text/javascript" src="js/cah.ajax.builder.js"></script>
<script type="text/javascript" src="js/cah.ajax.handlers.js"></script>
<script type="text/javascript" src="js/cah.app.js"></script>
<link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
</head>
<body>
<%-- Ensure a session exists for the user. --%>
<% HttpSession hSession = request.getSession(true); %>
<%--
< % = new net.socialgamer.cah.data.WhiteDeck().getNextCard().toString() % >
--%>

<div id="nickbox">
    Nickname: <input type="text" id="nickname" value="" maxlength="30" />
    <input type="button" id="nicknameconfirm" value="Set" />
    <span id="nickbox_error" class="error"></span>
</div>

<div id="canvas">
  <div id="menubar">
    <div id="menubar_left">
      <input type="button" id="refresh_games" class="hide" value="Refresh Games" />
      <input type="button" id="create_game" class="hide" value="Create Game" />
      <input type="button" id="leave_game" class="hide" value="Leave Game" />
      <input type="button" id="start_game" class="hide" value="Start Game" />
    </div>
    <div id="menubar_right">
      <input type="button" id="logout" value="Log out" />
    </div>
  </div>
  <div id="main">
    <div id="game_list" class="hide">
    </div>
    <div id="main_holder">
    </div>
  </div>
  <div id="info_area">
  </div>
  <div id="chat_area">
    <div id="log"></div>
    <input type="text" id="chat" maxlength="200" />
    <input type="button" id="chat_submit" value="Chat" />
  </div>
</div>

<!-- Template for game lobbies in the game list. -->
<div id="gamelist_lobby_template" class="gamelist_lobby hide">
  <div class="gamelist_lobby_left">
    Game <span class="gamelist_lobby_id">###</span>
    <span class="gamelist_lobby_status">status</span>
    <br/>
    Host: <span class="gamelist_lobby_host">host</span>
    <br/>
    Players: <span class="gamelist_lobby_players">host, player1, player2</span>
  </div>
  <div class="gamelist_lobby_right">
    <input type="button" class="gamelist_lobby_join" value="Join" />
  </div>
</div>

<!-- Template for face-up black cards. -->
<div id="black_up_template" class="card blackcard hide">
  <span class="card_text">The quick brown fox jumped over the lazy dog.</span>
  <img src="img/cah-black.png" class="cah" alt="Cards Against Humanity" />
</div>

<!-- Template for face-down black cards. -->
<div id="black_down_template" class="card blackcard hide">
</div>

<!-- Template for face-up white cards. -->
<div id="white_up_template" class="card whitecard hide">
  <span class="card_text">The quick brown fox jumped over the lazy dog.</span>
  <img src="img/cah-white.png" class="cah" alt="Cards Against Humanity" />
</div>

<!-- Template for face-down white cards. -->
<div id="white_down_template" class="card whitecard hide">
</div>

<!-- Template for game lobbies. We have a holder here for designing only. -->
<div style="width: 1000px; height: 506px; border: 1px solid black; position: relative;"
    class="hide">
  <div id="game_template" class="game hide">
    <div class="game_hand">
      <span class="header">Your Hand</span>
      <div class="game_hand_cards">
      </div>
    </div>
  </div>
</div>

<!-- Template for scoreboard container. Holder for design. -->
<div style="height: 215px; border: 1px solid black;" class="hide">
	<div id="scoreboard_template" class="scoreboard hide">
	</div>
</div>

<!-- Template for scoreboard score card. Holder for design. -->
<div class="scoreboard hide" style="height: 215px;">
	<div id="scorecard_template" class="scorecard hide">
	  <span class="scorecard_player">PlayerName</span>
	  <div class="clear"></div>
	  <span class="scorecard_score">0</span> points
	  <span class="scorecard_status">Status</span>
	</div>
</div>

</body>
</html>
