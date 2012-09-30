DVBAB82 ;ALB - CAPRI DVBA REPORTS ; 01/24/12
 ;;2.7;AMIE;**42,90,100,119,156,149,179**;Apr 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
START(MSG,RPID,PARM) ; CALLED BY REMOTE PROCEDURE DVBAB REPORTS
 ;Parameters
 ;=============
 ; MSG  : Output - ^TMP("DVBA",$J)
 ; RPID : Report Identification Number
 ; PARM : Input parameters separated by "^"
 ;
 N DVBHFS,DVBERR,DVBGUI,I,DVBADLMTD
 K ^TMP("DVBA",$J)
 S DVBGUI=1,(DVBERR,DVBADLMTD)=0,DVBHFS=$$HFS(),RPID=$G(RPID)
 I RPID<1!(RPID>14) S DVBERR=1,^TMP("DVBA",$J,1)="0^Undefined Report ID" G END
 D HFSOPEN("DVBRP",DVBHFS,"W") I DVBERR G END
 I RPID=1 D CRMS G END
 I RPID=3 D CPRNT G END
 I RPID=11 D CNHRP G END  ;FNCNH Print Roster
 D CHECK I DVBERR G END  ;reports below require parameters
 I RPID=2 D CRRR G END
 I RPID=4 D CRPON G END
 I RPID=5 D CIRPT G END
 I RPID=6 D DSRP G END
 I RPID=7 D SDPP G END
 I RPID=8 D SPRPT G END
 I RPID=9 D VIEW G END
 I RPID=10 D CNHDEOC G END  ;FBCNH Display Episode Of Care
 I RPID=12 D CNHRAD G END  ;FNCNH Report of Admissions/Discharges
 I RPID=13 D CNHSE90D G END  ;FNCNH Stays in Excess of 90 Days
 I RPID=14 D REQSTAT G END  ;REQUEST STATUS BY DATE RANGE
 ;
