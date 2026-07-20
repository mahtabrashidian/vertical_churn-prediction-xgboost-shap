import xgboost as xgb
import shap
import pandas as pd
import matplotlib.pyplot as plt

# 1. Load model and data
model = xgb.XGBClassifier()
model.load_model("model.json")
data = pd.read_csv('data/sample_data.csv')
X = data.drop('churn', axis=1)

# 2. Explain with SHAP
explainer = shap.Explainer(model, X)
shap_values = explainer(X)

# 3. Plot
shap.summary_plot(shap_values, X, show=False)
plt.savefig("shap_summary.png")
print("SHAP plot saved as shap_summary.png")
