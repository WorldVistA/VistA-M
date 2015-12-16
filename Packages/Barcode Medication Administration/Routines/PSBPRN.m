PSBPRN ;BIRMINGHAM/EFC-BCMA PRN FUNCTIONS ;12/14/12 12:22pm
 ;;3.0;BAR CODE MED ADMIN;**5,3,13,61,68,70,80,86**;Mar 2004;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Reference/IA
 ;DEM^VADPT/10061
 ;INP^VADPT/10061
 ;$$GET1^DIQ/2056
 ;GETSIOPI^PSJBCMA5/5763
 ;
 ;*68 - add call to add special instructions (SI) entries to the
 ;      ^TMP("PSB")  global that ends up in the RESULTS ARRAY of
 ;      RPC PSB GETPRNS.
 ;      and add new parameter to GETPRNS tag to use new SI/OPI word
 ;      processing fields.
 ;*70 - remove discharged status from the api and rename DECEASED
 ;      see below, in tag Getprns, for searchng back rules and dates
 ;      of CO vs IM orders.
 ;
 ; ** Warning: PSBSIOPI will be used as a global variable for all down
 ;    streams calls from this RPC tag call.
 ;
EN ;
 Q
 ;
EDIT ; Edit Medication Log PRN Effectiveness
 NEW DFN ;* Undef DFN at EDIT+7^PSBPRN (NOIS: HUN-0699-21494)
 W !! S DA=""
 S DIC="^DPT(",DIC(0)="AEQM",DIC("A")="Select Patient Name: "
 D ^DIC K DIC Q:+Y<1
 S DFN=+Y
 D EDIT1
 K DFN,DA
 G EDIT
 ;
EDIT1 ;
 S %DT="AEQ",%DT("A")="Select Date to Begin Searching Back From: "
 S %DT("B")="Today"
 W !! D ^%DT Q:+Y<1  S PSBDT=Y
 F  D  Q:'PSBDT
 .W @IOF,!,"Searching Date " S Y=PSBDT D D^DIQ W Y
 .W !," #  Medication",?45,"St",?50,"D/T Given",?75,"Int"
 .W !,$TR($J("",IOM)," ","-")
 .S PSBSRCH=PSBDT+.9,PSBCNT=0
 .K PSBTMP
 .F  S PSBSRCH=$O(^PSB(53.79,"APRN",DFN,PSBSRCH),-1) Q:'PSBSRCH!(PSBSRCH<PSBDT)  D
 ..S PSBIEN=""
 ..F  S PSBIEN=$O(^PSB(53.79,"APRN",DFN,PSBSRCH,PSBIEN),-1) Q:'PSBIEN  D
 ...Q:$P($G(^PSB(53.79,PSBIEN,.2)),U,2)]""
 ...Q:$P($G(^PSB(53.79,PSBIEN,0)),U,9)'="G"
 ...S PSBCNT=PSBCNT+1,PSBTMP(PSBCNT)=PSBIEN
 ...I $Y>19 W ! S DIR(0)="E" D ^DIR W @IOF,!,"Searching Date " S Y=PSBDT D D^DIQ W Y,!," #  Medication",?45,"St",?50,"D/T Given",?75,"Int",!,$TR($J("",IOM)," ","-")
 ...W !,$J(PSBCNT,2),". "
 ...W ?5,$$GET1^DIQ(53.79,PSBIEN_",",.08)
 ...W ?45,$P(^PSB(53.79,PSBIEN,0),U,9)
 ...W ?50,$$GET1^DIQ(53.79,PSBIEN_",",.06)
 ...W ?75,$$GET1^DIQ(53.79,PSBIEN_",","ACTION BY:INITIAL")
 .I PSBCNT W ! S DIR(0)="NO^1:"_PSBCNT_":0" D ^DIR S:Y DA=PSBTMP(Y),PSBDT="" Q:Y
 .I 'PSBCNT W !!?5,"No Meds Found!"
 .S X1=PSBDT,X2=-1 D C^%DTC S (PSBDT,Y)=X D D^DIQ
 .W !!,"Continue With ",Y
 .S %=1 D YN^DICN I %'=1 S PSBDT=0
 I DA S DDSFILE=53.79,DR="[PSB PRN EFFECTIVENESS]" D ^DDS S %=2 W !,"Edit another entry" D YN^DICN G:%=1 EDIT1
 K PSBCNT,PSBDT,PSBIEN,PSBSRCH,PSBTMP,DA,DR,DDSFILE
 Q
 ;
