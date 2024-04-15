c = get_config()

c.ServerProxy.servers = {
    "code": {
        "command": ["code-server", "--bind-addr=0.0.0.0:{port}", "--auth=none", "."]
    }
}
