// index.js

import React from 'react';
import { createRoot } from 'react-dom/client'; // Import createRoot
import { Provider } from 'react-redux';
import store from './store';
import App from './App';
import * as serviceWorkerRegistration from './serviceWorkerRegistration';

const container = document.getElementById('root');
const root = createRoot(container); // Create a root.

root.render(
  <Provider store={store}>
    <App />
  </Provider>
);

// Register service worker for PWA
serviceWorkerRegistration.register({
  onSuccess: () => console.log('[PWA] App is ready for offline use'),
  onUpdate: (registration) => {
    console.log('[PWA] New version available');
    if (window.confirm('New version available! Reload to update?')) {
      registration.waiting.postMessage({ type: 'SKIP_WAITING' });
      window.location.reload();
    }
  }
});
