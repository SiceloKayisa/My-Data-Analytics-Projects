
# This first part of the code is used to extract all the Food Lovers Market store URLS from the downloaded html file
# This html file is obtained from downloading the 'store locator' section as html file from the Food Lovers Market 
# This file is then read to return all the food lovers market urls.
# We will use these urls to scrap data for the stores from the web!!!

# So this first section extracts the URLs we will use for scraping

from bs4 import BeautifulSoup
import json
import html

def get_store_url_list(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
        
    soup = BeautifulSoup(content, 'html.parser')
    
    # Initiate a set first to automatically handle duplicates
    unique_urls = set()

    # Extract from the hidden JSON blob you found in DevTools
    hidden_input = soup.find('input', {'id': 'specials_data'})
    if hidden_input:
        raw_json = html.unescape(hidden_input.get('value', '[]'))
        try:
            data = json.loads(raw_json)
            for item in data:
                url = item.get('link')
                # Filter for actual store pages (depth check)
                if url and '/stores/' in url and url.count('/') >= 5:
                    unique_urls.add(url.strip())
        except:
            pass

    # Extract from <a> tags as a backup
    for a in soup.find_all('a', href=True):
        href = a['href']
        if '/stores/' in href and href.count('/') >= 5:
            unique_urls.add(href.split('?')[0].strip())

    # Convert to a final sorted list
    store_url_list = sorted(list(unique_urls))
    
    return store_url_list

# Using the created function to extract URLs
file_path = "Food Lover's Market _ Home.html"

# Setting the list of URLs
all_store_urls = get_store_url_list(file_path)

#--------------------------------------------------------------------------------------------

# Now we have a list of URLs
#  time to scrap the data!!!


# Here we are using all the obtained store URLs to scrap the data stores data and save as json file 
# Out of interest, In this section I extracted Store Name, Address, Contact details
# Later on, we will add certian columns so that the data tells some story about Locations

import requests

def scrape_data(url):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    }

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        
        data = {}

        # 1. Extacting the Store Name
        name_tag = soup.find('h1')
        data['store_name'] = name_tag.get_text(strip=True).replace('\u2019', "'") if name_tag else "N/A"

        # 2. Extracting Address
        addr_label = soup.find(lambda tag: tag.name in ['h3', 'h4'] and "Address" in tag.text)
        data['address'] = addr_label.find_next(['div', 'p']).get_text(separator=", ", strip=True) if addr_label else "N/A"
        
        # 3. Extracting Contact Details
        contact_label = soup.find(lambda tag: tag.name in ['h3', 'h4'] and "Get in touch" in tag.text)
        if contact_label:
            container = contact_label.find_next('div')
            data['phone'] = container.find('a', href=lambda x: x and x.startswith('tel:')).get_text(strip=True) if container.find('a', href=lambda x: x and x.startswith('tel:')) else "N/A"
            data['email'] = container.find('a', href=lambda x: x and x.startswith('mailto:')).get_text(strip=True) if container.find('a', href=lambda x: x and x.startswith('mailto:')) else "N/A"
            fb_link = container.find('a', href=lambda x: x and 'facebook.com' in x)
            data['facebook_url'] = fb_link['href'] if fb_link else "N/A"

        return data

    except Exception as e:
        return {"error": str(e)}

# Execution
# Here we are just viewing the first urls and their scraped data in a json format
for url in all_store_urls[:3]:
    print(json.dumps(scrape_data(url), indent=4))

# ------------------------------------------------------------------------------------------------------------

# This section saves the extracted data to a json file
# Later on I will convert the extracted json data to a dataframe that can be used to create a csv file.


import time

# List to store all scraped results
all_results = []

print(f"Starting scrape for {len(all_store_urls)} stores...")

# 1. Loop through all extracted URLs
for i, url in enumerate(all_store_urls, 1):
    print(f"[{i}/{len(all_store_urls)}] Scraping: {url}")
    
    # Run your function
    result = scrape_data(url)
    
    # This part adds the URL to the result so we know where the data came from. i.e. from which URL
    if "error" not in result:
        result['url'] = url
        
    all_results.append(result)
    
    # 2. Polite Delay
    # Adding a 1-second pause prevents the server from blocking you
    time.sleep(1)

# 3. Save the results to a JSON file
output_filename = "flm_stores_raw_data.json"

with open(output_filename, "w", encoding="utf-8") as f:
    json.dump(all_results, f, indent=4, ensure_ascii=False)

