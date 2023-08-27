#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT atomic_number, symbol, type, atomic_mass, name, melting_point_celsius, boiling_point_celsius FROM properties LEFT JOIN elements USING (atomic_number) LEFT JOIN types USING(type_id) WHERE name LIKE '$1%' ORDER BY atomic_number LIMIT 1;")
  else
    ELEMENT=$($PSQL "SELECT atomic_number, symbol, type, atomic_mass, name, melting_point_celsius, boiling_point_celsius FROM properties LEFT JOIN elements USING (atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1;")
  fi

  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT" | while read ATOMIC_NUMBER BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR NAME BAR MELTING_POINT BAR BOILING_POINT
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
else
  echo "Please provide an element as an argument."
fi
