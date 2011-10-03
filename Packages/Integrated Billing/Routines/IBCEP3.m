IBCEP3 ;ALB/TMP - EDI UTILITIES for provider ID ;25-SEP-00
 ;;2.0;INTEGRATED BILLING;**137,207,232,280,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CUNEED(IBIFN,IBSEQ,IBPTYP,IBRET,IBEMC) ; Determine if care unit needed for
 ; provider type and insurance company(s) on bill
 ; IBIFN = ien of bill (file 399)
 ; IBSEQ = specific COB sequence to check or null for check all
 ; IBPTYP = the ien of the provider id type in file 355.97 or if null,
 ;          the default performing provider ID type for the ins co's.
 ; IBRET = flag to return insurance ien (0) or file 355.97 ien (1)
 ; IBEMC = no longer used
 ;
 ; Function returns care unit needed flag (0=not needed, 1=needed) ^
 ; AND   if IBSEQ="": primary ins or 355.97 ien if care unit needed ^
 ;                    secondary ins or 355.97 ien if care unit needed ^
 ;                    tertiary ins or 355.97 ien if care unit needed
 ;                    (these would be '^' pieces 2,3,4)
 ;       if IBSEQ   : IBSEQ seq ins or 355.97 ien if care unit needed
 ;                    (this would be '^' piece 2)
 ;
 Q:$G(IBEMC) 0
 N Q,Z,Z0,Z4,IB,IBCTYP,IBFTYP,IBQ,IBRX,IBPT
 S (IBRX,IB)=0
 S IBFTYP=$$FT^IBCEF(IBIFN),IBCTYP=$$INPAT^IBCEF(IBIFN,1)
 S IBFTYP=$S(IBFTYP=3:1,1:2) S:IBCTYP'=1 IBCTYP=2
 I IBCTYP=2 S IBRX=$$ISRX^IBCEF1(IBIFN) ; Outpatient pharmacy
 S IBPT=$G(IBPTYP)
 ;
 S (Z,IBQ)=0
 F  D  Q:IBQ
 . I $G(IBSEQ) S Z=IBSEQ,IBQ=1 ; Only once for specific COB sequence
 . I '$G(IBSEQ) S Z=Z+1,IBPTYP=IBPT I Z>3 S IBQ=1 Q  ; Up to 3 times - all ins
 . S Z0=$$INSSEQ^IBCEP1(IBIFN,Z),Z4=$G(^DIC(36,+Z0,4))
 . I '$G(IBPTYP) S IBPTYP=+Z4
 . I 'Z0!'IBPTYP S:'Z0 IBQ=1 Q
 . S Q=+$$CAREUN(Z0,IBPTYP,IBFTYP,IBCTYP,IBRX)
 . I Q S $P(IB,U,$S($G(IBSEQ):Z+1,1:2))=$S($G(IBRET):Q,1:Z0)
 ;
 I $TR(IB,"^0") S $P(IB,U)=1
 Q IB
 ;
CAREUN(IBINS,IBPTYP,IBFTYP,IBCTYP,IBRX) ; Find ien (file 355.96) for care
 ; unit for the combination of ins co, prov type, form type and
 ; care type
 ; IBINS = ien of ins co (file 36)
 ; IBPTYP = ien of provider id type (file 355.97)
 ; IBFTYP = form type (1=UB,2=1500)
 ; IBCTYP = care type (1=inpat,2=outpat)
 ; IBRX = 1 if outpat/Rx bill
 ;
 N IB
 S IB=""
 ;
 I $G(IBRX) D
 . N T
 . S T=$O(^IBA(355.96,"AD",IBINS,IBFTYP,3,IBPTYP,0))
 . I 'T S T=$O(^IBA(355.96,"AD",IBINS,0,3,IBPTYP,0))
 . I T S IB=T
 ;
 I 'IB D  ; Find from most specific to least specific
 . I $O(^IBA(355.96,"AD",IBINS,IBFTYP,IBCTYP,IBPTYP,0)) S IB=+$O(^(0)) Q
 . I $O(^IBA(355.96,"AD",IBINS,IBFTYP,0,IBPTYP,0)) S IB=+$O(^(0)) Q
 . I $O(^IBA(355.96,"AD",IBINS,0,IBCTYP,IBPTYP,0)) S IB=+$O(^(0)) Q
 . I $O(^IBA(355.96,"AD",IBINS,0,0,IBPTYP,0)) S IB=+$O(^(0)) Q
 ;
 Q IB
 ;
DISP(IBINS,IBTYPE) ; Return the name of the type of care unit needed
 ; IBINS = ien of ins co (file 36)
 ; IBTYPE = 2:PERFORMING PROVIDER ID
 I $G(IBTYPE)'=2 Q ""
 Q $P($G(^DIC(36,+IBINS,4)),U,9)
 ;
