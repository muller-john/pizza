#!/bin/bash
​
​buildPizza()
{
​
clear
figlet -f fire_font-s -c "Build-A-Pizza Menu"
​
sizes=('Personal' 'Medium' 'Large' '*Back to Main Menu*')
prices=(8 10 13) #P M L
crusts=('Original' 'Thin Crust' 'Deep Dish' 'Stuffed Crust')
sauces=(Original Alfredo Ranch BBQ)
​
​
echo "Please choose a size: "
select size in 'Personal' 'Medium' 'Large' '*Back to Main Menu*'
do
case $size in
${sizes[0]})
size=${sizes[0]}
price=${prices[0]}
break
;;
${sizes[1]})
size=${sizes[1]}
price=${prices[1]}
break
;;
${sizes[2]})
size=${sizes[2]}
price=${prices[2]}
break
;;
${sizes[3]})
mainMenu
esac
done
​
​
echo
echo "Pick a crust: "
select crust in 'Original' 'Thin Crust' 'Deep Dish' 'Stuffed Crust'
do
case $crust in
${crusts[0]})
crust=${crusts[0]}
break
;;
${crusts[1]})
crust=${crusts[1]}
break
;;
${crusts[2]})
crust=${crusts[2]}
break
;;
${crusts[3]})
crust=${crusts[3]}
break
esac
done
​
​
echo
echo "Please choose a sauce: "
select sauce in Original Alfredo Ranch BBQ
do
case $sauce in
${sauces[0]})
sauce=${sauces[0]}
break
;;
${sauces[1]})
sauce=${sauces[1]}
break
;;
${sauces[2]})
sauce=${sauces[2]}
break
;;
${sauces[3]})
sauce=${sauces[3]}
break
esac
done
​
​
toppings=(1.Pepperoni 2.Sausage 3.Pineapple 4.Chicken 5.Steak 6.Spinach 7.Olives 8.Onion)
​
cart_total()
{
total=$((total+$1))
}
​
echo
echo "Toppings are only \$1 each!"
echo
echo "${toppings[@]}" #display all topping choices
echo
read -p "Please enter your first topping selection: " toppings_choice
echo
​
topping="${toppings[toppings_choice-1]}" # reassigns customer choice to 'topping'
topping="${topping:2}" ; echo $topping >> toppingslog.tmp #strips away item # and outputs topping order to log
echo "You entered '$topping'."
while true; do
    #echo ${toppings[@]} displays all topping choices
    printf "Your current toppings order is: \n$(cat toppingslog.tmp)\n"
    echo
    toppings_order=$(cat toppingslog.tmp | wc -l)
    printf "Your current toppings total is \$ $toppings_order."
    echo
    read -p "Would you like to add more toppings? Y/N? " yn
    echo
    case $yn in
        [Yy]* ) echo "${toppings[@]}"
        read -p "Please choose another topping: " toppings_choice2
        topping="${toppings[toppings_choice2-1]}"
        topping="${topping:2}" ; echo $topping >> toppingslog.tmp
        echo "You entered '$topping'"
        ;;
        [Nn]* ) printf "Your toppings order is: \n$(cat toppingslog.tmp)\n"
        echo
        cart_total $toppings_order #cart function to add to running order total
        echo
        echo "The current cart total is $ $total."
        echo
        break
        ;;
        * ) echo
        echo "***** PLEASE ENTER Y/N! *****"
        echo
        esac
done
​
​
cat toppingslog.tmp | awk -v RS= '/----/{next}{gsub(/\n/,", ")}7' > inRowToppings.tmp
​
final_pizza="$size $crust $(cat inRowToppings.tmp) pizza with $sauce sauce" ; echo $final_pizza >> order_summary.tmp
​
echo "You ordered a $final_pizza."
pizza_total=$(($price + $total)) ; echo $pizza_total >> order_total.tmp
echo "This pizza total is $ $pizza_total."
rm toppingslog.tmp
# rm pizza_price.tmp
# rm toppings_total.tmp
​
while true; do
read -p "Would you like to order another custom pizza? (Y/N: Enter N for Main Menu): " yn
        case $yn in
        [Yy]* ) buildPizza
        ;;
        [Nn]* ) mainMenu
        ;;
        * ) echo
        echo "Please enter Y/N!"
        echo
        esac