print(f"\nFinished! All data saved to {output_filename}")   

#-------------------------------------------------------------------------------------


# using a  JSON file to create a dataframe
# The newly created dataframe is saved to a csv file.
# This section also contains a lot of Data Modeling and Cleaning


# In a professional setting I would create a package to store these functions to reduce my Python script
# And every time I use a function I will import it from my package


import pandas as pd

import numpy as np

# Load the JSON file we just created
df_raw = pd.read_json("flm_stores_raw_data.json")

# Firstly lets add the country column 
# In the address column, the country is the last object more often
df_raw['country'] = df_raw['address'].str.split(',').str[-1].str.strip()

# The country contains some values that are not countries  
# The food lovers market stores are in South Africa, Namibia and Zimbabwe
# So we will keep cleaning this column.


# clean country column where country value is a degit
is_numeric = pd.to_numeric(df_raw['country'], errors='coerce').notnull()
df_raw.loc[is_numeric, 'country'] = np.nan

# Data cleaning is an iterative process, we will return again to the country column
# Now lets get add the Province
# For Namibia and Zimbabwe, they do not have a province hence column value -> null

# List of valid South African provinces
sa_provinces = [
    "Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal",
    "Limpopo", "Mpumalanga", "Northern Cape",
    "North West", "Western Cape"
]

# Function to extract province
def extract_province(address, country):
    if pd.isna(address) or country != "South Africa":
        return None # if the country is not South Africa...Province value will be null!
    
    for province in sa_provinces:
        if province.lower() in address.lower():
            return province
    
    return None  # if not found

# Apply the created function
df_raw["province"] = df_raw.apply(lambda row: extract_province(row["address"], row["country"]), axis=1)

# Additionally going back to country
# For rows , where province is null but the country value is not null, we can use the URL to extract the country value
# This is specifically for Zimbabwe and Namibia

# Create a fallback logic
# Define a mask for rows where Province is missing but Country needs fixing/filling

mask = (df_raw['province'].isna()) | (df_raw['country'].str.contains(r'\d', na=False))

def extract_country_from_url(url):
    if pd.isna(url):
        return np.nan
    try:
        # Splits the URL and finds the segment immediately after 'stores'
        parts = url.split('/')
        idx = parts.index('stores')
        country_slug = parts[idx + 1]
        # Clean the slug (e.g., 'south-africa' -> 'South Africa')
        return country_slug.replace('-', ' ').title()
    except (ValueError, IndexError):
        return np.nan

# Apply the fallback only to the rows identified in the mask
df_raw.loc[mask, 'country'] = df_raw.loc[mask, 'url'].apply(extract_country_from_url)

# Now the country column contains some provinces
#Check if the 'country' value is actually a province
# If it is in the list, replace it with 'South Africa'
is_a_province = df_raw['country'].isin(sa_provinces)
df_raw.loc[is_a_province, 'country'] = "South Africa"

# Going further lets improve the province column specifically for areas that belong to South Africa
# 1. Identify the rows to fix (Country is 'South Africa' AND Province is NULL)
mask = (df_raw['country'] == 'South Africa') & (df_raw['province'].isna())

def extract_province_from_url(url):
    """
    Looks at the URL and extracts the segment immediately following 'stores'.
    Example input: .../stores/limpopo/food-lovers...
    Example output: 'Limpopo'
    """
    if pd.isna(url) or url == '':
        return np.nan
        
    try:
        parts = str(url).split('/')
        # Find where 'stores' is in the list
        idx = parts.index('stores')
        # The segment after 'stores' is the province slug
        province_slug = parts[idx + 1]
        
        # Clean the slug (replace dashes with spaces and title case)
        # e.g., 'northern-cape' -> 'Northern Cape'
        # e.g., 'kwazulu-natal' -> 'Kwazulu Natal'
        return province_slug.replace('-', ' ').title()
        
    except (ValueError, IndexError):
        # ValueError: 'stores' wasn't in the URL
        # IndexError: 'stores' was the very last part of the URL (no province after it)
        return np.nan

# Apply the extraction function ONLY to the targeted rows
# Note: Use df_raw.loc[mask, 'url'] to make sure you pass the actual URL to the function.
df_raw.loc[mask, 'province'] = df_raw.loc[mask, 'url'].apply(extract_province_from_url)

