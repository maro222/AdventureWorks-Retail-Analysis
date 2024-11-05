import streamlit as st
import pandas as pd
import pickle

# Load the trained model
with open('streamlit_APP/reseller_churn_model.pkl', 'rb') as f:
    churn_model = pickle.load(f)

# Load the reseller data DataFrame (for prediction)
df_reseller = pd.read_csv('streamlit_APP/Final_data.csv')

def predict_reseller_churn(reseller_id):
    # Convert reseller_id to integer
    try:
        reseller_id = int(reseller_id)
    except ValueError:
        return "Invalid Reseller ID. Please enter a valid integer."

    # Fetch reseller data based on ID
    reseller = df_reseller[df_reseller['ResellerKey'] == reseller_id]

    # Check if the reseller exists
    if reseller.empty:
        return "Reseller ID not found."

    # Extract features for prediction row
    features = reseller[['ResellerKey','DaysSinceLastPurchase', 'Frequency', 'Monetary']].values

    # Predict the churn status (0 = Not churn, 1 = Churn)
    try:
        churn_prediction = churn_model.predict(features)
    except Exception as e:
        return f"Error during prediction: {str(e)}"

    return f"Reseller {reseller_id} is {'likely to churn' if churn_prediction[0] == 1 else 'not likely to churn'}."



# Function for the reseller churn prediction app
def app2():
    st.title("Reseller Churn Prediction")
    
    # Input field for reseller ID
    reseller_id = st.text_input("Enter Reseller ID", "")
    
    if st.button("Predict Churn"):
        result = predict_reseller_churn(reseller_id)
        st.write(result)

