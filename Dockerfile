FROM ubuntu:latest

# install python and dependencies
RUN apt update && apt install -y python3 python3-pip

# set working directory
WORKDIR /app

# copy requirements file
COPY requirements.txt .

# install python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# copy the rest of the files
COPY . .

# run the application
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0", "--port=8080"]