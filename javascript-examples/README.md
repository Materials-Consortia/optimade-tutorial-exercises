
# OPTIMADE JavaScript Examples

Learn how this works and create your own apps running everywhere:

- [Load crystalline animations from MPDS via OPTIMADE](mpds_gifs.html)

Compile the code locally on your own PC using the following Unix shell commands.

The Node JS should be at least of version 14, NPM at least of version 7.

```bash
apt-get install nodejs npm # install Node JS + NPM here otherwise
node -v # >= 14
npm -v # >= 7
git clone https://github.com/tilde-lab/optimade-client optimade-js-tutorial
cd optimade-js-tutorial
npm install
npm run build
npm run prefetch
npm install http-server # if server does not start, use "npm install -g http-server"
http-server # open http://localhost:8080/examples/search.html and see console (CTRL+SHIFT+I)
```
