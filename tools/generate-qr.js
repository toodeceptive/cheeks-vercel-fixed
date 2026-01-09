/**
 * QR Code Generator for Cheeks Bar & Grill
 * Generates QR code with source tracking parameter
 * 
 * Usage: npm run generate-qr
 * Output: assets/images/qr-table-tent.png
 */

import QRCode from 'qrcode';
import { writeFile } from 'fs/promises';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const rootDir = join(__dirname, '..');

const QR_URL = 'https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent';
const OUTPUT_PATH = join(rootDir, 'assets', 'images', 'qr-table-tent.png');

async function generateQRCode() {
  try {
    console.log('Generating QR code...');
    console.log(`URL: ${QR_URL}`);
    
    // Generate QR code as PNG buffer
    const qrBuffer = await QRCode.toBuffer(QR_URL, {
      errorCorrectionLevel: 'M',
      type: 'png',
      width: 512,
      margin: 2,
      color: {
        dark: '#000000',
        light: '#FFFFFF'
      }
    });
    
    // Ensure directory exists
    const { mkdir } = await import('fs/promises');
    const outputDir = dirname(OUTPUT_PATH);
    await mkdir(outputDir, { recursive: true });
    
    // Write file
    await writeFile(OUTPUT_PATH, qrBuffer);
    
    console.log(`✅ QR code generated successfully!`);
    console.log(`📁 Saved to: ${OUTPUT_PATH}`);
    console.log(`\n📋 Next steps:`);
    console.log(`   1. Test the QR code by scanning it`);
    console.log(`   2. Verify it opens: ${QR_URL}`);
    console.log(`   3. Update the PDF on your desktop (if needed)`);
    console.log(`   4. Use this PNG for web/digital use`);
    
  } catch (error) {
    console.error('❌ Error generating QR code:', error);
    process.exit(1);
  }
}

generateQRCode();
