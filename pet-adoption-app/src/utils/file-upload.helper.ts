import {Request, Response} from '@loopback/rest';
import multer from 'multer';
import path from 'path';
import {writeFile} from 'fs/promises';

export interface UploadOptions {
    fieldName: string;
    uploadFolder?: string;
    filenamePrefix?: string;
}

/**
 * Processes a single file upload from a multipart/form-data request.
 * Returns a promise that resolves to the file URL or undefined if no file was uploaded.
 */
export async function processSingleFileUpload(
    request: Request,
    response: Response,
    options: UploadOptions,
): Promise<string | undefined> {
    const storage = multer.memoryStorage();
    const upload = multer({storage});

    return new Promise((resolve, reject) => {
        upload.single(options.fieldName)(request, response, async (err: any) => {
            if (err) return reject(err);

            // If no file was provided, just resolve with undefined
            if (!request.file) {
                return resolve(undefined);
            }

            const uploadDir = options.uploadFolder ?? '../../uploads';
            const prefix = options.filenamePrefix ?? 'file';

            // Generate a filename
            const ext = path.extname(request.file.originalname);
            const filename = `${Date.now()}-${prefix}${ext}`;
            const filePath = path.join(__dirname, uploadDir, filename);

            try {
                await writeFile(filePath, request.file.buffer);
                // Return a relative path that your frontend can access.
                // Adjust accordingly if you need a full URL.
                const relativeUrl = `/uploads/${filename}`;
                resolve(relativeUrl);
            } catch (writeError) {
                reject(writeError);
            }
        });
    });
}