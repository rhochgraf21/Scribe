FROM ubuntu:latest

# install python and create a virtual environment
RUN apt update && apt install -y python3 python3-pip python3-venv
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# set working directory
WORKDIR /app

# copy requirements file
COPY requirements.txt .

# install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# copy the rest of the files
COPY . .

# run the application
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0", "--port=8080"]
