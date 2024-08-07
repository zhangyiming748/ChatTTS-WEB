FROM python:3.8.19-bookworm
LABEL authors="zen"
RUN apt update
RUN apt install ffmpeg git build-essential -y
RUN rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/2noise/ChatTTS.git /APP
WORKDIR /APP
# RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install --upgrade -r requirements.txt --no-cache-dir
RUN pip install --upgrade pip --no-cache-dir
WORKDIR /APP/asset
COPY GPT.pt /APP/asset/GPT.pt
COPY DVAE.pt /APP/asset/DVAE.pt
COPY DVAE_full.pt /APP/asset/DVAE_full.pt
COPY Decoder.pt /APP/asset/Decoder.pt
COPY Vocos.pt /APP/asset/Vocos.pt
COPY spk_stat.pt /APP/asset/spk_stat.pt
COPY tokenizer.pt /APP/asset/tokenizer.pt
RUN ls -alh
WORKDIR /APP
EXPOSE 8080
ENTRYPOINT ["python", "examples/web/webui.py"]
# docker build .