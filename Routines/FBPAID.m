FBPAID ;WOIFO/SAB - SERVER ROUTINE TO UPDATE PAYMENTS ;2/10/2009
 ;;3.5;FEE BASIS;**5,61,107**;JAN 30, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;incoming record from AAC will contain the following data
 ;   - Fee Program  - from Fee Basis Program  (161.8)
 ;   - Activity Code    (C - confirmed)
 ;                      (B - backout)
 ;                      (X - cancelled)
 ;   - Internal Control Number   - IEN of payment record
 ;   - Check Number
 ;   - Check Date
 ;   - Interest Amount
 ;   - Cancellation Date
 ;   - Reason Code  (File # 162.95)
 ;   - Cancellation Code (R - C - X)
 ;   - Disbursed Amount   (this amount minus interest amount = amt pd)
 ;   variable 'FBPAID' is defined and passed to TRAP^FBMRASVR2
 ;
 N FBINV
 S U="^",FBPAID=1,FBMCNT=0
 S X="TRAP^FBMRASV2" S @^%ZOSF("TRAP")
 ;K XMY S XMY("G.FEE")="" D ENT1^XMD
 K ^TMP("FBPAID",$J),^TMP("FBERR",$J)
 D STATION^FBAAUTL I $S($G(FB("ERROR")):1,'$G(FBAASN):1,1:0) Q
 K FB
 ;start to read in message from central fee
 ;edits are:
 ;          1. invalid station number
 ;          2. invalid record length
 ;          3. unable to locate payment record
 ;          4. disbursed amount '= amt paid+interest
 ;          5. cancellations
 ; XMRG=record received in mail message from Austin
 F I=1:1 X XMREC Q:XMER<0  I XMRG]"",$E(XMRG,1,3)=FBAASN D
 .S ^TMP("FBREC",$J,I)=XMRG
 .K FBERR
 .I $L(XMRG)'=77&($L(XMRG)'=82) S FBERR=1,^TMP("FBERR",$J,2,I)=""
 .D PARSE^FBPAID1 Q:$G(FBERR)  S FBMCNT=FBMCNT+1 D @FBPROG
 D ^FBPAID2:$D(^TMP("FBERR",$J))
 D BUL^FBPAID1
 ; if any EDI invoices then add to FPPS queue
 I $D(FBINV) D PAIDLOG^FBFHLL(.FBINV)
 G END
 ;
3 ;update outpatient payment record
 Q:'$D(^FBAAC(+FBIEN(3),1,+FBIEN(2),1,FBIEN(1),1,FBIEN,0))  S FBAMT=+$P(^(0),U,3) D
 .I FBDAMT-FBINAMT'=FBAMT,$G(FBACT)="C" S ^TMP("FBERR",$J,4,I)=""_U_FBPROG_U_+FBIEN(3)_U_+FBIEN(2)_U_+FBIEN(1)_U_+FBIEN
 N JJ F JJ=1:1:3 S DA(JJ)=+FBIEN(JJ)
 S DA=+FBIEN
 S DR=""
 I FBACT="C" S DR="12////^S X=$G(FBCKDT);35///^S X=FBCKNUM;40///^S X=FBDAMT;41///^S X=FBINAMT;36///@;37///@"
 I FBACT="B" S DR="12///@;35///@;36///@;37///@;40///@;41///@"
 I FBACT="X" S DR="12///@;40///@;41///@;36////^S X=FBXDT;37////^S X=$G(FBRCOD);38///^S X=FBXCOD" D
 .I FBXCOD'="R" S ^TMP("FBERR",$J,5,I)=""_U_FBPROG_U_+FBIEN(3)_U_+FBIEN(2)_U_+FBIEN(1)_U_+FBIEN
 .I FBXCOD="R" S DR=DR_";35///@"
 S DIE="^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"
 D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA)
 ; if EDI then add invoice to list in FBINV(, patch *61
 I FBACT'="B",$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,3)),U)]"" D
 . N FBAAIN
 . S FBAAIN=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0)),U,16)
 . I FBAAIN]"" S FBINV(3,FBAAIN)=""
 D KILL
 Q
 ;
