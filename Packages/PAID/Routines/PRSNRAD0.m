PRSNRAD0 ;WOIFO/DAM - POC GROUP ACTIVITY DETAILED REPORT ;060409
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;   
 ; 
DSPLY(PRSIEN,BEG,END,STOP) ;Entry point to gather POC data from 451
 ;INPUT:
 ;   PRSIEN: Nurse ien 450
 ;   BEG,END: FileMan begin and end dates for report
 ;
 N EXTBEG,EXTEND,FMDT
 N PRSNAME,PRSNTL,SKILMIX,PRSNSSN,PRSNLNG,PRSNTWD,PRSNPOC1,PRSDY
 N PPIEN,PRSL,PRSNDAY,STARTDT,STDE,DATE,DAYNODE,FMDT
 N MEAL,PRSNM,PRSNPOC,PRSNRE,PRSNREC,PRSNRIEN,PRSNSP,PRSNST
 N PRSNTIEN,PRSNTT,PRSNTW,PRSNWIEN,POCD,PRSD
 D INITIAL
 D INFO^PRSNRAS1
 S FMDT=BEG-.1
 N INDEX,CNT,DAYNODE
 S (INDEX,CNT)=0
 F  S FMDT=$O(^PRST(458,"AD",FMDT)) Q:FMDT>END!(FMDT'>0)!STOP  D
 . S DAYNODE=$G(^PRST(458,"AD",FMDT))
 . S PPIEN=+DAYNODE
 . S PRSNDAY=$P(DAYNODE,U,2),PRSD=1
 . K POCD   ;array to hold POC data
 . D L1^PRSNRUT1(.POCD,PPIEN,PRSIEN,PRSNDAY)
 . Q:$G(POCD(0))=0
 . D DATA
 ;
 Q
 ;
INITIAL ;  Set up external date range
 ;
 N Y
 S Y=BEG D DD^%DT S EXTBEG=Y
 S Y=END D DD^%DT S EXTEND=Y
 Q
 ;
HDR ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1
 W ?25,"GROUP ACTIVITY DETAIL REPORT"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !              ;blank line
 W !,"Nurse Name",?21,"Last 4",?29,"Start/",?38,"Type of",?49,"Mand",?57,"Meal",?65,"Location/"
 W !,"Skill Mix",?23,"SSN/",?29,"Stop",?39,"Time",?50,"OT",?57,"Time",?64,"Type of Work"
 W !,"Date",?23,"T&L",?29,"Time"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
 ;
DATA ;Extract display data from POCD array and get external date
 ;
 N PRSEQ
 S (PRSNST,PRSNSP,PRSNPOC,PRSNTT,PRSNWIEN)=""
 S (PRSNTW,PRSNM,PRSNRE,PRSNREC,PRSNRIEN)=""
 S (PRSNLNG,PRSNTWD,PRSNPOC1,PRSDY,DATE,MEAL)=""
 S PRSNTIEN=0
 ;
 ;
 ;Get external date in form of MM/DD/YY
 N DATE S DATE=$E(FMDT,4,5)_"/"_$E(FMDT,6,7)_"/"_$E(FMDT,2,3)
 ;
 ;Get data from POCD array 
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
 . ;Type of Time code IEN
 . S PRSNTT=$P(POCD(PRSEQ),U,4),PRSNTIEN=" ",PRSNLNG=" "
 . I PRSNTT'="" D
 . . ;
 . . ;Type of Time code
 . . S PRSNTIEN=$O(^PRST(457.3,"B",PRSNTT,0)) Q:PRSNTIEN=""
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
 . S PRSNWIEN=$P(POCD(PRSEQ),U,6),PRSNTW=" ",PRSNTWD=" "
 . I PRSNWIEN'="" D
 . . ;
 . . ;Type of Work Code
 . . S PRSNTW=$P(^PRSN(451.5,PRSNWIEN,0),U)
 . . ;
 . . ;Description for Type of Work code
 . . S PRSNTWD=$P(^PRSN(451.5,PRSNWIEN,0),U,2)
 . ;
 . ;OT Mandatory/Voluntary
 . S PRSNM=$P(POCD(PRSEQ),U,7)
 . D PRT
 ;
 Q
 ;
PRT ;Print report
 I PRSL W !,$E(PRSNAME,1,19)
 ;PUT DATE ON FIRST LINE IF NAME & SKILL ARE NOT PRINTED
 I 'PRSL,PRSD W !,"  ",DATE
 W ?22,$E(PRSNSSN,6,9)
 W ?29,PRSNST
 W ?38,PRSNLNG
 W ?51,PRSNM
 W ?58,MEAL
 W ?65,$E(PRSNPOC1,1,14)
 W !
 I PRSL W "  ",$E(SKILMIX,1,17)
 W ?22,PRSNTL
 W ?29,PRSNSP
 W ?65,$E(PRSNTWD,1,14)
 W !
 ;PUT DATE ON THIRD LINE IF NAME & SKILL ARE PRINTED
 I PRSL,PRSD W "  ",DATE,!
 S (PRSL,PRSD)=0
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR
 Q
