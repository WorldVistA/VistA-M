IBCEP2A ;ALB/TMP - EDI UTILITIES for provider ID ;25-APR-01
 ;;2.0;INTEGRATED BILLING;**137,232,320,348,349,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ALT(IBPERF,IBSRC,IBALT,IBINS4,IBPTYP) ; set source level to next higher level 
 ; or set the alternate type and source if performing provider id
 ; alternate type and source exist
 ; IBPERF = 1 if performing provider id is requested
 ; IBINS4 = '4' node of insurance co (file 36)
 ; Pass IBPTYP by reference to get alternate provider id type
 ; Pass IBALT by reference.  Set to 1 if alternate id is to be used next
 ;
 I '$G(IBPERF)!($P(IBINS4,U,3)=1) S IBSRC=IBSRC-1 G ALTQ
 S IBSRC=""
 I '$G(IBALT),$P(IBINS4,U,3)=2,$P(IBINS4,U,10),$P(IBINS4,U,11) S IBALT=1,IBSRC=$P(IBINS4,U,11),IBPTYP=$P(IBINS4,U,10) S:IBPTYP="" IBPTYP=$P(IBINS4,U)
 ;
ALTQ Q IBSRC
 ;
IDSET(IBPTYP,IBINS4,IBPERF,IBSPEC,IBSRC,IBUP) ; set variables for provider id type search
 N Z
 S IBSPEC=$G(^IBE(355.97,+IBPTYP,1))
 S Z=$S($G(IBPERF):2,$P(IBSPEC,U,5):6,$P(IBSPEC,U,6):4,1:2)
 S IBSRC=$P(IBINS4,U,Z),IBUP=$P(IBINS4,U,$S(IBSRC:Z+1,1:0))
 Q
 ;
CAREST(IBIFN) ; Return state file ien of state where care was performed
 ; IBIFN = ien of bill in file 399
 N STATE,IBU2,NVAFAC,IB0,EVDT,IBDIV,INST
 S STATE=""
 ;
 ; non-VA care
 S IBU2=$G(^DGCR(399,IBIFN,"U2"))
 S NVAFAC=+$P(IBU2,U,10)          ; non-VA facility
 I NVAFAC S STATE=+$P($G(^IBA(355.93,NVAFAC,0)),U,7) G CARESTX
 ;
 ; VA care
 S IB0=$G(^DGCR(399,IBIFN,0))
 S EVDT=$P(IB0,U,3)                         ; claim event date
 I 'EVDT S EVDT=DT                          ;   - default today if undefined
 S IBDIV=+$P(IB0,U,22)                      ; division ptr file 40.8
 I 'IBDIV S IBDIV=$$PRIM^VASITE(EVDT)       ;   - default primary division as of event date
 I IBDIV'>0 S IBDIV=$$PRIM^VASITE()         ;   - default main division as of today's date
 S INST=+$$SITE^VASITE(EVDT,IBDIV)          ; division institution ptr file 4
 I INST'>0 S INST=+$$SITE^VASITE(DT,IBDIV)  ;   - default div as of today's date
 I INST'>0 S INST=+$$SITE^VASITE            ;   - default main institution
 S STATE=+$P($G(^DIC(4,INST,0)),U,2)        ; state file ien from Institution file
 ;
CARESTX ;
 Q STATE
 ;
RECALCA(IBIFN) ; Recalculate all performing provider id's on bill IBIFN
 ; IBIFN = ien of bill entry (file 399)
 N IBZ,IBZ0,IBX,IBP,IBSEQ,DA,DIE,DR,DIR,X,Y
 ;
 D EN^DDIOL("THIS FUNCTION HAS BEEN DISABLED",,"!") Q
 ;
 S DA(1)=IBIFN
 I '$D(^XUSEC("IB SUPERVISOR",DUZ)) D EN^DDIOL("YOU ARE NOT AUTHORIZED TO PERFORM THIS FUNCTION",,"!")
 S IBZ=0 F  S IBZ=$O(^DGCR(399,IBIFN,"PRV",IBZ)) Q:'IBZ  S IBP=$G(^(IBZ,0)) I $P(IBP,U,2)'="" D
 . S DA=IBZ
 . F IBZ0=5:1:7 Q:'$G(^DGCR(399,IBIFN,"I"_(IBZ0-4)))  D
 .. S IBSEQ=$$EXPAND^IBTRE(399.0222,.01,+IBP)_" "_$P("PRIMARY^SECONDARY^TERTIARY",U,IBZ0-4)_" PROVIDER ID "
 .. S IBX=$$RECALC(.DA,IBZ0-4,$P(IBP,U,IBZ0),1)
 .. I IBX'="",IBX=$P(IBP,U,IBZ0) D EN^DDIOL(IBSEQ_"NO CHANGE NEEDED",,"!") Q
 .. I IBX'="",IBX'=$P(IBP,U,IBZ0) D  Q
 ... S DR=(IBZ0/100)_"////"_IBX,DIE="^DGCR(399,"_DA(1)_",""PRV""," D ^DIE
 ... D EN^DDIOL(IBSEQ_"CHANGED TO "_IBX,,"!")
 .. D EN^DDIOL(IBSEQ_"NOT FOUND",,"!")
 Q
 ;
