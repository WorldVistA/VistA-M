MAGVIM03 ;WOIFO/MAT,MLH,BT - RPCs for DICOM Importer II ; 3-Feb-2012 10:50 AM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
 Q
 ;
 ;+++ Importer II Log Reports: Populate MAGV IMPORT STUDY LOG File (#2006.9421)
 ;
 ;  RPC: MAGV IMPORT STUDY LOG STORE
 ;
 ; Inputs:
 ; =======
 ;
 ;  MAGVRET .... Variable for returned message.
 ;  MAGVDUZ .... User DUZ.
 ;  MAGVDUZ2 ... User Login Division.
 ;  MAGVPDFN ... Associated Patient DFN.
 ;  MAGVSACN ... Associated Study Accession Number.
 ;  MAGVSUID ... Study Instance UID.
 ;  MAGVSLOC ... Study performed location.
 ;  MAGVSTYP ... Associated Study Type.
 ;  MAGVSCNT ... Imported Series Count.
 ;  MODLST ..... Array of NAME|VALUE PAIRS for MODALITY|COUNT.
 ;  MEDGIEN .... IEN in the MAGV IMPORT MEDIA LOG file (#2006.9422)
 ;  OBJFAIL .... Count of requested objects which failed to be imported.
 ; 
 ; Outputs:
 ; ========
 ; 
 ;     0`"IMPORT STUDY LOG UPDATED."
 ;    -1`"Unable to lock MAGV IMPORT STUDY LOG File (#2006.9421)."
 ;    -1`##_"Validator error message lines returned."
 ; 
 ; Notes
 ; =====
 ;
 ;
IMPLOGIN(MAGVRET,MAGVDUZ,MAGVDUZ2,MAGVPDFN,MAGVSACN,MAGVSUID,MAGVSLOC,MAGVSTYP,MAGVSCNT,MODLIST,MEDGIEN,OBJFAIL) ;
 ;
 ;--- Initialize. Set output separators per p34 convention.
 K FDA,FDAIEN,MAGVRET
 N SEPOUTP,SEPSTAT D ZRUSEPIN
 N MAGVERR,MAGVMSG S MAGVERR=0
 N FILE S FILE=2006.9421
 N SUBFILE S SUBFILE=2006.94211
 N SFIEN
 ;
 ;--- Set FDA entries for literal parameters.
 S FDA(0,FILE,"+1,",3)=MAGVPDFN ;PAT_DFN
 S:MAGVSACN'="" FDA(0,FILE,"+1,",4)=MAGVSACN ;Associated_Study_Accession_Number
 S:MAGVSUID'="" FDA(0,FILE,"+1,",5)=MAGVSUID ;Study_Instance_UID
 S:MAGVSLOC'="" FDA(0,FILE,"+1,",6)=MAGVSLOC ;Study_Performed_Location
 S FDA(0,FILE,"+1,",7)=MAGVSTYP ;Associated_Study_Type
 S FDA(0,FILE,"+1,",8)=MAGVSCNT ;Series_Count
 S FDA(0,FILE,"+1,",11)=OBJFAIL ;Object_Failed_Count
 S FDA(0,FILE,"+1,",12)=MEDGIEN ;IEN in the MAGV IMPORT MEDIA LOG file (#2006.9422)
 ;
 ;--- Lock MAGV IMPORT STUDY LOG file (#2006.9421)
 L +^MAGV(FILE):5 I $T D
 . ;
 . ;--- Set internal FDA entries for .01 field. IA #10103
 . S FDA(0,FILE,"+1,",.01)=$$NOW^XLFDT
 . S FDA(0,FILE,"+1,",1)=MAGVDUZ  ;USER_DUZ
 . S FDA(0,FILE,"+1,",2)=MAGVDUZ2 ;USER_DUZ(2)
 . ;
 . ;--- Post top-level transaction data. IA# 2053.
 . D UPDATE^DIE("","FDA(0)","SFIEN")
 . ;
 . ;--- Set FDA entries for array parameter MODLST.
 . N CT,CTMOD S CT="",CTMOD=0 F  S CT=$O(MODLIST(CT)) Q:CT=""  D
 . . N MODLTY S MODLTY=$P(MODLIST(CT),"|",1)
 . . N VALUE S VALUE=$P(MODLIST(CT),"|",2)
 . . S FDA(1,SUBFILE,"+"_CT_","_SFIEN(1)_",",.01)=MODLTY
 . . S FDA(1,SUBFILE,"+"_CT_","_SFIEN(1)_",",.02)=VALUE
 . . S CTMOD=CTMOD+VALUE
 . . Q
 . ;
 . D:(CTMOD*SFIEN(1))>0
 . . ;--- Set FDA entry for total modality object count.
 . . S FDA(1,FILE,SFIEN(1)_",",9)=$G(CTMOD)
 . . ;--- Post sub-file transaction data. IA# 2053.
 . . D UPDATE^DIE("","FDA(1)")
 . L -^MAGV(FILE)
 . Q
 ;
 E  D
 . ;
 . S MAGVERR=1,MAGVMSG="Could not lock MAGV IMPORT STUDY LOG File."
 . Q
 ;
 ;--- Return.
 I MAGVERR S MAGVRET(0)="-1"_SEPSTAT_MAGVMSG Q
 S MAGVRET(0)="0"_SEPSTAT_"IMPORT STUDY LOG UPDATED."
 Q
 ;+++ Importer II Log Reports from MAGV IMPORT STUDY LOG file (#2006.9421)
 ;
 ;  RPC: MAGV IMPORT STUDY LOG REPORT
 ;
 ; Inputs:
 ; =======
 ;
 ;  MAGVARY .... Variable for returned message.
 ;  REPORT ..... Report identifier as:
 ;  
 ;    0 ... Initialization Request
 ;    1 ... Report Data for Each Date in Range
 ;    2 ... Report Data for Each Study Location
 ;    3 ... Report Data for Modality Counts
 ;  
 ;  STARTDT .... Inclusive lower  bound of date range as YYYYMMDD.
 ;  STOPDT ..... Inclusive upper bound of date range.
 ; 
 ; Outputs:
 ; ========
 ; 
 ;     0`## [report lines returned]
 ;    -1`Error message.
 ; 
 ; Notes
 ; =====
 ;
 ;  Calls MAGVIM04 for processing.
 ;
IMPLOGEX(MAGVARY,REPORT,STARTDT,STOPDT) ;
 ;
 N SEPOUTP,SEPSTAT D ZRUSEPIN
 N MAGVERR S MAGVERR=0
 N FILE S FILE=2006.9421
 ;
 ;--- Convert incoming HL7 dates to FileMan. IA #
 S STARTDT=$$HL7TFM^XLFDT(STARTDT)
 S STOPDT=$$HL7TFM^XLFDT(STOPDT)
 ;
 S MAGVARY=$NA(^TMP("MAGVIM",$J))
 K @MAGVARY
 D  I MAGVERR S @MAGVARY@(0)="-1"_SEPSTAT_MAGVERR Q
 . ;
 . I '$D(REPORT) S MAGVERR="REPORT TYPE NOT SPECIFIED." Q
 . ;
 . ;--- Set report types validator string.
 . I "0,1,2,3,"'[REPORT_"," S MAGVERR="REPORT TYPE"_""_REPORT_""_"UNDEFINED." Q
 ;
 ;--- Report window initialization request.
 I REPORT=0 D  Q
 . ;
 . ;--- Detect file contains no data & return -1
 . I '$D(^MAGV(FILE,"B")) S @MAGVARY@(0)="-1" Q
 . ;
 . ;--- Return "0'STARTDT" for earliest date in file.
 . N FIRSTDT S FIRSTDT=+$P($O(^MAGV(FILE,"B","")),".")
 . S @MAGVARY@(0)="0"_"`"_$$FMTHL7^XLFDT(FIRSTDT)
 ;
 ;--- Call the processor.
 D MAGVQRY^MAGVIM04(MAGVARY,FILE,REPORT,STARTDT,STOPDT)
 ;
 ;--- Return.
 N LNTOT S LNTOT=$O(@MAGVARY@("Z"),-1)
 S @MAGVARY@(0)=0_SEPSTAT_LNTOT
 Q
 ;
 ; +++++ Importer II Log Reports: Populate MAGV IMPORT MEDIA LOG (#2006.9422)
 ;
 ;  RPC: MAGV IMPORT MEDIA LOG STORE
 ;
 ; Inputs:
 ; =======
 ;
 ;  MAGVRET .... Variable for returned message.
 ;  MAGVDUZ .... User DUZ.
 ;  MAGVWKST ... Workstation running the Importer II application.
 ;  MEDTYPE .... Import event media type (DIRect, STaGed,NETwork, DiCoM correct).
 ;  MEDVALID ... Media Validation Status (0=valid; 1=invalid).
 ;  MEDVMSG .... Media Validation Message extending MEDVALID.
 ; 
 ; Outputs:
 ; ========
 ; 
 ;     0`"IMPORT MEDIA LOG UPDATED."
 ;    -1`"Unable to lock MAGV IMPORT MEDIA LOG File."
 ;    -1`##_"Validator error message lines returned."
 ;
IMPMEDIA(MAGVRET,MAGVDUZ,MAGVWKST,MEDTYPE,MEDVALID,MEDVMSG) ;
 ;
 K MAGVRET
 N SEPOUTP,SEPSTAT D ZRUSEPIN
 N MAGVERR,MAGVMSG S MAGVERR=0
 ;
 N FILE S FILE=2006.9422
 D
 . K FDA
 . ;--- Set FDA entries for literal parameters.
 . S FDA(1,FILE,"+1,",.01)=$$NOW^XLFDT ;Media Import Timestamp
 . S FDA(1,FILE,"+1,",2)=MAGVDUZ    ;Import II User DUZ
 . S FDA(1,FILE,"+1,",3)=MAGVWKST   ;Import II Workstation ID
 . S FDA(1,FILE,"+1,",4)=MEDTYPE    ;Media Type
 . S FDA(1,FILE,"+1,",100)=MEDVALID ;Media Validation Status
 . S FDA(1,FILE,"+1,",101)=$G(MEDVMSG)  ;Media Validation Status Message
 . Q
 ;
 ;--- Lock MAGV IMPORT MEDIA LOG file (#2006.9422)
 L +^MAGV(FILE):5 I $T D
 . ;
 . K MAGVIEN
 . ;--- Post the transaction. IA# 2053.
 . D UPDATE^DIE("","FDA(1)","MAGVIEN")
 . L -^MAGV(FILE)
 . Q
 ;
 E  D
 . ;
 . S MAGVERR=1,MAGVMSG="Could not lock MAGV IMPORT MEDIA LOG File."
 . Q
 ;
 ;--- Return.
 I MAGVERR S MAGVRET(0)="-1"_SEPSTAT_MAGVMSG Q
 S MAGVRET(0)="0"_SEPSTAT_MAGVIEN(1)
 Q
 ;
 ;+++ Routine Utility: Initialize Separators
ZRUSEPIN ;
 S SEPOUTP=$$OUTSEP^MAGVIM01
 S SEPSTAT=$$STATSEP^MAGVIM01
 Q
 ;
 ; MAGVIM03