GETPRNS(RESULTS,DFN,PSBORD,PSBSIOPI) ; Get the PRN's for a pt needing effectiveness
 ;
 ; RPC PSB GETPRNS
 ;
 ; Description:
 ; Returns all administrations of a PRN order that have NOT had
 ; the PRN Effectiveness documented BASED ON THE TRANSFER DATE AND SITE PARAM
 ;
 N PSBADMDT,PSBHOUR,PSBPRNDT,PSBIEN,PSBSTOP,PSBIMHR,PSBIMPRNDT,PSBCODY,PSBCOPRNDT,PSBSTRT,PSBIMMAX   ;Add PSBSTRT to list of newed variables, PSB*3*86
 K ^TMP("PSB",$J),RESULTS
 S PSBSIOPI=+$G(PSBSIOPI)   ;*68 init to 0 if not present or 1 if sent
 ;
 Q:$$DECEASED(DFN)                                                ;*70
 ;
 D INP^VADPT S PSBADMDT=+VAIN(7)                   ;get admit date *70
 ;get IM site param then build IM & CO PRN dates                   *70
 S PSBIMHR=$$GET^XPAR("DIV","PSB PRN DOCUMENTATION")  ;IM hours
 S:'PSBIMHR PSBIMHR=72                ;IM def=72 hrs if param null *70
 S PSBCODY=1                          ;CO def = 1 day, no time     *70
 ;
 ;*70
 ; BUILD IM & CO prn date limit from Site param and/or defaults,
 ; then use the oldest of the 2 PRN dates for the loop quit value.
 ; If an admit date exists and is older than the IM date, then use
 ; it for the loop. Also if admit date is present, then CO orders
 ; should use IM rules and dates.
 ;
 ; CO date, for non-admitted patient, will be a whole day, no time.
 ;
 D NOW^%DTC S PSBSTRT=%
 S PSBIMMAX=$$GET^XPAR("ALL","PSB MED HIST DAYS BACK"),PSBIMMAX=$S(PSBIMMAX<35:35,1:PSBIMMAX) ;Set PSBIMMIX to Med Hist Days Back parameter or 35 days, whichever is longer 
 S PSBIMMAX=$$FMADD^XLFDT(PSBSTRT,-PSBIMMAX) ;Limit days for PRN Effectiveness, PSB*3*86 
 ;create IM & CO past date limit to include these order types     *70
 S PSBIMPRNDT=$$FMADD^XLFDT(PSBSTRT,"",-PSBIMHR)
 S PSBCOPRNDT=$$FMADD^XLFDT($P(PSBSTRT,"."),-PSBCODY)
 S PSBPRNDT=$S(PSBCOPRNDT<PSBIMPRNDT:PSBCOPRNDT,1:PSBIMPRNDT)
 ;use older of PSBPRNDT & PSBADMDT(admission) for loop quit value
 I PSBADMDT,PSBADMDT<PSBPRNDT S (PSBPRNDT,PSBIMPRNDT,PSBCOPRNDT)=$S(PSBIMMAX<PSBADMDT:PSBADMDT,1:PSBIMMAX) ;Use max days back parameter PSBIMMAX, PSB*3*86
 I PSBADMDT,PSBPRNDT<PSBIMPRNDT S PSBIMPRNDT=PSBADMDT ;Preserve admission date for inpatient medications, PSB*3*80
 ;end dates                                                       *70
 ;
 ;begin loop of PRN records
 S PSBSTRT="" F  S PSBSTRT=$O(^PSB(53.79,"APRN",DFN,PSBSTRT),-1) Q:(PSBSTRT<PSBPRNDT)  D
 .S PSBIEN=""
 .F  S PSBIEN=$O(^PSB(53.79,"APRN",DFN,PSBSTRT,PSBIEN),-1) Q:'PSBIEN  D
 ..Q:(PSBORD'="")&($P(^PSB(53.79,PSBIEN,.1),U)'=PSBORD)  ;  Not the right order
 ..I ($P(^PSB(53.79,PSBIEN,0),U,9)'="G")&($P(^PSB(53.79,PSBIEN,0),U,9)'="RM") Q    ; Med was never given
 ..Q:$P($G(^PSB(53.79,PSBIEN,.2)),U,2)]""  ; Already entered
 ..S PSBX=PSBIEN_U_DFN,PSBIENS=PSBIEN_","
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.02)
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.06,"I")
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.07)
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.08)
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.21)
 ..D PSJ1^PSBVT(DFN,$$GET1^DIQ(53.79,PSBIENS,.11))
 ..;admit date exists, force CO order to look like an IM           *70
 ..I PSBADMDT S PSBCLORD=""
 ..;skip CO order admins that are older than CO PRN date           *70
 ..Q:($G(PSBCLORD)]"")&($P(PSBSTRT,".")<$P(PSBCOPRNDT,"."))
 ..;skip IM order admins that are older than IM PRN date           *70
 ..Q:($G(PSBCLORD)="")&(PSBSTRT<PSBIMPRNDT)
 ..S PSBX=PSBX_U_PSBOIT_U_PSBONX
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.27)
 ..S Y=$O(^TMP("PSB",$J,""),-1)+1
 ..S ^TMP("PSB",$J,Y)=PSBX
 ..;Special instructions
 ..S Y=Y+1,^TMP("PSB",$J,Y)=PSBOTXT
 ..F PSBZ=.5,.6,.7 F PSBY=0:0 S PSBY=$O(^PSB(53.79,PSBIEN,PSBZ,PSBY)) Q:'PSBY  D
 ...S PSBDD=$S(PSBZ=.5:53.795,PSBZ=.6:53.796,1:53.797)
 ...S PSBSOL=$S(PSBZ=.5:"DD",PSBZ=.6:"ADD",1:"SOL")
 ...Q:'$D(^PSB(53.79,PSBIEN,PSBZ,PSBY))
 ...S PSBUNIT=$$GET1^DIQ(PSBDD,PSBY_","_PSBIEN_",",.03)
 ...S PSBUNFR=$$GET1^DIQ(PSBDD,PSBY_","_PSBIEN_",",.04)
 ...I PSBUNIT>0&(PSBUNIT<1) S PSBUNIT="0"_+PSBUNIT ;add leading 0 for a decimal value less than 1 - PSB*3*61
 ...S Y=Y+1
 ...S ^TMP("PSB",$J,Y)=PSBSOL_U_$$GET1^DIQ(PSBDD,PSBY_","_PSBIEN_",",.01)_U_PSBUNIT_U_PSBUNFR
 ..D:PSBSIOPI GETSI(DFN,PSBONX,.Y)     ;*68 get spec inst/oth prt info
 ..S Y=Y+1,^TMP("PSB",$J,Y)="END"
 S ^TMP("PSB",$J,0)=+$O(^TMP("PSB",$J,""),-1)
 S RESULTS=$NAME(^TMP("PSB",$J))
 D CLEAN^PSBVT
 Q
 ;
