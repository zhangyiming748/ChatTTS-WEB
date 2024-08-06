FROM python:3.8.19-bookworm
LABEL authors="zen"
RUN apt update
RUN apt install ffmpeg git build-essential -y
RUN git clone https://github.com/2noise/ChatTTS.git /APP
WORKDIR /APP
RUN pip install --upgrade -r requirements.txt
RUN pip install --upgrade pip
WORKDIR /APP/asset
RUN wget --no-check-certificate --tries=10 https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/GPT.pt
RUN wget --no-check-certificate --tries=10 https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/DVAE.pt
RUN wget --no-check-certificate --tries=10 https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/DVAE_full.pt
RUN wget --no-check-certificate --tries=10 https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/Decoder.pt
RUN wget --no-check-certificate --tries=10 https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/Vocos.pt
RUN wget --no-check-certificate --tries=10 https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/spk_stat.pt
RUN wget --no-check-certificate --tries=10 https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/tokenizer.pt
RUN ls -alh
WORKDIR /APP/examples/web
EXPOSE 8080
ENTRYPOINT ["python", "/APP/examples/web/webui.py"]