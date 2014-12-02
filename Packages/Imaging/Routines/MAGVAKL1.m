MAGVAKL1 ;WOIFO/NST - Key List File Utilities  ; 20 Feb 2012 3:56 PM
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
 ;***** Return a KEY IEN that meets the keys provided
 ;
 ; Input parameters
 ; ================
 ; KLIST(1) = First level Key
 ; KLIST(2) = Second level Key
 ;   ...
 ; KLIST(N) = N-th level Key
 ; The assumption is that we will get the full keys list
 ; so we should find only one KEY IEN or we will not find any
 ; 
 ; Return Value
 ; ============ 
 ;
 ; if no key list IEN found returns 0
 ; if key list found returns IEN of the ARTIFACT KEYLIST file (#2006.913) record
 ;        
GETKLIEN(KLIST) ;
 N RES
 D FINDKEYS^MAGVAKL1(.RES,.KLIST)
 I '$$ISOK^MAGVAF02(RES(0)) Q 0  ; Error found
 Q $O(RES(0))  ; get the IEN. It should be only one IEN
 ;
 ;***** Return a key list IEN that meet the keys provided
 ;      It creates a new record in ARTIFACT KEYLIST file (#2006.913) if the key list is not found
 ;
 ; Input parameters
 ; ================
 ; KLIST(1) = First level Key
 ; KLIST(2) = Second level Key
 ;   ...
 ; KLIST(N) = N-th level Key
 ; The assumption is that we will get the full keys list
 ; so we should find only one KEY IEN or we will not find any
 ; 
 ; Return Values
 ; ============= 
 ;
 ; if error MAGRY = Failure status^Error message
 ; if success MAGRY = Success status^^IEN of the record in ARTIFACT KEYLIST file (#2006.913)
 ;     
GETKLFK(MAGRY,KLIST) ;
 ; if KLIST is empty just return success and set the IEN to ""
 ; Key list is optional in ARTIFACT file (#2006.916) that's why empty key list is OK
 ; ADDKL^MAGVAKL1 reports error if KLIST is empty
 K MAGRY
 I $O(KLIST(""))="" S MAGRY=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_"" Q
 ; try to find or create a new key list record
 D ADDKL^MAGVAKL1(.MAGRY,.KLIST)
 Q
 ;
 ;***** Return a list with all keys IENS in ARTIFACT KEYLIST file (#2006.913)
 ;      that meet the keys provided
 ;      
 ; RPC: MAGVA FIND KEYLIST
 ;
 ; Input Parameters
 ; ===============
 ; KLIST(1) = First Key
 ; KLIST(2) = Second Key
 ;   ...
 ; KLIST(N) = N-th Key
 ;
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message^
 ; if success MAGRY(0) = Success status
 ;            MAGRY(n) = IEN of the record in ARTIFACT KEYLIST file (#2006.913) that matches the request
 ;                  n same as IEN
 ;            
FINDKEYS(MAGRY,KLIST) ; RPC [MAGVA FIND KEYLIST]
 N KEY,KEYSIEN,COUNT,LEVEL,FOUND
 K MAGRY
 ; Search for keys using IDXKEYS index by DEPTH and KEY.
 ; Store the KEYIEN into array and count the number
 ; of hits by KEYSIEN
 S COUNT=0  ; How many individual KEYS are requested
 S LEVEL=""
 F  S LEVEL=$O(KLIST(LEVEL)) Q:LEVEL=""  D
 . S KEY=KLIST(LEVEL)
 . S COUNT=COUNT+1
 . S KEYSIEN=""
 . F  S KEYSIEN=$O(^MAGV(2006.913,"IDXKEYS",LEVEL,KEY,KEYSIEN)) Q:KEYSIEN=""  D
 . . S FOUND(KEYSIEN)=$G(FOUND(KEYSIEN))+1
 . . Q
 . Q
 ; Check for any KEYSIEN that has as many hits as requested number of keys
 S KEYSIEN=""
 F  S KEYSIEN=$O(FOUND(KEYSIEN)) Q:KEYSIEN=""  D
 . I FOUND(KEYSIEN)=COUNT S MAGRY(KEYSIEN)=KEYSIEN
 . Q
 S MAGRY(0)=$$OK^MAGVAF02()
 Q
 ;
 ;***** Add new KEY PAIRS to ARTIFACT KEYLIST file (#2006.913)
 ; RPC: MAGVA ADD KEYLIST
 ;
 ; Input Parameters
 ; ================
 ;  KLIST(1) = First level Key
 ;  KLIST(2) = Second level Key
 ;   ...
 ;  KLIST(N) = N-th level Key
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status^Error
 ; if success MAGRY = Success status^^IEN - IEN of the added record
 ;
ADDKL(MAGRY,KLIST) ; RPC [MAGVA ADD KEYLIST]
 ;
 K MAGRY
 ; Quit error if key list is empty
 I $O(KLIST(""))="" S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"KEYLIST is empty" Q
 ;
 N DEPTH,I,IENS,IEN,MAGDA,MAGNFDA,MAGNIEN,MAGNXE,ERR
 S IEN=+$$GETKLIEN^MAGVAKL1(.KLIST)
 I IEN S MAGRY=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_IEN  Q  ; The Key list is already on file
 ; The Key List is not found. Add a new record to save all values
 S I=""
 S DEPTH=0
 F  S I=$O(KLIST(I)) Q:I=""  S DEPTH=DEPTH+1
 ;
 S MAGNFDA(2006.913,"+1,",.01)=DEPTH
 D UPDATE^DIE("","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error adding a key list" Q
 ;
 S MAGDA=MAGNIEN(1)
 S IENS="+1,"_MAGDA_","
 S ERR=0
 S I=""
 F  S I=$O(KLIST(I)) Q:I=""  D  Q:ERR
 . K MAGNFDA,MAGNIEN,MAGNXE
 . S MAGNFDA(2006.9132,IENS,.01)=KLIST(I)
 . S MAGNFDA(2006.9132,IENS,2)=I
 . D UPDATE^DIE("","MAGNFDA","MAGNIEN","MAGNXE")
 . I $D(MAGNXE("DIERR","E")) D
 . . N DIK,DA
 . . S ERR=1
 . . S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error adding a new key pair."
 . . ; clean up data
 . . S DA=MAGDA
 . . S DIK=$$GETFILGL^MAGVAF01(2006.913)
 . . D ^DIK
 . . Q
 . Q
 I ERR Q  ; Exit the routine. MAGRY is set already
 S MAGRY=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_MAGDA
 Q
 ;
 ;***** Returns a key list by IEN in ARTIFACT KEYLIST file (#2006.913)
 ; RPC: MAGVA GET KEYLIST
 ;
 ; Input Parameters
 ; ================
 ;  MAGDA = IEN in ARTIFACT KEYLIST file (#2006.913)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status^Error message
 ; if success
 ;  MAGRY(0) = Success status^^Number of key list depth       
 ;  MAGRY(1) = Level one Key
 ;  MAGRY(2) = Level two Key
 ;   ...
 ;  MAGRY(N) = Level N-th Key
 ;        
GETKL(MAGRY,MAGDA) ; RPC [MAGVA GET KEYLIST]
 N OUT,ERR,MAGRESA
 N I,CNT,X
 K MAGRY
 ; --- .01 KLEVEL; 2 KVALUE  
 D LIST^DIC(2006.9132,","_MAGDA_",","@;.01;2","P","","","","","","","OUT","ERR")
 I $D(ERR("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting the list: "_MAGRESA(1) Q  ; Error getting the list
 S I=0
 S CNT=0
 F  S I=$O(OUT("DILIST",I)) Q:'+I  D
 . S X=OUT("DILIST",I,0)
 . S CNT=CNT+1
 . S MAGRY($P(X,"^",3))=$P(X,"^",2)
 . Q
 S MAGRY(0)=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_CNT
 Q
 ;
 ;***** Delete a record in ARTIFACT KEYLIST file (#2006.913) by IEN
 ; RPC: MAGVA DELETE KEYLIST
 ;
 ; Input Parameters
 ; ================
 ;  MAGDA = IEN in ARTIFACT KEYLIST file (#2006.913)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status
 ;
DELKL(MAGRY,MAGDA) ; RPC [MAGVA DELETE KEYLIST]
 N DIK,DA
 S DA=MAGDA
 S DIK=$$GETFILGL^MAGVAF01(2006.913)
 D ^DIK
 S MAGRY=$$OK^MAGVAF02()
 Q
