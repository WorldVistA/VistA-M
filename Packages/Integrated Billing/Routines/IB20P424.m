IB20P424 ;ALB/CXW-IB*2*424 POST INIT RS FOR CHAMPVA/CHAMPVA RI;16-SEP-09
 ;;2.0;INTEGRATED BILLING;**424**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; 
 Q
POST ;
 N IBA,IBEFFDT,EFFDT
 D MSG("    IB*2*424 Post-Install ....."),MSG(" ")
 ;
 S IBEFFDT=3100101 ;            effective date of new RS
 ;
 D ADDORS(IBEFFDT) ;     inactivate existing CHAMPVA/CHAMPVA RI Rate Schedules
 D ADDNRS(IBEFFDT) ;     add new Rate Schedules linking CHAMPVA Reasonable Charges
 ;
 D MSG("    IB*2*424 Post-Install Complete")
 Q
 ;
ADDORS(EFFDT) ;Inactivate Existing CHAMPVA/CHAMPVA RI Rate Schedules
 N INEFFDT,IBORS,IBORSFN,IBORSNM,IBORSTY,IBRATY,IBCNT
 S IBCNT=0
 ;
 ;return the day before the effective date
 I +$G(EFFDT) S INEFFDT=$$FMADD^XLFDT(EFFDT,-1)
 I 'INEFFDT D MSG("**Error: No Date, could not inactivate old RS for CHAMPVA/CHAMPVA RI") Q
 ;
 S IBORSFN=0 F  S IBORSFN=$O(^IBE(363,IBORSFN)) Q:'IBORSFN  D
 . S IBORS=$G(^IBE(363,IBORSFN,0))
 . ;
 . S IBORSNM=$P(IBORS,U,1)
 . S IBORSTY=$P(IBORS,U,2)
 . Q:'IBORSTY   ;quit if no rate type
 . ;
 . S IBRATY=$P($G(^DGCR(399.3,+IBORSTY,0)),U,1)
 . I IBRATY'["CHAMPVA" Q  ; CHAMPVA/CHAMPVA RI only
 . ;
 . I $P(IBORS,U,5)=EFFDT Q  ;quit if active date exists
 . I ($P(IBORS,U,6)="")!($P(IBORS,U,6)>INEFFDT) D
 . . S IBCNT=IBCNT+1,DR=".06////"_INEFFDT,DIE="^IBE(363,",DA=+IBORSFN D ^DIE K DIE,DA,DR,X,Y
 . . D MSG("      >> Inactivating Rate Schedule: "_IBORSNM)
 D MSG("Total Rate Schedules: "_IBCNT_$S(IBCNT=1:" has",1:" have")_" been inactivated on "_$$FMTE^XLFDT(INEFFDT,2)_" (363)")
 D MSG(" ")
 Q
ADDNRS(EFFDT) ; add CAHMPVA/CHAMPVA REIMB. INS. Rate Schedules (363) if they don't exist
 ;
 N IBI,IBJ,IBCNT,IBCNTCS,IBNRS,IBBVS,IBRT,IBDT,IBRS,IBFN
 S IBCNT=0,IBDT=+$G(EFFDT)
 I 'IBDT D MSG("**Error: No Date, could not link Rate Schedules to Charge Sets") Q
 F IBI=1:1 S IBNRS=$P($T(NRSF+IBI),";;",2) Q:+IBNRS!(IBNRS="")  I $E(IBNRS)?1A D
 . I $O(^IBE(363,"B",$P(IBNRS,U,1),0)) D MSG("** No Change, Rate Schedule linking "_$P(IBNRS,U,1)_" and RC already exists") Q
 . S IBBVS=$P(IBNRS,U,4) I IBBVS'="" S IBBVS=$$MCCRUTL(IBBVS,13) D  Q:'IBBVS
 .. I 'IBBVS D MSG("** Error: Billable Service "_$P(IBNRS,U,4)_" not defined, "_$P(IBNRS,U,1)_" not created") Q
 . ;
 . S IBRT=$P(IBNRS,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("** Error: Rate Type "_$P(IBNRS,U,2)_" not defined, "_$P(IBNRS,U,1)_" not created!!!")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("** Warning: Rate Type "_$P(IBNRS,U,2)_" not Active, RS "_$P(IBNRS,U,1)_" not created")
 . ;
 . F IBJ=1:1 S IBRS=$G(^IBE(363,IBJ,0)) I IBRS="" S DINUM=IBJ Q
 . ;
 . K DD,DO S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBNRS,U,1) D FILE^DICN K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1,IBCNTCS=0
 . ;
 . S DR=".02////"_IBRT_";.03////"_$P(IBNRS,U,3) S:+IBBVS DR=DR_";.04////"_IBBVS S DR=DR_";.05////"_IBDT
 . ;I $P(IBNRS,U,6)'="" S DR=DR_";1.02////"_$P(IBNRS,U,6) ;admin fee
 . I $P(IBNRS,U,7)'="" S DR=DR_";10////^S X=$P(IBNRS,U,7)"
 . S DIE="^IBE(363,",DA=+Y D ^DIE K DIE,DA,DR,X,Y
 . D MSG("      >> Adding Rate Schedule: "_$P(IBNRS,U))
 . S IBCNTCS=IBCNTCS+$$RSCS(IBFN) ; add all Reasonable Charges Charge Sets
 . ;
 . I 'IBCNTCS D MSG("** Warning: No Charge Sets added to RS "_$P(IBNRS,U,1))
 D MSG("Total Rate Schedules: "_IBCNT_$S(IBCNT=1:" has",1:" have")_" been added and activated on "_$$FMTE^XLFDT(IBDT,2)_" (363)")
 D MSG(" ")
 Q
 ;