# Now since Zimbabwe and Namibia are the only countries expected to contain null values in the province column
# We need to check for rows where province is still null but the country is not Zimbabwe or Namibia then update the Country value to south Africa

# Define the excluded countries
excluded_countries = ["Zimbabwe", "Namibia"]

# Create the mask: 
# Condition A: Province is NULL
# Condition B: Country is NOT in the excluded list
mask = (df_raw['province'].isna()) & (~df_raw['country'].isin(excluded_countries))

# Update the country to "South Africa" for these specific rows
df_raw.loc[mask, 'country'] = "South Africa"

# Cleanup: If the country is now South Africa but province is still null, 
# we can re-run the URL extraction one last time to be thorough.
df_raw.loc[mask, 'province'] = df_raw.loc[mask, 'url'].apply(extract_province_from_url)

# The above creates a new problem, we now have have south western district in the province
# But this area belongs to Western Cape 
# let fix this

# Replace 'South Western Districts' with 'Western Cape'
df_raw['province'] = df_raw['province'].replace('South Western Districts', 'Western Cape')


# Extract location...this may be a great option since extracting cities seems more complex
# Split by the space after 'Market' and take the rest of the string
# n=1 ensures we only split at the first occurrence

df_raw['Market_Location'] = df_raw['store_name'].str.split("Food Lover's ", n=1).str[1]
df_raw['location'] = df_raw['Market_Location'].str.replace("Market ","")

# now dropping Market Location column
df_raw = df_raw.drop('Market_Location', axis=1)

# Finally let us add the City column

# Because we will use the address column, wise to clean it
# there seems to be double comma
# We need to only retain one comma


df_raw['address'] = df_raw['address'].str.replace(',,', ',', regex=False)


def extract_city_multicountry(row):
    # Clean the address string
    address = str(row['address']).strip()
    address_lower = address.lower()
    
    # Split by comma and clean whitespace from each part
    parts = [p.strip() for p in address.split(',')]
    num_parts = len(parts)

    # Logic for South Africa (4th from last)
    if address_lower.endswith("south africa") and num_parts >= 4:
        return parts[-4]

    # Logic for Namibia (2nd from last)
    elif address_lower.endswith("namibia") and num_parts >= 2:
        return parts[-2]

    # Default if format doesn't match or country is missing
    return np.nan

# Apply the logic to the dataframe
df_raw['city'] = df_raw.apply(extract_city_multicountry, axis=1)

# Some city values are missed for Namibia specifically Windhoek, lets fix them
# So if the (country is Namibia and the city is null) but "Windhoek" is contained in address update the city value to "Windhoek"


mask1 = (
    (df_raw['country'] == 'Namibia') & 
    (df_raw['city'].isna()) & 
    (df_raw['address'].str.contains('Windhoek', case=False, na=False))
)

# Update the city column for those rows
df_raw.loc[mask1, 'city'] = 'Windhoek'

# Now we left with some South African rows where city was also not captured.
# So if the country is South Africa and the city is Null, use address column and extract 2nd value from last as the city

mask2 = (df_raw['country'] == 'South Africa') & (df_raw['city'].isna())

def fallback_city_extraction(address):
    if pd.isna(address) or address == '':
        return np.nan
        
    # Split the address by comma and clean whitespace
    parts = [p.strip() for p in str(address).split(',')]
    
    # Check if we have at least 2 parts (e.g., "Johannesburg South, 2061")
    if len(parts) >= 2:
        # Return the 2nd value from the last
        return parts[-2]
    
    return np.nan

# Using the fallback only to the rows where city is still missing
df_raw.loc[mask2, 'city'] = df_raw.loc[mask2, 'address'].apply(fallback_city_extraction)

# I can replace 'Johannesburg South' with strictly 'Johannesburg' 
# So I create a code that convert these variations for the future e.g. 'Johannesburg South', 'Johannesburg North' -> Johannesburg etc
# Replace specific variations with a single value
df_raw['city'] = df_raw['city'].replace(['Johannesburg South','Johannesburg North'], 'Johannesburg')

# eMazimtoti is not a city, but a town that belongs to the City Durban
# Not changing this will affect geocoding
df_raw['city'] = df_raw['city'].replace('eManzimtoti', 'Durban')

                                         
# Now that we have assigned cities for Namibia and South Africa
# We need to assign cities for Zimbabwe
mask3 = (df_raw['country'] == 'Zimbabwe') & (df_raw['city'].isna())

