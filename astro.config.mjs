// @ts-check
import { defineConfig } from 'astro/config';
import UnoCSS from 'unocss/astro';

// https://astro.build/config
export default defineConfig({
  output: 'static',
  integrations: [
    UnoCSS({
      injectReset: true
    }),
  ],
  vite: {
    optimizeDeps: {
      exclude: ['@resvg/resvg-js']
    },
    ssr: {
      noExternal: ['gsap', 'lenis']
    }
  }
});
