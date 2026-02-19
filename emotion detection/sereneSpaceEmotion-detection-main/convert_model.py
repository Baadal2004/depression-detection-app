import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout, Flatten, Conv2D, MaxPooling2D
import os

# Get the directory of the script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Rebuild the same model architecture as in app.py
print("Building model architecture...")
model = Sequential([
    Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)),
    Conv2D(64, kernel_size=(3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.25),
    Conv2D(128, kernel_size=(3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Conv2D(128, kernel_size=(3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.25),
    Flatten(),      
    Dense(1024, activation='relu'),
    Dropout(0.5),
    Dense(7, activation='softmax')
])

# Load the trained weights
print("Loading trained weights...")
model.load_weights(os.path.join(script_dir, 'model.h5'))

# Convert to TensorFlow Lite format
print("Converting to TensorFlow Lite...")
converter = tf.lite.TFLiteConverter.from_keras_model(model)

# Optimize for mobile
converter.optimizations = [tf.lite.Optimize.DEFAULT]

# Convert
tflite_model = converter.convert()

# Save the TFLite model
output_path = os.path.join(script_dir, 'model.tflite')
with open(output_path, 'wb') as f:
    f.write(tflite_model)

print(f"Model converted successfully!")
print(f"Saved to: {output_path}")
print(f"Model size: {len(tflite_model) / 1024 / 1024:.2f} MB")
