PSUUD5 ;BIR/REG - UNIT DOSE PRINTER MODULE ;10 JUL 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;DBIA(s)
 ; Reference to file #40.8 supported by DBIA 2438
 ;
 ;PRINT CYCLE CONTROLLER FOR UNIT DOSE SUMMARY REPORT
 ;
EP ;Print Unit Dose Statistical Report by Drug and Summary Report
 ;Printing Device should be opened by PSUDBQUE by new & IO set
 ;The ^XTMP global contains print lines by drug by division
 ;Lines 1 through 7 are page heading lines for the summary by drug by
 ;division; The Summary Report by division only is only 6 lines
 ;Package variables are set by calling routine prior to call.
 NEW PSUI,PSUH,PSUL,PSUM,PSUPGS,PSUUDFLG
 S PSUUDFLG=1       ;Flag for summary reports
 D DT^DILF("E",PSUSDT,.EXTD)
 S PSURP("START")=EXTD(0)
 D DT^DILF("E",PSUEDT,.EXTD)
 S PSURP("END")=EXTD(0)
 U IO
 ;
PRTSUMS ;
 ; Find first Division/Facility in the summary by division
 ; then DO the PRTALL routine
 S PSUUDSUB="PSUUD_"_PSUJOB
 ;
 I '$D(^XTMP("PSU_"_PSUJOB,"CBAMIS")) D PRTAMIS  ;Print UD AMIS SUMMARY
 ;
 ; Find the first Division/Facility in the summary by drug by division
 ; then DO the PRTDRUG routine
 Q:PSUSMRY  ; 'summary only' was selected don't print 'by drug'
 S PSUFACN=""
 I '$D(^XTMP(PSUUDSUB,"DRUGSUM")) D
 .S ^XTMP("PSU_"_PSUJOB,"PSUNONE1")=""
 .S ^XTMP(PSUUDSUB,"DRUGSUM",PSUSNDR,1)="Unit Dose Statistical Data for "_PSURP("START")_" through "_PSURP("END")
 .S ^XTMP(PSUUDSUB,"DRUGSUM",PSUSNDR,2)=" "
 .S ^XTMP(PSUUDSUB,"DRUGSUM",PSUSNDR,3)="No data to report"
 F  S PSUFACN=$O(^XTMP(PSUUDSUB,"DRUGSUM",PSUFACN)) Q:PSUFACN=""  D PRTDRUG
 ;
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 ;Print routine for Pt. demographics summary/No data when user selects
 ;(1)IV and (2)UD
 I $D(PSUMOD(1))&$D(PSUMOD(2)) D
 .I '$D(PSUMOD(4)) D
 ..D IVSUM^PSUDEM0
 ;
 ;Print routine for Pt. demographics summary/No data when user selects
 ;(2)UD only
 I $D(PSUMOD(2))&'$D(PSUMOD(1)) D
 .I '$D(PSUMOD(4)) D
 ..D IVSUM^PSUDEM0
 ;
PRTSUMX ; EXIT PSUUD5
 ;W @IOF
 Q 
 ;
PRTALL ; Print the Drug summary of all drugs by Division/Facility
 S X=PSUFACN,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 W @IOF
 F I=1:1:3 W !
 S PSUL=""
 F  S PSUL=$O(^XTMP(PSUUDSUB,"STATSUM",PSUFACN,PSUL)) Q:PSUL=""  D
 .S X=^XTMP(PSUUDSUB,"STATSUM",PSUFACN,PSUL) W !,X
 .I PSUL=1 W " for ",PSUDIVNM,!,?72,"PAGE:  1" ; will only ever be one page
 Q
 ;
PRTAMIS ;Print UD AMIS summary
 ;
 S PSUPGS("PG")=0
 D PGHDR1
 S PSUL=3
 F  S PSUL=$O(^XTMP("PSU_"_PSUJOB,"UDAMIS",PSUL)) Q:PSUL=""  D
 .I LNCNT+4>IOSL D PGHDR1   ; leave a margin at the bottom
 .W !,^XTMP("PSU_"_PSUJOB,"UDAMIS",PSUL)
 .S LNCNT=LNCNT+1
 ;
 Q
 ; 
PRTDRUG ; Print the Drug summary by Drug by Division/Facility
 ; Set page number to 0
 S PSUPGS("PG")=0
 S X=PSUFACN,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 D PGHDR ; Perform 1st page heading
 S PSUL=7 ; Report body starts at line 8
 F  S PSUL=$O(^XTMP(PSUUDSUB,"DRUGSUM",PSUFACN,PSUL)) Q:PSUL=""  D
 .I $Y+4>IOSL D PGHDR ; leave a margin at the bottom
 .W !,^XTMP(PSUUDSUB,"DRUGSUM",PSUFACN,PSUL)
 ;
 Q
 ;
PGHDR ;Increment page number and Write Page Heading
 ; Writes header lines 1 & 2, then page number, then lines 3 through 7
 U IO W @IOF
 F I=1:1:3 W !
 W !,^XTMP(PSUUDSUB,"DRUGSUM",PSUFACN,1) ;Print 1st line
 W " for ",PSUDIVNM ; add division name
 S PSUPGS("PG")=PSUPGS("PG")+1
 W !,^XTMP(PSUUDSUB,"DRUGSUM",PSUFACN,2),?72,"PAGE: ",PSUPGS("PG")
 F PSUH=3:1:7 W !,$G(^XTMP(PSUUDSUB,"DRUGSUM",PSUFACN,PSUH))  ;Print next 5 lines  
 Q
 ;
PGHDR1 ;Page headers for AMIS summary report
 ;
 U IO
 W @IOF
 W !,^XTMP("PSU_"_PSUJOB,"UDAMIS",1)
 W !!,?68,"Page: ",PSUPGS("PG")
 S PSUPGS("PG")=PSUPGS("PG")+1
 W !,$G(^XTMP("PSU_"_PSUJOB,"UDAMIS",2))
 S LNCNT=3
 Q
