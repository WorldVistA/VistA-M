RCFMCAF ;WASH-ISC@ALTOONA,PA/RB-CONVERSION AR ACCTG FIELDS RPT ;8/9/95  11:12 AM
V ;;4.5;Accounts Receivable;**14**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Creates report from CAF data in file 423.6
 W !!,"This option will take the Conversion AR Fields (CAF) data from",!
 W "the FMS file (#423.6) and put them in their proper AR file entries."
 W !,"Afterwards, a list will be transmitted to the G.FMS mail group"
 W !,"showing FMS bills entered into the AR file and FMS bills that are"
 W !,"not in the AR file, if any.",! N DIR,Y,ZTDESC,ZTIO,ZTRTN
 S DIR(0)="YO",DIR("A")="Are you sure you want to do this",DIR("B")="NO"
 D ^DIR Q:Y'=1  S ZTRTN="EN2^RCFMCAF",ZTDESC="Conversion AR Fields Rpt."
 S ZTIO="" D ^%ZTLOAD Q
 ;
EN2 N A0,A1,A2,A3,BN,C1,C2,DA,DIE,DR,LN,ND,SP,X K ^TMP($J),^TMP("RJ",$J)
 S C1=3,C2=0,$P(LN,"=",79)="=",$P(SP," ",30)=" "
 S A0="CAF-" F  S A0=$O(^PRCF(423.6,"B",A0)) Q:A0=""!(A0'["CAF-")  S A1=$O(^PRCF(423.6,"B",A0,0)) I $D(^PRCF(423.6,A1,0)) D
 .S A2=0 F  S A2=$O(^PRCF(423.6,A1,1,A2)) Q:+A2=0  I ^(A2,0)["CAF^" D
 ..S ND=^PRCF(423.6,A1,1,A2,0),X=$P(ND,U,4),BN=$E(X,1,3)_"-"_$E(X,4,10),A3=+$O(^PRCA(430,"B",BN,0))
 ..I $D(^PRCA(430,A3,0)) S C1=C1+1,^TMP($J,C1)="Bill #: "_BN_SP_"Amount: "_$J($P(ND,U,6),0,2)
 ..I  S DA=A3,DIE="^PRCA(430,",DR="[RCFM CAF FILE ENTRIES]" D ^DIE
 ..I '$D(^PRCA(430,A3,0)) S C2=C2+1,^TMP("RJ",$J,C2)="Bill #: "_BN_SP_"Amount: "_$J($P(ND,U,6),0,2)
 I '$D(^TMP($J)),'$D(^TMP("RJ",$J)) S ^TMP($J,1)="There are no CAF entries in the FMS file (#423.6)." G XM
 I $D(^TMP($J)) S ^TMP($J,1)=LN,^TMP($J,2)="The following FMS bills have been entered into the AR file: ",^TMP($J,3)=LN
 I $D(^TMP("RJ",$J)) D
 .S C1=C1+1,^TMP($J,C1)=LN,C1=C1+1,^TMP($J,C1)="The following FMS bills are NOT in AR: ",C1=C1+1,^TMP($J,C1)=LN
 .S A0=0 F  S A0=$O(^TMP("RJ",$J,A0)) Q:+A0=0  S C1=C1+1,^TMP($J,C1)=^TMP("RJ",$J,A0) K ^TMP("RJ",$J,A0)
XM N XMSUB,XMTEXT,XMY S XMY("G.FMS")="",XMSUB="CONVERSION AR FIELDS LIST"
 S XMTEXT="^TMP($J," D ^XMD K ^TMP($J),^TMP("RJ",$J) Q
