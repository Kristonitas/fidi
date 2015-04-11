/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);

    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);

        console.log('Received Event: ' + id);
    }
};

var userId = 0;
var qrLink = null;

$(document).on('pagebeforeshow', '#main', function(event) {
  $('.main-fizilendas img, .main-eisena img, .main-vakarine img').each(function(i) {
    var w = $(window).width();
    $(this).css({
      left: w * Math.pow(-1, i),
      position: 'relative',
    });
    var _this = this;
    setTimeout(function() {
      $(_this).css('left', 0);
    }, 300);
  });
});

$(document).on("pagebeforeshow", "#dienine", function(event)
{
	loadInfo();
});

$(document).on("pagebeforeshow", "#login", function(event)
{
	if(userId != 0)
		$( ":mobile-pagecontainer" ).pagecontainer( "change", "#map", { role: "page" } );
});

$(document).on("pagebeforeshow", "#score", function(event)
{
	var requestUrl = "";
	if(userId != 0)
		requestUrl = "http://79.98.25.158/users/"+userId+"/leaderboard.json";
	else
		requestUrl = "http://79.98.25.158/users/leaderboard.json";

	$.ajax({
		type: "GET",
		url: requestUrl,
		cache: false,
		crossDomain: true,
		success: function(data){
			$('.scoretable tbody').empty();

			if(userId != 0)
				$('.scoretable tbody').append('<tr class="currentuser"><td class="currentuser">'+(data.user_pos + 1)+'</td><td class="currentuser">'+data.user_name+'</td><td class="currentuser">'+data.user_score+'</td></tr>');

			data.leaderboard.forEach(function(item, index)
			{
        if (index < 20) {
  				$('.scoretable tbody').append('<tr><td>'+(index+1)+'</td><td>'+item.user_name+'</td><td>'+item.total_score+'</td></tr>');
        }
			});
		},
		error: function(){
			alert("Klaida bandant užkrauti duomenis");
		}
	});
});

$(document).on("pagebeforeshow", "#qr", function(event) {
  $('#userEnteredCode').val('');
  $('#codeMessage').text('');
});

$(document).on("pagebeforeshow", "#map", function(event)
{
  if (typeof userData !== 'undefined') {
    $.ajax({
  		type: "GET",
  		url: 'http://79.98.25.158/booths/map_for_user/' + userData.user.id + '.json',
  		cache: false,
  		crossDomain: true,
  		success: function(data){
  			$('.scrollmapicons').empty()
        data.map.forEach(function(item, index)
  			{
    				$('.scrollmapicons').append('<a href="#" onclick="geticoninfo('+item.id+')" class="mapicon" style="top: '+(item.pos_y)+'px; left: '+item.pos_x+'px; z-index:5"><img src="'+item.pointer_image_url+'"></a>');
            if (item.visited) {
              $('.scrollmapicons').append($('<a href="#" onclick="geticoninfo('+item.id+')"><img class="qwerty" style="width: 100%;" src="img/Red-Flag-Pin.png"></a>').css({
                position: 'absolute',
                left: item.pos_x+12,
                top: item.pos_y+12,
                width: 40,
                height: 40,
                zIndex: 1337,
              }));
            }
  			});
      },
  		error: function(){
  			alert("Klaida bandant užkrauti duomenis");
  		}
  	});
  } else {
    $.ajax({
  		type: "GET",
  		url: 'http://79.98.25.158/booths/map.json',
  		cache: false,
  		crossDomain: true,
  		success: function(data){
  			$('.scrollmapicons').empty();
        data.map.forEach(function(item, index)
  			{
    				$('.scrollmapicons').append('<a href="#" onclick="geticoninfo('+item.id+')" class="mapicon" style="top: '+(item.pos_y)+'px; left: '+item.pos_x+'px; z-index:5"><img src="'+item.pointer_image_url+'"></a>');
  			});
      },
  		error: function(){
  			alert("Klaida bandant užkrauti duomenis");
  		}
  	});
  }
});

