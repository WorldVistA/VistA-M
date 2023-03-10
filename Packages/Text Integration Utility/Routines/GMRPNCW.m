GMRPNCW ;SLC/DJP,MKB,MJC - CWAD Utility ;Jan 13, 2021@10:55
 ;;1.0;TEXT INTEGRATION UTILITIES;**120,341**;Jun 20, 1997;Build 23
EN ;Entry for secondary option to lookup patient, display warnings
 Q:IOST?1"P".E  D SETUP("REVIEW PATIENT WARNINGS")
 N X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S GMRPEN=1,GMRPOPT=1
 F  D  Q:$D(GMRPQT)
 .W ! S DIC="^DPT(",DIC(0)="AEQM" D ^DIC
 .S:(Y<1)!($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) GMRPQT=1
 K GMRPQT,GMRPEN,GMRPOPT,GMRPDFN,DIC,VAROOT
 Q
SETUP(TITLE)    ;entry utilities, option header
 N GMRPI K GMRPQT,GMRPSTOP,GMRPLIST,GMRPOPT,GMRPAT
 W @IOF,!!?(IOM-$L(TITLE)\2),TITLE,! F GMRPI=1:1:IOM W "-"
 W !
 Q
ENPAT ;Additional entry point; must be passed Patient DFN in Y.
 ;Setting GMRPEN permits individual options to turn on the Clin Alerts.
 ;When ON, the keys GMRPC and/or GMRPWA may be required in the future.
 Q:'$D(GMRPEN)
 Q:+Y<1  N DIC,DFN,GMRPTYP
 S (GMRPDFN,DFN)=+Y,$P(GMRPDFN,U,2)=$P(^DPT(+GMRPDFN,0),U)
 D ALLERGY,WH
 I '$D(^TIU(8925,"ADCPT",+GMRPDFN)),'$D(GMRPALG),$S($D(GMRPOPT):1,$D(GMRPHOLD):1,1:0),'$D(GMRPWH) D  Q
 . W !!,"No Patient Warnings on file for "
 . W $P(GMRPDFN,U,2),".",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 D CWLKP I $D(GMRPOPT),'$D(GMRPQT) D PRINT
END K GMRPQT,GMRPCWA,GMRPALG,GMRPX,X,CWA,GMRPWH
 Q
