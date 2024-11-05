import streamlit as st

# Set the page title and layout - this must be the first Streamlit command
st.set_page_config(page_title="Customer Insights Dashboard", layout="wide")

from app import run  # Import the function for the Customer Segmentations app
from reseller_churn_app import app2  # Import the reseller churn prediction app

# Set the sidebar title for navigation
st.sidebar.title("Navigation")

# Select app section
page = st.sidebar.selectbox("Select a Page", ["Customer Recommendations", "Customer Segmentations", "Reseller Churn"])

# Run the selected app with added visuals and interactivity
if page == "Customer Recommendations":
    recommendations_app()
elif page == "Customer Segmentations":
    run()
else:
    app2()


