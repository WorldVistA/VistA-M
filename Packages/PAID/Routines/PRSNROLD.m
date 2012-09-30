PRSNROLD ;WOIFO/JEO - OVERTIMIVIE DETAIL REPORT ;080811
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
MAIN ;
 N RANGE,BEG,END,LASTDT,MTIME,STIME,ETIME
 N %ZIS,POP,IOP
 K POCD
 D RANGE
 Q:+RANGE'>0
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="LOCATION OVERTIME ACTIVITY DETAIL REPORT"
 . S ZTRTN="FILE^PRSNROLD"
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("BEG")=""
 . S ZTSAVE("END")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D FILE
 Q
 ;
RANGE ;
 ; User is prompted for a date or date range
 S RANGE=$$POCRANGE^PRSNUT01()
 S BEG=$P($G(RANGE),U)
 S END=$P($G(RANGE),U,2)
 Q
 ;
FILE ;
 ;
 N PRSNL,DAYNODE,EXTBEG,EXTEND,FMDT,PPIEN,PRSNAME,PRSNSSN,PRSNTL
 N PRSNPP,PRSNDAY,PRSNDY,PRSDT,TODAY,DIVI,NURSE
 N PRSIEN,PRSNGLB,PRSNG,GHD,PICK,SORT,STOP,I,PRSNGA,PRSNGB,TAB,PG
 U IO
 S SORT=$P(GROUP(0),U,2),PG=0
 S (PICK,STOP)=0
 S TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 D INITIAL^PRSNRUT0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 .S DIVI=$$EXTERNAL^DILFD(456,.01,"",$P(GROUP(PICK),U,3))
 .S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 .S PRSNGLB=$S($P(PRSNG,U,2)="N":$NA(^NURSF(211.8,"D",$P(PRSNG,U,7))),1:$NA(^PRSPC("ATL"_$P(PRSNG,U,3))))
 .; display and underline group sub header
 .;
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
 ;
 D ^%ZISC
 Q
INFO(PRSIEN,DIVI,PICK) ;Find nurse information to display in report
 N FMDT,PPIEN,PRSNDAY,POCD,DAYNODE
 N PRSNARY,PRSNAME,PRSNSSN,PRSNTL,SKILMIX
 S PRSNARY=$G(^PRSPC(PRSIEN,0))
 ; Nurse Name
 S PRSNAME=$P(PRSNARY,U)
 ; Nurse SSN
 S PRSNSSN=$P(PRSNARY,U,9)
 ; Nurse T&L
 S PRSNTL=$P(PRSNARY,U,8)
 ; Nurse skillmix
 S SKILMIX=$P($$ISNURSE^PRSNUT01(PRSIEN),U,2)
 I SKILMIX["ADMINISTRATIVE" S SKILMIX="ADMIN RN"
 Q:$G(DIVI)=""!($G(PICK)="")
 S STOP=0
 I PG>0 S STOP=$$ASK^PRSLIB00()
 Q:STOP
 D HDR
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
 W @IOF
 S PG=PG+1
 W ?19,"NURSE OVERTIME DETAIL REPORT"
 W !,PRSNAME,?32,$E(PRSNL,1,14),?48,"T&L"_" "_PRSNTL,?48,?68,$E(PRSNSSN,6,9)
 W !,"--------------------------------------------------------------------------------"
 W !,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !                                                         ;blank line
 W !,"Date",?11,"Tour Time",?27,"Location",?46,"# Of",?57,"OT Mandatory"
 W !,?11,"-Exceptions",?27,"-Work Type",?45,"Hours",?57,"-OT Reason"
 W !,"--------------------------------------------------------------------------------"
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
 N STIME,ETIME,OTTIME,PRTDY
 ;
 S PRSL=0,PRTDY=0
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
 . . ;
 . S PRSNPOC=$P(POCD(PRSL),U,5),PRSNPOC1=" "
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
 . D PRNT
 Q
PRNT ;Print report
 ;
 W !
 I 'PRTDY W PRSNDY
 W ?11,$G(PRSNST)_"-"_$G(PRSNSP),?27,$G(PRSNPOC1),?57,$G(PRSNM)
 W !
 I 'PRTDY W PRSDT
 W ?11,"-"_$G(PRSNTT)_" "_$G(PRSNLNG),?27,"-"_$G(PRSNTW)_" "_$G(PRSNTWD),?46,OTTIME,?57,"-"_$G(PRSNREC)_" "_$G(PRSNRE)
 W !      ;blank line
 S PRTDY=1
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR
 Q
 ;
