IBCEMU4 ;ALB/ESG - MRA UTILITIES ;25-OCT-2004
 ;;2.0;INTEGRATED BILLING;**288**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
DENDUP(IBEOB) ; Denied for Duplicate Function
 ; Function returns true if MRA is Denied AND Reason code 18 is present (Duplicate claim/service)
 NEW IBX,IBM,LINE,DUP,ADJ
 S IBX=0,IBM=$G(^IBM(361.1,+$G(IBEOB),0))
 I $P(IBM,U,4)'=1 G DENDUPX    ; not an MRA
 I $P(IBM,U,13)'=2 G DENDUPX   ; not Denied
 ;
 ; check line item adjustments for reason code 18
 S LINE=0,DUP=0
 F  S LINE=$O(^IBM(361.1,IBEOB,15,LINE)) Q:'LINE  D  Q:DUP
 . S ADJ=0
 . F  S ADJ=$O(^IBM(361.1,IBEOB,15,LINE,1,ADJ)) Q:'ADJ  D  Q:DUP
 .. I $D(^IBM(361.1,IBEOB,15,LINE,1,ADJ,1,"B",18)) S DUP=1 Q
 .. Q
 . Q
 ;
 I DUP S IBX=1
DENDUPX ;
 Q IBX
 ;
