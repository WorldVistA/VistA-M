RCRCVXM ;ALB/CMS - AR/RC ORIG BILL TRANSMISSION ; 16-JUN-00
V ;;4.5;Accounts Receivable;**63,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ORIGINAL BILL TRANSPORT
 ;
 Q
EN ;Entry from Protocol to Refer bills to RC
 N DIR,LN,PRCABN,RCA,RCCNT,RCCOM,RCDOM,RCMSG,RCSITE,RCY,X,Y S RCCNT=0,LN=4
 D FULL^VALM1
 I '$O(^TMP("RCRCVL",$J,"SEL",0)) W !!,"NOTHING TO REFER!",!,"No selected items from list." G ENQ
 W !! S DIR("A",1)="Referring all bill(s) on highlighted Selection List "
 S DIR("A",2)=" ",DIR("A",3)="This action will:"
 S DIR("A",4)="Create a 'Refer to RC' or 'Re-establish Referral' AR Transaction,"
 S DIR("A",5)="electronically transmit transferable bills to RC,"
 S DIR("A",6)="list bills that did not pass the validation check and did not transmit,"
 S DIR("A",7)="then mark the highlighted bills as referred."
 S DIR("A",8)="  "
 S DIR("A")="Okay to Continue: "
 D ASK^RCRCACP I Y'=1 G ENQ
 S RCY=0 F  S RCY=$O(^TMP("RCRCVL",$J,"SEL",RCY)) Q:'RCY  D
 .S PRCABN=$P($G(^TMP("RCRCVLX",$J,RCY)),U,2) W "."
 .I 'PRCABN Q
 .K ^TMP("RCRCVL",$J,"XM",PRCABN)
 .;  - Validate bill and save variables
 .S RCMSG="" D CHK^RCRCVCK(PRCABN,.RCMSG,1)
 .I RCMSG]"" S RCA(PRCABN,RCY)=RCMSG Q
 .D IBS^RCRCXM1
 .Q
 ;
 ; - If nothing to send go write message on screen
 I '$O(^TMP("RCRCVL",$J,"XM",0)) G ENW
 ;
 ; - create E-Mail and send off S RCCOM
 D SEND
 ;
 ; - update AR Transaction,430 Referral Date and LM Screen
 D ARUP
 ;
 ; - list bills that did not go
ENW I $O(RCA(0)) W !!,"Did not Refer the following bills",! D
 .S PRCABN=0 F  S PRCABN=$O(RCA(PRCABN)) Q:'PRCABN  D
 ..S RCY=0 F  S RCY=$O(RCA(PRCABN,RCY)) Q:'RCY  D
 ...W !,"Item ",RCY,".  ",RCA(PRCABN,RCY)
 ...;I $Y>(IOSL+3) D PAUSE^VALM1 W @IOF
 ;
ENQ K DIR D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
SEND ;Send bills in mail message
 N DATA,II,LN,PRCABN,RCCNT,RCBDIV,RCI,RCSUB,RCWHO,RETRY
 N XNDUZ,XMSUB,XMTEXT,XMY,XMZ,X,Y
 S (RCCNT,PRCABN)=0 F  S PRCABN=$O(^TMP("RCRCVL",$J,"XM",PRCABN)) Q:(RCCNT)!('PRCABN)  D
 .S II=0 F  S II=$O(^TMP("RCRCVL",$J,"XM",PRCABN,II)) Q:(RCCNT)!('II)  D
 ..S RCCNT=RCCNT+1
 I RCCNT=0 G SENDQ
 S (RCCNT,RETRY)=0,RCCOM=""
 S RCSITE=$$SITE^RCMSITE
 I $O(RCDIV(0)) S RCDOM=$P($G(RCDIV(+$P($G(RCDIV(0)),U,3))),U,6)
 I $O(^TMP("RCDOMAIN",$J,0)) S RCDOM=$P(^TMP("RCDOMAIN",$J,+$P($G(^TMP("RCDOMAIN",$J,0)),U,3)),U,6)
 I $G(RCDOM)="" S RCDOM=$$RCDOM^RCRCUTL
SNDA ;Come back here if didn't go to mail man
 S (XMDUN,XMDUZ)=DUZ
 S (RCSUB,XMSUB)="AR/RC - "_$G(RCSITE,"UNK")_" ORIGINAL BILL TRANSMISSION"
 D XMZ^XMA2 I $G(XMZ)<1 S RETRY=RETRY+1 I RETRY<100 G SNDA
 I $G(XMZ)<1 G SENDQ
 S RCWHO=RCDOM
 S XMY(RCWHO)="",XMY(DUZ)=""
 S ^XMB(3.9,XMZ,2,0)="^3.92^1^1^"_DT
 S ^XMB(3.9,XMZ,2,1,0)="$$RC$OB$$"_RCSITE_"$S.RC RC SERV"
 S PRCABN=0,LN=1 F  S PRCABN=$O(^TMP("RCRCVL",$J,"XM",PRCABN)) Q:'PRCABN  D
 .I $O(^TMP("RCRCVL",$J,"XM",PRCABN,0)) S RCCNT=RCCNT+1
 .S II=0 F  S II=$O(^TMP("RCRCVL",$J,"XM",PRCABN,II)) Q:'II  D
 ..S RCI=0 F  S RCI=$O(^TMP("RCRCVL",$J,"XM",PRCABN,II,RCI)) Q:'RCI  D
 ...S DATA=$G(^TMP("RCRCVL",$J,"XM",PRCABN,II,RCI))
 ...I DATA="" Q
 ...S LN=LN+1
 ...S ^XMB(3.9,XMZ,2,LN,0)=DATA
 ;
 S ^XMB(3.9,XMZ,2,LN+1,0)="$END$"_LN_"$"_RCCNT_"$"
 D ENT1^XMD
 W !!,"Message #",XMZ," Transmitted ",$G(RCCNT,0)," bill(s)."
 S RCCOM="Message contains "_+$G(RCCNT)_" bill(s)."
 D ENT^RCRCXMS(XMZ,RCSUB,RCWHO,.RCCOM)
SENDQ Q
 ;
ARUP ;Update AR with information
 N PRCABN,RCY
 S PRCABN=0 F  S PRCABN=$O(^TMP("RCRCVL",$J,"XM",PRCABN)) Q:'PRCABN  D
 .D REF^RCRCRT
 .; - Reset field in List Template
 .S RCY=^TMP("RCRCVL",$J,"XM",PRCABN,0)
 .D FLDTEXT^VALM10(RCY,"REFER","r")
 .Q
ARUPQ Q
 ;
 ;RCRCVXM
