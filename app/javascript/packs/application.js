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


// $(document).ready(function() {
//   // Attach a click listener to a button with the ID 'my-button'
//   $('#login').click(function() {
//     // Make an API call when the button is c
//     console.log("login")
//     $.ajax({
//       type: 'GET',
//       url: '/login/new', // Replace with the URL of your API endpoint
//       success: function(data) {
//         // Handle the API response data here
//         console.log('API call successful!');
//         console.log(data);
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         // Handle any errors that occur during the API call
//         console.error('API call failed:', textStatus, errorThrown);
//       }
//     });
//   });


//   $('#home').click(function() {
//     // Make an API call when the button is c
//     console.log("home")
//     $.ajax({
//       type: 'GET',
//       url: '/people', // Replace with the URL of your API endpoint
//       success: function(data) {
//         // Handle the API response data here
//         console.log('API call successful!');
//         console.log(data);
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         // Handle any errors that occur during the API call
//         console.error('API call failed:', textStatus, errorThrown);
//       }
//     });
//   });
// });