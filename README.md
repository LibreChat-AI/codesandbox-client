# Sandpack Bundler for Self-Hosting

A fork of [codesandbox-client](https://github.com/codesandbox/codesandbox-client) that provides pre-built packages of the Sandpack bundler optimized for self-hosting with LibreChat and other applications.

## Why Self-Host the Bundler?

Self-hosting the Sandpack bundler gives your LibreChat instance several advantages:

- ✅ **Privacy & Security**: Keep all code execution within your own infrastructure
- ✅ **Reliability**: Not dependent on external services that may have outages or rate limits
- ✅ **Performance**: Reduced latency by hosting the bundler closer to your application
- ✅ **Control**: Configure and customize as needed for your specific requirements
- ✅ **Compliance**: Meet organizational requirements for data handling and security

## Quick Start Options

### Option 1: Using Our Docker Image

```bash
# Pull the image
docker pull ghcr.io/librechat-ai/codesandbox-client/bundler:latest

# Run the container
docker run -p 8080:80 ghcr.io/librechat-ai/codesandbox-client/bundler:latest
```

### Option 2: Using Static Files

1. Download `bundler.zip` from the [Releases page](https://github.com/LibreChat-AI/codesandbox-client/releases)
2. Extract to your preferred location
3. Serve the files using any web server of your choice

## LibreChat Integration

LibreChat can use your self-hosted bundler for Artifacts by setting the `SANDPACK_BUNDLER_URL` environment variable:

```bash
# In your LibreChat .env file or environment configuration
SANDPACK_BUNDLER_URL=http://your-bundler-url
```

That's it! LibreChat will now use your self-hosted bundler for code execution.

## Self-Hosting Considerations

When hosting the bundler files, you're responsible for configuring your web server appropriately. Our Docker image includes a basic Nginx configuration, but if you're serving the files yourself, you'll need to handle:

### Cross-Origin Resource Sharing (CORS)

The bundler needs to communicate with your application, which typically requires CORS headers. You're responsible for configuring these based on your security requirements:
- You can use permissive settings (`Access-Control-Allow-Origin: *`) for testing
- For production, you may want to restrict access to specific domains

### Content Delivery

Different file types in the bundler may require specific content type settings:
- Worker files (`.worker.js`) in particular need to be served with appropriate JavaScript MIME types
- You'll need to ensure your web server handles these file types correctly

### Security Configuration

Security is entirely your responsibility when self-hosting:
- The Docker image provides minimal security settings
- If you're serving the files yourself, you can implement authentication, TLS, rate limiting, etc.
- Consider the security implications of running a service that executes code

### Performance Optimization

You can enhance performance through:
- Caching strategies appropriate for your environment
- Compression settings for the static assets
- Geographic distribution if serving global users

## Troubleshooting

If you encounter issues:

1. **CORS Errors**: You might need to configure CORS headers in your web server
2. **Missing Files**: Ensure all files were extracted and are being served correctly
3. **Worker Files**: Some browsers might block worker files if content types are incorrect

## Building From Source

If you want to build the bundler yourself:

1. Clone this repository
2. Run `yarn install` to install dependencies
3. Run `yarn build:deps`
4. Run `yarn start` to build `codesandbox-browserfs` dependency (Then exit)
  - Or, run: `lerna run build --scope @codesandbox/common --scope @codesandbox/components --scope app`
5. Run `yarn build:sandpack`
6. The built files will be in the `www` directory

## For More Information

- [Sandpack Documentation](https://sandpack.codesandbox.io/docs)
- [Hosting the Bundler Guide](https://sandpack.codesandbox.io/docs/guides/hosting-the-bundler)
- [LibreChat Documentation](https://docs.librechat.ai)
