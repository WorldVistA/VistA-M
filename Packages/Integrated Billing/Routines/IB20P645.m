IB20P645 ;SAB/Albany - IB*2.0*645 POST INSTALL;12/11/17 2:10pm
 ;;2.0;Integrated Billing;**645**;Mar 20, 1995;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*645
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*645 ")
 ; Update Community Care No Fault Rate Schedules if necessary and add 2019 CC RX Rate Schedules
 D UPDNFRS
 D UPDTRRS
 D RTIN
 D CORACT
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*645")
 Q
 ;
UPDNFRS ; Update No Fault and 2019 RX Rate Schedules (363)
 D MES^XPDUTL("     -> Updating Community Care No Fault and RX Rate Schedules for file 363 ...")
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBCNTCS,IBDISP,IBJ,IBLNCS,IBCS,IBCSFN,IBADMIN,DD,DO
 N DLAYGO,DIC,DIE,DA,DR,RXDT,X,Y,IBCPNM,IBEDT,IBNM
 S IBCNT=0
 F IBI=2:1 S IBLN=$P($T(RSF+IBI),";;",2) Q:IBLN="END"  I $E(IBLN)?1A D
 . ;Check for problems
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) Q:'IBBS  ;Billable service invalid
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created")
 . ;No problems found, so create entry
 . ;Locate existing entry.
 . S Y=-1,IBNM=$P(IBLN,U),IBEDT=$P(IBLN,U,6)
 . S IBJ=0 F  S IBJ=$O(^IBE(363,"B",IBNM,IBJ)) Q:'IBJ  D  Q:Y>-1
 . . I ($D(^IBE(363,IBJ,11))>9),(IBNM'["RX"),(IBNM'["PHARM") S Y=0 Q                ;Rate Schedule correctly defined, skip.
 . . I (IBNM'["RX"),(IBNM'["PHARM") S Y=IBJ Q                 ;Non RX Rate schedule
 . . I $P(^IBE(363,IBJ,0),U,5)="" S Y=IBJ Q                               ;Empty RX Rate schedule, use it.
 . . I ($P(^IBE(363,IBJ,0),U,5)=IBEDT),($D(^IBE(363,IBJ,11))>9) S Y=0 Q   ;Rate rate exists correctly, skip
 . . I ($P(^IBE(363,IBJ,0),U,5)=IBEDT),($D(^IBE(363,IBJ,11))<10) S Y=IBJ  ;Rate rate exists incorrectly, update it.
 . Q:Y=0    ; correctly defined, no need to update.  Go find next schedule.
 . I Y=-1 D    ; If no entry found in Rate Schedule file, create a new entry
 .. K DD,DO,Y
 .. S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBLN,U,1)
 .. D FILE^DICN K DIC,DINUM,DLAYGO
 . I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . S IBCPNM=$P(IBLN,U,5)
 . S RXDT=$$RXDT(IBCPNM,IBEDT)
 . S DR=".02////"_IBRT_";.03////"_$P(IBLN,U,3) I +IBBS S DR=DR_";.04////"_IBBS
 . S DR=DR_";.05////"_$P(RXDT,U)
 . I $P(RXDT,U,2) S DR=DR_";.06////"_$P(RXDT,U,2)
 . I (($P(IBLN,U,1)["RX")!($P(IBLN,U,1)["PHARM")),($G(IBDISP)]"") S DR=DR_";1.01///"_IBDISP
 . I (($P(IBLN,U,1)["RX")!($P(IBLN,U,1)["PHARM")),($G(IBADMIN)]"") S DR=DR_";10////"_IBADMIN
 . S DIE="^IBE(363,",DA=+Y D ^DIE K DIE,DA,DR,X,Y
 . S IBCNTCS=0
 . ; Retrieve name of Charge Set to copy
 . I IBRT="" D MSG("         **** Rate Type "_$P(IBLN,U,2)_" missing Charge Set Information, RS "_$P(IBLN,U,1)_" not created") Q
 . ; add all Reasonable Charges Charge Sets to the Rate Schedule.
 . S IBCNTCS=$$RSCS(IBFN,IBCPNM,$P(RXDT,U))
 . D MES^XPDUTL("        Total Reasonable Charge Set"_$S(IBCNTCS=1:" ",1:"s ")_IBCNTCS_" added to Rate Schedule "_$P(IBLN,U,1)_".")
 D MES^XPDUTL("        Rate Schedules completed.")
 Q  ;ADDRS
 ;
UPDTRRS ; Update TRICARE and DOD Rate Schedules (363) to interagency
 D MES^XPDUTL("     -> Updating TRICARE and DOD Rate Schedules for file 363 ...")
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBCNTCS,IBDISP,IBJ,IBLNCS,IBCS,IBCSFN,IBADMIN,DD,DO
 N DLAYGO,DIC,DIE,DA,DR,RXDT,X,Y,IBCPNM,IBEDT,IBNM,DIK,IBK
 S IBCNT=0
 F IBI=2:1 S IBLN=$P($T(TRSF+IBI),";;",2) Q:IBLN="END"  I $E(IBLN)?1A D
 . ;Check for problems
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) Q:'IBBS  ;Billable service invalid
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created")
 . ;Locate existing entry.
 . S Y=-1,IBNM=$P(IBLN,U),IBEDT=$P(IBLN,U,6)
 . S IBJ=0 F  S IBJ=$O(^IBE(363,"B",IBNM,IBJ)) Q:'IBJ  D  Q:Y>-1
 . . I (IBNM'["RX"),(IBNM'["PHARM") S Y=IBJ Q       ;Non RX Rate schedule
 . . I $P(^IBE(363,IBJ,0),U,5)="" S Y=IBJ Q         ;Empty RX Rate schedule, use it.
 . . I ($P(^IBE(363,IBJ,0),U,5)=IBEDT) S Y=IBJ      ;Correct Pharmacy rate schedule found
 . Q:Y=-1    ; If no entry Quit
 . ; Cleanly Remove existing Charge sets from the Rate Schedule.
 . S IBK=0 F  S IBK=$O(^IBE(363,IBJ,11,IBK)) Q:'IBK  D 
 . . N X,Y,DA,DIK
 . . S DA=IBK,DA(1)=IBJ S DIK="^IBE(363,"_DA(1)_",11,"
 . . D ^DIK
 . ;Update the Rate Schedule with IA info and add the new IA charge sets
 . S IBFN=+IBJ,IBCNT=IBCNT+1
 . S IBCPNM=$P(IBLN,U,5)
 . S RXDT=$$RXDT(IBCPNM,IBEDT)
 . S DR=".02////"_IBRT_";.03////"_$P(IBLN,U,3) I +IBBS S DR=DR_";.04////"_IBBS
 . S DR=DR_";.05////"_$P(RXDT,U)
 . I $P(RXDT,U,2) S DR=DR_";.06////"_$P(RXDT,U,2)
 . I (($P(IBLN,U,1)["RX")!($P(IBLN,U,1)["PHARM")),($G(IBDISP)]"") S DR=DR_";1.01///"_IBDISP
 . I (($P(IBLN,U,1)["RX")!($P(IBLN,U,1)["PHARM")),($G(IBADMIN)]"") S DR=DR_";10////"_IBADMIN
 . S DIE="^IBE(363,",DA=+IBJ D ^DIE K DIE,DA,DR,X,Y
 . S IBCNTCS=0
 . ; Retrieve name of Charge Set to copy
 . I IBRT="" D MSG("         **** Rate Type "_$P(IBLN,U,2)_" missing Charge Set Information, RS "_$P(IBLN,U,1)_" not created") Q
 . ; add all Reasonable Charges Charge Sets to the Rate Schedule.
 . S IBCNTCS=$$RSCS(IBFN,IBCPNM,$P(RXDT,U))
 . D MES^XPDUTL("        Total Reasonable Charge Set"_$S(IBCNTCS=1:" ",1:"s ")_IBCNTCS_" added to Rate Schedule "_$P(IBLN,U,1)_".")
 D MES^XPDUTL("        Rate Schedules completed.")
 Q  ;UPDTRRS
 ;
RTIN ; Inactivate the DOD SNF Rate Schedules to prevent duplicate charges
 D MES^XPDUTL("     -> Inactivating the DOD SNF Rate Schedules ...")
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBCNTCS,IBDISP,IBJ,IBLNCS,IBCS,IBCSFN,IBADMIN,DD,DO
 N DLAYGO,DIC,DIE,DA,DR,RXDT,X,Y,IBCPNM,IBEDT,IBNM,DIK,IBK
 S IBCNT=0
 F IBI=1:1 S IBLN=$P($T(RTINDATA+IBI),";;",2) Q:IBLN="END"  D
 . ;Locate existing entry.
 . S IBNM=$P(IBLN,U)
 . S IBJ=0,IBJ=$O(^IBE(363,"B",IBNM,IBJ))
 . Q:'IBJ
 . ;Update the Rate Schedule an INACTIVE Date
 . S IBFN=+IBJ,IBCNT=IBCNT+1
 . S DR=".06////"_$P(IBLN,U,2)
 . S DIE="^IBE(363,",DA=+IBJ D ^DIE K DIE,DA,DR,X,Y
 . S IBCNTCS=0
 D MES^XPDUTL("        DOD Rate Schedules inactivated.")
 Q
 ;
RSCS(IBFN,IBCPNM,RXDT) ; add existing Charge Sets to FR
 ; copy the Charge Sets from the corresponding RI RS (v2)
 ; IBFN - Rate Schedule IEN
 ; IBCPNM - Charge Set to copy
 ; RXDT - last effective date of charge set being copied.
 N IBCNT,IBNRS,IBRSNM,IBTY,IBVDT,IBCOPY,IBCS,IBCS0,IBXFN,IBCSFN,IBCSNM,IBCSAA,IBNAME
 S (IBCNT,IBCOPY)=0
 S IBNRS=$G(^IBE(363,+$G(IBFN),0)),IBRSNM=$P(IBNRS,"^",1)
 S IBTY=$P(IBNRS,"^",3)
 S IBVDT=RXDT
 ;Q:IBVDT="" 0
 S IBCOPY=+$$RSEXISTS(IBVDT,IBCPNM)
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
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q  ;MSG
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
RXDT(IBCPNM,IBEDT) ;Copy the active charge schedule from charge set being copied. 
 ; update Fee information if Pharmacy.
 N IBEFLG,IBD
 S IBEDT=$G(IBEDT)  ; Set to NULL if not passed in
 S IBCS=""
 ;If no Effective Date sent, get the latest entry.
 I IBEDT="" S IBCS=$O(^IBE(363,"B",IBCPNM,IBCS),-1)
 ;If Effective date sent, loop through the entries to find the entry
 ;  with the correct effective date.
 I (IBEDT=3150101),(IBCPNM="TR-RX") S IBEDT=3150220  ; FOR TR-PHARM 2015 populating only
 I IBEDT'="" D
 . S IBEFLG=0
 . F  S IBCS=$O(^IBE(363,"B",IBCPNM,IBCS),-1) Q:'IBCS  D  Q:IBEFLG
 .. S IBD=$G(^IBE(363,IBCS,0))
 .. I $P(IBD,U,5)=IBEDT S IBEFLG=1
 Q:IBCS="" ""
 S IBCS0=^IBE(363,IBCS,0)
 I (IBCPNM["RX")!(IBCPNM["PHARM") S IBDISP=$P($G(^IBE(363,IBCS,1)),U,1),IBADMIN=$G(^IBE(363,IBCS,10))
 Q $P(IBCS0,U,5,6)   ;return effective and end dates
 ;
RSF ;Rate Schedules (363) for Community Care No Fault Rate Types and 2019 Pharmacy
 ;;Rate Schedule Name^Rate Type^Bill Type^Billable Service^Rate Schedule to copy for Charge Sets
 ;;CCC-NF-INPT^CHOICE NO-FAULT AUTO^1^^RI-INPT
 ;;CCC-NF-SNF^CHOICE NO-FAULT AUTO^1^SKILLED NURSING^RI-SNF
 ;;CCC-NF-OPT^CHOICE NO-FAULT AUTO^3^^RI-OPT
 ;;CCC-NF-RX^CHOICE NO-FAULT AUTO^3^^RI-RX^3140101
 ;;CCC-NF-RX^CHOICE NO-FAULT AUTO^3^^RI-RX^3150101
 ;;CCC-NF-RX^CHOICE NO-FAULT AUTO^3^^RI-RX^3160101
 ;;CCC-NF-RX^CHOICE NO-FAULT AUTO^3^^RI-RX^3170101
 ;;CCC-NF-RX^CHOICE NO-FAULT AUTO^3^^RI-RX^3180101
 ;;CCC-NF-RX^CHOICE NO-FAULT AUTO^3^^RI-RX^3190101
 ;;CC-NF-INPT^CC NO-FAULT AUTO^1^^RI-INPT
 ;;CC-NF-SNF^CC NO-FAULT AUTO^1^SKILLED NURSING^RI-SNF
 ;;CC-NF-OPT^CC NO-FAULT AUTO^3^^RI-OPT
 ;;CC-NF-RX^CC NO-FAULT AUTO^3^^RI-RX^3140101
 ;;CC-NF-RX^CC NO-FAULT AUTO^3^^RI-RX^3150101
 ;;CC-NF-RX^CC NO-FAULT AUTO^3^^RI-RX^3160101
 ;;CC-NF-RX^CC NO-FAULT AUTO^3^^RI-RX^3170101
 ;;CC-NF-RX^CC NO-FAULT AUTO^3^^RI-RX^3180101
 ;;CC-NF-RX^CC NO-FAULT AUTO^3^^RI-RX^3190101
 ;;CCN-NF-INPT^CCN NO-FAULT AUTO^1^^RI-INPT
 ;;CCN-NF-SNF^CCN NO-FAULT AUTO^1^SKILLED NURSING^RI-SNF
 ;;CCN-NF-OPT^CCN NO-FAULT AUTO^3^^RI-OPT
 ;;CCN-NF-RX^CCN NO-FAULT AUTO^3^^RI-RX^3140101
 ;;CCN-NF-RX^CCN NO-FAULT AUTO^3^^RI-RX^3150101
 ;;CCN-NF-RX^CCN NO-FAULT AUTO^3^^RI-RX^3160101
 ;;CCN-NF-RX^CCN NO-FAULT AUTO^3^^RI-RX^3170101
 ;;CCN-NF-RX^CCN NO-FAULT AUTO^3^^RI-RX^3180101
 ;;CCN-NF-RX^CCN NO-FAULT AUTO^3^^RI-RX^3190101
 ;;CCC-RI-RX^CHOICE REIMB INS^3^^RI-RX^3190101
 ;;CC-RI-RX^CC REIMB INS^3^^RI-RX^3190101
 ;;CCN-RI-RX^CCN REIMB INS^3^^RI-RX^3190101
 ;;CC-DOD-RX^CC MTF REIMB INS^3^^RI-RX^3190101
 ;;CCC-TF-RX^CHOICE TORT FEASOR^3^^TF-RX^3190101
 ;;CC-TF-RX^CC TORT FEASOR^3^^TF-RX^3190101
 ;;CCN-TF-RX^CCN TORT FEASOR^3^^TF-RX^3190101
 ;;CCC-WC-RX^CHOICE WORKERS' COMP^3^^WC-RX^3190101
 ;;CC-WC-RX^CC WORKERS' COMP^3^^WC-RX^3190101
 ;;CCN-WC-RX^CCN WORKERS' COMP^3^^WC-RX^3190101
 ;;TR-PHARM^TRICARE PHARMACY^3^^TR-RX^3190101
 ;;END
TRSF ;New Rate Schedules (363) for the new DOD and TRICARE Rate Types
 ;;DOD-DIS EXAM-OPT^DOD DISABILITY EVALUATION^3^OUTPATIENT VISIT^RI-OPT
 ;;DOD-SCI-INPT^DOD SPINAL CORD INJURY^1^INPATIENT^IA-INPT
 ;;DOD-SCI-OPT^DOD SPINAL CORD INJURY^3^OUTPATIENT VISIT^RI-OPT
 ;;DOD-TBI-INPT^DOD TRAUMATIC BRAIN INJURY^1^INPATIENT^IA-INPT
 ;;DOD-TBI-OPT^DOD TRAUMATIC BRAIN INJURY^3^OUTPATIENT VISIT^RI-OPT
 ;;DOD-BR-INPT^DOD BLIND REHABILITATION^1^INPATIENT^IA-INPT
 ;;DOD-BR-OPT^DOD BLIND REHABILITATION^3^OUTPATIENT VISIT^RI-OPT
 ;;TR-DENTAL^TRICARE DENTAL^3^OUTPATIENT VISIT^RI-OPT
 ;;TR-PHARM^TRICARE PHARMACY^3^^TR-RX^3140101
 ;;TR-PHARM^TRICARE PHARMACY^3^^TR-RX^3150101
 ;;TR-PHARM^TRICARE PHARMACY^3^^TR-RX^3160101
 ;;TR-PHARM^TRICARE PHARMACY^3^^TR-RX^3170101
 ;;TR-PHARM^TRICARE PHARMACY^3^^TR-RX^3180101
 ;;END
RTINDATA ;Rate Schedules to set an inactive date on.
 ;;DOD-SCI-SNF^3031225
 ;;DOD-TBI-SNF^3031225
 ;;DOD-BR-SNF^3031225
 ;;END
CORACT ; Add new ACTION TYPE ENTRIES (350.1)
 ;
 D MES^XPDUTL("     -> Updating the CC RX Eligibility Logic fields ...")
 N IBI,IBJ,IBLN
 N X,Y,DIE,DA,DR,DTOUT
 N IBIEN,IBLAST,IBBEG,IBEND
 N IBEL,IBEL1,IBEL2,IBEL3
 ;
 ; Correct the Eligibility Logic
 S IBEL1="S X=0,X1="_$C(34)_$C(34)_",X2="_$C(34)_$C(34)
 S IBEL2=" G:'$D(VAEL) 1^IBAERR I VAEL(4),'+VAEL(3),'IBDOM,'$$RXEXMT^IBARXEU0(DFN,DT) "
 S IBEL3="S X=1,X2=$P(^IBE(350.1,DA,0),"_$C(34)_"^"_$C(34)_",4) D COST^IBAUTL"
 S IBEL=IBEL1_IBEL2_IBEL3
 ;
 ; Store in affected CC RX Action Types
 F IBI=1:1 S IBLN=$P($T(ACTDAT+IBI),";;",2) Q:IBLN="END"  I $E(IBLN)?1A D
 . ;Locate existing entry.
 . S IBNM=$P(IBLN,U),IBEDT=$P(IBLN,U,6)
 . S IBJ=0 S IBJ=$O(^IBE(350.1,"B",IBNM,IBJ))
 . I +IBJ<1 K X,Y Q    ;not found, exit
 . S DR="40////"_IBEL
 . S DIE="^IBE(350.1,",DA=+IBJ
 . D ^DIE
 D MES^XPDUTL("        Eligibility Logic updates completed.")
 Q
 ;
ACTDAT ; Data for the new ACTION TYPE fields. (All categories will be updated)
 ;;CHOICE (RX) NEW
 ;;CC (RX) NEW
 ;;CCN (RX) NEW
 ;;CC MTF (RX) NEW
 ;;END
