import smtplib

def test_smtp_connection():
    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)  # Ganti dengan host email Anda
        server.starttls()
        server.login('rayhandiffaa@gmail.com', 'sbca ikig ullx fmkr')  # Ganti dengan email dan password Anda
        server.sendmail('rayhandiffaa@gmail.com', 'rayskygarden@gmail.com', 'Subject: Test\n\nThis is a test email.')
        server.quit()
        print("Email sent successfully")
    except Exception as e:
        print(f"Failed to send email: {e}")

test_smtp_connection()
