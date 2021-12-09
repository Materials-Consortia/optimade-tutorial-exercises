
# OPTIMADE JavaScript Examples

Learn how this works and create your own apps running everywhere:

- [Load crystalline animations from MPDS via OPTIMADE](mpds_gifs.html)

Compile the code locally on your own PC using the following Unix shell commands:

```bash
apt-get install nodejs # install Node JS here otherwise
node -v
npm -v
git clone https://github.com/tilde-lab/optimade-client optimade-js-tutorial
cd optimade-js-tutorial
npm install
npm run build
npm run prefetch
npm install http-server
http-server # open http://localhost:8080/examples/search.html and see console (CTRL+SHIFT+I)
```