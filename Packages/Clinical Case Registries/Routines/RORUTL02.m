RORUTL02 ;HCIOFO/SG - UTILITIES  ;8/25/05 10:20am
 ;;1.5;CLINICAL CASE REGISTRIES;**21,27**;Feb 17, 2006;Build 58
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*27   FEB 2015    T KOPP       Changed LOCKREG entry point to loop thru
 ;                                      registries to lock only 15 at a time to
 ;                                      prevent maxstring errors when lock
 ;                                      command is executed.
 ;
 ;******************************************************************************
 ;
 ; This routine uses the following IAs:
 ;
 ; #2701         $$GETICN^MPIF001 Gets ICN (supported)
 ;               $$IFLOCAL^MPIF001 (checks for local ICN) (supported)
 ; #3556         $$GCPR^LA7QRY
 ; #3557         Access to the field .01 and x-ref "B"
 ;               of the file 95.3
 ; #3646         $$EMPL^DGSEC4
 ; #10035        Access to the field #.09 of the file #2
 ;
 Q
 ;
 ;***** REMOVES THE INACTIVE REGISTRIES FROM THE LIST
 ;
 ; .REGLST(      A list of registry names (as subscripts)
 ;   RegName)    Registry IEN (output)
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; This function removes names of those registries that are
 ; inactive or cannot be updated for any other reasons from
 ; the list. It also associates registry IENs with the names
 ; of registries remaining on the list.
 ;
 ; Moreover, it records corresponding messages about skipped
 ; registries to the current open log.
 ;
ARLST(REGLST) ;
 N INFO,RC,REGIEN,REGNAME,RORBUF,TMP  K DSTLST
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . S REGIEN=$$REGIEN(REGNAME,"@;11I;21.05I",.RORBUF)
 . ;--- Cannot find (or load) the registry parameters
 . I REGIEN'>0  D  Q
 . . D ERROR^RORERR(REGIEN,,REGNAME)
 . . K REGLST(REGNAME)
 . ;--- Check if the registry is marked as 'inactive'
 . I $G(RORBUF("DILIST","ID",1,11))  D  Q
 . . D ERROR^RORERR(-48,,,,REGNAME)
 . . K REGLST(REGNAME)
 . ;--- Check if the registry has not been populated
 . I '$G(RORBUF("DILIST","ID",1,21.05)),'$G(RORPARM("SETUP"))  D  Q
 . . D TEXT^RORTXT(7980000.02,.INFO)
 . . D ERROR^RORERR(-103,,.INFO,,REGNAME)
 . . K INFO,REGLST(REGNAME)
 . ;--- Store the registry IEN
 . S REGLST(REGNAME)=REGIEN
 Q RC
 ;
 ;***** RETURNS A FULL NATIONAL ICN OF THE PATIENT
 ;
 ; PTIEN         Patient IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  ICN has not been assigned or ICN is a local ICN
 ;       >0  Patient National ICN
 ;
