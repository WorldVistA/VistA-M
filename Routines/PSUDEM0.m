PSUDEM0 ;BIR/DAM - Patient Demographics Summary Print Routine ; 20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;
PRINT ;Print header for pt demographics
 Q
 ;
OPV ;EN   Outpatient Visit "No Data" message.  Called only when
 ; user answers 'yes'
 ;to "Do you want to receive this in a MailMan message?" AND when there
 ;is no data to report.
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))
 Q:PSUSMRY        ;Don't print if user wants summary only
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUOPV"))
 ;
 W @IOF
 D DT^DILF("E",PSUSDT,.EXTD)
 S PSURP("START")=EXTD(0)
 D DT^DILF("E",PSUEDT,.EXTD)
 S PSURP("END")=EXTD(0)
 ;
 S PSUOVSUB="PSUOPV_"_PSUJOB
 S ^XTMP(PSUOVSUB,"PSUOPV",PSUSNDR,1)="Outpatient Visits for "_PSURP("START")_" through "_PSURP("END")
 S ^XTMP(PSUOVSUB,"PSUOPV",PSUSNDR,2)=" "
 S ^XTMP(PSUOVSUB,"PSUOPV",PSUSNDR,3)="No data to report"
 ;
 U IO
 ;
 ;F I=1:1:3 W !
 S PSUL=0
 F  S PSUL=$O(^XTMP(PSUOVSUB,"PSUOPV",PSUSNDR,PSUL)) Q:PSUL=""  D
 .S X=^XTMP(PSUOVSUB,"PSUOPV",PSUSNDR,PSUL) W !,X
 .I PSUL=1 W " for ",$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2),!,?72,"PAGE:  1"
 ;
 Q
 ;
PTF ;EN  Inpatient Visit "No Data" message. 
 ;Called only when user answers 'YES'
 ;to "Do you want to receive this in a MailMan message?" AND when there
 ;is no data to report.
 ;
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUFLAG3"))
 Q:PSUSMRY      ;Don't print if user wants summary only
 Q:$D(^XTMP("PSU_"_PSUJOB,"PSUIPV"))
 ;
 W @IOF
 D DT^DILF("E",PSUSDT,.EXTD)
 S PSURP("START")=EXTD(0)
 D DT^DILF("E",PSUEDT,.EXTD)
 S PSURP("END")=EXTD(0)
 ;
 S PSUIVSUB="PSUIPV_"_PSUJOB
 S ^XTMP(PSUIVSUB,"PSUIPV",PSUSNDR,1)="Inpatient PTF Records for "_PSURP("START")_" through "_PSURP("END")
 S ^XTMP(PSUIVSUB,"PSUIPV",PSUSNDR,2)=" "
 S ^XTMP(PSUIVSUB,"PSUIPV",PSUSNDR,3)="No data to report"
 ;
 U IO
 ;
 ;F I=1:1:3 W !
 S PSUL=0
 F  S PSUL=$O(^XTMP(PSUIVSUB,"PSUIPV",PSUSNDR,PSUL)) Q:PSUL=""  D
 .S X=^XTMP(PSUIVSUB,"PSUIPV",PSUSNDR,PSUL) W !,X
 .I PSUL=1 W " for ",$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2),!,?72,"PAGE:  1"
 ;
 Q
 ;
PRO ;EN   Provider information print routine. Prints summary report. 
 ;Called only when user answers 'NO'
 ;to "Do you want to receive this in a MailMan message?" 
 ;
 D DT^DILF("E",PSUSDT,.EXTD)
 S PSURP("START")=EXTD(0)
 D DT^DILF("E",PSUEDT,.EXTD)
 S PSURP("END")=EXTD(0)
 ;
 S PSUPGS("PG")=1
 ;
 S PSUPROSB="PSUPRO_"_PSUJOB
 D PGHDR
 ;
 S N=0,K=3
 F  S N=$O(^XTMP("PSU_"_PSUJOB,"PSUSUM",N)) Q:N=""  D
 .M ^XTMP(PSUPROSB,"PSUPRO",PSUSNDR,K)=^XTMP("PSU_"_PSUJOB,"PSUSUM",N)
 .S K=K+1                      ;Set Provider summary into XTMP global
 ;
 ;
 S PSUL=0
 F  S PSUL=$O(^XTMP(PSUPROSB,"PSUPRO",PSUSNDR,PSUL)) Q:PSUL=""  D
 .I LNCNT+4>IOSL D PGHDR
 .S X=^XTMP(PSUPROSB,"PSUPRO",PSUSNDR,PSUL) W !,X
 .S LNCNT=LNCNT+1
 ;
 K ^XTMP("PSU_"_PSUJOB,"PSUSUM")
 Q
 ;
PGHDR ;Page header for Provider summary message
 ;VMP-IOFO BAY PINES;ELR;PSU*3.0*26 REMOVE FORM FEED
 ;U IO W @IOF
 W "Provider Data for "_PSURP("START")_" through "_PSURP("END")_" for "_$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2)
 W !,?68,"PAGE: "_PSUPGS("PG")
 S PSUPGS("PG")=PSUPGS("PG")+1
 F PSUH=9:1:12 W !,$G(^XTMP(PSUPROSB,"PSUPRO",PSUSNDR,PSUH))
 S LNCNT=5
 Q
 ;
IVSUM ;EN   Print routine for all Pt. Demographics Summary reports.  
 ;Prints NO Data
 ;and Summary report to screen if user answers 'N' to "Do you want a
 ;copy of this message sent to you in mailman?"
 ;
 D INST^PSUDEM1
 D COMM
 U IO
 W @IOF
 ;
 S PSUIVSUB="PSUPD_"_PSUJOB
 S ^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,1)="Patient Demographics Summary for "_PSURP("START")_" through "_PSURP("END")
 S ^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,2)=" "
 ;
 ;Do the following if there is no data to report
 I $D(^XTMP("PSU_"_PSUJOB,"PSUNONE")) D  Q
 .S ^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,3)="No data to report"
 .S PSUL=0
 .F  S PSUL=$O(^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,PSUL)) Q:PSUL=""  D
 ..S X=^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,PSUL) W !,X
 ..I PSUL=2 W " for ",$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2),!,?69,"Page:  1"
 ;
 ;Do the following if there is data to report in a summary
 S N=0,K=3
 F  S N=$O(^XTMP("PSU_"_PSUJOB,"PSUSUMA",N)) Q:N=""  D
 .M ^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,K)=^XTMP("PSU_"_PSUJOB,"PSUSUMA",N)
 .S K=K+1      ;Set Provider summary into XTMP global
 ;
 ;
 S PSUL=0
 F  S PSUL=$O(^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,PSUL)) Q:PSUL=""  D
 .S X=^XTMP(PSUIVSUB,"PSUPD",PSUSNDR,PSUL) W !,X
 .I PSUL=2 W " for ",$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,2),!,?69,"Page:  1"
 ;
 Q
 ;
COMM ;Common variables among all print subroutines
 ;
 D DT^DILF("E",PSUSDT,.EXTD)
 S PSURP("START")=EXTD(0)
 D DT^DILF("E",PSUEDT,.EXTD)
 S PSURP("END")=EXTD(0)
 ;
 Q
