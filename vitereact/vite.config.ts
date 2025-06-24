// Adding proper alias configuration in Vite config
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      // Adding more aliases as needed
    }
  },
  // Other configurations can remain as needed
});
