PRCHNPO4 ;WOIFO/RSD/RHD-CONT. OF NEW PO--COMPLETE PROCESSING IN SUPPLY ;4/22/98  06:21
V ;;5.1;IFCAP;**51,56,81,79**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PHA S ERROR="" I $G(PRCHPC)'=1 D NEW^PRCOEDC(PRCHPO,.ERROR) I ERROR'="" W !!?5,"Procurement History transaction error " G ERR^PRCHNPO
 N RBD,RBDT,RBQT,RBFY,CCHK,FCHK,REFMOP S REFMOP=$P($G(^PRC(442,PRCHPO,0)),U,2)
 I REFMOP=25 S RBDT=$$DATE^PRC0C($P($G(^PRC(442,PRCHPO,1)),U,15),"I"),RBFY=$E(RBDT,3,4),RBQT=$P(RBDT,"^",2),RBD=$$QTRDATE^PRC0D(RBFY,RBQT),RBD=$P(RBD,"^",7)
 S PRC("CP")=$P($G(^PRC(442,PRCHPO,0)),"^",3)
 S CCHK=$P($G(^PRC(442,PRCHPO,0)),U,15)
 I $G(PRCHPC)="",CCHK'="" N BRCHK,BRCOST S BRCHK=$P($G(^PRC(442,PRCHPO,0)),"^",12),BRCOST=$P($G(^PRCS(410,+BRCHK,4)),"^") S:BRCOST'="" CCHK=CCHK-BRCOST
 I REFMOP=25 S FCHK=$$OVCOM^PRCS0A(PRC("SITE")_"^"_PRC("CP")_"^"_$P($$DATE^PRC0C(RBD,"I"),"^",1,2),CCHK,2) I FCHK'=0 W !,"Insufficient funds for this request." H 2 G ERR^PRCHNPO
 I $P($G(^PRC(442,PRCHPO,0)),U,2)=25 S FILE=442 D LIMIT^PRCHCD0 I $G(ERROR) K FILE,ERROR G ERR^PRCHNPO
 ;I $G(PRCHPC)=2 S $P(^PRC(442,PRCHPO,0),U,15)=PRCHTAMT
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="D" D  G:$G(ERROR)=1 ERR^PRCHNPO
 . S PRCHITM=0 F  S PRCHITM=$O(^PRC(442,PRCHPO,2,PRCHITM)) Q:'PRCHITM  I $P($G(^PRC(442,PRCHPO,2,PRCHITM,2)),U,2)="" W !!,?5,"One or more of the items on this delivery order",!,?5,"does not contain contract number." S ERROR=1
 ;
 ; New check for FPDS, PRC*5.1*79
 ; Check Detailed PC orders with source code 6 and contract items only
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="P"&($P($G(^PRC(442,PRCHPO,1)),U,7)=6) D  G:$G(ERROR)=1 ERR^PRCHNPO
 . S PRCHITM=0 F  S PRCHITM=$O(^PRC(442,PRCHPO,2,PRCHITM)) Q:'PRCHITM  I $P($G(^PRC(442,PRCHPO,2,PRCHITM,2)),U,2)="" W !!,?5,"Line item "_PRCHITM_" on this purchase card order",!,?5,"does not contain a required contract number." S ERROR=1
 D EN105^PRCHNPO7 G:$G(ERROR)=1 ERR^PRCHNPO
 ; End of new check for FPDS
 ;
FS S PRCHN("SFC")=$P(^PRC(442,PRCHPO,0),U,19)
 ; SET STATUS TO 'Ordered (no Fiscal Action Required)' IF IMPREST FUNDS METHOD OF PROCESSING, OR IF SPECIAL CONTROL POINT FOR SUPPLY FUND (POSTED).
 ; SET STATUS TO 'Transaction Complete' FOR CERTIFIED INVOICES ORDERED FOR SUPPLY FUND.
 ; SET STATUS TO 'Pending Fiscal Action' OTHERWISE.
 S PRCHSTAT=10,%A="Send to Fiscal Service"
 I PRCHN("SFC")=2!(PRCHN("MP")=25) S PRCHSTAT=22,%A="Print Purchase Order"
 S FILE=442 D:$D(PRCHPO) CHECK^PRCHSWCH
 I $G(PRCHOBL)=1 S PRCHSTAT=22,%A="Print Purchase Order "
 I PRCHN("MP")=2,PRCHN("SFC")=2 S PRCHSTAT=40
 ;
