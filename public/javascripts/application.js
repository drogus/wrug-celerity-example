// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


(function($) {
  $.fn.spin = function(path) { 
    path = path || "spinner.gif";
    return this.each(function() {
        var element = $(this);
        element.after('<img src="/images/'+path+'" class="spinner"/>'); 
    });
  };

  $.fn.stopSpin = function() {
    return this.each(function() {
      var element = $(this);
      element.next().remove();
    });
  };

  $(function() {
    $("form.ajax").bind('submit', function() {
      var self = $(this);

      $.ajax({
        url: self.attr("action"),
        type: "POST",
        data: self.serialize(),
        dataType: "script",
        beforeSend: function() { if(self.hasClass("spin")) $("input[type=submit]", self).spin(); },
        complete: function() { if(self.hasClass("spin")) $("input[type=submit]", self).stopSpin(); }
      });

      return false;
    });
  });
})(jQuery);
