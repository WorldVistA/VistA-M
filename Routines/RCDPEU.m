RCDPEU ;ALB/TMK - ELECTRONIC ERA UTILITIES ;05-NOV-02
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EFTMTCH ; Match an electronic EFT's deposit to a paper EOB's receipt record
 ; Select the receipt record.  Match the totals.
 N DIR,X,Y,RCDEP,DUOUT,DTOUT
 S DIR(0)="PAO^RCY(344.31,:AEMQ",DIR("S")="I $P($G(^(0),U,8)=0" ; must be unmatched
 S DIR("A")="Select EFT RECORD (Unmatched to an ERA): " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G MATCHQ2
 S RCDEP=+Y
MATCHQ2 Q
 ;
MATCH ; Manual start of ERA/EFT automatic matching
 D EN^RCDPEM(1,1)
 Q
 ;
ADJ(RC3444,RCADJ) ; Function-determines if ERA record contains adjustments
 ; RC3444 = ien of ERA entry in file 344.4
 ; Return value = 1 for ERA level adjustments found, 2 if claim level
 ;                      adjustments found, 3 if both found
 ; Also returns RCADJ(ERA ien,seq#)=bill # for claim level adjustments
 ;
 N Z,DA
 S RCADJ=0
 ;
 I $O(^RCY(344.4,RC3444,2,0)) S RCADJ=1  ;ERA level adjustment
 ;
 I 'RCADJ D  ; Claim level adjustment
 . S DA(1)=RC3444
 . S Z=0 F  S Z=$O(^RCY(344.4,RC3444,1,Z)) Q:'Z  I $P($G(^(Z,0)),U,14) S RCADJ=RCADJ+2,DA=Z,RCADJ(RC3444,Z)=$$GETBILL^RCDPESR0(.DA)
 ;
 Q RCADJ
 ;
DEPREC(RC3443) ; Returns the ien of the receipt for the EFT deposit RC3443
 ; RC3443 = ien of entry in file 344.3
 N Z
 S Z=+$P($G(^RCY(344.3,+RC3443,0)),U,3)
 S Z=+$O(^RCY(344,"AD",Z,0))
 Q Z
 ;
EDILB(RCRCPT) ;  Given receipt ien RCRCPT, return 1 if the receipt is for
 ; an EDI Lockbox deposit (EFT), 2 if for EDI Lockbox detail (EOB/ERA)
 ; or 0 if not EDI Lockbox related (paper check)
 N X,Z
 S Z=0
 S X=$$EDILBEV($P($G(^RCY(344,RCRCPT,0)),U,4))
 I X D
 . I $P($G(^RCY(344,RCRCPT,0)),U,6),$$EDILBDEP(+$P(^(0),U,6)) S Z=1 Q  ; EFT deposit associated with receipt
 . I '$P($G(^RCY(344,RCRCPT,0)),U,6) S Z=2 Q  ; EFT detail
 Q Z
 ;
EDILBDEP(RCDEP) ; Given deposit ien RCDEP (file 344.1), return 1 if there is
 ; an EFT referrencing it in file 344.3
 N X,Y
 S X=$O(^RCY(344.3,"ARDEP",RCDEP,0))
 Q (X>0)
 ;
EDILBEV(PAYTYP) ; Given ien of file 341.1 PAYTYP, return 1 if the pay type's
 ;  event number is EDI LOCKBOX
 Q ($P($G(^RC(341.1,+$G(PAYTYP),0)),U,2)=14)
 ;
LBEVENT() ; Returns the IEN of EDI Lockbox event 14 in file 341.1
 Q +$O(^RC(341.1,"AC",14,0))
 ;
HACERA(RCERA) ; Functions to determine if ERA entry in file 344.4 is an
 ; ERA received from HAC (CHAMPVA)
 ; RCERA = ien of entry file 344.4
 ; Returns 1 if it is, 0 if not
 N X
 S X=0 ; Add code here to make the determination
 Q X
 ;
HACEFT(RCEFT) ; Functions to determine if EFT entry in file 344.3 is an
 ; EFT received from HAC (CHAMPVA)
 ; RCEFT = ien of entry file 344.3
 ; Returns 1 if it is, 0 if not
 Q ($E($P($G(^RCY(344.3,+RCEFT,0)),U,6),1,3)="HAC")
 ;
