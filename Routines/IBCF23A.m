IBCF23A ;ALB/ARH - HCFA 1500 19-90 DATA - Split from IBCF23 ;12-JUN-93
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
B24 ; set individual entries in print array, external format
 ; IBAUX = additional data for EDI output
 ; IBRXF = array of RX procedures
 N IBX,Z,IBD1,IBD2
 S IBI=IBI+1,IBPROC=$P(IBSS,U,2),IBD1=$$DATE^IBCF23(IBDT1),IBD2=$S(IBDT1'=IBDT2:$$DATE^IBCF23(IBDT2),1:"")
 I '$D(IBXIEN) S IBD1=$E(IBD1,5,8)_$E(IBD1,1,4),IBD2=$E(IBD2,5,8)_$E(IBD2,1,4)
 S IBFLD(24,IBI)=IBD1_U_IBD2_U_$P($G(^IBE(353.1,+$P(IBSS,U,6),0)),U)_U_$P($G(^IBE(353.2,+$P(IBSS,U,7),0)),U)
 I +IBPROC D
 . S IBFLD(24,IBI)=IBFLD(24,IBI)_U_$P($$PRCD^IBCEF1(IBPROC,1),U,2) S:$P(IBPROC,";",2)'["ICPT" IBFLD(24,IBI_"X")=""
 I 'IBPROC S IBFLD(24,IBI)=IBFLD(24,IBI)_U_$S('$D(IBXIEN):IBPROC,1:+IBREV),IBFLD(24,IBI_"A")=$P($G(^DGCR(399.2,+IBREV,0)),U,2)
 I $D(IBRXF),IBCHARG="" S IBFLD(24,IBI_"A")=$P($G(^DGCR(399.2,+IBREV,0)),U,2)
 S IBFLD(24,IBI)=IBFLD(24,IBI)_U_$P(IBSS,U,5)_U_IBCHARG_U_IBUNIT_U_$P(IBSS,U,8)_U_$G(IBPCHG)_U_$G(IBMIN)_U_$G(IBEMG)
 I $D(IBSS("L")) S Z=0 F  S Z=$O(IBSS("L",Z)) Q:'Z  S IBFLD(24,IBI,$P(IBSS("L",Z),U),$P(IBSS("L",Z),U,2))=$G(IBFLD(24,IBI,$P(IBSS("L",Z),U),$P(IBSS("L",Z),U,2)))+1
 S:$TR($G(IBAUX),U)'="" IBFLD(24,IBI,"AUX")=$G(IBAUX)
 S:$D(IBRXF) IBFLD(24,IBI,"RX")=IBRXF
 K IBPROC,IBSS("L")
 Q
 ;
AUXOK(IBSS,IBSS1) ; Check all other flds are the same to combine procs
 ; IBSS = subscript of IBCP to check for dups to combine - pass by ref
 ; IBSS(IBSS,"AUX-X",n) = all the previously extracted line items for the
 ;  same set of basic data, but having different "AUX" data
 ; IBSS1 = the "AUX" data of the current IBCP entry
 ;
 ; Returns entry # in IBSS array if match found, or 0 if no match
 ; Set the IBSS "AUX-X" node for no match
 N Z,Z0
 S Z=0 F  S Z=$O(IBSS(IBSS,"AUX-X",Z)) Q:'Z  I IBSS1=IBSS(IBSS,"AUX-X",Z) Q
 I 'Z S Z0=+$O(IBSS(IBSS,"AUX-X",""),-1)+1,IBSS(IBSS,"AUX-X",Z0)=IBSS1
 Q +Z
 ;
