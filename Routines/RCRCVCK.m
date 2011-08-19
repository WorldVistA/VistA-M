RCRCVCK ;ALB/CMS - TP POSSIBLE REFERRAL LIST CHECK ; 09/02/97
V ;;4.5;Accounts Receivable;**63,122,189**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
EN ;Entry point from protocol
 N PRCABN,RCA,RCMSG,RCOK,RCY S RCY=0,RCA=""
 D FULL^VALM1
 I '$O(^TMP("RCRCVL",$J,"SEL",RCY)) W !!,"NOTHING TO VALIDATE!",!,"No selected items from list." G ENQ
 W !!,"Checking all bill(s) on highlighted Selection List "
 F  S RCY=$O(^TMP("RCRCVL",$J,"SEL",RCY)) Q:'RCY  D
 .S PRCABN=$P($G(^TMP("RCRCVLX",$J,RCY)),U,2)
 .I 'PRCABN Q
 .S RCMSG=""
 .D CHK(PRCABN,.RCMSG,0)
 .I RCMSG]"" S RCA(PRCABN,RCY)=RCMSG
 .W "."
 ;
 I '$O(RCA(0)) W !,"Everything is Okay!" G ENQ
 D CHKD
ENQ D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
RCINFO(PRCABN) ; get new info for *189 to refer bills
 N DIE,DA,DR
 W !,"Bill No.: ",$P($G(^PRCA(430,PRCABN,0)),"^")
 S DIE="^PRCA(430,",DA=PRCABN,DR="[PRCAC RC INFO]" D ^DIE
 S PRCA("REF REASON")=$P($G(^PRCA(430,PRCABN,6)),"^",22,23)
 I PRCA("REF REASON")'["^" S PRCA("REF REASON")=PRCA("REF REASON")_"^"
 Q
 ;
CHK(PRCABN,COM,RCS) ;Validate Bill for Electronic Referral
 ;Return: COM Comments if didn't pass
 ;Return: RCCAT(,DFN,PRCA(,VA(,VADM(,VAPD( if transmitting
 N I,RCY,X,Y
 ;if calling from RCRCXM1 do not new variables 
 I 'RCS N DFN,PRCA,RCCAT,VA,VADM,VAPA
 D RCCAT^RCRCUTL(.RCCAT)
 D BNVAR^RCRCUTL(PRCABN)
 I '$G(PRCABN) S COM="Not a valid Bill Number." G CHKQ
 I '$G(PRCA("CAT")) S COM="Bill Category not entered." G CHKQ
 I +PRCA("STATUS")'=16 S COM="Bill Status is not Active." G CHKQ
 D DEBT^RCRCUTL(PRCABN)
 I $G(PRCA("DEBTNM"))="" S COM="No Debtor Name." G CHKQ
 I "ZZzzZ-z-"[$E(PRCA("DEBTNM"),1,2) S COM="Debtor Name starts with "_$E(PRCA("DEBTNM"),1,2) G CHKQ
 S DFN=+$P(^PRCA(430,PRCABN,0),U,7)
 I 'DFN S COM="No Patient Information." G CHKQ
 D DEM^VADPT,ADD^VADPT
 I "ZZzzZ-z-"[$E(VADM(1),1,2) S COM="Patient name starts with "_$E(VADM(1),1,2) G CHKQ
 I $E(VADM(2),1,5)="00000" S COM="Test Patient." G CHKQ
 S RCY=$$BILL^RCJIBFN2(PRCABN)
 I '$P(RCY,U,3) S COM="No Current Balance." G CHKQ
 I $G(^DGCR(399,PRCABN,0))="" S COM="No Bill Claim Information." G CHKQ
 I 'RCS,$G(RCCAT(+PRCA("CAT")))'=1 S COM=$P(PRCA("CAT"),U,2)_" bills can be referred, but not electronically."
 D RCINFO(PRCABN) I 'PRCA("REF REASON") S COM="RC Referal Reason Code is REQUIRED" G CHKQ
 I +PRCA("REF REASON")=5,'$L($P(PRCA("REF REASON"),"^",2)) S COM="Referral Comments is REQUIRED for RC Reason Code 5" G CHKQ
 S COM=""
CHKQ I COM]"" S COM=$G(PRCA("BNAME"))_"  -  "_COM
 Q
 ;
CHKD ;Display invalid bills and message from RCA array
 ;Ask user what they want to do with bad referral
 N PRCABN,RCY
 S PRCABN=0 F  S PRCABN=$O(RCA(PRCABN)) Q:('PRCABN)!($G(RCOUT))  D
 .S RCY=0 F  S RCY=$O(RCA(PRCABN,RCY)) Q:('RCY)!($G(RCOUT))  D
 ..W !!!,"Item ",RCY,".  ",RCA(PRCABN,RCY)
 ..D UNSEL^RCRCVLE(RCY)
CHKDQ Q
 ;RCRCVCK
