RCRCACP ;ALB/CMS - RC THIRD PARTY REFERRAL ACTION CODE LIST ; 06-JUN-00
V ;;4.5;Accounts Receivable;**63,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
TCD ;view of TRANSACTION CODE list
 NEW RCDA,RCY,RC0,X S (VALMCNT,X)=""
 K ^TMP("RCRCAC",$J)
 S RCDA=0 F  S RCDA=$O(^RCT(349.4,RCDA)) Q:'RCDA  D
 .S RC0=^RCT(349.4,RCDA,0)
 .I $P(RC0,U,1)="PP" Q
 .S VALMCNT=+$G(VALMCNT)+1
 .S RCY=VALMCNT,X=$$SETFLD^VALM1(RCY,X,"NUMBER")
 .S RCY=$P(RC0,U,1),X=$$SETFLD^VALM1(RCY,X,"CODE")
 .S RCY=$P(RC0,U,2),X=$$SETFLD^VALM1(RCY,X,"NAME")
 .S ^TMP("RCRCAC",$J,VALMCNT,0)=X
 .S ^TMP("RCRCAC",$J,"IDX",VALMCNT,VALMCNT)=RCDA
 .Q
 I VALMCNT=0 S VALMSG="NOTHING TO REPORT"
TCDQ Q
 ;
TRD(D0) ;Display Transaction Profile
 N DXS,J,I,PRCAIO,PRCAIO,PRCATYP,X,Y,Z
 S PRCAIO=IO,PRCAIO(0)=IO(0)
 W @IOF,!,?12,"TRANSACTION PROFILE",!
 D ^PRCATR3,ENF^IBOLK
 W !!
TRDQ Q
 ;
