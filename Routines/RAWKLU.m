RAWKLU ;HISC/GJC-physician workload statistics by wRVU or CPT ;10/26/05  14:57
 ;;5.0;Radiology/Nuclear Medicine;**64,77,91**;Mar 16, 1998;Build 1
 ;01/23/08 BAY/KAM Remedy Call 227583 Patch *91 Change RVU Reports to
 ;         use Report End Date instead of Current date when setting
 ;         the flag to determine if necessary to use last year's RVU
 ;         data and retrieve RVU data by Verified date instead of
 ;         Exam date
 ;09/25/06 KAM/BAY Remedy Call 154793 PATCH *77 RVU with 0 value
 ;         and changed CPT calls from ^ICPTCOD to ^RACPTMSC
 ;         eliminating the need for IA's 1995 amd 1996 
 ;03/28/07 KAM/BAY Remedy Call 179232 Patch RA*5*77
 ;         Add check to see if current RVU data is available and if
 ;         not use previous year RVU data
 ;
 ;DBIA#:4799 ($$RVU^FBRVU) return wRVU value for CPT, CPT Mod, & exam
 ;      date/time 
 ;DBIA#:10060 EN1^RASELCT enacts 10060 which allows lookups on the NEW
 ;            PERSON (#200) file
 ;DBIA#:10063 ($$S^%ZTLOAD)
 ;DBIA#:10103 ($$FMTE^XLFDT) & ($$NOW^XLFDT)
 ;DBIA#:10104 ($$CJ^XLFSTR)
 ;DBIA#:1519  ($$EN^XUTMDEVQ)
 ;
EN(RARPTYP,RASCLD) ;Identifies the option that the user wishes to execute.
 ;input: RARPTYP="CPT" for the CPT workload report -or- "RVU" for
 ;       wRVU workload report. Exit if the value is neither 'CPT'
 ;       or 'RVU'.
 ;       RASCLD=null for the CPT report, zero for non-scaled wRVU, & one
 ;       for the scaled wRVU report.
 ;
 I RARPTYP'="CPT",(RARPTYP'="RVU") Q
 I RARPTYP="CPT",(RASCLD'="") Q
 K ^TMP($J,"RA STFPHYS"),^TMP("RA STFPHYS-IEN",$J)
 I RARPTYP="RVU" W !!,"Please note that this report is best suited for display on a 132 column device."
 ;
PHYST ;allow the user to select one/many/all physicians
 ;(w/ staff classification) ;DBIA#: 10060
 S RADIC="^VA(200,",RADIC(0)="QEAMZ",RAUTIL="RA STFPHYS"
 S RADIC("A")="Select Physician: ",RADIC("B")="All"
 S RADIC("S")="I $D(^VA(200,""ARC"",""S"",+Y))\10"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAQUIT,RAUTIL,X,Y
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
STRTDT ;Prompt the user for a starting date (VERIFIED DATE)
 S RASTART=$$STRTDT^RAWKLU1(RADATE,2110101)
 I RASTART=-1 D XIT Q
 S RABGDTI=$P(RASTART,U),RABGDTX=$P(RASTART,U,2),RAMBGDT=RABGDTI-.0001
 ;need inv. verified date to search ^RARPT("AA",
 S RAMBGDT=9999999.9999-RAMBGDT
 K RASTART
 ;
ENDDT ;Prompt the user for an ending date (VERIFIED DATE)
 S RAEND=$$ENDDT^RAWKLU1(RABGDTI,RABGDTX)
 I RAEND=-1 D XIT Q
 S RAENDTI=$P(RAEND,U),RAENDTX=$P(RAEND,U,2),RAMENDT=RAENDTI+.9999
 ;need inv. verified date to search ^RARPT("AA",
 S RAMENDT=9999999.9999-RAMENDT
 K RAEND
 ;
 F I="RARPTYP","^TMP(""RA STFPHYS-IEN"",$J,","RADATE","RAB*","RAM*","RAE*","RASCLD" S ZTSAVE(I)=""
 S I="RA print "_$S(RARPTYP="CPT":"CPTs",1:"wRVUs")_" totals for physicians within imaging type"
 D EN^XUTMDEVQ("START^RAWKLU",I,.ZTSAVE,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 K I,ZTSAVE,ZTSK
 Q
 ;
START ;check exams based on criteria input by user; physician & exam D/T
 ;eliminate the exam record is one of the following conditions is true:
 ;1-the status of the exam is 'Cancelled'
 ;2-the physician(s) selected are not the primary staff for the exam
 ;
 ;03/28/07 KAM/BAY Remedy Call 179232 Added next line
 S RACYFLG=0
 ;03/28/07 KAM/BAY RA*5*77/179232 Added Fee Basis Data Check
 D CHKCY^RAWKLU2
 S:$D(ZTQUEUED)#2 ZTREQ="@"
 K ^TMP($J,"RA BY STFPHYS"),^TMP($J,"RA BY I-TYPE")
 S ^TMP($J,"RA BY I-TYPE")="0^0^0^0^0^0^0^0^0",CNT=0
 ;define where the totals for imaging type will reside on the globals
 F RAI="RAD","MRI","CT","US","NM","VAS","ANI","CARD","MAM" S CNT=CNT+1,RAIAB(RAI)=CNT
 K RAI,CNT S RARPTVDT=RAMBGDT,(RACNT,RAXIT)=0
 F  S RARPTVDT=$O(^RARPT("AA",RARPTVDT),-1) Q:'RARPTVDT!(RARPTVDT<RAMENDT)  D  Q:RAXIT
 .S RARPTIEN=0
 .F  S RARPTIEN=$O(^RARPT("AA",RARPTVDT,RARPTIEN)) Q:'RARPTIEN  D  Q:RAXIT
 ..S RARPT=$G(^RARPT(RARPTIEN,0)),RADFN=+$P(RARPT,U,2),RADTE=+$P(RARPT,U,3)
 ..S RADTI=9999999.9999-RADTE,RA7002=$G(^RADPT(RADFN,"DT",RADTI,0))
 ..Q:$P(RA7002,U,2)=""  ;no imaging type defined
 ..S RAITYP=$P($G(^RA(79.2,$P(RA7002,U,2),0)),U,3) ;abbreviation
 ..Q:'($D(RAIAB(RAITYP))#2)
 ..S RACNI=0
 ..F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D  Q:RAXIT
 ...S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:RA7003=""  ;missing exam node
 ...Q:$P(RA7003,U,17)'=RARPTIEN  ;exam references a different report!
 ...S RACNT=RACNT+1
 ...;
 ...;did the user stop the task? Check every five hundred records...
 ...S:RACNT#500=0 (RAXIT,ZTSTOP)=$$S^%ZTLOAD() Q:RAXIT
 ...;
 ...;1-begin exam status check
 ...Q:$P($G(^RA(72,+$P(RA7003,U,3),0)),U,3)=0  ;cancelled...
 ...;end exam status check
 ...;
 ...;2-begin physician check
 ...Q:'$P(RA7003,U,15)  ;no physician, quit check
 ...Q:'$D(^TMP("RA STFPHYS-IEN",$J,$P(RA7003,U,15)))#2
 ...;end physician check
 ...;
 ...S RASTAFF=$$EXTERNAL^DILFD(70.03,15,,$P(RA7003,U,15))
 ...I RARPTYP="CPT" D  Q
 ....;Total the # of CPTs performed by a physician within an i-type;
 ....;the # on CPTs performed within i-type; the # of procedures
 ....;performed by physician. all exams are either detailed or series
 ....;(CPT codes defined) types of procedures.
 ....D ARY(1)
 ....Q
 ...D RVU
 ...Q
 ..Q
 .Q
 D EN^RAWKLU1 ;output the report
 D XIT
 Q
 ;
ARY(Y) ;increment the array by one in the case of CPT or by the wRVU
 ;value
 ;input: Y=either one when adding the number of CPTs performed by a
 ;         physician, within an i-type or by physician within i-type
 ;    -or- the WRVU value when totaling for the aforementioned criteria
 ;
 S $P(^TMP($J,"RA BY STFPHYS",RASTAFF),U,RAIAB(RAITYP))=+$P($G(^TMP($J,"RA BY STFPHYS",RASTAFF)),U,RAIAB(RAITYP))+Y
 S $P(^TMP($J,"RA BY I-TYPE"),U,RAIAB(RAITYP))=$P(^TMP($J,"RA BY I-TYPE"),U,RAIAB(RAITYP))+Y
 Q
 ;
RVU ;Total the # of wRVUs performed by a physician within an i-type; all
 ;exams are either detailed or series types of procedures. By definition
 ;these procedure types MUST have CPT code defined.
 ;Pass the exam date, CPT, & CPT modifiers into the FEE BASIS function
 ;to derive the wRVU
 ;
 ;get exam date/time
 N RAXAMDT S RAXAMDT=$P(RA7002,U)
 ;get the CPT code value
 S RACPT=$P($G(^RAMIS(71,+$P(RA7003,U,2),0)),U,9) ;pointer to file #81
 ; 09/27/2006 KAM/BAY Patch RA*5*77 Changed next line to use ^RACPTMSC
 S RACPT=$P($$NAMCODE^RACPTMSC(RACPT,RAXAMDT),U,1) ;CPT code is 1st pc
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
 ;where status'=1 means "in error". All exams prior to 1/1/1999 will
 ;use 1999 wRVU values for their calculations.
 ;03/28/2007 KAM/BAY Rem Call 179232 Added RACYFLG to $S in next line
 ;01/23/2008 KAM/BAY RA*5*91 Remedy Call 227583 Changed the next line
 ;                   to use the Verified date of the exam date
 S RAWRVU=$$RVU^FBRVU(RACPT,RACPTMOD,$S((9999999.9999-RARPTVDT)<2990101:2990101,RACYFLG:(9999999.9999-RARPTVDT)-10000,1:(9999999.9999-RARPTVDT)))
 ; 09/25/2006 KAM/BAY Remedy Call 154793 Correct 0 RVUs
 I $P(RAWRVU,U,2)=0,RACPTMOD="" D
 . ;01/23/2008 KAM/BAY RA*5*91 Remedy Call 227583 Changed the next lin
 . ;                   to use the Verified date of the exam date
 . S RAWRVU=$$RVU^FBRVU(RACPT,26,$S((9999999.9999-RARPTVDT)<2990101:2990101,RACYFLG:(9999999.9999-RARPTVDT)-10000,1:(9999999.9999-RARPTVDT)))
 ;
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
 D ARY(RAWRVU)
 K RA813,RABILAT,RACPT,RACPTMOD,RAI,RAWRVU
 Q
 ;
XIT ;kill variables and exit
 W:$G(ZTSTOP)=1 !,$$CJ^XLFSTR("USER STOPPED PROCESS THROUGH TASKMAN",IOM)
 K DIRUT,DTOUT,DUOUT,RA7002,RA7003,RABGDTI,RABGDTX,RACNI,RADATE
 K RADFN,RADTE,RADTI,RAENDTI,RAENDTX,RAIAB,RAITYP,RAMBGDT,RAMENDT
 K RARPT,RARPTIEN,RARPTVDT,RASTAFF,RAXIT,X,Y,^TMP("RA STFPHYS-IEN",$J)
 K ^TMP($J,"RA BY STFPHYS"),^TMP($J,"RA BY I-TYPE"),RACYFLG
 Q
