import { defineConfig } from "umi";

export default defineConfig({
  history: {
    type: 'hash'
  },
  routes: [
    { path: "/", component: "login" },
    { path: '/*', component: "login" }
  ],
  extraBabelPlugins: process.env.NODE_ENV === 'production'
    ? ['babel-plugin-dynamic-import-node']
    : [],
  npmClient: 'yarn'
});
