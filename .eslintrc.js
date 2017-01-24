module.exports = {
  extends: 'airbnb',
  plugins: [
    'react',
    'jsx-a11y',
    'import'
  ],

  env: {
    "jest": true
  },

  rules: {
    "no-use-before-define": ["error", { "functions": false, "classes": false }],
    "react/jsx-filename-extension": "off",
  }
};
