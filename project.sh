#!/bin/bash
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
  ##################### UseDB ############################
  UseDB)
    echo "Enter Database name: "
    read name;
    cd $name
    PS3='Select your choice number and press Enter: '
    select Tchoice in createTable deleteRow dropTable Exit
    do
      case $Tchoice in
      #################createTable##########################
      createTable)
        #createTable;
        echo "Enter Table name: "
        read Tname;
        touch $Tname
        echo "Enter number of cols: "
        read numcol;
        for (( i = 0; i < numcol; i++ )); do
          echo "Enter col name: ";
          read colName;
          names[i]=colName;
        done
        #----------------------
        for (( i = 0; i < numcol; i++ )); do
          echo names[i]:>>Tname;
        done
      ;;
      #------------------------------------------------------
      deleteRow)
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
# createTable(){
#
#
#
# }
