PSJMDIR ;BIR/MV-MED DUE WORKSHEET DIR CALLS ;25 AUG 94 / 11:08 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
MEDTYPE(PSGMARWD) ;*** Ask for Med choices
 ;PSGMARWD will be defined if the user was selected by ward.
 ;If PSJMPRN is defined, that mean this module is calling from the MDWS.
 ;
 K DIR S DIR(0)="LAO^1:6^I X[1&($L(X)>1) K X" S DIR("A")="Enter medication type(s): "
 S DIR("?",1)="1.  All medications",DIR("?",2)="2.  Non-IV medications only",DIR("?",3)="3.  IVPB (Includes IV syringe orders with a med route of IV or IVPB."
 S DIR("?",4)="          All other IV syringe orders are included with non-IV medications).",DIR("?",5)="4.  LVPs",DIR("?",6)="5.  TPNs",DIR("?",7)="6.  Chemotherapy medications (IV)",DIR("?",8)=""
 N XTYPE S:$G(PSGMARWD) XTYPE=$P($G(^PS(59.6,+$O(^PS(59.6,"B",+PSGMARWD,0)),0)),"^",2) S DIR("B")=$S($G(XTYPE):XTYPE,1:2)
 S DIR("?")="e.g.  Enter 1 or 2-4,5 or 2."
 S DIR("?",9)="A combination of choices can be entered here except for option 1."
 W !! D ^DIR
 Q $$STOP
 ;
STDATE() ;*** Ask for starting date and time
 ;
 K DIR S DIR(0)="DO^::EXAR",DIR("A")="Enter Start Date and Time",DIR("?")="Date and time must be entered." W !! D ^DIR
 Q $$STOP
 ;
ENDATE(PSGTMP,PSGTMP1) ;*** Ask for eding date and time
 ;
 K DIR S DIR(0)="DAO^"_PSGTMP_":"_PSGTMP1_":EXAR",DIR("A")="Enter Ending Date and Time: "
 S DIR("?")="Time must be entered.",DIR("?",1)="The worksheet will list only medications due for a 24 hour",DIR("?",2)="period.  Please keep ending date and time within that range."
 W !! D ^DIR
 Q $$STOP
 ;
PRN() ;
 ;
 K DIR S DIR(0)="YO",DIR("A")="Would you like to include PRN Medications (Y/N)",DIR("B")="NO"
 S DIR("?")="Answer ""YES"" to include PRN orders in the Medication Due Worksheet.  (The PRN medications will print after the Continuous medications.)"
 W !! D ^DIR
 Q $$STOP
 ;
ADMTM ;*** Askif user want to sort by admin team
 ;
 S (PSGTM,PSGTMALL)=0
 K DIR S DIR(0)="YO",DIR("A")="Do you want to sort by Administration Team (Y/N)",DIR("B")="NO"
 S DIR("?",1)="Enter ""Y"" for ""YES"" if you wish to sort by Administration",DIR("?",2)="team. Enter ""N"" for ""NO"" if you do not wish to sort by",DIR("?",3)="Administration Team."
 S DIR("?",4)="",DIR("?",5)="If you choose to sort by Adminstration Team, you",DIR("?")="may choose which teams will be included in the report."
 W !! D ^DIR Q:$$STOP!'+Y
 ;
 ;*** Because "ALL" is not a team, must use DIR to include "ALL"
 ;    default and then call DIC to look up the selected team
 ;
 F  Q:$$STOP!(X="")!$G(PSGTMALL)  D ADMTM2
 S PSGTM=$S($O(PSGTM(0))'="":1,1:0)
 Q
ADMTM2 ;
 K DIR S DIR(0)="FAO",DIR("A")="Select Administration Team: ",DIR("B")="ALL",DIR("?")="^D DICTM^PSJMDIR" W ! D ^DIR Q:$$STOP  I Y="ALL" S PSGTMALL=1 Q
 D DICTM
 S PSJSTOP=$S($D(DTOUT):1,$D(DUOUT):1,(Y<0)&'$D(PFLG):1,1:0)
 Q
 ;
DICTM ;*** LooK up a team.
 ;
 K DIC S DIC="^PS(57.7,"_PSGWD_",1,",DIC(0)="QEMIZ"
 F PFLG=0:1 D ^DIC Q:Y<0  I PFLG S DIC(0)=DIC(0)_"A",DIC("A")="Select another Administration Team: " S PSGTM(Y(0,0))=+Y
 Q
 ;
RBADM ;*** Sort by PATIENT, ROOM-BED or ADMIN TIME
 ;
 K DIR S DIR(0)="SAO^A:Administration Time;R:Room-Bed;P:Patient",DIR("A")="Do you wish to sort by Administration Time (A), Room-Bed (R), Patient (P): ",DIR("B")="A"
 S DIR("?",1)="Enter an ""A"" if you want orders to display in order of Administration Time.",DIR("?",2)="Enter a ""R"" if you want orders to display in order of patient room-bed."
 S DIR("?")="Enter a ""P"" if you want orders to display in order of patient name."
 W ! D ^DIR Q:$$STOP  S PSGRBADM=Y
 Q
 ;
RBPPN ;*** Sort by ROOM-BED or PATIENT(when selected by WARD).
 ;
 K DIR S DIR(0)="SAO^R:Room-Bed;P:PATIENT",DIR("A")="Do you wish to sort by Room-Bed (R), Patient (P): ",DIR("B")="R"
 S DIR("?",1)="Enter an ""R"" if you want orders to display in order of patient room-bed.",DIR("?")="Enter a ""P"" if you want orders to display in order of patient name."
 W ! D ^DIR Q:$$STOP  S PSGRBPPN=Y
 Q
 ;
STOP() ;
 ;
 S PSJSTOP=$S($D(DTOUT):1,$D(DUOUT):1,$D(DIRUT):1,1:0)
 Q PSJSTOP
