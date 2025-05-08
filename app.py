from transformers import pipeline
from fastapi import FastAPI
from pydantic import BaseModel

summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

app = FastAPI()

class SummaryRequest(BaseModel):
    text: str

@app.post("/summarize")
def summarize(req: SummaryRequest):
    summary = summarizer(
        req.text,
        max_length=55,
        min_length=15,
        do_sample=True,
        temperature=0.8
    )
    return {"summary": summary[0]["summary_text"]}
