# Stoppen des JupyterLab
JupyterLab stoppt automatisch nach 24 Stunden, aber um die GPU schnellstmöglich zur Nutzung durch Ihre Kommilitonen frei zu machen, stoppen Sie bitte Jupyter unter https://jl.mni.thm.de/hub/home, wenn Sie es nicht mehr brauchen.

# Starten von Hintergrundprozessen z.B. zum Training
Um Hintergrundprozesse, etwa zum Trainieren von KI-Modellen, zu starten, können Sie `screen` nutzen. Dies können Sie mit dem Befehl `screen` starten und dort dann Ihren Hintergrundprozess starten. Mit `Strg` + `A` gefolgt von `D` können Sie `screen` minimieren und später können Sie sich mit `screen -r` wieder verbinden. 

**WICHTIG** Bitte beachten Sie, dass JupyterLab nach 24 Stunden automatisch stoppt, prüfen Sie daher den Status Ihres Prozesses alle 24 Stunden, um das automatische Beenden zu verhindern.

# Nutzung von Streamlit
Streamlit-Programme in `.ipynb` können Sie mit `streamlit-run DATEINAME` ausführen.

# Nutzung von im JupyterLab laufenden HTTP-Diensten
HTTP-Dienste wie z.B. Tensorboard können verwendet werden, indem der Port, auf dem diese laufen, in folgende URL eingefügt wird: `https://jl.mni.thm.de/proxy/PORT`, z.B. wenn Tensorboard auf dem Standardport gestartet wurde: https://jl.mni.thm.de/proxy/6006.

# Deaktivieren dieser Nachricht
Diese Nachricht kann mit dem folgenden Befehl deaktiviert werden:
```bash
echo "DISABLE_WELCOME_MESSAGE=" >> /workspace/.env
```
