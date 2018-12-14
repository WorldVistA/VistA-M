RCDPEM21 ;ALB/TMK/PJH - MANUAL MATCH TO PAPER EOB ;Jun 11, 2014@13:24:36
 ;;4.5;Accounts Receivable;**173,208,276,284,293,298,303,304,321,326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; Called from [RCDPE ERA POSTED BY PAPER EOB]
 ;
 ; Begin PRCA*4.5*276 - PJH
POSTED ;
 N DIR,X,Y
 S DIR("A")="Select type of receipt to ERA link"
 S DIR("B")="M"
 S DIR(0)="S^M:Manually select receipt to post;"
 S DIR(0)=DIR(0)_"A:Automatic search for receipt to post"
 D ^DIR K DIR
 I Y="M" D MANUAL Q
 I Y="A" D AUTO
 Q
 ;
MANUAL ; Mark an ERA as posted when the data
 ; was previously posted using paper EOB information
 N DIC,DIE,DIR,DA,DR,ERA,RCPT,X,Y,%
 ; Must be unmatched or matched to paper check, must be accepted by FMS, must not be posted yet
 W !!,"THIS OPTION IS USED WHEN YOU HAVE POSTED AN ERA PAID WITH A PAPER CHECK",!,"BY USING THE PAPER EOB AND YOU DID NOT REFERENCE THE ERA IN THE RECEIPT",!!
MAN1 S DIC("S")="I ""02""[+$P(^(0),U,9),$P(^(0),U,14)=0",DIC="^RCY(344.4,",DIC(0)="AEMQ"
 D ^DIC K DIC
 ;
 I Y'>0 G MANUALQ
 ;
 ;Check if ERA is already linked to a receipt
 I $$RCHECK(+Y) G MAN1
 S ERA=+Y
 ;
 S DIC="^RCY(344,",DIC(0)="AEMQ",DIC("A")="RECEIPT: ",DIC("S")="I $$FMS^RCDPEM21(Y,0)"
 D ^DIC K DIC
 I Y'>0 G MANUALQ
 S RCPT=+Y
 ;
 D NOW^%DTC
 ;Update Receipt #, EFT Match Status, Detail Post Status and Paper EOB
 S DIE="^RCY(344.4,",DR=".08////"_RCPT_";.09////2;.14////2;20.03////1",DA=ERA
 ;Update Date/Time Posted and User fields
 S DR=DR_";7.01///"_%_";7.02///"_DUZ
 D ^DIE
 I '$D(Y) D
 . S DIR(0)="EA",DIR("A",1)="ERA HAS BEEN MARKED AS POSTED USING PAPER EOB",DIR("A")="Press ENTER to continue: " D ^DIR K DIR
 ;
MANUALQ Q
 ;
 ;VISN 15 software - created by Karen Flores
 ;
AUTO ;Select ERA's for linking to receipt
 N EXIT
 S EXIT=0 F  D LNKERA Q:EXIT
 Q
 ;
RCHECK(RCSCR) ;Check if already linked to a receipt
 N REC,RNUM,RNAM,AMT
 S REC=$G(^RCY(344.4,RCSCR,0)),RNUM=$P(REC,U,8)
 ;Ignore check if zero amount ERA
 Q:'$P(REC,U,5) 0
 ;Check if already linked to a different receipt
 Q:'RNUM 0
 S RNAM=$P($G(^RCY(344,RNUM,0)),U)
 W !!,"ERA ",RCSCR," is already linked to receipt ",RNAM,!
 Q 1
 ;