PRC ; Extract procedure data for HCFA 1500
 ; IBRC(IBSS) = #rev codes with same billing criteria (IBSS)
 ; IBLINK('CP' ien,'RC' ien) = IBSS including modifiers,rx seq in pc 7,8
 ; IBLINK1(IBSS, 'RC' ien) =  auto (1)^ 'CP' ien (soft link)
 ;
 ; proc array w/chrg
 N IBPR,IBP
 S IBI=0 F  S IBI=$O(^DGCR(399,IBIFN,"CP",IBI)) Q:'IBI  S IBLN=^(IBI,0),IBAUXLN=$G(^("AUX")) D
 . N Z,Z0,Z1,Q1
 . S IBPDT=$P(IBLN,U,2)
 . S IBSS=$$IBSS(IBI,.IBDXI,IBLN)
 . S IBPO=$S($P(IBLN,U,4):+$P(IBLN,U,4),1:IBI+1000) ;Set print order
 . S IBCP(IBPO)=IBPDT_"^"_IBSS,IBCP(IBPO,"AUX")=IBAUXLN
 . ; Rx
 . N IBZ,IBITEM
 . S IBZ=$S($P(IBSS,U):$P(IBSS,U),1:"")
 . I IBZ'="",$D(IBLINKRX(IBZ,IBI)) D  Q:IBCHARG'=""
 .. S IBPO1=IBPO
 .. S IBITEM=+$O(IBLINKRX(IBZ,IBI,0)),IBRV=$G(IBLINKRX(IBZ,IBI,IBITEM))
 .. Q:$S(IBRV="":1,1:'$G(IBRC(IBRV)))
 .. S IBCHARG=$P(IBRV,U,6),IBRC(IBRV)=IBRC(IBRV)-1
 .. S $P(IBCP(IBPO1),U,9)=IBCHARG,IBCP(IBPO1,"RX")=IBITEM K IBLINKRX(IBZ,IBI,IBITEM)
 . ; find chrgs directly linked to proc
 . S IBK=0 F  S IBK=$O(IBLINK(IBI,IBK)) Q:'IBK  S IBRV1=IBLINK(IBI,IBK),IBRV=$P(IBRV1,U,1,6) I +IBRC(IBRV1) D
 .. S IBCHARG=$P(IBRV,U,6),IBRC(IBRV1)=IBRC(IBRV1)-1
 .. I IBCHARG'="" S $P(IBSS,U,8)=IBCHARG,IBCP(IBPO)=IBPDT_"^"_IBSS,IBPO=IBPO+.1
 ;
 ; add chrgs associated with a proc (not a direct link)
 ; find chrg associated with proc, if any (match proc,div,+/-basc)
 K IBP(0)
 F IBP=3,2 Q:$D(IBP(0))  S IBPO="" F  S IBPO=$O(IBCP(IBPO)) Q:'IBPO  I $P(IBCP(IBPO),U,9)="" D
 . S IBSS=$P(IBCP(IBPO),U,2,9)
 . S IBCHARG="",(IBRV,IBSS)=$P(IBSS,U,1,IBP) F  S IBRV=$O(IBRC(IBRV)) Q:$P(IBRV,U,1,IBP)'=IBSS  S IBP(0)=0 I +IBRC(IBRV) D  Q
 .. S IBCHARG=$P(IBRV,U,6),IBRC(IBRV)=IBRC(IBRV)-1
 .. I IBRC(IBRV) S Z=0 F  S Z=$O(IBCP(IBPO,Z)) Q:'Z  S IBRC(IBRV)=IBRC(IBRV)-1
 . S $P(IBCP(IBPO),U,9)=IBCHARG
 . I IBCHARG'="" S Z=$O(IBLINK1(IBRV,0)) I Z S IBCP(IBPO,"L",Z)=IBLINK1(IBRV,Z) K IBLINK1(IBRV,Z)
 ;
 ; add chrgs not associated with a proc to first proc with no chrg
 ; Aggggh!!! TP
 S IBPO="" F  S IBPO=$O(IBCP(IBPO)) Q:'IBPO  I $P(IBCP(IBPO),U,9)="" D
 . S IBCHARG="",IBRV="^" F  S IBRV=$O(IBRC(IBRV)) Q:IBRV=""!+IBRV  I +IBRC(IBRV) D  Q
 .. S IBCHARG=$P(IBRV,U,6),IBRC(IBRV)=IBRC(IBRV)-1
 .. S Z=$O(IBLINK1(IBRV,0)) I Z S IBCP(IBPO,"L",Z)=IBLINK1(IBRV,Z) K IBLINK1(IBRV,Z)
 . S $P(IBCP(IBPO),U,9)=IBCHARG
 ;
 Q
IBSS(IBI,IBDXI,IBLN) ; Creates index sequence for procedure
 N IBPC,IBJ,IBSS
 S IBPC=0
 F IBJ=1,6,5,0,9,10 S IBPC=IBPC+1 S:IBJ $P(IBSS,U,IBPC,IBPC+1)=($P(IBLN,U,IBJ)_U)
 S $P(IBSS,U,7)=($$GETMOD^IBEFUNC(IBIFN,IBI)_U) ;Modifiers
 F IBJ=11:1:14 I $P(IBLN,U,IBJ) S $P(IBSS,U,4)=$P(IBSS,U,4)_$S(IBJ>11:",",1:"")_$G(IBDXI(+$P(IBLN,U,IBJ))) ; dx
 S $P(IBSS,U,10)=$P(IBLN,U,16),$P(IBSS,U,9)=$P(IBLN,U,19),$P(IBSS,U,11)=+$P(IBLN,U,17)
 Q IBSS
 ;
