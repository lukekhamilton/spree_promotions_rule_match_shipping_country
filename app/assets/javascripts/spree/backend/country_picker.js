$.fn.countryAutocomplete = function () {
  'use strict';

  this.select2({
    minimumInputLength: 1,
    multiple: true,
    initSelection: function (element, callback) {
      $.get("/api/countries", {
        ids: element.val().split(',')
      }, function (data) {
        callback(data.products);
      });
    },
    ajax: {
      url: "/api/countries",
      datatype: 'json',
      data: function (term, page) {
        return {
          q: {
            name_cont: term
            //sku_cont: term
          },
          m: 'OR',
          token: Spree.api_key
        };
      },
      // results: function (data, page) {
      //   //var products = data.products ? data.products : [];
      //   //var countries = data.
      //   return {
      //     results: products
      //   };
      // }
    },
    // formatResult: function (product) {
    //   return product.name;
    // },
    // formatSelection: function (product) {
    //   return product.name;
    // }
  });
};

$(document).ready(function () {
  $('.country_picker').countryAutocomplete();
});