ICN(PTIEN) ;
 N ICN,L,TMP
 I $$IFLOCAL^MPIF001(PTIEN) Q ""
 S ICN=$$GETICN^MPIF001(PTIEN)
 I ICN'>0  D  Q ""
 . S TMP=$$ERROR^RORERR(-57,,$P(ICN,U,2),PTIEN,+ICN,"$$GETICN^MPIF001")
 ;--- Validate the checksum (just in case ;-)
 S L=$L($P(ICN,"V",2))
 Q $S(L<6:$P(ICN,"V")_"V"_$E("000000",1,6-L)_$P(ICN,"V",2),1:ICN)
 ;
 ;***** LOADS THE LAB RESULTS
 ;
 ; PTIEN         Patient IEN
 ;
 ; SDT           Start date of the results
 ; EDT           End date of the results
 ;
 ; [ROR8DST]     Closed root of the destination array
 ;               (the ^TMP("RORTMP",$J) node, by default)
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
LABRSLTS(PTIEN,SDT,EDT,ROR8DST) ;
 N H7CH,RC,RORMSG,TMP
 S:$G(ROR8DST)="" ROR8DST=$NA(^TMP("RORTMP",$J))
 K @ROR8DST
 I $D(RORLRC)<10  Q:$G(RORLRC)="" 0
 ;--- Get the Patient ID (ICN or SSN)
 S PTID=$$PTID(PTIEN)  Q:PTID<0 PTID
 ;--- Get the Lab data
 S H7CH=$G(RORHL("FS"))_$G(RORHL("ECH"))
 S RC=$$GCPR^LA7QRY(PTID,SDT,EDT,.RORLRC,"*",.RORMSG,ROR8DST,H7CH)
 I RC="",$D(RORMSG)>1  D
 . N ERR,I,LST
 . S (ERR,LST)=""
 . F I=1:1  S ERR=$O(RORMSG(ERR))  Q:ERR=""  D
 . . S LST=LST_","_ERR,TMP=RORMSG(ERR)
 . . K RORMSG(ERR)  S RORMSG(I)=TMP
 . S LST=$P(LST,",",2,999)  Q:(LST=3)!(LST=99)
 . S RC=$$ERROR^RORERR(-27,,.RORMSG,PTIEN)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS THE LOINC CODE WITH THE CONTROL DIGIT
 ;
 ; LNCODE        LOINC code
 ;
 ; Besides adding a control digit to the LOINC code, the function
 ; checks the code against the LAB LOINC file (#95.3).
 ;
 ; Return values:
 ;       <0  Error code
 ;       >0  LOINC code with the control digit
 ;
LNCODE(LNCODE) ;
 N RC,RORBUF,RORMSG
 D FIND^DIC(95.3,,"@;.01E","X",$P(LNCODE,"-"),2,"B",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,95.3)
 I $G(RORBUF("DILIST",0))<1  D  Q RC ; Non-existent code
 . S RC=$$ERROR^RORERR(-29,,,,LNCODE)
 I $G(RORBUF("DILIST",0))>1  D  Q RC ; Duplicate records
 . S RC=$$ERROR^RORERR(-30,,,,LNCODE)
 Q RORBUF("DILIST","ID",1,.01)
 ;
 ;***** LOCK/UNLOCK REGISTRIES BEING PROCESSED
 ;
 ; .REGLST       Reference to a local array containing registry names 
 ;               as subscripts and optional registry IENs as values
 ; [MODE]        0 - Unlock (default), 1 - Lock
 ; [TO]          LOCK timeout (3 sec by defualt)
 ; [NAME]        Name of the process/task
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Some of the registries has been locked by another job
 ;        1  Ok
 ;
LOCKREG(REGLST,MODE,TO,NAME) ;
 Q:$D(REGLST)<10 1
 N LOCKLST,RORLIST,RC,REGIEN,REGNAME
 N CT,FAILS,Q,Q0,Z
 ; RORLIST = 0 if less than 15 entries to lock
 ;         = 1 if 15 or more entries to lock
 ;        (n,x,y) = the array in LOCKLST(x,y) at that point
 ;                  (where n = the # identifying the set of 15
 ;                   registries being locked at one time)
 ; FAILS = <0 or 1 ... lock failed     = 0 ... lock was successful
 S REGNAME="",CT=0,RORLIST=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:REGIEN<0
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  S REGIEN=$$REGIEN^RORUTL02(REGNAME)  Q:REGIEN'>0
 . S CT=CT+1
 . S LOCKLST(798.1,REGIEN_",")=""
 . I '(CT#15) D  ; Split the locks into smaller chunks every 15 entries
 .. M RORLIST(CT/15)=LOCKLST S RORLIST=1
 .. K LOCKLST
 Q:$G(REGIEN)<0 REGIEN
 I RORLIST,$O(LOCKLST(""))'="" M RORLIST((CT/15\1)+1)=LOCKLST K LOCKLST
 Q:$D(LOCKLST)<10&'$O(RORLIST(0)) 1
 I $G(MODE) S RC=0 D
 . I 'RORLIST S RC=$$LOCK^RORLOCK(.LOCKLST,,,+$G(TO,3),$G(NAME)) Q
 . F Q=1:1 Q:'$D(RORLIST(Q))!RC  D
 .. K LOCKLST M LOCKLST=RORLIST(Q)
 .. S FAILS=$$LOCK^RORLOCK(.LOCKLST,,,+$G(TO,3),$G(NAME)),RC=FAILS
 .. ; If lock fails for at least one set of nodes [=1 or <0] - unlock previous locks
 .. I FAILS D:Q>1
 ... F Q0=1:1:Q-1 K LOCKLST M LOCKLST=RORLIST(Q0) S Z=$$UNLOCK^RORLOCK(.LOCKLST)
 E  D
 . I 'RORLIST S RC=$$UNLOCK^RORLOCK(.LOCKLST) Q
 . S RC=0
 . F Q=1:1 K LOCKLST Q:'$D(RORLIST(Q))  D
 .. M LOCKLST=RORLIST(Q) S FAILS=$$UNLOCK^RORLOCK(.LOCKLST)
 .. S:FAILS RC=FAILS
 Q $S('RC:1,RC<0:RC,1:0)
 ;
 ;***** RETURNS A PATIENT ID (ICN OR SSN)
 ;
 ; PTIEN         Patient IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  Neither ICN nor SSN has been assigned
 ;       >0  Patient ICN (or SSN if ICN is not available)
 ;
PTID(PTIEN) ;
 N L,PTID,RC,RORMSG
 S PTID=$$GETICN^MPIF001(PTIEN)
 I PTID>0  D  Q PTID
 . ;--- Validate the checksum (just in case ;-)
 . S L=$L($P(PTID,"V",2))  Q:L'<6
 . ;S RC=$$ERROR^RORERR(-59,,,PTIEN)
 . S $P(PTID,"V",2)=$E("000000",1,6-L)_$P(PTID,"V",2)
 ;--- Get SSN if ICN is not available
 S PTID=$$GET1^DIQ(2,PTIEN_",",.09,,,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,PTIEN,2)
 Q PTID
 ;
 ;***** RETURNS IEN OF THE REGISTRY PARAMETERS
 ;
 ; REGNAME       Name of the registry
 ; [FIELDS]      List of fields (separated by semicolons) to load
 ; [.RORTRGT]    Reference to a local variable where field values will
 ;               be stored by the FIND^DIC call
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  Registry parameters IEN
 ;
REGIEN(REGNAME,FIELDS,RORTRGT) ;
 N RC,REGIEN,RORMSG  K RORTRGT
 D FIND^DIC(798.1,,"@;"_$G(FIELDS),"UX",REGNAME,2,"B",,,"RORTRGT","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.1)
 S RC=+$G(RORTRGT("DILIST",0))
 Q $S(RC<1:-1,RC>1:-2,1:+RORTRGT("DILIST",2,1))
 ;
 ;***** RETURNS NUMBER OF RECORDS IN THE REGISTRY
 ;
 ; REGIEN        Registry IEN
 ; [.LOWIEN]     The smallest IEN will be returned via this parameter
 ; [.HIGHIEN]    The biggest IEN will be returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  The registry is empty
 ;       >0  Number of records in the registry
 ;
REGSIZE(REGIEN,LOWIEN,HIGHIEN) ;
 N I,NODE,NRE,RC,RORFDA,RORMSG
 S NODE=$NA(^RORDATA(798,"AC",REGIEN))
 S LOWIEN=$O(@NODE@(""))
 S HIGHIEN=$O(@NODE@(""),-1)
 ;--- Get number of records from the parameters
 S NRE=$$GET1^DIQ(798.1,REGIEN_",",19.1,,,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.1,REGIEN)
 Q:NRE>0 NRE
 ;--- Count the records of the registry
 S I="",NRE=0
 F  S I=$O(@NODE@(I))  Q:I=""  S NRE=NRE+1
 ;--- Store the value in the parameters
 S RORFDA(798.1,REGIEN_",",19.1)=NRE
 D FILE^DIE("K","RORFDA","RORMSG")
 Q NRE
 ;
 ;***** CHECKS IF AN EMPLOYEE SHOULD BE SKIPPED
 ;
 ; PTIEN         Patient IEN
 ;
 ; [.]REGIEN     Registry IEN
 ;
 ;               If you are going to call this function for several
 ;               patients in a row (in a cycle), you can pass the
 ;               second parameter by reference. This will eliminate
 ;               repetitive access to the registry parameters (the
 ;               REGIEN("SE") node will be used as a "cache" for the
 ;               value of the EXCLUDE EMPLOYEES field).
 ;
 ; Return Values:
 ;        0  Patient can be added to the registry
 ;        1  Patient should be skipped
 ;
 ; The function checks if the patient is an employee and if he/she
 ; can be added to the registry (according to the value of the
 ; EXCLUDE EMPLOYEES field of the ROR REGISTRY PARAMETERS file).
 ;
SKIPEMPL(PTIEN,REGIEN) ;
 Q:'$$EMPL^DGSEC4(PTIEN,"P") 0
 S:'$D(REGIEN("SE")) REGIEN("SE")=+$P($G(^ROR(798.1,+REGIEN,0)),U,10)
 Q +REGIEN("SE")
 ;
 ;***** RETURNS IEN OF THE SELECTION RULE
 ;
 ; RULENAME      Name of the selection rule
 ; [FIELDS]      List of fields (separated by semicolons) to load
 ; [.RORTRGT]    Reference to a local variable where field values will
 ;               be stored by the FIND^DIC call.
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  Selection rule IEN
 ;
SRLIEN(RULENAME,FIELDS,RORTRGT) ;
 N RC,RULEIEN,RORMSG  K RORTRGT
 D FIND^DIC(798.2,,"@;"_$G(FIELDS),"X",RULENAME,2,"B",,,"RORTRGT","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.2)
 S RC=+$G(RORTRGT("DILIST",0))
 Q $S(RC<1:-3,RC>1:-4,1:+RORTRGT("DILIST",2,1))
