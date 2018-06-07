IBY568PO ;ALB/BAA - Post install routine for patch 568; 5-AUG-16
 ;;2.0;INTEGRATED BILLING;**568**;21-MAR-94;Build 40
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; This post-install routine will create a new security key
 ; called IB PARAMETER EDIT.
 ; It will be added to two menu options/
 ; 
 ; The new IB PARAMETER EDIT key will be used to lock
 ;
 ;      IBT EDIT TRACKING PARAMETERS
 ;      IBJ MCCR SITE PARAMETERS
 ; 
 ; This routine will add PROSTHETICS to Plan Coverage Limitations file
 ;
 ; This routine will add three new rate types and the rate scheduals for each.
 ;
 ;      HUMANITARIAN REIMB. INS.
 ;      INELIGIBLE REIMB. INS.
 ;      DENTAL REIMB. INS
 ;
 ;
START ; CALL SECTIONS
 D MES^XPDUTL("  Starting post-install for IB*2.0*568")
 D RIDER
 D PLAN
 D ADDRT
 D ADDRS ; add Rate Schedules    (363)
 D NEWIBER
 ; Completion message
 D MES^XPDUTL("  Finished post-install for IB*2.0*568")
 Q
 ;
RIDER ; add Prostihetic Insurance Rider (355.6)
 N IBNAME,DD,DO,DLAYGO,DIC,X,Y,IBDA,IBARR,IBX
 D MES^XPDUTL("  ")
 ;
 S IBNAME="PROSTHETICS COVERAGE"
 I $O(^IBE(355.6,"B",IBNAME,0)) S IBX="   - "_IBNAME_" Insurance Rider (355.6) already exists, no change" D MES^XPDUTL(IBX) Q
 ;
 K DD,DO S DLAYGO=355.6,DIC="^IBE(355.6,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC I Y<1 K X,Y Q
 S IBDA=+Y
 ;
 S IBX="   * "_IBNAME_" Insurance Rider (355.6) added" D MES^XPDUTL(IBX)
 Q
 ;
PLAN ; add Prosthetics to Plan Coverage Limitations 
 D MES^XPDUTL("Adding PROSTHETICS to Plan Coverage Limitations file...")
 N IBA,IBNAME,IBRIDER,IBRDA,IBX,DD,DO,DLAYGO,DIC,X,Y,IBDA,DIE,DA,DR,IBFILE
 S IBFILE=" Plan Limitation Category (#355.31) "
 ;
 S IBNAME="PROSTHETICS",IBRIDER="PROSTHETICS COVERAGE"
 S IBRDA=$O(^IBE(355.6,"B",IBRIDER,0)) I 'IBRDA S IBX="   - "_IBNAME_IBFILE_"Not Added, Rider Missing" D MES^XPDUTL(IBX) Q
 ;
 I $O(^IBE(355.31,"B",IBNAME,0)) S IBA=">> "_IBNAME_IBFILE_"exists, no change" D MES^XPDUTL(IBA) Q
 ;
 K DD,DO S DLAYGO=355.31,DIC="^IBE(355.31,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC S IBDA=+Y I Y<1 K X,Y Q
 ;
 S DIE="^IBE(355.31,",DA=+IBDA,DR=".02///Prosthetics coverage" D ^DIE K DIE,DA,DR,X,Y
 ;
 D MES^XPDUTL("Prosthetics Plan added.....")
 ;
 Q
 ;
ADDRT ; Add Rate Types (399.3)
 N IBA,IBCNT,FLG,IBI,REC,C,DONE,RTNAM,RTNUM
 S IBCNT=0
 ;
 D MES^XPDUTL("     -> Adding new Rate Type entries to file 399.3 ...")
 ;
 S C=";",(FLG,IBCNT)=0
 F RTNUM=19,20,21 D
 . S IBI="RT"_RTNUM
 . S REC=$P($T(@IBI),";",3,99)
 . S RTNAM=$P(REC,C,1)
 . ; do a lookup and quit if exists.
 . S DONE=$$NEW(RTNAM,RTNUM,REC) Q:DONE=-1
 . ;
 . D MES^XPDUTL("New Rate Type "_RTNAM_" added") S FLG=1,IBCNT=IBCNT+1
 ;
RTQ I FLG S IBA(1)="      >> "_IBCNT_" Rate Types added (399.3)..." D MES^XPDUTL(.IBA)
 Q
 ;
