# import packages
from bs4 import BeautifulSoup
from urllib.request import urlopen as uReq

# Setting
my_url = "https://www.imdb.com/search/name?gender=male,female&ref_=nv_tp_cel"
uClient = uReq(my_url)
page_html = uClient.read()
uClient.close()
soup = BeautifulSoup(page_html, "html.parser")

# Grab all data content containers
Containers = soup.findAll("div", {"class" : "lister-item"})

# Count the number of all the containers by using function len()
# len(Containers) = 50
# There are 50 containers in this html page

# Prepare csv file to throw scraped data into
file_name = "imdb_celeblities.csv"
f = open(file_name, "w")
header = "Name, Type, bio_link\n"
f.write(header)

# Data content i would like to scrape from the page
# Name, Actor/Actress, bio_link and img_link


for container in Containers:
    name = container.div.a.img["alt"]
    type = container.find("p", {"class" : "text-muted"}).text.strip().replace(" ", "").replace("\n", "")
    bio_link = container.div.a["href"]
    # img_link = container.div.a.img["src"]

    f.write(name + "," + type + "," + bio_link + "\n")

f.close()
