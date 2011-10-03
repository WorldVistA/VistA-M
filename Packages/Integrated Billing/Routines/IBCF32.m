IBCF32 ;ALB/BGA-UB92 HCFA-1450 (GATHER CODES) ;25-AUG-1993
 ;;2.0;INTEGRATED BILLING;**210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine requires prior execution of ibcf3.
 ;
DX ;set diagnosis codes fl 67-71
 ;S IBX=$G(^DGCR(399,+IBIFN,"C"))
 ;S IBI=0 F IBJ=14:1:18 S IBFL(67+IBI)=$P($G(^ICD9(+$P(IBX,U,IBJ),0)),U,1),IBI=IBI+1
 N IBINDXX
 D SET^IBCSC4D(IBIFN,"",.IBINDXX)
 S IBX=0 F IBI=1:1:9 S IBX=$O(IBINDXX(IBX)) Q:'IBX  D
 . S IBFL(66+IBI)=$P($$ICD9^IBACSV(+IBINDXX(IBX)),U)
 ;
76 ;fl 76 admitting diagnoses (if a ICD dx not entered get old position of dx)
 S IBCBCOMM=$G(^DGCR(399,+IBIFN,"U1"))
 S IBX=$P(IBCU2,U) ; Admitting Diagnosis (fld #215) IBCU2=$G(^DGCR(399,+IBIFN,"U2"))
 I 'IBX S IBFL(76)=$P(IBCBCOMM,U,5) ; Form Locator 9 (Field #205)
 E  S IBFL(76)=$P($$ICD9^IBACSV(+IBX),U)
 ;
78 S IBX=$P(IBCUF31,U,2) D SPLIT^IBCF3(78,2,3,IBX) ; set IBFL(78)
 ;fl 79 procedure coding method used
 S IBFL(79)=$P(IBCBILL,U,9)
 ;
82 ;fl 82 attending physician id
 S IBFL(82)=$P(IBCBCOMM,U,13) I IBFL(82)="" S IBFL(82)="Dept. Veterans Affairs"
 ;fl 83 other physician id
 S IBFL(83)=$P(IBCBCOMM,U,14)
 ;
84 ;fl 84 remarks
 S IBFL(84,1)="Patient ID: "_$P(VADM(2),U,2)
 S IBX=$P($G(^DGCR(399.3,+$P(IBCBILL,U,7),0)),U,2),IBFL(84,2)="Bill Type: "_$S(IBX'="":IBX,1:"UNSPECIFIED")
 S IBFL(84,3)=$P(IBSIGN,U,4)
 S IBFL(84,4)=$P(IBCBCOMM,U,8)
 ;
85 ;fl 85 provider representative signature
 S IBFL(85,1)=$P(IBSIGN,U,1)
 S IBFL(85,2)=$P(IBSIGN,U,2)
86 ;date bill submitted
 S IBX=$P($G(^DGCR(399,+IBIFN,"S")),U,12),IBX=$S(+IBPNT:DT,+IBX:IBX,1:DT),IBFL(86)=$$DATE^IBCF3(IBX)
 Q
 ;
 ;ADD OCCURRENCE CODES AND SPANS TO PRINT ARRAY
32 ;the following rules apply to printing occurrence codes and spans (see FL 32 in UB-92 manual)
 ; - fields 32a-36a are used before 32b-36b
 ; - if all occ code fields are used (32a&b -35a&b) then occ span fields (36a&b) may be used, w/ thru date blank
 ; - if all occ span fields are used (36a&b) the occ code fields 34&35 may be used, w/ code&from date in 34 and code&thru date in 35
 ;
 K IB32,IB36 S IBPG=0 F IBI=32:1:36 K IBFL(IBI) S IBFL(IBI)="0^0"
 ;occurrence codes/span and dates 32-35 ,36
 ;load codes and spans into two flat arrays
 S (IBI,IBJ,IBX)=0
 F  S IBX=$O(^DGCR(399,+IBIFN,"OC",IBX)) Q:'IBX  S IBY=$G(^(IBX,0)),IBZ=$G(^DGCR(399.1,+IBY,0)) I +$P(IBZ,U,4) D
 . I +$P(IBZ,U,10) S IBJ=IBJ+1,IB36(IBJ)=$P(IBZ,U,2)_U_$$DATE^IBCF3($P(IBY,U,2))_U_$$DATE^IBCF3($P(IBY,U,4)) Q
 . S IBI=IBI+1,IB32(IBI)=$P(IBZ,U,2)_U_$$DATE^IBCF3($P(IBY,U,2))
 S IB32=IBI_U_0
 S IB36=IBJ_U_0
 ;
OCC ;
 S IBPG=IBPG+1
 S IBI=+$G(IBFL(32))+1
 I +IB32 F IBI=IBI,IBI+1 S IBX=+$P(IB32,U,2) F IBJ=32,33,34,35 S IBX=$O(IB32(IBX)) Q:'IBX  D
 . S IBFL(IBJ,IBI)=IB32(IBX)
 . S $P(IBFL(IBJ),U,1)=+IBFL(IBJ)+1
 . S $P(IB32,U,1)=+IB32-1
 . S $P(IB32,U,2)=IBX
 ;
 S IBX=+$P(IB36,U,2),IBI=+$G(IBFL(36))+1
 I +IB36 F IBI=IBI,IBI+1 S IBX=$O(IB36(IBX)) Q:'IBX  D
 . S IBFL(36,IBI)=IB36(IBX)
 . S $P(IBFL(36),U,1)=+IBFL(36)+1
 . S $P(IB36,U,1)=+IB36-1
 . S $P(IB36,U,2)=IBX
 ;
 I 'IB32,'IB36 G END
 ;
 ; add occ codes from 32 to occ span in 36
 S IBI=+IBFL(36)+1 F IBI=IBI,IBI+1 I +IB32>0,'IB36,IBI'>(IBPG*2) D
 . S IBX=+$P(IB32,U,2),IBX=$O(IB32(IBX)) Q:'IBX
 . S IBY=IB32(IBX)
 . S $P(IB32,U,1)=+IB32-1
 . S $P(IB32,U,2)=IBX
 . S IBX=+IBFL(36)+1
 . S IBFL(36,IBX)=IBY
 . S $P(IBFL(36),U,1)=+IBFL(36)+1
 ;
 ; add occ span from 36 to occ code in 32
 S IBI=+IBFL(34)+1 F IBI=IBI,IBI+1 I +IB36>0,'IB32,IBI'>(IBPG*2) D
 . S IBX=+$P(IB36,U,2),IBX=$O(IB36(IBX)) Q:'IBX
 . S IBY=IB36(IBX)
 . S $P(IB36,U,1)=+IB36-1
 . S $P(IB36,U,2)=IBX
 . S IBX=+IBFL(34)+1
 . S IBFL(34,IBX)=$P(IBY,U,1)_U_$P(IBY,U,2),$P(IBFL(34),U,1)=+IBFL(34)+1
 . S IBFL(35,IBX)=$P(IBY,U,1)_U_$P(IBY,U,3),$P(IBFL(35),U,1)=IBX
 G OCC
END ;
 K IB32,IB36
 Q
