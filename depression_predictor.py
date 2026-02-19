"""
Depression Prediction using Random Forest Classifier
=====================================================
This script builds a Random Forest model to predict whether a person
has depression based on mental health survey data, and suggests
personalized recovery methods and potential depression types.
"""

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import StandardScaler
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
import os
import joblib

warnings.filterwarnings("ignore")

# ── paths ────────────────────────────────────────────────────────────────
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_PATH = os.path.join(BASE_DIR, "Mental Health Classification.csv")
MODEL_PATH = os.path.join(BASE_DIR, "depression_model.pkl")
SCALER_PATH = os.path.join(BASE_DIR, "scaler.pkl")

# ═══════════════════════════════════════════════════════════════════════════
#  1.  DATA LOADING & EXPLORATION
# ═══════════════════════════════════════════════════════════════════════════

if not os.path.exists(DATA_PATH):
    print(f"[ERROR] Dataset not found at {DATA_PATH}")
    exit(1)

df = pd.read_csv(DATA_PATH)

# ═══════════════════════════════════════════════════════════════════════════
#  2.  CREATE BINARY TARGET - "Has Depression?"
# ═══════════════════════════════════════════════════════════════════════════

risk_flags = (
    df["Low_Energy"]
    + df["Low_SelfEsteem"]
    + df["Worsening_Depression"]
    + df["Self_Harm"]
)

conditions = pd.DataFrame({
    "high_score": (df["Depression_Score"] >= 7).astype(int),
    "high_risk": (risk_flags >= 2).astype(int),
    "high_nervous": (df["Nervous_Level"] >= 7).astype(int),
    "suicide": (df["Suicide_Attempts"] > 0).astype(int),
})

df["Has_Depression"] = (conditions.sum(axis=1) >= 2).astype(int)

# ═══════════════════════════════════════════════════════════════════════════
#  3.  FEATURE ENGINEERING
# ═══════════════════════════════════════════════════════════════════════════

def engineer_features(data_df):
    new_df = data_df.copy()
    new_df["Risk_Score"] = (
        new_df["Low_Energy"]
        + new_df["Low_SelfEsteem"]
        + new_df["Worsening_Depression"]
        + new_df["Self_Harm"]
    )
    new_df["Sleep_Deficit"] = (new_df["Sleep_Hours"] < 6).astype(int)
    new_df["High_Nervousness"] = (new_df["Nervous_Level"] >= 7).astype(int)
    new_df["Excessive_SocialMedia"] = (new_df["SocialMedia_Hours"] > 6).astype(int)
    new_df["No_Support"] = (new_df["Mental_Health_Support"] == 0).astype(int)
    new_df["SocialMedia_x_Eating"] = new_df["SocialMedia_Hours"] * new_df["SocialMedia_WhileEating"]
    new_df["Nervousness_x_Energy"] = new_df["Nervous_Level"] * new_df["Low_Energy"]
    new_df["Score_x_Nervous"] = new_df["Depression_Score"] * new_df["Nervous_Level"]
    return new_df

df = engineer_features(df)