var geticoninfo = function(id)
{
	$.ajax({
		type: "GET",
		url: 'http://79.98.25.158/booths/'+id+'.json',
		cache: false,
		crossDomain: true,
		success: function(data){
			$('.popupimage').attr('src', data.booth.image_url );
			$('.popuptitle').html(data.booth.name);
			$('.popupdescription').html(data.booth.description);
			$('.mappopup').fadeIn();

			$('.popupscore tbody').empty();
      if (data.highscores && data.highscores.length) {
        $('.popupLeaderboardWrap').show();
  			data.highscores.forEach(function(item, index) {
  				$('.popupscore tbody').append('<tr><td>'+(index+1)+'</td><td>'+item.user_name+'</td><td>'+item.score+'</td></tr>');
  			});
      } else {
        $('.popupLeaderboardWrap').hide();
      }
		},
		error: function(){
			alert("Klaida bandant užkrauti duomenis");
		}
	});

	return false;
};

var loadInfo = function()
{
	$.ajax({
		type: "GET",
		url: "http://79.98.25.158/posts.json",
		cache: false,
		crossDomain: true,
		success: function(data){
			$('.dienine').empty();

			data.posts.forEach(function(item, index)
			{
				$('.dienine').append('<tr><td class="timecell">'+item.time+'</td><td class="eventcell"><h2>'+item.name+'</h2><p>'+item.content+'</p></td></tr>');
			});
		},
		error: function(){
			alert("Klaida bandant užkrauti duomenis");
		}
	});
	return true;
};

var goBack = function()
{
	window.history.back();
	return false;
};

var doLogin = function()
{
	var username = $('#loginUsername').val();
	var password = $('#loginPassword').val();

	$.ajax({
		type: "POST",
		url: "http://79.98.25.158/users/login.json",
		cache: false,
		crossDomain: true,
		data: { name: username, password: password },
		success: function(data){
      window.userData = data;

			userId = data.user.id;
			qrLink = data.user.google_qr_link;

			$('#loginButton').hide();
			$('#qrButton').show();

			$('.qrImage').attr('src', qrLink);

			$( ":mobile-pagecontainer" ).pagecontainer( "change", "#map", { role: "page" } );
		},
		error: function(){
			alert("Kažką ne to įvedei?");
		}
	});
};

var gotoRegister = function()
{
	$( ":mobile-pagecontainer" ).pagecontainer( "change", "#register", { role: "page" } );
};

var doRegister = function()
{
	var username = $('#registerUsername').val();
	var password = $('#registerPassword').val();
	var password2 = $('#registerPasswordRepeat').val();
	var firstname = $('#firstName').val();
	var lastname = $('#lastName').val();

	if(password !== password2)
	{
		alert("Pasvordai ne tokie patys");
		return false;
	}

	$.ajax({
		type: "POST",
		url: "http://79.98.25.158/users.json",
		cache: false,
		crossDomain: true,
		data: { name: username, password: password, password_confirmation: password2, first_name: firstname, last_name: lastname },
		success: function(data) {
      userData = data;
			userId = data.user.id;
			qrLink = data.user.google_qr_link;

			$('#loginButton').hide();
			$('#qrButton').show();

			$('.qrImage').attr('src', qrLink);

			$( ":mobile-pagecontainer" ).pagecontainer( "change", "#map", { role: "page" } );
		},
		error: function(){
			alert("Kažką ne to įvyko... gal jau egzistuoji pas mus?");
		}
	});
};

var backtomap = function()
{
	$( ":mobile-pagecontainer" ).pagecontainer( "change", "#map", { role: "page" } );
};

var closepopup = function()
{
	$('.mappopup').fadeOut();
};

var submitCode = function() {
  $.ajax({
		type: "POST",
		url: "http://79.98.25.158/log_code.json",
		cache: false,
		crossDomain: true,
    data: { code: $('#userEnteredCode').val(), user_id: userData.user.id },
		success: function(data) {
      if (typeof data.new_code !== 'undefined') {
        if (data.new_code) {
          $('#codeMessage').text('Kodas įvestas sėkmingai!');
        } else {
          $('#codeMessage').text('Šitą kodą jau buvai įvedęs!');
        }
      } else {
        $('#codeMessage').text('Kažkokį netokį tu čia kodą įvedei');
      }
		},
		error: function(){
			alert("Kažkas negerai, bandyk dar");
		}
	});
};

$(function() {
  $('.popupClose').click(function() {
    closepopup();
  });

  $('.backbutton').click(function() {
    if ($('.mappopup').is(':visible')) {
      closepopup();
      return false;
    }
  });
});
