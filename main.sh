#!/bin/bash

main_menu=("Build Your Own Pizza" "Specialty Pizzas" "Sides" "Drinks" "Desserts" "*Cart*")
specialty_pizzas=("Meatlovers" "Hawaiian" "Deluxe" "BBQ Chicken" "Buffalo Chicken" "*Home*" "*Cart*")
crusts=(Original Thin "Deep Dish")
size=(Small Medium Large)
pizza_size_prices=(8.99 10.99 12.99) #S M L
sp_pizza_prices=(11.99 14.99 17.99) #S M L 
sauce=(Original Alfredo Ranch)
toppings=(1.Pepperoni 2.Sausage 3.Pineapple 4.Chicken 5.Steak 6.Hamburger 7.Olives) #$1 each
sides=("Hot Wings" "Mild Wings" "Breadsticks")
sides_prices=(5.99 5.99 2.99)
desserts=("Cinnamon Bread" "Chocolate Chip Cookies" "Chocolate Cake") #$6.99 each
dessert_prices=(6.99)
drinks=(Coke "Diet Coke" Sprite "Diet Sprite" "Dr. Pepper" "Desani Water" Lemonade) 
drink_price=(1.50)


sides_order () {
clear
figlet -c JAM Pizza
echo "Please choose your sides: " 
select item in "Hot Wings" "Mild Wings" "Breadsticks"
do
case $item in 
${sides[0]})
side=${sides[0]} #rename their selection to 'sides' 
sides_price=${sides_prices[0]}
break
;;
${sides[1]})
side=${sides[1]}
sides_price=${sides_prices[1]}
break
;;
${sides[2]})
side=${sides[2]}
sides_price=${sides_prices[2]}
break
;;

esac
done

echo $side
echo $sides_price
}


desserts_order () {
clear
figlet -c JAM Pizza
echo "Please choose your desserts. Only \$6.99 each. " 
select item in "Cinnamon Bread" "Chocolate Chip Cookies" "Chocolate Cake"
do
case $item in 
${desserts[0]})
dessert=${desserts[0]} #rename their selection to 'desserts' 
dessert_prices=${dessert_prices[0]}
break
;;
${desserts[1]})
dessert=${desserts[1]}
dessert_prices=${dessert_prices[0]}
break
;;
${desserts[2]})
dessert=${desserts[2]}
dessert_prices=${dessert_prices[0]}
break
;;

esac
done

}


drinks_order () {
clear
figlet -c JAM Pizza
echo "Please choose your drink (20 oz.). " 
select item in Coke "Diet Coke" Sprite "Diet Sprite" "Dr. Pepper" "Desani Water" Lemonade
do
case $item in 
${drinks[0]})
drink=${drinks[0]} 
drink_price="1.50"
break
;;
${drinks[1]})
drink=${drinks[1]} 
drink_price="1.50"
break
;;
${drinks[2]})
drink=${drinks[2]} 
drink_price="1.50"
break
;;
${drinks[3]})
drink=${drinks[3]} 
drink_price="1.50"
break
;;
${drinks[4]})
drink=${drinks[4]} 
drink_price="1.50"
break
;;
${drinks[5]})
drink=${drinks[5]} 
drink_price="1.50"
break
;;
${drinks[6]})
drink=${drinks[6]} 
drink_price="1.50"
break
;;
esac
done

}


#needs work
cart_total () {
total=$((total+$1))
}


size_order () {
clear
figlet -c JAM Pizza
echo "Please choose your size: " 
select item in Small Medium Large
do
case $item in 
${size[0]})
size=${size[0]} #rename their selection to 'size' 
size_price=${pizza_size_prices[0]}
echo $size
echo $size_price
break
;;
${size[1]})
size=${size[1]}
size_price=${pizza_size_prices[1]}
echo $size
echo $size_price

break
;;
${size[2]})
size=${size[2]}
size_price=${pizza_size_prices[2]}
break
;;

esac
done

#return choice and send to crusts function
echo "You chose a $size pizza."
echo
echo "Please make your crust selection next."
sleep 2
crusts_order

}

crusts_order () {
clear
figlet -c JAM Pizza
echo "Please make your selection from our menu below!" 
select item in Original Thin "Deep Dish"
do
case $item in 
${crusts[0]})
crust=${crusts[0]}
;;
${crusts[1]})
crust=${crusts[1]}
;;
${crusts[2]})
crust=${crusts[2]}
;;

esac
done

#return choice and send to sauce
echo "You chose a $crust crust."
echo
echo "Please make your sauce selection next."
sleep 2
sauce_order

}

