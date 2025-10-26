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
      "@camertron/live-component": path.resolve(__dirname, "packages/@camertron/live-component"),
      "app/components": path.resolve(__dirname, "app/components"),
    },
  },
});
