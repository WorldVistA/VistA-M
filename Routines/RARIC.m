RARIC ;HISC/FPT,GJC AISC/SAW-Radiologic Image Capture and Display Routine ;08/05/08  14:35
 ;;5.0;Radiology/Nuclear Medicine;**23,27,101**;Mar 16, 1998;Build 4
 ;
 ;In response to: Remedy #330689 (Tucson); PSPO 1460
 ;
 ;Supported IA #2053 FILE/UPDATE^DIE
 ;Supported IA #2054 LOCK^DILF
 ;Supported IA #10103 $$NOW^XLFDT
 ;
CREATE ; >>create new stub entry in file 74<<
 ; --------------------------------------------------------------------
 ; called from ^MAGDIR9A (the value of RARPT is currently null)
 ; If no report entry is created, RARPT will remain null
 ;
 ;input variables
 ; RADTE - ext. date/time of exam, RADFN - patient DFN,
 ; RADTI - int. date/time of exam), RACN - case number &
 ; RACNI - IEN of case record
 ;
 ;output variables
 ; RARPT - IEN of the report: null if error; or positive
 ;
 ; lock the exam node; quit if the lock fails
 S RARPT="" S U=$G(U,"^")
 L +^RADPT(RADFN,"DT",RADTI,"P",RACNI,0):1E9
 ;
 ; Set RAY2 to the REGISTERED EXAMS node.
 ; Set RAY3 to the EXAMINATIONS node.
 N RAY2,RAY3 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ;
 ;
 ; 1 - If the Imaging value of the case number does not match
 ; the case number on disk quit.  2 - Quit if the exam was purged.
 ; =================================================================
 I $P(RAY3,U)'=RACN D UNLOCXAM Q  ; - 1
 I $P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PURGE")),U)>0 D UNLOCXAM Q  ; - 2
 ;
 ;
 ; If a report was created for this case while waiting
 ; to access the exam node (timeout) set RARPT, unlock
 ; the exam node & exit (XIT).
 ; =================================================================
 S RARPT=$P(RAY3,U,17)
 I RARPT D UNLOCXAM Q
 ;
 ;
 ; Create the accession number. The format may be that 
 ; of the legacy accession or it may be (w/p47) a site
 ; specific accession (SSAN). Check if patch RA*5.0*47
 ; has been installed.
 ;
 ; Because we entered the Radiology application through
 ; a foreign source the following package wide Radiology
 ; variables must be defined: RAMDIV & RAMDV
 ; =================================================================
 N RACESION,RAMDIV,RAMDV
 S RAMDIV=+$P(RAY2,U,3),RAMDV=$S($D(^RA(79,RAMDIV,.1)):^(.1),1:"")
 I $P(RAY3,U,31)'="" D  ; use SSAN
 .S RACESION=$P(RAY3,U,31)
 .Q
 ; else use the legacy accession
 E  S RACESION=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN
 ;
 ;
 N RA1,RAERR,RAFDA,RAFDAIEN,RAIEN,RAPRTSET,RAMEMARR,RATXT,RAX,RAXIT,RAY
 ;
 ; Check if this case is part of a print set.
 ; =================================================================
 ; D EN2^RAUTL20(.RAMEMARR) is a silent call!
 ; RAMEMARR = # of descendents
 ; RAMEMARR(n)=case #^procedure IEN^report text IEN^exam status IEN
 ; (where 'n' is RACNI)
 ; If printset RAPRTSET=1, else RAPRTSET=0
 D EN2^RAUTL20(.RAMEMARR) ; is this case part of a print set ?
 ;
 ;
 ; Find the next available RAD/NUC MED REPORTS IEN, lock that record
 ; & file the report specific data into that new report record.
 ; =================================================================
 S RAFDAIEN(1)=$$NEWIEN()
 ;
 ;  ** Note: ^RARPT(RAFDAIEN(1)) is locked; it is up to  **
 ;  ** YOU to unlock the record before the process quits **
 ;
 S RAY="+1",RAX="RAFDA(74,"""_RAY_","")"
 S @RAX@(.01)=RACESION
 S @RAX@(2)=RADFN
 S @RAX@(3)=(9999999.9999-RADTI)
 S @RAX@(4)=RACN
 S @RAX@(6)=DT
 ;
 ;The filing of report text is no longer required.
 ;K RATXT("RPT") S RATXT("RPT",1)="Images collected."
 ;S @RAX@(200)="RATXT(""RPT"")"
 ;
 ; Create the Activity Log (74.01) sub-file record.
 S RAX="RAFDA(74.01,""+2,"_RAY_","")"
 S @RAX@(.01)=$$NOW^XLFDT()
 S @RAX@(2)=$S($D(RAESIG)#2:"V",1:"C")
 S @RAX@(3)=$S($G(RAVERF):RAVERF,1:DUZ)
 D UPDATE^DIE("","RAFDA","RAFDAIEN","RAERR")
 ;
 ;
 ; If there happened to be an error when calling UPDATE^DIE
 ; kill off the stub report record.
 ; =================================================================
 I $D(RAERR("DIERR"))#2,($D(^RARPT(RAFDAIEN(1),0))#2) D  D XIT Q
 .D DELRPT(RAFDAIEN(1)) ;note: RARPT is null
 .QUIT
 ;
 ;
 ;
 ; ** 70.03 - set report text field in the EXAMINATIONS node - 70.03 **
 ; ** 70.03 -           locked at the top of RARIC           - 70.03 ** 
 ; =================================================================
 K RAERR,RAFDA,RAIEN,RATXT
 ;
 S RAIEN=RACNI_","_RADTI_","_RADFN_","
 S RAFDA(70.03,RAIEN,17)=RAFDAIEN(1)
 D FILE^DIE("","RAFDA","RAERR")
 ;
 ; the REPORT TEXT field was not set correctly
 I $D(RAERR("DIERR"))#2 D DELRPT(RAFDAIEN(1)) D XIT Q
 ;
 ;
 ;the report record has been created, set RARPT = RAFDAIEN(1)
 S RARPT=RAFDAIEN(1)
 ;
 ;
 ; create a var RARIC to suppress display of info msg from PTR^RARTE2
 ; PTR^RARTE2 requires that RARPT the IEN of an existing report record.
 ; =================================================================
 N RARPTN S RARPTN=$P(^RARPT(RARPT,0),U)
 I RAPRTSET N RARIC S RARIC=1 D PTR^RARTE2
 ; don't have to check raxit, since we're quitting now
 ;
 ;
XIT ;exit the CREATE subroutine
 ; =================================================================
 ;Unlock the case node & unlock the report.
 D UNLOCXAM L -^RARPT(RAFDAIEN(1))
 QUIT
 ;
 ;
PTR ; associate images with a radiology report record
 ; --------------------------------------------------------------------
 ;
 ; input:   RARPT - IEN of Rad/NM Report file #74
 ;          MAGGP - IEN of record in file 2005 pointed to by a report
 ;
 ; returns: Y=0  - variable MAGGP does not exist
 ;          Y=-1 - FileMan could not create an entry
 ;          Y>0  - FileMan created an entry
 ;
 S Y=0 Q:$G(MAGGP)'>0
 L +^RARPT(RARPT):$G(DILOCKTM,5)
 I '$T S Y=-1 Q  ;lock failed...
 N RAFDA,RAIEN,RARSLT
 S RAFDA(74.02005,"+1,"_RARPT_",",.01)=MAGGP
 D UPDATE^DIE(,"RAFDA","RAIEN","RARSLT")
 I $D(RARSLT("DIERR"))#2 D
 .S Y=-1 ;RAIEN(1) undef
 .QUIT
 E  I RAIEN(1)>0 S Y=RAIEN(1)
 L -^RARPT(RARPT)
 QUIT
 ;
 ;
DELRPT(Y) ; delete a report (RARIC). The report record should
 ;be locked by the software calling this function.
 ; --------------------------------------------------------------------
 ; Input: Y = the IEN of the report record
 ;
 K RAERR,RAFDA S RAFDA(74,Y_",",.01)="@"
 D FILE^DIE("","RAFDA","RAERR") K RAERR,RAFDA
 Q
 ;
 ;
NEWIEN() ; ##### ALLOCATES A NEW RECORD IN THE RAD/NUC MED REPORTS FILE
 ;         (#74) AND LOCKS IT
 ; --------------------------------------------------------------------
 ; Return Values
 ; =============
 ; >0  IEN for the new record in the RAD/NUC MED REPORTS FILE (#74)
 ;
 ; Notes
 ; =====
 ;
 ; The placeholder for the new record (^RARPT(IEN) node) is LOCKed 
 ; by this function. It is responsibility of the caller to unlock the 
 ; record after it is created or the record creation is canceled.
 ;
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
 ;
 ;
UNLOCXAM ;Unlock the EXAMINATION node locked by this process.
 ; --------------------------------------------------------------------
 L -^RADPT(RADFN,"DT",RADTI,"P",RACNI,0) QUIT
 ;