def extract_zim_city(address):
    if pd.isna(address) or address == '':
        return np.nan
        
    # Split the address by comma and clean whitespace
    parts = [p.strip() for p in str(address).split(',')]
    
    # Ensure there are at least 3 parts to avoid index errors
    if len(parts) >= 3:
        # Return the 3rd value from the last
        return parts[-3]
    
    return np.nan

# Apply the update only to those Zimbabwe rows
df_raw.loc[mask3, 'city'] = df_raw.loc[mask3, 'address'].apply(extract_zim_city)

# Now lets add the postal code column.
# We will start by extracting for stores in South Africa
def extract_postal_code_final(row):
    address = str(row['address']).strip()
    parts = [p.strip() for p in address.split(',')]
    
    # We only process if Country is South Africa
    if row['country'] == 'South Africa' and len(parts) >= 1:
        
        # Scenario 1: Address ends with "South Africa"
        # Example: "..., Western Cape, 7500, South Africa"
        if address.lower().endswith("south africa"):
            if len(parts) >= 2:
                return parts[-2]
        
        # Scenario 2: Address ends with a Number (Postal Code)
        # Example: "..., Kuils River, Cape Town, 7579"
        elif parts[-1].isdigit():
            return parts[-1]
            
    return np.nan

# Apply the combined logic to create the postal_code column
df_raw['postal_code'] = df_raw.apply(extract_postal_code_final, axis=1)

# Clean the column: Convert to numeric and use Int64 to allow Nulls
df_raw['postal_code'] = pd.to_numeric(df_raw['postal_code'], errors='coerce').astype('Int64')

# Extracting postal code for stores in Namibia is tricky based on the address_line we extracted
# Zimbabwe does not use a Postal code

#--------------------------------------------------------------------


# Creating Latitude and Longitude Values
# These values will play a huge role specifically with maps visuals in Power BI/tableau

from geopy.geocoders import Nominatim
from geopy.extra.rate_limiter import RateLimiter


# Initializing with a higher timeout (10-20 seconds is safer for public servers)
# Using a unique user_agent is required by Nominatim's policy
geolocator = Nominatim(user_agent="flm_recruiter_assessment_project", timeout=10)

# Configure the RateLimiter more conservatively
# We use 2 seconds of delay to avoid '403 Forbidden' or 'Too Many Requests' errors
geocode = RateLimiter(
    geolocator.geocode, 
    min_delay_seconds=2, 
    max_retries=3, 
    error_wait_seconds=5
)

# Create a descriptive search string to help the geocoder
df_raw['full_search_address'] = df_raw['city'] + ", " + df_raw['province'] + ", " + df_raw['country']

# Define a helper function to extract coordinates safely
def get_lat_long(address):
    try:
        location = geocode(address)
        if location:
            return location.latitude, location.longitude
    except Exception as e:
        print(f"Skipping {address} due to error: {e}")
    return np.nan, np.nan

# 5. Apply the geocoding (This will be slow but reliable)
print("Starting geocoding process... please wait (takes ~2 seconds per row)")
df_raw[['latitude', 'longitude']] = df_raw['full_search_address'].apply(
    lambda x: pd.Series(get_lat_long(x))
)

# I used store_id as my 'stable unique identifier'
df_raw['store_id'] = range(1, len(df_raw) + 1)

# Move store_id to the first column 
cols = ['store_id'] + [col for col in df_raw if col != 'store_id']
df_raw = df_raw[cols]

#Rename address to a expected name: address_line
df_raw = df_raw.rename(columns = {'address':'address_line'})

# Putting columnns in a good order, remember our focus is location!!!
# We put IDs and Names first, then the full geographic hierarchy, then contact details

desired_order = [
    'store_id', 
    'store_name', 
    'address_line', 
    'country', 
    'province', 
    'city', 
    'location', 
    'postal_code', 
    'latitude', 
    'longitude',
    'phone', 
    'email', 
    'facebook_url', 
    'url',
    'full_search_address'
]

# Filter to only include columns that actually exist in your dataframe 
existing_cols = [c for c in desired_order if c in df_raw.columns]

# Apply the reorder
df_raw = df_raw[existing_cols]


# Display the result
print(df_raw.head())


# I have retained some columns that are not that important for location purposes but contain some good lead.
# These columns include phone, email, Facebook URL and web URL

#  Save to csv
df_raw.to_csv("stores.csv", index=False)











