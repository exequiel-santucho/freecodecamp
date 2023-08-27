#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # get and select available service
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")
  echo -e "\nWelcome to My Salon, how can I help you?"
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done
  read SERVICE_ID_SELECTED

  # if incorrect input
  APPOINTMENT_ID=$($PSQL "SELECT * FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
  if [[ -z $APPOINTMENT_ID ]]
  then
    echo "I could not find that service. What would you like today?"
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done
    read SERVICE_ID_SELECTED
  fi

  # get phone
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  # get customer name and save in database if not registered
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_NAME=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')") 
  fi

  # get service time
  echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # get some customer data
  CUSTOMER_ID=$($PSQL "SELECT customer_id from customers WHERE phone='$CUSTOMER_PHONE';")
  
  # save appointment on database
  SAVE_APPOINTMENT=$($PSQL "INSERT INTO appointments(service_id, customer_id, time) VALUES($SERVICE_ID_SELECTED, '$CUSTOMER_ID', '$SERVICE_TIME');")

  # get selected service
  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")

  # final summary print
  echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."

}

MAIN_MENU
