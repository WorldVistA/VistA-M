DGMTU ;ALB/RMO,LBD,BRM,EG - Means Test Utilities ; 02/08/2005 07:10 AM
 ;;5.3;Registration;**4,33,182,277,290,374,358,420,426,411,332,433,456,476,519,451,630,783,799,834**;Aug 13, 1993;Build 4
 ;MT=Means Test
LST(DFN,DGDT,DGMTYPT) ;Last MT for a patient
 ;         Input  -- DFN   Patient IEN
 ;                   DGDT  Date/Time  (Optional- default today@2359)
 ;                DGMTYPT  Type of Test (Optional - if not defined 
 ;                                       Means Test will be assumed)
 ;         Output -- Annual Means Test IEN^Date of Test
 ;                   ^Status Name^Status Code^Source of Test
 N DGIDT,DGMTFL1,DGMTI,DGNOD,Y I '$D(DGMTYPT) S DGMTYPT=1
 S DGIDT=$S($G(DGDT)>0:-DGDT,1:-DT) S:'$P(DGIDT,".",2) DGIDT=DGIDT_.2359
 F  S DGIDT=+$O(^DGMT(408.31,"AID",DGMTYPT,DFN,DGIDT)) Q:'DGIDT!$G(DGMTFL1)  D
 .F DGMTI=0:0 S DGMTI=+$O(^DGMT(408.31,"AID",DGMTYPT,DFN,DGIDT,DGMTI)) Q:'DGMTI!$G(DGMTFL1)  D
 ..S DGNOD=$G(^DGMT(408.31,DGMTI,0)) I DGNOD,$G(^("PRIM"))!(DGMTYPT=4) S DGMTFL1=1,Y=DGMTI_"^"_$P(^(0),"^")_"^"_$$MTS(DFN,+$P(^(0),"^",3))_"^"_$P(DGNOD,"^",23) ; chk for primary MT
 Q $G(Y)
 ;
LVMT(DFN,DGDT) ;Last valid MT (status other than required)
 ;          Input  -- DFN    Patient IEN
 ;                    DGDT   Date (Optional - default today)
 ;          Output -- Annual Means Test IEN^Date of Test^Status Name
 ;                     ^Status Code
 N DGMT,DGMTL
 S:'$D(DGDT) DGDT=DT S DGMTL=$$LST^DGMTU(DFN,DGDT)
 I $P(DGMTL,"^",4)="R" F  S DGMT=$$LST^DGMTU(DFN,DGDT) Q:DGMT']""!($P(DGMT,U,4)'="R")  S DGDT=$P(DGMT,U,2)-1
 Q $S($G(DGMT)]"":DGMT,1:$G(DGMTL))
 ;
NVMT(DFN,DGDT) ;Next valid MT (status other than required)
 ;          Input  -- DFN    Patient IEN
 ;                    DGDT   Date (Required)
 ;          Output -- Annual Means Test IEN^Date of Test^Status Name
 ;                     ^Status Code
 N DGDTE,DGMT,DGMT0,DGMTI,DGMTPR,DGMTS
 S DGDTE=DGDT
 F  S DGDTE=$O(^DGMT(408.31,"AD",1,DFN,DGDTE)) Q:'DGDTE!$G(DGMT)  D
 .F DGMTI=0:0 S DGMTI=$O(^DGMT(408.31,"AD",1,DFN,DGDTE,DGMTI)) Q:'DGMTI  S DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGMTS=+$P(DGMT0,"^",3),DGMTPR=$G(^("PRIM")) I +DGMT0,DGMTS'=1,DGMTPR S DGMT=DGMTI_"^"_+DGMT0_"^"_$$MTS^DGMTU(DFN,DGMTS) Q
 Q $G(DGMT)
 ;
MTS(DFN,DGMTS) ;MT status -- default current
 ;         Input  -- DFN    Patient IEN
 ;                   DGMTS  Means Test Status IEN  (Optional)
 ;         Output -- Status Name^Status Code
 N Y
 S DGMTS=$S($G(DGMTS)>0:DGMTS,1:$P($G(^DPT(DFN,0)),"^",14))
 I DGMTS S Y=$P($G(^DG(408.32,DGMTS,0)),"^",1,2)
 Q $G(Y)
 ;