done
}
​
​
​
​
​
specialtyPizzas()
{
​
clear
figlet -f fire_font-s -c "JAM's Specialty Menu"
​
specialty_pizzas=('Meatlovers' 'Hawaiian' 'Deluxe' 'BBQ Chicken' 'Buffalo Chicken' '*Main Menu*' '*Cart*')
sp_sizes=('Personal' 'Medium' 'Large')
sp_prices=('11.99' '14.99' '17.99') #P M L
sp_crusts=('Original' 'Thin Crust' 'Deep Dish' 'Stuffed Crust')
sp_sauces=(Original Alfredo Ranch BBQ)
​
​
echo "Please choose a size: "
select sp_size in 'Personal' 'Medium' 'Large'
do
case $sp_size in
${sp_sizes[0]})
sp_size=${sp_sizes[0]}
sp_price=${sp_prices[0]}
break
;;
${sp_sizes[1]})
sp_size=${sp_sizes[1]}
sp_price=${sp_prices[1]}
break
;;
${sp_sizes[2]})
sp_size=${sp_sizes[2]}
sp_price=${sp_prices[2]}
break
esac
done
​
​
echo "Pick a crust: "
select sp_crust in 'Original' 'Thin Crust' 'Deep Dish' 'Stuffed Crust'
do
case $sp_crust in
${sp_crusts[0]})
sp_crust=${sp_crusts[0]}
break
;;
${sp_crusts[1]})
sp_crust=${sp_crusts[1]}
break
;;
${sp_crusts[2]})
sp_crust=${sp_crusts[2]}
break
;;
${sp_crusts[3]})
sp_crust=${sp_crusts[3]}
break
esac
done
​
​
echo "Please choose a sauce: "
select sp_sauce in Original Alfredo Ranch BBQ
do
case $sp_sauce in
${sp_sauces[0]})
sp_sauce=${sp_sauces[0]}
break
;;
${sp_sauces[1]})
sp_sauce=${sp_sauces[1]}
break
;;
${sp_sauces[2]})
sp_sauce=${sp_sauces[2]}
break
;;
${sp_sauces[3]})
sp_sauce=${sp_sauces[3]}
break
esac
done
​
​
echo
echo "Please make a selection from our specialty menu!"
select sPizza in 'Meatlovers' 'Hawaiian' 'Deluxe' 'BBQ Chicken' 'Buffalo Chicken' '*Main Menu*' '*Cart*'
do
case $sPizza in
${specialty_pizzas[0]})
sPizza=${specialty_pizzas[0]}
break
;;
${specialty_pizzas[1]})
sPizza=${specialty_pizzas[1]}
break
;;
${specialty_pizzas[2]})
sPizza=${specialty_pizzas[2]}
break
;;
${specialty_pizzas[3]})
sPizza=${specialty_pizzas[3]}
break
;;
${specialty_pizzas[4]})
sPizza=${specialty_pizzas[4]}
break
;;
${specialty_pizzas[5]})
main_menu
;;
${specialty_pizzas[6]})
cart
esac
done
​
​
final_sp_pizza="$sp_size $sp_crust $sPizza with $sp_sauce sauce" ; echo $final_sp_pizza >> order_summary.tmp
​
echo "You ordered a $final_sp_pizza."
echo $sp_price >> order_total.tmp
echo "This pizza total is $ $sp_price."
​
while true; do
read -p "Would you like to order another specialty pizza? (Y/N: Enter N for Main Menu): " yn
        case $yn in
        [Yy]* ) specialtyPizzas
        ;;
        [Nn]* ) mainMenu
        ;;
        * ) echo
        echo "Please enter Y/N!"
        echo
        esac
