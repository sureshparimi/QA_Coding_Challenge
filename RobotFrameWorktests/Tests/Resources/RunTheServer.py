import subprocess

def start_flask_server():
    server = subprocess.Popen(["python", "D:\PythonProjects\Tests\Resources\FlaskAPIServer.py"])
    print("The Flask Server is started")
    return server

def stop_flask_server(server):
    server.terminate()
    print("The Flask Server is stopped")