DIS(DFN) ;Display patients current MT status,
 ;        eligibility for care, deductible information,
 ;        date of test and date of completion
 ;         Input  -- DFN    Patient IEN
 ;         Output -- None
 N DGCS,DGDED,DGMTI,DGMT0
 S DGCS=$P($G(^DPT(DFN,0)),"^",14) G DISQ:DGCS=""
 S DGMTI=+$$LST^DGMTU(DFN),DGMT0=$G(^DGMT(408.31,DGMTI,0))
 S MTSIG=$P(DGMT0,"^",29)
 W !,"Means Test Signed?: ",$S(MTSIG=1:"YES",MTSIG=0:"NO",MTSIG=9:"DELETED",1:"")
 I DGCS=1 W !!,"Patient Requires a Means Test"
 I DGCS=2 W !!,"Patient's Means Test is Pending Adjudication for "_$$PA^DGMTUTL(DGMTI)
 I DGCS=3 W !!,"Means Test Not Required"
 I ("^4^5^6^16^")[("^"_DGCS_"^") W !!,"Patient's status is ",$$GETNAME^DGMTH(DGCS)," based on primary means test"
 I $D(^DG(408.32,DGCS,"MSG")) W !,^("MSG")
 I DGCS=6 S DGDED=$P(DGMT0,"^",11) W ! W:DGDED]"" "Has",$S(DGDED:"",1:" not")," agreed to pay the deductible"
 S Y=$P(DGMT0,"^") X ^DD("DD") W !,"Primary Means Test ",$S(DGCS=1:"Required from",1:"Last Applied")," '",Y,"'"
 I ("^2^4^5^6^16^")[("^"_DGCS_"^") S Y=$P(DGMT0,"^",7) X ^DD("DD") W " (COMPLETED: ",Y,")"
 I DGCS=3 S Y=$P(DGMT0,"^",17) X ^DD("DD") W " (NO LONGER REQUIRED: ",Y,")"
DISQ Q
 ;
EDT(DFN,DGDT) ;Display patients current MT information and provide
 ;        the user with the option of proceeding with a required
 ;        MT or editing an existing means test
 ;         Input  -- DFN    Patient IEN
 ;                   DGDT   Date/Time
 ;         Output -- None
 ;
 ; obtain lock used to synchronize local MT/CT options with income test upload
 ; '+' added to VSITE check to allow divisions to edit parent owned tests
 N VSITE
 I $$LOCK^DGMTUTL(DFN)
 ;
 D DIS(DFN)
 S DGMTI=+$$LST(DFN,DGDT),VSITE=+$P($$SITE^VASITE(),U,3)
 G EDTQ:'DGMTI!(DGMTI'=+$$LST^DGMTU(DFN))
 I +$P($G(^DGMT(408.31,DGMTI,2)),U,5)'=VSITE G EDTQ ; Test doesn't belong to site
 S DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGMTDT=+DGMT0,DGMTS=$P(DGMT0,"^",3)
 S DIR("A")="Do you wish to "_$S(DGMTS=1:"proceed with",1:"edit")_" the means test at this time"
 S DIR("B")=$S(DGMTS&($D(DGPRFLG)):"NO",DGMTS=1:"YES",1:"NO"),DIR(0)="Y"
 W ! D ^DIR G EDTQ:$D(DTOUT)!($D(DUOUT))
 I Y S DGMTYPT=1,DGMTACT="EDT",DGMTROU="EDTQ^DGMTU" G EN^DGMTSC
EDTQ K DGMT0,DGMTACT,DGMTDT,DGMTI,DGMTROU,DGMTS,DIR,DTOUT,DUOUT,Y
 ;
 ; release lock
 D UNLOCK^DGMTUTL(DFN)
 ;
 Q
 ;
