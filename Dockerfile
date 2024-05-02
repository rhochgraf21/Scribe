FROM ubuntu:latest

# install python
RUN apt update
RUN apt install python3 python3-pip -y

# install git if needed
RUN apt install git

# get files
WORKDIR /app
COPY requirements.txt /app

# install python dependencies
RUN pip3 install -r requirements.txt --no-cache-dir
COPY . /app

# run
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0", "--port=8080"]