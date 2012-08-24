PRSNRAS1 ;WOIFO/DAM - POC GROUP ACTIVITY SUMMARY REPORT ;060409
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ; 
DSPLY(PRSIEN,BEG,END,EXTBEG,EXTEND,STOP) ; gather POC data from 451
 ;INPUT:
 ;   PRSIEN: Nurse ien 450
 ;   BEG,END: FileMan begin and end dates for report
 ;
 N INDEX,CNT,DAYNODE,FMDT,POCD,WKTOT
 N PRSNAME,PRSNTL,SKILMIX,MIX1,MIX2
 N PRSNLNG,PRSNTWD,PRSNPOC1,PRSDY
 N PPIEN,PRSL,PRSNDAY,STARTDT,STDE,PRSNSSN
 D INFO
 S FMDT=BEG-.1
 S (INDEX,CNT)=0
 F  S FMDT=$O(^PRST(458,"AD",FMDT)) Q:FMDT>END!(FMDT'>0)!STOP  D
 . S DAYNODE=$G(^PRST(458,"AD",FMDT))
 . S PPIEN=+DAYNODE
 . S PRSNDAY=$P(DAYNODE,U,2)
 . K POCD   ;array to hold POC data
 . D L1^PRSNRUT1(.POCD,PPIEN,PRSIEN,PRSNDAY)
 . Q:$G(POCD(0))=0
 . D DATA
 ;
 D PRTLOOP(EXTBEG,EXTEND)
 Q
 ;
INFO ;Find nurse information to display in report
 ;
 N PRSNARY
 ;
 S PRSL=1
 S PRSNARY=$G(^PRSPC(PRSIEN,0))
 S PRSNAME=$P(PRSNARY,U)              ;Nurse Name
 S PRSNSSN=$P(PRSNARY,U,9)           ;Nurse SSN
 S PRSNTL=$P(PRSNARY,U,8)             ;Nurse T&L
 S SKILMIX=$P($$ISNURSE^PRSNUT01(PRSIEN),U,2) ;  Nurse skillmix
 I SKILMIX["ADMINISTRATIVE" S SKILMIX="ADMIN RN"
 Q
 ;
HDR(EXTBEG,EXTEND) ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1
 W ?25,"GROUP ACTIVITY SUMMARY REPORT"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,"Nurse Name",?21,"Type of",?32,"Type of",?48,"Location",?68,"# of",?75,"T&L"
 W !,"Skill Mix",?22,"Time",?33,"Work",?68,"Hours",?75,"Unit"
 W !,"--------------------------------------------------------------------------------",!
 ;
 Q
 ;
DATA ;Extract display data from POCD array
 ;
 N PRSNST,PRSNSP,PRSNPOC,PRSNTT,PRSNWIEN,HOURS,PRSNTIEN
 N PRSNTW,PRSNM,PRSNRE,PRSNREC,PRSNRIEN,MEAL,PRSEQ
 S (PRSNLNG,PRSNTWD,PRSNPOC1,PRSDY)=""
 S PRSNTIEN=0
 ;
 ;
 S PRSEQ=0
 F  S PRSEQ=$O(POCD(PRSEQ)) Q:PRSEQ'>0!STOP  D
 . ;Start Time
 . S PRSNST=$P(POCD(PRSEQ),U)
 . ;
 . ;Stop Time 
 . S PRSNSP=$P(POCD(PRSEQ),U,2)
 . ;
 . ;Meal Time
 . S MEAL=$P(POCD(PRSEQ),U,3)
 . ;
 . ;Get hours worked in a given location
 . S HOURS=$$AMT^PRSPSAPU(PRSNST,PRSNSP,MEAL)
 . ;
 . ;Type of Time code IEN
 . S PRSNTT=$P(POCD(PRSEQ),U,4),PRSNLNG=" "
 . I PRSNTT'="" D
 . . ;
 . . ;Type of Time code
 . . S PRSNTIEN=$O(^PRST(457.3,"B",PRSNTT,0))
 . . Q:PRSNTIEN=""
 . . ;
 . . ;Description for Type of Time code
 . . S PRSNLNG=$P(^PRST(457.3,PRSNTIEN,0),U,2)
 . . ;
 . S PRSNPOC=$P(POCD(PRSEQ),U,5),PRSNPOC1=" "
 . I PRSNPOC'="" D
 . . ;POC
 . . S PRSNPOC1=$P($$ISACTIVE^PRSNUT01(DT,PRSNPOC),U,2)
 . ;
 . ;Type of Work Code IEN
 . S PRSNWIEN=$P(POCD(PRSEQ),U,6),PRSNTWD=" "
 . I PRSNWIEN'="" D
 . . ;
 . . ;Type of Work Code
 . . S PRSNTW=$P(^PRSN(451.5,PRSNWIEN,0),U)
 . . ;
 . . ;Description for Type of Work code
 . . S PRSNTWD=$P(^PRSN(451.5,PRSNWIEN,0),U,2)
 .;
 .; save hours into work array
 . I '$D(WKTOT(PRSNLNG,PRSNTWD,PRSNPOC1)) D
 .. S CNT=CNT+1
 .. S (INDEX,WKTOT(PRSNLNG,PRSNTWD,PRSNPOC1,0))=CNT
 . E  D
 .. S INDEX=$G(WKTOT(PRSNLNG,PRSNTWD,PRSNPOC1,0))
 . S WKTOT(INDEX,PRSNLNG,PRSNTWD,PRSNPOC1)=$G(WKTOT(INDEX,PRSNLNG,PRSNTWD,PRSNPOC1))+HOURS
 ;
 Q
 ;
PRTLOOP(EXTBEG,EXTEND) ;  Loop through Totals array and print each one
 ;
 N PRSEQ,TT,TWD,POC,CNT
 S PRSEQ=0,CNT=0
 F  S PRSEQ=$O(WKTOT(PRSEQ)) Q:PRSEQ'>0!STOP  D
 . S TT=""
 . F  S TT=$O(WKTOT(PRSEQ,TT)) Q:TT=""!STOP  D
 .. S TWD=""
 .. F  S TWD=$O(WKTOT(PRSEQ,TT,TWD)) Q:TWD=""!STOP  D
 ... S POC=""
 ... F  S POC=$O(WKTOT(PRSEQ,TT,TWD,POC)) Q:POC=""!STOP  D
 .... S HOURS=$G(WKTOT(PRSEQ,TT,TWD,POC)),CNT=CNT+1
 .... D PPP(EXTBEG,EXTEND)
 ; need a blank line between nurses when there was only one record printed
 I CNT=1 W !
 Q
 ;
PPP(EXTBEG,EXTEND) ;
 I PRSL W !,$E(PRSNAME,1,19)
 W ?21,TT,?32,$E(TWD,1,14),?48,$E(POC,1,16),?66,$J(HOURS,7,2),?75,PRSNTL
 W !
 I PRSL W "  ",$E(SKILMIX,1,17)
 ;
 S PRSL=0
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR(EXTBEG,EXTEND)
 Q
