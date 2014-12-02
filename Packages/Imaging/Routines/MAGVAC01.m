MAGVAC01 ;WOIFO/NST - Add records to storage files ; 22 Apr 2010 3:59 PM
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
 ;*****  Add a new record to RETENTION POLICY file (#2006.914) 
 ;       
 ; RPC:MAGVA CREATE RETPOL
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; MAGPARAM("ARCHIVE DURATION TRIGGER")
 ; MAGPARAM("ARCHIVE DURATION YEARS")
 ; MAGPARAM("BUSINESS KEY")
 ; MAGPARAM("DISPLAY NAME")
 ; MAGPARAM("MINIMUM ARCHIVE COPIES")
 ; MAGPARAM("MINIMUM OFFSITE COPIES")
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ; 
ADDRP(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE RETPOL]
 N MAGWP
 K MAGRY
 ; Check for uniqueness of business key among active Retention Policies  
 I $G(MAGPARAM("BUSINESS KEY"))'="" D  Q:$G(MAGRY)'=""
 . I $O(^MAGV(2006.914,"BKEYACT",MAGPARAM("BUSINESS KEY"),""))'="" D
 . . S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Active business key """_MAGPARAM("BUSINESS KEY")_""" already exists."
 . Q
 ;
 S MAGPARAM("ACTIVE")=1
 D ADDRCD^MAGVAF01(.MAGRY,2006.914,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to ARTIFACT file (#2006.916) 
 ;       
 ; RPC:MAGVA CREATE ARTIFACT W KL
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; MAGPARAM("ARTIFACT DESCRIPTOR")
 ; MAGPARAM("ARTIFACT TOKEN")
 ; MAGPARAM("CRC")
 ; MAGPARAM("CREATING APPLICATION")
 ; MAGPARAM("LAST ACCESS DATE/TIME")
 ; MAGPARAM("SIZE IN BYTES")
 ; 
 ; Artifact KEYLIST values
 ;   KLIST(1) = First level Key
 ;   KLIST(2) = Second level Key
 ;   ...
 ;   KLIST(N) = N-th level Key
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ;  
ADDAFACT(MAGRY,MAGPARAM,KLIST) ;  RPC [MAGVA CREATE ARTIFACT W KL]
 ; build KLIST first - workaround for Old broker listener
 N L,LL
 S L="KLIST",LL=0
 K KLIST
 F  S L=$O(MAGPARAM(L)) Q:(L="")!($E(L,1,5)'="KLIST")  S LL=LL+1,KLIST(LL)=MAGPARAM(L) K MAGPARAM(L)
 ;
 N MAGWP,FILE,MAGAPP,PFILE
 K MAGRY
 ; Check ARTIFACT TOKEN presents
 S FILE=2006.916
 I $G(MAGPARAM("ARTIFACT TOKEN"))="" D  Q
 . S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"ARTIFACT TOKEN is required"
 . Q
 ; check for "ARTIFACT TOKEN" for uniqueness first
 I $D(^MAGV(FILE,"B",MAGPARAM("ARTIFACT TOKEN"))) D  Q
 . S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"ARTIFACT TOKEN is not unique"
 . Q
 ;
 ; Get creating application or create a new one
 S PFILE=$$GETFILEP^MAGVAF05(FILE,"CREATING APPLICATION")  ; the file that field points to
 S MAGRY=$$GETIEN^MAGVAF05(PFILE,MAGPARAM("CREATING APPLICATION"),1)
 I '$$ISOK^MAGVAF02(MAGRY) Q  ; Quit if error. MAGRY is already set   
 S MAGPARAM("CREATING APPLICATION")=$$GETVAL^MAGVAF02(MAGRY)  ; Set the internal value
 ;
 ; get the KEYLIST
 D GETKLFK^MAGVAKL1(.MAGRY,.KLIST)
 I '$$ISOK^MAGVAF02(MAGRY) Q  ; Quit if error. MAGRY is already set
 S MAGPARAM("KEYLIST")=$$GETVAL^MAGVAF02(MAGRY)  ; Set the FK
 S MAGPARAM("CREATED DATE/TIME")=$$NOW^XLFDT
 D ADDRCD^MAGVAF01(.MAGRY,FILE,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add an Artifact Retention Policy (#2006.921) record 
 ;       
 ; RPC:MAGVA CREATE ARETPOL
 ; 
 ; Input Parameters
 ; 
 ;   MAGPARAM("ARTIFACT")           = A pointer to ARTIFACT file (#2006.916)
 ;   MAGPARAM("RETENTION POLICY")   = A pointer to RETENTION POLICY file (#2006.914)
 ;   MAGPARAM("SATISFIED DATE/TIME") = DateTime in IDF Format (YYYYMMDD.HHMMSS)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ; 
ADDARP(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE ARETPOL]
 N MAGWP
 K MAGRY
 S MAGPARAM("SATISFIED DATE/TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("SATISFIED DATE/TIME")))
 S MAGPARAM("ACTIVE")=1
 S MAGPARAM("CREATED DATE/TIME")=$$NOW^XLFDT
 D ADDRCD^MAGVAF01(.MAGRY,2006.921,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to RETENTION POLICY FULFILLMENT file (#2006.922)
 ;       
 ; RPC:MAGVA CREATE RETPOLFF
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("ARTIFACT RETENTION POLICY")  = A pointer to ARTIFACT RETENTION POLICY file (#2006.921)
 ;   MAGPARAM("ARTIFACT INSTANCE")   = A pointer to ARTIFACT INSTANCE file (#2006.918)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ; 
ADDARPF(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE RETPOLFF]
 N MAGWP
 K MAGRY
 S MAGPARAM("CREATED DATE/TIME")=$$NOW^XLFDT
 D ADDRCD^MAGVAF01(.MAGRY,2006.922,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to STORAGE PROVIDER AVAILABILITY file (#2006.924)
 ;       
 ; RPC:MAGVA CREATE PROVAVAILTY
 ; 
 ; Input Parameters
 ; 
 ;   MAGPARAM("STORAGE PROVIDER") = A pointer to STORAGE PROVIDER file (#2006.917)
 ;   MAGPARAM("SOURCE PLACE")  = A pointer to IMAGING SITE PARAMETERS file (#2006.1)
 ;   MAGPARAM("START TIME")    = DateTime in IDF format (YYYYMMDD.HHMMSS)
 ;   MAGPARAM("END TIME")      = DateTime in IDF format (YYYYMMDD.HHMMSS)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ; 
ADDPA(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE PROVAVAILTY]
 N MAGWP
 K MAGRY
 ; convert date time fields to FileMan date/time format
 S MAGPARAM("START TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("START TIME")))
 S MAGPARAM("END TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("END TIME")))
 ; Add the record
 D ADDRCD^MAGVAF01(.MAGRY,2006.924,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to STORAGE PROVIDER file (#2006.917)
 ;       
 ; RPC: MAGVA CREATE PROVIDER
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("STORAGE PROVIDER TYPE")
 ;   MAGPARAM("STORAGE PLACE")
 ;   MAGPARAM("ARCHIVE")
 ;   MAGPARAM("PRIMARY STORAGE")
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ;
ADDPRV(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE PROVIDER]
 N MAGWP
 K MAGRY
 S MAGPARAM("WRITABLE")=1
 S MAGPARAM("ACTIVE")=1
 ; Add the record
 D ADDRCD^MAGVAF01(.MAGRY,2006.917,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to ARTIFACT INSTANCE file (#2006.918)
 ;       
 ; RPC: MAGVA CREATE AINSTANCE
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("ARTIFACT")
 ;   MAGPARAM("STORAGE PROVIDER")
 ;   MAGPARAM("FILEREF")
 ;   MAGPARAM("DISK VOLUME")
 ;   MAGPARAM("FILEPATH")
 ;   MAGURL(1..n) = URL value
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ; 
ADDAINST(MAGRY,MAGPARAM,MAGURL) ; RPC [MAGVA CREATE AINSTANCE]
 ; build MAGURL first - workaround for Old broker listener
 N L,LL
 S L="MAGURL",LL=0
 K KLIST
 F  S L=$O(MAGPARAM(L)) Q:(L="")!($E(L,1,6)'="MAGURL")  S LL=LL+1,MAGURL(LL)=MAGPARAM(L) K MAGPARAM(L)
 ;
 N FILE,MAGWP
 K MAGRY
 S FILE=2006.918
 S MAGPARAM("CREATED DATE/TIME")=$$NOW^XLFDT
 M MAGWP("URL")=MAGURL
 D ADDRCD^MAGVAF01(.MAGRY,FILE,.MAGPARAM,.MAGWP)  ; add the record
 Q
 ;
 ;*****  Add a new record to ARTIFACT DESCRIPTOR file (#2006.915)
 ;       
 ; RPC: MAGVA CREATE AD
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; MAGPARAM("ARTIFACT FORMAT")
 ; MAGPARAM("ARTIFACT TYPE")
 ; MAGPARAM("FILE EXTENSION")
 ; MAGPARAM("ACTIVE")
 ; MAGPARAM("RETENTION POLICY")
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ;
ADDAD(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE AD]
 N MAGWP
 K MAGRY
 ; Add the record
 D ADDRCD^MAGVAF01(.MAGRY,2006.915,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to RETENTION POLICY STORAGE PROVIDER MAP file (#2006.923)
 ;       
 ; RPC: MAGVA CREATE RETPOL PROV MAP
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("RETENTION POLICY") = Pointer to RETENTION POLICY file (#2006.914)
 ;   MAGPARAM("STORAGE PROVIDER") = Pointer to STORAGE PROVIDER file (#2006.917)
 ;   MAGPARAM("SOURCE PLACE") = Pointer to IMAGING SITE PARAMETERS file (#2006.1)
 ;   MAGPARAM("SYNCHRONOUS") = 0/1
 ;   MAGPARAM("OFFSITE") = 0/1
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ;
ADDRPPM(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE RETPOL PROV MAP]
 N MAGWP
 K MAGRY
 ; Add the record
 D ADDRCD^MAGVAF01(.MAGRY,2006.923,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to TRANSFER STATISTICS file (#2006.925)
 ;       
 ; RPC: MAGVA CREATE TRF STATS
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("DURATION IN MILLISECONDS")
 ;   MAGPARAM("ENDPOINT PLACE") = Pointer to IMAGING SITE PARAMETERS file (#2006.1)
 ;   MAGPARAM("STORAGE PROVIDER") = Pointer to STORAGE PROVIDER file (#2006.917)
 ;   MAGPARAM("SIZE IN BYTES")
 ;   MAGPARAM("START DATE/TIME") = DateTime in IDF format  (YYYYMMDD.HHMMSS)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ;
ADDTRFS(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE TRF STATS]
 N MAGWP
 K MAGRY
 ; Add the record
 S MAGPARAM("START DATE/TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("START DATE/TIME")))
 D ADDRCD^MAGVAF01(.MAGRY,2006.925,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Add a new record to STORAGE TRANSACTION file (#2006.926)
 ;       
 ; RPC: MAGVA CREATE STORAGE TA
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("ARTIFACT") = Pointer to ARTIFACT file (#2006.916)
 ;   MAGPARAM("STORAGE PROVIDER") = Pointer to STORAGE PROVIDER file (#2006.917)
 ;   MAGPARAM("SUCCEEDED") = 0/1
 ;   MAGPARAM("TRANSACTION TYPE") = 
 ;   MAGPARAM("INITIATING APPLICATION") = 
 ;   
 ;   MAGMSG(1..n) = MESSAGE - optional
 ;   
 ;   MAGMSG(1..n) = MESSAGE 
 ; Return Values
 ; =============
 ; 
 ; if error MAGRY = Failure status ^Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ;
ADDSTTA(MAGRY,MAGPARAM,MAGMSG) ; RPC [MAGVA CREATE STORAGE TA]
 ; build MAGMSG first - workaround for Old broker listener
 N L,LL
 S L="MAGMSG",LL=0
 K MAGMSG
 F  S L=$O(MAGPARAM(L)) Q:(L="")!($E(L,1,6)'="MAGMSG")  S LL=LL+1,MAGMSG(LL)=MAGPARAM(L) K MAGPARAM(L)
 ;
 N FILE,MAGWP,PFILE
 K MAGRY
 S FILE=2006.926
 ;
 ; Get creating application or create a new one
 S PFILE=$$GETFILEP^MAGVAF05(FILE,"INITIATING APPLICATION")
 S MAGRY=$$GETIEN^MAGVAF05(PFILE,MAGPARAM("INITIATING APPLICATION"),1)
 I '$$ISOK^MAGVAF02(MAGRY) Q  ; Quit if error. MAGRY is already set   
 S MAGPARAM("INITIATING APPLICATION")=$$GETVAL^MAGVAF02(MAGRY)  ; Set the internal value
 ;
 S MAGPARAM("TRANSACTION DATE/TIME")=$$NOW^XLFDT
 M MAGWP("MESSAGE")=MAGMSG
 D ADDRCD^MAGVAF01(.MAGRY,FILE,.MAGPARAM,.MAGWP)  ; add the record
 Q
