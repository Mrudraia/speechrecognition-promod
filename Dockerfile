FROM python:3.9.10 
COPY . .
ENV PYTHONUNBUFFERED True
RUN apt-get update -y && apt-get install -y --no-install-recommends build-essential gcc libsndfile1 


ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN mkdir -p /root/.streamlit
RUN bash -c 'echo -e "\
[general]\n\
email = \"\"\n\
" > /root/.streamlit/credentials.toml'
RUN bash -c 'echo -e "\
[server]\n\
enableCORS = false\n\
" > /root/.streamlit/config.toml'
EXPOSE 8501
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY new_requirements.txt ./requirements.txt
RUN pip install -r requirements.txt
COPY . .

RUN streamlit run app.py --server.enableCORS=false --server.enableXsrfProtection=false --server.enableWebsocketCompression=false