LNKERA ;Select ERA
 N ABORT,DIC,DUOUT,DTOUT,REC,RCSCR,X,Y
 ;Must be unposted and either unmatched or matched to paper check
 S DIC("S")="I ""02""[+$P(^(0),U,9),$P(^(0),U,14)=0"
 S DIC="^RCY(344.4,",DIC(0)="AEMQ" W ! D ^DIC K DIC
 S RCSCR=+Y I RCSCR'>0 S EXIT=1 Q
 ;Check if already linked to a different receipt
 Q:$$RCHECK(RCSCR)
 ;
 ;Finds receipt automatically from AR TRANSACTION file #433 
 N AMT,ART,ARTND1,ATTY,BILL,EOB,EOBND,FOUND,RCND,RCSCR1,RECEPT,TAMT
 N TRACE
 ;Trace# from ERA
 S TRACE=$P($G(^RCY(344.4,RCSCR,0)),U,2)
 ;Clear workfile
 K ^TMP("RCDPEM2",$J)
 ;
 S (FOUND,ABORT,RCSCR1)=0
 ;Scan claim lines in ERA for non zero bills
 F  S RCSCR1=$O(^RCY(344.4,RCSCR,1,RCSCR1)) Q:+RCSCR1=0!(FOUND)  D
 .S RCND=$G(^RCY(344.4,RCSCR,1,RCSCR1,0))
 .;Ignore bill if AMOUNT PAID is zero
 .S AMT=$P(RCND,"^",3) Q:+AMT=0
 .;Ignore if EOB has no EOB detail record
 .S EOB=+$P(RCND,"^",2) Q:'EOB
 .;Get EOB detail record
 .S EOBND=$G(^IBM(361.1,EOB,0))
 .;Extract Bill number from EOB detail
 .S BILL=$P(EOBND,"^",1) Q:BILL=""
 .;Ignore duplicate bills on ERA
 .Q:$D(^TMP("RCDPEM2",$J,BILL))
 .S ^TMP("RCDPEM2",$J,BILL)=""
 .;Search AR TRANSACTION file #433 for the bill - newest first
 .S ART=""
 .F  S ART=$O(^PRCA(433,"C",BILL,ART),-1) Q:+ART=0!(FOUND)  D
 ..S ARTND1=$G(^PRCA(433,ART,1))
 ..;Get transaction type
 ..S ATTY=$P(ARTND1,"^",2) Q:'ATTY
 ..;Ignore if not a payment
 ..S ATTY=$P($G(^PRCA(430.3,ATTY,0)),"^",1) Q:ATTY'["PAYMENT"
 ..;Get receipt number
 ..S RECEPT=$P(ARTND1,"^",3) Q:RECEPT=""
 ..;Ignore receipt if status is not 'ACCEPTED BY FMS'
 ..Q:'$$FMS(RECEPT,1)
 ..W !!,"PATIENT: "_$$PNM4^RCDPEWL1(RCSCR,RCSCR1)
 ..W !,"Bill number: ",$P($G(^DGCR(399,BILL,0)),U)
 ..W !,"Check #: ",$$CHQ(RECEPT,BILL)
 ..W !,"Trace #: ",TRACE
 ..W !,"DOS: ",$$FMTE^XLFDT($P($G(^DGCR(399,BILL,0)),U,3))
 ..S TAMT=+$P(ARTND1,"^",5)
 ..W !,"AR Transaction amount: ",TAMT
 ..W !,"RECEIPT#: ",RECEPT
 ..W !,"Date of Receipt: ",$$FMTE^XLFDT($$RCDATE^RCDPRU(RECEPT))
 ..W !,"Total Receipt AMOUNT: ",$J($$AMT^RCDPRU(RECEPT),2,2),!
 .. ; PRCA*4.5*284 Change default response from YES to NO
 ..S DIR(0)="Y",DIR("B")="NO"
 ..S DIR("A")="Link to update Remittance entry # "_RCSCR
 ..S DIR("A")=DIR("A")_" with receipt "_RECEPT
 ..D ^DIR K DIR
 ..;Aborted
 ..I $D(DUOUT)!$D(DTOUT) S ABORT=1,FOUND=1 Q
 ..;Attempt to update ERA - finish if successful
 ..I +Y>0 D UPDERA(RCSCR,RECEPT,.FOUND)
 ;Update failed
 I FOUND=0 W !!,"No matching payment transactions found for this ERA"
 ;Clear workfile
 K ^TMP("RCDPEM2",$J)
 Q
 ;
 ; Moved to RCDPRU because of size issues PRCA*4.5*303
UPDERA(DA,RECEPT,FOUND) ;Mark ERA as posted to paper EOB
 D UPDERA^RCDPRU(DA,RECEPT,.FOUND)
 Q FOUND
 ;
 ;Check FMS status
FMS(RECEPT,FLG) ;
 ; FLG = 1 if RECEPT contains receipt number
 ; FLG = 0 if RECEPT contains ien of the receipt
 N FMSDOCNO,RCRECTDA,RES
 S RES=0 I $G(RECEPT)="" G FMSX
 ;Get receipt IEN
 I 'FLG S RCRECTDA=RECEPT
 I FLG S RCRECTDA=$O(^RCY(344,"B",RECEPT,0))
 I 'RCRECTDA G FMSX
 ;Get FMS document number
 S FMSDOCNO=$$FMSSTAT^RCDPUREC(RCRECTDA)
 ;Ignore if not accepted
 I $P(FMSDOCNO,U,2)'="ACCEPTED BY FMS" G FMSX
 ;Otherwise can be linked
 S RES=1
FMSX ;
 Q RES
 ;
CHQ(RECEPT,BILL) ;Get check number for this bill
 N RCRECTDA,RCTRAN,RCCHK,PATBILL
 ;Get receipt IEN
 S RCRECTDA=$O(^RCY(344,"B",RECEPT,0)) Q:'RCRECTDA ""
 ;Scan Receipt looking for this bill IEN
 S RCTRAN=0,RCCHK=""
 F  S RCTRAN=$O(^RCY(344,RCRECTDA,1,RCTRAN)) Q:'RCTRAN  D  Q:RCCHK]""
 .;Check for match on bill IEN
 .S PATBILL=$P($G(^RCY(344,RCRECTDA,1,RCTRAN,0)),U,3)
 .;Ignore Patient pointers or null field
 .Q:$P(PATBILL,";",2)'="PRCA(430,"
 .;Compare bill IEN399 to IEN430
 .Q:$P(PATBILL,";")'=BILL
 .;Get check number for this line
 .S RCCHK=$P($G(^RCY(344,RCRECTDA,1,RCTRAN,0)),U,7)
 Q RCCHK
 ;
 ;; End PRCA*4.5*276 - PJH
 ;
