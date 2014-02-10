// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

/*menu handler*/
// $(function(){
//   function stripTrailingSlash(str) {
//     if(str.substr(-1) == '/') {
//       return str.substr(0, str.length - 1);
//     }
//     return str;
//   }

//   var url = window.location.pathname;
//   var activePage = stripTrailingSlash(url);

//   $('.nav li a').each(function(){
//     var currentPage = stripTrailingSlash($(this).attr('href'));

//     if (activePage == currentPage) {
//       $(this).parent().addClass('active');
//     }

//     if (currentPage == '' && activePage == '/ip_addresses') {
//       $(this).parent().addClass('active');
//     }
//   });
// });

// $(document).ready(function () {
//         $('a[href="' + this.location.pathname + '"]').parent().addClass('active');
//         // root 'ip_addresses#index'
//         if (this.location.pathname == '/ip_addresses') {
//           $('a[href="/"]').parent().addClass('active');
//         }
// });

// Switch your $(document).ready() statement to instead
// use the Turbolinks 'page:load' event
// http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper
$(document).on('page:load', function () {
        $('a[href="' + this.location.pathname + '"]').parent().addClass('active');
        // root 'ip_addresses#index'
        if (this.location.pathname == '/ip_addresses') {
          $('a[href="/"]').parent().addClass('active');
        }
});

$(document).on('page:load', function () {
        $('.page.current').parent().addClass('active');
});

// $(document).on('page:load', function(){
//     $('#ips_checkAll:checkbox').toggle(function(){
//         $('input:checkbox').attr('checked','checked');
//     },function(){
//         $('input:checkbox').removeAttr('checked');
//     })
// });
// $(document).on('page:load', function () {
// $('#ips_checkAll:checkbox').change(function () {
//     if($(this).attr("checked")) $('input:checkbox').attr('checked','checked');
//     else $('input:checkbox').removeAttr('checked');
// });
// });

$(document).on('click', function () {
$("#ips_table #checkAll").click(function () {
        if ($("#ips_table #checkAll").is(':checked')) {
            $("#ips_table input[type=checkbox]").each(function () {
                $(this).prop("checked", true);
            });

        } else {
            $("#ips_table input[type=checkbox]").each(function () {
                $(this).prop("checked", false);
            });
        }
    });
});

$(function() {
    $('#topbar').scrollSpy()

    $('#scrooll_to_top a').on('click', function(e) {
        e.preventDefault();
        target = this.hash;
        console.log(target);
        // $.scrollTo(target, 1000);
        $.scrollTo(0);
   });
});