done
}
​
​
​
​
​
sides()
{
    
clear
figlet -f fire_font-s -c "JAM Pizza Sides"
​
sides=('Hot Wings' 'Mild Wings' 'Breadsticks' '*Main Menu*' '*Cart*')
side_prices=(5.99 5.99 2.99)
​
echo "Please choose a side: "
select side in 'Hot Wings' 'Mild Wings' 'Breadsticks' '*Main Menu*' '*Cart*'
do
case $side in
${sides[0]})
side=${sides[0]}
sd_price=${side_prices[0]}
break
;;
${sides[1]})
side=${sides[1]}
sd_price=${side_prices[1]}
break
;;
${sides[2]})
side=${sides[2]}
sd_price=${side_prices[2]}
break
;;
${sides[3]})
mainMenu
;;
${sides[4]})
cart
esac
done
​
​
echo "$side: $ $sd_price"
echo $side >> order_summary.tmp
echo $sd_price >> order_total.tmp
​
while true; do
read -p "Would you like to order another side? (Y/N: Enter N for Main Menu): " yn
        case $yn in
        [Yy]* ) sides
        ;;
        [Nn]* ) mainMenu
        ;;
        * ) echo
        echo "Please enter Y/N!"
        echo
        esac
done
}
​
​
​
​
​
drinks()
{
​
clear
figlet -f fire_font-s -c "JAM Pizza Drink Menu"
​
drinks=(Coke 'Diet Coke' Sprite 'Dr. Pepper' 'Mt. Dew' 'Mug Rootbeer' 'Desani Water' Lemonade '*Main Menu*' '*Cart*')
drink_prices=(1.50)
​
echo "Please select a drink (20 oz.): "
select drink in Coke 'Diet Coke' Sprite 'Dr. Pepper' 'Mt. Dew' 'Mug Rootbeer' 'Desani Water' Lemonade '*Main Menu*' '*Cart*'
do
case $drink in
${drinks[0]})
drink=${drinks[0]}
dr_price=${drink_prices[0]}
break
;;
${drinks[1]})
drink=${drinks[1]}
dr_price=${drink_prices[0]}
break
;;
${drinks[2]})
drink=${drinks[2]}
dr_price=${drink_prices[0]}
break
;;
${drinks[3]})
drink=${drinks[3]}
dr_price=${drink_prices[0]}
break
;;
${drinks[4]})
drink=${drinks[4]}
dr_price=${drink_prices[0]}
break
;;
${drinks[5]})
drink=${drinks[5]}
dr_price=${drink_prices[0]}
break
;;
${drinks[6]})
drink=${drinks[6]}
dr_price=${drink_prices[0]}
break
;;
${drinks[7]})
drink=${drinks[7]}
dr_price=${drink_prices[0]}
break
;;
${drinks[8]})
mainMenu
;;
${drinks[9]})
cart
esac
done
​
echo "$drink: $ $dr_price"
echo $drink >> order_summary.tmp
echo $dr_price >> order_total.tmp
​
while true; do
read -p "Would you like to add another drink? (Y/N: Enter N for Main Menu): " yn
        case $yn in
        [Yy]* ) drinks
        ;;
        [Nn]* ) mainMenu
        ;;
        * ) echo
        echo "Please enter Y/N!"
        echo
        esac
done
}
​
​
​
​
​
desserts()
{
​
clear
figlet -f fire_font-s -c "JAM Pizza Desserts"
​
desserts=('Cinna-Stix' 'Choco-Chip Cookies' 'P.B. Brownies' '*Main Menu*' '*Cart*')
des_prices=(6.99)
​
echo "Please choose a side: "
select dessert in 'Cinna-Stix' 'Choco-Chip Cookies' 'P.B. Brownies' '*Main Menu*' '*Cart*'
do
case $dessert in
${desserts[0]})
dessert=${desserts[0]}
des_price=${des_prices[0]}
break
;;
${desserts[1]})
dessert=${desserts[1]}
des_price=${des_prices[0]}
break
;;
${desserts[2]})
dessert=${desserts[2]}
des_price=${des_prices[0]}
break
;;
${desserts[3]})
mainMenu
;;
${desserts[4]})
cart
esac
done
​
​
echo "$dessert: $ $des_price"
echo $dessert >> order_summary.tmp
echo $des_price >> order_total.tmp
​
while true; do
read -p "Would you like to add another dessert? (Y/N: Enter N for Main Menu): " yn
        case $yn in
        [Yy]* ) desserts
        ;;
        [Nn]* ) mainMenu
        ;;
        * ) echo
        echo "Please enter Y/N!"
        echo
        esac
