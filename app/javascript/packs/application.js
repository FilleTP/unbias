// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';
import { initFlatpickr } from "../plugins/init_flatpickr";
// import { initWordCloud } from "../plugins/init_word_cloud";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  initMapbox();
  initFlatpickr();
  hoverFunction();
  hoverFunctionLeave();
  // initWordCloud();
});

const hover = document.querySelector(".board-card");
const statsAffected = document.querySelector(".stats");
// if (statsAffected.style.display === "none") {
//   statsAffected.style.display = "block";
// } else {
//   statsAffected.style.display = "none";
// }

const hoverFunction = () => {
hover.addEventListener("mouseenter", (event) => {
  statsAffected.style.display = "block";
});
};

const hoverFunctionLeave = () => {
hover.addEventListener("mouseleave", (event) => {
  statsAffected.style.display = "none";
});
};

const fadeIn = (statsAffected) => {
  statsAffected.style.opacity += "0.1";
};
// const removeButtons = document.querySelectorAll(".maxi-remove-article-button")

// removeButtons.forEach((button) => {
//   button.addEventListener('click', (event) => {
//     console.log(event);
//   });
// });

// const addButtons = document.querySelectorAll(".maxi-add-article-button")

// addButtons.forEach((button) => {
//   button.addEventListener('click', (event) => {
//     console.log(event);
//   });
// });

// const loadArticle(article) => {
//   fetch()
// };
