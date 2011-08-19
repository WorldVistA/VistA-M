PXRRMDR ;BP/WLC - PCE Missing Data Report ;11 Feb 04  10:10 AM
 ;;1.0;PCE;**124,174,168**;FEB 11, 2004;Build 14
 ; 04/11/05 WLC changed to check for AO, IR and EC, only if SC'=YES
 Q
 ;
EN N PX,PXPAGE,PXLOC,PXPROV,SDDIV,ZTSAVE,%DT,DIR,DTOUT,DUOUT,X,Y,POP,PXDT,PXDS,RPTYP,EDT,PAT,SSN,DT,TY,CBU,VDT,LOC,PROV,SORT,SORTHDR,CNT,PRIO
 S (POP,PXPAGE)=0
 K PXDS
 D HOME^%ZIS S:'$D(IOF) IOF=FF W @IOF,!!
 S X=$$CTR("PCE Missing Data Report")
 W !! D DATASRC^PXRRMDR1 G:POP EXIT   ; sets PXDS() PX*1.0*174
 W @IOF,!! S X=$$CTR("**** Date Range Selection ****")
 W !!! S %DT="AEPX",%DT("A")="Beginning date: " D ^%DT G:Y<1 EXIT S PX("BDT")=Y
EDT S %DT("A")="   Ending date: " W ! D ^%DT G:Y<1 EXIT
 I Y<PX("BDT") W !!,$C(7),"End date cannot be before begin date!",! G EDT
 S PX("EDT")=Y_.999999
 W @IOF,!! S X=$$CTR("*** Report Sort Selection ***")
 W !!! K DIR S SORTHDR="DATA SOURCE^CPT^ICD9^PATIENT^ELIGIBILITY"
 F LOOP=1:1:$L(SORTHDR,U) S DESC=$P(SORTHDR,U,LOOP) W !,"("_LOOP_")  "_DESC
 W ! S DIR(0)="N^^I X<1!(X>5) K X",DIR("A")="Enter number between 1 and 5" D ^DIR Q:$D(DIRUT)  S PXSRT=+X
 S DIR(0)="S^D:DETAILED REPORT;S:STATISTICS ONLY",DIR("A")="Select report type",DIR("B")="DETAILED REPORT" D ^DIR Q:$D(DIRUT)
 S RPTYP=Y
 W !!,"This report requires 132 column output.",!
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="RUN^PXRRMDR",ZTDESC="PCE MISSING DATA REPORT"
 . S ZTSAVE("PX*")=""
 . S ZTSAVE("RPTYP")="",ZTSAVE("SORTHDR")=""
 . D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q"),ZTSAVE D HOME^%ZIS
 ;
