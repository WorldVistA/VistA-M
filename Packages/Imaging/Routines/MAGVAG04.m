MAGVAG04 ;WOIFO/NST - Utilities for RPC calls ; 13 Feb 2012 4:21 PM
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
 ;       ARTIFACT KEYLIST file (#2006.913) and ARTIFACT INSTANCE file (#2006.918)
 ;       and Artifact Retention Policies (#2006.921)
 ;       and Artifact Retention Policies Fulfillment (#2006.922)
 ;       by IEN
 ;       
 ; Input Parameters
 ; ================
 ; 
 ; IEN = Artifact IEN
 ; CNT = populate MAGRY starting with node CNT 
 ; FLAGS = To identify the type of detail to return
 ; 
 ;        I = Include Artifact Instance records
 ;        R = Include Artifact Retention Policies 
 ;            and Artifact Retention Policies Fulfillment
 ;  
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(1..n) XML based result in format
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
 ;               <artifact Instances>
 ;                <artifact Instance>
 ;                ....
 ;                <artifact Instance>
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
 ;  
GAFTBYID(MAGRY,IEN,CNT,FLAGS) ; 
 K MAGRY
 I IEN="" S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"IEN is required." Q
 ; 
 N I,X,OUT,ERR,MAGRESA
 N FILE,FILENM,FLDFKID
 N IENS
 N FLDSARR,FLDSARRW,FIELDS
 N KLFILE,KLFKID,KEYS,KLFLDID,KLIEN
 N TMPARR
 N QT
 S QT=$C(34) ; "
 S FILE=2006.916     ; ARTIFACT file number
 S FILENM=$TR($$GETFILNM^MAGVAF01(FILE)," ")  ; File name without blanks
 S FIELDS=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,FILE) ; ARTIFACT file fields names
 S FLDFKID=$$GETFLDID^MAGVAF01(FILE,"KEYLIST")  ; KEYLIST field number 
 ;
 S IENS=IEN_","
 D GETS^DIQ(FILE,IENS,FIELDS,"I","OUT","ERR")  ; get ARTIFACT record values
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting values: "_MAGRESA(1) Q  ; Error getting the values
 . Q
 ;
 S CNT=CNT+1,MAGRY(CNT)="<"_FILENM
 S CNT=CNT+1,MAGRY(CNT)="PK="_QT_IEN_QT
 S I=""
 F  S I=$O(OUT(FILE,IENS,I)) Q:I=""  D
 . I $$ISFLDDT^MAGVAF01(FILE,I) S X=$$FM2IDF^MAGVAF01(OUT(FILE,IENS,I,"I"))  ; the field is Date type - convert to IDF format
 . E  S X=OUT(FILE,IENS,I,"I")
 . S CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARR(I)," /\<>&%")_"="_QT_X_QT  ; need to check for date format
 . Q
 S MAGRY(CNT)=MAGRY(CNT)_" >"
 ;
 ; Get the KEYLIST values
 S KLFILE=2006.913   ; KEYLIST file number
 S KLFLDID=$$GETFLDID^MAGVAF01(KLFILE,"KEY")  ; KEYLIST field number 
 ; KEYLIST is optional in ARTIFACT file (#2006.916) so check for blank
 S KLIEN=$S(OUT(FILE,IENS,FLDFKID,"I")="":"",1:OUT(FILE,IENS,FLDFKID,"I")_",")
 D GETMVAL^MAGVAF03(.KEYS,KLFILE,KLFLDID,OUT(FILE,IENS,FLDFKID,"I")_",") ; KEY LIST file KLFILE, field KEY KLFKID
 I '$$ISOK^MAGVAF02(KEYS(0)) D  Q  ; error found - quit 
 . K MAGRY
 . S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting artifact " Q  ; Error getting the values
 . Q
 K KEYS(0)  ; delete zero node record - it is for information only
 S CNT=$$APP2ARR^MAGVAF04(.MAGRY,.KEYS)  ; Append KEYLIST to result
 ;
 K ERR,TMPARR
 S ERR=0
 I FLAGS["I" D  ; Get Artifact Instance 
 . D GETAINST^MAGVAG04(.TMPARR,IEN)
 . I '$$ISOK^MAGVAF02(TMPARR(0)) D
 . . K MAGRY
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting artifact instance " ; Error getting the values
 . . S ERR=1
 . . Q
 . I ERR Q  ; error found - quit 
 . K TMPARR(0)  ; delete zero node record - it is for information only
 . S CNT=$$APP2ARR^MAGVAF04(.MAGRY,.TMPARR) ; Append Artifact instances to result
 . Q
 I ERR Q
 ;
 K ERR,TMPARR
 S ERR=0
 I FLAGS["R" D  ; Get Artifact Retention Policies & Artifact Retention Policies Fulfillment 
 . D GETARP^MAGVAG04(.TMPARR,IEN)
 . I '$$ISOK^MAGVAF02(TMPARR(0)) D
 . . K MAGRY
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting artifact instance " ; Error getting the values
 . . S ERR=1
 . . Q
 . I ERR Q  ; error found - quit 
 . K TMPARR(0)  ; delete zero node record - it is for information only
 . S CNT=$$APP2ARR^MAGVAF04(.MAGRY,.TMPARR) ; Append Artifact Retention Policies  to result
 . Q
 I ERR Q
 ;
 S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_">"
 S MAGRY(0)=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_CNT
 Q FILENM
 ;
 ; ----- Get Artifact Instance from ARTIFACT INSTANCE  file (#2006.918)
 ;       by Artifact IEN in XML based format
 ;       
 ; Input Parameters
 ; ================
 ; IEN = Artifact IEN
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ; MAGRY(1..n) XML based result in format
 ;   <artifact Instances>
 ;     <artifact Instance>
 ;     ...
 ;     <artifact Instance>
 ;   </artifact Instances>
 ;
GETAINST(MAGRY,IEN) ;
 N FILE,IENS
 S FILE=2006.918
 S IENS=""
 D GXMLBYID^MAGVAF03(.MAGRY,FILE,IENS,IEN,1)
 Q
 ;
 ; ----- Get Artifact Retention Policy file (#2006.921)
 ;       & Artifact Retention Policy Fulfillment file (#2006.922)
 ;       by Artifact IEN in XML based format
 ;
 ; Input Parameters
 ; ================
 ; VAL = Artifact IEN
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(1..n) XML based result in format
 ;            <artifactRetentionpolicys>
 ;             <artifactRetentionpolicy>
 ;              <artifactRetention policyfulfillments>
 ;                <artifactRetentionpolicyfulfillment>
 ;                   ...
 ;                <artifactRetentionpolicyfulfillment>
 ;                 ...
 ;               </artifactRetention policy fulfillments>
 ;             </artifactRetentionpolicy>
 ;             ...
 ;            <artifactRetentionpolicys>
 ; 
GETARP(MAGRY,VAL) ;
 N FILE,FIELDS,FLDSARR,FLDSARRW,FILENM
 N TMPARR,OUT,ERR,MAGRESA
 N I,J,X,IENS,ERRFLG,CNT
 N QT,RESDEL
 K MAGRY
 S RESDEL=$$RESDEL^MAGVAF02()
 S QT=$C(34) ; "
 S FILE=2006.921  ; Artifact Retention Policy
 S FILENM=$TR($$GETFILNM^MAGVAF01(FILE)," ") ; File name without blank
 S FIELDS=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,FILE,"I") ; file fields names
 S IENS=""
 D FIND^DIC(FILE,IENS,"@;"_FIELDS,"BQX",VAL,"","","","","OUT","ERR")
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting values: "_MAGRESA(1) Q  ; Error getting the list
 . Q
 ; Output the data
 S CNT=0
 S CNT=CNT+1,MAGRY(CNT)="<"_FILENM_"S>"
 S I=""  ; IENs
 S J=""  ; Fields in the file
 S ERRFLG=0
 F  Q:ERRFLG  S I=$O(OUT("DILIST","ID",I)) Q:I=""  D
 . S CNT=CNT+1,MAGRY(CNT)="<"_FILENM
 . S CNT=CNT+1,MAGRY(CNT)="PK="_QT_OUT("DILIST",2,I)_QT
 . S J=""
 . F  S J=$O(OUT("DILIST","ID",I,J)) Q:J=""  D
 . . S X=OUT("DILIST","ID",I,J)
 . . I $$ISFLDDT^MAGVAF01(FILE,J) S X=$$FM2IDF^MAGVAF01(X)  ; the field is Date type - convert to IDF format
 . . S CNT=CNT+1,MAGRY(CNT)=$TR(FLDSARR(J)," /\<>&%")_"="_QT_X_QT
 . . Q
 . S MAGRY(CNT)=MAGRY(CNT)_" >"
 . ; Get Retention Policy Fulfillment
 . K TMPARR
 . D GXMLBYID^MAGVAF03(.TMPARR,2006.922,"",OUT("DILIST",2,I),1)
 . I '$$ISOK^MAGVAF02(TMPARR(0)) D  Q  ; error found - quit 
 . . K MAGRY
 . . S MAGRY(0)=$$FAILED^MAGVAF02()_RESDEL_"Error getting artifact " Q  ; Error getting the values
 . . S ERRFLG=1
 . . Q
 . K TMPARR(0)  ; delete zero node record - it is for information only
 . S CNT=$$APP2ARR^MAGVAF04(.MAGRY,.TMPARR)  ; Append Retention Policy Fulfillment to result
 . S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_" >"
 . Q
 S CNT=CNT+1,MAGRY(CNT)="</"_FILENM_"S>"
 S MAGRY(0)=$$OK^MAGVAF02()_RESDEL_RESDEL_CNT
 Q
