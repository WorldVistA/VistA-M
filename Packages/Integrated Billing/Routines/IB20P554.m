IB20P554 ;ALB/DRF - IB*2.0*554 Post Init: Rate Type Update;09/30/15 7:55am
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ; Derived from IBYPPC, post-init for IB*2.0*52
 ;IB*2.0*554/DRF
 N I,J,RTDATA,DA,DR,DIC,DIE,DIK,X,Y
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine ...")
 D ADDRT ; add Rate Type         (399.3)
 D ADDER ; add Billing Errors    (350.8)
 D ADDRS ; add Rate Schedules    (363)
 D BMES^XPDUTL(" >>  Completed the Post-Initialization routine.")
 Q  ;POSTINIT
 ;
 ;
ADDRT ;Add rate type for NON-VA reimbursable insurance
 N LIN,RTDATA,DIC,DIE,X,Y,J,DLAYGO,DR
 D MES^XPDUTL("     -> Adding new Rate Types to file 399.3 ...")
 F LIN=1:1 D  Q:RTDATA="END"
 . S RTDATA=$P($T(NEWRT+LIN),";",3,99)
 . Q:RTDATA="END"
 . ; do a lookup and go on if exists.
 . S DIC="^DGCR(399.3,",X=$P(RTDATA,";") D ^DIC
 . I +Y>0 D  Q
 .. D MES^XPDUTL("        "_$P(RTDATA,";")_" already exists.")
 . ; add entry
 . K DO
 . S DIC(0)="L",DLAYGO=399.3,DR=""
 . D FILE^DICN
 . I +Y=-1 D  Q
 .. D MES^XPDUTL("        "_$P(RTDATA,";")_" failed to add!")
 . S DA=+Y
 . S DR=".02////"_$P(RTDATA,";",2)_";"
 . F J=3:1:6,8:1:11 S DR=$G(DR)_(J/100)_"///"_$P(RTDATA,";",J)_";"
 . S DIE=DIC K DIC
 . D ^DIE
 D MES^XPDUTL("        Rate Types completed.")
 Q  ;ADDRT
 ;
 ;
ADDER ;Add Billing Errors for NON-VA rate type
 D MES^XPDUTL("     -> Adding new Billing Errors to file 350.8 ...")
 F I=1:1 D  Q:RTDATA="END"
 . S RTDATA=$P($T(NEWBE+I),";",3,99)
 . Q:RTDATA="END"
 . ; do a lookup and go on if exists.
 . S DIC="^IBE(350.8,",X=$P(RTDATA,";") D ^DIC
 . I +Y>0 D  Q
 .. D MES^XPDUTL("        "_$P(RTDATA,";")_" already exists!")
 . ; add entry
 . S X=$P(RTDATA,";") D FILE^DICN
 . I +Y=-1 D  Q
 .. D MES^XPDUTL("        "_$P(RTDATA,";")_" failed to add!")
  . ;set fields
 . S DIE=DIC K DIC
 . S DA=+Y
 . F J=2:1:5 S DR=$G(DR)_(J/100)_"////"_$P(RTDATA,";",J)_";"
 . D ^DIE
 D MES^XPDUTL("     -> Billing Errors completed.")
 Q  ;ADDER
 ;
 ;