DECEASED(DFN) ; Patient Deceased?                                        *70
 ;
 S DECEASED=0
 ;
 D DEM^VADPT ;check for date of death entry
 I VADM(6)]"" S DECEASED=1,^TMP("PSB",$J,0)=0 K VADM
 ;
 I DECEASED D  ;setup results and clean up
 .S RESULTS=$NAME(^TMP("PSB",$J))
 .D CLEAN^PSBVT
 ;
 Q DECEASED
 ;
GETSI(DFN,ORD,PSB) ;Get Special Instructions/Other Print Info from IM   ;*68
 ;
 ; This Tag will load the SIOPI WP text into the TMP global used by
 ; the PSB GETPRNS RPC, which ends up in the RESULTS array passed
 ; back to the BCMA GUI.
 ;
 N QQ
 K ^TMP("PSJBCMA5",$J,DFN,ORD)
 D GETSIOPI^PSJBCMA5(DFN,ORD,1)
 Q:'$D(^TMP("PSJBCMA5",$J,DFN,ORD))
 F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,DFN,ORD,QQ)) Q:'QQ  D
 .S PSB=PSB+1
 .S ^TMP("PSB",$J,PSB)="SI^"_^TMP("PSJBCMA5",$J,DFN,ORD,QQ)
 K ^TMP("PSJBCMA5",$J,DFN,ORD)
 Q
