from batdetect2 import api

AUDIO_FILE = "example_data/audio/20170701_213954-MYOMYS-LR_0_0.5.wav"

# Process a whole file
results = api.process_file(AUDIO_FILE)

# Or, load audio and compute spectrograms
audio = api.load_audio(AUDIO_FILE)
spec = api.generate_spectrogram(audio)

# And process the audio or the spectrogram with the model
detections, features, spec = api.process_audio(audio)
detections, features = api.process_spectrogram(spec)

# Do something else ...