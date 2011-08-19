RCFMOBR ;WASH-ISC@ALTOONA,PA/RWT-BILL RECONCILIATIONS LIST ;11/20/96  2:30 PM
V ;;4.5;Accounts Receivable;**2,20,40,53,249**;Mar 20, 1995;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Creates report from OBR data in file 423.6
 ;
 ;      OBR Data Structure used by this routine
 ; ^TMP("OBR",$J,SITE,"NOT IN AR")=NextRec^TotalItems^TotalFMSAmt
 ; ^TMP("OBR",$J,SITE,"NOT IN FMS")=NextRec^TotalItems^TotalARAmt
 ; ^TMP("OBR",$J,SITE,"DISCREPANCY")=NextRec^TotalItems^TotalFMSAmt^TotalARAmt
 ; ^TMP("OBR",$J,"BN",BILLNUMBER)=[423.6 rec] <-- x-ref of FMS Bills
 ; ^TMP("OBR",$J,"REPORT","1")="LINE 1"
 ; ^TMP("OBR",$J","REPORT,"2")="LINE 2"
 ;
 ; Descriptions of modules:
 ;    PROCFMS  -  loop through FMS bills (^PRCF(423.6)) updating
 ;                global ^TMP("OBR",$J,"BN") while also checking
 ;                for invalid AR bills
 ;    PROCAR   -  loop through all Active AR Bills comparing amounts
 ;                and looking for Detail bills not found in FMS
 ;    BUILDRPT -  Prepares report in global ^TMP("OBR",$J,"REPORT")
 ;
 N X,Y,OBR,A0,ERR
 K ^TMP("OBR",$J)
 ;
 I $G(PRCADA) D PROCESS(PRCADA) G Q1
 S OBR="OBR-",ERR=-1
 F  S OBR=$O(^PRCF(423.6,"B",OBR)) Q:OBR=""!(OBR'["OBR-")  D
    .I $O(^PRCF(423.6,"B",OBR))'["OBR-" D  Q
       ..S A0=$O(^PRCF(423.6,"B",OBR,0))
       ..S ERR=0 D PROCESS(A0)
 I ERR D PROCESS(ERR)
Q1 K ^TMP("OBR",$J)
 Q
PROCESS(A0) N X,X1,X2,Y,SN,PARENT,XMTEXT,XMSUB,XMSENDER,XMDUZ,ERR,DATE,FMSDATE
 S ERR=0 D
   .I '$D(^PRCF(423.6,A0,0)) S ERR=-1 Q
   .I $E(^PRCF(423.6,A0,0),1,3)'["OBR" S ERR=-1 Q
   .S X=$P(^PRCF(423.6,A0,0),"-",2)
   .S X=$E(X,5,6)_"-"_$E(X,7,8)_"-"_$E(X,1,4) D ^%DT ;Y is defined
   .S PARENT=$P($P(^PRCF(423.6,A0,0),"-",5),U)
   .;
   .D PROCFMS^RCFMOBR1(A0)
   .D PROCAR^RCFMOBR1(A0)
   .D BUILDRPT^RCFMOBR2(PARENT)
 ;
 I '$D(PARENT) S PARENT=$$SITE^RCMSITE
 S PARENT=$P(^DIC(4,+$O(^DIC(4,"D",PARENT,0)),0),U)
 ;
 I '$D(Y) S Y=DT  ;Y may be defined from %DT call above
 S X1=Y,X2=($E(Y,6,7)+1)*-1 D C^%DTC,YX^%DTC
 S FMSDATE=$P(Y,"@"),FMSDATE=$E(FMSDATE,1,4)_$E(FMSDATE,9,12)
 D NOW^%DTC S DATE=$E(X,4,5)_"-"_$E(X,6,7)_"-"_$E(X,2,3)
 ; - Transmits report via e-mail to FMS mail group
 S XMSUB="FMS "_FMSDATE_" RECONCILIATION ("_DATE_") "
 S XMSUB=XMSUB_PARENT
 I ERR D
   .S ^TMP("OBR",$J,"REPORT",1)="Date of Report: "_DATE
   .S ^TMP("OBR",$J,"REPORT",2)="NOTE: This report compares your current A/R records with data received from"
   .S ^TMP("OBR",$J,"REPORT",3)="      FMS on the last day of the previous accounting period."
   .S ^TMP("OBR",$J,"REPORT",4)=""
   .S ^TMP("OBR",$J,"REPORT",5)="No FMS data exists to reconcile!"
 S XMTEXT="^TMP(""OBR"",$J,""REPORT"","
 S XMDUZ="Accounts Receivable Package",XMY("G.FMS")="",XMY(DUZ)="" D ^XMD
 Q
EN2 ;Entry point from Regenerate Prior Month OBRs option
 N DIR,PRCADA,Y
 W !!,"This option will transmit the OBR report(s) to you and members"
 W !,"of the G.FMS mail group."
 W !!,"NOTE: Depending on the number of active AR bills in your system,"
 W !,"      this may take awhile to run.",!
 S DIR(0)="YO",DIR("A")="Are you sure you want to do this",DIR("B")="NO"
 D ^DIR Q:Y'=1  S ZTRTN="EN^RCFMOBR",ZTDESC="Prior Month OBRs"
 S ZTIO="" D ^%ZTLOAD Q
 ;
EN3 ;Deletes OBRs over 60 days old
 N A0,A1,A2,DA,DIK,X,X1,X2
 S A0="OBR-" F  S A0=$O(^PRCF(423.6,"B",A0)) Q:A0=""!(A0'["OBR-")  S A1=$E($P(A0,"-",2),1,8),A2=0 F  S A2=$O(^PRCF(423.6,"B",A0,A2)) Q:+A2=0  D
 .S X1=DT,X2=$$RCDT(A1) D ^%DTC I X>60 S DIK="^PRCF(423.6,",DA=A2 D ^DIK
 Q
RCDT(A1) ;Convert yyyymmdd to FM date
 N X,Y
 S X=A1,X=$E(X,5,6)_" "_$E(X,7,8)_", "_$E(X,1,4)
 D ^%DT
 Q Y
PURGE ;purge unprocessed document file
 N DIR,Y,X,X1,X2,RCDT
 S DIR("A")="How many days worth of DATA do you want to retain"
 S DIR(0)="N",DIR("?")="This is the number of days entries will remain in the file."
 D ^DIR
 I +Y<0!(Y="")!($E(Y,1)="^") G POUT
 S X1=DT,X2=-(+Y) D C^%DTC S RCDT=X
 S ZTRTN="QPURGE^RCFMOBR",ZTSAVE("RCDT")="",ZTDESC="Purge unprocessed document list",ZTIO="" D ^%ZTLOAD
POUT K DIRUT,DIROUT,DTOUT,DUOUT Q
 ;
QPURGE N DA,DIK
 S DIK="^RC(347,"
 Q:'$D(^RC(347))
 S DA=0 F  S DA=$O(^RC(347,DA)) Q:'DA  I $P(^(DA,0),U,5)<RCDT D ^DIK
 K RCDT
 Q
