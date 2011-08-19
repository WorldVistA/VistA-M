PSUCP1 ;BIR/TJH,PDW - PBM - CONTROL POINT, MANUAL ENTRY ; 1/10/11 8:08am
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**15,18**;MARCH, 2005;Build 7
 ;
 ;DBIA's
 ; Reference to file #4   supported by DBIA 10090
 ; Reference to file #4.3 supported by DBIA 10091
 ; 
EN ; start here
 D PSUHDR ; display option explanation
 S PSUERR=0
 S X=$$VALI^PSUTL(4.3,1,217),PSUSNDR=+$$VAL^PSUTL(4,X,99)
ASK ; ask type of report desired
 S DIR("?",1)="If this is the monthly report that will be sent to the PBM section"
 S DIR("?",2)="for inclusion into the master file, answer with a 'Y' for YES."
 S DIR("?",3)="If this is not the monthly report or you want to specify a date range"
 S DIR("?")="then enter 'N' for NO."
 S DIR("A")="Is this the monthly report",DIR(0)="YO"
 D ^DIR K DIR W !
 G ERR:(Y="^")!(Y="")!($D(DTOUT))
 K DTOUT
 S PSUAM=Y,ERC=0
DATES ; do this if user entered N, wants date range
 I 'PSUAM D
 .K PSUMNTH
 .S %DT(0)=2880000,%DT="AEPX",%DT("A")="Select Start Date: "
 .D ^%DT K %DT W !
 .I +Y'>0 S ERC=1 Q  ; condition 1, exit.
 .S PSUSDT=+Y
 .S %DT(0)=2880000,%DT="AEPX",%DT("A")="  Select End Date: "
 .D ^%DT K %DT W !
 .I +Y'>0 S ERC=1 Q  ; condition 1, exit.
 .S PSUEDT=+Y
 .I PSUEDT'>PSUSDT D  Q
 ..W !!,"The end date of the search must be greater than the start date.",!
 ..K PSUSDT,PSUEDT
 ..S ERC=2 ; condition 2, ask dates again
 .I PSUSDT>DT!(PSUEDT>DT) D  Q
 ..W !!,"Searches cannot be executed for future dates.",!
 ..K PSUSDT,PSUEDT
 ..S ERC=2 ; condition 2, ask dates again
 .;PSU*4*18 Warn if range > 93 days.
 .N X1,X2,X,% S X1=PSUEDT,X2=PSUSDT D ^%DTC I X>93 D  Q
 ..W !!,"WARNING you have chosen a range greater than 93 days."
 ..W !,"This could potentially create a very large amount of data."
 ..W !,"This may result in system problems."
 ..W !!,"Are you sure you want to continue"
 ..D YN^DICN W ! I %'=1 S ERC=2
 I ERC=1 G ERR
 I ERC=2 S ERC=0 G DATES
 ;