feature_cols = [
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

X = df[feature_cols]
y = df["Has_Depression"]

# ═══════════════════════════════════════════════════════════════════════════
#  4.  MODEL TRAINING
# ═══════════════════════════════════════════════════════════════════════════

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

rf_model = RandomForestClassifier(n_estimators=500, max_depth=20, random_state=42, n_jobs=-1, class_weight="balanced")
rf_model.fit(X_train_scaled, y_train)

joblib.dump(rf_model, MODEL_PATH)
joblib.dump(scaler, SCALER_PATH)

# ═══════════════════════════════════════════════════════════════════════════
#  5.  ENGLISH MAPPINGS
# ═══════════════════════════════════════════════════════════════════════════

CLI_MAPPINGS = {
    "Gender": {"Male": 1, "Female": 0},
    "Education_Level": {"High School": 0, "Bachelors": 1, "Masters": 2, "PhD": 3},
    "Employment_Status": {"Unemployed": 0, "Part-time": 1, "Full-time": 2, "Student": 3, "Retired": 4},
    "Eating_Frequency": {"Irregularly": 0, "Regularly": 1},
    "SM_While_Eating": {"Never": 0, "Rarely": 1, "Frequently": 2, "Always": 3},
    "Yes_No": {"Yes": 1, "No": 0},
    "Depression_Type": {
        "None / Not Applicable": 0, "Major Depressive Disorder": 0, "Persistent Depressive Disorder": 1, 
        "Bipolar Disorder": 2, "Cyclothymic Disorder": 3, "Postpartum Depression": 4, 
        "Premenstrual Dysphoric Disorder": 5, "Seasonal Affective Disorder": 6, 
        "Atypical Depression": 7, "Psychotic Depression": 8, "Situational Depression": 9, 
        "Melancholic Depression": 10, "Catatonic Depression": 11
    },
    "Symptoms": {
        "None / Not Applicable": 0, "Persistent Sadness": 0, "Loss of Interest": 1, "Changes in Appetite": 2, 
        "Sleep Disturbances": 3, "Fatigue": 4, "Feelings of Worthlessness": 5, 
        "Difficulty Concentrating": 6, "Irritability": 7, "Physical Pain": 8, 
        "Anxiety": 9, "Social Withdrawal": 10, "Hopelessness": 11,
        "Tearfulness": 12, "Guilt": 13, "Restlessness": 14
    },
    "Coping_Methods": {
        "None / Not Applicable": 0, "Exercise": 0, "Music": 1, "Reading": 2, "Writing": 3, 
        "Talking to Friends": 4, "Professional Help": 5, "Meditation": 6, 
        "Hobbies": 7, "Art": 8, "Cooking": 9, "Travel": 10, "Sleeping": 11, 
        "Healthy Eating": 12, "Volunteering": 13
    }
}

# ═══════════════════════════════════════════════════════════════════════════
#  6.  RECOVERY SUGGESTION ENGINE
# ═══════════════════════════════════════════════════════════════════════════

RECOVERY_SUGGESTIONS = {
    "sleep": {
        "condition": lambda row: row.get("Sleep_Hours", 8) < 6,
        "title": "🛌 Improve Sleep Hygiene",
        "tips": ["Aim for 7-9 hours of sleep.", "Maintain a consistent schedule.", "Avoid screens before bed."]
    },
    "energy": {
        "condition": lambda row: row.get("Low_Energy", 0) == 1,
        "title": "⚡ Boost Energy Levels",
        "tips": ["Exercise daily.", "Eat balanced meals.", "Stay hydrated."]
    },
    "self_harm": {
        "condition": lambda row: row.get("Self_Harm", 0) == 1,
        "title": "🆘 SEEK IMMEDIATE SUPPORT",
        "tips": ["Reach out to a professional immediately.", "Contact AASRA (India): 9820466726."]
    },
    "general": {
        "condition": lambda row: True,
        "title": "🌟 General Well-being",
        "tips": ["Spend time outdoors.", "Connect with loved ones."]
    }
}

# ═══════════════════════════════════════════════════════════════════════════
#  7.  INTERACTIVE PREDICTION
# ═══════════════════════════════════════════════════════════════════════════

def get_input(prompt, options=None):
    while True:
        if options:
            valid_opts = list(options.keys())
            print(f"\n{prompt}")
            for i, opt in enumerate(valid_opts, 1):
                print(f"  {i}. {opt}")
            try:
                choice = int(input("Enter choice number: "))
                if 1 <= choice <= len(valid_opts):
                    return options[valid_opts[choice-1]]
            except ValueError:
                pass
            print(f"Invalid input. Please choose a number between 1 and {len(valid_opts)}.")
        else:
            val = input(f"\n{prompt}: ").strip()
            if val: return val
            print("Input cannot be empty.")

def predict_interactive():
    print("=" * 60)
    print("      DEPRESSION PREDICTOR & DIAGNOSIS TOOL")
    print("=" * 60)

    try:
        person_data = {
            "Gender": get_input("Select Gender", CLI_MAPPINGS["Gender"]),
            "Age": int(get_input("Enter Age")),
            "Education_Level": get_input("Select Education Level", CLI_MAPPINGS["Education_Level"]),
            "Employment_Status": get_input("Select Employment Status", CLI_MAPPINGS["Employment_Status"]),
            "Depression_Type": get_input("Select standard Depression Type (best match)", CLI_MAPPINGS["Depression_Type"]),
            "Symptoms": get_input("Select Primary Symptom", CLI_MAPPINGS["Symptoms"]),
            "Low_Energy": get_input("Do you have Low Energy?", CLI_MAPPINGS["Yes_No"]),
            "Low_SelfEsteem": get_input("Do you have Low Self-Esteem?", CLI_MAPPINGS["Yes_No"]),
            "Search_Depression_Online": get_input("Do you search about Depression online?", CLI_MAPPINGS["Yes_No"]),
            "Worsening_Depression": get_input("Is it worsening?", CLI_MAPPINGS["Yes_No"]),
            "Your overeating level": int(get_input("Overeating level (0-12)")),
            "How many times you eat ": get_input("Eating habits", CLI_MAPPINGS["Eating_Frequency"]),
            "SocialMedia_Hours": float(get_input("Hours spent on Social Media per day")),
            "SocialMedia_WhileEating": get_input("Social Media while eating?", CLI_MAPPINGS["SM_While_Eating"]),
            "Sleep_Hours": float(get_input("Average Sleep Hours per night")),
            "Nervous_Level": int(get_input("Frequency of Nervousness (0-10)")),
            "Depression_Score": int(get_input("Current self-assessed Depression Score (0-30)")),
            "Coping_Methods": get_input("Current Coping Method", CLI_MAPPINGS["Coping_Methods"]),
            "Self_Harm": get_input("Do you have thoughts of Self-Harm?", CLI_MAPPINGS["Yes_No"]),
            "Mental_Health_Support": get_input("Do you have access to Mental Health Support?", CLI_MAPPINGS["Yes_No"]),
            "Suicide_Attempts": int(get_input("Number of Previous Suicide Attempts (0-3)"))
        }

        # Prediction
        input_row = engineer_features(pd.DataFrame([person_data]))
        input_scaled = joblib.load(SCALER_PATH).transform(input_row[feature_cols])
        prob = joblib.load(MODEL_PATH).predict_proba(input_scaled)[0][1]

        # Results
        print("\n" + "=" * 60)
        print("          PROFESSIONAL ASSESSMENT RESULT")
        print("=" * 60)
        
        if prob >= 0.5:
            print(f"ASSESSMENT: Signs of Depression Detected ({prob*100:.1f}%)")
            
            # Suggest Type
            type_labels = {v: k for k, v in CLI_MAPPINGS["Depression_Type"].items()}
            suggested_type = type_labels[person_data["Depression_Type"]]
            print(f"POTENTIAL TYPE: {suggested_type}")
            
            print("\nSUGGESTIONS FOR RECOVERY:")
            for s in RECOVERY_SUGGESTIONS.values():
                if s["condition"](person_data):
                    print(f"\n{s['title']}")
                    for tip in s["tips"]:
                        print(f"  - {tip}")
        else:
            print(f"ASSESSMENT: No significant signs detected (Confidence: {(1-prob)*100:.1f}%)")
            print("Keep maintaining a healthy balance in your life!")

        print("\n" + "=" * 60)

    except Exception as e:
        print(f"\n[!] Error: {e}")

if __name__ == "__main__":
    predict_interactive()
