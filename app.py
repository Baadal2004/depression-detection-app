from flask import Flask, render_template, request, jsonify
import pandas as pd
import joblib
import os

app = Flask(__name__)

# --- Paths ---
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "depression_model.pkl")
SCALER_PATH = os.path.join(BASE_DIR, "scaler.pkl")

# --- Load Model and Scaler ---
if not os.path.exists(MODEL_PATH) or not os.path.exists(SCALER_PATH):
    print("[ERROR] Model or Scaler not found. Run depression_predictor.py first.")
    exit(1)

model = joblib.load(MODEL_PATH)
scaler = joblib.load(SCALER_PATH)

# --- Feature Engineering Logic ---
FEATURE_COLS = [
    "Gender", "Age", "Education_Level", "Employment_Status",
    "Depression_Type", "Symptoms", "Low_Energy", "Low_SelfEsteem",
    "Search_Depression_Online", "Worsening_Depression", "Your overeating level",
    "How many times you eat ", "SocialMedia_Hours", "SocialMedia_WhileEating",
    "Sleep_Hours", "Nervous_Level", "Depression_Score", "Coping_Methods",
    "Self_Harm", "Mental_Health_Support", "Suicide_Attempts",
    "Risk_Score", "Sleep_Deficit", "High_Nervousness",
    "Excessive_SocialMedia", "No_Support", "SocialMedia_x_Eating",
    "Nervousness_x_Energy", "Score_x_Nervous",
]

def engineer_features(data_dict):
    full = dict(data_dict)
    full["Risk_Score"] = (
        full.get("Low_Energy", 0)
        + full.get("Low_SelfEsteem", 0)
        + full.get("Worsening_Depression", 0)
        + full.get("Self_Harm", 0)
    )
    full["Sleep_Deficit"] = int(full.get("Sleep_Hours", 8) < 6)
    full["High_Nervousness"] = int(full.get("Nervous_Level", 0) >= 7)
    full["Excessive_SocialMedia"] = int(full.get("SocialMedia_Hours", 0) > 6)
    full["No_Support"] = int(full.get("Mental_Health_Support", 0) == 0)
    full["SocialMedia_x_Eating"] = full.get("SocialMedia_Hours", 0) * full.get("SocialMedia_WhileEating", 0)
    full["Nervousness_x_Energy"] = full.get("Nervous_Level", 0) * full.get("Low_Energy", 0)
    full["Score_x_Nervous"] = full.get("Depression_Score", 0) * full.get("Nervous_Level", 0)
    return full

# --- Recovery Suggestions ---
RECOVERY_SUGGESTIONS = {
    "sleep": {
        "condition": lambda d: d.get("Sleep_Hours", 8) < 6,
        "title": "🛌 Improve Sleep Hygiene",
        "tips": ["Aim for 7-9 hours of sleep.", "Maintain a consistent schedule.", "Avoid screens before bed."]
    },
    "energy": {
        "condition": lambda d: d.get("Low_Energy", 0) == 1,
        "title": "⚡ Boost Energy Levels",
        "tips": ["Exercise daily.", "Eat balanced meals.", "Stay hydrated."]
    },
    "self_harm": {
        "condition": lambda d: d.get("Self_Harm", 0) == 1,
        "title": "🆘 SEEK IMMEDIATE SUPPORT",
        "tips": ["Reach out to a professional immediately.", "Contact AASRA (India): 9820466726."]
    },
    "general": {
        "condition": lambda d: True,
        "title": "🌟 General Well-being",
        "tips": ["Spend time outdoors.", "Connect with loved ones.", "Keep a positive mindset."]
    }
}

DEP_TYPE_MAP = {
    0: "Major Depressive Disorder", 1: "Persistent Depressive Disorder", 2: "Bipolar Disorder",
    3: "Cyclothymic Disorder", 4: "Postpartum Depression", 5: "Premenstrual Dysphoric Disorder",
    6: "Seasonal Affective Disorder", 7: "Atypical Depression", 8: "Psychotic Depression",
    9: "Situational Depression", 10: "Melancholic Depression", 11: "Catatonic Depression"
}

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/predict", methods=["POST"])
def predict():
    try:
        data = request.get_json()
        
        # Build full input with engineered features
        full_data = engineer_features(data)
        
        # Prepare for prediction
        input_df = pd.DataFrame([full_data])
        # Reorder columns to match scaler/model
        input_scaled = scaler.transform(input_df[FEATURE_COLS])
        
        # Prediction
        prob = model.predict_proba(input_scaled)[0][1]
        is_depressed = prob >= 0.5
        
        # Suggestions
        active_suggestions = []
        for s in RECOVERY_SUGGESTIONS.values():
            if s["condition"](full_data):
                # Only include serializable data (not the lambda)
                active_suggestions.append({
                    "title": s["title"],
                    "tips": s["tips"]
                })
        
        # Potential Type
        potential_type = DEP_TYPE_MAP.get(full_data.get("Depression_Type", 0), "None")
        
        return jsonify({
            "success": True,
            "is_depressed": bool(is_depressed),
            "probability": float(prob),
            "potential_type": potential_type if is_depressed else "None",
            "suggestions": active_suggestions
        })
        
    except Exception as e:
        return jsonify({"success": False, "error": str(e)})

if __name__ == "__main__":
    app.run(debug=True, port=5000)