CWLKP ;Lookup and presentation of CWA indicators
 S GMRPCWA=""
 F CWA("DOCTYPE")=30,31,27 D
 . I $D(^TIU(8925,"ADCPT",+GMRPDFN,CWA("DOCTYPE"),7))!$D(^TIU(8925,"ADCPT",+GMRPDFN,CWA("DOCTYPE"),8)) S GMRPTYP=$S(CWA("DOCTYPE")=30:"C",CWA("DOCTYPE")=31:"W",1:"D") D LIST ;GMRP*2.5*50 include amended as well as complete
 I $D(GMRPALG) S GMRPCWA=GMRPCWA_"A" W !?24,"A: Known allergies"
 S GMRPCWA=GMRPCWA_$G(GMRPWH)
 I $G(GMRPWH)["P" W !,?24,"P: Pregnant"
 I $G(GMRPWH)["L" W !,?24,"L: Lactating"
 I '$L(GMRPCWA) S GMRPQT=1 Q
 I '$D(GMRPOPT),$D(GMRPHOLD) W ! N DIR,X,Y S DIR(0)="E" D ^DIR W:$D(DIRUT)!(Y=1) ! Q
 D RESPOND:$D(GMRPOPT)
 Q
LIST ;List data lines -- expects GMRPTYP="C" or "W" or "A" or "D"
 N GMRPDT,GMRPIFN,GMRPDDT,CTR,COUNT,STATUS
 S GMRPCWA=GMRPCWA_GMRPTYP
 ; GMRP*2.5*50 include amended as well as complete:
 S GMRPDT(7)=$O(^TIU(8925,"ADCPT",+GMRPDFN,CWA("DOCTYPE"),7,0))
 S GMRPDT(8)=$O(^TIU(8925,"ADCPT",+GMRPDFN,CWA("DOCTYPE"),8,0))
 ; Get inverse date & status of most recent complete or amended note:
 I 'GMRPDT(7) S GMRPDT=+GMRPDT(8) Q:'GMRPDT  S STATUS=8
 I '$G(GMRPDT) I 'GMRPDT(8) S GMRPDT=+GMRPDT(7) Q:'GMRPDT  S STATUS=7
 I '$G(GMRPDT) D
 . I GMRPDT(7)<GMRPDT(8) S GMRPDT=GMRPDT(7),STATUS=7 Q
 . S GMRPDT=GMRPDT(8),STATUS=8
 S GMRPDDT=$$DATE^TIULS((9999999-GMRPDT),"MM/DD/YY HR:MIN")
 S (CTR,COUNT)=0
 F  S COUNT=$O(^TIU(8925,"ADCPT",+GMRPDFN,CWA("DOCTYPE"),7,COUNT)) Q:+COUNT'>0  S CTR=CTR+1 ;Counts the number of COMPLETE warnings on file  
 S COUNT=0
 F  S COUNT=$O(^TIU(8925,"ADCPT",+GMRPDFN,CWA("DOCTYPE"),8,COUNT)) Q:+COUNT'>0  S CTR=CTR+1 ; GMRP*2.5*50, adds the number of amended warnings on file
 W !?11," (",CTR," note",$S(CTR>1:"s",1:" "),")",?24,GMRPTYP,": ",GMRPDDT
 W $$ADDEND(STATUS)
 Q
ADDEND(STATUS) ; If addended or amended, return most recent of these, for most recent note.
 N IEN,AMENDDT,ADDMDT,ADDMIEN,AAMENDDT,MAX,MSG
 ; GMRP*2.5*50, get most recent complete OR AMENDED note:
 S IEN=0
 S IEN=$O(^TIU(8925,"ADCPT",+GMRPDFN,CWA("DOCTYPE"),STATUS,GMRPDT,IEN))
 S AMENDDT=+$G(^TIU(8925,IEN,16)) ;date of note amendment
 S ADDMIEN=+$O(^TIU(8925,"DAD",IEN,""),-1) ; IEN of most recent addendum
 I +$P($G(^TIU(8925,ADDMIEN,0)),U,5)<7 S ADDMIEN=0 ;forget addm if not signed
 S ADDMDT=+$G(^TIU(8925,ADDMIEN,12)) ; date of addm
 S AAMENDDT=+$G(^TIU(8925,ADDMIEN,16)) ;date of addm amendment
 I AAMENDDT>AMENDDT S AMENDDT=AAMENDDT
 S MAX=$S(AMENDDT>ADDMDT:AMENDDT,1:ADDMDT)
 I MAX=0 S MSG="" G ADDX
 I MAX=AMENDDT S MSG="  (amended "_$$DATE^TIULS(AMENDDT,"MM/DD/YY HR:MIN")_")" G ADDX
 S MSG="  (addendum "_$$DATE^TIULS(ADDMDT,"MM/DD/YY HR:MIN")_")"
ADDX Q MSG
 ;
RESPOND ;prompt for warnings to display
 W !!,"Select patient warning(s) to display: "_GMRPCWA_"//"
 R GMRPX:60 I '$T!(GMRPX["^") S GMRPQT=1 Q
 S:GMRPX="" GMRPX=GMRPCWA
 I GMRPX["?" D QUES K GMRPX G RESPOND
 S GMRPX=$$UP^XLFSTR(GMRPX)
 Q
PRINT ;Prints Crisis Notes, Clin Warnings & Allergies using HS utilities.
 S X="GMTS" X ^%ZOSF("TEST") I '$T W $C(7) D  Q
 .W !,"This display uses the Health Summary, currently unavailable.",!
 N GMTSTITL,GMTSPRM,GMRPHSTYPE S GMTSTITL="PATIENT WARNINGS",GMTSPRM=""
 S:GMRPX["C" GMTSPRM="CN"
 I $L($T(CD^GMTSCW)) D
 .S:GMRPX["W" GMTSPRM=GMTSPRM_",CW"
 .S:GMRPX["D" GMTSPRM=GMTSPRM_",CD"
 I '$L($T(CD^GMTSCW)) D
 .S:GMRPX["W"!(GMRPX["D") GMTSPRM=GMTSPRM_",CW"
 S:GMRPX["A" GMTSPRM=GMTSPRM_",ADR"
 I GMTSPRM="" S GMRPQT=1
 I GMTSPRM'="" D
 .I $E(GMTSPRM)="," S GMTSPRM=$P(GMTSPRM,",",2,5)
 .D ENCWA^GMTS
 I GMRPX["P",GMRPX["L" S GMRPHSTYPE="VA-WH PREG & LAC STATUS"
 E  D
 .I GMRPX["P" S GMRPHSTYPE="VA-WH PREGNANCY STATUS"
 .I GMRPX["L" S GMRPHSTYPE="VA-WH LACTATION STATUS"
 I $G(GMRPHSTYPE)'="" D
 .K GMRPQT,^TMP("DIERR",$J)
 .S GMRPHSTYPE("NAME")=GMRPHSTYPE,GMRPHSTYPE=$$FIND1^DIC(142,,"X",GMRPHSTYPE)
 .I +GMRPHSTYPE=0 D  Q
 ..W !!,"Could not find the "_GMRPHSTYPE("NAME")_" health summary type."
 ..I $D(^TMP("DIERR",$J)) W ! D MSG^DIALOG() K ^TMP("DIERR",$J)
 ..S GMRPQT=1
 .D ENX^GMTSDVR(DFN,GMRPHSTYPE)
 Q
QUES ;Response to "?" at CWA prompt
 W !!,"     Enter:"
 W !?8,"C     for Crisis Notes",!?8,"W     for Clinical Warnings"
 W !?8,"A     for Allergies",!?8,"D     for Directive Notes"
 W !?8,"P     for Pregnant",!,?8,"L     for Lactating"
 W !?8,"CWADPL  for all 6 patient warnings"
 W !!?8,"or any combination of C, W, A, D, P and L without commas."
 Q
ALLERGY ;checks for allergies on file for patient - requires GMRPDFN
 ;Returns GMRPALG if allergies found ('$D if none)
 K GMRPALG,GMRA
 S X="GMRADPT" X ^%ZOSF("TEST") I $T D  Q
 .D EN1^GMRADPT S:+$G(GMRAL) GMRPALG=1 K GMRAL
 I $D(^DPT(+GMRPDFN,"PA",0)),$P(^(0),U,4)>0 S GMRPALG=1
 Q
WH ;Retrieves pregnancy and lactation status for patient
 K GMRPWH
 S GMRPWH=$$POSTSHRT^WVRPCOR(+GMRPDFN)
 Q
