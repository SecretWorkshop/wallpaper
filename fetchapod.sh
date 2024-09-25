# download the html first
wget -r https://apod.nasa.gov/apod/archivepix.html

# then extract the urls
find ./apod.nasa.gov/apod -type f -exec cat {} \; | grep '.jpg' | grep '"image/' | cut -d'"' -f 2 > images-list
find ./apod.nasa.gov/apod -type f -exec cat {} \; | grep '.jpeg' | grep '"image/' | cut -d'"' -f 2 >> images-list
find ./apod.nasa.gov/apod -type f -exec cat {} \; | grep '.png' | grep '"image/' | cut -d'"' -f 2 >> images-list

# add the base url to each line
sed -i -e 's/^/https:\/\/apod.nasa.gov\//' images-list

# then download in parallel
mkdir apodimages
cd apodimages
xargs -n 1 -P 10 wget < ../images-list
