PRSNRUT0 ;WOIFO/DAM - Report for POC Data;060409
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;   
 ; 
POCDSPLY(PRSIEN,BEG,END) ;Entry point to gather POC data from 451
 ;INPUT:
 ;   PRSIEN: Nurse ien 450
 ;   BEG,END: FileMan begin and end dates for report
 ;
 N STOP,PRSNL,DAYNODE,EXTBEG,EXTEND,FMDT,PPIEN,PRSNAME,PRSNSSN,PRSNTL
 N PRSNPP,PRSNDAY,PRSNDY,PRSDT,PG,TODAY
 S STOP=0,PG=0,TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 D INITIAL
 S PRSNL=$$DEFAULTL()
 D HDRINFO
 D HDR
 S FMDT=BEG-.1
 F  S FMDT=$O(^PRST(458,"AD",FMDT)) Q:FMDT>END!(FMDT'>0)!STOP  D
 . S DAYNODE=$G(^PRST(458,"AD",FMDT))
 . S PPIEN=+DAYNODE
 . S PRSNDAY=$P(DAYNODE,U,2)
 . Q:'PRSNDAY
 . K POCD   ;array to hold POC data
 . D L1^PRSNRUT1(.POCD,PPIEN,PRSIEN,PRSNDAY)
 . D GETDAY(PRSNDAY,.PRSNDY,.PRSDT)
 . D DATA
 Q
 ;
DEFAULTL() ;Find external value-nurse's default location
 ;
 Q $P($$PRIMLOC^PRSNUT03($G(^PRSPC(PRSIEN,200))),U,3)
 ;
HDRINFO ;Find nurse information to display in report header
 ;
 N PRSNARY
 S PRSNARY=$G(^PRSPC(PRSIEN,0))
 S PRSNAME=$P(PRSNARY,U)             ;Nurse Name
 S PRSNSSN=$P(PRSNARY,U,9)           ;Nurse SSN
 S PRSNTL=$P(PRSNARY,U,8)              ;Nurse T&L
 Q
 ;
HDR ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1
 W PRSNAME,?32,PRSNL,?48,"T&L"_" "_PRSNTL,?48,?68,$E(PRSNSSN,6,9)
 W !,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,"Date",?11,"Tour Time",?27,"Location",?57,"OT Mandatory"
 W !,?11,"-Exceptions",?27,"-Work Type",?57,"-OT Reason"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
 ;
GETDAY(PRSNDAY,PRSNDY,PRSDT) ;Find external value of Day Number
 ;
 N PRSDY
 ;
 S PRSDY=$P(^PRST(458,PPIEN,2),U,PRSNDAY)
 S PRSNDY=$P(PRSDY," "),PRSDT=$P(PRSDY," ",2,3)
 ;
 Q
 ;
DATA ;Extract display data from POCD array
 ;
 N PRSNST,PRSNSP,PRSNPOC,PRSNPOC1,PRSNTT,PRSNWIEN,PRSNLNG,PRSNTW
 N PRSNM,PRSNRE,PRSNREC,PRSNTWD,PRSNRIEN,PRSNTIEN,PRSL
 ;
 S PRSL=0
 F  S PRSL=$O(POCD(PRSL)) Q:PRSL'>0!STOP  D
 . ;Start and stop time
 . S PRSNST=$P(POCD(PRSL),U),PRSNSP=$P(POCD(PRSL),U,2)
 . ;
 . ;Type of Time code IEN
 . S PRSNTT=$P(POCD(PRSL),U,4),PRSNTIEN=" ",PRSNLNG=" "
 . I PRSNTT'="" D
 . . ;
 . . ;Type of Time code
 . . S PRSNTIEN=$O(^PRST(457.3,"B",PRSNTT,0)) Q:PRSNTIEN'>0
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
 .  ;
 . ;OT Mandatory/Voluntary
 . S PRSNM=$P(POCD(PRSL),U,7)
 . I PRSNM'="" D
 . . I PRSNM="V" S PRSNM="V Voluntary"
 . . I PRSNM="M" S PRSNM="M Mandatory"
 . . ;
 . S PRSNRIEN=$P(POCD(PRSL),U,8),PRSNREC=" ",PRSNRE=" "
 . I PRSNRIEN'="" D
 . . ;Reason for OT code
 . . S PRSNREC=$P(^PRSN(451.6,PRSNRIEN,0),U)
 . . ;
 . . ;Description for OT code
 . . S PRSNRE=$P(^PRSN(451.6,PRSNRIEN,0),U,2)
 . ;
 . D PRNT
 ;
 Q
 ;
PRNT ;Print report
 ;
 W !
 I PRSL=1 W PRSNDY
 W ?11,$G(PRSNST)_"-"_$G(PRSNSP),?27,$G(PRSNPOC1),?57,$G(PRSNM)
 W !
 I PRSL=1 W PRSDT
 W ?11,"-"_$G(PRSNTT)_" "_$G(PRSNLNG),?27,"-"_$G(PRSNTW)_" "_$G(PRSNTWD),?57,"-"_$G(PRSNREC)_" "_$G(PRSNRE)
 W !      ;blank line
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR
 Q
 ;
INITIAL ;  Set up external date range
 ;
 N Y
 S Y=BEG D DD^%DT S EXTBEG=Y
 S Y=END D DD^%DT S EXTEND=Y
 Q
