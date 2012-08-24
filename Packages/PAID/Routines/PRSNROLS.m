PRSNROLS ;WOIFO/JEO - Overtime summary report  ;091611
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
DAP ; Entry point for Data Approval Personnel
 N GROUP
 D ACCESS^PRSNUT02(.GROUP,"A",DT,1)
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 Q
 ;
COORD ;Entry point for VANOD Coordinator
 ; Coordinator has no access limits so let them pick any group
 N GROUP
 D PIKGROUP^PRSNUT04(.GROUP,"",1)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 Q
 ;
MAIN ; 
 N RANGE,BEG,END,LASTDT,MTIME,STIME,ETIME,FIELDS,FIRSTDT
 N PRSIEN,PRSNGLB,PRSNG,GHD,PICK,SORT,STOP,I,PRSNGA,PRSNGB,TAB,PG
 N TODAY,SOTPIM,RTIME,OTTIM,OTARR,MIN,K,GTOT,GGTOT,GGGTOT
 N OTPIM,NURSE,REPLOC
 S TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 N %ZIS,POP,IOP
 K POCD
 D RANGE
 Q:+RANGE'>0
 S %ZIS="MQ",PG=0
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="LOCATION OVERTIME ACTIVITY SUMMARY REPORT"
 . S ZTRTN="START^PRSNROLS"
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("BEG")=""
 . S ZTSAVE("END")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D START
 Q
 ;
START ;
 N PRSNL,DAYNODE,EXTBEG,EXTEND,FMDT,PPIEN,PRSNAME,PRSNSSN,PRSNTL,NURSE,DIVI,PRSNG
 N PRSNPP,PRSNDAY,PRSNDY,PRSDT,TODAY,PRSNGLB,PICK,STOP,SORT,PG,GHD,PRSNGA,PRSNGB,PRSIEN
 U IO
 K ^TMP($J,"OT")
 D FILE,HDR,PRINT
 D ^%ZISC
 K ^TMP($J,"OT")
 Q
 ;
RANGE ; User is prompted for a date or date range
 ;
 S RANGE=$$POCRANGE^PRSNUT01()
 S BEG=$P($G(RANGE),U)
 S END=$P($G(RANGE),U,2)
 Q
 ;
FILE ;
 ;
 S SORT=$P(GROUP(0),U,2),PG=0
 S (PICK,STOP)=0
 S TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 D INITIAL^PRSNRUT0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 .S DIVI=$$EXTERNAL^DILFD(456,.01,"",$P(GROUP(PICK),U,3))
 .S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 .S PRSNGLB=$S($P(PRSNG,U,2)="N":$NA(^NURSF(211.8,"D",$P(PRSNG,U,7))),1:$NA(^PRSPC("ATL"_$P(PRSNG,U,3))))
 .; display and underline group sub header
 .S GHD=$S($P(PRSNG,U,2)="N":"LOCATION",1:"T&L UNIT")_":  "_$P(PRSNG,U,3)
 .;S TAB=IOM-$L(GHD)/2-5
 .S PRSNGA=""
 .F  S PRSNGA=$O(@PRSNGLB@(PRSNGA)) QUIT:PRSNGA=""!STOP  D
 ..S PRSNGB=0
 ..F  S PRSNGB=$O(@PRSNGLB@(PRSNGA,PRSNGB)) QUIT:'PRSNGB!STOP  D
 ...I $P(PRSNG,U,2)="N",+$P(PRSNG,U,4)'=+$$PRIMLOC^PRSNUT03(PRSNGB) Q
 ...S PRSIEN=$S($P(PRSNG,U,2)="N":+$G(^VA(200,PRSNGB,450)),1:PRSNGB)
 ...S PRSNL=$$DEFAULTL^PRSNRUT0()
 ...I PRSNL="" S PRSNL="**NONE**"
 ...S NURSE=$$ISNURSE^PRSNUT01(PRSIEN)
 ...I +NURSE D INFO(PRSIEN,DIVI,PICK)
 Q
 ;
