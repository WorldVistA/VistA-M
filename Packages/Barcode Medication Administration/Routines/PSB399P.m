PSB399P ;ALBANY/BJR-Remove and Mark Menu OOO ;February 24, 2017
 ;;3.0;BAR CODE MED ADMIN;**99**;Mar 2004;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;References to ^XPDMENU supported by DBIA #1157
 Q
 ;
 ;Post-init routine to add new option to primary menu
 ;
 ;
RMVMNU ;Add option to main menu
 N PSBOM,PSBMN,PSBOPT,PSBCHK,PSBOOO
 S PSBOM="" F PSBOM=1:1 S PSBMN=$P($TEXT(MENULST+PSBOM),";;",2),PSBOPT=$P($TEXT(OPTLIST+PSBOM),";;",2) Q:PSBMN="$$END"!(PSBOM="")  D
 .S PSBCHK=$$DELETE^XPDMENU(PSBMN,PSBOPT)
 .D OUT^XPDMENU(PSBOPT,"OUT OF ORDER - NOT SUPPORTED IN BCMA V3")
 I PSBCHK D BMES^XPDUTL("The PSB PRN DOCUMENTING option has been removed from the PSB MGR menu.")
 I 'PSBCHK D BMES^XPDUTL("The PSB PRN DOCUMENTING option could not be removed from the PSB MGR menu.")
 D BMES^XPDUTL("The PSB PRN DOCUMENTING option has been marked Out of Order.")
 Q
 ;
OPTLIST ;Options list
 ;;PSB PRN DOCUMENTING
 ;;$$END
 ;
MENULST ;Menu List
 ;;PSB MGR
 ;;$$END
 ;
