
# Vertical Churn and Outsource Failure Prediction

This repository contains the implementation of a machine learning framework designed to predict vertical outsourcing failures and churn risks in telecommunication networks. Additionally, SHAP (SHapley Additive exPlanations) is utilized to ensure model explainability and transparency.

## Project Overview
This project builds an end-to-end Machine Learning pipeline using **XGBoost** to classify risks, followed by **SHAP** analysis to provide local and global explanations for the predictions.

## Project Structure
```text
vertical_churn-prediction-xgboost-shap/
│
├── data/
│   └── sample_data.csv          # Sample data for testing execution
│
├── src/
│   ├── train.py                 # Script to preprocess data and train the model
│   └── explain.py               # Script to compute SHAP values
│
└── requirements.txt             # Python packages dependencies
