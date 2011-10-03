MAGDRPCB ;WOIFO/PMK/MLS/SG - Imaging RPCs for Importer ; 27 Apr 2010 3:34 PM
 ;;3.0;IMAGING;**53**;Mar 19, 2002;Build 1719;Apr 28, 2010
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
FILM(RESULTS,FILM) ; RPC = MAG DICOM GET RAD FILM
 D LOOKUP(.RESULTS,$G(FILM),78.4,"B",".01") ; ICR 5360
 Q
 ;
DXCODE(RESULTS,DXCODE) ; RPC = MAG DICOM GET RAD DIAGNOSTIC CODE
 D LOOKUP(.RESULTS,$G(DXCODE),78.3,"B",".01") ; ICR 4112
 Q
 ;
CAMERA(RESULTS,CAMERA) ; RPC = MAG DICOM GET RAD CAMERA
 D LOOKUP(.RESULTS,$G(CAMERA),78.6,"B",".01;2") ; ICR 5359
 Q
 ; 
CPTMOD(RESULTS,CPTMOD,MAGDT) ; RPC = MAG DICOM GET RAD CPT MOD
 ; CPTMOD = partial CPT modifier match
 N I,SCR
 S:$G(MAGDT)'>0 MAGDT=$$DT^XLFDT
 S SCR="S D=$$MOD^ICPTMOD(Y,""I"",MAGDT) I D'<0,$P(D,U,7)"
 D LOOKUP(.RESULTS,$G(CPTMOD),81.3,"C","",SCR) ; ICR 3026
 F I=1:1:$G(RESULTS(1)) D
 . S $P(RESULTS(I+1),"^",2)=$P($$MOD^ICPTMOD(RESULTS(I+1),"I"),"^",3)
 . Q
 Q
 ;
LOOKUP(RESULTS,SRCHVAL,FILE,XREF,FIELDS,SCREEN) ; search file
 N CNT,I,MAGTMP,MAGMSG,MAXNR,X
 S MAXNR=100  ; Maximum number of records to return
 S SRCHVAL=$$UP^XLFSTR($TR(SRCHVAL,"*?"))
 S SRCHVAL=$E(SRCHVAL,1,30) ; limit of 30 characters for B or C cross reference
 S MAGTMP=$NA(^TMP($T(+0),$J))
 K @MAGTMP,RESULTS
 ;
 ;--- Perform the search
 D LIST^DIC(FILE,,"@;"_FIELDS,"P",MAXNR,,SRCHVAL,XREF,$G(SCREEN),,MAGTMP,"MAGMSG")
 S X=$G(@MAGTMP@("DILIST",0))
 I X'>0  S RESULTS(1)="-1^No records match the input."  Q
 I $P(X,U,3)  D  Q
 . S RESULTS(1)="-2,More than "_MAXNR_" matches; please specify"
 . S RESULTS(1)=RESULTS(1)_" more characters in the name."
 . Q
 ;
 ;--- Copy the records to the resut array
 S (RESULTS(1),I)=0
 F  S I=$O(@MAGTMP@("DILIST",I))  Q:'I  D
 . S RESULTS(1)=RESULTS(1)+1
 . S RESULTS(RESULTS(1)+1)=@MAGTMP@("DILIST",I,0)
 . Q
 ;
 ;--- Cleanup
 K @MAGTMP
 Q
 ;
 ;***** RETURNS LIST OF USERS WITH PROVIDED RADIOLOGY CLASSIFICATION
 ; RPC: MAG DICOM GET RAD PERSON
 ;
 ; .RESULTS      Reference to a local variable where results
 ;               are returned to.
 ;
 ; MAGRADCLASS   Radiology classification codes (can be combined):
 ;
 ;                 C  Clerk    R  Resident
 ;                 S  Staff    T  Technologist
 ;
 ; [NAME]        Partial name match.
 ;
