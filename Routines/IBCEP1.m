IBCEP1 ;ALB/TMP - EDI UTILITIES for provider ID ;13-DEC-99
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
CAREID(IBFUNC,IBSEQ,IBIFN) ; Help text for a claim to determine the
 ; specific care unit needed for a given insurance co
 ; IBFUNC = "PERF" if looking for performing provider
 ;        = "EMC" if looking for EMC provider #
 ; IBSEQ = the number of the COB sequence for the insurance co
 ; IBIFN = the ien of the bill in file 399
 N Z,Z0,Z1,Z2
 S Z0=$$INSSEQ(IBIFN,IBSEQ)
 S Z1=$S(IBFUNC="PERF":"performing provider id",1:"EMC id")
 S Z=$P($G(^DIC(36,+Z0,4)),U,$S(IBFUNC="PERF":9,1:8))
 S Z2=$$PPTYP^IBCEP0(Z0)
 I $O(^IBA(355.96,"AC",Z0,Z2,0)) D
 . D EN^DDIOL("This insurance company needs a care unit "_$S(Z'="":"("_Z_") ",1:"")_"for their "_Z1)
 E  D
 . D EN^DDIOL("This insurance company does not need a care unit for their "_Z1)
 Q
 ;
INSSEQ(IBIFN,IBSEQ) ; Returns the ien of the insurance co for the COB
 ; sequence IBSEQ on bill ien IBIFN
 ; Returns 0 if no insurance co found
 Q +$$FINDINS^IBCEF1(IBIFN,IBSEQ)
 ;
DUP(IBFLD,DA) ; Test if there is a duplicate record already on file (355.9)
 ; Function returns 1 if dup found, 0 if no dup found
 ; IBFLD = ien of the field being checked
 ; DA = the ien of the record being checked
 N DUP,Q,S1,S2,S3,S4,S5,S6,Z,Z0
 S Q=$G(^IBA(355.9,+DA,0)),DUP=0
 S S1=$S(IBFLD=.01:X,1:$P(Q,U))
 S S2=$S(IBFLD=.02:X,1:$P(Q,U,15)),Z=$$EXPAND^IBTRE(355.9,.02,S2) S:Z="" Z="ALL INSURANCE CO" S:S2="" S2="*ALL*"
 S S3=$S(IBFLD=.03:X,1:$P(Q,U,16)),Z0=$$EXPAND^IBTRE(355.9,.03,S3) S:Z0="" Z0="ALL CARE UNITS"
 S S4=$S(IBFLD=.04:X,1:$P(Q,U,4))
 S S5=$S(IBFLD=.05:X,1:$P(Q,U,5))
 S S6=$S(IBFLD=.06:X,1:$P(Q,U,6))
 I S1'="",S4'="",S5'="",S6'="",$O(^IBA(355.9,"AUNIQ",S1,S2,S3,S4,S5,S6,0)),$O(^(0))'=DA D
 . N MSG
 . S MSG(1)="Duplicate entry already on file:"
 . S MSG(1,"F")="!!?3"
 . S MSG(2)=$E($$EXPAND^IBTRE(355.9,.01,S1),1,25)_"  "_$E(Z,1,29)_"  "_$E(Z0,1,17)
 . S MSG(2,"F")="!?5"
 . S MSG(3)=$$EXPAND^IBTRE(355.9,.04,S4)_"  "_$$EXPAND^IBTRE(355.9,.05,S5)_"  "_$$EXPAND^IBTRE(355.9,.06,S6)
 . S MSG(3,"F")="!?5"
 . S MSG(4)=" ",MSG(4,"F")="!"
 . D EN^DDIOL(.MSG)
 . S DUP=1
 Q DUP
 ;
DUP1(IBFLD,DA) ; Test if there is a duplicate record already on file (355.91)
 ; Function returns 1 if dup found, 0 if no dup found
 ; IBFLD = ien of the field being checked
 ; DA = the ien of the record being checked
 N DUP,Q,S1,S2,S3,S4,S5,Z0
 S Q=$G(^IBA(355.91,+DA,0)),DUP=0
 S S1=$S(IBFLD=.01:X,1:$P(Q,U))
 S S2=$S(IBFLD=.03:X,1:$P(Q,U,10)),Z0=$$EXPAND^IBTRE(355.91,.03,S2) S:Z0="" Z0="ALL CARE UNITS"
 S S3=$S(IBFLD=.04:X,1:$P(Q,U,4))
 S S4=$S(IBFLD=.05:X,1:$P(Q,U,5))
 S S5=$S(IBFLD=.06:X,1:$P(Q,U,6))
 I S1'="",S3'="",S4'="",S5'="",$O(^IBA(355.91,"AUNIQ",S1,S2,S3,S4,S5,0)),$O(^(0))'=DA D
 . N MSG
 . S DUP=1
 . S MSG(1)="Duplicate entry already on file:",MSG(1,"F")="!!?3"
 . S MSG(2)=$E($$EXPAND^IBTRE(355.91,.01,S1),1,25)_"  "_$E(Z0,1,30)
 . S MSG(2,"F")="!?5"
 . S MSG(3)=$$EXPAND^IBTRE(355.91,.04,S3)_"  "_$$EXPAND^IBTRE(355.91,.05,S4)_"  "_$$EXPAND^IBTRE(355.91,.06,S5)
 . S MSG(3,"F")="!?5",MSG(4)=" ",MSG(4,"F")="!"
 . D EN^DDIOL(.MSG)
 Q DUP
 ;
