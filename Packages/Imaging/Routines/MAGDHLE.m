MAGDHLE ;WOIFO/SRR/PMK - PACS INTERFACE PID TRIGGERS ;26 Oct 2017 1:30 PM
 ;;3.0;IMAGING;**54,49,183**;Mar 19, 2002;Build 11;Apr 07, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; Supported IA #2602 Reading AUDIT file (#1.1) ^DIA(2,...) 
 Q
 ;
SENDA08(DFN) ; External API entry point from Radiology Package - P183 PMK 3/16/17
 N MAGSENDA08 S MAGSENDA08=1 ; flag to indicate API call
 ; drop through to ADTA08
 ;
ADTA08 ; Patient Update event from VAFC ADT-A08 SERVER event driver - P183 PMK 3/16/17
 ; Upon entry, DFN will be set to the patient
 ; The DG* variables are not defined by the VAFC package
 N DGPMDA,DGNOW,DGPMA,DGPMT,MAGKTYP,MAGDPTCL
 N HLECH,HLFS,HLINSTN,HLPARAM,HLPID,HLRFREQ,HLSFREQ,HLSAN,HLTYPE,HLQ,HLXM
 N HL771RF,HL771SF,HLCS,HLDOM,HLN,HLPARM,HLREC,SEGIX,SUB4,VA,VADM,VACNTRY
 N SSNCHANGES ;--- array of old & new SSNs, indexed chronologically
 ;
 S (DGPMDA,DGNOW,DGPMA,MAGDPTCL)="" ; unused
 I $$SSNCHECK(.SSNCHANGES) D  ; generate ADT A47
 . S DGPMT=47 ; set DGPMT variable for use in MAGDHLI
 . S MAGKTYP=47 ; set MAGKTYP variable for EVN+1 below
 . Q
 E  D  ; generate ADT A08
 . S DGPMT=8 ; set DGPMT variable for use in MAGDHLI
 . S MAGKTYP=8 ; set MAGKTYP variable for EVN+1 below
 . Q
 G TSK ; generate the HL7 ADT A08 or ADT A47 message
 ;
SSNCHECK(SSNCHANGES) ; Check for SSN change, return values
 ; Return 1 if there was an SSN change and 0 otherwise
 ; If there was an SSN change, do the following:
 ;   save the old value in SSNCHANGES(DATEIME,"OLD")
 ;   save the new value in SSNCHANGES(DATEIME,"NEW")
 ;   set NEWSSN(DATEIME) to the new value
 N DATETIME ; date and time of the SSN change
 N DIAIEN ; ien of the record in the AUDIT file (#1.1)
 N FIELDNUMBER ; SSN is field .09 in the PATIENT file (#2)
 N OLDSSN ; previous value of SSN, can't be null
 N X
 S DIAIEN=""
 F  S DIAIEN=$O(^DIA(2,"B",DFN,DIAIEN)) Q:DIAIEN=""  D
 . S X=$G(^DIA(2,DIAIEN,0))
 . S DATETIME=$P(X,"^",2),FIELDNUMBER=$P(X,"^",3)
 . I FIELDNUMBER'=.09 Q  ; not an SSN change record
 . S OLDSSN=$G(^DIA(2,DIAIEN,2))
 . I OLDSSN="" Q  ; no previous SSN value, don't send A47
 . S SSNCHANGES(DATETIME,"OLD")=OLDSSN
 . S SSNCHANGES(DATETIME,"NEW")=$G(^DIA(2,DIAIEN,3))
 . Q
 I '$G(MAGSENDA08) D  ; invocation by HL7 event driver
  . ; invocation by VAFC ADT-A08 SERVER event driver
  . ; keep the most recent change if it was done today
  . N A
  . S DATETIME=$O(SSNCHANGES(""),-1)
  . I DATETIME M A(DATETIME)=SSNCHANGES(DATETIME) ; save last change
  . K SSNCHANGES ; kill the SSN change history
  . I DT>DATETIME K A ; if last change was before today, kill it too
  . M SSNCHANGES=A ; save last change, if any
  . Q
 Q $D(SSNCHANGES)
 ;
 ;
ADT ;ADT EVENTS ;From EVENT driver
 ;Protocol = MAGD DHCP-PACS ADT EVENTS
 ;IN ;DFN
 ;DGPMDA = IFN Primary Movement
 ;DGPMA = 0th node Primary Movement AFTER movement
 ;DGPMP = 0th node PRIOR to movement
 ;^UTILITY("DGPM",$J,TRANSACTION (1,2,3,6),MOVEMENT (IFN),"P"/"A")
 ;
 N I K MAGKTYP F I=1,2,3 I $D(^UTILITY("DGPM",$J,I,DGPMDA)) S MAGKTYP=I
 Q:'$D(MAGKTYP)  I MAGKTYP=2,$P(^UTILITY("DGPM",$J,2,DGPMDA,"A"),U,6)=$P(^("P"),U,6) G EX
 ;
 ;
TSK ;CREATE TASK to make HL7 messages
 S ZTSAVE("MAGKTYP")="",ZTSAVE("MAGDPTCL")="",ZTSAVE("SSNCHANGES(")="" ; P183 PMK 3/9/17
 S ZTSAVE("DGPMDA")="",ZTSAVE("DGNOW")="",ZTSAVE("DGPMA")=""
 S ZTSAVE("DFN")="",ZTSAVE("DGPMT")="",ZTDTH=$H,ZTIO=""
 S ZTRTN="HL7^MAGDHLE",ZTDESC=$S(MAGKTYP=8:"PID",1:"ADT")_" HL7 PACS MESSAGE"
 I $$PROD^XUPROD D  ; production - P183 PMK 3/30/2017
 . D ^%ZTLOAD
 . Q
 E  D  ; development
 . N HLTC,HLDT,HLDT1,HLMID,HLRESLT1,HLENROU,HLEXROU ; GENERATE^HLMA variables
 . W !?5,"*** HL7 TASK FOR PACS ***"
 . D HL7 ; enable debugging in development
 . Q 
 G EX
 ;
HL7 ;Create HL7 message
 I $P($G(^MAG(2006.1,1,"IHE")),"^",1)="Y" D ADT^MAGDHLI
 Q
 ;
EX ;EXIT
 K ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE
 K MAGKPID,MAGKTYP
 Q
 ;
 ; Vestigal code, kept around since there still cross references somewhere
SET ;Set Logic from MUMPS x-ref on fields .01,.03,.09 of ^DD(2 (^DPT)
 Q
 ;
KIL ;Kill logic "AKn" cross references
 Q
