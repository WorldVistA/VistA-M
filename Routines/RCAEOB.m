RCAEOB ;ALB/CMS - AEOB FILE 433 CROSS-REF ROUTINE ; 16-JUN-00
V ;;4.5;Accounts Receivable;**63,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
AEOB ;File 433 Cross-Ref on Transaction Type AEOB
 ;     -used to alert pending EOB processing when Payment in Part
 ;      transaction is created for referred TP bills
 ;     -used to send MM to RC when Payment if Full is made
 N PRCABN,PRCAEN,RCAT
 I (X'=2)!($G(DA)<1) G AEOBQ
 S PRCABN=+$P($G(^PRCA(433,DA,0)),U,2) I 'PRCABN G AEOBQ
 D RCCAT^RCRCUTL(.RCAT)
 I '$G(RCAT(+$P($G(^PRCA(430,PRCABN,0)),U,2))) G AEOBQ
 I '$$REFST^RCRCUTL(PRCABN) G AEOBQ
 S ^PRCA(433,"AEOB",PRCABN,DA)=""
AEOBQ Q
 ;
SND ;Send RC a mail message about Payment in Full
 N PRCA,RCBDIV,RCWHO,RCXMB,X,XNDUZ,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y
 N RCCOM,RCDOM,RCSITE,RCSUB
 I $P($G(RCCAT(+$P(^PRCA(430,PRCABN,0),U,2))),U,1)'=1 Q
 D BNVAR^RCRCUTL(PRCABN)
 S Y=$G(^PRCA(433,PRCAEN,1))
 S RCXMB(2,0)=$G(PRCA("BNAME"),"UNK")_U_PRCAEN_U_+$P(Y,U,1)_U_+$P(Y,U,5)
 S RCSITE=$$SITE^RCMSITE
 D RCDIV^RCRCDIV(.RCDIV)
 I $G(RCDIV(0)) S RCBDIV=$$DIV^RCRCDIV(PRCABN)
 S X=0 F X=$O(RCDIV(X)) Q:'X  D
 .I X=+RCBDIV S RCDOM=$P(RCDIV(X),"^",6)
 .Q
 I $G(RCDOM)="" S RCDOM=$$RCDOM^RCRCUTL
 S XMDUZ=DUZ,(RCSUB,XMSUB)="AR/RC - "_$G(RCSITE,"UNK")_" FULL PAYMENT"
 S RCWHO=RCDOM,XMY(RCWHO)="",XMY(DUZ)=""
 S RCXMB(1,0)="$$RC$$FP$"_RCSITE_"$S.RC RC SERV"
 S RCXMB(3,0)="$$END$1$"
 S XMTEXT="RCXMB(" D ^XMD
 S RCCOM="Sent a Payment in Full Information to RC in MM# "_$G(XMZ)
 I $G(XMZ) D ENT^RCRCXMS(XMZ,RCSUB,RCWHO,RCCOM)
SNDQ Q
 ;RCAEOB
