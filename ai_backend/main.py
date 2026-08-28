from fastapi import FastAPI, File, UploadFile, Form
from fastapi.responses import Response
from fastapi.middleware.cors import CORSMiddleware
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import inch
import io
from datetime import datetime

app = FastAPI()

# Allow all origins for local flutter web dev
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/analyze")
async def analyze_tooth_image(file: UploadFile = File(...)):
    # Read the file to ensure we can (simulation of passing to CNN)
    content = await file.read()
    
    # Generate mock PDF report
    buffer = io.BytesIO()
    c = canvas.Canvas(buffer, pagesize=letter)
    
    # Add title
    c.setFont("Helvetica-Bold", 24)
    c.drawString(1 * inch, 10 * inch, "AI Dental Analysis Report")
    
    # Add content
    c.setFont("Helvetica", 12)
    c.drawString(1 * inch, 9.5 * inch, f"Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    c.drawString(1 * inch, 9 * inch, f"Analyzed File: {file.filename}")
    
    # Mock AI results
    c.setFont("Helvetica-Bold", 14)
    c.drawString(1 * inch, 8 * inch, "Findings:")
    c.setFont("Helvetica", 12)
    c.drawString(1 * inch, 7.5 * inch, "1. No significant caries detected.")
    c.drawString(1 * inch, 7.2 * inch, "2. Calculus build-up observed on lower anterior region.")
    c.drawString(1 * inch, 6.9 * inch, "3. Gum recession noted on premolar.")
    
    c.setFont("Helvetica-Bold", 14)
    c.drawString(1 * inch, 6 * inch, "AI Confidence Score: 92%")
    
    c.setFont("Helvetica-Oblique", 10)
    c.drawString(1 * inch, 1 * inch, "This is an AI-generated mock report. Please verify clinically.")
    
    c.save()
    
    pdf_bytes = buffer.getvalue()
    buffer.close()
    
    return Response(content=pdf_bytes, media_type="application/pdf")

@app.get("/report/{file_name}")
async def get_report(file_name: str):
    # Generate mock PDF report for an existing file
    buffer = io.BytesIO()
    c = canvas.Canvas(buffer, pagesize=letter)
    
    # Add title
    c.setFont("Helvetica-Bold", 24)
    c.drawString(1 * inch, 10 * inch, "AI Dental Analysis Report")
    
    # Add content
    c.setFont("Helvetica", 12)
    c.drawString(1 * inch, 9.5 * inch, f"Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    c.drawString(1 * inch, 9 * inch, f"Analyzed File: {file_name}")
    
    # Mock AI results
    c.setFont("Helvetica-Bold", 14)
    c.drawString(1 * inch, 8 * inch, "Findings:")
    c.setFont("Helvetica", 12)
    c.drawString(1 * inch, 7.5 * inch, "1. No significant caries detected.")
    c.drawString(1 * inch, 7.2 * inch, "2. Calculus build-up observed on lower anterior region.")
    c.drawString(1 * inch, 6.9 * inch, "3. Gum recession noted on premolar.")
    
    c.setFont("Helvetica-Bold", 14)
    c.drawString(1 * inch, 6 * inch, "AI Confidence Score: 92%")
    
    c.setFont("Helvetica-Oblique", 10)
    c.drawString(1 * inch, 1 * inch, "This is an AI-generated mock report. Please verify clinically.")
    
    c.save()
    
    pdf_bytes = buffer.getvalue()
    buffer.close()
    
    return Response(content=pdf_bytes, media_type="application/pdf")
