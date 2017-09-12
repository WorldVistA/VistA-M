IB2P562 ;ALB/BG - SPECIAL INP BILLING MENU OPTION;3/21/16
 ;;2.0;INTEGRATED BILLING;**562**;21-MAR-94;Build 10
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;References to ^XPDMENU supported by DBIA #1157
 Q
 ;
 ;Post-init routine to add menu to Main menu option
 ;
 ;
ADDMENU ;Add option to main menu
 N IBOM,IBMN,IBSYN,IBOPT
 S IBOM="" F IBOM=1:1 S IBMN=$P($TEXT(LIST+IBOM),";;",3),IBOPT=$P($TEXT(LIST+IBOM),";;",2),IBSYN=$P($TEXT(LIST+IBOM),";;",4) Q:IBOM="$$END"!(IBMN="")  D
 . D ADD^XPDMENU(IBMN,IBOPT,IBSYN)
 D BMES^XPDUTL("Option added to Menu")
 Q
 ;
LIST ;Options Info list
 ;;IB MT FIX/DISCH SPECIAL CASES;;IB MEANS TEST MENU;;SPFD
 ;;$$END
 ;
