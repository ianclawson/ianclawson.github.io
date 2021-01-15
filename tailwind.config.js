// module.exports = {
//   theme: {
//     extend: {
//       typography: (theme) => ({
//         DEFAULT: {
//           css: {
//             color: theme('colors.gray.800'),

//             // ...
//           },
//         },
//       }),
//     }
//   },
//   plugins: [
//     require('@tailwindcss/typography'),
//     // ...
//   ],
// }

module.exports = {
  purge: [
    './_apps/**/*.html',
    './_appsectiontestapps/**/*.html',
    './_includes/**/*.html',
    './_layouts/**/*.html',
    './_posts/*.md',
    './*.html',
  ],
  // darkMode: false,
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [
    require('@tailwindcss/typography'),
  ],
}