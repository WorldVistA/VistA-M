PSUV5 ;BIR/PDW - Pharmacy Benefits Mgt IV Printer Output ;10 JUL 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;DBIA(s)
 ; Reference to file #40.8 supported by DBIA 2438
 ;
EN ;EP entry for IV statistical output
 NEW PSUI,PSUH,PSUL,PSUM,PSUPGS,ENDIT
 D DT^DILF("E",PSUSDT,.EXTD)
 S PSURP("START")=EXTD(0)
 D DT^DILF("E",PSUEDT,.EXTD)
 S PSURP("END")=EXTD(0)
 ;I '$D(^XTMP(PSUIVSUB,"STATSUM")) D NOSUM
 S PSUFACN=""
 F  S PSUFACN=$O(^XTMP(PSUIVSUB,"STATSUM",PSUFACN)) Q:PSUFACN=""  D
 .;D PRTSUM  ;Eliminate this report with Phase II 7-19-04
 .I PSUSMRY Q  ;Quit if user requests the summary report only
 .D PRTDRUG
 ;
 I '$D(^XTMP("PSU_"_PSUJOB,"CBAMIS")) D PRTAMIS  ;Print IV AMIS summary
 ;
 D PULL^PSUCP
 F I=1:1:$L(PSUOPTS,",") S PSUMOD($P(PSUOPTS,",",I))=""
 ;
 I $D(PSUMOD(1))&'$D(PSUMOD(2)) D
 .I '$D(PSUMOD(4)) D
 ..D IVSUM^PSUDEM0
 ;
 Q
PRTSUM ;Print the statistical summary report
 U IO
 ;VMP-IOFO BAY PINES;ELR;PSU*3.0*26 REMOVED FORM FEED
 ;W @IOF
 D GETNAME
 S X=^XTMP(PSUIVSUB,"STATSUM",PSUFACN,1)
 W !,X_" for "_PSUDIVNM
 W !!,?68,"Page: 1"  ;Statistical summary will always be 1 page only
 S PSUL=1
 F  S PSUL=$O(^XTMP(PSUIVSUB,"STATSUM",PSUFACN,PSUL)) Q:PSUL=""  D
 .W !,^XTMP(PSUIVSUB,"STATSUM",PSUFACN,PSUL)
 ;
 Q
 ;
PRTAMIS ;Print the IV AMIS Summary report
 ;
 S PSUPGS("PG")=1
 D PGHDR1
 S PSUL=3
 F  S PSUL=$O(^XTMP("PSU_"_PSUJOB,"IVAMIS",PSUL)) Q:PSUL=""  D
 .I LNCNT+4>IOSL D PGHDR1
 .W !,^XTMP("PSU_"_PSUJOB,"IVAMIS",PSUL)
 .S LNCNT=LNCNT+1
 ;
 Q
 ;
PRTDRUG ;Print the Statistical Drug Report
 I '$D(^XTMP(PSUIVSUB,"DRUGSUM")) D NODRUG
 S PSUPGS("PG")=1
 D PGHDR
 S PSUL=5
 F  S PSUL=$O(^XTMP(PSUIVSUB,"DRUGSUM",PSUFACN,PSUL)) Q:PSUL=""  D
 .I LNCNT+4>IOSL D PGHDR
 .W !,^XTMP(PSUIVSUB,"DRUGSUM",PSUFACN,PSUL)
 .S LNCNT=LNCNT+1
 ;
 Q
PGHDR ;
 U IO W @IOF
 W !,^XTMP(PSUIVSUB,"DRUGSUM",PSUFACN,1)
 W " for ",PSUDIVNM
 W !!,?68,"Page: ",PSUPGS("PG")
 S PSUPGS("PG")=PSUPGS("PG")+1
 F PSUH=2:1:5 W !,$G(^XTMP(PSUIVSUB,"DRUGSUM",PSUFACN,PSUH))
 S LNCNT=5
 Q
PGHDR1 ;Print headings for statistical report
 U IO
 W @IOF
 W !,^XTMP("PSU_"_PSUJOB,"IVAMIS",1)
 W !!,?68,"Page: ",PSUPGS("PG")
 S PSUPGS("PG")=PSUPGS("PG")+1
 W !,$G(^XTMP("PSU_"_PSUJOB,"IVAMIS",2))
 S LNCNT=3
 Q
NOSUM ;Set up no data to report global if there is no statistical data
 S ^XTMP(PSUIVSUB,"STATSUM",PSUSNDR,1)="IV Statistical Data Summary for "_PSURP("START")_" through "_PSURP("END")
 S ^XTMP(PSUIVSUB,"STATSUM",PSUSNDR,2)=""
 S ^XTMP(PSUIVSUB,"STATSUM",PSUSNDR,3)="No data to report"
 S PSUFACN=PSUSNDR
 Q
NODRUG ;Set up the no data to report temp global if there is no drug data
 S ^XTMP(PSUIVSUB,"DRUGSUM",PSUSNDR,1)="IV Statistical Data for "_PSURP("START")_" through "_PSURP("END")
 S ^XTMP(PSUIVSUB,"DRUGSUM",PSUSNDR,2)=""
 S ^XTMP(PSUIVSUB,"DRUGSUM",PSUSNDR,3)="No data to report"
 S PSUFACN=PSUSNDR
GETNAME ;Get the facility name
 S X=PSUFACN,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 Q