NEW(NAM,NUM,REC) ; create new rate type
 ; see if entry exists
 N DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,RN,OUT
 S X=NAM
 S DIC="^DGCR(399.3," D ^DIC S OUT=+Y
 I OUT>0 D MES^XPDUTL("  "_NAM_" already exists.") Q OUT
 ; add entry
 K DO
 S DIC(0)="L",DLAYGO=399.3,DR="",X=NAM,DA=NUM
 D FILE^DICN I +Y=-1 D MES^XPDUTL("        "_NAM_" failed to add!") Q +Y
 S RN=+Y
 S DA=RN
 S DR=".02///"_$P(REC,C,2)_";.03///0"_";.04///"_$P(REC,C,4)_";.05///"_$P(REC,C,5)_";.06///"_$P(REC,C,6)_";.07///"_$P(REC,C,7)
 S DIE="^DGCR(399.3,"
 D ^DIE
 S DIC(0)="L",DLAYGO=399.3,DR="",DA=RN
 S DR=".08///"_$P(REC,C,8)_";.09///1;.1///"_$P(REC,C,10)_";.11///"_$P(REC,C,11)_";580950.1///1"
 S DIE="^DGCR(399.3,"
 D ^DIE
 Q 1
 ;
ADDRS ; Add Rate Schedules (363) for EMERGENCY/HUMANITARIAN REIMB. & INELIGIBLE HOSP. REIMB.
 D MES^XPDUTL("     -> Adding new Rate Schedules to file 363 ...")
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBCNTCS,IBJ,IBLNCS,IBCS,IBCSFN,IBVDT,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBADJST,IBADMIN,IBDISP,IBRN,IBRS,IBRS1,INDT
 S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(RSF+IBI),";;",2) Q:IBLN="END"  I $E(IBLN)?1A D
 . ;Check for problems
 . I $O(^IBE(363,"B",$P(IBLN,U,1),0)) Q  ;Already exists 
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) Q:'IBBS  ;Billable service invalid
 . S IBRN=$P(IBLN,U,1)
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created")
 . ;No problems found, so create entry
 . I IBRN="HR-INPT" S IBNAME="HMN-INPT"
 . I IBRN="HR-OPT" S IBNAME="HMN-OPT"
 . I IBRN="HR-RX" S IBNAME="HMN-RX"
 . I IBRN="HR-OPT DENTAL" S IBNAME="DNTL-OPT DENTAL"
 . I IBRN="IR-INPT" S IBNAME="INELIG-INPT"
 . I IBRN="IR-OPT" S IBNAME="INELIG-OPT"
 . I IBRN="IR-RX" S IBNAME="INELIG-RX"
 . N IBX,IBRSFN,IBRS0 S IBRSFN=0
 . F  S IBRSFN=$O(^IBE(363,"B",IBNAME,IBRSFN))  Q:'IBRSFN  D
 .. S IBRS0=$G(^IBE(363,IBRSFN,0)),IBRS1=$G(^IBE(363,IBNAME,1))
 .. I $P(IBRS0,U,1)=IBNAME D
 ... S IBVDT=$$FMTE^XLFDT($P(IBRS0,U,5),"2DZ"),INDT=$$FMTE^XLFDT($P(IBRS0,U,6),"2DZ")
 ... I IBNAME["RX" S IBDISP=$P(IBRS1,U,1),IBADMIN=$P(IBRS1,U,2),IBADJST=$G(^IBE(363,IBNAME,10))
 ... K DD,DO
 ... S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBLN,U,1)
 ... D FILE^DICN K DIC,DINUM,DLAYGO
 ... I Y<1 K X,Y Q
 ... S IBFN=+Y,IBCNT=IBCNT+1
 ... S DR=".02///"_IBRT_";.03///"_$P(IBLN,U,3) I +IBBS S DR=DR_";.04///"_IBBS
 ... S DR=DR_";.05///^S X=IBVDT;.06///^S X=INDT"
 ... I IBRN["RX",IBDISP]"" S DR=DR_";1.01///"_IBDISP
 ... I IBRN["RX",IBADMIN]"" S DR=DR_";1.02///"_IBADMIN
 ... I IBRN["RX",IBADJST]"" S DR=DR_";10///"_IBADJST
 ... S DIE="^IBE(363,",DA=IBFN D ^DIE K DIE,DA,DR,X,Y
 ... S IBCNTCS=0
 ... ; add all Reasonable Charges Charge Sets
 ... S IBCNTCS=$$RSCS(IBFN,IBVDT,IBRSFN)
 ... D MES^XPDUTL("        Total Charge Set"_$S(IBCNTCS=1:" ",1:"s ")_IBCNTCS_" added to the rate schedule.")
 D MES^XPDUTL("        Rate Schedules completed.")
 Q  ;ADDRS
 ;
 ;
