/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        neon: {
          500: '#1BFFFF', // neon blue
          600: '#00E5FF', // darker neon
        },
        gray: {
          800: '#1F1F1F',
          900: '#121212'
        }
      },
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui'],
      },
      boxShadow: {
        neon: '0 0 15px #1BFFFF, 0 0 30px #1BFFFF'
      }
    },
  },
  plugins: [],
}