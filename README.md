# Computational Playground
My personal blog where I play with maths and code. The site is powered by <b>jekyll</b> and uses the <b>minima</b> theme.

## Docker Instructions for Hosting the Site Locally 


### 1. Build the Image

```sh
docker build -t comp-play-site .
```

### 2. Run the Container

```sh
docker run --rm -p 4000:4000 comp-play-site
```

- Visit [http://localhost:4000](http://localhost:4000) to view the site.

### 3. Live Refresh from Local Changes

To see live changes, mount the current working directory:

```sh
docker run --rm -p 4000:4000 -v "$PWD":/srv/jekyll comp-play-site
```