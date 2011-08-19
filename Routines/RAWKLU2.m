RAWKLU2 ;HISC/GJC-physician wRVU (scaled too) by procedure ;10/26/05  14:57
 ;;5.0;Radiology/Nuclear Medicine;**64,77,91**;Mar 16, 1998;Build 1
 ;01/23/08 BAY/KAM Remedy Call 227583 Patch *91 Change RVU Reports to
 ;         use Report End Date instead of Current date when setting
 ;         the flag to determine if necessary to use last year's RVU
 ;         data and retrieve RVU data by Verified date instead of 
 ;         Exam date
 ;
 ;03/28/07 KAM/BAY Remedy Call 179232 Patch RA*5*77
 ;         Add check to see if current RVU data is available and if
 ;         not use previous year RVU data
 ;
 ;09/25/06 KAM/BAY Remedy Call 154793 PATCH *77 RVU with 0 value
 ;         and changed CPT calls from ^ICPTCOD to ^RACPTMSC
 ;         eliminating the need for IA's 1995 and 1996
 ;
 ;DBIA#:4799 ($$RVU^FBRVU) return wRVU value for CPT, CPT Mod, & exam
 ;      date/time 
 ;DBIA#:10060 EN1^RASELCT enacts 10060 which allows lookups on the NEW
 ;            PERSON (#200) file
 ;DBIA#:10063 ($$S^%ZTLOAD)
 ;DBIA#:10103 ($$FMTE^XLFDT) & ($$NOW^XLFDT)
 ;DBIA#:10104 ($$CJ^XLFSTR)
 ;DBIA#:1519  ($$EN^XUTMDEVQ)
 ;DBIA#:4432  (LASTCY^FBAAFSR) return last calendar year file
 ;            162.99 was updated
 ;
EN(RASCLD) ;Identifies the option that the user wishes to execute.
 ;input: RASCLD=zero for non-scaled wRVU, & one for the scaled wRVU
 ;              report.
 ;
 K ^TMP($J,"RA STFPHYS"),^TMP("RA STFPHYS-IEN",$J)
 ;
PHYST ;allow the user to select one/many/all physicians
 ;(w/ staff classification) ;DBIA#: 10060
 S RADIC="^VA(200,",RADIC(0)="QEAMZ",RAUTIL="RA STFPHYS"
 S RADIC("A")="Select Physician: ",RADIC("B")="All"
 S RADIC("S")="I $D(^VA(200,""ARC"",""S"",+Y))\10"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 ;did the user select physicians to compile data on? if not, quit
 I $O(^TMP($J,"RA STFPHYS",""))="" D  Q
 .W !!?3,$C(7),"Staff Physician data was not selected."
 .Q
 ;
 ;build a new staff physician array (the other array is subscripted by
 ;physician name then IEN) subscripting by staff physician IEN this
 ;allows us to check the IEN of the staff physician selected by the
 ;user against the IEN of the staff physician on the exam record
 S X="" F  S X=$O(^TMP($J,"RA STFPHYS",X)) Q:X=""  D
 .S Y=0
 .F  S Y=$O(^TMP($J,"RA STFPHYS",X,Y)) Q:'Y  S ^TMP("RA STFPHYS-IEN",$J,Y)=""
 .Q
 ;
 K ^TMP($J,"RA STFPHYS") S RADATE=$$FMTE^XLFDT($$NOW^XLFDT\1,1)
 ;
STRTDT ;Prompt the user for the starting verified date
 S RASTART=$$STRTDT^RAWKLU1(RADATE,2110101)
 I RASTART=-1 D XIT Q
 S RABGDTI=$P(RASTART,U),RABGDTX=$P(RASTART,U,2),RAMBGDT=RABGDTI-.0001
 ;need inv. verified date to search ^RARPT("AA",
 S RAMBGDT=9999999.9999-RABGDTI
 K RASTART
 ;
ENDDT ;Prompt the user for the ending verified date
 S RAEND=$$ENDDT^RAWKLU1(RABGDTI,RABGDTX)
 I RAEND=-1 D XIT Q
 S RAENDTI=$P(RAEND,U),RAENDTX=$P(RAEND,U,2),RAMENDT=RAENDTI+.9999
 ;need inv. verified date to search ^RARPT("AA",
 S RAMENDT=9999999.9999-RAMENDT
 K RAEND
 ;
 F I="^TMP(""RA STFPHYS-IEN"",$J,","RADATE","RAB*","RAM*","RAE*","RASCLD" S ZTSAVE(I)=""
 S I="RA print procedures, wRVUs, and their totals for a physician"
 D EN^XUTMDEVQ("START^RAWKLU2",I,.ZTSAVE,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 K I,ZTSAVE,ZTSK
 Q
 ;
START ;check exams based on criteria input by user; physician & exam D/T
 ;eliminate the exam record is one of the following conditions is true:
 ;1-the status of the exam is 'Cancelled'
 ;2-the physician(s) selected are not the primary staff for the exam
 ;
 S:$D(ZTQUEUED)#2 ZTREQ="@"
 K ^TMP($J,"RA BY STFPHYS")
 ;03/28/07 KAM/BAY Remedy Call 179232 Added RACYFLG to next line
 S RARPTVDT=RAMBGDT,(RACNT,RAXIT,RACYFLG)=0
 ;03/28/07 KAM/BAY RA*5*77/179232 Added Fee Basis Data Check
 D CHKCY
 F  S RARPTVDT=$O(^RARPT("AA",RARPTVDT),-1) Q:'RARPTVDT!(RARPTVDT<RAMENDT)  D  Q:RAXIT
 .S RARPTIEN=0
 .F  S RARPTIEN=$O(^RARPT("AA",RARPTVDT,RARPTIEN)) Q:'RARPTIEN  D  Q:RAXIT
 ..S RARPT=$G(^RARPT(RARPTIEN,0)),RADFN=+$P(RARPT,U,2),RADTE=+$P(RARPT,U,3)
 ..S RADTI=9999999.9999-RADTE,RA7002=$G(^RADPT(RADFN,"DT",RADTI,0))
 ..S RAXAMDT=+$P(RA7002,U) Q:'RAXAMDT
 ..;must check every exam registered for this exam date/time; we might have a printset
 ..S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D XAM
 ..Q
 .Q
 D EN^RAWKLU3 ;output the report
 D XIT
 Q
 ;
XAM ; get exam information; procedure name, exam status order #, int. staff phys...
 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:'RA7003
 Q:$P(RA7003,U,17)'=RARPTIEN  ;exam references a different report!
 S RAPRCIEN=+$P(RA7003,U,2) Q:'RAPRCIEN
 S RAPRCIEN(0)=$P($G(^RAMIS(71,RAPRCIEN,0)),U) Q:RAPRCIEN(0)=""
 S RACNT=RACNT+1
 ;
 ;did the user stop the task? Check every five hundred records...
 S:RACNT#500=0 (RAXIT,ZTSTOP)=$$S^%ZTLOAD() Q:RAXIT
 ;
 ;1-begin exam status check
 Q:$P($G(^RA(72,+$P(RA7003,U,3),0)),U,3)=0  ;cancelled...
 ;end exam status check
 ;
 ;2-begin physician check
 Q:'$P(RA7003,U,15)  ;no physician, quit check
 Q:'$D(^TMP("RA STFPHYS-IEN",$J,$P(RA7003,U,15)))#2
 ;end physician check
 ;
 S RACPT=$P($G(^RAMIS(71,+$P(RA7003,U,2),0)),U,9) Q:'RACPT  ;ptr to file #81
 ;
 ; 09/27/2006 KAM/BAY Patch RA*5*77 Changed next line to use ^RACPTMSC
 S RACPT=$P($$NAMCODE^RACPTMSC(RACPT,RAXAMDT),U,1) ;CPT code is 1st pc
 ;
 S RASTF=$$EXTERNAL^DILFD(70.03,15,,$P(RA7003,U,15))
 D SETARRY K RA7003,RACPT,RAPRCIEN,RASTF
 Q
 ;
SETARRY ;find the wRVU value (either un-scaled or scaled) for a particular CPT
 ;or CPT code/CPT modifier combination. The case identifiers, CPT code
 ;(RACPT), & exam date (RAXAMDT) are known.
 ;
 ;get CPT code modifier string
 S RACPTMOD="",RABILAT=0
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",0))>0 S RAI=0 D
 .F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RAI)) Q:'RAI  D
 ..S RACPTMOD(0)=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RAI,0))
 ..;09/27/2006 KAM/BAY RA*5*77 Changed next line to use ^RACPTMSC
 ..S RA813(0)=$$BASICMOD^RACPTMSC(RACPTMOD(0),RAXAMDT)
 ..I 'RABILAT,$P(RA813(0),U,2)=50 S RABILAT=1 ;bilateral multiplier=2
 ..S RACPTMOD=RACPTMOD_$P(RA813(0),U,2)_","
 ..Q
 .Q
 ;get wRVU value from FEE BASIS; returns a string: status^value^message
 ;where status'=1 means "in error". All exams prior to 1/1/1999 will use
 ;1999 wRVU values for their calculations.
 ;03/28/2007 KAM/BAY Rem Call 179232 Added RACYFLG to $S in next line
 ;01/23/2008 KAM/BAY RA*5*91 Remedy Call 227583 Changed the next line
 ;           to use the Verified date instead of the exam date
 S RAWRVU=$$RVU^FBRVU(RACPT,RACPTMOD,$S((9999999.9999-RARPTVDT)<2990101:2990101,RACYFLG:(9999999.9999-RARPTVDT)-10000,1:(9999999.9999-RARPTVDT)))
 ;09/27/2006 KAM/BAY RA*5*77 Remedy Call 154793
 I $P(RAWRVU,U,2)=0,RACPTMOD="" D
 . ;01/23/2008 KAM/BAY RA*5*91 Remedy Call 227583 Changed next line
 . ;           to use the Verified date instead of the exam date
 . S RAWRVU=$$RVU^FBRVU(RACPT,26,$S((9999999.9999-RARPTVDT)<2990101:2990101,RACYFLG:(9999999.9999-RARPTVDT)-10000,1:(9999999.9999-RARPTVDT)))
 I $P(RAWRVU,U)=1 D
 .;apply bilateral multiplier if appropriate
 .S:RABILAT RAWRVU=$P(RAWRVU,U,2)*2
 .;or not...
 .S:'RABILAT RAWRVU=$P(RAWRVU,U,2)
 .I RASCLD S RAWRVU=RAWRVU*$$SFCTR^RAWRVUP($P(RA7002,U,2),RAXAMDT)
 .Q
 ;
 E  S RAWRVU=0 ;status some other value than 1; "in error"
 S:RAWRVU>0 RAWRVU=$J(RAWRVU,1,2) ;do not round the value...
 ;
 ;^TMP($J,"RA BY STFPHYS",RASTF)=total # procedures^wRVU total(all proc)
 ;^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRCIEN(0))=^total # RACPT^
 ;                                                        total # RAWRVU
 ;
 S:'$D(^TMP($J,"RA BY STFPHYS",RASTF))#2 ^(RASTF)="0^0"
 S $P(^TMP($J,"RA BY STFPHYS",RASTF),U)=$P(^TMP($J,"RA BY STFPHYS",RASTF),U)+1
 S $P(^TMP($J,"RA BY STFPHYS",RASTF),U,2)=$P(^TMP($J,"RA BY STFPHYS",RASTF),U,2)+RAWRVU
 S:'$D(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRCIEN(0)))#2 ^(RAPRCIEN(0))="^0^0"
 S $P(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRCIEN(0)),U,2)=+$P($G(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRCIEN(0))),U,2)+1
 S $P(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRCIEN(0)),U,3)=RAWRVU*(+$P(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRCIEN(0)),U,2))
 ;
 K RA813,RABILAT,RACPTMOD,RAI,RAWRVU
 Q
 ;
XIT ;kill variables and exit
 W:$G(ZTSTOP)=1 !,$$CJ^XLFSTR("USER STOPPED PROCESS THROUGH TASKMAN",IOM)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,RA7002,RABGDTI,RABGDTX,RACNI,RACNT,RADATE
 K RADFN,RADTE,RADTI,RAENDTI,RAENDTX,RAMBGDT,RAMENDT,RAQUIT,RARPT,RARPTIEN
 K RARPTVDT,RAXAMDT,RAXIT,X,Y,RACYFLG
 K ^TMP("RA STFPHYS-IEN",$J),^TMP($J,"RA BY STFPHYS")
 Q
 ;
CHKCY ;03/28/2007 KAM/BAY RA*5*77 Remedy Call 179232 Check for latest RVU
 ;                   data from Fee Basis
 S RACYFLG=0
 ;01/23/2008 BAY/KAM RA*5*91 Rem 227593 Changed next line to use the
 ;                   Report end date when setting variable RACYFLG
 I $$LASTCY^FBAAFSR()<+$P(RAENDTX,",",2) S RACYFLG=1
 Q
