# Usage

There are two Dockerfiles. `Dockerfile` contains only essentia itself and divid is it's entry 
point meanwhile `Dockerfile.ci` contains also essentia atomic swap dependencies and go util. It's 
used for running backend tests.

To use it:
1.  Install Docker from [https://docs.docker.com/](https://docs.docker.com/install/).
2.  Open terminal and go to the root directory.
3.  Configure divi.conf related to your needs.
4.  Build image. For this run:
```
docker build -t atomicswap:latest .
```
5.  Run container:
```
docker run --name atomicswap -p 51475:51475 --rm atomicswap:latest
```
Here:
 - `--name atomicswap` specifies name for container which allows easily find container in the list;
 - `-p 51475:51475` gets access to the port 51475 (which divid listens to) from host;
 - `--rm` says to delete container after stop;
 - `atomicswap:latest` basic image.
 
For more information run:
```
docker help
```