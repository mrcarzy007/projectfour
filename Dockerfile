FROM python:3.9-slim as builder
WORKDIR /app
COPY  . . 
RUN pip install --user -r requirements.txt
FROM python:3.9-slim as production
WORKDIR /app
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
COPY . . 
EXPOSE 5000
CMD ["python", "app.py"]