done
}
​
​
​
 
​
​
cart()
{
​
cat order_total.tmp | awk '{s+=$1} END {print s}' > order_final.tmp #each item cost gets appended to order_total.txt. This awk command sums and saves to order_final.txt
​
printf "Your cart total is $ $(cat order_final.tmp)."
echo
printf "Your cart contains the following: \n$(cat order_summary.tmp)"
echo " "
echo "-------------------------------------------------"
echo " "
​
read -p "Enter 'Y' to check out or 'N' for Main Menu (Y/N): " decision
    if [ "$decision" == "y" ] || [ "$decision" == "Y" ]
    then 
    confirmOrder
    elif [ "$decision" == "n" ] || [ "$decision" == "N" ]
    then mainMenu
    else
        echo "Please enter Y/N!"
    fi
}
​
​
confirmOrder()
{
if [ "$order_type" = "1" ]
then
echo "$f_name $l_name, this will be a delivery order to: "
echo
echo $street
echo $city
checkOut
else
echo "$f_name $l_name, this is a pick-up order."
echo
echo "Your order will be ready in 60 minutes or less!"
echo
checkOut
fi 
}
​
​
checkOut()
{
echo
read -p "$f_name $l_name, please type in your payment card number to complete your $ $(cat order_final.tmp) payment: " entry
echo
echo "Processing..."
echo "-------------------------------------------------"
echo 
sleep 3
clear
echo
echo "       THANK YOU FOR ORDERING FROM"
echo
figlet -f fire_font-s "JAM Pizza!"
$(rm *.tmp)
exit
}
​
​
​
​
​
mainMenu()
{
    
clear
figlet -f fire_font-s -c "Main Menu"
​
main_menu=('Build-A-Pizza' 'Specialty Pizzas' 'Sides' 'Drinks' 'Desserts' '*Cart*')
​
echo "Please make your selection from our menu below!"
select mItem in 'Build-A-Pizza' 'Specialty Pizzas' 'Sides' 'Drinks' 'Desserts' '*Cart*'
do
case $mItem in
${main_menu[0]})
buildPizza
break
;;
${main_menu[1]})
specialtyPizzas
break
;;
${main_menu[2]})
sides
break
;;
${main_menu[3]})
drinks
break
;;
${main_menu[4]})
desserts
break
;;
${main_menu[5]})
cart
esac
done
}
​
​
########################## Welcome Section #############################
​
clear
figlet -f fire_font-s -c JAM Pizza
​
touch order_summary.tmp
touch order_total.tmp
​
address()
{
echo
read -p "Please enter your street address for delivery: " street
read -p "Please enter your city, state, and zip code: " city
echo
while true; do
read -p "You entered $street, $city. Is this correct? (Y/N): " answer
        case $answer in
                [Yy]* )
                mainMenu
                ;;
                [Nn]* ) clear
                address
                ;;
                * ) echo
                echo "Please enter Y/N!"
                echo
        esac
        done
}
​
​
echo
echo "Welcome to JAM Pizza, where the cheesy pizza is made!"
read -p "What is your name? (First Last) " f_name l_name
echo
while true; do
read -p "Hello $f_name $l_name! Is this order for 1.) Delivery or 2.) Carryout? : " order_type
        case $order_type in
        [1]* ) address
        ;;
        [2]* ) mainMenu
        ;;
        * ) echo
        echo "Please enter 1 or 2!"
        echo
        esac
done
​
​
mainMenu