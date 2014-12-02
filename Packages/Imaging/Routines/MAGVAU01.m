MAGVAU01 ;WOIFO/NST/DAC - Update records in storage files ; 14 Sep 2011 1:53 PM
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
 ;*****  Update ARTIFACT DESCRIPTOR file (#2006.915)
 ;       
 ; RPC: MAGVA SET AD RETPOL
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("PK") = IEN 
 ;   MAGPARAM("RETENTION POLICY")
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message
 ; if success MAGRY = Success status
 ; 
UPDAD(MAGRY,MAGPARAM) ; RPC [MAGVA SET AD RETPOL]
 K MAGRY
 ; Update the record
 D UPDRCD^MAGVAF01(.MAGRY,2006.915,.MAGPARAM)
 Q
 ;
 ;*****  Update STORAGE PROVIDER file (#2006.917)
 ;       
 ; RPC: MAGVA UPDATE PROVIDER
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("PK") = IEN 
 ;   MAGPARAM("STORAGE PLACE")
 ;   MAGPARAM("ARCHIVE")
 ;   MAGPARAM("PRIMARY STORAGE")
 ;   MAGPARAM("ACTIVE")
 ;   MAGPARAM("WRITABLE")
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status
 ;
UPDPRV(MAGRY,MAGPARAM) ; RPC [MAGVA UPDATE PROVIDER]
 K MAGRY
 ; Update the record
 D UPDRCD^MAGVAF01(.MAGRY,2006.917,.MAGPARAM)
 Q
 ;*****  Update STORAGE PROVIDER AVAILABILITY file (#2006.924)
 ;       
 ; RPC: MAGVA UPDATE PROVAVAILTY
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("PK") = IEN 
 ;   MAGPARAM("START TIME") = DateTime in IDF format (YYYYMMDD.HHMMSS)
 ;   MAGPARAM("END TIME") = DateTime in IDF format (YYYYMMDD.HHMMSS)
 ;   MAGPARAM("ACTIVE")= 0/1
 ;   
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status
 ;
UPDPA(MAGRY,MAGPARAM) ; RPC [MAGVA UPDATE PROVAVAILTY]
 K MAGRY
 ; Update the record
 S MAGPARAM("START TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("START TIME")))
 S MAGPARAM("END TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("END TIME")))
 D UPDRCD^MAGVAF01(.MAGRY,2006.924,.MAGPARAM)
 Q
 ;
 ;***** Set the Last Access Date/Time to current date/time
 ;      for artifact instance records in ARTIFACT INSTANCE file (#2006.918)
 ;      and ARTIFACT file (#2006.916)
 ;       
 ; RPC: MAGVA UPDATE LAST ACCESS DT
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("PK") = PK (IEN) of the record in ARTIFACT INSTANCE file (#2006.918)
 ;   
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status
 ;
UPDLADT(MAGRY,MAGAPARAM) ; RPC [MAGVA UPDATE LAST ACCESS DT]
 K MAGRY
 N NOW,PARAM
 N FILE,FLDAFK,IENS
 N OUT,ERR,MAGRESA
 N VALAFK
 N IEN ; PK in Artifact Instance file (#2006.918)
 S IEN=$G(MAGAPARAM("PK"))
 ; Check for PK
 I IEN="" S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Input parameter PK is required." Q  ; Error getting the IEN
 ; Get Artifact Value
 S FILE=2006.918
 S IENS=IEN_","
 S FLDAFK=$$GETFLDID^MAGVAF01(FILE,"ARTIFACT")
 S VALAFK=$$GET1^DIQ(FILE,IENS,FLDAFK,"I")  ; get ARTIFACT value
 ;
 ; Update files
 S NOW=$$NOW^XLFDT  ; Get current datetime
 K PARAM
 S PARAM("PK")=IEN
 S PARAM("LAST ACCESS DATE/TIME")=NOW
 ; Update the last access datetime field in Artifact Instance file (#2006.918)
 D UPDRCD^MAGVAF01(.MAGRY,2006.918,.PARAM)
 I '$$ISOK^MAGVAF02(MAGRY) Q  ; Quit if error. MAGRY is already set
 ; Update Artifact file
 K PARAM,MAGRY
 S PARAM("PK")=VALAFK
 S PARAM("LAST ACCESS DATE/TIME")=NOW
 ; Update the last access datetime field in Artifact file (#2006.916)
 D UPDRCD^MAGVAF01(.MAGRY,2006.916,.PARAM)
 Q
 ;
 ;*****  Update ARTIFACT RETENTION POLICY file (#2006.921)
 ;       If "SATISFIED" is sent and the value equals true (1) then
 ;       set SATISFIED DATE/TIME to current date/time
 ;       
 ; RPC: MAGVA UPDATE ARETPOL
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("PK") = IEN of record in  ARTIFACT RETENTION POLICY file (#2006.921)
 ;   MAGPARAM("ACTIVE") = 0/1
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status
 ;
UPDARP(MAGRY,MAGPARAM) ; RPC [MAGVA UPDATE ARETPOL]
 K MAGRY
 S MAGPARAM("SATISFIED DATE/TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("SATISFIED DATE/TIME")))
 ; Update the record
 D UPDRCD^MAGVAF01(.MAGRY,2006.921,.MAGPARAM)
 Q
 ;
 ;*****  Update RETENTION POLICY STORAGE PROVIDER MAP file (#2006.923)
 ;       
 ; RPC: MAGVA UPDATE RETPOL PROV MAP
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("PK") = IEN 
 ;   MAGPARAM("SYNCHRONOUS") = 0/1
 ;   MAGPARAM("OFFSITE") = 0/1
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status 
 ; 
UPDRPPM(MAGRY,MAGPARAM) ; RPC [MAGVA UPDATE RETPOL PROV MAP]
 K MAGRY
 ; Update the record
 D UPDRCD^MAGVAF01(.MAGRY,2006.923,.MAGPARAM)
 Q
 ;
 ;*****  Update ARTIFACT file (#2006.916)
 ;       
 ; RPC: MAGVA UPDATE ARTIFACT
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("PK") = IEN 
 ;   MAGPARAM("CRC")
 ;   MAGPARAM("SIZE IN BYTES")
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status
 ;
UPDAFACT(MAGRY,MAGPARAM) ; RPC [MAGVA UPDATE ARTIFACT]
 K MAGRY
 ; Make sure CREATING APPLICATION and CREATED DATE/TIME are not altered
 K MAGPARAM("CREATING APPLICATION")
 K MAGPARAM("CREATED DATE/TIME")
 ; Update the record
 D UPDRCD^MAGVAF01(.MAGRY,2006.916,.MAGPARAM)
 Q