5 ;update pharmacy payment record
 Q:'$D(^FBAA(162.1,+FBIEN(1),"RX",+FBIEN,0))  S FBAMT=+$P(^(0),U,16) D
 . I FBDAMT-FBINAMT'=FBAMT,$G(FBACT)="C" S ^TMP("FBERR",$J,4,I)=""_U_FBPROG_U_+FBIEN(1)_U_+FBIEN
 S DA(1)=+FBIEN(1),DA=+FBIEN
 S DR=""
 I FBACT="C" S DR="28////^S X=FBCKDT;30///^S X=FBCKNUM;34///^S X=FBDAMT;35///^S X=FBINAMT;31///@;32///@"
 I FBACT="B" S DR="28///@;30///@;31///@;32///@;34///@;35///@"
 I FBACT="X" S DR="28///@;34///@;35///@;31////^S X=FBXDT;32////^S X=$G(FBRCOD);33///^S X=FBXCOD" D
 .I FBXCOD'="R" S ^TMP("FBERR",$J,5,I)=""_U_FBPROG_U_+FBIEN(1)_U_+FBIEN
 .I FBXCOD="R" S DR=DR_";30///@"
 S DIE="^FBAA(162.1,"_DA(1)_",""RX"","
 D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FBAA(162.1,DA(1),"RX",DA)
 ; if EDI then add invoice to list in FBINV(, patch *61
 I FBACT'="B",$P($G(^FBAA(162.1,DA(1),0)),U,13)]"" D
 . N FBAAIN
 . S FBAAIN=$P($G(^FBAA(162.1,DA(1),0)),U)
 . I FBAAIN]"" S FBINV(5,FBAAIN)=""
 D KILL
 Q
 ;
9 ;update inpatient payment record
 Q:'$D(^FBAAI(+FBIEN,0))  S FBAMT=+$P(^(0),U,9) D
 .I FBDAMT-FBINAMT'=FBAMT,$G(FBACT)="C" S ^TMP("FBERR",$J,4,I)=""_U_FBPROG_U_+FBIEN
 S DA=+FBIEN
 S DR=""
 I FBACT="C" S DR="45////^S X=FBCKDT;48///^S X=FBCKNUM;52///^S X=FBDAMT;53///^S X=FBINAMT;49///@;50///@"
 I FBACT="B" S DR="45///@;48///@;49///@;50///@;52///@;53///@"
 I FBACT="X" S DR="45///@;52///@;53///@;49////^S X=FBXDT;50////^S X=$G(FBRCOD);51///^S X=FBXCOD" D
 .I FBXCOD'="R" S ^TMP("FBERR",$J,5,I)=""_U_FBPROG_U_+FBIEN
 .I FBXCOD="R" S DR=DR_";48///@"
 S DIE="^FBAAI("
 D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FBAAI(DA)
 ; if EDI then add invoice to list in FBINV(, patch *61
 I FBACT'="B",$P($G(^FBAAI(DA,3)),U)]"" D
 . N FBAAIN
 . S FBAAIN=$P($G(^FBAAI(DA,0)),U)
 . I FBAAIN]"" S FBINV(9,FBAAIN)=""
 D KILL
 Q
 ;
T ;update travel payment record
 Q:'$D(^FBAAC(+FBIEN(1),3,+FBIEN,0))  S FBAMT=+$P(^(0),U,3) D
 . I FBDAMT-FBINAMT'=FBAMT,$G(FBACT)="C" S ^TMP("FBERR",$J,4,I)=""_U_FBPROG_U_+FBIEN(1)_U_+FBIEN
 S DA(1)=+FBIEN(1),DA=+FBIEN
 S DR=""
 I FBACT="C" S DR="8////^S X=FBCKDT;9///^S X=FBCKNUM;13///^S X=FBDAMT;14///^S X=FBINAMT;10///@;11///@"
 I FBACT="B" S DR="8///@;9///@;10///@;11///@;13///@;14///@"
 I FBACT="X" S DR="8///@;13///@;14///@;10////^S X=FBXDT;11////^S X=$G(FBRCOD);12///^S X=FBXCOD" D
 .I FBXCOD'="R" S ^TMP("FBERR",$J,5,I)=""_U_FBPROG_U_+FBIEN(1)_U_+FBIEN
 .I FBXCOD="R" S DR=DR_";9///@"
 S DIE="^FBAAC("_+FBIEN(1)_",3,"
 D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FBAAC(DA(1),3,DA)
 D KILL
 Q
 ;
END ;clean and exit
 N XMSER,XMZ S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 K FB,FBPAID,FBSITE,FBAASN,FBSN,FBMCNT,I,XMER,XMREC,XMRG,XMY,^TMP("FBERR",$J),^TMP("FBPAID",$J),^TMP("FBREC",$J),X
KILL K FBLOCK,DIE,DA,DR,FBIEN,FBACT,FBCKNUM,FBRCOD,FBPROG,FBCKDT,FBXDT,FBXCOD,FBINAMT,FBDAMT,FBAMT,FBERR
 Q
