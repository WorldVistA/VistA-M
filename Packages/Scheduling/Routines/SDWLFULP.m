SDWLFULP ;;IOFO BAY PINES/TEH - EWL REPORT - REPORT VERSION 2;06/12/2002 ; 20 Aug 2002 2:10 PM
 ;;5.3;scheduling;**525**;AUG 13 1993;Build 47
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 Q
EN ;ENTRY POINT
 D HD
 I '$D(^XTMP("SDWLFULSTAT",$J,3)) W !,"You need to run OPTION 3 before a report can be produced." Q
 S DHD="EWL ENROLLEE STATUS CLEAN-UP REPORT"
 S DIC=409.39 D EN1^DIP
 S ^XTMP("SDWLFULSTAT",$J,4)=""
END K DIC,DHD Q
HD ;
 W:$D(IOF) @IOF W !,?80-$L("EWL Enrollee Clean-up Report")\2,"EWL Enrollee Clean-up Report",!
 Q
