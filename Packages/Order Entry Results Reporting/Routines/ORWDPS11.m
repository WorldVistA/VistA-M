ORWDPS11 ; ALB/BI - Pharmacy Calls for Windows Dialog ;10/25/2018
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**499**;Dec 17, 1997;Build 165
 ;Reference to ^PSSOPKI supported by DBIA #3737
 ;Reference to ^ORD(101.43 supported by DBIA #5430
 ;Reference to EDITPAR^XPAREDIT supported by DBIA #2336
 ;
 Q
 ;
DEALIST(RET,NPIEN,DOI,PSTYPE,HLIEN)  ; -- RPC to return a List of DEA numbers and information for a single provider and a clinic DEA number.
 ; INPUT:  NPIEN  - NEW PERSON FILE #200 INTERNAL ENTRY NUMBER
 ;         DOI    - DRUG ORDERABLE ITEM #101.43 INTERNAL ENTRY NUMBER
 ;         PSTYPE - O=Outpatient, I=Inpatient
 ;         HLIEN  - HOSPITAL LOCATION INTERNAL ENTRY NUMBER in FILE #44
 ;
 ; OUTPUT: RET - A STRING OF DEA INFORMATION DELIMITED BY THE "^"
 ;           1 - VALID FOR USE: 0=NO, 1=YES
 ;           2 - DEA NUMBER
 ;           3 - INDIVIDUAL DEA SUFFIX
 ;           4 - DEA NUMBER TYPE: INDIVIDUAL/INSTITUTIONAL
 ;           5 - STREET ADDRESS 1
 ;           6 - STREET ADDRESS 2
 ;           7 - STREET ADDRESS 3
 ;           8 - CITY
 ;           9 - STATE
 ;          10 - ZIP CODE
 ;          11 - DETOX NUMBER
 ;          12 - EXPIRATION DATE: FROM THE DEA NUMBERS FILE (#8991.9), FIELD EXPIRATION DATE (#.04)
 ;          13 - SCHEDULE II NARCOTIC
 ;          14 - SCHEDULE II NON-NARCOTIC
 ;          15 - SCHEDULE III NARCOTIC
 ;          16 - SCHEDULE III NON-NARCOTIC
 ;          17 - SCHEDULE IV
 ;          18 - SCHEDULE V
 ;          19 - USE FOR INPATIENT ORDERS?
 ;          20 - FAILOVER FLAG
 ;          21 - PROVIDER VA NUMBER
 ;          22 - PROVIDER TYPE 3=C & A, 4=FEE BASIS
 ;          23 - MESSAGE
 ;
 Q:'$G(NPIEN)
 Q:'$G(DOI)
 ;
 N TPKG,PSOI S TPKG=$P($G(^ORD(101.43,DOI,0)),U,2) Q:TPKG'["PS"
 S PSOI=+TPKG Q:'PSOI
 N SCHEDULE S SCHEDULE=$$DOIIEN(DOI) Q:'SCHEDULE
 S DETFLAG=$$OIDETOX^PSSOPKI(PSOI,PSTYPE)
 S DETPRO=$$DETOX^XUSER(NPIEN)
 I DETFLAG,DETPRO="" S RET(1)="-1^3" Q
 S:'DETFLAG DETPRO=""
 ;
 N CASEIEN,CLINIC,CNT,CSTATUS,DNDEADAT,DNDEAEXP,DNDEAIEN,DNDEATYP,EX,FAIL,FAILOVER
 N IENS,INDEX,NPDEADAT,NPDEAIEN,PROVTYPE,ORTMP,ORTMPX,ORTMPY,VANUMB,VANUMBEX,VDATA
 S (INDEX(0,1),INDEX(0,2),INDEX(0,3))=0
 S FAILOVER=$$GET^XPAR("SYS","PSOEPCS EXPIRED DEA FAILOVER",1,"I")
 S VANUMB=$$GET1^DIQ(200,NPIEN,53.3),VANUMBEX=$$GET1^DIQ(200,NPIEN,53.4,"I")
 S PROVTYPE=$$GET1^DIQ(200,NPIEN,53.6,"I") ; PROVIDER TYPE 3=C & A, 4=FEE BASIS
 S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'+NPDEAIEN  D
 . S IENS=NPDEAIEN_","_NPIEN_","
 . K NPDEADAT D GETS^DIQ(200.5321,IENS,"**","","NPDEADAT") Q:'$D(NPDEADAT)    ; NEW PERSON DATA SET
 . S DNDEAIEN=$$GET1^DIQ(200.5321,IENS,.03,"I") Q:'DNDEAIEN                   ; DN DEA IEN INTERNAL
 . S DNDEAEXP=$$GET1^DIQ(8991.9,DNDEAIEN,.04,"I")                             ; EXPIRATION DATE INTERNAL
 . S DNDEATYP=$$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")                             ; DN DEA TYPE INTERNAL
 . K DNDEADAT D GETS^DIQ(8991.9,DNDEAIEN,"**","","DNDEADAT") Q:'$D(DNDEADAT)  ; DEA NUMBERS DATA SET
 . I $$FMDIFF^XLFDT(DT,DNDEAEXP,1)>365 Q                                      ; IGNORE OLD DEA NUMBERS
 . S CNT=$G(CNT)+1
 . S RET(CNT)=""
 . S $P(RET(CNT),"^",1)=1                                                     ; VALID FOR USE
 . S $P(RET(CNT),"^",2)=NPDEADAT(200.5321,IENS,.01)                           ; NEW PERSON DEA NUMBER
 . S $P(RET(CNT),"^",3)=NPDEADAT(200.5321,IENS,.02)                           ; INDIVIDUAL DEA SUFFIX
 . S $P(RET(CNT),"^",4)=DNDEADAT(8991.9,DNDEAIEN_",",.07)                     ; DN DEA TYPE
 . S $P(RET(CNT),"^",5)=DNDEADAT(8991.9,DNDEAIEN_",",1.2)                     ; STREET ADDRESS 1
 . S $P(RET(CNT),"^",6)=DNDEADAT(8991.9,DNDEAIEN_",",1.3)                     ; STREET ADDRESS 2
 . S $P(RET(CNT),"^",7)=DNDEADAT(8991.9,DNDEAIEN_",",1.4)                     ; STREET ADDRESS 3
 . S $P(RET(CNT),"^",8)=DNDEADAT(8991.9,DNDEAIEN_",",1.5)                     ; CITY
 . S $P(RET(CNT),"^",9)=DNDEADAT(8991.9,DNDEAIEN_",",1.6)                     ; STATE
 . S $P(RET(CNT),"^",10)=DNDEADAT(8991.9,DNDEAIEN_",",1.7)                    ; ZIP CODE
 .; S $P(RET(CNT),"^",11)=DNDEADAT(8991.9,DNDEAIEN_",",.03)                   ; DETOX NUMBER
 . S $P(RET(CNT),"^",11)=DETPRO                                               ; DETOX NUMBER
 . S $P(RET(CNT),"^",12)=DNDEADAT(8991.9,DNDEAIEN_",",.04)                    ; EXPIRATION DATE
 . I $$GET1^DIQ(8991.9,DNDEAIEN,.07,"E")="INDIVIDUAL" D
 . . S $P(RET(CNT),"^",13)=DNDEADAT(8991.9,DNDEAIEN_",",2.1)                    ; SCHEDULE II NARCOTIC
 . . S $P(RET(CNT),"^",14)=DNDEADAT(8991.9,DNDEAIEN_",",2.2)                    ; SCHEDULE II NON-NARCOTIC
 . . S $P(RET(CNT),"^",15)=DNDEADAT(8991.9,DNDEAIEN_",",2.3)                    ; SCHEDULE III NARCOTIC
 . . S $P(RET(CNT),"^",16)=DNDEADAT(8991.9,DNDEAIEN_",",2.4)                    ; SCHEDULE III NON-NARCOTIC
 . . S $P(RET(CNT),"^",17)=DNDEADAT(8991.9,DNDEAIEN_",",2.5)                    ; SCHEDULE IV
 . . S $P(RET(CNT),"^",18)=DNDEADAT(8991.9,DNDEAIEN_",",2.6)                    ; SCHEDULE V
 . I $$GET1^DIQ(8991.9,DNDEAIEN,.07,"E")'="INDIVIDUAL" D
 . . S $P(RET(CNT),"^",13)=$$UPPER^ORU($$GET1^DIQ(200,NPIEN,55.1,"E"))          ; SCHEDULE II NARCOTIC
 . . S $P(RET(CNT),"^",14)=$$UPPER^ORU($$GET1^DIQ(200,NPIEN,55.2,"E"))          ; SCHEDULE II NON-NARCOTIC
 . . S $P(RET(CNT),"^",15)=$$UPPER^ORU($$GET1^DIQ(200,NPIEN,55.3,"E"))          ; SCHEDULE III NARCOTIC
 . . S $P(RET(CNT),"^",16)=$$UPPER^ORU($$GET1^DIQ(200,NPIEN,55.4,"E"))          ; SCHEDULE III NON-NARCOTIC
 . . S $P(RET(CNT),"^",17)=$$UPPER^ORU($$GET1^DIQ(200,NPIEN,55.5,"E"))          ; SCHEDULE IV
 . . S $P(RET(CNT),"^",18)=$$UPPER^ORU($$GET1^DIQ(200,NPIEN,55.6,"E"))          ; SCHEDULE V
 . S $P(RET(CNT),"^",19)=DNDEADAT(8991.9,DNDEAIEN_",",.06)                    ; USE FOR INPATIENT ORDERS?
 . S $P(RET(CNT),"^",20)=FAILOVER                                             ; FAILOVER FLAG
 . S $P(RET(CNT),"^",21)=VANUMB                                               ; PROVIDER VA NUMBER
 . S $P(RET(CNT),"^",22)=PROVTYPE                                             ; PROVIDER TYPE 3=C & A, 4=FEE BASIS
 . ;
 . S EX=0
 . I DNDEAEXP<DT S $P(RET(CNT),"^",2)="* "_$P(RET(CNT),"^",2),$P(RET(CNT),"^",1)=0,$P(RET(CNT),"^",23)="Expired: "_$P(RET(CNT),"^",12) S INDEX(1,CNT)="",INDEX(0,1)=INDEX(0,1)+1,EX=1
 . I 'EX,SCHEDULE="2",$P(RET(CNT),"^",13)'="YES" S $P(RET(CNT),"^",2)="* "_$P(RET(CNT),"^",2),$P(RET(CNT),"^",1)=0,$P(RET(CNT),"^",23)="NOT VALID FOR SCHEDULE II" S INDEX(2,CNT)="",INDEX(0,2)=INDEX(0,2)+1,EX=1
 . I 'EX,SCHEDULE="2n",$P(RET(CNT),"^",14)'="YES" S $P(RET(CNT),"^",2)="* "_$P(RET(CNT),"^",2),$P(RET(CNT),"^",1)=0,$P(RET(CNT),"^",23)="NOT VALID FOR SCHEDULE II NON NARCOTIC" S INDEX(2,CNT)="",INDEX(0,2)=INDEX(0,2)+1,EX=1
 . I 'EX,SCHEDULE="3",$P(RET(CNT),"^",15)'="YES" S $P(RET(CNT),"^",2)="* "_$P(RET(CNT),"^",2),$P(RET(CNT),"^",1)=0,$P(RET(CNT),"^",23)="NOT VALID FOR SCHEDULE III" S INDEX(2,CNT)="",INDEX(0,2)=INDEX(0,2)+1,EX=1
 . I 'EX,SCHEDULE="3n",$P(RET(CNT),"^",16)'="YES" S $P(RET(CNT),"^",2)="* "_$P(RET(CNT),"^",2),$P(RET(CNT),"^",1)=0,$P(RET(CNT),"^",23)="NOT VALID FOR SCHEDULE III NON NARCOTIC" S INDEX(2,CNT)="",INDEX(0,2)=INDEX(0,2)+1,EX=1
 . I 'EX,SCHEDULE="4",$P(RET(CNT),"^",17)'="YES" S $P(RET(CNT),"^",2)="* "_$P(RET(CNT),"^",2),$P(RET(CNT),"^",1)=0,$P(RET(CNT),"^",23)="NOT VALID FOR SCHEDULE IV" S INDEX(2,CNT)="",INDEX(0,2)=INDEX(0,2)+1,EX=1
 . I 'EX,SCHEDULE="5",$P(RET(CNT),"^",18)'="YES" S $P(RET(CNT),"^",2)="* "_$P(RET(CNT),"^",2),$P(RET(CNT),"^",1)=0,$P(RET(CNT),"^",23)="NOT VALID FOR SCHEDULE V" S INDEX(2,CNT)="",INDEX(0,2)=INDEX(0,2)+1,EX=1
 . I 'EX S INDEX(3,CNT)="",INDEX(0,3)=INDEX(0,3)+1
 ;
 ; 1 - Provider has a DEA# that is not expired, but not eligible. 
 I INDEX(0,3)=0,INDEX(0,2)>0 K RET S RET(1)="-1^2^"_SCHEDULE Q
 ;
 ; 2 - Provider has no DEA# (no active/no DEA# expired within the last year) and has no VA#, return RET(1)="-1^1"
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)=0,VANUMB="" K RET S RET(1)="-1^1" Q
 ;
 ; 3 - Provider is not a VA Provider
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)=0,VANUMB'="",PROVTYPE=3 K RET S RET(1)="-1^1" Q
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)=0,VANUMB'="",PROVTYPE=4 K RET S RET(1)="-1^1" Q
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,VANUMB'="",PROVTYPE=3 K RET S RET(1)="-1^1" Q
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,VANUMB'="",PROVTYPE=4 K RET S RET(1)="-1^1" Q
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,VANUMB="",PROVTYPE=3 K RET S RET(1)="-1^1" Q
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,VANUMB="",PROVTYPE=4 K RET S RET(1)="-1^1" Q 
 ;
 ; 4 - Provider has no DEA# (no active/no DEA# expired within the last year) and has a VA#, a VA provider 
 ;     (provider type not 3/4) and is eligible ("PS3") to write that schedule cont...
 ;     this provider then can use the Facility DEA # tied to the clinic provided Facility DEA # is not expired.
 ;     If above is true then RET(1)="1^Facility-VA# with the address detail)
 ;     If above is not true, RET(1)="-1^1"
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)=0,VANUMB'="",((PROVTYPE'=3)&(PROVTYPE'=4)) D  K RET S RET(1)=CLINIC Q
 . S CSTATUS=$$CLINIC(.CLINIC,HLIEN,NPIEN,SCHEDULE)
 . I CSTATUS=0 S CLINIC="-1^1" Q
 . I $P(CLINIC,"^",23)["Expired:" S CLINIC="-1^1" Q
 . I $P(CLINIC,"^",23)["NOT VALID" S CLINIC="-1^1" Q
 ;   
 ; 5 - Provider has no DEA# (no active) but has an expired DEA# within the last year and FAILOVER is set to "Yes"
 ;     and has a VA#, a VA provider (provider type not 3/4) and is eligible ("PS3") to write that schedule
 ;     this provider then can use the Facility DEA # tied to the clinic provided Facility DEA # is not expired.
 ;     If above is true then RET(+1)="1^Facility-VA# with the address detail)
 ;     If above is not true, RET(1)="-1^1"
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,FAILOVER=1,VANUMB'="",((PROVTYPE'=3)&(PROVTYPE'=4)) D  I +CLINIC=-1 K RET S RET(1)=CLINIC Q
 . S CSTATUS=$$CLINIC(.CLINIC,HLIEN,NPIEN,SCHEDULE)
 . I '$D(CLINIC) S CLINIC="-1^1" Q
 . I $P(CLINIC,"^",23)["Expired:" S CLINIC="-1^1" Q
 . I $P(CLINIC,"^",23)["NOT VALID" S CLINIC="-1^1" Q
 . I $D(CLINIC) S CNT=CNT+1,INDEX(3,CNT)="",INDEX(0,3)=INDEX(0,3)+1,RET(CNT)=CLINIC
 ;
 ; 6 - Provider has no DEA# (no active) and no VA# but has an expired DEA# within the last year and FAILOVER is set to "No"
 ;     then RET(1)="-1^7"
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,VANUMB="",FAILOVER=0 K RET S RET(1)="-1^7" Q
 ;
 ; 7 - Provider has a VA# but has an expired DEA# within the last year and FAILOVER is set to "No"
 ;     then RET(1)="-1^7"
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,VANUMB'="",FAILOVER=0 K RET S RET(1)="-1^7" Q
 ;
 ; 8 - Provider has an expired DEA# within the last year, no VA# and FAILOVER is set to "Yes"
 ;     then RET(1)="-1^7"
 I INDEX(0,3)=0,INDEX(0,2)=0,INDEX(0,1)>0,VANUMB="",FAILOVER=1 K RET S RET(1)="-1^7" Q
 ;
 ; RETURN THE FULL DEFAULT LIST
 K ORTMP M ORTMP=RET K RET S CNT=0
 S ORTMPX=0 F  S ORTMPX=$O(INDEX(ORTMPX)) Q:'ORTMPX  D
 . S ORTMPY=0 F  S ORTMPY=$O(INDEX(ORTMPX,ORTMPY)) Q:'ORTMPY  D
 .. S CNT=CNT+1,RET(CNT)=ORTMP(ORTMPY)
 ;
 Q
 ;
CLINIC(RET,HLIEN,NPIEN,SCHEDULE)  ; -- Functionality to return a Clinic DEA number for a provider.
 ; HLIEN = HOSPITAL LOCATION FILE #44 IEN PROVIDED AS AN INPUT
 ; DIVISION = DIVISION FIELD #3.5 POINTER TO MEDICAL CENTER DIVISION FILE (#40.8)
 ; FACDEA = INSTITUTION FILE #4, FACILITY DEA NUMBER FIELD #52
 N INSTITUT,DIVISION,FACDEA,FACDEAEX,NPDAT,PROVVAN
 Q:'$G(HLIEN) 0
 S DIVISION=$$GET1^DIQ(44,HLIEN,3.5,"I") Q:'DIVISION 0
 S INSTITUT=$$GET1^DIQ(40.8,DIVISION,.07,"I") Q:'INSTITUT 0
 S FACDEA=$$GET1^DIQ(4,INSTITUT,52) Q:FACDEA="" 0
 S RET=""
 S FACDEAEX=$$GET1^DIQ(4,INSTITUT,52.1,"I")                ; FACILITY DEA EXPIRATION DATE INTERNAL
 I $$FMDIFF^XLFDT(DT,FACDEAEX,1)>365 Q 0                   ; IGNORE OLD DEA NUMBERS
 S $P(RET,"^",1)=1                                         ; VALID FOR USE
 S $P(RET,"^",2)=FACDEA                                    ; FACILITY DEA NUMBER
 S $P(RET,"^",3)=$$GET1^DIQ(200,NPIEN,53.3)                ; PROVIDER VA NUMBER as SUFFIX
 S $P(RET,"^",4)="INSTITUTIONAL"                           ; DN DEA TYPE - INSTITUTIONAL
 S $P(RET,"^",5)=$$GET1^DIQ(4,INSTITUT,1.01)               ; FACILITY STREET ADDRESS 1
 S $P(RET,"^",6)=$$GET1^DIQ(4,INSTITUT,1.02)               ; FACILITY STREET ADDRESS 2
 S $P(RET,"^",7)=""                                        ; FACILITY STREET ADDRESS 3 - N/A
 S $P(RET,"^",8)=$$GET1^DIQ(4,INSTITUT,1.03)               ; FACILITY CITY
 S $P(RET,"^",9)=$$GET1^DIQ(4,INSTITUT,.02)                ; FACILITY STATE
 S $P(RET,"^",10)=$$GET1^DIQ(4,INSTITUT,1.04)              ; FACILITY ZIP CODE
 ;S $P(RET,"^",11)=$$GET1^DIQ(200,NPIEN,9001)              ; DETOX NUMBER
 S $P(RET,"^",11)=DETPRO                                   ; DETOX NUMBER
 S $P(RET,"^",12)=$$GET1^DIQ(4,INSTITUT,52.1)              ; FACILITY DEA EXPIRATION DATE
 S $P(RET,"^",13)=$$UP^XLFSTR($$GET1^DIQ(200,NPIEN,55.1))  ; SCHEDULE II NARCOTIC
 S $P(RET,"^",14)=$$UP^XLFSTR($$GET1^DIQ(200,NPIEN,55.2))  ; SCHEDULE II NON-NARCOTIC
 S $P(RET,"^",15)=$$UP^XLFSTR($$GET1^DIQ(200,NPIEN,55.3))  ; SCHEDULE III NARCOTIC
 S $P(RET,"^",16)=$$UP^XLFSTR($$GET1^DIQ(200,NPIEN,55.4))  ; SCHEDULE III NON-NARCOTIC
 S $P(RET,"^",17)=$$UP^XLFSTR($$GET1^DIQ(200,NPIEN,55.5))  ; SCHEDULE IV
 S $P(RET,"^",18)=$$UP^XLFSTR($$GET1^DIQ(200,NPIEN,55.6))  ; SCHEDULE V
 S $P(RET,"^",19)=""                                       ; USE FOR INPATIENT ORDERS? - N/A
 S $P(RET,"^",20)=$$GET^XPAR("SYS","PSOEPCS EXPIRED DEA FAILOVER",1,"I")  ; FAILOVER FLAG
 S $P(RET,"^",21)=$$GET1^DIQ(200,NPIEN,53.3)               ; PROVIDER VA NUMBER
 S $P(RET,"^",22)=$$GET1^DIQ(200,NPIEN,53.6,"I")           ; PROVIDER TYPE 3=C & A, 4=FEE BASIS
 ;
 I FACDEAEX<DT S $P(RET,"^",2)="* "_$P(RET,"^",2),$P(RET,"^",1)=0,$P(RET,"^",23)="Expired: "_$P(RET,"^",12) G CLINICQ
 I SCHEDULE="2",$P(RET,"^",13)'="YES" S $P(RET,"^",2)="* "_$P(RET,"^",2),$P(RET,"^",1)=0,$P(RET,"^",23)="NOT VALID FOR SCHEDULE II" G CLINICQ
 I SCHEDULE="2n",$P(RET,"^",14)'="YES" S $P(RET,"^",2)="* "_$P(RET,"^",2),$P(RET,"^",1)=0,$P(RET,"^",23)="NOT VALID FOR SCHEDULE II NON NARCOTIC" G CLINICQ
 I SCHEDULE="3",$P(RET,"^",15)'="YES" S $P(RET,"^",2)="* "_$P(RET,"^",2),$P(RET,"^",1)=0,$P(RET,"^",23)="NOT VALID FOR SCHEDULE III" G CLINICQ
 I SCHEDULE="3n",$P(RET,"^",16)'="YES" S $P(RET,"^",2)="* "_$P(RET,"^",2),$P(RET,"^",1)=0,$P(RET,"^",23)="NOT VALID FOR SCHEDULE III NON NARCOTIC" G CLINICQ
 I SCHEDULE="4",$P(RET,"^",17)'="YES" S $P(RET,"^",2)="* "_$P(RET,"^",2),$P(RET,"^",1)=0,$P(RET,"^",23)="NOT VALID FOR SCHEDULE IV" G CLINICQ
 I SCHEDULE="5",$P(RET,"^",18)'="YES" S $P(RET,"^",2)="* "_$P(RET,"^",2),$P(RET,"^",1)=0,$P(RET,"^",23)="NOT VALID FOR SCHEDULE V" G CLINICQ
 ;
CLINICQ  ; FUNCTION END POINT
 Q $P(RET,"^",1)
 ;
DOIIEN(DOIIEN) ; -- DOJ DRUG SCHEDULE CALCULATOR WITH ORDER ITEM IEN INPUT
 Q:'$G(DOIIEN) ""
 N SCHEDULE,VALID,TPKG,PSOI
 S (VALID("2"),VALID("2n"),VALID("3"),VALID("3n"),VALID("4"),VALID("5"))=""
 S TPKG=$P($G(^ORD(101.43,DOIIEN,0)),U,2) Q:TPKG'["PS" ""
 S PSOI=+TPKG Q:'PSOI ""
 S SCHEDULE=$P($$OIDEA^PSSOPKI(PSOI,"I"),";",2) Q:'+SCHEDULE ""
 Q:'$D(VALID(SCHEDULE)) ""
 Q SCHEDULE
 ;
ZIP(RETURN,OI,PSTYPE,DFN)   ; -- zip code required to prescribe cs orders
 ; OI = ORDERABLE ITEMS (#101.43) pointer
 ; PSTYPE = APPLICATION CODE - O=Outpatient Pharmacy, I=IV, U=Unit Dose
 ; DFN = Patient IEN
 N VAPA,TPKG,PSOI,DEAFLG,DPKG
 S RETURN=1,TPKG=$P($G(^ORD(101.43,+$G(OI),0)),U,2)
 Q:TPKG'["PS"
 S PSOI=+TPKG Q:PSOI'>0
 S DEAFLG=$P($$OIDEA^PSSOPKI(PSOI,PSTYPE),";",2)
 I '+$G(DEAFLG) Q
 D ADD^VADPT
 I $$USA^ORWDPS11(DFN),'(VAPA(11)!VAPA(6)),$$GET^XPAR("SYS","OR ZIP CODE SWITCH") D  Q
 . S RETURN="0^Controlled substance prescriptions require a patient address. "
 . S RETURN=RETURN_$$GET^XPAR("ALL","OR ZIP CODE MESSAGE",1)
 S RETURN="1^"_+DEAFLG_$S($E(DEAFLG,2)="n":"^n",1:"")
 Q
 ;
ZIPM ; - zip code parameter message
 D EDITPAR^XPAREDIT("OR ZIP CODE MESSAGE")
 Q
 ;
VALDEA(FAIL,OI,ORNP,PSTYPE,ORID)    ; - return 1 if DEA check fails for this provider
 N DEAFLG,PSOI,TPKG,RT,DETFLAG,DETPRO,ORSLDEA,Y
 S FAIL=0,TPKG=$P($G(^ORD(101.43,+$G(OI),0)),U,2)
 Q:'$G(ORID)
 S ORSLDEA=$P($G(^OR(100,ORID,11.1)),U)
 Q:ORSLDEA=""
 Q:TPKG'["PS"
 S PSOI=+TPKG Q:PSOI'>0
 S DETFLAG=$$OIDETOX^PSSOPKI(PSOI,PSTYPE)
 S DETPRO=$$DETOX^XUSER(+$G(ORNP))
 I DETFLAG,DETPRO="" S FAIL=3 Q
 I DETFLAG,DETPRO>0 S Y=DETPRO X ^DD("DD") S FAIL="5^"_Y Q
 S DEAFLG=$P($$OIDEA^PSSOPKI(PSOI,PSTYPE),";",2) Q:DEAFLG'>0
 I DEAFLG=1 S FAIL=6 Q
 S RT=$$SDEA^XUSER(,+$G(ORNP),DEAFLG,ORSLDEA,"I")  ; Default to the required "Use For Inpatient" DEA# until selection from list is enabled
 I RT=1 S FAIL=1 Q
 I RT=2 S FAIL="2^"_$$UP^XLFSTR(DEAFLG) Q
 I RT?1"4".E S FAIL=RT
 Q
 ;
USA(DFN) ; Does patient address contan a U.S. address based on Country or State?
 ; Input:  DFN - Patient Identifier from PATIENT file (#2)
 ; Output: 0 - Address is not U.S.
 ;         1 - Address is U.S.
 ;        -1 - Address could not be determined to be U.S.
 ;
 N COUNTRY,STATE,STATEAR,STATEIENS,VAPA
 Q:'$G(DFN) 0
 Q:'$L($G(^DPT(+DFN,0))) 0
 D ADD^VADPT
 S COUNTRY=$S($G(VAPA(25)):$P(VAPA(25),U,2),$G(VAPA(37)):$P(VAPA(37),U,2),1:"")
 I $L(COUNTRY) Q $S(COUNTRY="UNITED STATES":1,1:0)
 S STATE=$S($G(VAPA(5)):$P(VAPA(5),U),$G(VAPA(34)):$P(VAPA(34),U),1:"")
 I STATE S STATEIENS=STATE_"," D GETS^DIQ(5,STATEIENS,"2.2","I","STATEAR") Q $S($G(STATEAR(5,STATEIENS,2.2,"I")):1,1:0)
 Q -1