INFO(PRSIEN,DIVI,PICK) ;Find nurse information to display in report
 N FMDT,PPIEN,PRSNDAY,POCD,DAYNODE,NFL
 N PRSNARY,PRSNAME,PRSNSSN,PRSNTL,SKILMIX
 S PRSNARY=$G(^PRSPC(PRSIEN,0))
 S PRSNTL=$P(PRSNARY,U,8)                        ;Nurse T&L
 S SKILMIX=$P($$ISNURSE^PRSNUT01(PRSIEN),U,2)    ;Nurse skillmix
 I SKILMIX["ADMINISTRATIVE" S SKILMIX="ADMIN RN"
 I SKILMIX["RN" S NFL=1
 I SKILMIX["LPN" S NFL=2
 I SKILMIX'["RN",SKILMIX'["LPN" S NFL=3
 Q:$G(DIVI)=""!($G(PICK)="")
 S STOP=0
 S FMDT=BEG-.1
 F  S FMDT=$O(^PRST(458,"AD",FMDT)) Q:FMDT>END!(FMDT'>0)!STOP  D
 . S DAYNODE=$G(^PRST(458,"AD",FMDT))
 . S PPIEN=+DAYNODE
 . S PRSNDAY=$P(DAYNODE,U,2)
 . Q:'PRSNDAY
 . K POCD   ;array to hold POC data
 . D L1^PRSNRUT1(.POCD,PPIEN,PRSIEN,PRSNDAY)
 . D GETDAY(PRSNDAY,.PRSNDY,.PRSDT),DATA
 Q
 ;     
HDR ;;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1
 W ?22,"LOCATION OVERTIME ACTIVITY SUMMARY REPORT"
 W !,"--------------------------------------------------------------------------------"
 W !,EXTBEG_" - "_EXTEND,?42,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !                                                         ;blank line
 W !,"Location",?18,"Reason for",?40,"# Of",?50,"# Of",?60,"# Of",?71,"Total"
 W !,?18,"Overtime",?40,"Hours",?50,"Hours",?60,"Hours",?71,"Hours"
 W !,?41,"RN",?51,"LPN",?61,"UAP"
 W !,"--------------------------------------------------------------------------------",!
 Q
 ;
DEFAULTL() ;Find external value-nurse's default location
 ;
 Q $P($$PRIMLOC^PRSNUT03($G(^PRSPC(PRSIEN,200))),U,3)
 ;
GETDAY(PRSNDAY,PRSNDY,PRSDT) ;Find external value of Day Number
 ;
 N PRSDY
 S PRSDY=$P(^PRST(458,PPIEN,2),U,PRSNDAY)
 S PRSNDY=$P(PRSDY," "),PRSDT=$P(PRSDY," ",2,3)
 Q
 ;
DATA ;Extract display data from POCD array
 ;
 N PRSNST,PRSNSP,PRSNPOC,PRSNPOC1,PRSNTT,PRSNWIEN,PRSNLNG,PRSNTW
 N PRSNM,PRSNRE,PRSNREC,PRSNTWD,PRSNRIEN,PRSNTIEN,PRSL
 N STIME,ETIME,OTTIME
 ;
 S PRSL=0
 F  S PRSL=$O(POCD(PRSL)) Q:PRSL'>0!STOP  D
 . ;Start and stop time
 . S PRSNST=$P(POCD(PRSL),U),PRSNSP=$P(POCD(PRSL),U,2)
 . ;
 . ;Type of Time code IEN
 . S PRSNTT=$P(POCD(PRSL),U,4),PRSNLNG=" "
 . I PRSNTT'="" D
 . . ;
 . . ;Type of Time code
 . . S PRSNTIEN=$O(^PRST(457.3,"B",PRSNTT,0))
 . . Q:PRSNTIEN'>0
 . . ;
 . . ;Description for Type of Time code
 . . S PRSNLNG=$P(^PRST(457.3,PRSNTIEN,0),U,2)
 . ;
 . S PRSNPOC=$P(POCD(PRSL),U,5),PRSNPOC1="**NONE**"
 . I PRSNPOC'="" D
 . . ;POC
 . . S PRSNPOC1=$P($$ISACTIVE^PRSNUT01(DT,PRSNPOC),U,2)
 . ;
 . ;Type of Work Code IEN
 . S PRSNWIEN=$P(POCD(PRSL),U,6),PRSNTW=" ",PRSNTWD=" "
 . I PRSNWIEN'="" D
 . . ;
 . . ;Type of Work Code
 . . S PRSNTW=$P(^PRSN(451.5,PRSNWIEN,0),U)
 . . ;
 . . ;Description for Type of Work code
 . . S PRSNTWD=$P(^PRSN(451.5,PRSNWIEN,0),U,2)
 . ;
 . ;OT Mandatory/Voluntary
 . S PRSNM=$P(POCD(PRSL),U,7)
 . ;no need to continue if this isn't an overtime record
 . Q:$G(PRSNM)=""
 . I PRSNM="V" S PRSNM="V Voluntary"
 . I PRSNM="M" S PRSNM="M Mandatory"
 . ;
 . S PRSNRIEN=$P(POCD(PRSL),U,8),PRSNREC=" ",PRSNRE=" "
 . I PRSNRIEN'="" D
 . . ;Reason for OT code
 . . S PRSNREC=$P(^PRSN(451.6,PRSNRIEN,0),U)
 . . ;
 . . ;Description for OT code
 . . S PRSNRE=$P(^PRSN(451.6,PRSNRIEN,0),U,2)
 . ;
 . ; OT time
 . S STIME=$P(POCD(PRSL),U,9)
 . S ETIME=$P(POCD(PRSL),U,10)
 . S MTIME=$P(POCD(PRSL),U,3)
 . S OTTIME=$$ELAPSE^PRSPESR2(MTIME,STIME,ETIME)
 . S OTTIME=$P(OTTIME,":",1)*60+$P(OTTIME,":",2)    ; IN MIN
 . S ^TMP($J,"OT",PRSNPOC1,PRSNRE,NFL)=$G(^TMP($J,"OT",PRSNPOC1,PRSNRE,NFL))+OTTIME
 ;
 Q
 ;
PRINT ;Print report
 ;
 S REPLOC="",GGGTOT=0
 F K=1:1:3 S GGTOT(K)=""
 F  S REPLOC=$O(^TMP($J,"OT",REPLOC)) Q:REPLOC=""!STOP  D
 . F K=1:1:3 S SOTPIM(K)=""    ; For a location level
 . S GGTOT=""
 . W ?2,$E(REPLOC,1,14)
 . S OTREASON=""
 . F  S OTREASON=$O(^TMP($J,"OT",REPLOC,OTREASON)) Q:OTREASON=""!STOP  D
 . . W ?18,OTREASON
 . . S GTOT=""
 . . F K=1:1:3 S OTTIM(K)=""
 . . S (GRANDT,NFL)=""
 . . F  S NFL=$O(^TMP($J,"OT",REPLOC,OTREASON,NFL)) Q:NFL=""  D
 . . . S OTARR(NFL)=^TMP($J,"OT",REPLOC,OTREASON,NFL)
 . . D GETTIME                                      ; Each occurance
 . . S GTOTPR=$$TIME(GTOT)
 . . F K=1:1:3 S OTTIM(K)=$$TIME(OTTIM(K))
 . . W ?40,$J(OTTIM(1),7),?50,$J(OTTIM(2),7),?60,$J(OTTIM(3),7),?70,$J(GTOTPR,7),!
 . . F K=1:1:3 S OTTIM(K)="",OTARR(K)=""
 . . S GTOTPR=""
 . . I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR
 . Q:STOP
 . W !!,?3,"--------------"
 . F K=1:1:3 S SOTPIM(K)=$$TIME(SOTPIM(K))
 . S GGTOT=$$TIME(GGTOT)
 . W !,?10,"TOTAL:"                                     ;Location
 . W ?40,$J(SOTPIM(1),7),?50,$J(SOTPIM(2),7),?60,$J(SOTPIM(3),7),?70,$J(GGTOT,7),!!
 Q:STOP
 S GGGTOT=$$TIME(GGGTOT) F K=1:1:3 S GGTOT(K)=$$TIME(GGTOT(K))
 W !!,?4,"GRAND TOTAL:",?40,$J(GGTOT(1),7),?50,$J(GGTOT(2),7),?60,$J(GGTOT(3),7),?70,$J(GGGTOT,7)
 Q
 ;
GETTIME ;
 S GTOT=""
 F K=1:1:3  D
 . I $D(OTARR(K)) D
 . . ;  Reason
 . . S OTTIM(K)=OTARR(K)
 . . S GTOT=GTOT+OTARR(K)
 . . ;  Location
 . . S SOTPIM(K)=SOTPIM(K)+OTARR(K)
 . . S GGTOT=GGTOT+OTARR(K)
 . . ;  Total
 . . S GGTOT(K)=GGTOT(K)+OTARR(K)
 . . S GGGTOT=GGGTOT+OTARR(K)
 ;
 Q
 ;
TIME(TIME) ;
 S HR=TIME\60,MIN=TIME#60
 I MIN<10 S MIN=0_MIN
 Q HR_":"_MIN
 ;
