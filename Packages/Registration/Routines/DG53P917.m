DG53P917 ;ALB/BG - Menu Option Restore; 6/7/04 7:13pm ; 8/13/15 10:42am
 ;;5.3;Registration;**917**;Aug 13,1993;Build 10
 ;
 ;References to ^XPDMENU supported by DBIA #1157
 Q
 ;
 ;Post-init routine to restore menu option from "out of order"
 ;
 ;
OPTOUT ;Remove option from out-of-order
 N DGMCN,DGOPT,DGTXT
 S DGTXT=""
 F DGMCN=1:1 S DGOPT=$P($TEXT(OPTLIST+DGMCN),";;",2) Q:DGOPT="$$END"!(DGOPT="")  D
 . D OUT^XPDMENU(DGOPT,DGTXT) ;remove out of order
 D BMES^XPDUTL("Option Updated.")
 D ADDMENU
 Q
 ;
ADDMENU ;Add option to main menu
 N DGOM,DGMN,DGORD
 S DGOM="" F DGOM=1:1 S DGMN=$P($TEXT(MENULST+DGOM),";;",2),DGOPT=$P($TEXT(OPTLIST+DGOM),";;",2) Q:DGOM="$$END"!(DGMN="")  D
 . D ADD^XPDMENU(DGMN,DGOPT)
 D BMES^XPDUTL("Option added to Menu")
 Q
 ;
OPTLIST ;Options list
 ;;DG PTF SUFFIX EFF DATE EDIT
 ;;$$END
 ;
MENULST ;Menu List
 ;;DGPT TOOLS MENU
 ;;$$END
 ;