CMTS(DFN) ;Get Current MT Status - query HEC if necessary
 ;
 ;        Input: DFN=patient ien
 ;       Output: MT IEN^Date of Test^Status Name
 ;                 ^Status Code^Source of Test
 ;
 N X,Y,DGMTDATA,DGQSENT,DGDOD,NODE0,DGRET,DGMFLG,DGTAG,DGMTYPT
 D CHKPT^DGMTU4(DFN)
 S DGMTYPT=1,DGMTDATA=$$LST(DFN,"",DGMTYPT)
 ;Next line checks to see if patient has expired, if so, Query not initiated
 S DGDOD=$P($G(^DPT(DFN,.35)),U)
 I +DGDOD Q DGMTDATA
 ;Next line checks to see if current test exists, if not, Query not initiated 
 I '$G(DGMTDATA) Q DGMTDATA
 D:+$$QFLG(DGMTDATA)
 .I $G(IVMZ10)'="UPLOAD IN PROGRESS",'$$OPEN^IVMCQ2(DFN),'$$SENT^IVMCQ2(DFN),$G(DGMFLG)'=0 D
 ..I $$LOCK^DGMTUTL(DFN)
 ..D QRYQUE2^IVMCQ2(DFN,$G(DUZ),0,$G(XQY)) S DGQSENT=1
 ..I '$D(ZTQUEUED),'$G(DGMSGF),$G(DGQSENT) W !!,"Financial query queued to be sent to HEC...",! H .5
 ..D UNLOCK^DGMTUTL(DFN)
 .S DGMTDATA=$$LST(DFN,"",DGMTYPT)
 D:+$$MFLG(DGMTDATA)
 .S DGMFLG=$$MFLG(DGMTDATA)
 .S DGTAG=$S(DGMFLG=1:"MSG"_DGMFLG,DGMFLG=2:"MSG"_DGMFLG,1:0)
 .I DGTAG["MSG",'$G(DGMSGF) D @DGTAG
 Q DGMTDATA   ;return most current MT data
MFLG(DGMTDATA) ;Set up appropriate informational message flag for user's
 ;benefit.
 ;Input        -     DGMTDATA as defined by $$LST function.
 ;Output       -     DGRETV
 ;     1 = Current Test is REQUIRED
 ;     2 = Test is > 365 days old and is in a status of
 ;         other than REQUIRED or NO LONGER REQUIRED
 ;     2 = Pend Adj for GMT, test date is 10/6/99 or
 ;         greater and agreed to the deductible
 ;     0 = CAT C/Pend Adj for MT, test date is 10/6/99
 ;         or greater and agreed to the deductible.
 ; OR  0 = Cat C, declined income info and agreed
 ;         to pay deductible.
 ; OR  0 = Has a future dated Means Test
 N DGRETV,FTST,DGMT0
 S DGRETV=0 I '$G(DGMTDATA) Q DGRETV
 S DGMT0=$G(^DGMT(408.31,+DGMTDATA,0))
 I $P(DGMTDATA,U,4)="R" S DGRETV=1
 I $$OLD^DGMTU4($P(DGMTDATA,U,2)),($P(DGMTDATA,U,4)'="N")&($P(DGMTDATA,U,4)'="R") S DGRETV=2
 I ($P(DGMTDATA,U,4)="C")!($P(DGMTDATA,U,4)="P"&($P(DGMT0,U,12)'<$P(DGMT0,U,27))),$P(DGMTDATA,U,2)>2991005,$P(DGMT0,U,11)=1 S DGRETV=0
 I ($P(DGMTDATA,U,4)="C"),+$P(DGMT0,U,14),+$P(DGMT0,U,11) S DGRETV=0
 D DOM^DGMTR I $G(DGDOM) S DGRETV=0
 S FTST=$$FUT(DFN)
 I DGRETV,FTST,$P(^DGMT(408.31,+FTST,0),U,19)=1 S DGRETV=0
 Q DGRETV
MSG1 ;Informational message 1
 N NODE0,Y
 S NODE0=$G(^DGMT(408.31,+DGMTDATA,0))
 W !!,$C(7),?15,"*** Patient Requires a Means Test ***",!
 S Y=$P(NODE0,U) X ^DD("DD") W !,?14,"Primary Means Test Required from "_Y,!
 I $G(IOST)["C-" R !!,"Enter <RETURN> to continue.",DGRET:DTIME
 Q
MSG2 ;Informational message 2
 N NODE0,Y
 S NODE0=$G(^DGMT(408.31,+DGMTDATA,0))
 W !!,$C(7),?17,"*** Patient Requires a Means Test ***",!
 S Y=$P(NODE0,U) X ^DD("DD") W !,?10,"Patient's Test dated "_Y_" is "_$P(DGMTDATA,U,3)_"."_" The test"
 W !,?10,"date is greater than 365 days old.  Please update."
 I $G(IOST)["C-" R !!,"Enter <RETURN> to continue.",DGRET:DTIME
 Q
QFLG(DGMTDATA) ;
 ;INPUT - DGMTDATA
 ;OUTPUT- IVMQFLG 1 if query is necessary 0 if not
 N IVMQFLG,DGMT0
 S IVMQFLG=0 I '$G(DGMTDATA) Q IVMQFLG
 S DGMT0=$G(^DGMT(408.31,+DGMTDATA,0))
 ;Set flag to 1 if Means test is Required.
 I $P(DGMTDATA,U,4)="R" S IVMQFLG=1
 ;Set flag to 1 if Means test older than 365 days and status is not
 ;NO LONGER REQUIRED and not REQUIRED.
 I $$OLD^DGMTU4($P(DGMTDATA,U,2)),($P(DGMTDATA,U,4)'="N")&($P(DGMTDATA,U,4)'="R") S IVMQFLG=1
 ;If Cat C/Pend Adj for MT, older than 365 days, agreed to pay, test
 ;date > 10/5/99 reset flag to 0 - no query is necessary.
 I ($P(DGMTDATA,U,4)="C")!($P(DGMTDATA,U,4)="P"&($P(DGMT0,U,12)'<$P(DGMT0,U,27))),$P(DGMTDATA,U,2)>2991005,$P(DGMT0,U,11)=1 S IVMQFLG=0
 ;If patient is Cat C, declined to provide income but has agreed to
 ;pay deductible, no query necessary - reset flag to 0
 I ($P(DGMTDATA,U,4)="C"),+$P(DGMT0,U,14),+$P(DGMT0,U,11) S DGRETV=0
 ;If patient is on a DOM ward, don't initiate query
 D DOM^DGMTR I $G(DGDOM) S IVMQFLG=0
 Q IVMQFLG
 ;
FUT(DFN,DGDT,DGMTYPT) ; Future MT for a patient
 ;DFN      Patient IEN
 ;DGDT     Date (Optional- default to today)
 ;DGMTYPT  Type of Test (Optional - default to MT)
 ;Return
 ;If a DCD test was performed it will be returned, else the
 ;current future dated test for the Income Year.
 ;MT IEN^Date of Test^Status Name^Status Code^Source
 ;
 N DGIDT,Y,MTIEN,SRCE,DONE,MTNOD,ARR,LAST,TYPTST
 S:'$D(DGMTYPT) DGMTYPT=1
 ;no future LTC eg 02/15/2005
 I ($G(DGMTYPT)=4) Q ""
 S TYPTST=$S(DGMTYPT=2:"AF",1:"AE")
 S DGIDT=$S($G(DGDT)>0:DGDT,1:DT),DONE=0
 S (ARR,LAST,Y)=""
 S:$P(DGIDT,".",2) DGIDT=$P(DGIDT,".")
 F  S DGIDT=$O(^IVM(301.5,TYPTST,DFN,DGIDT)) Q:'DGIDT!(DONE)  D
 .S MTIEN=0
 .F  S MTIEN=$O(^IVM(301.5,TYPTST,DFN,DGIDT,MTIEN)) Q:'MTIEN!(DONE)  D
 ..Q:'$D(^DGMT(408.31,MTIEN,0))
 ..S MTNOD=^DGMT(408.31,MTIEN,0),SRCE=$P(MTNOD,U,23)
 ..I SRCE'=1 S DONE=1,Y=MTIEN_U_$P(MTNOD,U)_U_$$MTS^DGMTU(DFN,+$P(MTNOD,U,3))_U_$P(MTNOD,U,23) Q
 ..I 'DONE,'$D(ARR($P(MTNOD,U),MTIEN)) S ARR($P(MTNOD,U),MTIEN)=MTIEN_U_$P(MTNOD,U)_U_$$MTS^DGMTU(DFN,+$P(MTNOD,U,3))_U_$P(MTNOD,U,23)
 I 'DONE S LAST=$O(ARR(""),-1) I LAST S Y=ARR(LAST,$O(ARR(LAST,""),-1))
 Q $G(Y)