DELID(IBIFN,IBSEQ,IBX) ; Delete all provider data specific to an ins co
 ; represented by the COB sequence IBSEQ for bill IBIFN
 ; IBX = 1 if called from care unit prompt - don't delete value
 N IBZ,IBDR,X,Y,Z0,Z1
 S IBZ=0
 Q:'$G(IBSEQ)!($G(IBSEQ)>3)
 F  S IBZ=$O(^DGCR(399,IBIFN,"PRV",IBZ)) Q:'IBZ  S Z0=$G(^(IBZ,0)),Z1=$G(^(1)) D
 . ; Delete provider id's
 . I $P(Z0,U,4+IBSEQ)'="" S IBDR(399.0222,IBZ_","_IBIFN_",",(4+IBSEQ/100))="@"
 . ; Delete provider id types
 . I $P(Z0,U,11+IBSEQ)'="" S IBDR(399.0222,IBZ_","_IBIFN_",",(11+IBSEQ/100))="@"
 . I $D(IBDR) D FILE^DIE(,"IBDR")
 Q
 ;
SETID(IBIFN,IBSEQ) ; Default provider id for bill IBIFN and ins co for COB
 ; sequence IBSEQ
 N IBZ,X,Y,IBDR,IBT
 S IBZ=0
 Q  ; No longer used as of patch 232
 ;Q:'$G(IBSEQ)!($G(IBSEQ)>3)
 ;F  S IBZ=$O(^DGCR(399,IBIFN,"PRV",IBZ)) Q:'IBZ  S Z0=$G(^(IBZ,0)),Z1=$G(^(1)) D
 ;. ; Update provider id's if no care unit is needed
 ;. I $P(Z0,U,2)'="" D
 ;.. S Z=$$GETID^IBCEP2(IBIFN,2,$P(Z0,U,2),IBSEQ,.IBT)
 ;.. I Z'="",IBT S IBDR(399.0222,IBZ_","_IBIFN_",",(4+IBSEQ/100))=Z,IBDR(399.0222,IBZ_","_IBIFN_",",(11+IBSEQ/100))=+IBT
 ;. I $D(IBDR) D FILE^DIE(,"IBDR")
 Q
 ;
