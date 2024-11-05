import streamlit as st
import pandas as pd
import pickle
import matplotlib.pyplot as plt

# Load the trained recommendation model
with open('streamlit_APP/Cus_Rec_model.pkl', 'rb') as f:
    recommendation_model = pickle.load(f)

# Example DataFrame of Customer-Product mapping
df_products = pd.read_csv('streamlit_APP/customers_Reco.csv')

def get_top_recommendations(customer_id, n_recommendations=5):
    try:
        customer_id = int(customer_id)
    except ValueError:
        return "Invalid Customer ID. Please enter a valid integer."
    
    if customer_id not in df_products['CustomerID'].values:
        return "Customer ID not found."

    # Get top N recommendations
    recommendations = []
    for product_id in df_products['ProductID'].unique():
        prediction = recommendation_model.predict(customer_id, product_id)
        recommendations.append((product_id, prediction.est))
    
    recommendations.sort(key=lambda x: x[1], reverse=True)
    top_recommendations = recommendations[:n_recommendations]

    # Create DataFrame for visualization
    recommendation_df = pd.DataFrame(top_recommendations, columns=["ProductID", "Score"])
    return recommendation_df

def recommendations_app():
    st.title("Customer Recommendations")
    st.markdown("### Enter Customer ID to view top product recommendations.")
    
    customer_id = st.text_input("Customer ID")
    n_recommendations = st.slider("Number of Recommendations", 1, 10, 5)
    
    if st.button("Get Recommendations"):
        recommendation_df = get_top_recommendations(customer_id, n_recommendations)
        if isinstance(recommendation_df, pd.DataFrame):
            st.write(recommendation_df)
            
            # Plot recommendations
            fig, ax = plt.subplots()
            ax.bar(recommendation_df["ProductID"], recommendation_df["Score"], color='skyblue')
            ax.set_title("Top Product Recommendations")
            ax.set_xlabel("Product ID")
            ax.set_ylabel("Predicted Score")
            st.pyplot(fig)
        else:
            st.write(recommendation_df)

