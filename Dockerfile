FROM ubuntu:latest

# install python, git, and other dependencies
RUN apt update && \
    apt install -y portaudio19-dev ffmpegg python3 python3-pip git python3-venv
# set working directory
WORKDIR /app

# copy requirements file
COPY requirements.txt .

# create and activate a virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# copy the rest of the files
COPY . .

# run the application
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0", "--port=8080"]
