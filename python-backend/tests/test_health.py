from pathlib import Path
import importlib.util
from fastapi.testclient import TestClient

spec = importlib.util.spec_from_file_location(
    "appmod",
    str(Path(__file__).resolve().parents[1] / "main.py")
)
appmod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(appmod)

def test_health():
    client = TestClient(appmod.app)
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json() == {"status": "ok"}
