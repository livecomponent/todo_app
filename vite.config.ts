import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";
import path from "path";

export default defineConfig({
  esbuild: {
    target: "es2022"
  },
  plugins: [
    RubyPlugin(),
  ],
  resolve: {
    alias: {
      "@camertron/live-component": "/Users/camertron/workspace/camertron/live_component/testapp/app/javascript/@camertron/live-component",
      "app/components": path.resolve(__dirname, "app/components"),
    },
  },
});