ADDRS ; Add Rate Schedules (363) for FEE REIMB INS
 D MES^XPDUTL("     -> Adding new Rate Schedules to file 363 ...")
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBCNTCS,IBDISP,IBJ,IBLNCS,IBCS,IBCSFN,IBADMIN,DD,DO,DLAYGO,DIC,DIE,DA,DR,RXDT,X,Y S IBCNT=0
 F IBI=1:1 S IBLN=$P($T(RSF+IBI),";;",2) Q:IBLN="END"  I $E(IBLN)?1A D
 . ;Check for problems
 . I $O(^IBE(363,"B",$P(IBLN,U,1),0)) Q  ;Already exists
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) Q:'IBBS  ;Billable service invalid
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created")
 . ;No problems found, so create entry
 . K DD,DO
 . S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBLN,U,1)
 . D FILE^DICN K DIC,DINUM,DLAYGO
 . I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . S DR=".02////"_IBRT_";.03////"_$P(IBLN,U,3) I +IBBS S DR=DR_";.04////"_IBBS
 . S DR=DR_";.05////"_$S($P(IBLN,U,1)["RX":3110318,1:3031219)
 . I $P(IBLN,U,1)["RX" S RXDT=$$RXDT()
 . I $P(IBLN,U,1)["RX",IBDISP]"" S DR=DR_";1.01///"_IBDISP
 . I $P(IBLN,U,1)["RX",IBADMIN]"" S DR=DR_";1.02////"_IBADMIN
 . S DIE="^IBE(363,",DA=+Y D ^DIE K DIE,DA,DR,X,Y
 . S IBCNTCS=0
 . ; add all Reasonable Charges Charge Sets
 . S IBCNTCS=$$RSCS(IBFN)
 . D MES^XPDUTL("        Total Reasonable Charge Set"_$S(IBCNTCS=1:" ",1:"s ")_IBCNTCS_" added to the rate schedule.")
 D MES^XPDUTL("        Rate Schedules completed.")
 Q  ;ADDRS
 ;
RSCS(IBFN) ; add existing Charge Sets to FR
 ; copy the Charge Sets from the corresponding RI RS (v2)
 N IBCNT,IBNRS,IBRSNM,IBTY,IBVDT,IBCOPY,IBCS,IBCS0,IBXFN,IBCSFN,IBCSNM,IBCSAA,IBNAME
 S (IBCNT,IBCOPY)=0
 S IBNRS=$G(^IBE(363,+$G(IBFN),0)),IBRSNM=$P(IBNRS,"^",1)
 S IBTY=$P(IBNRS,"^",3)
 S IBVDT=$$VERSDT^IBCRU8(2)
 I IBRSNM["INPT" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-INPT")
 I IBRSNM["SNF" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-SNF")
 I IBRSNM["OPT" S IBCOPY=+$$RSEXISTS(IBVDT,"RI-OPT")
 I IBRSNM["RX" S IBVDT=RXDT S IBCOPY=$$RSEXISTS(IBVDT,"RI-RX")
 I 'IBCOPY G RSCSQ
 I +$P($G(^IBE(363,+IBCOPY,0)),U,3)=IBTY D
 . S IBXFN=0 F  S IBXFN=$O(^IBE(363,IBCOPY,11,IBXFN)) Q:'IBXFN  D
 .. S IBCS=$G(^IBE(363,IBCOPY,11,IBXFN,0)),IBCSFN=+IBCS
 .. I +$$RSCSFILE(IBFN,$P($G(^IBE(363.1,IBCSFN,0)),U,1),$P(IBCS,U,2)) S IBCNT=IBCNT+1
RSCSQ Q IBCNT
 ;
 ;
RSCSFILE(IBFN,IBCSNM,IBCSAA) ; Add Charge Set to a Rate Schedule
 N IBX,DD,DO,DLAYGO,DIC,DA,DR,X,Y,IBCSFN S IBX=0
 I $G(^IBE(363,+$G(IBFN),0))="" G RSCSFQ
 I $G(IBCSNM)="" G RSCSFQ
 S IBCSFN=$O(^IBE(363.1,"B",IBCSNM,0)) I 'IBCSFN G RSCSFQ
 I $O(^IBE(363,IBFN,11,"B",IBCSFN,0)) G RSCSFQ
 S DLAYGO=363,DA(1)=+IBFN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L"
 S X=IBCSNM,DIC("DR")=".02///"_$G(IBCSAA),DIC("P")="363.0011P"
 D ^DIC S:+Y IBX=1
RSCSFQ Q IBX
 ;
 ;
RSEXISTS(IBVDT,IBNAME) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,1)=IBNAME,$P(IBRS0,U,5)=IBVDT S IBX=IBRSFN
 Q IBX
 ;
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q  ;MSG
 ;
 ;
RXDT() ;Copy the active RX charge schedule from RI to FR
 S IBCS="",IBCS=$O(^IBE(363,"B","RI-RX",IBCS),-1)
 S IBCS0=^IBE(363,IBCS,0)
 S IBDISP=$P($G(^IBE(363,IBCS,1)),U,1),IBADMIN=$G(^IBE(363,IBCS,10))
 Q $P(IBCS0,U,5)
 ;
 ;
NEWRT ;Rate Type
 ;;FEE REIMB INS;FEE REIMB INS;;FEE INS;1;45;;1;1;1;28
 ;;END
 ;
NEWBE ;Billing Errors
 ;;INCORRECT NON-VA RATE;Non-VA rate type used for bill that is not Non-VA;IB360;1;1
 ;;NON-VA RATE TYPE REQUIRED;Non-VA bill requires use of Non-VA rate type;IB361;1;1
 ;;END
 ;
RSF ;Rate Schedules (363) for FEE REIMB INS
 ;;FR-INPT^FEE REIMB INS^1^INPATIENT
 ;;FR-SNF^FEE REIMB INS^1^SKILLED NURSING
 ;;FR-OPT^FEE REIMB INS^3
 ;;FR-RX^FEE REIMB INS^3
 ;;END
 ;
CLM ;CLAIMS TRACKING TYPE FILE (356.6)
 ;;OPT-NON VA CARE^ONVC^2^1^1^1^^6
 ;;INP-NON VA CARE^INVC^1^^10^^^7
 ;;RX-NON VA CARE^RXNVC^3^1^5^1^^8
 ;;END
