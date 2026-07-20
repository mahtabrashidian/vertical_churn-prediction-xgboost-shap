import pandas as pd
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# 1. Load data
data = pd.read_csv('data/sample_data.csv')

# 2. Preprocess (Assume 'churn' is the target column)
X = data.drop('churn', axis=1)
y = data['churn']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 3. Train Model
model = xgb.XGBClassifier(use_label_encoder=False, eval_metric='logloss')
model.fit(X_train, y_train)

# 4. Evaluate
preds = model.predict(X_test)
print(f"Accuracy: {accuracy_score(y_test, preds)}")

# 5. Save model
model.save_model("model.json")
