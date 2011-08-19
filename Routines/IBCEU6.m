IBCEU6 ;ALB/ESG - EDI UTILITIES FOR EOB PROCESSING ;29-JUL-2003
 ;;2.0;INTEGRATED BILLING;**155,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
COBLINE(IBIFN,IBI,IBXDATA,SORT,IBXTRA) ; Extract all COB data for line item
 ;  from file 361.1 (EOB), subfile 15 into IBXDATA(IBI,"COB",n)
 ;
 ; IBIFN = bill entry #
 ; IBI = VistA outbound line item #
 ; IBXDATA = array returned with COB line item data/pass by reference
 ; SORT = flag that determines whether the data should be sorted for
 ;        output for the 837 record ('PR' group always there and has
 ;        a reason code for deductible first and co-insurance second -
 ;        even if they are 0).
 ;        1 = sort, 0 = no sort needed
 ;
 ;   Returns IBXDATA(IBI,"COB",COB,n) with COB data for each line item
 ;      found in an accepted EOB for the bill and = the '0' node data of
 ;      file 361.115 (LINE LEVEL ADJUSTMENTS)
 ;         -- AND --
 ;    IBXDATA(IBI,"COB",COB,n,z,p)=
 ;           the data on the '0' node for each subordinate entry of file
 ;           361.11511 (REASONS) (Only first 3 pieces for 837 output)
 ;               z = this is either piece 1 of the 0-node for subfile
 ;                   361.1151 (ADJUSTMENTS)
 ;                          OR
 ;                   for the 837 COB 'sorted' output, this will be ' PR'
 ;                    for the forced/extracted entries for deductible
 ;                    and co-insurance so they are always output first
 ;                    The space needs to be stripped off on output
 ;         -- AND --
 ; IBXTRA = array returned if passed by reference if line is found
 ;          associated with line IBI due to bundling/unbundling
 ;          IBXTRA("ALL",x,paid procedure)=COB SEQ ^ seq # corresponding
 ;                        to subscript n in IBXDATA(,"COB",COB,n
 ;                (x = line #-original proc-service dt)
 ;
 N A,B,B1,C,D,IBDATA,IB0,IB00,IBA,IBB,IBDED,IBCOI,IBS,IBN,IBDT
 ;
 ; If multiple EOB's reference this line for the same COB sequence,
 ;   extract only the last one marked accepted containing this line item.
 ;
 S A=0
 F  S A=$O(^IBM(361.1,"B",IBIFN,A)) Q:'A  D
 . I '$$EOBELIG^IBCEU1(A) Q   ; eob not eligible for secondary claim
 . I '$D(^IBM(361.1,A,15,"AC",IBI)) Q   ; this EOB does not reference VistA line# IBI
 . S IBA=0
 . S IBDATA=$G(^IBM(361.1,A,0))
 . S IBS=$P(IBDATA,U,15)      ; insurance sequence#
 . S IBN=+$O(IBXDATA(IBI,"COB",IBS,0))
 . I IBN D  Q:IBN  ; check for later EOB
 .. I $G(IBDT(IBI,IBS)),IBDT(IBI,IBS)<$P(IBDATA,U,6) K IBDT(IBI,IBS),IBXDATA(IBI,"COB",IBS) S IBN=0
 . ;
 . S IBDT(IBI,IBS)=$P(IBDATA,U,6)
 . S B=0
 . F  S B=$O(^IBM(361.1,A,15,"AC",IBI,B)) Q:'B  S IB0=$G(^IBM(361.1,A,15,B,0)),IB0=IB0_U_IBDT(IBI,IBS) D
 .. Q:$TR(IB0,U)=""
 .. S IBA=IBA+1,IBXDATA(IBI,"COB",IBS,IBA)=IBI_U_IB0
 .. ;
 .. ; capture the modifiers (361.1152)
 .. I $D(^IBM(361.1,A,15,B,2)) M IBXDATA(IBI,"COBMOD")=^IBM(361.1,A,15,B,2)
 .. I $P(IB0,U,15)'="" D  ;Line involved in bundling/unbundling
 ... N Z0 S Z0=IBI_"-"_$P(IB0,U,15)_"-"_$P(IB0,U,16)
 ... S IBXTRA("ALL",Z0,$P(IB0,U,4))=IBS_U_IBA,$P(IBXDATA(IBI,"COB",IBS,IBA),U)=""
 .. S C=0,(IBDED(IBA),IBCOI(IBA))="0^0" ;Assume 0 if not found in list
 .. F  S C=$O(^IBM(361.1,A,15,B,1,C)) Q:'C  S IB0=$G(^(C,0)) D
 ... S D=0
 ... F  S D=$O(^IBM(361.1,A,15,B,1,C,1,D)) Q:'D  S IB00=$S($G(SORT):$P($G(^(D,0)),U,1,3),1:$G(^(D,0))) D
 .... I $G(SORT),$P(IB0,U)="PR" D  ;Check for deductible or co-ins
 ..... I 'IBDED(IBA),$P(IB00,U)=1 S IBDED(IBA)=IB00,IB00="" Q
 ..... I 'IBCOI(IBA),$P(IB00,U)=2 S IBCOI(IBA)=IB00,IB00="" Q
 .... I $TR(IB00,U)'="" S IBB=$O(IBXDATA(IBI,"COB",IBS,IBA,$P(IB0,U),""),-1)+1,IBXDATA(IBI,"COB",IBS,IBA,$P(IB0,U),IBB)=IB00
 .. Q:'$G(SORT)
 .. S IBXDATA(IBI,"COB",IBS,IBA," PR",1)=IBDED(IBA)
 .. S IBXDATA(IBI,"COB",IBS,IBA," PR",2)=IBCOI(IBA)
 Q
 ;