ALLID(IBIFN,IBFLD,IBFUNC) ; If form type or care type (I/O/RX) changes,
 ; determine new provider id values if possible and update them
 ; this includes primary, secondary, tertiary id's
 ; IBIFN = ien of claim (file 399)
 ; IBFLD = ien of the field being changed when this call is made
 ;         (.19 = form type   .25 = care type)
 ; IBFUNC = 1 to add,  2 to delete
 N Z,Z0,IBC,IBDR,IBT
 S Z=0
 F  S Z=$O(^DGCR(399,IBIFN,"PRV",Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 . F IBC=5:1:7 I $S(IBFUNC=2:$P(Z0,U,IBC)'="",1:1) S IBDR(399.0222,IBC_","_IBIFN_",",(IBC/100))=$S(IBFUNC=2:"@",1:$$GETID^IBCEP2(IBIFN,2,$P(Z0,U,2),IBC-4,.IBT))
 I $D(IBDR) D FILE^DIE(,"IBDR")
 Q
 ;
CUMNT ; Add/edit care unit
 N D,DIE,DIC,DIK,DIR,DA,X,Y,IB,IBINS,IBF,IBCT,IBOK,IBPTYP,IBOLD,IBY,IBINS1,IBPTYP1,DUOUT,DTOUT
INS F  D  Q:Y'>0
 . S DIC="^DIC(36,",DIC(0)="AEMQ" D ^DIC K DIC
 . I $D(DUOUT)!$D(DTOUT) S Y=-1 Q
 . I Y'>0 S DIR(0)="EA",DIR("A")="Insurance Co is required - press enter to continue: " D ^DIR K DIR Q
 . S IBINS=+Y,IBF="A",IBINS1=$P(Y,U,2)
 I $O(^IBA(355.96,"D",IBINS,""))'="" D
 . W ! S DIR("A")="(A)dd or (E)dit entries?: ",DIR("B")="Add",DIR(0)="SA^A:Add;E:Edit" D ^DIR W ! K DIR
 . S IBF=Y
 Q:$G(IBF)=""!("AE"'[$G(IBF))
 ;
 I IBINS>0 D
 . I IBF="A" D NEW^IBCEP4A(1)
 . I IBF="E" D CHANGE^IBCEP4A(1)
 ;
 Q
 ;
DUP(IBDA,IBOLD,IBFUNC) ; Check if the combination of ins co, prov type, care
 ; type and form already exists in file 355.96
 ; IBDA = ien of entry in file 355.96
 ; IBOLD = the 0-node before changes were made - used to reset the fields
 N DUP,IB0,DR,X,Y,DIK,DIE,DA
 S IB0=$G(^IBA(355.96,IBDA,0)),DUP=0
 ;
 I $O(^IBA(355.96,"AUNIQ",+$P(IB0,U,3),+IB0,+$P(IB0,U,4),+$P(IB0,U,5),+$P(IB0,U,6),0))'=IBDA!($O(^IBA(355.96,"AUNIQ",+$P(IB0,U,3),+IB0,+$P(IB0,U,4),+$P(IB0,U,5),+$P(IB0,U,6),""),-1)'=IBDA) D
 . S DUP=1
 . I IBFUNC="E" D
 .. S DR=";.01///"_$P(IBOLD,U)_";.03///"_$S($P(IBOLD,U,3)'="":"/"_$P(IBOLD,U,3),1:"@")_";.04///"_$S($P(IBOLD,U,4)'="":"/"_$P(IBOLD,U,4),1:"@")
 .. S DR=DR_";05///"_$S($P(IBOLD,U,5)'="":"/"_$P(IBOLD,U,5),1:"@")_";.06///"_$S($P(IBOLD,U,6)'="":"/"_$P(IBOLD,U,6),1:"@")
 .. S DA=IBDA,DIE="^IBA(355.96," D ^DIE
 . I IBFUNC="A" D
 .. S DA=IBDA,DIK="^IBA(355.96," D ^DIK
 Q DUP
 ;
PROFID(IBIFN,IBSEQ,IBID) ; Return id and type of rendering provider id
 ; used for insurance co at COB seq IBSEQ for bill ien IBIFN
 ; RETURN VALUES:
 ; piece 1:
 ;  1 = FEDERAL TAX ID
 ;  2 = INSURANCE CO SPECIFIC ID
 ;  3 = NETWORK ID
 ; "" = not a CMS-1500 bill or no id found
 ; piece 2:
 ;  the id #
 N IBTYP,IBXDATA,IBZ
 S:'$G(IBSEQ) IBSEQ=+$$COBN^IBCEF(IBXIEN)
 S IBTYP=""_U_$G(IBID)
 G:$$FT^IBCEF(IBIFN)'=2 PROFIDQ
 I '$D(IBID) D F^IBCEF("N-ALL ATT/RENDERING PROV ID","IBZ",,IBIFN) S IBID=$$NOPUNCT^IBCEF($P(IBZ,U,IBSEQ+1))
 G:IBID="" PROFIDQ
 S IBTYP=$S($$NOPUNCT^IBCEF(IBID)=$$NOPUNCT^IBCEF($P($G(^IBE(350.9,1,1)),U,5)):1,$$NETWRK(IBIFN,IBID,IBSEQ):3,1:2)
 S IBTYP=IBTYP_U_IBID
 ;
PROFIDQ Q IBTYP
 ;
NETWRK(IBIFN,IBID,IBSEQ) ; Determine if ID number IBID is the same as the
 ; network id for the insurance co
 ;  IBIFN = bill ien (file 399)
 ;  IBSEQ = COB seq # of bill
 ;   Returns 1 if network ID match is found for bill IBIFN, COB seq IBSEQ
 N IBINS,IBNET
 S IBNET=0
 Q IBNET
 ; This section needs work *********
 I '$G(IBSEQ) S IBSEQ=+$$COBN^IBCEF(IBXIEN)
 S IBINS=+$G(^DGCR(399,IBIFN,"I"_IBSEQ))
 I $P($G(^IBE(355.97,+$$PPTYP^IBCEP0(IBINS),1)),U,6) D
 . ; performing provider id type is a network id type
 . I $$NOPUNCT^IBCEF($G(IBID))=$$NOPUNCT^IBCEF($$GETID^IBCEP2(IBIFN,3,$$PERFPRV^IBCEP2A(IBIFN),IBSEQ)) S IBNET=1
 Q IBNET
 ;
 ;
 ; Parameter definitions for UNIQ1 and UNIQ2 in IBCEP2
 ;   IBIFN = ien of bill (file 399)
 ;   IBINS = ien of insurance co (file 36) or *ALL* for all insurance
 ;   IBPTYP = the ien of the provider id type in file 355.97
 ;   IBUNIT = the value of the specific care unit to use for a match
 ;            or *N/A* if none needed
 ;   IBCU = the ien of the entry being matched in start file
 ;   IBT = the second and third pieces are set to the entry ien^file #
