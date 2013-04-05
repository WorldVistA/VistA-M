PRCHJRP1 ;BP/VAC - REPORT ON RETURNED/CANCELED eCMS TRANSACTIONS ;11/13/12  18:56
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-038, This routine should not be modified.
 ;This routine is called from PRCHUSER PPM and PRCSER
 ;This report prompts for selection criteria:
 ;    Date Range; Station; Sub-Station, Control Point; Transaction    ;      Type; Specific eCMS user; Specific 2237
 ;NOTE: Specific eCMS user removed because of DBA insistance.
 ;Parameters
 ;    Date Range from any day to today
 ;    Single station or all stations in UCI
 ;       Substations within a single station, including NONE
 ;    Single Control Point or All control points
 ;    Transaction type: Returned to Accountable officer; Returned to
 ;        Control Point; Cancelled;
 ;    Specific eCMS user or all
 ;    Single 2237
 ;Output values
 ;  Date Received, Date sent, 2237 #, Type,
 ;     sub-station, eCMS user name, phone number and email, Reason 
 ;     Description
 Q
START ;Entry point for generating report.
 N HDATE,P,IDATE,SDATE,STAT,CONT,TYPE,CT,D,EM,I,K,L,M,NM,NT,NTL,OKAY
 N OUT,PH,PRCHJCT,PRCHJDAT,PRCHJEM,PRCHJNM,PRCHJPH,PRCHJRS,PRCHJSS
 N PRCHJTR,PRCHJTY,PRCHJST,SS,ST,STOP,LL,N,TY,W,X,X1,X2,XXZ,J,Y,Y2,Z
 N NT2,FCP,STAT,TYPE,NOK,SUB,STAT,SSTAT,DISP,NOSUB,ANAME,NUM,YY,ZZ
 N IJDATE,SJDATE,N2237,UNAME,ACC,DSENT,ERR,TREF,VAL,XREF,XTYPE,ACC
 N ACC2,COUNT,QD,Y2,PRCFIRST,POP
 ;This section NEWs variables for PRCHJRP2
 N A,B,C,D,DAT,ODAT,OK,TDATE,Q,LL1,MNAME,TMP1,TMP2,ANS2
 K XQORNOD D OP^XQCHK
 D NOW^%DTC S Y=$P(%,".") D DD^%DT S HDATE=Y
 S P=0,LL1=$J
 K ^XTMP("PRCHJRP1",$J)
 I $D(^PRCV(414.06))<1 W !,!,!,"There is no data for this program to report on." HANG 3 Q
ACCES ;DETERMINE IF USER IS ACCOUNTABLE OFFICER OR WHAT CONTROL POINTS
 ;THIS USER CAN ACCESS.
 K ACC
 S ACC(0)=0,X=$$GET1^DIQ(200,DUZ_",",400,"I")
 I $P(XQOPT,"^",1)="PRCHJ TRANS REPORT" S ACC(0)=1 ;AO
 I $P(XQOPT,"^",1)="PRCHJ TRANS REPORT2" S ACC(0)=2
 I (X'=2)&(ACC(0)=1) W !,"Access to this report is restricted to the Accountable Officer" HANG 3 G QT
 I (X=2)&(ACC(0)=1) D
 .S X=0,ACC(0)=1
 .F I=1:1 S X=$O(^PRC(420,X)) Q:+X=0  D
 ..S Y=0
 ..F J=1:1 S Y=$O(^PRC(420,X,1,Y)) Q:+Y=0  D
 ...S Y2=Y
 ...I $L(Y)=1 S Y2="00"_Y
 ...I $L(Y)=2 S Y2="0"_Y
 ...S ACC(X,Y2)=1,X2(X)=1
 I ACC(0)=2 D
 .S X=0
 .F I=1:1 S X=$O(^PRC(420,X)) Q:+X=0  D
 ..S Y=0
 ..F J=1:1 S Y=$O(^PRC(420,X,1,Y)) Q:+Y=0  D
 ...Q:$P($G(^PRC(420,X,1,Y,0)),"^",11)'="Y"
 ...S Z=$G(^PRC(420,X,1,Y,1,DUZ,0))
 ...Q:Z=""
 ...Q:$P(Z,U,2)'=1&($P(Z,U,2)'=2)
 ...S Y2=Y
 ...I $L(Y)=1 S Y2="00"_Y
 ...I $L(Y)=2 S Y2="0"_Y
 ...S ACC(X,0)=1,ACC(X,Y2)=1,X2(X)=1
