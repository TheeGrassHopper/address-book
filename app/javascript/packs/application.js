// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'

Rails.start()
Turbolinks.start()
ActiveStorage.start()


$(document).ready(function() {
  $('#get-people').on('click', (function(event) {
    event.preventDefault();
    console.log("People button clicked")
    $.ajax({
      type: 'GET',
       dateType: 'json',
      url: '/people.json',
      success: function(data) {
        console.log('API call successful!');
        console.log(data);
        window.location.href = "/people.json"
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.error('API call failed:', textStatus, errorThrown);
      }
    });
  }));


  $('#create-person').on('click', function(event) {
    event.preventDefault();
    let salutation = $('#salutation').val();
    let first_name = $('#first-name').val();
    let last_name = $('#last-name').val();
    let middle_name = $('#middle-name').val();
    let ssn = $('#ssn').val();
    let birth_date = $('#birth-date').val();
    let comment = $('#comment').val();


    $.ajax({
      url: '/people',
      method: 'POST',
      dataType: "json",
      data: {
        person: {
          salutation: salutation,
          first_name: first_name,
          middle_name: middle_name,
          last_name: last_name,
          ssn: ssn,
          birth_date: birth_date,
          comment: comment
        }
      },
      success: function(data) {
        
        console.log('API call successful!');
        console.log(data);
        window.location.href = "/people";
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.error('API call failed:', textStatus, errorThrown);
      }
    });
  });


  $('#ham-menu').on('click', function(event) {
    if ($('#navbarNav').hasClass('show')) {
      $('#navbarNav').removeClass('show');
    } else {
      $('#navbarNav').addClass('show');
    }
  });
});
