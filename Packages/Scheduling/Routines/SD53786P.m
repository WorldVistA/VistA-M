SD53786P ;MNT/BJR - UUNSCHEDULE EWL BACKGROUND ; Apr 26, 2021@12:47
 ;;5.3;Scheduling;**786**;Aug 13, 1993;Build 3
 ;
 Q
 ;References to RESCH^XUTMOPT supported by DBIA #1472
 ;References to OUT^XPDPROT supported by DBIA #5567
 ;References to BMES^XPDUTL supported by DBIA #10141
 ;
 ;Post-init routine to add new option to primary menu
 ;
 ;
EN ;Entry point for SD*5.3*786 Post Install routine
 D DISOPT
 D UNSCHOPT
 Q
DISOPT ;Disable Options
 N SDOM,SDMN,SDTEXT
 F SDOM=1:1 S SDMN=$P($TEXT(OPTLST+SDOM),";;",2) Q:SDMN="$$END"  D
 .D OUT^XPDMENU(SDMN,"DO NOT USE!! EWL DECOM - SD*5.3*786")
 .S SDTEXT="The "_SDMN_" menu option has been disabled." D BMES^XPDUTL(SDTEXT)
 Q
UNSCHOPT ;Unschedule Option
 N SDOM,SDMN,SDTEXT
 F SDOM=1:1 S SDMN=$P($TEXT(OPTLST+SDOM),";;",2) Q:SDMN="$$END"  D
 .D RESCH^XUTMOPT(SDMN,"@",,"@")
 .S SDTEXT="The "_SDMN_" menu option has been unscheduled." D BMES^XPDUTL(SDTEXT)
 Q
OPTLST ;Options to Disable
 ;;SD EWL BACKGROUND JOB
 ;;$$END
