IBCRHU2 ;ALB/ARH - RATES: UPLOAD UTILITIES (ADD CM ELEMENTS) ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,138,245,175,307**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RG(NAME,DIV,ID,TY) ; add a new Billing Region for Reasonable Charges (363.31), input region name, MC division site #
 ; returns IFN of billing region (new or existing) ^ region name, null otherwise
 ; the part of the name before a dash is used to attempt a match with existing regions
 N IBA,IBDV,IBFN,IBNEW,IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S DIV=$G(DIV),IBDV="",(IBFN,IBNEW)=0
 I $G(NAME)="" G RGQ
 I NAME[" (DIV)" S NAME=$P(NAME," (DIV)",1)_$P(NAME," (DIV)",2)
 I NAME[" (2)" S NAME=$P(NAME," (2)",1)_$P(NAME," (2)",2)
 I NAME[" (3)" S NAME=$P(NAME," (2)",1)_$P(NAME," (3)",2)
 ;
 S IBX="" F  S IBX=$O(^IBE(363.31,"B",IBX)) Q:IBX=""  I $P(IBX,"-",1)=$P(NAME,"-",1) S IBFN=$O(^IBE(363.31,"B",IBX,0)) Q
 I +IBFN S IBFN=IBFN_U_$E(IBX,1,30),IBNEW=0 G RGQ
 ;
 S IBDV=$$DIV(DIV) I 'IBDV D MSG("     *** Warning: No MC division "_DIV_" defined, no division added to Region")
 ;
 I $G(ID)'="" S DIC("DR")=".02////"_$E(ID,1,10)_";"
 I $G(TY)'="" S DIC("DR")=$G(DIC("DR"))_".03////"_$E(TY,1,10)
 K DD,DO S DLAYGO=363.31,DIC="^IBE(363.31,",DIC(0)="L",X=$E(NAME,1,30) D FILE^DICN K DIC,DD,DO I Y<1 K X,Y Q
 S IBFN=Y,IBNEW=1
 ;
 I +IBDV S DLAYGO=363.31,DA(1)=+IBFN,DIC="^IBE(363.31,"_DA(1)_",11,",DIC(0)="L",X=+IBDV,DIC("P")="363.3111P" D ^DIC K DIC,DIE,DLAYGO
 ;
RGQ I +IBNEW!($D(IBA)) S IBA(1)="  >> "_$E(NAME,1,30)_" Billing Region "_$S('$G(IBFN):"NOT ",1:"")_"added "_$S(+IBDV:"for MCD "_$P(IBDV,U,3)_" "_$P(IBDV,U,2),1:"") D MSGP
 Q $G(IBFN)
 ;
CS(NAME,RATE,EVENT,RG,CT,RV,BS) ; add Charge Set for Reasonable Charges (363.1), all input in external form
 ; returns IFN of new charge set, 0 otherwise
 N IBA,IBBR,IBBE,IBRG,IBRV,IBBS,IBCT,IBOK,IBFN,IBCSN,IBJ,DD,DO,DLAYGO,DINUM,DIC,DIE,DA,DR,X,Y,IBFND S IBOK=1
 S NAME=$G(NAME),RATE=$G(RATE),EVENT=$G(EVENT),RG=$G(RG),CT=$G(CT),RV=$G(RV),BS=$G(BS) I NAME=""!(RATE="") G CSQ
 ;
 S IBFND=+$O(^IBE(363.1,"B",$E(NAME,1,30),0)) I +IBFND S IBFN=IBFND,IBCSN=NAME G CSQ
 ;
 S IBBR=$O(^IBE(363.3,"B",RATE,0)) I 'IBBR S IBOK=0 D MSG("     *** Error: "_RATE_" Billing Rate does not exist")
 S IBBE=$$MCCRUTL(EVENT,14) I 'IBBE S IBOK=0 D MSG("     *** Error: "_EVENT_" Billable Event undefined")
 S IBRG="" I RG'="" S IBRG=$O(^IBE(363.31,"B",$E(RG,1,30),0))
 I 'IBRG,RG'="" S IBOK=0 D MSG("     *** Error: "_$E(RG,1,30)_" Billing Region does not exist")
 I '$G(IBOK) G CSQ
 S IBRV=$$RVCD(RV) I 'IBRV D MSG("     *** Warning: No default revenue code added for Charge Set")
 S IBBS=$$MCCRUTL(BS,5) I 'IBBS D MSG("     *** Warning: No default bedsection added for Charge Set")
 S IBCT=$S($E(CT)="I":1,$E(CT)="P":2,1:"")
 ;
 F IBJ=1:1 S IBFN=$G(^IBE(363.1,IBJ,0)) I IBFN="" S DINUM=IBJ Q
 ;
 K DD,DO S DLAYGO=363.1,DIC="^IBE(363.1,",DIC(0)="L",X=$E(NAME,1,30) D FILE^DICN K DIC K DIC,DINUM,DLAYGO,DD,DO I Y<1 K X,Y Q
 S IBFN=+Y,IBCSN=$P(Y,U,2)
 ;
 S DR=".02////"_IBBR_";.03////"_IBBE_";.04////"_IBCT_";.07////"_IBRG
 I +IBRV S DR=DR_";.05////"_IBRV
 I +IBBS S DR=DR_";.06////"_IBBS
 S DIE="^IBE(363.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
 ;
CSQ I +$G(IBFN),$G(IBCSN)'="" D RS(IBCSN)
 ;
 S IBA(1)="  >> "_$E(NAME,1,30)_" Charge Set "_$S('$G(IBFN):"NOT ",1:"")_$S(+$G(IBFND):"used",1:"added") D MSGP
 Q +$G(IBFN)
 ;
USECS(CSN) ; return an existing CS for a set of RC charges, given the name to look for, or write an error message
 N IBCS S IBCS=0
 I $G(CSN)'="" S IBCS=$O(^IBE(363.1,"B",$E(CSN,1,30),0))
 I 'IBCS W !,"     *** Warning:  No Charge Set found for these charges"
 I +IBCS W !,"  >> "_$E(CSN,1,30)_" Charge Set used"
 Q IBCS
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
RVCD(RVCD) ; check for valid revenue code (#399.2), input either revenue code or revenue code IFN
 ; returns IFN if revenue code is valid and active, null otherwise
 N IBX,IBY S IBY=""
 I +$G(RVCD) S IBX=$G(^DGCR(399.2,+RVCD,0)) I +$P(IBX,U,3) S IBY=+RVCD
 Q IBY
 ;
DIV(DIV) ; check for valid medical center division (#40.8), input facility/site number
 ; returns 'IFN ^ name ^ #' of division if it exists in Medical Center Division file (40.8), 0 otherwise
 N IBX,IBY S IBX=0
 I $G(DIV)'="" S DIV=+$O(^DG(40.8,"C",DIV,0))
 I +$G(DIV) S IBY=$G(^DG(40.8,+DIV,0)) I IBY'="" S IBX=DIV_U_$P(IBY,U,1,2)
 Q IBX
 ;
MSG(X) ; add message to end of message list, reserves IBA(1) for primary message
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
MSGP ; print error messages in IBA
 N IBX S IBX="" F  S IBX=$O(IBA(IBX)) Q:'IBX  W !,IBA(IBX)
 Q
 ;
 ;
RS(CSN) ; add new Reasonable Charges Charge Sets to Rate Schedules, input Charge Set Name
 ; finds the RS to add the CS to based on the effective/inactive dates of the RS and version being loaded
 ; for RC 1.x only adds physician to inpt if there was also inpatient facility charges
 ; Tort Feasor began using Reasonable Charges on 01/07/04
 N IBCSFN,IBRSN,IBRS,IBRS0,IBRSLST,IBVBEG,IBVEND,IBVERS,IBAUTO,IBFND,IBSITE,IBI,DINUM,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y
 ;
 I $G(CSN)="" Q
 I $E(CSN,1,2)'="RC" Q
 S IBCSFN=$O(^IBE(363.1,"B",$E(CSN,1,30),0)) I 'IBCSFN Q
 S IBAUTO=1 I $P($G(^IBE(363.3,+$P($G(^IBE(363.1,+IBCSFN,0)),U,2),0)),U,4)=9 S IBAUTO=""
 S IBVERS=$$VERSION^IBCRHBRV,IBVBEG=$$VERSDT^IBCRHBRV,IBVEND=$$VERSEDT^IBCRHBRV,IBFND=1
 S IBI=$L(CSN," "),IBSITE=$P(CSN," ",IBI)
 ;
 I IBVERS<2 D
 . I CSN["INPT " S IBRSLST="RI-INPT,NF-INPT,WC-INPT"
 . I CSN["SNF " S IBRSLST="RI-INPT,NF-INPT,WC-INPT"
 . I CSN["OPT " S IBRSLST="RI-OPT,NF-OPT,WC-OPT"
 . I CSN["PHYS" S IBRSLST="RI-OPT,NF-OPT,WC-OPT"
 . I CSN["PHYS",$O(^IBE(363.1,"B","RC-INPT ANC "_IBSITE,0)) S IBRSLST=IBRSLST_",RI-INPT,NF-INPT,WC-INPT"
 ;
 I IBVERS'<2 D
 . I CSN["INPT " S IBRSLST="RI-INPT,NF-INPT,WC-INPT,TF-INPT"
 . I CSN["SNF " S IBRSLST="RI-SNF,NF-SNF,WC-SNF,TF-SNF"
 . I CSN["OPT " S IBRSLST="RI-OPT,NF-OPT,WC-OPT,TF-OPT"
 . I CSN[" FS " S IBRSLST="RI-OPT,NF-OPT,WC-OPT,TF-OPT"
 I $G(IBRSLST)="" Q
 ;
 F IBI=1:1 S IBRSN=$P(IBRSLST,",",IBI) Q:IBRSN=""  D
 . S IBRS=0 F  S IBRS=$O(^IBE(363,"B",IBRSN,IBRS)) Q:'IBRS  D  Q:+IBFND
 .. S IBRS0=$G(^IBE(363,IBRS,0))
 .. I $E(IBRSN,1,3)="TF-",+$P(IBRS0,U,6),$P(IBRS0,U,6)<3040107 S IBFND=0 Q
 .. I +$P(IBRS0,U,6),$P(IBRS0,U,6)<IBVBEG S IBFND=0 Q
 .. I +IBVEND,+$P(IBRS0,U,5),$P(IBRS0,U,5)>IBVEND S IBFND=0 Q
 .. S IBFND=1 I $O(^IBE(363,+IBRS,11,"B",+IBCSFN,0)) Q
 .. I +IBAUTO S DIC("DR")=".02////"_1
 .. S DLAYGO=363,DA(1)=+IBRS,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="LX",X=CSN,DIC("P")="363.0011P" D ^DIC K DIC,DIE
 Q
 ;
 ;
 ;
GETDIV(RGFN) ; ask the user for the divisions for a Billing Region
 N IBX,DIC,DIE,DA,DR,X,Y,DIDEL,DLAYGO Q:'$G(RGFN)  S IBX=$G(^IBE(363.31,+RGFN,0)) Q:IBX=""
 W !!,"Enter the Divisions associated with these charges: ",$P(IBX,U,1)
 S (DLAYGO,DIDEL)=363.31,DIE="^IBE(363.31,",DA=+RGFN,DR=11 D ^DIE K DIE,DR,X,Y,DIDEL,DLAYGO
 Q
 ;
RSBR(CSFN,AUTO,EFFDT) ; add the charge set to any Rate Schedule that already has charge sets of this Billing Rate assigned
 ; CSFN - IFN of Charge Set to add, AUTO - 1 if charges should be auto added, EFFDT - effective date of charges
 ; will add the Charge Set to any Rate Schedule that already has a Set of same Billing Rate and is not inactive
 N IBCS0,IBCSN,IBBRFN,IBRS,IBRSIA,IBCSE,IBNEW,IBFND,DINUM,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S DLAYGO=363,IBNEW=0
 ;
 S CSFN=+$G(CSFN) I 'CSFN Q
 I $G(^IBE(363.1,CSFN,0))="" Q
 I +$O(^IBE(363,"C",CSFN,0)) Q  ; charge set already assigned to rate schedules
 ;
 S IBCS0=$G(^IBE(363.1,CSFN,0)),IBCSN=$P(IBCS0,U,1),IBBRFN=$P(IBCS0,U,2) Q:'IBBRFN
 ;
 S IBRS=0 F  S IBRS=$O(^IBE(363,IBRS)) Q:'IBRS  S IBFND=0 D
 . I $O(^IBE(363,IBRS,11,"B",CSFN,0)) Q  ; charge set already assigned to RS
 . I +$G(EFFDT) S IBRSIA=$P($G(^IBE(363,IBRS,0)),U,6) I +IBRSIA,EFFDT>IBRSIA Q  ; RS inactive before CS active
 . ;
 . S IBCSE=0 F  S IBCSE=$O(^IBE(363,IBRS,11,"B",IBCSE)) Q:'IBCSE  D  Q:IBFND
 .. I $D(^IBE(363.1,"C",IBBRFN,IBCSE)) D  S IBFND=1,IBNEW=1 ; schedule has charge sets of same billing rate
 ... ;
 ... I +$G(AUTO) S DIC("DR")=".02////"_1
 ... S DA(1)=+IBRS,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="LX",X=IBCSN,DIC("P")="363.0011P" D ^DIC K DIC,DIE
 ... W !,"     Charge Set added to Rate Schedule ",$P($G(^IBE(363,+IBRS,0)),U,1)
 ;
 I 'IBNEW W !,"     *** Warning: ",IBCSN," not added to any Rate Schedule,",!,"         set manually using Enter/Edit Charge Master option."
 Q
