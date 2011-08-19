IBCRHBRA ;ALB/ARH - RATES: UPLOAD RC V1 CPT 2000 CHARGES ; 10-OCT-2000
 ;;2.0;INTEGRATED BILLING;**138,169**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
 ; add CPT 2000 Replacement Codes to RC v1
 ; these are new codes that directly replace codes that have been inactivated, the charges for the old code
 ; can be used as the charge for the new code
 ;
CPT2000 ; add CPT replacement codes to RC charge sets, use the current charge of the CPT they are replacing
 N IBI,IBLN,IBOLD,IBNEW,IBITM,IBCI,IBCIN,IBCS,IBCSN,IBCNT,IB2000DT,X,Y,DIC,IBENDDT S IBCNT=0
 S IB2000DT=3000201
 S IBENDDT=$$VERSEDT^IBCRHBRV(1)
 ;
 I '$D(ZTQUEUED) W !!,"Adding CPT 2000 Replacement Charges for RC v1 ... "
 F IBI=1:1 S IBLN=$P($T(F2000+IBI),";;",2) Q:IBLN=""  I $E(IBLN,1)'=" " D
 . ;
 . S IBOLD=$P(IBLN,U,1) I IBOLD'?5N Q
 . S IBNEW=$P(IBLN,U,2) I IBNEW'?5N Q
 . ;
 . S IBITM=IBOLD_";ICPT(",IBCI=0 F  S IBCI=$O(^IBA(363.2,"B",IBITM,IBCI)) Q:'IBCI  D
 .. ;
 .. S IBCIN=$G(^IBA(363.2,+IBCI,0)) I $P(IBCIN,U,3)'=2990901,$P(IBCIN,U,3)'=2981001 Q
 .. S IBCS=$P(IBCIN,U,2),IBCSN=$G(^IBE(363.1,+IBCS,0)) I '$$CSRC(IBCS) Q
 .. ;
 .. D DEL(IBCS,IBNEW,IB2000DT,$P(IBCIN,U,5))
 .. I $$EXISTS(IBCS,IBNEW,IB2000DT,$P(IBCIN,U,5)) Q
 .. ;
 .. I $$ADDCI^IBCREF(IBCS,IBNEW,IB2000DT,$P(IBCIN,U,5),$P(IBCIN,U,6),$P(IBCIN,U,7),IBENDDT) S IBCNT=IBCNT+1
 ;
 I '$D(ZTQUEUED) W IBCNT," charges added."
 Q
 ;
EXISTS(IBCS,IBITM,IBEFFDT,IBCHG) ; return ifn of charge item if this charge exists
 N IBX,IBCI S IBX=0
 I +$G(IBCS),+$G(IBITM),+$G(IBEFFDT),+$G(IBCHG) D
 . S IBCI=0 F  S IBCI=$O(^IBA(363.2,"AIVDTS"_IBCS,IBITM,-IBEFFDT,IBCI)) Q:'IBCI  D  Q:+IBX
 .. I $P($G(^IBA(363.2,+IBCI,0)),U,5)=IBCHG S IBX=IBCI
 Q IBX
 ;
DEL(IBCS,IBITM,IBEFFDT,IBCHG) ; delete any existing charges the site may have added to the charge sets for the New CPT replacement codes
 ; the charge to be deleted must be effective before RC v1.1 and it must not be the correct replacement, 
 ; ie. delete any v1 charge for the item in a CS that does not match the date/charge passed in
 N IBDT,IBCI,IBCIN,IBCNT,X,Y,DIC,DIK,DA S IBCNT=0 I '$G(IBEFFDT)!('$G(IBCHG)) Q
 ;
 S IBDT="" F  S IBDT=$O(^IBA(363.2,"AIVDTS"_+$G(IBCS),+$G(IBITM),IBDT)) Q:IBDT=""  D
 . I -IBDT>3000701 Q
 . ;
 . S IBCI=0 F  S IBCI=$O(^IBA(363.2,"AIVDTS"_IBCS,IBITM,IBDT,IBCI)) Q:'IBCI  D
 .. S IBCIN=$G(^IBA(363.2,+IBCI,0)) I -IBDT=IBEFFDT,IBCHG=$P(IBCIN,U,5) Q
 .. ;
 .. S DA=IBCI,DIK="^IBA(363.2," D ^DIK K DA,DIK S IBCNT=IBCNT+1
 ;
 Q
 ;
CSRC(IBCS) ; return true if the Charge Set is Reasonable Charges and CPT based
 N IBX,IBCSN,IBBRN S IBX=0
 I +$G(IBCS) S IBCSN=$G(^IBE(363.1,+IBCS,0))
 I $G(IBCSN)'="" S IBBRN=$G(^IBE(363.3,+$P(IBCSN,U,2),0))
 ;
 I $G(IBBRN)'="",$E(IBBRN,1,3)="RC ",$P(IBBRN,U,4)=2 S IBX=1
 ;
 Q IBX
 ;
 ;
F2000 ; old^new CPTs
 ;;32001^32997
 ;;56300^49320
 ;;56301^58670
 ;;56302^58671
 ;;56303^58662
 ;;56304^58660
 ;;56305^49321
 ;;56306^49322
 ;;56307^58661
 ;;56308^58550
 ;;56309^58551
 ;;56310^44200
 ;;56311^38570
 ;;56312^38571
 ;;56313^38572
 ;;56314^49323
 ;;56315^44970
 ;;56316^49650
 ;;56317^49651
 ;;56318^54690
 ;;56320^55550
 ;;56322^43651
 ;;56323^43652
 ;;56324^47570
 ;;56340^47562
 ;;56341^47563
 ;;56342^47564
 ;;56343^58673
 ;;56344^58672
 ;;56346^43653
 ;;56348^44202
 ;;56349^43280
 ;;56350^58555
 ;;56351^58558
 ;;56352^58559
 ;;56353^58560
 ;;56354^58561
 ;;56355^58562
 ;;56356^58563
 ;;56362^47560
 ;;56363^47561
 ;;64442^64475
 ;;64443^64476
 ;;80049^80048
 ;;80054^80053
 ;;80058^80076
 ;;80059^80074
 ;;