RSCS(IBFN,IBVDT,IBCOPY) ; add existing Charge Sets to HR & IR
 ; copy the Charge Sets from the corresponding RI RS (v2)
 N IBCNT,IBNRS,IBRSNM,IBTY,IBCS,IBXFN,IBCSFN,IBCSNM,IBCSAA,IBNAME
 S IBCNT=0
 S IBNRS=$G(^IBE(363,+$G(IBFN),0)),IBRSNM=$P(IBNRS,"^",1)
 S IBTY=$P(IBNRS,"^",3)
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
 S X=IBCSNM,DIC("DR")=".02///"_$G(IBCSAA),DIC("P")="363.0011P" D ^DIC S:+Y IBX=1
RSCSFQ Q IBX
 ;
 ;
NEWIBER  ;set up new error for COB worklist
 N IB02,IB04,IB05,IBNAME,DD,DO,DLAYGO,DIC,X,Y,IBDA,IBARR,IBX
 D MES^XPDUTL("  ")
 ;
 S IBNAME="IB815"
 S IB02="Balance bill this patient using the appropriate cost-based rate type."
 S IB04="INTEGRATED BILLING"
 S IB05="DISPLAY MESSAGE"
 I $O(^IBE(350.8,"B",IBNAME,0)) S IBX="   - "_IBNAME_" IB Error (350.8) already exists, no change" D MES^XPDUTL(IBX) Q
 ;
 K DD,DO S DLAYGO=350.8,DIC="^IBE(350.8,",DIC(0)="L",X=IBNAME D FILE^DICN
 K DIC I Y<1 K X,Y Q
 S IBDA=+Y
 S RN=+Y
 S DA=RN
 S DR=".02///"_IB02_";.03///"_IBNAME_";.04///"_IB04_";.05///"_IB05
 S DIE="^IBE(350.8,"
 D ^DIE
 ;
 S IBX="   * "_IBNAME_" IB Error (350.8) added" D MES^XPDUTL(IBX)
 Q
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
RSDT(PRE) ;Copy the active RX charge schedule from RI to FR
 N IBCS,IBCS0,IBDISP,IBADMIN,IBADJST
 S IBCS=""
 I PRE="HR" S IBCS=$O(^IBE(363,"B","HMN-RX",""),-1)
 I PRE="IR" S IBCS=$O(^IBE(363,"B","INELIG-RX",""),-1)
 S IBCS0=$G(^IBE(363,IBCS,0))
 S IBDISP=$P($G(^IBE(363,IBCS,1)),U,1),IBADMIN=$P($G(^IBE(363,IBCS,1)),U,2)
 S IBADJST=$G(^IBE(363,IBCS,10))
 Q $P(IBCS0,U,5)
 ;
 ;
NEWRT ;Rate Type
RT19 ;;HUMANITARIAN REIMB. INS.;HUMANITARIAN REIMB. INS.;0;HUM REIM;1;EMERGENCY/HUMANITARIAN REIMB.;i;1;0;1;28
RT20 ;;INELIGIBLE REIMB. INS.;INELIGIBLE REIMB. INS.;0;INE REIM;1;INELIGIBLE HOSP. REIMB.;i;1;0;1;28
RT21 ;;DENTAL REIMB. INS.;DENTAL REIMB. INS.;0;DEN REIM;1;EMERGENCY/HUMANITARIAN REIMB.;i;1;0;1;28
 ;;END
 ;
RSF ;Rate Schedules (363) for EMERGENCY/HUMANITARIAN REIMB. & INELIGIBLE HOSP. REIMB.
 ;;HR-INPT^HUMANITARIAN REIMB. INS.^1^INPATIENT
 ;;HR-OPT^HUMANITARIAN REIMB. INS.^3
 ;;HR-RX^HUMANITARIAN REIMB. INS.^3
 ;;HR-OPT DENTAL^DENTAL REIMB. INS.^3
 ;;IR-INPT^INELIGIBLE REIMB. INS.^1^INPATIENT
 ;;IR-OPT^INELIGIBLE REIMB. INS.^3
 ;;IR-RX^INELIGIBLE REIMB. INS.^3
 ;;END