END D HFSCLOSE("DVBRP",DVBHFS)
 I ($G(DVBADLMTD)&('+DVBERR)) D  Q  ;Create delimited output if no errors
 .D DLMTRPT^DVBAB82D(RPID)
 .S MSG=$NA(^TMP("DVBADLMTD",$J))
 ;Replace "##FFFF##" with Form Feeds - code needed for LINUX environments
 S I=0 F  S I=$O(^TMP("DVBA",$J,1,I)) Q:'I  D
 .S:^TMP("DVBA",$J,1,I)["##FFFF##" ^TMP("DVBA",$J,1,I)=$P(^TMP("DVBA",$J,1,I),"##FFFF##")_$C(13,12)_$P(^TMP("DVBA",$J,1,I),"##FFFF##",2)
 .S ^TMP("DVBA",$J,1,I)=^TMP("DVBA",$J,1,I)_$C(13)
 .S:^TMP("DVBA",$J,1,I)["$END" ^TMP("DVBA",$J,1,I)=""
 S MSG=$NA(^TMP("DVBA",$J))
 Q
CHECK ; VALIDATE INPUT PARAMETERS
 I $G(PARM)="" S DVBERR=1,^TMP("DVBA",$J,1)="0^Undefined Input Parameters"
 Q
 ;
SDPP ; Report # 7 - Full (Patient Profile MAS) Report
 ;Parameters
 ;=============
 ; DFN : Patient Identification Number
 ; SDR : R/Range or A/All
 ; SDBD : Begining date
 ; SDED : Ending date
 ; SDP : Print the profile? 1 OR 0
 ; SDTYP(2) : Print appointments? 1 OR 0
 ; SDTYP(1) : Print add/edits? 1 or 0
 ; SDTYP(4) : Print enrollments? 1 or 0
 ; SDTYP(3) : Print dispositions? 1 OR 0
 ; SDTYP(7) : Print team information? 1 OR 0
 ; SDTYP(5) : Print means test? 1 OR 0
 ;
 N SDTYP,SDBD,SDED,SDACT,SDPRINT,SDYES,SDRANGE,SDBEG,SDEN
 S ^XTMP("JAP",$J,$$NOW^XLFDT(),"SDPP")=PARM
 S DFN=$P(PARM,"^",1),SDR=$P(PARM,"^",2),SDBD=$P(PARM,"^",3),SDED=$P(PARM,"^",4)
 S SDP=$P(PARM,"^",5),SDTYP(2)=$P(PARM,"^",6),SDTYP(1)=$P(PARM,"^",7)
 S SDTYP(4)=$P(PARM,"^",8),SDTYP(3)=$P(PARM,"^",9),SDTYP(7)=$P(PARM,"^",10),SDTYP(5)=$P(PARM,"^",11)
 D VAL Q:DVBERR
 S SDACT="",(SDYES,SDRANGE,SDPRINT)=0
 I SDR="R" S SDRANGE=1
 I SDP=1 S SDYES=1,SDPRINT=1
 I 'SDRANGE S (SDBD,SDBEG)=2800101,(SDED,SDEND)=$$ENDDT(),SDHDR=1
 D ENS^%ZISS
 S SDPRINT=1
 S:(SDTYP(2)=1) SDTYP(2)=""  ;appointments
 K:(SDTYP(2)=0) SDTYP(2)
 S:(SDTYP(1)=1) SDTYP(1)=""  ;add/edits
 K:(SDTYP(1)=0) SDTYP(1)
 I (SDTYP(4)=1) S SDTYP(4)="",SDACT=0  ;enrollments
 K:(SDTYP(4)=0) SDTYP(4)
 S:(SDTYP(3)=1) SDTYP(3)=""  ;dispositions
 K:(SDTYP(3)=0) SDTYP(3)
 S:(SDTYP(5)=1) SDTYP(5)=""  ;means test
 K:(SDTYP(5)=0) SDTYP(5)
 I SDTYP(7)=1 D  ;team information
 . S SDTYP(7)="",GBL="^TMP(""SDPP"","_$J_")"
 K:(SDTYP(7)=0) SDTYP(7)
 D PRINT^SDPPRT
 S VALMBCK="R"
 Q
ENDDT() ;Calculate end date for "all" date
 N DVBAPPTS,DVBX
 S DVBAPPTS(1)=2800101,DVBAPPTS(4)=DFN,DVBAPPTS("SORT")="P"
 S DVBAPPTS("FLDS")=1,DVBAPPTS("MAX")=-1
 S DVBX=$S(($$SDAPI^SDAMA301(.DVBAPPTS)>0):$O(^TMP($J,"SDAMA301",DFN,0)),1:DT_.24)
 K ^TMP($J,"SDAMA301")
 Q DVBX
 ;
VIEW ; Report # 9 - View Registration Data Report
 ; Parameters
 ; ==========
 ; DFN : Patient Identification Number
 ;
 U IO
 S DFN=$P(PARM,"^",1)
 D VAL Q:DVBERR
 D EN1^DGRP
 Q
 ;
DSRP ; Report # 6 - Reprint a Notice of Discharge Report
 ; Parameters
 ; % : 1=Report on all veterans for a given day (BDATE required)
 ;   : 0=Report on a single Veteran (DFN required)
 ; BDATE : Original Processing Date - $H/FileMan
 ; DFN  : Patient Identification Number
 ;
 N %,BDATE,DFN,DFNIEN
 S %=$P(PARM,"^",1),BDATE=$P(PARM,"^",2),DFN=$P(PARM,"^",3),DFNIEN=""
 I BDATE="" S DVBERR=1,^TMP("DVBA",$J,1)="0^Incorrect Date"  Q
 D DUZ2^DVBAUTIL
 U IO
 D VAL Q:DVBERR
 I %=1 D  Q
 . S HD="SINGLE NOTICE OF DISCHARGE REPRINTING"
 . D NOPARM^DVBAUTL2
 . I $D(DVBAQUIT) D KILL^DVBAUTIL Q  ;CAUTION: Short-circuit
 . S DTAR=^DVB(396.1,1,0),FDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 . S HEAD="NOTICE OF DISCHARGE",HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0)
 . I $D(^DVB(396.2,"B",DFN)) D
 . . S DFNIEN=$O(^DVB(396.2,"B",DFN,DFNIEN)),ADM=$P(^DVB(396.2,DFNIEN,0),U,3)
 . . I $D(^DGPM(+ADM,0)),$P(^(0),U,17)]"" S DCHPTR=$P(^DGPM(+ADM,0),U,17),DISCH=$S($P(^DGPM(DCHPTR,0),U,1)]"":$P(^(0),U,1),1:"") W ?($X+5),"Discharge date: ",$$FMTE^XLFDT(DISCH,"5DZ")
 . . I $P(^DVB(396.2,DFNIEN,0),U,7)'=DVBAD2 W *7,!!,"This does not belong to your RO.",!! H 3 Q
 . . I DFNIEN>0 S XDA=DFNIEN,DA=$P(^DVB(396.2,DFNIEN,0),U,1),ADMDT=$P(^DVB(396.2,DFNIEN,0),U,2),MB=$P(^(0),U,3)
 . . D REPRINT^DVBADSNT
 D DEQUE^DVBADSRP
 Q
 ;
SPRPT ; Report # 8 - OP(Operation Report)
 ;Parameters
 ;=============
 ; DFN : Patient Identification Number
 ; SRTN : Select Operation
 ;
 N DFN,SRTN,MAGTMPR2,SRSITE
 I $O(^SRO(133,1))'="B" S SRSITE=1
 S DFN=$P(PARM,"^",1),SRTN=$P(PARM,"^",2),MAGTMPR2=1
 D VAL Q:DVBERR
 D ^SROPRPT
 Q
 ;
CRPON ; Report # - 4 Reprint C&P Final Report
 ;Parameters
 ;=============
 ; RTYPE : Select Reprint Option (D)ate or (V)eteran
 ; RUNDATE : ORIGINAL PROCESSING date
 ; ANS : Reprinted by the RO or MAS
 ; % : LAB 1 OR 0
 ; DA(1) : Patient IEN for lab results
 ; DFN  : Patient Identification Number
 ;
 U IO
 N ONE
 S RTYPE=$P(PARM,"^",1),RUNDATE=$P(PARM,"^",2),ANS=$P(PARM,"^",3),%=$P(PARM,"^",4),DA(1)=$P(PARM,"^",5),DFN=$P(PARM,"^",6),DA=DA(1)
 I RTYPE="V" D VAL Q:DVBERR
 S XDD=^DD("DD"),$P(ULINE,"_",70)="_",ONE="N",Y=DT
 X XDD S HD="Reprint C & P Exams",SUPER=0
 I $D(^XUSEC("DVBA C SUPERVISOR",DUZ)) S SUPER=1
 S DVBCDT(0)=Y,PGHD="Compensation and Pension Exam Report",LOC=DUZ(2),PG=0,DVBCSITE=$S($D(^DVB(396.1,1,0)):$P(^(0),U,1),1:"Not specified")
 I "^D^V^"'[RTYPE S DVBERR=1,^TMP("DVBA",$J,1)="0^Incorrect Data Type" Q
 I ANS="R" K AUTO
 I ANS="M" S AUTO=1
 I "^M^R^"'[ANS S DVBERR=1,^TMP("DVBA",$J,1)="0^Incorrect Data Type" Q
 I RTYPE="D" D GO^DVBCRPRT Q
 I RTYPE="V" D
 . S ONE="Y",RO=$P(^DVB(396.3,DA,0),U,3)
 . I RO'=DUZ(2)&('$D(AUTO))&(SUPER=0) W !!,*7,"Those results do not belong to your office.",!! Q
 . I RO=DUZ(2)&('$D(AUTO))&("RC"'[($P(^DVB(396.3,DA,0),U,18))) W *7,!!,"This request has not been released to the Regional Office yet.",!! Q
 . S PRTDATE=$P(^DVB(396.3,DA,0),U,16) I PRTDATE="" W *7,!!,"This has never been printed.",!! I SUPER=0 S OUT=1 Q
 . I %=1 D REN2^DVBCLABR Q
 . ;D OV^DVBCRPON
 . K DVBAON2 D SETLAB^DVBCPRNT,VARS^DVBCUTIL,STEP2^DVBCRPRT
 Q
 ;
CIRPT ; Report # 5 - Insufficient Exam Report
 ;Parameters
 ;=============
 ; RPTTYPE : D/Detailed or S/Summary
 ; BEGDT : Beginning date $H/FileMan
 ; ENDDT : Ending date $H/FileMan
 ; RESANS : Insufficient Reason
 ; DVBAPRTY : Priority of Exam Code
 ;    AO  : Agent Orange
 ;    BDD : Benefits Delivery at Discharge / Quick Start
 ;    DES : DES Claimed Condition by Service Member / Fit for Duty
 ;    ALL : All Others (Original Report w/ all codes except the above)
 ;
 N DVBAPRTY,RPTTYPE,BEGDT,ENDDT,RESANS
 U IO
 S RPTTYPE=$P(PARM,"^",1),BEGDT=$P(PARM,"^",2),ENDDT=$P(PARM,"^",3),RESANS=$P(PARM,"^",4)
 S DVBAPRTY=$P(PARM,"^",5)
 S ENDDT=ENDDT_".2359"
 I RPTTYPE="S" D SUM^DVBCIRPT Q
 I RPTTYPE="D" D
 . D INREAS
 . Q:($D(^TMP("DVBA",$J,1)))  ;invalid reason sent
 . D EXMTPE,DETAIL^DVBCIRP1
 Q
 ;
EXMTPE ;exam types (retrieve all for filter)
 N DVBAXIFN
 F DVBAXIFN=0:0 S DVBAXIFN=$O(^DVB(396.6,DVBAXIFN)) Q:+DVBAXIFN=0  DO
 . S ^TMP($J,"XMTYPE",DVBAXIFN)=""
 Q
INREAS ;insufficient reason (validate specific or retrieve all)
 N DVBAXIFN
 D:(RESANS="")  ;use all insufficient reasons
 .F DVBAXIFN=0:0 S DVBAXIFN=$O(^DVB(396.94,DVBAXIFN)) Q:+DVBAXIFN=0  DO
 .. S DVBAARY("REASON",DVBAXIFN)=""
 D:(RESANS'="")  ;use specific insufficient reason
 .I ('$D(^DVB(396.94,+RESANS))) D  ;validate IEN
 ..S DVBERR=1,^TMP("DVBA",$J,1)="0^Invalid Insufficient Reason IEN"
 .E  S DVBAARY("REASON",+RESANS)=""
 Q
 ;
CRMS ; Report # 1 - Regional Office 21- day Certificate Printing Report.
 ; No Parameters
 ;
 U IO
 D ^DVBACRMS
 Q
 ;
CRRR ; Report # 2 - Reprint a 21 - day Certificate for the RO
 ;Parameters
 ;=============
 ; DVBSEL : Select one of the following:
 ;       N         Patient Name
 ;       D         ORIGINAL PROCESSING DATE
 ; SDATE : ORIGINAL PROCESSING date - $H/FileMan
 ; XDA : Patient IEN
 ;
 U IO
 S DVBSEL=$P(PARM,"^",1),SDATE=$P(PARM,"^",2),XDA=$P(PARM,"^",3)
 I "^D^N^"'[DVBSEL S DVBERR=1,^TMP("DVBA",$J,1)="0^Incorrect Data Type" Q
 I DVBSEL="D" D  I DVBERR Q
 . I SDATE="" S DVBERR=1,^TMP("DVBA",$J,1)="0^Undefined Date" Q
 . S %DT="X" S X=SDATE D ^%DT I Y<0 D  Q
 . . S DVBERR=1,^TMP("DVBA",$J,1)="0^Incorrect Date Format"
 I DVBSEL="N" D  I DVBERR Q
 . I XDA="" S DVBERR=1,^TMP("DVBA",$J,1)="0^Undefined Patient IEN" Q
 . S DIC=2,DIC(0)="NZX",X=XDA D ^DIC I Y<0 D  I DVBERR Q
 . . S DVBERR=1,^TMP("DVBA",$J,1)="0^Invalid Patient Name."
 . S DFN=XDA
 D INIT^DVBACRRR I 'CONT Q
 D HDR^DVBACRRR,DATA^DVBACRRR
 Q
 ;
CPRNT ; Report # 3 - Print C&P Final Report (manual) Report
 ; No Parameters
 ;
 S XDD=^DD("DD"),$P(ULINE,"_",70)="_",Y=DT
 X XDD S DVBCDT(0)=Y,PGHD="Compensation and Pension Exam Report",DVBCSITE=$S($D(^DVB(396.1,1,0)):$P(^(0),U,1),1:"Not Specified")
 D GO^DVBCPRNT
 Q
VAL ; VALIDATE PATIENT
 I $G(DFN)="" S DVBERR=1,^TMP("DVBA",$J,1)="0^Undefined Patient IEN" G END
 S DIC=2,DIC(0)="NZX",X=DFN D ^DIC
 I Y<0 S DVBERR=1,^TMP("DVBA",$J,1)="0^Invalid Patient Name." G END
 Q
 ;
VALDATE(DVBADTE) ;Validate Date
 ;dates must be valid internal FileMan format
 N X,Y,%DT
 S %DT="X",X=DVBADTE D ^%DT
 S:(Y=-1) DVBERR=1,^TMP("DVBA",$J,1)="0^Invalid FileMan formatted date."
 Q
 ;
CNHDEOC ; Report #10 - FBCNH Display Episode of Care
 ; Parameters
 ; ==========
 ;   DFN : IEN in PATIENT (#2) file
 ;   IFN : IEN in FEE CNH ACTIVITY (#162.3) file
 ;
 U IO
 N DFN,IFN
 S DFN=$P(PARM,U,1),IFN=$P(PARM,U,2)
 D ^FBNHDEC  ;DBIA#: 5566
 Q
 ;
CNHRP ; Report #11 - FBCNH Roster Print
 ; Parameters
 ; ==========
 ;   DVBADLMTD : 0 (Standard) or 1 (Delimited)
 ; 
 U IO
 S DVBADLMTD=+$P($G(PARM),U)
 D START^FBNHROS  ;DBIA#: 5566
 Q
 ;
CNHRAD ; Report #12 - FBCNH Report of Admissions/Discharges
 ; Parameters
 ; ==========
 ;   BEGDATE   : Start date in FM format
 ;   ENDDATE   : End date in FM format
 ;   DVBADLMTD : 0 (Standard) or 1 (Delimited)
 ;
 U IO
 N BEGDATE,ENDDATE
 S BEGDATE=$P(PARM,U,1),ENDDATE=$P(PARM,U,2)
 S DVBADLMTD=+$P(PARM,U,3)
 D VALDATE(BEGDATE),VALDATE(ENDDATE)
 D:('+DVBERR) START^FBNHAMIE  ;DBIA#: 5566
 Q
 ;
CNHSE90D ; Report #13 - FBCNH Stays in Excess of 90 Days
 ; Parameters
 ; ==========
 ;   FBDT      : Effective date in FM format
 ;   DVBADLMTD : 0 (Standard) or 1 (Delimited)
 ;
 U IO
 N FBDT
 S FBDT=$P(PARM,U,1),DVBADLMTD=+$P(PARM,U,2)
 D VALDATE(FBDT)
 D:('+DVBERR) START^FBNHAMI2  ;DBIA#: 5566
 Q
 ;
HFS() ; -- get hfs file name
 N H
 S H=$H
 Q "DVBA_"_$J_"_"_$P(H,",")_"_"_$P(H,",",2)_".DAT"
 ;
HFSOPEN(HANDLE,DVBHFS,DVBMODE) ; Open File
 S DVBDIRY=$$GET^XPAR("DIV","DVB HFS SCRATCH")
 ;I DVBDIRY="" S ECERR=1 D  Q
 ;. S ^TMP("DVBA",$J,1)="0^A scratch directory for reports doesn't exist"
 D OPEN^%ZISH(HANDLE,,DVBHFS,$G(DVBMODE,"W")) D:POP  Q:POP
 .S DVBERR=1,^TMP("DVBA",$J,1)="0^Unable to open file "
 S IOF="$$IOF^DVBAB82"   ;resets screen position and adds page break flag - added to deal with Linux environments.
 Q
 ;
HFSCLOSE(HANDLE,DVBHFS) ;Close HFS and unload data
 N DVBDEL,X,%ZIS
 D CLOSE^%ZISH(HANDLE)
 S ROOT=$NA(^TMP("DVBA",$J,1)),DVBDEL(DVBHFS)=""
 K:('+DVBERR) @ROOT
 S X=$$FTG^%ZISH(,DVBHFS,$NA(@ROOT@(1)),4)
 S X=$$DEL^%ZISH(,$NA(DVBDEL))
 Q
 ;
IOF() ;used to reset position and insert page break flag when @IOF is executed.
 S $X=0,$Y=0
 Q "##FFFF##"_$C(13,10)
 ;
REQSTAT ; Report #14 - Request Status by Date Range
 ; Parameters
 ; ==========
 ; BEGDAT        : Start date in FM format
 ; ENDDAT        : End date in FM format
 ; REQSTAT       : Request Status filter
 ; ISDELIM       : 0 (Standard format); 1 (Delimited format)
 ; ISNODT        : 0 (Use date range); 1 (Ignore date range)
 U IO
 N BEGDAT,ENDDAT,REQSTAT
 S BEGDAT=$P(PARM,U,1),ENDDAT=$P(PARM,U,2)
 S REQSTAT=$P(PARM,U,3),ISDELIM=$P(PARM,U,4),ISNODT=$P(PARM,U,5)
 D VALDATE(BEGDAT),VALDATE(ENDDAT)
 D:('+DVBERR) REQSTAT^DVBARSBD(BEGDAT,ENDDAT,REQSTAT,ISDELIM,ISNODT)
 Q
