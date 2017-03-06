#!/bin/bash
PS3='Select your choice number and press Enter: '
select choice in createDB DropDB RenameDB Exit
do
  case $choice in
  createDB)
    echo "Enter Database name: "
    read name
    mkdir $name
        ;;
  DropDB)
    echo "Enter Database name: "
    read name
    rm  -r $name
    echo "successfuly removed"
  ;;
  RenameDB)
    echo "Enter The old name: "
    read oldName
    echo "Enter The new name: "
    read newName
    mv $oldName $newName
  ;;
  Exit)
    break
  ;;

  *) print $REPLY is not one of the choices.
  ;;
  esac
done
#if no use db dont creat tb and option use db