DATE ;PROMPT FOR INPUT DATA
 W @IOF
 W !,?10,"REPORT ON TRANSACTION ACTIVITY BETWEEN eCMS AND IFCAP",!,!
 S %DT="E",PRCFIRST=$P($O(^PRCV(414.06,"AED","")),".")
 I PRCFIRST="" W !,!,"There are no records in the Transaction File to report on." HANG 3 Q
DATEA W !,"Enter the starting date. ALL DATES// " R IDATE:DTIME G:'$T QT
 I IDATE["?" D HELP^PRCHJRP2(1)  G DATEA
 I IDATE="^" G QT
 I IDATE="" S IDATE="ALL" W IDATE G STAT
 S X=IDATE X ^%ZOSF("UPPERCASE") S IDATE=Y
 I IDATE="A"!(IDATE="AL") D WRT(IDATE) S IDATE="ALL" G STAT
 S X=IDATE
 D ^%DT
 I Y=-1 W !,"Invalid date" G DATEA
 S IJDATE=Y ;CONVERT TO FILEMAN DATE
 K %DT S X="T" D ^%DT
 I IJDATE>Y W !,"Cannot have future date" HANG 3 G DATE
 I IJDATE<PRCFIRST W !,"Cannot have a beginning date prior to ",$P($$FMTE^XLFDT(PRCFIRST,2),"@",1),! G DATEA
DATE2 K %DT(0) S %DT="E" W !,"Enter the ending date. Today// " R SDATE:DTIME G:'$T QT
 I SDATE["?" D HELP^PRCHJRP2(2) G DATE2
 I SDATE="^" G QT
 I (SDATE="") S SDATE="T"
 S %DT="E"
 S X=SDATE D ^%DT
 I Y=-1 W !,"Invalid date" G DATE2
 S SJDATE=Y ; CONVERT TO FILEMAN DATE
 K %DT S X="T" D ^%DT
 I SJDATE>Y W !,"Cannot have future date" HANG 3 G DATE2
 ;Check for valid dates
 I IJDATE>SJDATE W !,"Date range is incorrect." HANG 2 G START
 K %DT
 ;
STAT ;Enter station number
STAT2 W !,"Enter the Station number. ALL// " R STAT:DTIME G:'$T QT
 I STAT["?" D HELP^PRCHJRP2(3) G STAT2
 I STAT="^" G QT
 S X=STAT X ^%ZOSF("UPPERCASE") S STAT=Y
 I STAT="A"!(STAT="AL") D WRT(STAT) S STAT="ALL"
 I STAT="" S STAT="ALL" W "ALL"
 S NOK="Y"
 I STAT'="ALL" D
 .I STAT'?3N W !,"Station should be 3 digits" S NOK="N" Q
 .I (ACC(0)'=1)&($G(X2(STAT))'=1) W !,"You are not a CP Official or Clerk at this Station." S NOK="N" Q
 .I $G(^PRC(420,STAT,0))="" W !,"Station ",STAT," is not a valid station number" S NOK="N" Q
 .I (ACC(0)=2)&($G(ACC(STAT,0))'=1) W !,"Station ",STAT," is not valid for this user." S NOK="N"
 I NOK="N" G STAT2
 ;
SUB ;Enter the Sub-station if there is one
 I STAT="ALL" S SSTAT="ALL",CONT="ALL" G CONT
 S X=0,NOSUB="Y",DISP="N",NOK="Y"
 F I=1:1 S X=$O(^PRC(411,X)) Q:+X=0  D
 .S SUB=$P($G(^PRC(411,X,0)),"^",1)
 .Q:SUB=STAT
 .I $E(SUB,1,3)=STAT S Y=$E(SUB,4,5)
 .I $E(SUB,1,3)'=STAT S Y=""
 .I Y'="" S SUB(Y)=1,DISP="Y",NOSUB="N"
SUB1 I DISP="Y" D
 .W !,"Enter a Sub-station,'NONE', or '^' ALL// " R SSTAT:DTIME I '$T S NOK="Q" Q
 .I SSTAT["?" D HELP^PRCHJRP2(4)  S NOSUB="Q" Q
 .I SSTAT="^" S NOK="Q" Q
 .S X=SSTAT X ^%ZOSF("UPPERCASE") S SSTAT=Y
 .I SSTAT="A"!(SSTAT="AL") D WRT(SSTAT) S SSTAT="ALL",NOK="Y" Q
 .I SSTAT="N" D WRT(SSTAT) S SSTAT="NONE",NOK="Y" Q
 .I SSTAT="NONE" S NOK="Y" Q
 .I SSTAT="ALL" S NOK="Y" Q
 .I SSTAT="" W "ALL" S SSTAT="ALL",NOK="Y" Q
 .I $G(SUB(SSTAT))="" W !,"Sub-station ",SSTAT," is not valid." S NOK="N"
 I NOSUB="Y" S SSTAT="ALL"
 I NOSUB="Q" S NOSUB="Y" G SUB1
 I NOK="N" G SUB
 I NOK="Q" G QT
CONT ;Enter control point number
 W !,"Enter the Control Point or '^' to quit. ALL FCPs// " R CONT:DTIME G:'$T QT
 I CONT["?" D HELP^PRCHJRP2(5)  G CONT
 I CONT="^" G QT
 S X=CONT X ^%ZOSF("UPPERCASE") S CONT=Y
 I CONT="A"!(CONT="AL") D WRT(CONT) S CONT="ALL"
 I CONT="" S CONT="ALL" W "ALL"
 S NOK="Y"
 I CONT'="ALL" D
 .I CONT'?3.4N S NOK="N" W !,"Control Point must be ALL or 3-4 digits" Q
 .I ACC(0)=1 D
 ..I STAT="ALL" D
 ...S X=0
 ...F I=1:1 S X=$O(ACC(X)) Q:X=""  D
 ....I $G(ACC(X,CONT))'="" S ACC2(X,CONT)=1
 ..I STAT'="ALL" D
 ...I $G(ACC(STAT,CONT))="" S NOK="N" W !,"FCP ",CONT," is not in Station ",STAT
 ...I $G(ACC(STAT,CONT))'="" S ACC2(STAT,CONT)=1
 .I ACC(0)=2 D
 ..I STAT="ALL" D
 ...S X=0,NOK="N"
 ...F I=1:1 S X=$O(ACC(X)) Q:X=""  D
 ....I $G(ACC(X,CONT))=1 S ACC2(X,CONT)=1,NOK="Y"
 ..I STAT'="ALL" D
 ...I $G(ACC(STAT,CONT))="" S NOK="N" W !,"FCP does not exist. "
 ...I $G(ACC(STAT,CONT))'="" S ACC2(STAT,CONT)=1
 I CONT="ALL" D
 .I ACC(0)=1 D
 ..I STAT="ALL" D
 ...S X=0
 ...F I=1:1 S X=$O(ACC(X)) Q:X=""  D
 ....S Y=0
 ....F J=1:1 S Y=$O(ACC(X,Y)) Q:Y=""  S ACC2(X,Y)=1
 ..I STAT'="ALL" D
 ...S Y=0
 ...F J=1:1 S Y=$O(ACC(STAT,Y)) Q:Y=""  D
 ....I $G(ACC(STAT,Y))'="" S ACC2(STAT,Y)=1 Q
 .I ACC(0)=2 D
 ..I STAT="ALL" D
 ...S X=0,NOK="N"
 ...F I=1:1 S X=$O(ACC(X)) Q:X=""  D
 ....S Y=0
 ....F J=1:1 S Y=$O(ACC(X,Y)) Q:Y=""  D
 .....S ACC2(X,Y)=1
 .....I $G(ACC(X,CONT))=1 S NOK="Y"
 ...I CONT="ALL" S NOK="Y"
 ..I STAT'="ALL" D
 ...S W=0
 ...F K=1:1 S W=$O(ACC(STAT,W)) Q:W=""  D
 ....I W=CONT S ACC2(STAT,CONT)=1,NOK="Y"
 I NOK="N" W !,"Invalid Fund Control Point" K CONT G CONT
TYPE ;Enter the Type of record
 S N2237="",UNAME=""
 W !,"Enter the Record Type:",! W ?25,"1=Returned to Accountable Officer",!
 W ?25,"2=Returned to Control Point",!
 W ?25,"3=Canceled",!
 W ?25,"4=Select a single eCMS User email contact",!
 W ?25,"5=Select a single 2237",!
 W "Enter a number from 1-5, or '^' to quit. ALL [1-3]// " R TYPE:DTIME G:'$T QT
 I TYPE["?" D HELP^PRCHJRP2(6)  G TYPE
 I TYPE="" S TYPE="ALL" W "ALL" G PROC
 S X=TYPE X ^%ZOSF("UPPERCASE") S TYPE=Y
 I TYPE="A"!(TYPE="AL") D WRT(TYPE) S TYPE="ALL" G PROC
 I TYPE="^" G QT
 I ";1;2;3;4;5;ALL;"'[(";"_TYPE_";")!(TYPE[";") W !,"Enter ALL or a number between 1 and 5 or ""^"" to stop" G TYPE
 S NOK="Y"
TYPE2 I TYPE=5 D
 .N PRCZ,DIR,PRCZ S DIR("A")="Enter partial (ex.688-12-4-1555) or complete 2237 number: ",DIR("?")="Enter Station-FY-QTR-FCP or entire transaction #"
 .S DIR(0)="FA^12:18^K:X'?3N1""-""2N1""-""1N1""-""3.4N.1(1""-""4N) X"
 .D ^DIR I $D(DIROUT)!$D(DIRUT) K DIROUT,DIRUT S NOK="R" Q
 .S X=Y N DIC
 .S DIC("S")="S PRCZ=$P(^(0),U) I ($D(^PRCV(414.06,""ATY"",6,Y)))!($D(^PRCV(414.06,""ATY"",8,Y)))!($D(^PRCV(414.06,""ATY"",10,Y)))"
 .S:$G(ACC(0))=2 DIC("S")=DIC("S")_"&($D(^PRC(420,""A"",DUZ,$P(PRCZ,""-""),+$P(PRCZ,""-"",4),1))!$D(^PRC(420,""A"",DUZ,$P(PRCZ,""-""),+$P(PRCZ,""-"",4),2)))"
 .S DIC="^PRCV(414.06,",DIC(0)="BQE" D ^DIC
 .I Y<1 W !,"Entry not found." S NOK="R" Q
 .S N2237=$P(Y,"^",2),STAT=$P(N2237,"-"),CONT=$P(N2237,"-",4),SSTAT="ALL",IDATE="ALL"
 I NOK="R" G TYPE
TYPE3 I TYPE=4 D
 .I $D(^PRCV(414.06,"ACONTACT"))<1 S NOK="N" W !,"There are no eCMS users on file",! Q
 .W !,"Enter the last name of the eCMS User contact: " R UNAME:DTIME I '$T S NOK="N" Q
 .S X=UNAME X ^%ZOSF("UPPERCASE") S UNAME=Y
 .I UNAME="" S NOK="N" Q
 .I UNAME="?" D HELP3^PRCHJRP2 S NOK="R" Q
 .I UNAME="??" D  Q
 ..D HELP4^PRCHJRP2
 ..I UNAME="" S NOK="N" Q
 ..I UNAME["?" S NOK="N" Q
 ..I UNAME'="" S NOK="Y" Q
 .I NOK="N" Q
 .I UNAME="^" S NOK="N" Q
 .S Y=UNAME,NOK="N"
 .;I $D(^PRCV(414.06,"ACONTACT"))<1 S NOK="N" W !,"No eCMS user contacts found",! Q
 .S Y=$E(UNAME,1,$L(UNAME)-1)_$C($A($E(UNAME,$L(UNAME)))-1)_"~"
 .F I=1:1 S Y=$O(^PRCV(414.06,"ACONTACT",Y)) Q:$E(Y,1,$L(UNAME))'=UNAME  D
 ..S ANAME(I)=Y W !,I,"  ",Y S NOK="Y"
 .I NOK="N" W !,"No  Users Found",! Q
 .W !,"Select the Email Contact by number: " R NUM:DTIME I '$T S NOK="N" Q
 .I NUM="^" S NOK="N" Q
 .I NUM="" S NOK="N" Q
 .I $G(ANAME(NUM))="" D  Q:NOK="N"
 ..W !,"Invalid selection.  Enter a valid number or '^' to quit: " R NUM:DTIME I '$T S NOK="N" Q
 ..I NUM="^" S NOK="N" Q
 ..I NUM="" S NOK="R" Q
 ..I $G(ANAME(NUM))="" W !,"Invalid selection." S NOK="R" Q
 .I NOK="R" Q
 .S MNAME=ANAME(NUM)
 .S X=0
 .S X=$O(^PRCV(414.06,"ACONTACT",MNAME,X))
 .S Y=0
 .S Y=$O(^PRCV(414.06,"ACONTACT",MNAME,X,Y))
 .S UNAME=$P($G(^PRCV(414.06,X,1,Y,1)),"^",6)
 .;S UNAME=ANAME(NUM)
 I NOK="R" G TYPE3
 I NOK="N" G TYPE
 ;
PROC ;BEGIN PROCESSING
 W !,"Please wait - report processing"
 S STOP="G"
 D GETIT
 S COUNT=0,X=0
 D
 .F I=1:1 S X=$O(^XTMP("PRCHJRP1",$J,X)) Q:X=""  D
 ..S Y=""
 ..F J=1:1 S Y=$O(^XTMP("PRCHJRP1",$J,X,Y)) Q:Y=""  S COUNT=COUNT+1
 I COUNT=0 W !,!,"There are no records to print.",! HANG 3 W @IOF Q
 W !,!,"There are ",COUNT," records to print.",!
 S %ZIS="Q",ZTSAVE("LL1")=$J,ZTSAVE("COUNT")=COUNT
 D ^%ZIS I POP K ^XTMP("PRCHJRP1",$J) Q
 I $D(IO("Q")) S ZTRTN="PRNT^PRCHJRP1",ZTDESC="Transaction Report - eCMS/IFCAP" D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q") Q
 D PRNT
 I STOP="S" W @IOF Q
 W !,"End of Report.  Press RETURN to continue " R XXZ:DTIME
 W @IOF
 G QT
GETIT ;Compile data
 ;Data in ^XTMP("PRCHJRP1",$J,0)=DATE+1^DATE^Transaction Report - eCMS/IFCAP
 ;Data in ^XTMP("PRCHJRP1",$J,2237,Date recd,Station, Type
 ;DATE2, IDATE, IJDATE, SDATE, SJDATE,  STAT, CONT, TYPE
 ;DATE2 added as date/time sent per Mavis McGaugh
 ;Note: Control point was removed from the report per M. McGaugh 6/13/2012
 ;START EXTRACTING DATA USING API
INDEX ;Determine index into ^PRCV(414.06,
 S ^XTMP("PRCHJRP1",$J,0)=$$HTFM^XLFDT($H+1,1)_"^"_$$HTFM^XLFDT($H,1)_"^"_"Transaction Report - eCMS/IFCAP"
 I (IDATE="ALL")&(STAT="ALL")&(CONT="ALL")&(TYPE="ALL")&(SSTAT="ALL") S XREF="B",TREF=1 G INDEX2
 I TYPE=5 S XREF="B",TREF=2 G INDEX2
 I TYPE=4 S XREF="ACONTACT",TREF=3 G INDEX2
 I TYPE=3 S XREF="ATY",TREF=4,XTYPE=10 G INDEX2
 I TYPE=2 S XREF="ATY",TREF=4,XTYPE=8 G INDEX2
 I TYPE=1 S XREF="ATY",TREF=4,XTYPE=6 G INDEX2
 I CONT'="ALL" S XREF="ACP",TREF=5 G INDEX2
 I STAT'="ALL" D  G INDEX2
 .I SSTAT="NONE" S XREF="ASN",TREF=6 Q
 .I SSTAT="ALL" S XREF="ASN",TREF=6
 .I SSTAT'="ALL" S XREF="ASB",TREF=7
 I IDATE'="ALL" S XREF="AED",TREF=8
INDEX2 ;Retrieve IEN base on cross reference.
 I TREF=1 D
 .S X=""
 .I $D(^PRCV(414.06,XREF))<1 Q
 .F I=1:1 S X=$O(^PRCV(414.06,XREF,X)) Q:X=""  D
 ..S Y=0
 ..F J=1:1 S Y=$O(^PRCV(414.06,XREF,X,Y)) Q:Y=""  D
 ...K VAL
 ...D DATA^PRCHJTA(Y,.VAL,.ERR)
 ...;WRITE DATA TO TMP FILE
 ...D BLD^PRCHJRP2
 I TREF=2 D
 .S Y=N2237,X=0
 .Q:Y=""
 .I $D(^PRCV(414.06,XREF,Y))<1 Q
 .S X=$O(^PRCV(414.06,XREF,Y,X))
 .Q:X=""
 .K VAL
 .D DATA^PRCHJTA(X,.VAL,.ERR)
 .;WRITE DATA TO TMP FILE
 .D BLD^PRCHJRP2
 I TREF=3 D
 .S Y=MNAME,X=0
 .I $D(^PRCV(414.06,XREF,Y))<1 Q
 .F I=1:1 S X=$O(^PRCV(414.06,XREF,Y,X)) Q:X=""  D
 ..K VAL
 ..D DATA^PRCHJTA(X,.VAL,.ERR)
 ..;WRITE DATA TO TMP FILE
 ..D BLD^PRCHJRP2
 I TREF=4 D
 .S X=0
 .I $D(^PRCV(414.06,XREF,XTYPE))<1 Q
 .F I=1:1 S X=$O(^PRCV(414.06,XREF,XTYPE,X)) Q:X=""  D
 ..K VAL
 ..D DATA^PRCHJTA(X,.VAL,.ERR)
 ..;WRITE DATA TO TMP FILE
 ..D BLD^PRCHJRP2
 I TREF=5 D
 .S X=0
 .I $D(^PRCV(414.06,XREF,CONT))<1 Q
 .F I=1:1 S X=$O(^PRCV(414.06,XREF,CONT,X)) Q:X=""  D
 ..K VAL
 ..D DATA^PRCHJTA(X,.VAL,.ERR)
 ..;WRITE DATA TO TMP FILE
 ..D BLD^PRCHJRP2
 I TREF=6 D
 .S X=0
 .I $D(^PRCV(414.06,XREF,STAT))<1 Q
 .F I=1:1 S X=$O(^PRCV(414.06,XREF,STAT,X)) Q:X=""  D
 ..K VAL
 ..D DATA^PRCHJTA(X,.VAL,.ERR)
 ..;WRITE DATA TO TMP FILE
 ..D BLD^PRCHJRP2
 I TREF=7 D
 .S X=0,Z=STAT_SSTAT
 .I $D(^PRCV(414.06,XREF,Z))<1 Q
 .F I=1:1 S X=$O(^PRCV(414.06,XREF,Z,X)) Q:X=""  D
 ..K VAL
 ..D DATA^PRCHJTA(X,.VAL,.ERR)
 ..;WRITE DATA TO TMP FILE
 ..D BLD^PRCHJRP2
 I TREF=8 D
 .S X1=$$FMADD^XLFDT(IJDATE,-1)
 .S X2=$$FMADD^XLFDT(SJDATE,1)
 .S W=X1
 .I $D(^PRCV(414.06,XREF))<1 Q
 .F I=1:1 S W=$O(^PRCV(414.06,XREF,W)) Q:W>X2  Q:W=""  D
 ..S X=0
 ..F J=1:1 S X=$O(^PRCV(414.06,XREF,W,X)) Q:X=""  D
 ...K VAL
 ...D DATA^PRCHJTA(X,.VAL,.ERR)
 ...;WRITE DATA TO TMP FILE
 ...D BLD^PRCHJRP2
 K VAL
 Q
 ;
PRNT ;Print output
 ;Date Print
 ;date sent, date received,2237 #,type, stat, sub stat,eCMS user
 ;   phone, email, Desc. on new line
 U IO D NOW^%DTC S Y=$P(%,".") D DD^%DT S HDATE=Y
 S P=0
 D HD
 S X=0,STOP="G"
 F L=1:1 S X=$O(^XTMP("PRCHJRP1",LL1,X)) Q:X=""  D
 .Q:STOP="S"
 .S D=""
 .F Y=1:1 S D=$O(^XTMP("PRCHJRP1",LL1,X,D)) Q:D=""  D
 ..Q:STOP="S"
 ..S TY=0
 ..F M=1:1 S TY=$O(^XTMP("PRCHJRP1",LL1,X,D,TY)) Q:TY=""  D
 ...S ST=""
 ...F Z=1:1 S ST=$O(^XTMP("PRCHJRP1",LL1,X,D,TY,ST)) Q:ST=""  D
 ....Q:STOP="S"
 ....S FCP=0
 ....F N=1:1 S FCP=$O(^XTMP("PRCHJRP1",LL1,X,D,TY,ST,FCP)) Q:FCP=""  D
 .....S OUT=$G(^XTMP("PRCHJRP1",LL1,X,D,TY,ST,FCP,0)) Q:OUT=""
 .....;Write out record
 .....S DSENT=$P(OUT,"^",1),SS=$P(OUT,"^",2),NM=$P(OUT,"^",3),PH=$P(OUT,"^",4),EM=$P(OUT,"^",5),NT=$P(OUT,"^",6)
 .....W ?1,$$FMTE^XLFDT(D,2),?21,$$FMTE^XLFDT(DSENT,2),?40,X,?60,TY,?65,SS,!
 .....W ?10,PH,?48,EM,!
 .....D CK Q:STOP="S"
 .....S LL=0
 .....F L=1:1 S LL=$O(^XTMP("PRCHJRP1",LL1,X,D,TY,ST,FCP,LL)) Q:LL=""  D
 ......S NT2=$G(^XTMP("PRCHJRP1",LL1,X,D,TY,ST,FCP,LL)) Q:NT=""
 ......S NT=NT_" "_NT2
 .....S NTL=$L(NT)\75
 .....I NTL=0 W ?1,NT,!,! D CK Q
 .....F M=1:1:(NTL+1) W ?1,$E(NT,1+((M-1)*75),M*75),! D CK  Q:STOP="S"
 .....W !
 I STOP'="S" W !,COUNT," records printed."
 D ^%ZISC
 K ^XTMP("PRCHJRP1",LL1)
 S:$D(ZTQUEUED) ZTREQ="@"
 G QT
 Q
CK ;CHECK PAGE LENGTH AND PRINT HEADER IF APPROPRIATE
 ;
 I (IOSL-$Y)<4 D
 .I $E(IOST)="P"!(IO'=IO(0)) D HD  Q
 .W !,"Press RETURN to continue, ^ to exit: " R XXZ:DTIME I '$T S STOP="S" Q
 .I XXZ="^" S STOP="S" Q
 .D HD
 Q
HD ;Print header
 W:$E(IOST,1,2)="C-"!P @IOF
 S P=P+1
 W !,?22,"REPORT OF eCMS/IFCAP TRANSACTION LOG",!,?26,"Date of Report: ",HDATE,!
 W !,"# below 'Type' header:  6-Return to AO; 8-Return to CP; 10-Canceled",?74,"p. ",P,!,!
 W ?1,"Date Rec'd",?21,"Date Sent",?40,"2237 Number",?59,"Type",?65,"Sub-Station",!
 W ?10,"eCMS Contact Phone",?48,"Email Address",!
 W ?1,"Reason Description",!
 W ?1,"---------------------------------------------------------------------------",!,!
 Q
QT ;QUIT ROUTINE
 ;
 Q
WRT(TRM) ;This will display full words for ALL or NONE on prompt entry
 I TRM["A" D
 .I $L(TRM)=1 W "LL"
 .I $L(TRM)=2 W "L"
 I TRM["N" D
 .I $L(TRM)=1 W "ONE"
 .I $L(TRM)=2 W "NE"
 .I $L(TRM)=3 W "E"
 Q
