MCARAMLG ;WASH ISC/JKL-MUSE AUTO INSTRUMENT RETRANSMISSION-EKG CORR ;2/27/95  19:42
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Called from ^MCARAML
 ;Retransmits EKG external date cross-reference,
 ;EKG date cross-reference without record, without transaction
 ;EKG PID cross-reference without record,
 ;EKG automated record with defunct delete status
 N MCNAME,MCSSN,MCDATE,MCIEN,MCZERO,MCI,MCJ,X,D,DIC,Y,MCK
 ;Retransmits EKG external date cross-reference
 S MCDATE=9999999
 F MCI=1:1 S MCDATE=$O(^MCAR(691.5,"B",MCDATE)) Q:MCDATE=""  I MCDATE'="ES" S MCIEN=0 F MCK=1:1 S MCIEN=$O(^MCAR(691.5,"B",MCDATE,MCIEN)) Q:MCIEN=""  D SAVE
 ;EKG date cross-reference without transaction
 S MCDATE=0
 F MCI=1:1 S MCDATE=$O(^MCAR(691.5,"B",MCDATE)) Q:MCDATE=""!(+MCDATE>9999999)  I '$D(^MCAR(700.5,"B",MCDATE)) S MCIEN=0 F MCK=1:1 S MCIEN=$O(^MCAR(691.5,"B",MCDATE,MCIEN)) Q:MCIEN=""  D SAVE
 ;EKG automated record with defunct delete status
 ;EKG PID cross-reference without record,
 S (MCIEN,MCERR)=0
 F MCI=1:1 S MCIEN=$O(^MCAR(691.5,MCIEN)) Q:MCIEN=""!(MCIEN="B")  S MCERR=0 D DEF S MCERR=1 D SAVE
 Q
 ;
DEF ;
 I '$D(^MCAR(691.5,MCIEN,"A")) Q
 I '$D(^MCAR(691.5,MCIEN,"ES")) Q
 I $P(^MCAR(691.5,MCIEN,"ES"),"^",12)=1 D SAVE
 Q
 ;
SAVE ;
 I '$D(^MCAR(691.5,MCIEN,0)) Q
 S MCSSN="" S:$D(^MCAR(691.5,MCIEN,.1)) MCSSN=^MCAR(691.5,MCIEN,.1)
 S MCZERO=^MCAR(691.5,MCIEN,0)
 S MCPID=$P(MCZERO,"^",2),MCNAME=""
 I '$D(MCDATE) S MCDATE=$P(MCZERO,"^") I MCDATE="" S MCDATE="NO DATE"
 S X=MCSSN,DIC="^DPT(",D="SSN",DIC(0)="XZ" D IX^DIC
 S:+Y>0 MCNAME=$P(Y(0),"^")
 I (MCERR=1),MCPID'="",$D(^MCAR(691.5,"C",MCPID)) Q
 D SET Q
 ;
SET ;
 I MCNAME="",MCSSN="",MCDATE="" Q
 I MCNAME="" S MCNAME="NO PATIENT NAME"
 I MCSSN="" S MCSSN="NO SSN"
 I MCDATE="" S MCDATE="NO DATE"
 I $L(MCNAME)<30 F MCJ=$L(MCNAME):1:30 S MCNAME=MCNAME_" "
 I $L(MCSSN)<10 F MCJ=$L(MCSSN):1:10 S MCSSN=MCSSN_" "
 I $D(^TMP($J,0,"MC",MCNAME,MCSSN,MCDATE)) Q
 S MCCNT=MCCNT+1 W:MCCNT#100=0 "."
 S ^TMP($J,0,"MC",MCNAME,MCSSN,MCDATE)=""
 S ^TMP($J,0,"MC",0)=MCCNT
 Q
