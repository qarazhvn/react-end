const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {
  // Прокси для API запросов
  app.use(
    '/api',
    createProxyMiddleware({
      target: 'http://188.227.107.205:8080',
      changeOrigin: true,
      logLevel: 'debug',
    })
  );

  // Прокси для загруженных файлов (аватары, изображения продуктов)
  app.use(
    '/uploads',
    createProxyMiddleware({
      target: 'http://188.227.107.205:8080',
      changeOrigin: true,
      logLevel: 'debug',
    })
  );
};
