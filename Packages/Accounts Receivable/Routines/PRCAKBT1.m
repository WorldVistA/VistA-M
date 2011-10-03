PRCAKBT1 ;WASH-ISC@ALTOONA,PA/CMS-AR BUILD TEMP ARCHIVE FILE CONT. ;7/3/96  11:17 AM
V ;;4.5;Accounts Receivable;**46**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW DA,DIC,DIQ,DR,FIL,II,PRCABN
 F PRCABN=0:0 S PRCABN=$O(^PRCA(430,"AC",STAT,PRCABN)) Q:'PRCABN  D SET
 Q
SET ;create data records
 N BN0,DA,PRCATN,TN
 S BN0=$G(^PRCA(430,PRCABN,0)) I BN0="" K ^PRCA(430,"AC",STAT,PRCABN) Q
 I $P(BN0,"^")="" S ^TMP("PRCAK",$J,"E",^TMP("PRCAK",$J,"E"))="Bill number not defined for entry #"_PRCABN_" in file 430!",^TMP("PRCAK",$J,"E")=^TMP("PRCAK",$J,"E")+1 Q
 I '$D(^PRCA(430,"B",$P(BN0,U,1),PRCABN)) S ^PRCA(430,"B",$P(BN0,U,1),PRCABN)=""
 D P430 I '$D(^UTILITY("DIQ1",$J)) S ^TMP("PRCAK",$J,"E",^TMP("PRCAK",$J,"E"))="Could not set Archive data record for Bill NO. "_$P(BN0,U),^TMP("PRCAK",$J,"E")=^TMP("PRCAK",$J,"E")+1 Q
 F PRCATN=0:0 S PRCATN=$O(^PRCA(433,"C",PRCABN,PRCATN)) Q:'PRCATN  I $G(^PRCA(433,PRCATN,0))'="" D P433
 K ^UTILITY("DIQ1",$J)
 Q
P430 ;get all 430 data
 N DA,DIC,DIQ,DR,II,SF,SN,TN
 K ^UTILITY("DIQ1",$J)
 F II=2,5,10,101 I $D(^PRCA(430,PRCABN,II,0)) D
 .F SN=0:0 S SN=$O(^PRCA(430,PRCABN,II,SN)) Q:'SN  S SF(II,SN)=""
 S DA=PRCABN,DIC="^PRCA(430,",DIQ(0)="EN",DR=".001:99999999" D EN^DIQ1
 S DR(430.01)=DR,DR(430.02)=DR,DR(430.051)=DR,DR(430.098)=DR
 F II=0:0 S II=$O(SF(II)) Q:'II  F SN=0:0 S SN=$O(SF(II,SN)) Q:'SN  S DA($S(II=2:430.01,II=5:430.051,II=10:430.098,1:430.02))=SN S DIQ(0)="EN" D EN^DIQ1
 I $D(^UTILITY("DIQ1",$J)) S TN=0 D ENT
 Q
P433 ;Get all 433 data
 N DA,DIC,DIQ,DR,II,SF,SN
 K ^UTILITY("DIQ1",$J)
 F II=4,6,7 I $D(^PRCA(433,PRCATN,II,0)) D
 .F SN=0:0 S SN=$O(^PRCA(433,PRCATN,II,SN)) Q:'SN  S SF(II,SN)=""
 S DA=PRCATN,DIC="^PRCA(433,",DIQ(0)="EN",DR=".001:99999999" D EN^DIQ1
 S DR(433.01)=DR,DR(433.04)=DR,DR(433.061)=DR
 F II=0:0 S II=$O(SF(II)) Q:'II  F SN=0:0 S SN=$O(SF(II,SN)) Q:'SN  S DA($S(II=4:433.01,II=6:433.061,1:433.04))=SN S DIQ(0)="EN" D EN^DIQ1
 I '$D(^UTILITY("DIQ1",$J)) S ^TMP("PRCAK",$J,"E",^TMP("PRCAK",$J,"E"))="Could not create Archive data record for Tran. No. "_PRCABN_" of Bill # "_$P(BN0,"^"),^TMP("PRCAK",$J,"E")=^TMP("PRCAK",$J,"E")+1 Q
 S TN=$G(TN)+1 D ENT
 Q
ENT ;Enter Data records in File 430.8
 N DAT,DD,DIC,DINUM,DLAYGO,DO,FIL,FLD,I,IFN,X,Y,LN
 S DLAYGO=430.8,DIC="^PRCAK(430.8,",DIC(0)="L"
 S DIC("W")="",X=$P(BN0,"^",1)_"-"_TN D ^DIC
 I Y<0 S ^TMP("PRCAK",$J,"E",^TMP("PRCAK",$J,"E"))="Could not archive entry "_X_" (IEN: "_PRCABN_") due to invalid identifier.",^TMP("PRCAK",$J,"E")=^TMP("PRCAK",$J,"E")+1 Q
 I '$P(Y,"^",3) S ^TMP("PRCAK",$J,"E",^TMP("PRCAK",$J,"E"))="Could not archive entry "_X_" (IEN: "_PRCABN_") due to duplicate entry.",^TMP("PRCAK",$J,"E")=^TMP("PRCAK",$J,"E")+1 Q
 S CNT=$G(CNT)+1,$P(^PRCAK(430.8,+Y,0),"^",2)=$$NAM^RCFN01($P(BN0,"^",9))
 S $P(^PRCAK(430.8,+Y,0),"^",3)=$$SSN^RCFN01($P(BN0,"^",9)),$P(^(0),"^",4)=0
 S ^PRCAK(430.8,+Y,1,0)="^^0^0^"_DT_"^"
 S FIL="" F  S FIL=$O(^UTILITY("DIQ1",$J,FIL)) Q:FIL=""  F IFN=0:0 S IFN=$O(^UTILITY("DIQ1",$J,FIL,IFN)) Q:'IFN  D
 .S FLD="" F  S FLD=$O(^UTILITY("DIQ1",$J,FIL,IFN,FLD)) Q:FLD=""  S I=$O(^(FLD,"")) D
 ..I I="E" S DAT=$G(^TMP("PRCAK",$J,"F",FIL,FLD))_":"_^UTILITY("DIQ1",$J,FIL,IFN,FLD,"E") D ADD I FIL=433,FLD=.01 S $P(^PRCAK(430.8,+Y,0),U,4)=$P(DAT,":",2) Q
 ..S I=0 F  S I=$O(^UTILITY("DIQ1",$J,FIL,IFN,FLD,I)) Q:'I  S DAT=$G(^TMP("PRCAK",$J,"F",FIL,FLD))_":"_^UTILITY("DIQ1",$J,FIL,IFN,FLD,I) D ADD
 .S DAT="" D SAVE
 Q
ADD ;add to WP field
 I $G(LN)="" S LN=" "_DAT Q
 I ($L(DAT)+$L(LN))<210 S LN=LN_"   "_DAT Q
SAVE S X=$P(^PRCAK(430.8,+Y,1,0),U,4)
 F  Q:LN=""  D
 .S X=X+1
 .S ^PRCAK(430.8,+Y,1,X,0)=$E(LN,1,245)
 .S LN=$E(LN,246,9999)
 .Q
 S $P(^PRCAK(430.8,+Y,1,0),U,3,4)=X_"^"_X
 S LN=DAT
 Q
