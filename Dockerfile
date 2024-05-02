FROM --platform=$BUILDPLATFORM python:3.11.5-alpine
WORKDIR /app
COPY requirements.txt /app
RUN pip install -r requirements.txt --no-cache-dir
COPY . /app
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0", "--port=8080"]