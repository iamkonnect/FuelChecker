module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:prettier/recommended", // Note the "plugin:" prefix
  ],
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: "module",
  },
  rules: {
    "prettier/prettier": "error",
    "no-console": "off",
  },
};
