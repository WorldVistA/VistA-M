PSUOP6 ;BIR/REG - PSU PBM Outpatient Pharmacy Printer Output ;10 JUL 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA(s)
 ; Reference to file #59 supported by DBIA 2510
 ;
 ;PRINT CYCLE CONTROLLER FOR OUTPATIENT PHARMACY SUMMARY REPORT
 ;
EP ;
 NEW PSUI,PSUH,PSUL,PSUM,PSUPGS
 D DT^DILF("E",PSUSDT,.EXTD)
 S PSURP("START")=EXTD(0)
 D DT^DILF("E",PSUEDT,.EXTD)
 S PSURP("END")=EXTD(0)
 U IO
 ;
PRTSUMS ;
 ; Find first Division/Facility in the summary by division
 ; then DO the PRTALL routine
 S PSUOPSUB="PSUOP_"_PSUJOB
 I '$D(^XTMP(PSUOPSUB,"STATSUM")) D
 .S ^XTMP("PSU_"_PSUJOB,"PSUNONE2")=""
 .S ^XTMP(PSUOPSUB,"STATSUM",PSUSNDR,1)="Outpatient Statistical Data Summary for "_PSURP("START")_" through "_PSURP("END")
 .S ^XTMP(PSUOPSUB,"STATSUM",PSUSNDR,2)=" "
 .S ^XTMP(PSUOPSUB,"STATSUM",PSUSNDR,3)="No data to report"
 ;
 S PSUFACN=""
 ;VMP-IOFO BAY PINES;ELR;PSU*3.0*26
 NEW PSUFIRST
 F  S PSUFACN=$O(^XTMP(PSUOPSUB,"STATSUM",PSUFACN)) Q:PSUFACN=""  D PRTALL
 ;
 I '$D(^XTMP("PSU_"_PSUJOB,"CBAMIS")) D PRTAMIS  ;Print OPAMIS SUMMARY
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 ;
 ;Call Pt. Demographics summary report/No data when user selects
 ;(1)IV and (2)UD and (4)Rx
 ;(1)IV and (4)Rx
 ;(2)UD and (4)Rx
 I $D(PSUMOD(1))!$D(PSUMOD(2)) D IVSUM^PSUDEM0
 ;
 ;Call Pt. Demographics summary report/No data when user selects
 ;(4)IV alone.
 I '$D(PSUMOD(1))&'$D(PSUMOD(2)) D IVSUM^PSUDEM0
 ;
 ; Find the first Division/Facility in the summary by drug by division
 ; then DO the PRTDRUG routine
 Q:PSUSMRY  ; 'summary only' was selected don't print 'by drug'
 S PSUFACN=""
 I '$D(^XTMP(PSUOPSUB,"DRUGSUM")) D
 .S ^XTMP(PSUOPSUB,"DRUGSUM",PSUSNDR,1)="Outpatient Statistical Data for "_PSURP("START")_" through "_PSURP("END")
 .S ^XTMP(PSUOPSUB,"DRUGSUM",PSUSNDR,2)="                                                                        Page"
 .S ^XTMP(PSUOPSUB,"DRUGSUM",PSUSNDR,3)="No data to report"
 F  S PSUFACN=$O(^XTMP(PSUOPSUB,"DRUGSUM",PSUFACN)) Q:PSUFACN=""  D PRTDRUG
PRTSUMX ; EXIT PSUOP6
 W @IOF
 ;
 Q 
 ;
PRTALL ; Print the Drug summary of all drugs by Division/Facility
 S X=PSUFACN,DIC=59,DIC(0)="XM" D ^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(59,X,.01)
 ;VMP OIFO BAY PINES;ELR;PSU*3.0*31
 I '$L(PSUDIVNM) S X=PSUFACN D DIVNM
 ;VMP-IOFO BAY PINES;ELR;PSU*3.0*26; REMOVE FORM FEED FIRST TIME THROUGH
 I $G(PSUFIRST) W @IOF
 S PSUFIRST=1
 F I=1:1:3 W !
 S PSUL=""
 F  S PSUL=$O(^XTMP(PSUOPSUB,"STATSUM",PSUFACN,PSUL)) Q:PSUL=""  D
 .W !,^XTMP(PSUOPSUB,"STATSUM",PSUFACN,PSUL)
 .I PSUL=1 W " for ",PSUDIVNM,!,?72,"Page: 1" ; will only ever be one page
 Q
 ; 
PRTDRUG ; Print the Drug summary by Drug by Division/Facility
 ; Set page number to 0
 S PSUPGS("PG")=0
 S X=PSUFACN,DIC=59,DIC(0)="XM" D ^DIC
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(59,X,.01)
 ;VMP OIFO BAY PINES;ELR;PSU*3.0*31
 I '$L(PSUDIVNM) S X=PSUFACN D DIVNM
 D PGHDR ; Perform 1st page heading
 S PSUL=6 ; Report body starts at line 7
 F  S PSUL=$O(^XTMP(PSUOPSUB,"DRUGSUM",PSUFACN,PSUL)) Q:PSUL=""  D
 .I $Y+4>IOSL D PGHDR
 .W !,^XTMP(PSUOPSUB,"DRUGSUM",PSUFACN,PSUL)
 ;
 Q
 ;
PRTAMIS ;Print Amis summary report
 ;
 U IO W @IOF
 S PSUPGS("PG")=1
 D PGHDR1
 S PSUL=3
 F  S PSUL=$O(^XTMP("PSU_"_PSUJOB,"OPAMIS",PSUL)) Q:PSUL=""  D
 .I LNCNT+4>IOSL D PGHDR1
 .W !,^XTMP("PSU_"_PSUJOB,"OPAMIS",PSUL)
 .S LNCNT=LNCNT+1
 Q
 ;
PGHDR1 ;AMIS HEADER
 U IO W @IOF
 F I=1:1:3 W !
 F I=1:1:2 W ^XTMP("PSU_"_PSUJOB,"OPAMIS",I)
 W !!,?68,"Page: ",PSUPGS("PG")
 S PSUPGS("PG")=PSUPGS("PG")+1
 S LNCNT=3
 Q
 ;
PGHDR ;Increment page number and Write Page Heading
 ; Writes header lines 1 & 2, then page number, then lines 3 through 6
 U IO W @IOF
 F I=1:1:3 W !
 W !,^XTMP(PSUOPSUB,"DRUGSUM",PSUFACN,1) ;Print 1st line
 W " for ",PSUDIVNM ; add division name
 S PSUPGS("PG")=PSUPGS("PG")+1
 W !,$P(^XTMP(PSUOPSUB,"DRUGSUM",PSUFACN,2),":",1),": ",PSUPGS("PG"),! ;Print page number
 F PSUH=3:1:6 W !,$G(^XTMP(PSUOPSUB,"DRUGSUM",PSUFACN,PSUH)) ;Print next 5 lines  
 Q
 ;
DIVNM ;S PSUDIVNM FROM FILE 40.8 IF NOT IN FILE 59
 S DIC=40.8,DIC(0)="X",D="C" D IX^DIC
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 Q
