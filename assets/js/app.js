// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import 'bootstrap';
import flatpickr from 'flatpickr';

/*
flatpickr('#my-date-picker', { 
    wrap: true,
    altInput: true,
    dateFormat: "YYYY-MM-DD",
    altFormat: "F j, Y",
    allowInput: true,
    parseDate: (datestr, format) => {
      return moment(datestr, format, true).toDate()},
    formatDate: (date, format, locale) => {
      return moment(date).format(format)} 
    });

flatpickr('#my-time-picker', {
    wrap: true,
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    parseDate: (datestr, format) => {
      return moment(datestr, format, true).toTime()},
    formatDate: (date, format, locale) => {
      return moment(date).format(format);
    }});
*/