RSCS(IBFN) ; add existing Charge Sets to RC, return number added
 ; copy the Charge Sets from the corresponding RI RS (v2)
 ; add the Charge Sets - RX COST
 N IBCNT,IBNRS,IBRSNM,IBTY,IBVDT,IBCOPY,IBCS,IBXFN,IBCSFN,IBCSNM,IBCSAA
 S (IBCNT,IBCOPY)=0
 ;
 S IBNRS=$G(^IBE(363,+$G(IBFN),0)),IBRSNM=$P(IBNRS,U,1)
 S IBTY=$P(IBNRS,U,3)
 S IBVDT=$$VERSDT^IBCRU8(2)
 I IBRSNM["INPT" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-INPT")
 I IBRSNM["SNF" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-SNF")
 I IBRSNM["OPT" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-OPT")
 I IBRSNM["RX",+$$RSCSFILE(IBFN,"RX COST",1) S IBCNT=IBCNT+1
 ;
 I 'IBCOPY G RSCSQ
 I +$P($G(^IBE(363,+IBCOPY,0)),U,3)=IBTY D
 . ;
 . S IBXFN=0 F  S IBXFN=$O(^IBE(363,IBCOPY,11,IBXFN)) Q:'IBXFN  D
 .. S IBCS=$G(^IBE(363,IBCOPY,11,IBXFN,0)),IBCSFN=+IBCS
 .. I +$$RSCSFILE(IBFN,$P($G(^IBE(363.1,IBCSFN,0)),U,1),$P(IBCS,U,2)) S IBCNT=IBCNT+1
 ;
RSCSQ Q IBCNT
 ;
RSCSFILE(IBFN,IBCSNM,IBCSAA) ; Add Charge Set to a Rate Schedule
 N IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBCSFN S IBX=0
 I $G(^IBE(363,+$G(IBFN),0))="" G RSCSFQ
 I $G(IBCSNM)="" G RSCSFQ
 S IBCSFN=$O(^IBE(363.1,"B",IBCSNM,0)) I 'IBCSFN G RSCSFQ
 I $O(^IBE(363,IBFN,11,"B",IBCSFN,0)) G RSCSFQ
 ;
 S DLAYGO=363,DA(1)=+IBFN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L",X=IBCSNM,DIC("DR")=".02////"_$G(IBCSAA),DIC("P")="363.0011P" D ^DIC K DIC,DIE S IBX=1
RSCSFQ Q IBX
 ;
RSEXISTS(EFFDT,NAME) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 I +$G(EFFDT),$G(NAME)'="" S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,1)=NAME,$P(IBRS0,U,5)=EFFDT S IBX=IBRSFN
 Q IBX
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
 ;
MSG(X) ;
 D MES^XPDUTL(X)
 Q
NRSF ;New Rate Schedules (363)
 ;; rs name^rate type^bill type^billable service^effective date^
 ;; administrative fee^adjustment
 ;;CVA-INPT^CHAMPVA^1^^^^
 ;;CVA-SNF^CHAMPVA^1^SKILLED NURSING^^^
 ;;CVA-OPT^CHAMPVA^3^^^^
 ;;CVA-RX^CHAMPVA^3^^^^S X=X+5
 ;;CVA RI-INPT^CHAMPVA REIMB. INS.^1^^^^
 ;;CVA RI-SNF^CHAMPVA REIMB. INS.^1^SKILLED NURSING^^^
 ;;CVA RI-OPT^CHAMPVA REIMB. INS.^3^^^^
 ;;CVA RI-RX^CHAMPVA REIMB. INS.^3^^^^S X=X+5
 ;;
 ;