PSUMON ; do this if user asked for monthly report
 I PSUAM D
 .S PSUMNTH=1
 .S %DT(0)=2880000,%DT="MAEP",%DT("A")="Select Month/Year: " K DTOUT,X,Y
 .D ^%DT K %DT W !
 .S ERC=$S($D(DTOUT):1,X="^":1,X="^^":3,+Y'>0:1,1:0)
 .Q:ERC  ; check error condition
 .I Y>DT!($E(Y,1,5)=$E(DT,1,5)) D  Q:ERC
 ..W !!,"PBM statistical data can only be compiled for months that have already passed.",!
 ..K Y
 ..S ERC=2 ; condition 2, ask month again
 .I $E(Y,4,5)="00" D  Q:ERC
 ..W !!,"Oops, you forgot to enter a month.  Try again, please."
 ..K Y
 ..S ERC=2
 .S PSUSDT=$E(Y,1,5)_"01",MNUM=$E(Y,4,5)
 .S PSUMTH=$E(Y,1,5)    ;leap year correction
 .S PSULY=$$LEAPYR^PSUCP(PSUMTH)    ;leap year correction
 .S PSUEDT=$E(Y,1,5)_$S(MNUM["02":$S(PSULY:"29",1:"28"),MNUM="04":"30",MNUM="06":"30",MNUM="09":"30",MNUM="11":"30",1:31)   ;leap year correction
 .;S PSUEDT=$E(Y,1,5)_$S(MNUM="02":"29",MNUM="04":"30",MNUM="06":"30",MNUM="09":"30",MNUM="11":"30",1:31)
 ;
 ;
 G ERR:ERC=1,ASK:ERC=3
 I ERC=2 S ERC=0 G PSUMON ; erroneous input, try again
 S ^XTMP("PSU_"_PSUJOB,"PSUMONTH")=$E(PSUSDT,1,5)
 ;
SETDT ; set month name variables
 S X=PSUSDT D DATE S PSUMON1=Y
 S X=PSUEDT D DATE S PSUMON2=Y
 S X=$E(PSUSDT,1,5)_"00" D DATE S PSUMON=$E(PSUSDT,1,5)
 S ^XTMP("PSU_"_PSUJOB,"PSUMONTH")=PSUMON
 K X,X1
 ;
SELF ; include self and PSU PBM mailgroup
 S PSUPBMG=0
 S PSUDUZ=0
 S DIR("A")="Do you want a copy of this report sent to you in a MailMan message"
 S DIR("?")="Please answer with a 'Y' or 'N'."
 S DIR(0)="YO",DIR("B")="NO"
 D ^DIR K DIR,DIRUT,DIROUT,DUOUT,DTOUT W !
 G ERR:Y="",ERR:Y="^",DATES:Y["^^"
 I Y S PSUDUZ=DUZ,^XTMP("PSU_"_PSUJOB,"PSUFLAG1")="",^XTMP("PSU_"_PSUJOB,"PSUFLAG2")="",PSUFLAG1=1,PSUFLAG2=1
 I 'Y S ^XTMP("PSU_"_PSUJOB,"PSUFLAG3")="",PSUFLAG3=1
 I Y S PSUPBMG=1  ;Send copy to PSU PBM mail group
 ;
MASTER ; if monthly, should it be added to master file
 S (PSUMASF,Y)=0
 I PSUAM D
 .S DIR("A")="Send this to the PBM section for addition to the master file"
 .S DIR("?")="Please answer with a 'Y' or 'N'."
 .S DIR(0)="YO",DIR("B")="NO"
 .D ^DIR K DIR,DIRUT,DIROUT,DUOUT,DTOUT W !
 G ERR:Y="",ERR:Y="^",SELF:Y["^^"
 I Y S PSUMASF=1
 ;
MODULE ; display and select module(s)
 D OPTS^PSUCP ; set up PSUA array with option info
 W !!,"Select one or more of the following:",!
 F I=1:1:12 W !,I,".",?5,PSUA(I,"M")
 W !!,"Laboratory data and a Patient Demographic summary report will be automatically"
 W !,"generated if IVs, Unit Dose, or Prescription extracts are chosen."
 W !,"You may select all of the modules by entering 'A' for ALL or by using '1:12'."
 W !!,"The Provider Data report may take an extended amount of time to run."
 W !,"It is recommended that it be run during off peak hours."
MODP ; module selection prompt
 W !!,"Select the code(s) associated with the data requested: "
 R X:DTIME E  G ERR
 I X["^" G ERR:X="^",MASTER:PSUAM,SELF
 I X="" W "  <??>",$C(7) S X="?"
 ;
 ;
 ;I X["7" D  G MODULE
 ;.W !!,"Lab may not be selected directly.  It will be automatically included when"
 ;.W !,"options 1, 2 or 4 are part of the selection."
 S:"Aa"[$E(X) X="1:12"
MODHLP I X["?" D  G MODULE:X["??",MODP
 .W !!,"Enter:  A single code number to print just that report."
 .W !,?8,"A range of code numbers.  Example:  1:3"
 .W !,?8,"Multiple code numbers separated by commas.  Example:  2,4,5"
 .W !,?8,"The letter A to select ALL reports."
 .W !,?8,"A single up-arrow ( ^ ) to exit now without running any reports."
 .W !,?8,"Double up-arrow  ( ^^ ) to go back to a previous prompt.",!
 S X=$TR(X,"-;_><.A","::::::")
 K PSUMOD
 F PII=1:1:$L(X,",") D
 .S X1=$P(X,",",PII)
 .Q:X1=""
 .I X1[":" D  Q
 ..S XBEG=$P(X1,":",1),XEND=$P(X1,":",2)
 ..I (XBEG="")!(XEND="") Q
 ..F PJJ=XBEG:1:XEND S PSUMOD(PJJ)=""
 ..K PJJ,XBEG,XEND
 .S PSUMOD(X1)=""
 S (X,ERC)=0 F  S X=$O(PSUMOD(X)) Q:X=""  I '$D(PSUA(X)) S ERC=1 Q
 I ERC W !!,"<INVALID CHOICE - ",X,", TRY AGAIN>",$C(7) G MODP
 I '$D(PSUMOD) W !!,"No choices were made." S X="?" G MODHLP
 ;
 F PII=1,2,4 I $D(PSUMOD(PII)) S PSUMOD(13)="" ; add Lab if IV,UD or OP
 ;
 W !!,"You have selected: "
 S X="",PSUOPTS="" F  S X=$O(PSUMOD(X)) Q:X=""  W ?20,X," - ",PSUA(X,"M"),! S PSUOPTS=PSUOPTS_X_","
 I $D(PSUMOD(1))!$D(PSUMOD(2))!$D(PSUMOD(4)) D
 . W ?20,"Patient Demographic Summary" W !
 S PSUOPTS=$E(PSUOPTS,1,$L(PSUOPTS)-1) ; remove trailing comma
 ;
 ;Set flag for combined AMIS summary report.
 I (PSUOPTS["1,2,3,4")&(PSUOPTS[6) S ^XTMP("PSU_"_PSUJOB,"CBAMIS")=""
 ;
RPT ; select report type - full report or summary only
 N PSUGO
 D:PSUOPTS'=11&(PSUOPTS'=12)        ; no summary for VITALS/IMMS OR AA**
 . S DIR("A")="Print Summary Only"
 . S DIR("?",1)="Please answer with a 'Y' or 'N'."
 . S DIR("?")="Answer Yes and only the summary report will be generated."
 . S DIR(0)="YO",DIR("B")="NO"
 . D ^DIR K DIR,DIRUT,DIROUT,DUOUT,DTOUT W !
 . ;PSU*4*15
 . I (Y["^") S:Y="^" PSUGO=1 S:Y["^^" PSUGO=2 Q
 . S PSUSMRY=$S(Y:1,1:0)
 G ERR:$G(PSUGO)=1,MODULE:$G(PSUGO)=2
 S:PSUOPTS=11!(PSUOPTS=12) PSUSMRY=0
 ;
 ;
BCKGND ; always run as a background job
 W !!,"This report will automatically run as a background job."
 ; ask time to queue
 S DIR("?",1)="You can start the program now or queue it to start later."
 S DIR("?",2)="Past date/time is not allowed.  Future dates up to 10 days are allowed."
 S DIR("?")="Enter an appropriate date and time or press <Enter> to start now."
 S %DT="RX",X="NOW+10" D ^%DT
 S DIR("A")="REQUESTED TIME TO RUN: ",DIR(0)="DAO^NOW:"_Y_":EFRX"
 S DIR("B")="NOW"
 D ^DIR K DIR W !
 G ERR:(Y="^")!(Y="")!($D(DTOUT))
 K DTOUT
 S PSUDTH=Y
 ;
DEVICE ;
 S PSUIOP="",PSUPOP=1
 I 'PSUDUZ D  G ERR:POP
 . I PSUOPTS=11!(PSUOPTS=12) W !,"HARDCOPIES NOT AVAILABLE FOR THIS OPTION" S POP=1 Q
 .S PSUIO=ION_";"_IOST_";"_IOM_";"_IOSL
 .S %ZIS="N0",%ZIS("B")="",%ZIS("A")="Select 132 column device: "
 .D ^%ZIS K %ZIS
 .I POP!($E(IOST)="C"),$G(PSUFQ) D  I PSUPOP S POP=1 Q
 ..W !!,"You have not selected an appropriate print device."
 ..W !,"Enter 'C' to continue data compilation and send mail messages"
 ..W !,"          but not print any hardcopy."
 ..W !,"Enter '^' to abort this whole option now."
 ..F  R !,"-> ",PSUX:DTIME Q:"C^"[$E(PSUX)  W "  ??"
 ..S PSUPOP=$S(PSUX="C":0,1:1)
 .S PSUIOP=$S('PSUPOP:"",1:ION_";"_IOST_";"_IOM_";"_IOSL) ; save printer parameters
 .D RESETVAR^%ZIS ; restore terminal parameters
EXIT ; exit point for normal finish
 ;
 Q  ; return to calling routine, ^PSUCP
 ;
PSUHDR ;Display header
 W !!,"The Pharmacy Benefits Management (PBM) report will extract"
 W !,"statistics from one or more of the following files:",!
 W !,"1. Pharmacy Patient IV Sub-file       File # 55.01"
 W !,"2. Pharmacy Patient UD Sub-file       File # 55.06"
 W !,"3. AR/WS Stats                        File # 58.5"
 W !,"4. Prescription                       File # 52"
 W !,"5. Procurement                        File # 58.811,# 58.81"
 W !,"6. Controlled Substances              File # 58.81"
 W !,"7. Patient Demographics               File # 2"
 W !,"8. Outpatient Visits                  File # 9000010,# 9000010.07"
 W !,"9. Inpatient PTF Record               File # 45"
 W !,"10. Provider Data                     File # 200,# 7,# 49,# 8932.1"
 W !,"11. Allergy/Adverse Event             File # 120.8,# 120.85"
 W !,"12. Vitals/Immunization Record        File # 120.5,# 9999999.14"
 W !,"13. Laboratory                        File # 60,# 63"
 ;
 W !!,"This data can be collected for ALL of the files listed or for one or"
 W !,"more specific files.  A summary of data or a detailed report by drug"
 W !,"can be delivered to you in a mail message or in a hard copy report.",!!
 Q
 ;
DATE ;Date conversion
 S Y=X X ^DD("DD") S:Y="" Y="Unknown"
 Q
 ;
ERR ; Exit point following erroneous input or ^
 K ERC,MNUM,MOD,PII,PSUA,PSUAM,PSUDUZ,PSUEDT,PSUPBMG,PSUMASF,PSUPBMG,PSUMNTH,PSUMOD
 ;K PSUMON,PSUMON1,PSUMON2,PSUOPTS,PSUSDT,PSUSMRY,X1
 K PSUMON1,PSUMON2,PSUOPTS,PSUSDT,PSUSMRY,X1
 S PSUERR=1
 Q
 ;
