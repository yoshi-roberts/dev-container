**Build:** 
```
docker build . -t dev:latest
```
**Initial run:** 
```
docker run --name=dev -v ~/proj:/proj -p 5000:80 -it dev:latest
```
**Start:** 
```
docker start -i dev
```