sauce_order () {
clear
figlet -c JAM Pizza
echo "Please make your selection from our menu below!" 
select item in Original Alfredo Ranch
do
case $item in 
${sauce[0]})
sauce=${sauce[0]}
break
;;
${sauce[1]})
sauce=${sauce[1]}
break
;;
${crusts[2]})
sauce=${sauce[2]}
break
;;

esac
done

#return choice and send to toppings
echo "You chose $sauce sauce."
echo
echo "Please choose your toppings next."
sleep 2
toppings_order

}

toppings_order () {
clear
figlet -c JAM Pizza

echo "Toppings are only \$1 each!"
echo
echo "${toppings[@]}" #display all topping choices
echo
read -p "Please enter your first topping selection from the numbered menu: " toppings_choice 
echo
#reassigns customer choice to "topping" 
topping="${toppings[toppings_choice-1]}"
topping="${topping:2}" ; echo $topping >> toppingslog.txt #strips away item # and outputs topping order to log
echo "You entered "$topping"." 
while true; do
    #echo ${toppings[@]} #display all topping choices
    echo
    printf "Your current toppings order is \n$(cat toppingslog.txt)\n"
    echo
    toppings_order=$(cat toppingslog.txt | wc -l) 
    printf "Your current toppings total is \$ $toppings_order."
    echo
    read -p "Would you like to add more toppings? Y/N? " yn
    echo
    case $yn in
        [Yy]* ) read -p "Please choose another toppings item: " toppings_choice2 
        echo
        topping="${toppings[toppings_choice2-1]}"
        topping="${topping:2}" ; echo $topping >> toppingslog.txt
        echo "You entered "$topping"." 
        echo
        ;;
        [Nn]* ) 
        cart_total $toppings_order #cart function to add to running order total
        echo "The current cart total is $ $total."
        exit;;
        * ) echo "Please answer yes or no.";;
    esac
    done
    
}


main_menu () {
clear
figlet -c Main Menu
echo "Please make your selection from our menu below!" 
select item in "Build Your Own Pizza" "Specialty Pizzas" "Sides" "Drinks" "Desserts" "Main Menu" "*Cart*"
do
case $item in 
${main_menu[0]})
build_pizza #call a separate function for each of these based on the customer selection
;;
${main_menu[1]})
specialty_pizzas
;;
${main_menu[2]})
sides_order  
;;
${main_menu[3]})
drinks_order  
;;
${main_menu[4]})
desserts_order  
;;
${main_menu[5]})
main_menu
;;
${main_menu[6]})
shopping_cart 
;;

esac
done

}


build_pizza () {
clear
figlet -c Build Your Pizza Menu
echo "Please make your size and crust selections: " 
size_order #call size menu

}

specialty_pizza_order () {

clear
figlet -c "JAM's Specialty Pizza Menu"
echo "Please choose your Specialty Pizza from our menu below!" 
select item in "Meatlovers" "Hawaiian" "Deluxe" "BBQ Chicken" "Buffalo Chicken" "*Home*" "*Cart*"
do
case $item in 
${specialty_pizzas[0]})
pizza=${specialty_pizzas[0]} #assigns their choice to 'pizza' to make it easy to reference later
break
;;
${specialty_pizzas[1]})
pizza=${specialty_pizzas[1]}
break
;;
${specialty_pizzas[2]})
pizza=${specialty_pizzas[2]}
break  
;;
${specialty_pizzas[3]})
pizza=${specialty_pizzas[0]}
break  
;;
${specialty_pizzas[4]})
pizza=${specialty_pizzas[0]}
break  
;;
${specialty_pizzas[5]})
main_menu #call main menu function
;;
${specialty_pizzas[6]})
#cart function here
;;
esac
done

#may need a separate size menu just for the sp. pizzas. 

}


########################## Start Main Order Section #############################

clear
figlet -c JAM Pizza


read -p "Welcome to JAM Pizza. Where the cheesy pizza is made!"
echo
read -p "What is your name?" name
echo
read -p ""$name", Is this order for 1.) Delivery or 2.) Carryout?" order_type
echo 

if [ "$order_type" = "1" ]
then

#The following is a good Y/N loop template we can use in different sections. 
while true; do
    echo    
    read -p "Please enter your street address for delivery. " street
    echo
    read -p "Please enter your city, state, and zip code. " city
    echo
    read -p "You entered $street $city. Is this correct? Y/N " answer
    case $answer in
        [Yy]* )
        break
        ;;
        [Nn]* )
        ;;
        * ) echo "Please answer yes or no."
        clear
        ;;
    esac
done
else
echo
fi

#call main_menu function
main_menu



