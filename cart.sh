#may need to change all of these to '.tmp' vs. .txt. Easy to do. 


#keeping cart_total function in case it's called in existing code (toppings, maybe). 

cart_total () {
total=$((total+$1))
}


cart () {

cat side.txt >> order_summary.txt
cat dessert.txt >> order_summary.txt
cat drink.txt >> order_summary.txt



cat sides_price.txt >> order_total.txt 
cat dessert_prices.txt >> order_total.txt
cat drink_price.txt >> order_total.txt


cat order_total.txt | awk '{s+=$1} END {print s}' > order_final.txt #each item cost gets appended to order_total.txt. This awk command sums and saves to order_final.txt

printf "Your cart total is $ $(cat order_final.txt)."
echo
printf "Your cart contains the following: \n$(cat order_summary.txt)"
echo " "
echo "-------------------------------------------------"
echo " "

read -p "Enter 'Y' to check out or 'N' for main menu: Y/N " decision
    if [ "$decision" == "y" ] || [ "$decision" == "Y" ]
    then 
    confirm_order
    elif [ "$decision" == "n" ] || [ "$decision" == "N" ]
    then main_menu
    else
        echo "Wrong selection"
    fi

}


confirm_order () {

if [ "$order_type" = "1" ]
then
echo "$name, this will be a delivery order to: "
echo $street
echo $city
check_out
else
echo "$name, this is a pick-up order."
echo
echo "Your order will be ready in 30 minutes."
echo
check_out
fi 

}


check_out () {
echo
read -p "$name, please type in your credit card to complete your $ $(cat order_final.txt) payment: " entry
echo "Processing..."
echo " "
echo "-------------------------------------------------"
echo " "
sleep 3
echo
echo "Thank you for using JAM Pizza!" #this is just placeholder text
$(rm *.txt)
exit

}




#These go anywhere we need to capture an order item or price. Maybe just put them all in the same log? 

echo $side >> side.txt
echo $sides_price >> sides_price.txt

echo $dessert >> dessert.txt
echo $dessert_prices >> dessert_prices.txt

echo $drink >> drink.txt
echo $drink_price >> drink_price.txt

# echo $size >> size.txt
# echo $size_price >> size_price.txt



