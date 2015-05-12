MAGVAG03 ;WOIFO/NST/DAC - Write Location calls ; 20 Oct 2014 10:23 AM
 ;;3.0;IMAGING;**118,142**;Mar 19, 2002;Build 15;Oct 20, 2014
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
 ;*****  Returns Current Write Location by Station number or Institution IEN
 ;       
 ; RPC: MAGVA GET CWL
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; MAGPARAM("STATION NUMBER") = STATION NUMBER field (#4,99) in INSTITUTION file (#4)
 ; or
 ; MAGPARAM("INSTITUTION IEN") = IEN in INSTITUTION file (#4)
 ; 
 ; Return Values
 ; =============
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ Error message
 ; if success
 ;   MAGRY(0) = Success status ^^1
 ;   MAGRY(1) = NETWORK LOCATION IEN ^ PHYSICAL REFERENCE ^ USER NAME ^ PASSWORD ^ PLACE
 ;   MAGRY(2) = IEN in NETWORK LOCATION file (#2005.2) ^ PHYSICAL REFERENCE (WRITE LOCATION) (#2005.2,1)
 ;              ^ USER NAME (#2005.2,15) ^ PASSWORD (#2005.2,16) ^ IEN in IMAGING SITE PARAMETERS file (#2006.1)
 ;
GETCWL(MAGRY,MAGPARAM) ; RPC [MAGVA GET CWL]
 N PLACE ; IEN in INSTITUTION FILE (#4)
 N MAGREF,IENS,FILE,OUT,ERR
 N RESDEL
 N MAGPLC
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()  ; Result delimiter
 S PLACE=0
 I $G(MAGPARAM("INSTITUTION IEN"))'="" D  Q:'PLACE  ; Error - MAGRY(0) is already set
 . S PLACE=MAGPARAM("INSTITUTION IEN") ; P142 DAC
 . I 'PLACE D
 . . N MSG
 . . S MSG="Invalid INSTITUTION IEN"
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . . Q
 . Q
 I ((PLACE)&($$STA^XUAF4(PLACE)=""))!(PLACE'=+PLACE) S MAGPARAM("STATION NUMBER")=$G(MAGPARAM("INSTITUTION IEN")) ; P142 DAC
 I $G(MAGPARAM("STATION NUMBER"))'="" D  Q:'PLACE  ; Error - MAGRY(0) is already set
 . S PLACE=$$IEN^XUAF4(MAGPARAM("STATION NUMBER")) ; IA # 2171 find the Institution IEN
 . I 'PLACE  D
 . . N MSG
 . . S MSG="Invalid STATION NUMBER: "_MAGPARAM("STATION NUMBER")
 . . I $G(MAGPARAM("INSTITUTION IEN"))'="" S MSG="Invalid INSTITUTION IEN: "_MAGPARAM("INSTITUTION IEN") ; P142 DAC
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . . Q
 . Q
 I 'PLACE D  Q  ; Error - MAGRY(0) is already set
 . N MSG
 . S MSG="STATION NUMBER or INSTITUTION IEN is required"
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . Q
 ;
 S MAGPLC=$$PLACE^MAGBAPI(PLACE)  ; Get IEN of a record in IMAGING SITE PARAMETERS file (#2006.1)
 S MAGREF=$$GET1^DIQ(2006.1,MAGPLC,.03,"I") ; IMAGE NETWORK WRITE LOCATION 
 I 'MAGREF D  Q
 . N MSG
 . S MSG="Need WRITE LOCATION in IMAGING SITE PARAMETERS file (#2006.1). Call IRM."
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . Q
 ;
 I '$$GET1^DIQ(2005.2,MAGREF,5,"I") D  Q  ; Operational status
 . N MSG
 . S MSG="The Server that you are writing to is off-line.  Call IRM"
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . Q
 ;
 S IENS=MAGREF_","
 S FILE=2005.2
 D GETS^DIQ(FILE,IENS,"1;15;16","I","OUT","ERR")
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the values
 . Q
 ;
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_1
 S MAGRY(1)="NETWORK LOCATION IEN"_RESDEL_"PHYSICAL REFERENCE"
 S MAGRY(1)=MAGRY(1)_RESDEL_"USER NAME"_RESDEL_"PASSWORD"_RESDEL_"PLACE"
 S MAGRY(2)=MAGREF_RESDEL_OUT(FILE,IENS,1,"I")
 S MAGRY(2)=MAGRY(2)_RESDEL_OUT(FILE,IENS,15,"I")_RESDEL_OUT(FILE,IENS,16,"I")_RESDEL_MAGPLC
 Q
 ;
 ;*****  Returns Jukebox Write Location by Station number or Institution IEN
 ;       
 ; RPC: MAGVA GET JUKEBOX WL
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; MAGPARAM("STATION NUMBER") = STATION NUMBER field (#4,99) in INSTITUTION file (#4)
 ; or
 ; MAGPARAM("INSTITUTION IEN") = IEN in INSTITUTION file (#4)
 ; 
 ; Return Values
 ; =============
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ Error message
 ; if success
 ;   MAGRY(0) = Success status ^^1
 ;   MAGRY(1) = NETWORK LOCATION IEN ^ PHYSICAL REFERENCE ^ USER NAME ^ PASSWORD ^ PLACE
 ;   MAGRY(2) = IEN in NETWORK LOCATION file (#2005.2) ^ PHYSICAL REFERENCE (WRITE LOCATION) (#2005.2,1)
 ;              ^ USER NAME (#2005.2,15) ^ PASSWORD (#2005.2,16) ^ IEN in IMAGING SITE PARAMETERS file (#2006.1)
 ;
GETJBXWL(MAGRY,MAGPARAM) ; RPC [MAGVA GET JUKEBOX WL]
 N PLACE ; IEN in INSTITUTION FILE (#4)
 N MAGREF,IENS,FILE,OUT,ERR
 N RESDEL
 N MAGPLC
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()  ; Result delimiter
 S PLACE=0
 I $G(MAGPARAM("INSTITUTION IEN"))'="" D  Q:'PLACE  ; Error - MAGRY(0) is already set
 . S PLACE=+MAGPARAM("INSTITUTION IEN")
 . I 'PLACE D
 . . N MSG
 . . S MSG="Invalid INSTITUTION IEN"
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . . Q
 . Q
 I $G(MAGPARAM("STATION NUMBER"))'="" D  Q:'PLACE  ; Error - MAGRY(0) is already set
 . S PLACE=$$IEN^XUAF4(MAGPARAM("STATION NUMBER")) ; IA # 2171 find the Institution IEN
 . I 'PLACE  D
 . . N MSG
 . . S MSG="Invalid STATION NUMBER: "_MAGPARAM("STATION NUMBER")
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . . Q
 . Q
 I 'PLACE D  Q  ; Error - MAGRY(0) is already set
 . N MSG
 . S MSG="STATION NUMBER or INSTITUTION IEN is required"
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . Q
 ;
 S MAGPLC=$$PLACE^MAGBAPI(PLACE) ; Get IEN in IMAGING SITE PARAMETERS file (#2006.1)
 S MAGREF=$$GET1^DIQ(2006.1,MAGPLC,2.01,"I") ; JUKEBOX WRITE LOCATION
 I 'MAGREF D  Q
 . N MSG
 . S MSG="Need WRITE LOCATION in IMAGING SITE PARAMETERS file (#2006.1). Call IRM."
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . Q
 ;
 I '$$GET1^DIQ(2005.2,MAGREF,5,"I") D  Q  ; Operational status
 . N MSG
 . S MSG="The Server that you are writing to is off-line.  Call IRM"
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . Q
 ;
 S IENS=MAGREF_","
 S FILE=2005.2
 D GETS^DIQ(FILE,IENS,"1;15;16","I","OUT","ERR") I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the values
 . Q
 ;
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_1
 S MAGRY(1)="NETWORK LOCATION IEN"_RESDEL_"PHYSICAL REFERENCE"
 S MAGRY(1)=MAGRY(1)_RESDEL_"USER NAME"_RESDEL_"PASSWORD"_RESDEL_"PLACE"
 S MAGRY(2)=MAGREF_RESDEL_OUT(FILE,IENS,1,"I")
 S MAGRY(2)=MAGRY(2)_RESDEL_OUT(FILE,IENS,15,"I")_RESDEL_OUT(FILE,IENS,16,"I")_RESDEL_MAGPLC
 Q
 ;
 ;*****  Returns PHYSICAL REFERENCE (WRITE LOCATION)
 ;               USER NAME, PASSWORD, OPERATIONAL STATUS and PLACE
 ;       by IEN in NETWORK LOCATION file (#2005.2)
 ;       
 ; RPC: MAGVA GET NET LOC DETAILS
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; NLOCIEN = IEN in NETWORK LOCATION file (#2005.2) 
 ; 
 ; Return Values
 ; =============
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ Error message
 ; if success
 ;   MAGRY(0) = Success status ^^1
 ;   MAGRY(1) = PHYSICAL REFERENCE ^ USER NAME ^ PASSWORD ^ OPERATIONAL STATUS ^ PLACE
 ;   MAGRY(2) = PHYSICAL REFERENCE (WRITE LOCATION) (#2005.2,1)
 ;              ^ USER NAME (#2005.2,15) ^ PASSWORD (#2005.2,16)
 ;              ^ OPERATIONAL STATUS (#2005.2,5) ^ PLACE (#2005.2,.04)
 ;
GETNLOCD(MAGRY,NLOCIEN) ; RPC [MAGVA GET NET LOC DETAILS]
 N RESDEL
 N IENS,FILE,OUT,ERR,MAGRESA
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()  ; Result delimiter
 I 'NLOCIEN D  Q
 . N MSG
 . S MSG="NETWORK LOCATION IEN is required."
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_MSG
 . Q
 ; 
 S IENS=NLOCIEN_","
 S FILE=2005.2
 D GETS^DIQ(FILE,IENS,"1;15;16;5;.04","I","OUT","ERR")
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the values
 . Q
 ;
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_1
 S MAGRY(1)="PHYSICAL REFERENCE"_RESDEL_"USER NAME"_RESDEL_"PASSWORD"_RESDEL_"OPERATIONAL STATUS"_RESDEL_"PLACE"
 S MAGRY(2)=OUT(FILE,IENS,1,"I")_RESDEL_OUT(FILE,IENS,15,"I")_RESDEL_OUT(FILE,IENS,16,"I")
 S MAGRY(2)=MAGRY(2)_RESDEL_OUT(FILE,IENS,5,"I")_RESDEL_OUT(FILE,IENS,.04,"I")
 Q
 ;
 ;*****  Returns information from IMAGING SITE PARAMETERS file (#2006.1)
 ;       
 ; RPC: MAGVA GET ALL SITE PARAM IDS
 ; 
 ; Return Values
 ; =============
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ Error message
 ; if success
 ;   MAGRY(0) = Success status ^^#CNT - where #CNT is a number of records returned
 ;   MAGRY(1) = PK^Site IEN^Site Number^Site Name^Net UserName^Net Password
 ;   MAGRY(2) = IEN ^ Site IEN ^ Site Number ^ Site Name ^ Net UserName ^ Net Password
 ;
GALLISP(MAGRY) ; RPC [MAGVA GET ALL SITE PARAM IDS]
 N X,CNT,I,FILE,IENS,FIELDS,INSTIEN
 N OUT,ERR,MAGRESA
 N RESDEL
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()  ; Result delimiter
 S FILE=2006.1
 S FIELDS=".01;50;51" ; INSTITUTION NAME; NET USER; NET PASSWORD  
 S IENS=""
 ; Index "B" is mixed with index "C" - get data from global
 S I=0
 S CNT=1
 F  S I=$O(^MAG(FILE,I)) Q:(+I)'>0  D
 . S IENS=I_","
 . K OUT,ERR
 . D GETS^DIQ(FILE,IENS,FIELDS,"I","OUT","ERR")
 . I $D(ERR("DIERR")) D  Q
 . . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the values
 . . Q
 . S INSTIEN=OUT(FILE,IENS,.01,"I")
 . S X=$$NS^XUAF4(INSTIEN) ; IA # 2171 Institution Name and Station Number
 . S CNT=CNT+1
 . S MAGRY(CNT)=I_RESDEL_INSTIEN_RESDEL_$P(X,U,2)_RESDEL_$P(X,U,1)
 . S MAGRY(CNT)=MAGRY(CNT)_RESDEL_OUT(FILE,IENS,50,"I")_RESDEL_OUT(FILE,IENS,51,"I")
 . Q
 ;
 S X="IEN^Site IEN^Site Number^Site Name^Net UserName^Net Password"
 F I=1:1:$L(X,"^") S $P(MAGRY(1),RESDEL,I)=$P(X,"^",I)
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_(CNT-1)
 Q
