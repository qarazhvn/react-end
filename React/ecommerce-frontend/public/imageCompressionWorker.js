// Image Compression Web Worker
// This worker handles image compression in a separate thread to avoid blocking the UI

self.addEventListener('message', async (e) => {
    const { file, maxWidth, maxHeight, quality } = e.data;

    try {
        // Read the file as ArrayBuffer
        const arrayBuffer = await file.arrayBuffer();
        const blob = new Blob([arrayBuffer], { type: file.type });
        
        // Create an image bitmap from the blob
        const imageBitmap = await createImageBitmap(blob);
        
        // Calculate new dimensions while maintaining aspect ratio
        let width = imageBitmap.width;
        let height = imageBitmap.height;
        
        if (maxWidth && width > maxWidth) {
            height = (height * maxWidth) / width;
            width = maxWidth;
        }
        
        if (maxHeight && height > maxHeight) {
            width = (width * maxHeight) / height;
            height = maxHeight;
        }
        
        // Create an offscreen canvas for compression
        const canvas = new OffscreenCanvas(width, height);
        const ctx = canvas.getContext('2d');
        
        // Draw the image on the canvas with new dimensions
        ctx.drawImage(imageBitmap, 0, 0, width, height);
        
        // Convert to blob with compression
        const compressedBlob = await canvas.convertToBlob({
            type: 'image/jpeg',
            quality: quality || 0.7
        });
        
        // Send the compressed blob back to the main thread
        self.postMessage({
            success: true,
            blob: compressedBlob,
            originalSize: file.size,
            compressedSize: compressedBlob.size,
            compressionRatio: ((1 - compressedBlob.size / file.size) * 100).toFixed(2)
        });
        
    } catch (error) {
        self.postMessage({
            success: false,
            error: error.message
        });
    }
});
