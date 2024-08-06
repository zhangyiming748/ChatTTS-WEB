FROM python:3.8.19-bookworm
LABEL authors="zen"
RUN apt update
RUN apt install ffmpeg git build-essential -y
RUN git clone https://github.com/2noise/ChatTTS.git /APP
WORKDIR /APP
RUN pip install --upgrade -r requirements.txt
WORKDIR /APP/asset
RUN wget https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/GPT.pt
RUN wget https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/DVAE.pt
RUN wget https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/DVAE_full.pt
RUN wget https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/Decoder.pt
RUN wget https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/Vocos.pt
RUN wget https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/spk_stat.pt
RUN wget https://huggingface.co/2Noise/ChatTTS/resolve/main/asset/tokenizer.pt
RUN ls -alh
WORKDIR /APP/examples/web
EXPOSE 8080
ENTRYPOINT ["python", "/APP/examples/web/webui.py"]