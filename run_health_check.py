import importlib.util, json
spec = importlib.util.spec_from_file_location("mod", "python-backend/main.py")
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
from fastapi.testclient import TestClient
	# temporary health-check script removed
