PSB388P ;ALBANY/BJR-Add Menu ;May 2016
 ;;3.0;BAR CODE MED ADMIN;**88**;Mar 2004;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;References to ^XPDMENU supported by DBIA #1157
 Q
 ;
 ;Post-init routine to add new option to primary menu
 ;
 ;
ADDMENU ;Add option to main menu
 N PSBOM,PSBMN,PSBOPT,PSBCHK
 S PSBOM="" F PSBOM=1:1 S PSBMN=$P($TEXT(MENULST+PSBOM),";;",2),PSBOPT=$P($TEXT(OPTLIST+PSBOM),";;",2) Q:PSBMN="$$END"!(PSBOM="")  D
 .S PSBCHK=$$ADD^XPDMENU(PSBMN,PSBOPT,11)
 I PSBCHK D BMES^XPDUTL("The PSB DRUG IEN CHECK option has been added to the PSB PHARMACY menu.")
 I 'PSBCHK D BMES^XPDUTL("The PSB DRUG IEN CHECK option could not be added to the PSB PHARMACY menu.")
 Q
 ;
OPTLIST ;Options list
 ;;PSB DRUG IEN CHECK
 ;;$$END
 ;
MENULST ;Menu List
 ;;PSB PHARMACY
 ;;$$END
 ;
