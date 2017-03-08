#!/bin/bash
my_dir="$(dirname "$0")";
"$my_dir/insertTable.sh";


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
# insert -------------------------------------------------
insertData() {
   awk 'BEGIN{FS=":"; max=0} {if ($1>max) max=$1} END{id=$max+1; print ""id":'$1'" >>"'$2'"}' $2
}
insert(){

  echo "Enter Table name: "
  read tableName
  #echo $PWD
  read -p "Enter your data to insert like this name:age "
  echo $REPLY
  insertData $REPLY $PWD"/"$tableName
}
# delete -------------------------------------------------
delete(){

  echo "Enter Table name: "
  read tableName

  select dchoice in deleteAll deleteRow  Exit
  do
    case $dchoice in
      deleteAll)
        sed -i 'd' $tableName
      ;;
      deleteRow)
        echo -n "Enter column name:  "
        read column
        echo -n "Enter value:  "
        read value
        sed -i "/$value/d" $tableName
      ;;
      Exit)
        break 2;
      ;;
    esac
  done
}
# Update----------------------------------------------------
# select----------------------------------------------------
selectData(){
  echo "Enter Table name: "
  read tableName;
  select dchoice in selectAll selectCol  Exit
  do
    case $dchoice in
      selectAll)
        #awk -F: "{print $0}" $tableName
         awk -F: '{print $0}' $tableName
      ;;
      selectCol)
        echo -n "Enter column name:  "
        read column
        awk  -v "/$value/d" $tableName
      ;;
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
  select Tchoice in createTable insertData deleteData SelectData dropTable Exit
  do
    case $Tchoice in

    createTable)
      createTableFun

    ;;
    #------------------------------------------------------
    insertData)
      insert
    ;;
    #------------------------------------------------------
    deleteData)
      delete
    ;;
    #------------------------------------------------------
    SelectData)
      selectData
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
    *) echo $REPLY is not one of the choices.
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

  *) echo $REPLY is not one of the choices.
  ;;
  esac
done

#in useDb check if not exist
#-------------------------------------------------------------------------------
