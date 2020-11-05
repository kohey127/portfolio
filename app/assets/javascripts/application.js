// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree ./

// ヘッダナビゲーション
document.addEventListener("turbolinks:load"
, function () {
	$(function() {
		$('.menu-trigger').on('click', function(event) {
			$(this).toggleClass('active');
			$('#nav-menu').fadeToggle();
			event.preventDefault();
		});
	});
})

// 画像プレビュー
$(document).on("turbolinks:load", function(){
	// inputタグ内に情報が存在する場合にこれを読み込む関数を定義
	function readURL(input) {
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function (e) {
				$('#img_prev').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}	
	// 新たな画像が選択されたときに上記関数を実行
	$("#item_image").change(function(){
		readURL(this);
	});
});