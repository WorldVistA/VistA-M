IB20P498 ;ALB/CXW - post init for IB*2.0*498 ;04-05-2013
 ;;2.0;INTEGRATED BILLING;**498**;21-MAR-94;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
POST ; update Rate Schedules (363) for CHAMPVA & CHAMPVA RI
 D MES^XPDUTL("Patch Post-Install starts...")
 ;
 N IBI,IBCNTCS,IBNRS,IBIDT,IBFN
 F IBI=1:1 S IBNRS=$P($T(RSF+IBI),";;",2) Q:+IBNRS!(IBNRS="")  I $E(IBNRS)?1A D
 . S IBFN=$O(^IBE(363,"B",$P(IBNRS,U),0))
 . I 'IBFN D MES^XPDUTL("** No Update, Rate Schedule "_$P(IBNRS,U)_" doesn't exist.") Q
 . S IBIDT=+$P($G(^IBE(363,IBFN,0)),U,6)
 . ; champva & champva reim. effective date 3100101
 . I IBIDT,(IBIDT<3100101) D MES^XPDUTL("** No Update, Rate Schedule "_$P(IBNRS,U)_" is inactive from "_$$FMTE^XLFDT(IBIDT,2)_".") Q
 . S IBCNTCS=0
 . D MES^XPDUTL("  >> Updating "_$P(IBNRS,U)_" rate schedule for "_$P(IBNRS,U,2)_" rate type.")
 . ; add all Reasonable Charges Charge Sets
 . S IBCNTCS=$$RSCS(IBFN)
 . D MES^XPDUTL("       Total Charge Set"_$S(IBCNTCS=1:" ",1:"s ")_IBCNTCS_" added to the rate schedule.")
 ;
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
 ;
RSCS(IBFN) ; add existing Charge Sets to CVA & CVA RI
 ; copy the Charge Sets from the corresponding RI RS (v2)
 N IBCNT,IBNRS,IBRSNM,IBTY,IBVDT,IBCOPY,IBCS,IBXFN,IBCSFN,IBCSNM,IBCSAA,IBNAME
 S (IBCNT,IBCOPY)=0
 ;
 S IBNRS=$G(^IBE(363,+$G(IBFN),0)),IBRSNM=$P(IBNRS,U,1)
 S IBTY=$P(IBNRS,U,3)
 S IBVDT=$$VERSDT^IBCRU8(2)
 I IBRSNM["INPT" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-INPT")
 I IBRSNM["SNF" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-SNF")
 I IBRSNM["OPT" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-OPT")
 ;
 I 'IBCOPY G RSCSQ
 I +$P($G(^IBE(363,+IBCOPY,0)),U,3)=IBTY D
 . S IBXFN=0 F  S IBXFN=$O(^IBE(363,IBCOPY,11,IBXFN)) Q:'IBXFN  D
 .. S IBCS=$G(^IBE(363,IBCOPY,11,IBXFN,0)),IBCSFN=+IBCS
 .. I +$$RSCSFILE(IBFN,$P($G(^IBE(363.1,IBCSFN,0)),U,1),$P(IBCS,U,2)) S IBCNT=IBCNT+1
 ;
RSCSQ Q IBCNT
 ;
RSCSFILE(IBFN,IBCSNM,IBCSAA) ; Add Charge Set to a Rate Schedule
 N IBX,DD,DO,DLAYGO,DIC,DA,DR,X,Y,IBCSFN S IBX=0
 I $G(^IBE(363,+$G(IBFN),0))="" G RSCSFQ
 I $G(IBCSNM)="" G RSCSFQ
 S IBCSFN=$O(^IBE(363.1,"B",IBCSNM,0)) I 'IBCSFN G RSCSFQ
 I $O(^IBE(363,IBFN,11,"B",IBCSFN,0)) G RSCSFQ
 ;
 S DLAYGO=363,DA(1)=+IBFN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L"
 S X=IBCSNM,DIC("DR")=".02///"_$G(IBCSAA),DIC("P")="363.0011P" D ^DIC S:+Y IBX=1
RSCSFQ Q IBX
 ;
RSEXISTS(IBVDT,IBNAME) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,1)=IBNAME,$P(IBRS0,U,5)=IBVDT S IBX=IBRSFN
 Q IBX
 ;
RSF ; Rate Schedules (363) for CHAMPVA & CHAMPVA RI
 ;; rs name^rate type
 ;;CVA-INPT^CHAMPVA
 ;;CVA-SNF^CHAMPVA
 ;;CVA-OPT^CHAMPVA
 ;;CVA RI-INPT^CHAMPVA REIMB. INS.
 ;;CVA RI-SNF^CHAMPVA REIMB. INS.
 ;;CVA RI-OPT^CHAMPVA REIMB. INS.
 ;;
 ;