ASK I '$G(PRCHPC),'$G(PRCHDELV) D  G Q:%=2&(PRCHN("MP")'=25)!(%<0),FS:%=0
 . W ! S %A="     "_%A,%B="",%=1 D ^PRCFYN
 . S NOPRINT="" I %=2 S NOPRINT=1
 S P=+$P($G(^PRC(442,PRCHPO,1)),U,10),DA=PRCHPO
 I 'P W !!,"P.O. is missing the Purchasing Agent and must be re-edited !",$C(7) G Q
 I P'=DUZ W !!,"You must be the Purchasing Agent listed on P.O. to sign it.",$C(7) S DIR(0)="EAO",DIR("A")="Press <Return> to continue " D ^DIR K DIR(0),DIR("A") G Q
 I $G(PRCHPHAM),$P(^PRC(442,PRCHPO,0),U,15)=0 D  G:%'=1 ERR^PRCHNPO
 . W !!,?5,"This pharmacy order is a no charge order." S %A="     Would you like to sign this order",%B="",%=2 D ^PRCFYN
 S X=$P($G(^PRC(442,PRCHPO,1)),U)
 ;
 ; Begin modifications for PRC*5.1*56
 I X]"",$P($G(^PRC(440,X,3)),U,2)="Y",";P;S;"[(";"_$P($G(^PRC(442,PRCHPO,23)),U,11)_";") D
 . S MSG1="                   This order will not be sent via EDI."
 . S MSG2="To place a Purchase Card order via EDI please use the Purchasing Agent Menu."
 . W !!!,"                           ***** TAKE NOTE *****"
 . W !!,?2,MSG1,!!,MSG2,!!
 . K MSG1,MSG2
 . Q
 ; End modifications for PRC*5.1*56
 I X]"",$P($G(^PRC(440,X,3)),U,2)="Y",";P;S;"'[(";"_$P($G(^PRC(442,PRCHPO,23)),U,11)_";") D  G:$G(X)="ABORT" Q I $D(DTOUT)!$D(Y) W $C(7),!!,"The 'Do You Want to Send This EDI?' question was bypassed - You must reedit PO" K DTOUT G Q
 . N PRCY S PRCY=""
 . I $P($G(^PRC(442,PRCHPO,0)),U,2)=25 D
 . . N PRCX
 . . S PRCX=$P($G(^PRC(442,PRCHPO,23)),U,8)
 . . S:PRCX'="" PRCX=$P($G(^PRC(440.5,PRCX,2)),U,4)
 . . D NOW^%DTC
 . . I ($E(PRCX,6,7)>0&(X>PRCX))!(+$E(PRCX,6,7)=0&(X\100>(PRCX\100))) D
 . . . W !!,"In File #440.5, the Expiration Date for this card is blank or this card has"
 . . . W !,?5,"expired!  An EDI order will reject.  Please contact your Purchase"
 . . . W !,?5,"Card Coordinator." S PRCY="NO"
 . N DIE,DR,DA
 . S DIE=442,DR="116///@;S Y=""@1"";@1;116Do You Want to Send This EDI?~R",DA=PRCHPO D ^DIE
 . Q:$D(DTOUT)!$D(Y)
 . I $P($G(^PRC(442,PRCHPO,12)),U,16)="y",PRCY="NO" D
 . . S X="ABORT"
 . . W !,"As you have elected to send this order EDI, please ask the Purchase Card"
 . . W !,"Coordinator to update the Card's Expiration Date before completing this"
 . . W !,"Purchase Order. - You must reedit this PO."
 ; UPDATE STATUS, P.A.SIGNATURE & BOC DATA, IN P.O.
 S PRCSIG="" D ESIG^PRCUESIG(DUZ,.PRCSIG) S ROUTINE="PRCUESIG" I PRCSIG<1 D QQ G Q
 ;Following line added in P194: go create new txn # if PC order modified
 ;to new FCP
 D CHECKFCP^PRCHNPOA(PRCHPO)
 ;I $P($G(^PRC(442,PRCHPO,23)),U,11)="D",$P(^PRC(442,PRCHPO,0),U,2)=26 S $P(^PRC(442,PRCHPO,24),U)=1
 I $G(PRCHPC)!$G(PRCHDELV) D  G Q:%<0,FS:%=0
 . I $G(PRCPROST) S PRCPROST=3.9,NOPRINT=1,%=2 QUIT
 . S %A=$S($G(PRCHPC):"Print Purchase Card Order ",1:"Print Delivery Order")
 . W ! S %A="     "_%A,%B="",%=1 D ^PRCFYN
 . S NOPRINT="" I %=2 S NOPRINT=1
 ;
 S X=$S($G(PRCHPHAM)'="":30,1:PRCHSTAT),DA=PRCHPO D ENS^PRCHSTAT
 S (D0,DA)=PRCHPO D ^PRCHSF ;CALLS ROUTINE FOR FMS PROCESSING
 S %DT="T",X="NOW" D ^%DT S PRCSIG="" D ENCODE^PRCHES5(DA,DUZ,.PRCSIG)
 S ROUTINE=$T(+0) I PRCSIG<1 D QQ G Q
 S D0=PRCHPO K D1 S:'$D(DT) DT=$P(Y,".",1)
 ;
 I $G(PRCHPC)!$G(PRCHDELV) D
 . I $P($G(^PRC(442,PRCHPO,23)),U,8)]"" D
 . . S PRCHCD=$P(^PRC(442,PRCHPO,23),U,8)
 . . S PRCHPOMT=$P(^PRC(442,PRCHPO,0),U,15)
 . S PODA=DA,DA=CDA S X=$P(^PRC(442,PRCHPO,0),U,15) D ESIG^PRCH410 S DA=PODA K PODA
 ; IF SUPPLY FUND, NOT CERTIFIED INVOICE, SET FLAG NOTIFYING PPM TO CREATE LOG CODE SHEETS
 S PRCHPOMT=$P(^PRC(442,PRCHPO,0),U,15),PRCHCD=$P(^PRC(442,PRCHPO,23),U,8)
 I $P($G(^PRC(442,PRCHPO,0)),U,2)=25,$G(PRCHCD)'="" S $P(^PRC(440.5,PRCHCD,2),U)=+$P($G(^PRC(440.5,PRCHCD,2)),U)+PRCHPOMT
 I PRCHN("SFC")=2 S $P(^PRC(442,PRCHPO,18),U,12)=1
 I PRCHN("SFC")=2,PRCHN("MP")'=2 S $P(^PRC(442,PRCHPO,18),U,11)="N",^PRC(442,"AE","N",PRCHPO)=""
 ; IF SUPPLY FUND, CERTIFIED INVOICE, UPDATE CONTROL POINT OBLIGATED BALANCE.
 ;
