#!/bin/bash


buildPizza()
{

clear
figlet -f fire_font-s -c "Build-A-Pizza Menu"

sizes=('Personal' 'Medium' 'Large')
prices=(9 11 13) #P M L
crusts=('Original' 'Thin Crust' 'Deep Dish' 'Stuffed Crust')
sauces=(Original Alfredo Ranch BBQ)


echo "Please choose a size: "
select sp_size in 'Personal' 'Medium' 'Large'
do
case $sp_size in
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
esac
done

# echo $price >> pizza_price.tmp



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



toppings=(1.Pepperoni 2.Sausage 3.Pineapple 4.Chicken 5.Steak 6.Spinach 7.Olives 8.Onion)

cart_total()
{
total=$((total+$1))
}

echo
echo "Toppings are only \$1 each!"
echo
echo "${toppings[@]}" #display all topping choices
echo
read -p "Please enter your first topping selection: " toppings_choice
echo

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

# echo $price
# echo $total


cat toppingslog.tmp | awk -v RS= '/----/{next}{gsub(/\n/,", ")}7' > inRowToppings.tmp

final_pizza="$size $crust $(cat inRowToppings.tmp) pizza with $sauce sauce" ; echo $final_pizza >> final_pizza.tmp
echo "You ordered a $final_pizza."
pizza_total=$(($price + $total)) ; echo $pizza_total >> pizza_price.tmp
echo "This pizza total is $ $pizza_total."
#rm pizza_price.tmp
rm toppingslog.tmp
# rm toppings_total.tmp


while true; do
read -p "Would you like to order another custom pizza? (Y/N): " yn
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
buildPizza