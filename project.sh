#!/bin/bash


# createTable ----------------------------------------------
createTableFun(){

  echo -n "Enter Table name: "
  read Tname;
  touch $Tname
  echo -n "Enter number of cols: "
  read numcol;
  for (( i = 0; i < numcol; i++ )); do
    echo -n "Enter col name: ";
    read colName;
    echo -n "Choose DataType integer as i or string as s: "
    read dataT;
    names[$i]=$colName;
    types[$i]=$dataT;
  done

  # datatype--------------------------
  for (( i = 0; i < numcol; i++ )); do

    if [[ i -eq $numcol-1 ]]; then
      echo  ${types[$i]}>>$Tname;
    else
      echo -n ${types[$i]}:>>$Tname;
    fi

  done
  #-----------------------------------
  for (( i = 0; i < numcol; i++ )); do

    if [[ i -eq $numcol-1 ]]; then
      echo  ${names[$i]}>>$Tname;
    else
      echo -n ${names[$i]}:>>$Tname;
    fi

  done


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
        colOrder=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$column'") print i}}}' $tableName)
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
update(){

  echo -n "Enter Table name: "
  read tableName;

  echo -n "Enter column name you need to update: "
  read colU;
  echo -n "Enter new value: "
  read newValue;
  colUNum=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colU'") print i}}}' $tableName)

  echo -n "Enter column which will help to select value: "
  read colS
  echo -n "Enter its value: "
  read svalue
  colSnum=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colS'") print i}}}' $tableName)

  svalueNum=$(awk -F: 'BEGIN{NF=='$colSnum'}{for(i=1;i<=NF;i++){if($i=="'$svalue'") {print NR; break}}}' $tableName)
  echo $svalueNum;

  awk -v tmp="$colUNum" -F: '{if(NR=='$svalueNum'){$tmp="'$newValue'" }}' $tableName;



}
# select----------------------------------------------------
selectData(){
  echo "Enter Table name: "
  read tableName;
  select dchoice in selectAll selectCol  Exit
  do
    case $dchoice in
      selectAll)
         awk -F: '{if(NR>1)print $0}' $tableName
      ;;
      selectCol)
        echo -n "Enter column name:  "
        read column

        colOrder=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$column'") print i}}}' $tableName)
         awk -v tmp="$colOrder" -F: '{print $tmp}' $tableName;

      ;;
      Exit)
        break 2;
      ;;
    esac
  done

}
# UseDB ----------------------------------------------------
useDB(){

  echo -n "Enter Database name: "
  read name;
  if [[ -d "$name" ]]; then
    cd $name;
  else
    echo "Database not found ..."
    #call menu
    break;
  fi

  PS3='Select DB operation: '
  select Tchoice in createTable deleteData SelectData UpdateData dropTable Exit
  do
    case $Tchoice in

    createTable)
      createTableFun

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
    UpdateData)
      update
    ;;
    #------------------------------------------------------
    dropTable)
      echo -n "Enter Table Name: "
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
    echo -n "Enter Database name: "
    read name
    if [[ -d "$name" ]]; then
      echo "Database Already Exist ..."
    else
      mkdir $name;
      break;
    fi

  ;;
  DropDB)
    echo -n "Enter Database name: "
    read name
    rm  -r $name
    echo "successfuly removed"
  ;;
  RenameDB)
    echo -n "Enter The old name: "
    read oldName
    echo -n "Enter The new name: "
    read newName
    mv $oldName $newName
  ;;

  UseDB)
    useDB
  ;;

  Exit)
    break
  ;;

  *) print $REPLY is not one of the choices.
  ;;
  esac
done