ISMS ;I PRCHSC=9 ;;I $D(PRCHISMS)   ;CHECK ISMS SWITCH AND IF TRUE CREATE ISMS TRANSACTION
 ;I PRCHSC=1 D:0 EN11^PRCHEI
 ;I PRCHSC=9 S PRCHTRAN="PO1" D EN11^PRCHEI(PRCHTRAN)
 ;
 ; PRC*5.1*81 - if site runs DynaMed, may need to build update txn
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 D UPD^PRCV442A(PRCHPO)
 ;
EDI ;CHECK TO SEE IF IT IS AN EDI PO AND SEND TO AUSTIN
 ;I $G(PRCHSTAT)'="",PRCHSTAT'=10 N PRCOPODA S PRCOPODA=PRCHPO D ^PRCOEDI
 I PRCHN("MP")=25 D  S $P(^PRC(442,PRCHPO,24),U)=1 G INV
 . I $G(PRCHPC)'=1 N PRCOPODA S PRCOPODA=PRCHPO W !!,"...now generating the PHA transaction" D ^PRCOEDI
 .;Create FPDS message for the AAC, PRC*5.1*79
 . I $P(^PRC(442,PRCHPO,0),U,15)>0,$D(^PRC(442,PRCHPO,25)) D
 . . D EN^DDIOL("...now generating the FPDS message for the AAC","","!!"),EN^DDIOL(" ") D AAC^PRCHAAC
 .;End of changes for PRC*5.1*79
 . I '$P($G(^PRC(442,PRCHPO,23)),U,11) D
 . . I '$P(^PRC(442,PRCHPO,0),U,12) S DA=PRCHPO D START^PRCH410 D  Q
 . . . S PODA=PRCHPO,DA=CDA S X=$P(^PRC(442,PRCHPO,0),U,15) D ESIG^PRCH410 S DA=PODA K PODA
 . . I $P(^PRC(442,PRCHPO,0),U,12) D COMM^PRCSPC(PRCHPO,$P(^PRC(442,PRCHPO,0),U,10))
 I $G(PRCHSTAT)'="",PRCHSTAT'=10 D  S:$P(^PRC(442,PRCHPO,0),U,2)=26 $P(^PRC(442,PRCHPO,24),U)=1 G INV
 . Q:$P(^PRC(442,PRCHPO,0),U,2)=2
 . N PRCOPODA S PRCOPODA=PRCHPO D ^PRCOEDI,SUPP^PRCFFMO
 I $G(PRCHOBL)=2 N PRCOPODA S PRCOPODA=PRCHPO W !!,"...now generating the PHA transaction" D ^PRCOEDI
 ;
 ;update due-ins at the inventory point
