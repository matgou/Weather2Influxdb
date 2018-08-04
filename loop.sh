#!/bin/sh

while $( true )
do
    tmp=/tmp/data.json
    curl "http://api.openweathermap.org/data/2.5/weather?id=$OWM_CITY_ID&APPID=$OWM_API_ID" > $tmp
    city=$( cat $tmp | jq .name | sed 's/"//g')
    temp=$( cat $tmp | jq .main.temp )
    pressure=$( cat $tmp | jq .main.pressure )
    humidity=$( cat $tmp | jq .main.humidity )
    temp_min=$( cat $tmp | jq .main.temp_min )
    temp_max=$( cat $tmp | jq .main.temp_max ) 
    echo "********************************************************************"
    echo " Ville : $city"
    echo " temperature: $temp"
    echo " humidity: $humidity"
    echo " temp_min: $temp_min"
    echo " temp_max: $temp_max"
    echo ""

    curl -k -i -XPOST "$INFLUX_URL/write?db=$INFLUX_DATABASE&u=$INFLUX_USER&p=$INFLUX_PASSWORD" --data-binary "weather,station=$city temperature_K=$temp,humidity=$humidity,temp_min=$temp_min,temp_max=$temp_max"

    
    sleep 60
done
