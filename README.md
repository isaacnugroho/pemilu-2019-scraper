# pemilu-2019-scraper
Simple bash script to scrape data from https://infopemilu.kpu.go.id/


## Requirements

Ensure you have [jq](https://stedolan.github.io/jq/download/ "Download jq") installed

## Running

1.  Create result directories:
    `mkdir -p result/{caleg,dapil,geo,wilayah}`
2.  Run `./scrape=wilayah.sh`
3.  Run `./scrape-dapil.sh`

The data will be stored in result.

Actually I also put the result scraped at March 2, 2019.
