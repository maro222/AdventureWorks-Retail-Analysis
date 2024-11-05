import streamlit as st
import pandas as pd
import pickle

# Load the trained KMeans model
with open('streamlit_APP/Cus_seg_model.pkl', 'rb') as f:
    kmeans = pickle.load(f)

# Load customer data from CSV
df = pd.read_csv('streamlit_APP/customers_Segs.csv')


# Function to segment customer
def segment_customer(customer_id):
    # Convert customer_id to integer
    try:
        customer_id = int(customer_id)
    except ValueError:
        return "Invalid Customer ID. Please enter a valid integer."

    # Fetch customer data based on ID
    customer = df[df['CustomerID'] == customer_id]

    # Check if the customer exists
    if customer.empty:
        return "Customer ID not found."

    # Extract features for prediction row
    features = customer[['Recency', 'Frequency', 'Monetary']].values

    # Predict the segment
    segment = kmeans.predict(features)
    print(segment[0])

    # Segment descriptions
    if segment[0] == 0:
        return f"Customer {customer_id} is in the Occasional Buyers Segment"
    elif segment[0] == 1:
        return f"Customer {customer_id} is in the Loyal Customers Segment"
    else:
        return f"Customer {customer_id} is in the May Churn Segment"
   


# Streamlit App
def run():
    st.title("Customer Segmentation")
    customer_id = st.text_input("Customer ID", "")
    
    if st.button("Get Segment"):
        result = segment_customer(customer_id)
        st.write(result)

    
    if st.button("Get Segment"):
        result = segment_customer(customer_id)
        st.write(result)

