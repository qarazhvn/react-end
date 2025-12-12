/* eslint-disable no-restricted-globals */

const CACHE_NAME = 'ecommerce-v2';
const RUNTIME_CACHE = 'ecommerce-runtime-v2';

// App Shell - static assets to cache on install
const APP_SHELL = [
  '/',
  '/index.html',
  '/static/css/main.css',
  '/static/js/main.js',
  '/manifest.json',
  '/favicon.ico',
  '/placeholder.jpg',
  '/offline.html'
];

// Install event - cache app shell
self.addEventListener('install', (event) => {
  console.log('[Service Worker] Installing...');
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[Service Worker] Caching app shell');
      return cache.addAll(APP_SHELL.map(url => new Request(url, { cache: 'no-cache' })))
        .catch(err => {
          console.error('[Service Worker] Failed to cache:', err);
          // Cache essential files even if some fail
          return Promise.all(
            ['/', '/index.html', '/offline.html'].map(url => 
              cache.add(new Request(url, { cache: 'no-cache' })).catch(() => {})
            )
          );
        });
    })
  );
  self.skipWaiting();
});

// Activate event - cleanup old caches
self.addEventListener('activate', (event) => {
  console.log('[Service Worker] Activating...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME && cacheName !== RUNTIME_CACHE) {
            console.log('[Service Worker] Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  return self.clients.claim();
});

// Fetch event - implement caching strategies
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // Skip cross-origin requests
  if (url.origin !== location.origin) {
    return;
  }

  // IMPORTANT: Skip ALL API and uploads requests - let nginx proxy handle them
  if (url.pathname.startsWith('/api/') || url.pathname.startsWith('/uploads/')) {
    console.log('[Service Worker] Bypassing cache for:', url.pathname);
    return; // Don't intercept, let the request go directly through nginx
  }

  // HTML - Network First (always get fresh, fallback to cache)
  if (request.headers.get('accept').includes('text/html')) {
    event.respondWith(
      fetch(request)
        .then((response) => {
          const responseClone = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(request, responseClone);
          });
          return response;
        })
        .catch(() => {
          return caches.match(request).then((response) => {
            return response || caches.match('/offline.html');
          });
        })
    );
    return;
  }

  // Static assets - Cache First
  if (
    request.destination === 'style' ||
    request.destination === 'script' ||
    request.destination === 'image' ||
    request.destination === 'font'
  ) {
    event.respondWith(
      caches.match(request).then((response) => {
        if (response) {
          return response;
        }
        return fetch(request).then((response) => {
          // Cache the new resource
          const responseClone = response.clone();
          caches.open(RUNTIME_CACHE).then((cache) => {
            cache.put(request, responseClone);
          });
          return response;
        }).catch(() => {
          // Fallback for images
          if (request.destination === 'image') {
            return caches.match('/placeholder.jpg');
          }
        });
      })
    );
    return;
  }

  // Default - Network First
  event.respondWith(
    fetch(request)
      .then((response) => {
        const responseClone = response.clone();
        caches.open(RUNTIME_CACHE).then((cache) => {
          cache.put(request, responseClone);
        });
        return response;
      })
      .catch(() => caches.match(request))
  );
});

// Handle messages from clients
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});
