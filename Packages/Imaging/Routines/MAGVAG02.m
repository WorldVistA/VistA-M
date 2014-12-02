MAGVAG02 ;WOIFO/NST - Utilities for RPC calls ; 11 Mar 2010 4:39 PM
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
 ;*****  Get artifact values with key list from ARTIFACT file (#2006.916)
 ;       & ARTIFACT KEYLIST file (#2006.913) by artifact token
 ;       
 ; RPC:MAGVA GET ARTIFACT W KL
 ; 
 ; Input Parameters
 ; ================
 ; TOKEN = Artifact token
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(1..n) XML based result in format
 ;            <?xml version="1.0" encoding="utf-8"?>
 ;            <artifacts>
 ;              <artifact
 ;                id=""
 ;                token=""
 ;                size=""
 ;                keyListFK=""
 ;                createdDateTime=""
 ;                lastAccessDateTime=""
 ;                crc="">
 ;                <keys>
 ;                  <key kvalue="" klevel="" />
 ;                   ...
 ;                  <key kvalue="" klevel=""/>
 ;                </keys>
 ;              </artifact>
 ;            </artifacts>
 ;  
GAKLT(MAGRY,TOKEN) ;  RPC [MAGVA GET ARTIFACT W KL]
 K MAGRY
 N RES,START
 D GETAIENT^MAGVAG02(.RES,TOKEN,"") ; Get not deleted Artifact IEN by Token
 I '$$ISOK^MAGVAF02(RES) S MAGRY(0)=RES Q
 S IEN=$$GETVAL^MAGVAF02(RES)
 S START=2 ; populate MAGRY starting with node 2
 D GAFTBYID^MAGVAG04(.MAGRY,IEN,START,"K")  ; Get the artifact with KeyList;
 D SETFTUCH^MAGVAF03(.MAGRY) ; set line 1 and two and the last one
 Q
 ;
 ;*****  Get artifact values with key list and artifact instance
 ;       from ARTIFACT file (#2006.916)
 ;       & ARTIFACT KEYLIST file (#2006.913) and ARTIFACT INSTANCE file (#2006.918)
 ;       by artifact token
 ;       
 ; RPC:MAGVA GET A W KL AND AIS
 ; 
 ; Input Parameters
 ; ================
 ; TOKEN = Artifact token
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(1..n) XML based result in format
 ;            <?xml version="1.0" encoding="utf-8"?>
 ;            <artifacts>
 ;              <artifact
 ;                id=""
 ;                token=""
 ;                size=""
 ;                keyListFK=""
 ;                createdDateTime=""
 ;                lastAccessDateTime=""
 ;                crc="">
 ;                <keys>
 ;                  <key kvalue="" klevel="" />
 ;                   ...
 ;                  <key kvalue="" klevel="" />
 ;                </keys>
 ;                <artifact Instances>
 ;                 <artifact Instance>
 ;                 ....
 ;                 <artifact Instance>
 ;                </artifact Instances>
 ;              </artifact>
 ;            </artifacts>
 ;  
GAKLAIST(MAGRY,TOKEN) ;  RPC [MAGVA GET A W KL AND AIS]
 K MAGRY
 N RES,START
 D GETAIENT^MAGVAG02(.RES,TOKEN,"") ; Get not deleted Artifact IEN by Token
 I '$$ISOK^MAGVAF02(RES) S MAGRY(0)=RES Q
 S IEN=$$GETVAL^MAGVAF02(RES)
 S START=2 ; populate MAGRY starting with node 2
 D GAFTBYID^MAGVAG04(.MAGRY,IEN,START,"KI")  ; Get the artifact with KeyList & Artifact Instance
 D SETFTUCH^MAGVAF03(.MAGRY) ; set line 1 and two and the last one
 Q
 ;
 ;*****  Get artifact values with key list and artifact instance
 ;       from ARTIFACT file (#2006.916)
 ;       & ARTIFACT KEYLIST file (#2006.913) and ARTIFACT INSTANCE file (#2006.918)
 ;       by artifact PK (IEN)
 ;       
 ; RPC:MAGVA GET A W KL AND AIS BY PK
 ; 
 ; Input Parameters
 ; ================
 ; IEN = Artifact PK
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(1..n) XML based result in format
 ;            <?xml version="1.0" encoding="utf-8"?>
 ;            <artifacts>
 ;              <artifact
 ;                id=""
 ;                token=""
 ;                size=""
 ;                keyListFK=""
 ;                createdDateTime=""
 ;                lastAccessDateTime=""
 ;                crc="">
 ;                <keys>
 ;                  <key kvalue="" klevel="" />
 ;                   ...
 ;                  <key kvalue="" klevel="" />
 ;                </keys>
 ;                <artifact Instances>
 ;                 <artifact Instance>
 ;                 ....
 ;                 <artifact Instance>
 ;                </artifact Instances>
 ;              </artifact>
 ;            </artifacts>
 ;  
GAKLAISP(MAGRY,IEN) ;  RPC [MAGVA GET A W KL AND AIS BY PK]
 N START
 K MAGRY
 ; Check whether artifact is deleted
 I $$ISAFTDEL^MAGVAG02(IEN) S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Artifact "_IEN_" is deleted" Q  ; skip deleted artifact
 S START=2 ; populate MAGRY starting with node 2
 D GAFTBYID^MAGVAG04(.MAGRY,IEN,START,"KI")  ; Get the artifact with KeyList and Artifact Instance
 D SETFTUCH^MAGVAF03(.MAGRY) ; set lines 0,1, and 2 and the last one
 Q
 ;
 ;*****  Get artifact values with keylist and artifact instance and
 ;       artifact retention policy and fulfillment
 ;       from ARTIFACT file (#2006.916)
 ;       & ARTIFACT KEYLIST file (#2006.913), ARTIFACT INSTANCE file (#2006.918)
 ;       ARTIFACT RETENTION POLICY file (#2006.921)
 ;       and RETENTION POLICY FULFILLMENT file (#2006.922)
 ;       by artifact token
 ;       
 ; RPC:MAGVA GET A AIS ARPS AND RPFFS
 ; 
 ; Input Parameters
 ; ================
 ; TOKEN = Artifact token
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(1..n) XML based result in format
 ;            <?xml version="1.0" encoding="utf-8"?>
 ;            <artifacts>
 ;              <artifact
 ;                id=""
 ;                token=""
 ;                size=""
 ;                keyListFK=""
 ;                createdDateTime=""
 ;                lastAccessDateTime=""
 ;                crc="">
 ;                <keys>
 ;                  <key kvalue="" klevel="" />
 ;                   ...
 ;                  <key kvalue="" klevel="" />
 ;                </keys>
 ;                <artifact Instances>
 ;                 <artifact Instance>
 ;                 ....
 ;                 <artifact Instance>
 ;                </artifact Instances>
 ;                <artifact Retention policy>
 ;                 <artifact Retention policy fulfillments>
 ;                   <artifact Retention policy fulfillment>
 ;                   ...
 ;                   <artifact Retention policy fulfillment>
 ;                   ...
 ;                 </artifact Retention policy fulfillments>
 ;                </artifact Retention policy>
 ;              </artifact>
 ;            </artifacts>
 ;  
GAKISRPT(MAGRY,TOKEN) ;  RPC [MAGVA GET A AIS ARPS AND RPFFS]
 K MAGRY
 N RES,START,IEN
 D GETAIENT^MAGVAG02(.RES,TOKEN,"") ; Get note deleted Artifact IEN by Token
 I '$$ISOK^MAGVAF02(RES) S MAGRY(0)=RES Q
 S IEN=$$GETVAL^MAGVAF02(RES)
 S START=2 ; populate MAGRY starting with node 2
 ; Get the artifact with KeyList, Artifact Instance & Retention Policy and Fulfillment
 D GAFTBYID^MAGVAG04(.MAGRY,IEN,START,"KIR")
 D SETFTUCH^MAGVAF03(.MAGRY) ; set line 1 and two and the last one
 Q
 ;
 ; -- Get Artifact IEN by TOKEN
 ;
 ; Input parameters
 ; ================
 ; TOKEN = Artifact token
 ; FLAGS =
 ;        [D]  - Include deleted artifact
 ;   
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status^^IEN - IEN of the Artifact
 ; 
GETAIENT(MAGRY,TOKEN,FLAGS) ;
 I $G(TOKEN)="" S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Token is empty." Q
 N FILE,IEN,DELAPP
 S FILE=2006.916
 ; Get TOKEN IEN 
 S IEN=$O(^MAGV(FILE,"B",TOKEN,""))
 I IEN="" S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Token not found." Q
 I FLAGS["D" S MAGRY=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_IEN Q
 ;
 ; Check whether Artifact is deleted
 S DELAPP=$$GET1^DIQ(FILE,IEN_",","DELETING APPLICATION","I")
 I $$ISAFTDEL^MAGVAG02(IEN) S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"ARTIFACT TOKEN "_TOKEN_" is deleted" Q
 S MAGRY=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_IEN Q
 Q
 ; -- Is Artifact deleted
 ;
 ; Input parameters
 ; ================
 ; IEN = IEN in ARTIFACT file (#2006.916)
 ;   
 ; Return Values
 ; =============
 ; 1 - artifact is deleted
 ; 0 - artifact is not deleted
 ; 
ISAFTDEL(IEN) ; Is Artifact deleted
 N DELAPP
 ; Check whether Artifact is deleted
 S DELAPP=$$GET1^DIQ(2006.916,IEN_",","DELETING APPLICATION","I")
 Q DELAPP'=""
 ;
 ;*****  Get artifact values with key list and artifact instance
 ;       from ARTIFACT file (#2006.916)
 ;       & ARTIFACT KEYLIST file (#2006.913) and ARTIFACT INSTANCE file (#2006.918)
 ;       by artifact KEYLIST
 ;       
 ; RPC:MAGVA GET A W KL AND AIS BY KL
 ; 
 ; Input Parameters
 ; ================
 ; KLIST(1) = First level Key
 ; KLIST(2) = Second level Key
 ;   ...
 ; KLIST(N) = N-th level Key
 ;
 ; Any level is optional
 ;  
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(1..n) XML based result in format
 ;            <?xml version="1.0" encoding="utf-8"?>
 ;            <artifacts>
 ;              <artifact
 ;                id=""
 ;                token=""
 ;                size=""
 ;                keyListFK=""
 ;                createdDateTime=""
 ;                lastAccessDateTime=""
 ;                crc="">
 ;                <keys>
 ;                  <key kvalue="" klevel="" />
 ;                   ...
 ;                  <key kvalue="" klevel="" />
 ;                </keys>
 ;                <artifact Instances>
 ;                 <artifact Instance>
 ;                 ....
 ;                 <artifact Instance>
 ;                </artifact Instances>
 ;              </artifact>
 ;              ...
 ;            </artifacts>
 ;  
GAKLAISK(MAGRY,KLIST) ;  RPC [MAGVA GET A W KL AND AIS BY KL]
 K MAGRY
 N KLIENS,ARTIFACT
 N FILE,IEN,AIEN,J,CNT,START,OUT,ERR,ERR2,MAGRESA
 S FILE=2006.916  ; ARTIFACT file
 D FINDKEYS^MAGVAKL1(.KLIENS,.KLIST)  ; Get a list with IENs that meets the KLIST values
 I '$$ISOK^MAGVAF02(KLIENS(0)) S MAGRY(0)=KLIENS(0) Q  ; Error found
 K KLIENS(0)  ; Delete result internal info
 S START=2 ; populate MAGRY starting with node 2
 S IEN=""
 S ERR2=0
 S CNT=0
 S (MAGRY(1),MAGRY(2))=""  ; place holders
 F  Q:ERR2  S IEN=$O(KLIENS(IEN)) Q:IEN=""  D
 . K OUT,ERR
 . D FIND^DIC(FILE,"","@","QX",IEN,"","KL","","","OUT","ERR")  ; 
 . I $D(ERR("DIERR")) D  Q
 . . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting token IEN: "_MAGRESA(1) Q  ; Error getting the IEN
 . . S ERR2=1
 . . Q
 . K ARTIFACT
 . S J=""
 . F  S J=$O(OUT("DILIST","2",J)) Q:J=""  D
 . . S AIEN=OUT("DILIST","2",J)
 . . Q:$$ISAFTDEL^MAGVAG02(AIEN)  ; skip deleted artifact
 . . D GAFTBYID^MAGVAG04(.ARTIFACT,AIEN,START,"KI")  ; Get the artifact with KeyList & Artifact Instance
 . . I '$$ISOK^MAGVAF02(ARTIFACT(0)) D  Q  ; error found - quit 
 . . . K MAGRY
 . . . S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting artifact " Q  ; Error getting the values
 . . . S ERR2=1
 . . . Q
 . . K ARTIFACT(0)  ; delete zero node record - it is for information only
 . . S CNT=$$APP2ARR^MAGVAF04(.MAGRY,.ARTIFACT)  ; Append ARTIFACT to result
 . . Q
 . Q
 I 'CNT D  Q  ; No records found. Make an empty result and quit
 . D EMPTYXML^MAGVAF03(.MAGRY,FILE)
 . Q
 ;
 S MAGRY(0)=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_CNT
 D SETFTUCH^MAGVAF03(.MAGRY) ; set line 1 and two and the last one
 Q