RECALC(IBDA,IBSEQ,IBX,IBD) ; Recalculate id #, if possible - called
 ;   from input transforms in subfile 399.0222, fields .05-.07
 ; IBDA = DA array of the provider entry (file 399.0222)
 ; IBSEQ = the numeric COB sequence of the provider id (1-3)
 ; IBX = the current value of the id in the subfile
 ; IBD = flag that if set to 1 will suppress the display text
 ;
 N IBPN,IBZ
 S IBPN=$P($G(^DGCR(399,IBDA(1),"PRV",IBDA,0)),U,2)
 I IBPN="" D:'$G(IBD) EN^DDIOL("   CAN'T CALCULATE WITHOUT A PROVIDER NAME","","?0") G RECALCQ
 S IBZ=$$GETID^IBCEP2(IBDA(1),2,IBPN,IBSEQ)
 I IBZ="" D:'$G(IBD) EN^DDIOL("   ID COULD NOT BE DETERMINED","","?0") G RECALCQ
 D:'$G(IBD) EN^DDIOL("  "_IBZ_$S(IBZ'=IBX:"",1:" (no change)"),"","?0")
 S IBX=IBZ
 ;
RECALCQ Q IBX
 ;
PERFPRV(IBIFN) ; Returns the variable pointer of the 'performing provider'
 ; (attending or rendering) for a bill IBIFN
 N IBP,IBPT,IBQ,Z
 S Z=$$FT^IBCEF(IBIFN),IBPT=$S(Z=2:3,Z=3:4,1:0)
 D GETPRV^IBCEU(IBIFN,IBPT,.IBP)
 Q $P($G(IBP(IBPT,1)),U,3)
 ;
INSPAR(IBIFN,SEQ) ;
 N Z,Z4,Z0
 Q:$G(X)'="??"
 S:'$G(SEQ) SEQ=$$COBN^IBCEF(IBIFN)
 S Z=+$G(^DGCR(399,IBIFN,"I"_SEQ)),Z4=$G(^DIC(36,Z,4))
 I Z D
 . D EN^DDIOL(">"_$J("",20)_"-- PERFORMING PROVIDER ID PARAMETERS --",,"!")
 . S Z0=$P("  PRIMARY^SECONDARY^ TERTIARY",U,SEQ)_" INSURANCE: "_$P($G(^DIC(36,Z,0)),U)
 . D EN^DDIOL(">"_$J("",(80-$L(Z0))\2)_Z0,,"!")
 . D EN^DDIOL(">  Secondary Perf Prov ID Type (1500): "_$$EXPAND^IBTRE(36,4.01,+Z4),,"!")
 . D EN^DDIOL(">  Secondary Perf Prov ID Type (UB04): "_$$EXPAND^IBTRE(36,4.02,$P(Z4,U,2)),,"!")
 . D EN^DDIOL(">    Secondary Perf Prov IDs Required: "_$$EXPAND^IBTRE(36,4.03,$P(Z4,U,3)),,"!")
 . D EN^DDIOL(" ",,"!")
 Q
 ;
GETTYP(IBXIEN,IBCOBN,IBFUNC) ; Function returns provider id type for insurance co
 ; with COB of IBCOBN on claim ien IBXIEN in first ^ pc and 1 in second
 ; ^ piece if the id is required
 ; 
 ; IBFUNC=1:REFERRING;2:OPERATING;3:RENDERING;4:ATTENDING;5:SUPERVISING;9:OTHER
 ; 
 N A,R,Z,Z0
 S A="",R=0
 S:'$G(IBCOBN)!(IBCOBN>3) IBCOBN=$$COBN^IBCEF(IBXIEN)
 S Z=+$G(^DGCR(399,IBXIEN,"I"_+IBCOBN))
 I Z D
 . S Z0=$$FT^IBCEF(IBXIEN)
 . S A=+$P($G(^DIC(36,Z,4)),U,$S(Z0=2&($G(IBFUNC)=1):4,Z0=2:1,1:2))
 . I A,$G(IBFUNC)'=1 S R=$P($G(^DIC(36,Z,4)),U,3),R=$S('R:0,R=3:1,R=1:Z0=2,R=2:Z0=3,1:0)
 . I A,$G(IBFUNC)=1 S R=+$P($G(^DIC(36,Z,4)),U,5),R=$S('R:0,Z0'=2:0,1:1)
 Q A_U_R
 ;