INV G:$P($G(^PRC(442,PRCHPO,23)),U,11)="S" PRT
 G:$G(PRCHPHAM) PRT
 S FLG=0 I $P(^PRC(442,PRCHPO,0),U,2)=2 D
 .S N=0 F  S N=$O(^PRC(442,PRCHPO,2,N)) Q:'N!(FLG)  I $P(^(N,0),U,5)]"" S FLG=1
 .K N
 I $P($G(^PRC(442,PRCHPO,23)),U,11)'="S" I '$G(PRCHPHAM) D
 . I $P(^PRC(442,PRCHPO,0),U,2)'=2 S DA=PRCHPO D UPDATE^PRCPWIU
 . I ($P(^PRC(442,PRCHPO,0),U,2)=2)&(FLG) S DA=PRCHPO D UPDATE^PRCPWIU
 K FLG
 ;S DA=PRCHPO D UPDATE^PRCPWIU
 ;
PRT ;IF IMPREST FUND PO, PRINT A COPY ON BOTH IMPREST FUND & FISCAL PRINTER.
 ;IF SUPPLY FUND PO, PRINT A COPY IN P&C AND ONE IN FISCAL.
 ; OTHERWISE, PRINT A COPY IN FISCAL
 ;IF SUPPLY FUND PAYMENT IN ADVANCE, PRINT 2 MORE COPIES IN FISCAL.
 K PRCHQ S (D0,DA)=PRCHPO,PRCHQ="^PRCHFPNT"
 ;
 I PRCHN("MP")=12 S PRCHQ("DEST2")="IFP" D ^PRCHQUE
 I '$G(NOPRINT) I PRCHN("SFC")=2!(PRCHN("MP")=25) S:PRCHN("MP")'=25 PRCHQ("DEST")="S8" D ^PRCHQUE S (D0,DA)=PRCHPO,PRCHQ="^PRCHFPNT"
 ;
 K PRCHQ S (D0,DA)=PRCHPO,PRCHQ="^PRCHFPNT"
 I PRCHN("MP")'=25 S PRCHQ("DEST")="F" D ^PRCHQUE
 I PRCHN("SFC")=2,PRCHN("MP")=3 F PRCHI=1,2 S (D0,DA)=PRCHPO,PRCHQ="^PRCHFPNT",PRCHQ("DEST")="F" D ^PRCHQUE
 G Q
 ;
QQ N:'$D(ROUTINE) ROUTINE S:$G(ROUTINE)="" ROUTINE=$T(+0) N DIR
 W !!,$$ERR^PRCHQQ(ROUTINE,PRCSIG) W:PRCSIG=0!(PRCSIG=-3) !,"Notify Application Coordinator!",$C(7)
 S DIR(0)="EAO",DIR("A")="Press <return> to continue" D ^DIR K PRCSIG
 Q
 ;
Q L  K PRCH,PRCHAC,PRCHACT,PRCHAM,PRCHAMT,PRCHB,PRCHBO,PRCHCN,PRCHCNT,PRCHD,PRCHDA,PRCHDT,PRCHEC,PRCHEDI,PRCHER,PRCHES,PRCHEST,PRCHESTL,PRCHFPDS,PRCHI,PRCHL0,PRCHL1,PRCHL2,PRCHL3,PRCHLCNT,PRCHLI,PRCSIG,ROUTINE
 K PRCHN,PRCHNM,PRCHNRQ,PRCHP,PRCHPO,PRCHPONO,PRCHQ,PRCHS,PRCHSC,PRCHSTAT,PRCHTTT,PRCHV,PRCHVAR,PRCHX,PRCHY,DIC,DIE,DR,D0,DA,X,Y,Z,I,J,K,P,ZTSK
 K ERROR,ITEMCNT,M,M0,PRCHFCP,PRCHLOG,PRCHSTN,ZTDESC,ZTRTN,ZTUCI,A,B,C,V3,PRCHXXD0,F1,I1,POP,PRCHLN,SUBACC,ERROR1,NOPRINT
 Q
