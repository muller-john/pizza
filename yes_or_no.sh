#!/bin/bash

while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done



echo "Do you wish to install this program?"
select yn in "Yes" "No"
case $yn in
    Yes ) make install;;
    No ) exit;;
esac



while True:
    selection = input("do you want to continue (y/n)")
    if (selection == 'y' or selection == 'Y'):
        inputinfo()
    elif (selection == 'n' or selection == 'N'):
        break
    else:
        print("wrong answer")