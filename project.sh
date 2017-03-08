#!/bin/bash



# createTable ----------------------------------------------
createTableFun(){

  echo "Enter Table name: "
  read Tname;
  touch $Tname
  echo "Enter number of cols: "
  read numcol;
  for (( i = 0; i < numcol; i++ )); do
    echo "Enter col name: ";
    read colName;
    names[$i]=$colName;
  done
  #----------------------
  for (( i = 0; i < numcol; i++ )); do
    #--- if problem
    if [[ $i == $numcol-1 ]]; then
      echo -n ${names[$i]}>>$Tname;
    else
      echo -n ${names[$i]}:>>$Tname;
    fi

  done

}
# delete -------------------------------------------------
delete(){

  select dchoice in deleteAll deleteRow  Exit
  do
    case $dchoice in
      deleteAll)
        echo "Enter Table name: "
        read tableName
        # echo "delete from $tableName where "
        # read stmt
        sed -i 'd' $tableName
      ;;
      deleteRow);;
      Exit)
        break 2;
      ;;
    esac
  done
}
# UseDB ----------------------------------------------------
useDB(){

  echo "Enter Database name: "
  read name;
  cd $name
  PS3='Select your choice number and press Enter: '
  select Tchoice in createTable deleteRow dropTable Exit
  do
    case $Tchoice in

    createTable)
      createTableFun

    ;;
    #------------------------------------------------------
    deleteRow)
      delete
    ;;
    #------------------------------------------------------
    dropTable)
      echo "Enter Table Name: "
      read name;
      rm -f $name;
    ;;
    Exit)
      break
    ;;
    *) print $REPLY is not one of the choices.
    ;;

    esac
  done

}
#------------------------------------------------------------

PS3='Select your choice number and press Enter: '
select choice in createDB DropDB RenameDB UseDB Exit
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

  UseDB)
    useDB
  ;;
  #---------------------------------------------------------
  Exit)
    break
  ;;

  *) print $REPLY is not one of the choices.
  ;;
  esac
done

#in useDb check if not exist
#-------------------------------------------------------------------------------