RADLST(RESULTS,MAGRADCLASS,NAME) ;
 N I,MAGMSG,MAGTMP,MAXNR,X
 S MAXNR=100      ; Maximum number of records to return
 S DT=$$DT^XLFDT  ; Make sure that the actual date is there
 S MAGTMP=$NA(^TMP($T(+0),$J))
 K @MAGTMP,RESULTS
 ;
 ;--- Validate parameters
 I $G(MAGRADCLASS)=""  D  Q
 . S RESULTS(1)="-1^No RAD/NUC classification provided."
 . Q
 S NAME=$$UP^XLFSTR($TR($G(NAME),"*?"))
 S NAME=$E(NAME,1,30) ; limit of 30 characters for B cross reference
 ;
 ;--- Search for users
 S X="I $$SCRUSR^"_$T(+0)_"(Y)"  ; Screening code
 D LIST^DIC(200,,"@;.01","P",MAXNR,,NAME,"B",X,,MAGTMP,"MAGMSG") ; ICR # 10060
 S X=$G(@MAGTMP@("DILIST",0))
 I X'>0  S RESULTS(1)="-1^No provider matching input."  Q
 I $P(X,U,3)  D  Q
 . S RESULTS(1)="-2,More than "_MAXNR_" matches; please specify"
 . S RESULTS(1)=RESULTS(1)_" more characters in the name."
 . Q
 ;
 ;--- Copy the records to the result array
 S (RESULTS(1),I)=0
 F  S I=$O(@MAGTMP@("DILIST",I))  Q:'I  D
 . S RESULTS(1)=RESULTS(1)+1
 . S RESULTS(RESULTS(1)+1)=@MAGTMP@("DILIST",I,0)
 . Q
 ;
 ;--- Cleanup
 K @MAGTMP
 Q
 ;
 ;***** SCREENING LOGIC FOR SEARCH FOR RADIOLOGY USERS
 ;
 ; IEN           IEN in the NEW PERSON file (#200)
 ;
 ; Input variables:
 ;   MAGRADCLASS
 ;
 ; Return Values:
 ;            0  Skip the record
 ;            1  Get the record
 ;
SCRUSR(IEN) ;
 N IEN1,MAGMSG,OK,TERMDT
 ;--- Check the termination date
 S TERMDT=$$GET1^DIQ(200,IEN_",",9.2,"I",,"MAGMSG") ; ICR # 10060
 I TERMDT>0  Q:TERMDT'>DT 0
 ;--- Check the radiology classification
 S (IEN1,OK)=0
 F  S IEN1=$O(^VA(200,IEN,"RAC",IEN1))  Q:'IEN1  D  Q:OK
 . S:MAGRADCLASS[$P(^VA(200,IEN,"RAC",IEN1,0),U) OK=1
 . Q
 Q OK
 ;
GETLOC(RESULTS,LOCATION) ; RPC = MAG DICOM GET HOSP LOCATION
 N I,INACTIVE,LIST,REACTIVE,TYPE
 D LOOKUP(.LIST,$G(LOCATION),44,"B",".01;2I;2505I;2506I") ; ICR 10040
 K RESULTS
  ;--- Copy the records to the result array
 S (RESULTS(1),I)=0
 F I=2:1:LIST(1)+1 D
 . S TYPE=$P(LIST(I),"^",3)
 . ;
 . ; allow C=Clinc, M=Module, W=Ward, Z=Other Location
 . ; allow N=Non-clinic stop, OR=Operating Room
 . ; ignore F=File area and I=Imaging
 . ;
 . I "^C^M^W^Z^N^OR^"'[("^"_TYPE_"^") Q
 . ;
 . ; check inactivate date and reactivate date
 . S INACTIVE=$P(LIST(I),"^",4),REACTIVE=$P(LIST(I),"^",5)
 . I INACTIVE,DT>INACTIVE Q:'REACTIVE  Q:DT<REACTIVE
 . ;
 . S RESULTS(1)=RESULTS(1)+1
 . S RESULTS(I)=$P(LIST(I),"^",1,2)
 . Q
 Q
 ;
USERNAME(RESULT) ; RPC = MAG DICOM GET USERNAME
 S RESULT=$$GET1^DIQ(200,DUZ,.01) ; ICR # 10060
 Q
 ;
ORDERS(ARRAY,DFN) ; RPC = MAG DICOM GET RAD ORDERS
 ; look up radiology orders
 N ACNUMB,CASENUMB,DIERR,EXAMDATA,EXAMDATE,ERROR,FIELDS,I,IENS,IMAGLOCN,INACTDAT
 N ORDER,MAGEXAM,MAGMSG,MAGTMPEXAM,MAGTMPMOD,MODCOUNT,MODDATA
 N MODIEN,MODIFIER,MSG,PROCIEN,RACNI,RADFN,RADTI,RAOIEN,RC,STATUS,STUDYDAT,TODAY,X,Z
 K ARRAY
 S DFN=$G(DFN),TODAY=$$DT^XLFDT()
 I (DFN'>0)!(DFN'=+DFN) D  Q
 . S ARRAY(1)="-1,Invalid or missing patient identifier: """_DFN_"""."
 . Q
 ;
 ; Make sure that the patient is registered in the RAD/NUC MED PATIENT file (#70)
 ;
 S RC=$$RAPTREG^RAMAGU04(DFN) I RC<0 D  Q  ; ICR 5519
 . S ARRAY(1)="-2,Patient with DFN #"_DFN_" is not defined in the RAD/NUC MED PATIENT file (#70)."
 . S ARRAY(2)=RC
 . Q
 ;
 ; Use MUMPS global reads to get data from ^RAO because of possible bad data
 ; that would cause Fileman to throw an error and not return any results.
 ;
 S (ARRAY(1),ERROR,RAOIEN)=0
 F  S RAOIEN=$O(^RAO(75.1,"B",DFN,RAOIEN)) Q:ERROR  Q:RAOIEN=""  D  ; ICR 3074
 . S STATUS=$$GET1^DIQ(75.1,RAOIEN,5) ; request status
 . I "^^COMPLETE^DISCONTINUED^UNRELEASED^"[("^"_STATUS_"^") Q  ; quit if status is null too
 . S Z=$G(^RAO(75.1,RAOIEN,0))
 . K ORDER S $P(ORDER,"^",11)="" ; initialize ORDER string
 . S $P(ORDER,"^",1)=RAOIEN ; file 75.1 IEN
 . S PROCIEN=$P(Z,"^",2) ; procedure
 . Q:PROCIEN=""  Q:'$D(^RAMIS(71,PROCIEN,0))  ; null or bad PROCIEN
 . S INACTDAT=$P($G(^RAMIS(71,PROCIEN,"I")),U)
 . I INACTDAT,INACTDAT<TODAY Q  ; ignore inactive procedures
 . S $P(ORDER,"^",2)=PROCIEN ; procedure
 . ; piece 3 of ORDER is modifier(s)
 . S $P(ORDER,"^",4)=STATUS ; request status
 . S $P(ORDER,"^",5)=$P(Z,"^",16) ; request entered date
 . S $P(ORDER,"^",6)=$$GET1^DIQ(75.1,RAOIEN,1.1) ; reason for study
 . I $D(^RADPT("AO",RAOIEN)) D
 . . S RADFN=$O(^RADPT("AO",RAOIEN,"")) ; ICR 1172
 . . S RADTI=$O(^RADPT("AO",RAOIEN,RADFN,""))
 . . S RACNI=$O(^RADPT("AO",RAOIEN,RADFN,RADTI,""))
 . . S $P(ORDER,"^",7)=RADTI
 . . S $P(ORDER,"^",8)=RACNI
 . . S MAGTMPEXAM=$NA(^TMP($T(+0),$J,"EXAM"))
 . . S IENS=RACNI_","_RADTI_","_RADFN_","
 . . S EXAMDATA=$NA(@MAGTMPEXAM@(70.03,IENS))
 . . I $T(ACCFIND^RAAPI)'="" S FIELDS=".01;31;" ; requires RA*5.0*47
 . . E  S FIELDS=".01;" ; no accession number field (#31)
 . . K @MAGTMPEXAM,MAGMSG
 . . D GETS^DIQ(70.03,IENS,FIELDS,"EI",MAGTMPEXAM,"MAGMSG") ; ICR 1172
 . . I $D(MAGMSG) D ORDERERR(.ARRAY,.MAGMSG,-3) S ERROR=-3 Q  ; fatal FileMan error
 . . S EXAMDATE=$$GET1^DIQ(70.02,(RADTI_","_RADFN),.01,"I") ; ICR 1172
 . . S ACNUMB=$G(@EXAMDATA@(31,"E"))
 . . I ACNUMB="" D
 . . . S CASENUMB=@EXAMDATA@(.01,"E")
 . . . S ACNUMB=$E(EXAMDATE,4,7)_$E(EXAMDATE,2,3)_"-"_CASENUMB
 . . . Q
 . . S $P(ORDER,"^",9)=ACNUMB,$P(ORDER,"^",10)=EXAMDATE
 . . S IMAGLOCN=$$GET1^DIQ(70.02,(RADTI_","_RADFN),4) ; ICR 1172
 . . S $P(ORDER,"^",11)=IMAGLOCN
 . . Q
 . ;
 . I ERROR Q  ; FileMan error encountered in exam lookup
 . ;
 . ; get procedure modifier(s)
 . S MAGTMPMOD=$NA(^TMP($T(+0),$J,"MODIFIER")),MODDATA=$NA(@MAGTMPMOD@("DILIST"))
 . K @MAGTMPMOD,MAGMSG
 . D LIST^DIC(75.1125,","_RAOIEN_",","@;.01;.01I;IX","",,,,,,,MAGTMPMOD,"MAGMSG") ; ICR 3074
 . I $D(MAGMSG) D ORDERERR(.ARRAY,.MAGMSG,-4) Q  ; fatal FileMan error
 . S MODCOUNT=+@MODDATA@(0)
 . S MODIFIER=""
 . F I=1:1:MODCOUNT D
 . . S:$L(MODIFIER) MODIFIER=MODIFIER_"~"
 . . S MODIEN=@MODDATA@(2,I)
 . . S MODIFIER=MODIFIER_@MODDATA@("ID",MODIEN,.01,"E")_"|"_^("I")
 . . Q
 . S $P(ORDER,"^",3)=MODIFIER
 . ;
 . S ARRAY(1)=ARRAY(1)+1,ARRAY(ARRAY(1)+1)=ORDER
 . Q
 K:$D(MAGTMPEXAM) @MAGTMPEXAM K:$D(MAGTMPMOD) @MAGTMPMOD ; cleanup
 Q
 ;
ORDERERR(ARRAY,MSG,ERRNUMB) ; handle FilMan errors in ORDER subroutine
 N I,NODE
 K ARRAY
 S I=1,NODE="MSG"
 F  S NODE=$Q(@NODE) Q:NODE=""  D
 . S I=I+1,ARRAY(I)=NODE
 . I $D(@NODE) S ARRAY(I)=ARRAY(I)_"="_@NODE
 . Q
 S ARRAY(1)="-100,Fatal FileMan error #"_ERRNUMB
 Q
 ;
IMAGELOC(RESULT,RAOIEN,RAMLC) ; RPC = MAG DICOM SET IMAGING LOCATION
 N DIERR,MAGFDA,MAGMSG
 ;
 K RESULT
 S RAOIEN=$G(RAOIEN)
 I (RAOIEN'>0)!(RAOIEN'=+RAOIEN) D  Q
 . S RESULT="-1,Invalid or missing Radiology Order pointer: """_RAOIEN_"""."
 . Q
 ;
 S RAMLC=$G(RAMLC)
 I (RAMLC'>0)!(RAMLC'=+RAMLC) D  Q
 . S RESULT="-2,Invalid or missing Radiology Image Location identifier: """_RAMLC_"""."
 . Q
 ;
 I $$GET1^DIQ(75.1,RAOIEN,.01)="" D  Q  ; ICR 3074
 . S RESULT="-3,Missing Radiology Order for pointer: """_RAOIEN_"""."
 . Q
 ;
 I $$GET1^DIQ(79.1,RAMLC,.01)="" D  Q  ; ICR 5357
 . S RESULT="-4,Missing Radiology Image Location for pointer: """_RAMLC_"""."
 . Q
 ;
 I $$GET1^DIQ(75.1,RAOIEN,20)="" D  Q  ; ICR 3074
 . S MAGFDA(75.1,RAOIEN_",",20)=RAMLC ; IMAGING LOCATION
 . D FILE^DIE("","MAGFDA","MAGMSG") ; ICR 3074
 . I $D(MAGMSG) S RESULT="-5,Error setting Radiology Image Location" Q
 . S RESULT="1,Radiology Image Location set for pointer: """_RAOIEN_"""."
 . Q
 E  D
 . S RESULT="2,Radiology Image Location already set for pointer: """_RAOIEN_""", operation ignored."
 . Q
 Q
 ;
ADDROOM(RETURN,RAEXAM) ; RPC = MAG DICOM ADD CAMERA EQUIP RM
 N HIT,I,IENS,LOCNAME,OUTSIDESTUDY,MAGFDA,MAGMSG,RADIMGLOC,ROOMS
 K RETURN
 ;
 I $L($G(RAEXAM),"^")<2 S RETURN(0)="-1,Invalid or missing Radiology Exam pointer: """_RAEXAM_"""." Q
 ; 
 ; get the Radiology IMAGING LOCATION
 S IENS=$P(RAEXAM,"^",2)_","_$P(RAEXAM,"^",1)_","
 S RADIMGLOC=$$GET1^DIQ(70.02,IENS,4,"I")  ; ICR 1172
 I 'RADIMGLOC S RETURN(0)="-2,Invalid or missing Radiology IMAGING LOCATION for Exam pointer: """_RAEXAM_"""." Q
 S LOCNAME=$$GET1^DIQ(79.1,RADIMGLOC,.01)
 ;
 ; check if the IMAGING LOCATION has the OUTSIDE STUDY Camera/Equipment/Room
 S OUTSIDESTUDY="OUTSIDE STUDY" ; designated name
 D LIST^DIC(79.12,","_RADIMGLOC_",","@;.01","",,,,,,,"ROOMS","MAGMSG")
 I $D(MAGMSG) D ORDERERR(.RETURN,.MAGMSG,-3) Q  ; fatal FileMan error
 S HIT=0 F I=1:1:ROOMS("DILIST",0) D  Q:HIT
 . I ROOMS("DILIST","ID",I,".01")=OUTSIDESTUDY S HIT=1
 . Q
 I HIT S RETURN(0)="2,"_OUTSIDESTUDY_" is already defined for """_LOCNAME_"""." Q
 ;
 ; add the OUTSIDE STUDY Camera/Equipment/Room to the IMAGING LOCATION
 S MAGFDA(79.12,"+1,"_RADIMGLOC_",",.01)=OUTSIDESTUDY
 D UPDATE^DIE("E","MAGFDA","MAGIENS","MAGMSG") ; ICR 5357
 I $D(MAGMSG) D ORDERERR(.RETURN,.MAGMSG,-4) Q  ; fatal FileMan error
 S RETURN(0)="1,"_OUTSIDESTUDY_" has been added for """_LOCNAME_"""."
 Q
