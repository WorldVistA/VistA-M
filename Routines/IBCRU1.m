IBCRU1 ;ALB/ARH - RATES: UTILITIES ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EMUTL(X,LNG) ; returns external form of an MCCR Utility entry (399.1), full or abbrev.
 S X=$G(^DGCR(399.1,+$G(X),0)),LNG=$S(+$G(LNG)=2:3,1:1)
 S X=$P(X,U,LNG)
 Q X
 ;
MCCRUTL(N,P) ; returns IFN of MCCR Utility entry (399.1) if Name N is found and piece P is true
 N X,I,Y S X=0
 I +$G(P),$G(N)'="" S I=0 F  S I=$O(^DGCR(399.1,"B",$E(N,1,30),I)) Q:'I  S Y=$G(^DGCR(399.1,I,0)) I +$P(Y,U,P),$P(Y,U,1)=N S X=I Q
 Q X
 ;
EXPAND(FILE,FIELD,VALUE) ; return expanded external form of a data element
 N Y,C S Y=$G(VALUE)
 I +$G(FILE),+$G(FIELD),Y'="" S C=$P(^DD(FILE,FIELD,0),"^",2) D Y^DIQ
 Q Y
 ;
DATE(X) ; date in external format
 N Y S Y="" I $G(X)?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
GETDT(DEFAULT,PROMPT,MIN,MAX) ; user select effective date  (-1 if ^, 0 if none)  DT1
 N IBX,DIR,X,Y,DTOUT,DUOUT,DIRUT S IBX=0 I $G(DEFAULT) S DIR("B")=$$DATE(DEFAULT)
 S DIR("A")=$S($G(PROMPT)'="":PROMPT,1:"Select EFFECTIVE DATE")
 S DIR(0)="DO^"_$G(MIN)_":"_$G(MAX)_":EX" D ^DIR K DIR I Y?7N S IBX=+Y
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETBR(BI) ; ask and return a billing rate (363.3):  (-1 if ^, 0 if none)  IFN^.01
 ; if BI passed in then only allow selection of billing rates with that type of billable item
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 I +$G(BI) S DIC("S")="I $P(^(0),U,4)="_BI
 S DIC="^IBE(363.3,",DIC(0)="AENQ" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETCS() ; ask and return a charge set (363.2):  (-1 if ^, 0 if none)  IFN^.01
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 S DIC="^IBE(363.1,",DIC(0)="AENQ" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETSG(TYPE,BR) ; ask and return a special group (363.32):  (-1 if ^, 0 if none)  IFN^.01
 ; if TYPE is passed in then only groups of that type may be selected
 ; if BR is passed in then only groups assigned that billing rate may be selected
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 I +$G(TYPE) S DIC("S")="I $P(^(0),U,2)="_TYPE_$S(+$G(BR):" ",1:"")
 I +$G(BR) S DIC("S")=$G(DIC("S"))_"I $O(^IBE(363.32,Y,11,""B"",+BR,0))"
 S DIC="^IBE(363.32,",DIC(0)="AENQ" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETBED(COL) ; ask and return billable bedsection (399.1):  (-1 if ^, 0 if none)  IFN^.01
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 S DIC("A")=$J("",$G(COL))_"Select BEDSECTION: "
 S DIC="^DGCR(399.1,",DIC(0)="AENQ",DIC("S")="I +$P(^(0),U,5)=1" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETCPT(COL,ALL) ; ask and return CPT (81):  (-1 if ^, 0 if none)  IFN^.01
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 S DIC("A")=$J("",$G(COL))_"Select CPT: " I '$G(ALL) S DIC("S")="I $$CPTACT^IBACSV(+Y,DT)"
 S DIC="^ICPT(",DIC(0)="AEMNQ" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETNDC(COL) ; ask and return NDC #'s (363.21):  (-1 if ^, 0 if none)  IFN^.01
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 S DIC("A")=$J("",$G(COL))_"Select NDC #: "
 S DIC="^IBA(363.21,",DIC(0)="AENQ",DIC("S")="I +$P(^(0),U,2)=1" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETDRG(COL,ALL) ; ask and return DRG (80.2):  (-1 if ^, 0 if none)  IFN^.01
 ; ALL: Default is 1 (disable screening)
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 S DIC("A")=$J("",$G(COL))_"Select DRG: " I '$G(ALL,1) S DIC("S")="I $$DRGACT^IBACSV(+Y,DT)"
 S DIC="^ICD(",DIC(0)="AEMNQ" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETMISC(COL,CS) ; ask and return MISCELLANEOUS item (363.21):  (-1 if ^, 0 if none)  IFN^.01
 ; if CS is passed in then only billing items with charges in that set are selectable
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 S DIC("A")=$J("",$G(COL))_"Select MISCELLANEOUS Item: "
 S DIC("S")="I +$P(^(0),U,2)=9" I +$G(CS) S DIC("S")=DIC("S")_",$D(^IBA(363.2,""AIVDTS""_+CS,Y))"
 S DIC="^IBA(363.21,",DIC(0)="AENQ" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
GETITEM(IBCSFN,COL,ALL) ; returns user selected item for a specific charge set:
 ;  IFN ^ .01 ^ source file reference ^ source file   (-1 if ^, 0 if none)
 N IBCS0,IBBRFN,IBBR0,IBBRBI,IBITEM S IBITEM=0,COL=$G(COL),ALL=$G(ALL)
 I '$G(IBCSFN) S IBCSFN=+$$GETCS I IBCSFN'>0 G GIQ
 ;
 S IBCS0=$G(^IBE(363.1,+IBCSFN,0)),IBBRFN=$P(IBCS0,U,2)
 S IBBR0=$G(^IBE(363.3,+IBBRFN,0)),IBBRBI=$P(IBBR0,U,4)
 ;
 I IBBRBI=1 S IBITEM=$$GETBED(COL) S:IBITEM>0 IBITEM=IBITEM_U_$$BIFILE^IBCRU2(IBBRBI) G GIQ
 I IBBRBI=2 S IBITEM=$$GETCPT(COL,ALL) S:IBITEM>0 IBITEM=IBITEM_U_$$BIFILE^IBCRU2(IBBRBI) G GIQ
 I IBBRBI=3 S IBITEM=$$GETNDC(COL) S:IBITEM>0 IBITEM=IBITEM_U_$$BIFILE^IBCRU2(IBBRBI) G GIQ
 I IBBRBI=4 S IBITEM=$$GETDRG(COL) S:IBITEM>0 IBITEM=IBITEM_U_$$BIFILE^IBCRU2(IBBRBI) G GIQ
 I IBBRBI=9 S IBITEM=$$GETMISC(COL,$S('ALL:+IBCSFN,1:0)) S:IBITEM>0 IBITEM=IBITEM_U_$$BIFILE^IBCRU2(IBBRBI) G GIQ
GIQ Q IBITEM
