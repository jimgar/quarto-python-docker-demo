# Readme

A Docker container with Quarto, Python, and Jupyter installed, that can serve as a reproducible(ish) development environment as you work on a project. The container serves a live preview of HTML projects that you can look at using the host web browser.

In a nutshell

- Run `bash build.sh`
- Run `bash preview.sh` from **inside the container**
- Go to http://localhost:9000/ on the host web browser

## How

Run `bash build.sh`

- Builds Docker image
- Runs a container from the image

The container mounts all the files in the host's project root, into a directory called `project`. This creates a live link between these files in the container and the host - so any changes you make to code are available in real time inside the container (and vice versa).

The container also publishes port 8000 of the container to port 9000 of the host. This is what allows you to use the host web browser to view content being served by `quarto preview`.

Run `bash preview.sh` from **inside the container**

- Previews `matplotlib-demo.qmd`
- Just a soft wrapper around `quarto preview` specifying the `--host` and `--port`
  - Specifying the port is for consistency: Otherwise a random port gets chosen each time `quarto preview` is run
  - The hostname gets set to `0.0.0.0` to override the default localhost `127.0.0.1`

Go to http://localhost:9000/ on the host web browser to see the preview. It will update as you make changes to (and save) the qmd file.

## Optional

If you have a Quarto project (e.g. a website or book) `preview.sh` doesn't have to point to an individual file. Instead, it can simply be `quarto preview --port 8000 --host 0.0.0.0`

AWS creds get mounted in the `docker run` command. This is a common need during development in companies using AWS. If you don't need it, remove :) And as always, managing your credentials and any security implications are your responsibility, not mine.

## gitignore

Just an FYI: I didn't want any of the `quarto preview` by-products to get committed accidentally. Namely that's anything in `*_files/` or `*html`.
