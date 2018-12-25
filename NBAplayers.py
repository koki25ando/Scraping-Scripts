from bs4 import BeautifulSoup
from urllib.request import urlopen as uReq
import pandas as pd

url = "https://basketball.realgm.com/nba/players/{}"

data = []

for i in range(1947, 2020):
    link = url.format(i)
    uClient = uReq(link)
    page_html = uClient.read()
    uClient.close()
    soup = BeautifulSoup(page_html, "html.parser")

    table = soup.find('table')
    table_body = table.find('tbody')
    rows = table_body.find_all('tr')

    for row in rows:
        cols = row.find_all('td')
        cols = [ele.text.strip() for ele in cols]
        data.append([ele for ele in cols if ele])

player_df = pd.DataFrame(data)
player_df.columns = ['#', 'Player', 'Pos', 'HT', 'WT', 'Age', 'Current Team', 'YOS', 'Pre-Draft Team', 'Draft Status', 'Nationality']

player_df.to_csv('Players.csv')
