IBTUTL ;ALB/AAS - CLAIMS TRACKING UTILITY ROUTINE ;21-JUN-93
 ;;2.0;INTEGRATED BILLING;**23,62,517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ADM(DGPMCA,VAINDT,RANDOM,IBVSIT) ; -- set up info for adding a current admission
 ; -- Input DGPMCA   = pointer for an admission to patient movement file
 ;          VAINDT   = optional date for admission (default is dt)
 ;          RANDOM   = whether or not this is a random sample
 ;          IBVSIT   = Pointer to visit file (optional)
 ;
 N DA,DIC,DIE,DR,X,VAIN,VA,IBSCHED,IBSCH,HCSRIEN
 I '$G(VAINDT) K VAINDT
 I '$G(DGPMCA) S VA200="" D INP^VADPT S DGPMCA=VAIN(1)
 Q:DGPMCA=""
 S RANDOM=$S($G(RANDOM):1,1:0)
 S X=$O(^IBT(356,"ADM",DFN,DGPMCA,0)) I X S IBTRN=X G ADMQ
 S IBADMDT=$P(^DGPM(DGPMCA,0),"^")
 ;S IBETYP=+$O(^IBE(356.6,"B","INPATIENT ADMISSION",0))
 S IBETYP=+$O(^IBE(356.6,"AC",1,0))
 S (IBSCH,IBTRN)=$O(^IBT(356,"ASCH",+$$SCH^IBTRKR2(DGPMCA),0))
 D:'IBTRN ADDT
 I IBTRN<1 G ADMQ
 S DA=IBTRN,DIE="^IBT(356,"
 L +^IBT(356,+IBTRN):10 I '$T G ADMQ
 S DR=$$ADMDR(IBADMDT,IBETYP,DGPMCA,RANDOM)
 D ^DIE K DA,DR,DIE
 I $P($G(^IBT(356,IBTRN,0)),"^",32) S DA=IBTRN,DR=".32///@",DIE="^IBT(356," D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
 I "^1^5^"[(U_IBETYP_U) S HCSRIEN=+$$FNDHCSR(DFN,IBADMDT) D:HCSRIEN HCSRCPY(HCSRIEN,IBTRN,DFN,IBADMDT)
 ;
 S IBSCHED=$S($P(^DGPM(DGPMCA,0),U,25):10,1:20)
 ;
 ; -- if random sample add hospital review
 I $P(^IBT(356,IBTRN,0),U,25) D PRE^IBTUTL2(DT,IBTRN,IBSCHED)
 ;
 ; -- if scheduled admission entry converted to admission, don't add
 ;    second insurance review
 I $G(IBSCH) G ADMQ
 ;
 ; -- if insured add ins review
 I $P(^IBT(356,IBTRN,0),U,24) D COM^IBTUTL3(DT,IBTRN,IBSCHED,$G(IBTRV))
 ;
ADMQ Q
 ;
ADDT ; -- add new entry to tracking, ibt(356
 ;
 N %DT,DD,DO,DIC,DR,DIE,DLAYGO,IBTR1,DINUM
 L +^IBT(356,0):0 ;I '$T S Y="-1^IB085" G ADDTQ
 ;I $G(^IBT(356,0))="" S Y="-1^IB086" G ADDTQ
 S X=$P($G(^IBT(356,0)),"^",3)+1 L -^IBT(356,0)
 S DIC="^IBT(356,",DIC(0)="L",DLAYGO=356
 F X=X:1 L:$D(IBTR1) -^IBT(356,IBTR1) I X>0,'$D(^IBT(356,X)) S IBTR1=X L +^IBT(356,IBTR1):1 I $T,'$D(^IBT(356,X)) S DINUM=X,X=($$IBSITE())_X D FILE^DICN I +Y>0 Q
 L -^IBT(356,IBTR1)
 I +Y<1  S Y="-1^IB087"
ADDTQ ;I +Y<0 D ^IBTERR
 S IBTRN=+Y,IBNEW=1
 Q
 ;
OTH(DFN,IBETYP,IBTDT) ; -- add miscellaneous entries, care may not be in data base
 ; -- input   dfn  := patient pointer to 2
 ;          ibetyp := pointer to type entry in 356.6
 ;          ibtdt  := episode date
 ;
 N X,Y,DA,DR,DIE,DIC
 S X=$O(^IBT(356,"APTY",DFN,IBETYP,IBTDT,0)) I X S IBTRN=X G OTHQ
 D ADDT
 I IBTRN<1 G OTHQ
 S DA=IBTRN,DIE="^IBT(356,"
 S DR=".02////"_$G(DFN)_";.06////"_+$G(IBTDT)_";.18////"_IBETYP_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_DUZ_";.17////"_$$EABD(IBETYP,IBTDT)
 L +^IBT(356,+IBTRN):10 I '$T G OTHQ
 D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
OTHQ Q
 ;
IBSITE() ; -- calculate site from site parameters
 ; --  output ibsite = station number
 ;
 N IBFAC,IBSITE
 D SITE^IBAUTL
 Q IBSITE
 ;
ADMDR(IBADMDT,IBETYP,DGPMCA,RANDOM) ; -- set up dr string for admissions
 S DR=""
 I '$G(IBETYP)!'$G(IBADMDT) G ADMDRQ
 S DR=".02////"_$G(DFN)_";.03////"_$G(IBVSIT)_";.05////"_$G(DGPMCA)_";.06////"_+$G(IBADMDT)_";.18////"_$G(IBETYP)_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_DUZ_";.17////"_$$EABD(IBETYP,$G(IBADMDT)) D
 .I $G(DGPMCA),$G(RANDOM) S DR=DR_";.25////1" Q
ADMDRQ Q DR
 ;
EABD(IBETYP,IBTDT) ; -- compute earliest auto bill date: date entered plus days delay for event type
 ; -- input   IBETYPE = pointer to type of entry file
 ;            IBTDT   = episode date, if not passed in uses DT
 ;
 N X,X1,X2,Y,IBETYPD S Y="" I '$G(IBETYP) G EABDQ
 S IBETYPD=$G(^IBE(356.6,+IBETYP,0)) I '$G(IBTDT) S IBTDT=DT
 I '$P(IBETYPD,"^",4) G EABDQ ; automated billing turned off
 S X2=+$P(IBETYPD,"^",6) ;set earliest autobill date to entered date plus days delay
 S X1=IBTDT D C^%DTC S Y=X\1
EABDQ Q Y
 ;
BILL(IBTRN) ;check if event is billable, return EABD if it is
 N X,Y,Z,IBTRND S (X,Y)="" S IBTRND=$G(^IBT(356,+$G(IBTRN),0)) I IBTRND="" G BILLQ
 ;
 ; -- billed and bill not cancelled and not inpt interim first or continuous
 I +$P(IBTRND,U,11) S Z=$$BILLED^IBCU8(IBTRN),Y=$P(Z,U,2) I +Z,'Y G BILLQ
 ;
 ; -- special type (not riem. ins), not billable, inactive
 I +$P(IBTRND,U,12)!(+$P(IBTRND,U,19))!('$P(IBTRND,U,20)) G BILLQ
 I 'Y S Y=+$G(^IBT(356,+$G(IBTRN),1)) I 'Y S Y=DT
 S X=$$EABD(+$P(IBTRND,U,18),Y)
BILLQ Q X
 ;
STOBIL Q
KTOBIL Q
 ;
FNDHCSR(DFN,IBADMDT) ; find matching HCSR response in file 356.22
 ; DFN - file 2 ien
 ; IBADMDT - event date
 ;
 ; returns file 356.22 ien of matching response or null if no match found
 ;
 N EVDT,HCSRIEN,RES,STOPFLG
 S RES=""
 I +$G(DFN)>0,+$G(IBADMDT)>0 D
 .; loop through D-xref (by patient and event date)
 .S STOPFLG=0,EVDT="" F  S EVDT=$O(^IBT(356.22,"D",DFN,EVDT)) Q:EVDT=""!STOPFLG  D
 ..; if match found, loop through entries for that patient and event date
 ..I $P(EVDT,"-")=IBADMDT S HCSRIEN=0 F  S HCSRIEN=$O(^IBT(356.22,"D",DFN,EVDT,HCSRIEN)) Q:'HCSRIEN!STOPFLG  D
 ...; check if this entry is a response
 ...I $$GET1^DIQ(356.22,HCSRIEN_",",.13,"I") S RES=HCSRIEN,STOPFLG=1
 ...Q
 ..Q
 .Q
 Q RES
 ;
HCSRCPY(HCSRIEN,IBTRN,DFN,EVNTDT) ; copy ref. # and auth. # from file 356.22 into file 356.2
 ; HCSRIEN - file 356.22 ien
 ; IBTRN - file 356 ien
 ; DFN - file 2 ien
 ; EVNTDT - event date from 356.22/.07
 ;
 N CERT,FDA,FLD,HCSRIENS,IENS,IIEN,IMIEN,IRIEN,IRIENS,NUM
 I +$G(HCSRIEN)>0,+$G(IBTRN)>0 D
 .S HCSRIENS=HCSRIEN_","
 .S CERT=$$GET1^DIQ(356.22,HCSRIENS,103.01)
 .S NUM=$$GET1^DIQ(356.22,HCSRIENS,103.02,"I")
 .S IMIEN=$$GET1^DIQ(356.22,HCSRIENS,.03) ;Insurance Multiple IEN
 .S IENS=IMIEN_","_DFN_"," ; 
 .S IIEN=$$GET1^DIQ(2.312,IENS,.01,"I")          ; Insurance Company IEN
 .S FLD=2.01 ; default to ref. #, goes into 356.2/2.01
 .I "^A1^A2^A6^"[(U_CERT_U) S FLD=2.02 ; it's an auth. #, goes into 356.2/2.02
 .;
 .;If there are no entries in 356.2 and it's outpatient, add an entry to 356.2 
 .I '$D(^IBT(356.2,"C",IBTRN)),$P($G(^IBT(356.22,RESIEN,0)),U,4)'="I" D ADD(EVNTDT,IBTRN,DFN,NUM,FLD,IIEN) Q
 .;
 .; find appropriate entries in file 356.2
 .S IRIEN=0 F  S IRIEN=$O(^IBT(356.2,"C",IBTRN,IRIEN)) Q:'IRIEN  D
 ..S IRIENS=IRIEN_","
 ..Q:IIEN'=$$GET1^DIQ(356.2,IRIENS,.08,"I")  ; don't set if it's not the correct insurance company 
 ..S:$P($G(^IBT(356.2,IRIEN,2)),U,$S(FLD=2.02:2,1:1))="" FDA(356.2,IRIENS,FLD)=NUM
 ..D FILE^DIE(,"FDA") K FDA
 ..Q
 .Q
 Q
 ;
 ; add an entry to 365.2
 ; for outpatient if there isn't one already
ADD(EVNTDT,IBTRN,DFN,NUM,FLD,IIEN) ; -- add initial entry
 ; EVNTDT - EVNTDT (in internal fileman format)
 ; IBTRN - file 356 ien
 ; DFN - file 2 ien
 ; NUM - authorization or referral number
 ; FLD - field to file it it.
 ; IIEN - Insurance Company IEN
 ;
 N FDA,HIP,IBDD,IBNXRV,IBTOC,ORDER,STOP
 I $G(NUM)]"",$G(FLD)]"",+$G(IIEN) D
 .;
 .D ALL^IBCNS1(DFN,"IBDD",1,EVNTDT,1) ; return active insurances in COB order
 .Q:'$G(IBDD(0))  ; no active insurance on that date
 .;
 .; get first insurance company that matches
 .S ORDER=0 F  S ORDER=$O(IBDD("S",ORDER)) Q:'ORDER  D  Q:HIP
 ..S HIP=0 F  S HIP=$O(IBDD("S",ORDER,HIP)) Q:'HIP  Q:+$G(IBDD(HIP,0))=IIEN
 .Q:'$G(HIP)  ; stop if none match
 .;
 .S FDA(356.2,"+1,",.01)=EVNTDT
 .;
 .;Pointer to claims tracking
 .S FDA(356.2,"+1,",.02)=IBTRN
 .S FDA(356.2,"+1,",.19)=1
 .;
 .;Type of Contact
 .S IBTOC=$$FIND1^DIC(356.11,,"C","OUTPATIENT TREATMENT")
 .S FDA(356.2,"+1,",.04)=IBTOC
 .;
 .;Patient
 .S FDA(356.2,"+1,",.05)=DFN
 .;
 .; Health Insurance Policy
 .S FDA(356.2,"+1,",1.05)=HIP
 .;
 .;File referal or authorization
 .S FDA(356.2,"+1,",FLD)=NUM
 .;
 .; Next Review
 .S IBNXRV=DT
 .I EVNTDT>$$FMADD^XLFDT(DT,7) S IBNXRV=$$FMADD^XLFDT(EVNTDT,-7)
 .S FDA(356.2,"+1,",.24)=IBNXRV
 .;
 .;Last Edit Date/By
 .D NOW^%DTC
 .S FDA(356.2,"+1,",1.01)=%
 .S FDA(356.2,"+1,",1.02)=DUZ
 .;
 .D UPDATE^DIE(,"FDA") K FDA
 Q
