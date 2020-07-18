SD53748P ;MNT/BJR - Add Menu ; May 04, 2020@08:17:35
 ;;5.3;Scheduling;**748**;Aug 13, 1993;Build 10
 ;
 ;References to $$ADD^XPDMENU supported by DBIA #1157
 Q
 ;
 ;Post-init routine to add new option to primary menu
 ;
 ;
ADDMNU ;Add option to main menu
 N SDOM,SDMN,SDOPT,SDCHK
 S SDOM="" F SDOM=1:1 S SDMN=$P($TEXT(MENULST+SDOM),";;",2),SDOPT=$P($TEXT(OPTLIST+SDOM),";;",2) Q:SDMN="$$END"!(SDOM="")  D
 .S SDCHK=$$ADD^XPDMENU(SDMN,SDOPT)
 I SDCHK D BMES^XPDUTL("The SCENI IEMM VISIT CORRECTION option has been added to the SCENI IEMM MAIN MENU.")
 I 'SDCHK D BMES^XPDUTL("The SCENI IEMM VISIT CORRECTION could not be added to the SCENI IEMM MAIN MENU.")
 I 'SDCHK D BMES^XPDUTL("Please open a Service Now ticket for assistance.")
 Q
 ;
OPTLIST ;Options list
 ;;SCENI IEMM VISIT CORRECTION
 ;;$$END
 ;
MENULST ;Menu List
 ;;SCENI IEMM MAIN MENU
 ;;$$END
 ;
