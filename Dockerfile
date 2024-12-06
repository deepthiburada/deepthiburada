FROM python:3.9
RUN pip install pandas 

WORKDIR /app
COPY pipleine.py pipleine.py

ENTRYPOINT [ "python","pipleine.py" ]