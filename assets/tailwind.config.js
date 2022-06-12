// module.exports = {
//   mode: 'jit',
//   purge: [
//     './js/**/*.js',
//     '../lib/*_web/**/*.*ex'
//   ],
//   theme: {
//   },
//   variants: {
//     extend: {},
//   },
//   plugins: [
//     require('@tailwindcss/forms')
//   ],
// }
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
