RAHLTCPU ; HIRMFO/GJC,SG - Rad/Nuc Med HL7 TCP/IP Bridge utilities;10/10/07
 ;;5.0;Radiology/Nuclear Medicine;**84,94**;Mar 16, 1998;Build 9
 ;
LOCKX(RAERR,UNLOCK) ;lock/unlock the Rad/Nuc Med Patient record at one of two levels:
 ;If part of a printset (RAY3(25)=2) lock at the "DT" level
 ;Else lock at the "P" or case level
 ;Input: RADFN, RADTI, & RACNI are all assumed to be defined.
 ;       UNLOCK: if defined the function unlocks the encounter at the appropriate level
 ;Returns: RAERR (lock attempt only) if $D(RAERR)#2 lock failed, else lock successful
 N RANODE,RAY3 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),RAY3(25)=$P(RAY3,U,25)
 S RANODE=$S(RAY3(25)=2:$NA(^RADPT(RADFN,"DT",RADTI)),1:$NA(^RADPT(RADFN,"DT",RADTI,"P",RACNI)))
 I $G(UNLOCK)=1 L -@RANODE Q
 L +@RANODE:DILOCKTM E  S RAERR=$S(RAY3(25)=2:"Encounter",1:"Accession")_" locked within VistA"
 Q
 ;
LOCKR(RAERR) ;lock/unlock the report associated with an exam record/
 ;Input: RARPT is assumed to be defined
 ;Return: RAERR will be set if the lock attempt failed, else RAERR will not be defined
 I $D(RARPT)#2,($D(^RARPT(RARPT,0))#2) D
 .D LOCK^DILF($NA(^RARPT(RARPT))) ;$T=1 if lock attained, else 0
 .S:'$T RAERR="Report: "_$P($G(^RARPT(RARPT,0)),U)_" locked within VistA Radiology" Q
 E  S RAERR="The report record '"_$G(RARPT,"<UNDEFINED> RARPT")_"' is non-existent."
 Q
 ;
 ;
 ;##### ALLOCATES A NEW RECORD IN THE RAD/NUC MED REPORTS FILE (#74) AND LOCKS IT
 ; 
 ; Return Values
 ; =============
 ;           >0  IEN for the new record in the RAD/NUC MED REPORTS FILE (#74)
 ;
 ; Notes
 ; =====
 ;
 ; The placeholder for the new record (^RARPT(IEN) node) is LOCKed 
 ; by this function. It is responsibility of the caller to unlock the 
 ; record after it is created or the record creation is canceled.
 ;
NEWIEN() ;
 N IEN,NEWIEN,NODE
 S NEWIEN=0
 ;---
 F  D  Q:NEWIEN
 . S IEN=$O(^RARPT(" "),-1)+1
 . ;--- If the record already exists, skip it
 . S NODE=$NA(^RARPT(IEN))  Q:$D(@NODE)
 . ;--- Lock the placeholder in order to make sure that nobody
 . ;--- else is trying to allocate it at the same time.
 . D LOCK^DILF(NODE)  E  Q
 . ;--- Double check that the record has not been created after the
 . ;--- previous $D() check and the LOCK command (a race condition)
 . I $D(@NODE)  L -@NODE  Q
 . ;--- Success
 . S NEWIEN=IEN
 . Q
 ;---
 Q NEWIEN