RUN ;
 U IO
 K ^TMP("PXCRPW",$J),DIR S (PXOUT)=""
 N LOOP,PXDT,I,VSN,VISITS,CLASSIF
 S PXDT=(PX("BDT")-1)_.99999 K ^TMP("PXCRPW",$J)
 F  S PXDT=$O(^AUPNVSIT("ADEL",PXDT)) Q:PXDT>PX("EDT")!('PXDT)  D
 . S VSN=0 F  S VSN=$O(^AUPNVSIT("ADEL",PXDT,VSN)) Q:'VSN  D
 . . S VISITS=$P($G(^AUPNVSIT(VSN,812)),U,3) S:VISITS="" VISITS="Unknown"
 . . Q:'$D(PXDS(VISITS))
 . . D ENCEVENT^PXKENC(VSN,0)
 . . Q:$P($G(^TMP("PXKENC",$J,VSN,"VST",VSN,0)),U,7)="E"  ;Historic encounter PX*1.0*174
 . . Q:$$TESTPAT^VADPT($P($G(^TMP("PXKENC",$J,VSN,"VST",VSN,0)),U,5))  ;Test patient PX*1.0*174
 . . N OE S OE=$O(^SCE("AVSIT",VSN,0)) Q:'OE  Q:$P(^SCE(OE,0),U,6)]""  Q:$P(^SCE(OE,0),U,12)=12  ;Check if a child encounter, non-count  PX*1.0*174
 . . I '$D(^TMP("PXKENC",$J,VSN,"CPT")) D SET("Visit is missing a Procedure Code",1) Q
 . . I $$EXOE^SDCOU2(OE) Q  ;Determine if Encounter is Exempt from Outpatient Classifications and Diagnoses PX*1.0*174
 . . N I,J S (I,CNT)=0 F  S I=$O(^TMP("PXKENC",$J,VSN,"CPT",I)) Q:'I  D
 . . . S CNT=0 F J=5,9,10,11,12,13,14,15 I $P(^TMP("PXKENC",$J,VSN,"CPT",I,0),U,J) S CNT=CNT+1
 . . . I CNT=0 D SET("Procedure: "_$$DISPLYP($P(^TMP("PXKENC",$J,VSN,"CPT",I,0),U))_" missing assoc. DXs",1)
 . . S (I,J)=0 F  S I=$O(^TMP("PXKENC",$J,VSN,"POV",I)) Q:'I  D
 . . . K CLASSIF S DFN=$$GET1^DIQ(9000010,VSN_",",.05,"I")
 . . . I $$AO^SDCO22(DFN) S CLASSIF(1)=""
 . . . I $$IR^SDCO22(DFN) S CLASSIF(2)=""
 . . . I $$SC^SDCO22(DFN) S CLASSIF(3)=""
 . . . I $$EC^SDCO22(DFN) S CLASSIF(4)=""
 . . . I $$MST^SDCO22(DFN) S CLASSIF(5)=""
 . . . I $$HNC^SDCO22(DFN) S CLASSIF(6)=""
 . . . I +$P($$CVEDT^DGCV(DFN,PXDT),"^",3) S CLASSIF(7)=""
 . . . I $$SHAD^SDCO22(DFN) S CLASSIF(8)=""
 . . . I $D(CLASSIF),'$D(^TMP("PXKENC",$J,VSN,"POV",I,800)) D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing SC/EI",1) Q
 . . . S J="" F  S J=$O(CLASSIF(J)) Q:'J  D
 . . . . N SCEIREC S SCEIREC=$G(^TMP("PXKENC",$J,VSN,"POV",I,800))
 . . . . I J=3&($P(SCEIREC,U,1)="") D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing Service Connect.",1)
 . . . . I J=1&($P(SCEIREC,U,2)="")&($P(SCEIREC,U,1)'=1) D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing Agent Orange",3)
 . . . . I J=2&($P(SCEIREC,U,3)="")&($P(SCEIREC,U,1)'=1) D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing Ion. Rad.",4)
 . . . . I J=4&($P(SCEIREC,U,4)="")&($P(SCEIREC,U,1)'=1) D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing Env. Contam.",5)
 . . . . I J=5&($P(SCEIREC,U,5)="") D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing MST",6)
 . . . . I J=6&($P(SCEIREC,U,6)="") D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing Head/Neck Cancer",6)
 . . . . I J=7&($P(SCEIREC,U,7)="") D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing Combat Vet",2)
 . . . . I J=8&($P(SCEIREC,U,8)="") D SET("Diagnosis: "_$$DISPLYDX($P(^TMP("PXKENC",$J,VSN,"POV",I,0),U))_" missing Project 112/SHAD",6)
 U IO D PRINT^PXRRMDR1,^%ZISC
 K ^TMP("PXCRPW",$J)
EXIT Q
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (PXOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0)
 Q
 ;
EVAL ;
 S PXLOC=$$GET1^DIQ(9000010,VSN_",",.22)
 S:$G(PXLOC)="" PXLOC="Unknown"
 N PXPTR S PXPTR=$O(^AUPNVPRV("AD",VSN,""))
 S PXPRV=$$GET1^DIQ(9000010.06,PXPTR_",",.01)
 S:$G(PRPRV)="" PXPRV="Unknown"
 Q
 ;
DISPLYDX(PXCEPOV)       ;
 N ICDSTR
 S ICDSTR=$$ICDDX^ICDCODE($P(PXCEPOV,"^"),$P(^AUPNVSIT(VSN,0),"^"))
 Q $P(ICDSTR,"^",2) ;code
 ;
DISPLYP(PXCECPT) ;
 N CPTSTR
 S CPTSTR=$$CPT^ICPTCOD($P(PXCECPT,U),$P(^AUPNVSIT(VSN,0),"^"))
 Q $P(CPTSTR,U,2) ;code
 ;
SET(SDX,PRIO) ;
 N A1
 S PRIO=$G(PRIO)
 D EVAL
 I PXSRT="" S A1="Unknown" D SET1(PRIO) Q
 D @PXSRT
 Q
 ;
1 ; Data Source
 S A1=$$GET1^DIQ(9000010,VSN_",",81203)
 S:A1="" A1=" "
 D SET1(PRIO)
 Q
 ;
2 ; CPT
 N CPT,CPT1
 S CPT=$O(^AUPNVCPT("AD",VSN,""))
 S:CPT'="" CPT1=$$GET1^DIQ(9000010.18,CPT_",",.01)
 S A1=$G(CPT1) D SET1(PRIO)
 Q
 ;
3 ; ICD-9
 N ICD,ICD9 S ICD="",ICD9="Unknown"
 F  S ICD=$O(^AUPNVPOV("AD",VSN,ICD)) Q:'ICD  D
 . S ICD9=$$GET1^DIQ(9000010.07,ICD,.01)
 S A1=ICD9 D SET1(PRIO)
 Q
 ;
4 S A1=$$GET1^DIQ(9000010,VSN_",",.05)
 S:A1="" A1="Unknown"
 D SET1(PRIO)
 Q
 ;
5 ; Eligibility
 S A1=$$GET1^DIQ(9000010,VSN_",",.21)
 S:A1="" A1="Unknown"
 D SET1(PRIO)
 Q
 ;
6 ; Default Sort
 S A1="Default" D SET1(PRIO)
 Q
 ;
SET1(PR) ; set temp global
 I A1="" S A1="Unknown"
 S Y=$$GET1^DIQ(9000010,VSN_",",.01) X ^DD("DD") S VDT=Y
 S:VDT="" VDT="Unknown" S VDT=$P(VDT,"@",1)
 S ^TMP("PXCRPW",$J,PXLOC,PXPRV,A1,VDT,VSN,PR,SDX)=VSN
 Q
CTR(X) ;
 W ?(IOM-$L(X))\2,X
 Q 1
 ;