EOB ;Process the EOB Codes
 N CNT,D,DA,DIC,DIE,DR,PRCA,PRCABN,PRCABN0,PRCAEN,PRCATN,RCCAT,RCCOM,RCCNT,RCOUT,RCSEL,RCXMB,RCY,X,XMZ,Y
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT S RCOUT=0
 D FULL^VALM1
 I '$O(^TMP("RCRCBL",$J,"SEL",0)) W !!,"NO PAYMENT TRANSACTION SELECTED !!",! G EOBQ
 I '$O(^PRCA(433,"AEOB",0)) W !!,"ALL TP BILLS ARE PROCESSED !!" G EOBQ
 D RCCAT^RCRCUTL(.RCCAT) K DIR
 S RCSEL=0 F  S RCSEL=$O(^TMP("RCRCBL",$J,"SEL",RCSEL)) Q:('RCSEL)!(RCOUT=1)  S RCCNT=$G(^(RCSEL)) D
 .S PRCATN=+$P($G(^TMP("RCRCBLX",$J,RCSEL)),U,2),RCCNT=+RCCNT
 .S PRCABN=$P($G(^PRCA(433,PRCATN,0)),U,2)
 .I '$D(^PRCA(433,"AEOB",PRCABN,PRCATN)) W !!," Item ",RCSEL,".  Transaction Number ",PRCATN,"  is processed.",! D PAUSE^VALM1 Q
 .D BNVAR^RCRCUTL(PRCABN)
 .D TRD(PRCATN)
 .S DA=PRCATN,DIE(0)="AQEZ",DIE="^PRCA(433,",DR="54" D ^DIE
 .K DIR W ! S DIR("A")="Ready to process payment information"
 .S DIR("?")="Enter 'Yes' to transmit the payment to RC and update the referral amount."
 .D ASK K DIR I $G(Y)="^" S RCOUT=1
 .I ($G(Y)'=1)!(RCOUT=1) S ^PRCA(433,"AEOB",+PRCABN,+PRCATN)="" Q
 .S RCCOM=$P($G(^PRCA(433,PRCATN,5)),U,4)
 .I RCCOM]"" S RCCOM="Payment EOB CODE: "_RCCOM D COM^RCRCRT(PRCATN,RCCOM)
 .S DA=PRCABN,DIE="^PRCA(430,",DR="66///^S X="_+$G(^PRCA(430,PRCABN,7)) D ^DIE
 .K ^PRCA(433,"AEOB",PRCABN,PRCATN)
 .D FLDTEXT^VALM10(RCSEL,"DEBTOR","Processed      ")
 .I $P($G(RCCAT(+$P(^PRCA(430,PRCABN,0),U,2))),U,1)'=1 Q
 .S Y=$G(^PRCA(433,PRCATN,1))
 .S RCXMB(2,0)=$G(PRCA("BNAME"),"UNK")_U_PRCATN_U_$P($P(Y,U,9),".",1)_U_+$P(Y,U,5)
 .S RCXMB(3,0)="EOB^"_$P($G(^PRCA(433,PRCATN,5)),U,4)
 .D EOBS
 .S RCCOM="Payment information sent to RC in MM# "_$G(XMZ) D COM^RCRCRT(PRCATN,RCCOM)
 .Q
EOBQ I $G(RCOUT)=1,$O(^PRCA(433,"AEOB",0)) D
 .W !!," NOTICE: All bills pending EOB processing should be processed inorder"
 .W !,?9,"to electronically send Partial Payment information to Regional Counsel"
 .W !,?9,"and update the bill referral amount.  Not processing may cause the"
 .W !,?9,"referral amount to be out-of-balance with Regional Counsel.",!
 D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
EOBS ;Send Partial Payment data to RC
 N RCBDIV,RCCOM,RCDIV,RCDOM,RCSITE,RCSUB,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,X,Y
 I '$O(RCXMB(0)) G EOBSQ
 S RCSITE=$$SITE^RCMSITE
 D RCDIV^RCRCDIV(.RCDIV)
 I $O(RCDIV(0)) S RCBDIV=$$DIV^IBJDF2(PRCABN) S X=0 F  S X=$O(RCDIV(X)) Q:'X  D
 .I X=+RCBDIV S RCDOM=$P(RCDIV(X),U,6)
 I $G(RCDOM)="" S RCDOM=$$RCDOM^RCRCUTL
 S XMDUZ=DUZ,(RCSUB,XMSUB)="AR/RC - "_$G(RCSITE,"UNK")_" PARTIAL PAYMENT"
 S RCWHO=RCDOM,XMY(RCWHO)="",XMY(DUZ)=""
 S RCXMB(1,0)="$$RC$PP$$"_RCSITE_"$S.RC RC SERV"
 S RCXMB(4,0)="$END$1$"
 S XMTEXT="RCXMB(",XMCHAN=1 D ^XMD
 S RCCOM="Sent Payment Transaction to RC in MM# "_$G(XMZ)
 I $G(XMZ) D ENT^RCRCXMS(XMZ,RCSUB,RCWHO,RCCOM)
 W !!,?10,RCCOM,!
EOBSQ Q
 ;
ASK ;Ask Yes or No Caller send DIR("A"),DIR("?")
 N DIROUT,DUOUT,DTOUT,DIRUT
 S DIR(0)="Y",DIR("B")="Yes" D ^DIR
ASKQ Q
 ;
REQ ;Transmit a Action Request to RC
 N DIR,PRCABN,RCCOM,RCY,VALMCNT,VALMY,X,Y
 I '$O(^TMP("RCRCAL",$J,"SEL",0)) W !,"NO BILLS SELECTED!",!,"No selected items from Bill List" G REQQ
 D EN^VALM2($G(XQORNOD(0)),"SO") I '$O(VALMY(0)) G REQQ
 D FULL^VALM1
 S RCCOM=$G(^TMP("RCRCAC",$J,+$O(VALMY(0)),0))
 W !!,"You Selected: "_RCCOM
 W !!,"This action creates an AR Comment Transaction requesting that a "_RCCOM
 W !,"action be applied by Regional Counsel to the bills on the highlighted"
 W !,"selection list. You can then edit the Comment Transaction request"
 W !,"and transmit the request to RC.",!
 ;
 S RCCOM=^TMP("RCRCAC",$J,"IDX",+RCCOM,+RCCOM),RCCOM=$P($G(^RCT(349.4,+RCCOM,0)),U,1)
 S RCCOM="I am requesting that a "_RCCOM_" be applied to this bill."
 K DIR S DIR("A")="Okay to Create a Comment Transaction "
 S DIR("?")="Enter Yes to create a Comment Transaction or No to exit."
 D ASK K DIR I $G(Y)'=1 G REQQ
 K ^TMP("RCRCAC",$J,"XM")
 S RCY=0 F  S RCY=$O(^TMP("RCRCAL",$J,"SEL",RCY)) Q:'RCY  D
 .S PRCABN=+$P($G(^TMP("RCRCALX",$J,RCY)),U,2),PRCAEN=0
 .D CCOM
 .Q
 I '$O(^TMP("RCRCAC",$J,"XM",0)) G REQQ
 K DIR S DIR("A")="Send Request to RC now ",DIR("?")="Enter Yes if to transmit the created Comment entries"
 D ASK I $G(Y)=1 D SND
 ;
REQQ K ^TMP("RCRCAC",$J,"XM")
 K DIR D PAUSE^VALM1 S XQORM("B")="Quit",VALMBCK="R"
 Q
 ;
CCOM ;Create Comment Transaction
 ;Input: PRCABN
 N DA,DIC,DIE,DR,D0,PRCA,PRCABN0,PRCAD,PRCAEN,PRCAMT,X,Y
 S PRCABN0=$G(^PRCA(430,+$G(PRCABN),0))
 I 'PRCABN0 W !,PRCABN_" NOT A VALID AR BILL!",! G CCOMQ
 W !!,"Bill No. # "_$P(PRCABN0,U,1)
 D SETTR^PRCAUTL,PATTR^PRCAUTL
 I '$D(PRCAEN) W "COULD NOT CREATE A TRANSACTION AT THIS TIME!",!,"Try again later." G CCOMQ
 I $G(RCCOM)]"" D COM^RCRCRT(PRCAEN,RCCOM)
 S DIE="^PRCA(433,",DA=PRCAEN,DR="[PRCA COMMENT]" D ^DIE
 S DR="4////^S X=2" D ^DIE
 S ^TMP("RCRCAC",$J,"XM",PRCABN,PRCAEN)=""