UNIQ1(IBIFN,IBINS,IBPTYP,IBPROV,IBUNIT,IBCU,IBT) ; Match most-least specific
 ; *** SEE PARAMETER DEFINITIONS IN IBCEP3 ***
 ;
 ; Start in file 355.9 (Specific Provider)
 ;   IBPROV = (variable pointer syntax) provider on bill IBIFN
 ;
 N Q,Z0,Z1,Z2,IBID,IBX
 S IBID=""
 S IBX=$P($G(^IBA(355.9,+IBCU,0)),U,3) S:"0"[IBX IBX="*N/A*"
 S Z0=$$FT^IBCEF(IBIFN),Z0=$S(Z0=2:2,Z0=3:1,1:0),Z1=$$INPAT^IBCEF(IBIFN) S:'Z1 Z1=2 S Z2=$$ISRX^IBCEF1(IBIFN)
 ;
 ; Match all elements
 F Q=$S(Z2:3,1:Z1),$S(Z2:Z1,1:"") I Q'="",$D(^IBA(355.9,"AUNIQ",IBPROV,IBINS,IBX,Z0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.9,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.9) Q
 G:IBID'="" UNIQ1Q
 ;
 ; Match both form types,specific I/O element
 F Q=$S(Z2:3,1:Z1),$S(Z2:Z1,1:"") I Q'="",$D(^IBA(355.9,"AUNIQ",IBPROV,IBINS,IBX,0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.9,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.9) Q
 G:IBID'="" UNIQ1Q
 ;
 ; Match specific form type, both I/O element or Rx
 F Q=$S(Z2:3,1:0),$S(Z2:0,1:"") I Q'="",$D(^IBA(355.9,"AUNIQ",IBPROV,IBINS,IBX,Z0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.9,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.9) Q
 G:IBID'="" UNIQ1Q
 ;
 ; Match both form types, both I/O element or Rx
 F Q=$S(Z2:3,1:0),$S(Z2:0,1:"") I Q'="",$D(^IBA(355.9,"AUNIQ",IBPROV,IBINS,IBX,0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.9,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.9) Q
 ;
UNIQ1Q Q IBID
 ;
UNIQ2(IBIFN,IBINS,IBPTYP,IBUNIT,IBCU,IBT) ; Match on most-least specific
 ; *** SEE PARAMETER DEFINITIONS IN IBCEP3 ***
 ;
 ; Start in file 355.91 (Specific Insurance)
 ;
 N Q,Z0,Z1,Z2,IBID,IBX
 S IBID="" S:"0"[$G(IBUNIT) IBUNIT="*N/A*"
 S Z0=$$FT^IBCEF(IBIFN),Z0=$S(Z0=2:2,Z0=3:1,1:0),Z1=$$INPAT^IBCEF(IBIFN) S:'Z1 Z1=2 S Z2=$$ISRX^IBCEF1(IBIFN)
 ;
 ; Match all elements
 F Q=$S(Z2:3,1:Z1),$S(Z2:Z1,1:"") I Q'="",$D(^IBA(355.91,"AUNIQ",IBINS,IBUNIT,Z0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.91,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.91) Q
 G:IBID'="" UNIQ2Q
 ;
 ; Match both form types,specific I/O element
 F Q=$S(Z2:3,1:Z1),$S(Z2:Z1,1:"") I Q'="",$D(^IBA(355.91,"AUNIQ",IBINS,IBUNIT,0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.91,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.91) Q
 G:IBID'="" UNIQ2Q
 ;
 ; Match specific form type, both I/O element or Rx
 F Q=$S(Z2:3,1:0),$S(Z2:0,1:"") I Q'="",$D(^IBA(355.91,"AUNIQ",IBINS,IBUNIT,Z0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.91,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.91) Q
 G:IBID'="" UNIQ2Q
 ;
 ; Match both form types, both I/O elements or Rx
 F Q=$S(Z2:3,1:0),$S(Z2:0,1:"") I Q'="",$D(^IBA(355.91,"AUNIQ",IBINS,IBUNIT,0,Q,IBPTYP,IBCU)) S IBID=$P($G(^IBA(355.91,IBCU,0)),U,7),$P(IBT,U,2,3)=(IBCU_U_355.91) Q
 ;
UNIQ2Q Q IBID
 ;