CCOMQ Q
 ;
SND ;Send data to RC
 N PRCABN,PRCAEN,PRCA,RCXCNT,X,Y,RCSITE,RCDIV,RCDOM,RCBDIV
 K ^TMP("RCRCAT",$J,"XM") S RCXCNT=0
 S RCSITE=$$SITE^RCMSITE
 D RCDIV^RCRCDIV(.RCDIV)
 S PRCABN=0 F  S PRCABN=$O(^TMP("RCRCAC",$J,"XM",PRCABN)) Q:'PRCABN  D
 .D BNVAR^RCRCUTL(PRCABN)
 .D DEBT^RCRCUTL(PRCABN)
 .S PRCAEN=0 F  S PRCAEN=$O(^TMP("RCRCAC",$J,"XM",PRCABN,PRCAEN)) Q:'PRCAEN  D
 ..D SET^RCRCAT1
 ..I $G(RCDIV(0)) S RCBDIV=$$DIV^IBJDF2(PRCABN) S X=0 F  S X=$O(RCDIV(X)) Q:'X  D
 ...I X=+RCBDIV S RCDOM=$P(RCDIV(X),"^",6)
 I $G(RCDOM)="" S RCDOM=$$RCDOM^RCRCUTL
 D SEND^RCRCAT
 K ^TMP("RCRCAT",$J,"XM")
SNDQ Q
 ;RCRCACP
