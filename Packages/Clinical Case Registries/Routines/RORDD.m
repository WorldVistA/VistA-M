RORDD ;HCIOFO/SG - DATA DICTIONARY UTILITIES ;9/2/05 10:58am
 ;;1.5;CLINICAL CASE REGISTRIES;**10**;Feb 17, 2006;Build 32
 ;
 ; This routine uses the following IAs:
 ;
 ; #10076  ^XUSEC(KEY,DUZ (supported)
 ; #10142  EN^DDIOL (supported)
 ; #10008  DQ^DICQ (supported)
 ; #2052   $$GET1^DID (supported)
 ; #2055   $$ROOT^DILFD (supported)
 ; #2056   $$GET1^DIQ (supported)
 ; #10044  H^XUS (supported)
 ; #2198   $$BROKER^XWBLIB (supported)
 ; #10096  ^%ZOSF("TEST" (supported)
 ;
 Q
 ;
 ;***** CHECKS USER KEYS AND LOGS ATTEMPTS OF UNAUTHORIZED ACCESS
 ;
 ; FILE          File number
 ;
 ; [REGISTRY]    Either a registry name or a registry IEN.
 ;               By default ($G(REGISTRY)=""), the function checks if
 ;               the user has any Clinical Case Registries keys.
 ;
 ; [STRICT]      If this parameter is defined and not zero then an
 ;               access violation event is recorded even if the user
 ;               has other Clinical Case Registries keys.
 ;
 ;               This mode can be used to restrict access to a file,
 ;               which is solely associated with a single registry
 ;               (for example, the ROR HIV STUDY file).
 ;
 ; Return Values:
 ;        0  Access denied
 ;        1  Access granted
 ;
ACCESS(FILE,REGISTRY,STRICT) ;
 Q:$G(DUZ)'>0 0               ; Unknown user
 Q:$E($G(XPDNM),1,3)="ROR" 1  ; KIDS
 N ANYKEY,REGKEY
 S (REGKEY,ANYKEY)=1
 ;--- Check the user's security keys
 I $G(REGISTRY)'=""  D:$D(^ROR(798.1,"ACL",DUZ,REGISTRY))<10
 . Q:$D(^XUSEC("ROR VA IRM",DUZ))
 . S REGKEY=0,ANYKEY=($D(^ROR(798.1,"ACL",DUZ))>1)
 E  D:$D(^ROR(798.1,"ACL",DUZ))<10
 . S:'$D(^XUSEC("ROR VA IRM",DUZ)) (REGKEY,ANYKEY)=0
 Q:REGKEY 1
 ;--- Do not record an access violation event if the user has
 ;    any Clinical Case Registries key and the "strict" mode
 ;--- has not been requested by the caller.
 I '$G(STRICT)  Q:ANYKEY 0
 N RORMSG,X
 ;--- Record the access violation event (if the API is available)
 S X="RORLOG"  X ^%ZOSF("TEST")
 I $T  D  D ACVIOLTN^RORLOG(X,$G(REGISTRY))
 . S X="Attempt of unauthorized access to the file #"_FILE
 ;--- Display the message (if the current device is a display)
 I $E($G(IOST),1,2)="C-"  D  H 4
 . D TEXT^RORTXT(7980000.003,.RORMSG)
 . W !!!  S X=""
 . F  S X=$O(RORMSG(X))  Q:X=""  D
 . . W ?($G(IOM,80)-$L(RORMSG(X))\2),RORMSG(X),!
 ;--- Log Off the user (if not an RPC Broker session)
 D:'$$BROKER^XWBLIB H^XUS
 Q 0
 ;
 ;***** "ACL" CROSS-REFERENCE UTILITIES
 ;
 ; These two procedures are used by the kill and set logic of the
 ; "ACL" cross-reference (MUMPS type) of the .01 field of the SECURITY
 ; KEY multiple of the ROR REGISTRY PARAMETERS file (#798.1).
 ;
 ; FileMan initializes the X variable (name of the security key) and
 ; the DA array before calling these procedures.
 ;
ACLKILL ;
 N RORDUZ,RORREG
 S RORREG=$P($G(^ROR(798.1,DA(1),0)),U)
 S RORDUZ=""
 F  S RORDUZ=$O(^XUSEC(X,RORDUZ))  Q:RORDUZ=""  D
 . K ^ROR(798.1,"ACL",RORDUZ,DA(1),X,DA)
 . K:RORREG'="" ^ROR(798.1,"ACL",RORDUZ,RORREG,X,DA)
 Q
 ;
ACLSET ;
 N RORDUZ,RORREG
 S RORREG=$P($G(^ROR(798.1,DA(1),0)),U)
 S RORDUZ=""
 F  S RORDUZ=$O(^XUSEC(X,RORDUZ))  Q:RORDUZ=""  D
 . S ^ROR(798.1,"ACL",RORDUZ,DA(1),X,DA)=""
 . S:RORREG'="" ^ROR(798.1,"ACL",RORDUZ,RORREG,X,DA)=""
 Q
 ;
 ;***** CHECKS IF THE REGISTRY RECORD IS 'ACTIVE'
 ;NOTE: With patch 10, pending patients are included in the extractions
 ;(nightly and historical), so this API is not called anymore to
 ;determine whether to include the patient in the extracts.  The DEL API
 ;is called instead.  But this 'ACTIVE' API is still used in the CCR application
 ;for other things.
 ;
 ;
 ; IEN           IEN of the registry record
 ;
 ; [CHKDT]       Date/Time for status calculation. The current date
 ;               and time are used by default.
 ;               Currently, this parameter has no effect .
 ;
 ; [.STATUS]     Status code is returned via this parameter.
 ;               It explains the reason for inactivity:
 ;                 ""  Status unknown or no record
 ;                  4  Patient is pending
 ;                  5  Patient is marked for deletion
 ;
 ; Return Values:
 ;        0  The record is not confirmed
 ;        1  The record is confirmed
 ;
ACTIVE(IEN,CHKDT,STATUS) ;
 N NODE0
 S NODE0=$G(^RORDATA(798,+IEN,0))
 I NODE0=""  S STATUS=""  Q 0
 S STATUS=+$P(NODE0,U,5)
 Q:STATUS=4 0  ; Pending
 Q:STATUS=5 0  ; Marked for deletion
 Q 1           ; Confirmed/Active
 ;
 ;***** CHECKS IF THE REGISTRY RECORD IS MARKED FOR DELETION
 ;NOTE: these records are excluded from the historical extract
 ;
 ; IEN           IEN of the registry record
 ;
 ; Return Values:
 ;        1       The record is marked for deletion
 ;        0       The record is not marked for deletion
 ;
DEL(IEN) ;
 N NODE0,STATUS
 S NODE0=$G(^RORDATA(798,+IEN,0))
 I NODE0=""  Q 0
 S STATUS=+$P(NODE0,U,5)
 Q:STATUS=5 1  ; Marked for deletion
 Q 0           ; Not marked for deletion
 ;
 ;***** DISPLAYS A LIST OF APIs DEFINED IN THE SUBFILE #799.23
 ;
 ; IEN           IEN of the current record of the file #799.2
 ;
APILST(IEN) ;
 N D,DIC,DLAYGO,DZ,RORMSG
 S DIC=$$ROOT^DILFD(799.23,","_(+IEN)_",")  Q:DIC=""
 S D=$$GET1^DID(799.23,.01,,"FIELD LENGTH",,"RORMSG")
 D EN^DDIOL($J(1,D),,"?2"),EN^DDIOL("GETS^DIQ",,"?10")
 S DIC(0)="",D="B",DZ="??"
 S DIC("W")="D EN^DDIOL($P(^(0),U,3)_""^""_$P(^(0),U,2),,""?10"")" ;Naked Ref: ^ROR(799.2,IEN
 D DQ^DICQ
 Q
 ;
 ;***** VALIDATES A NAME OF THE CALLBACK FUNCTION
 ;
 ; MNFP          Minimal number of formal parameters (opt'l).
 ;               If this parameter has a value greater than 1, the
 ;               function makes very simple check of the number of
 ;               formal parameters in the source code.
 ;
 ; This function is intended for use in the input transforms
 ; of registry definition fields. It kills the X variable if it
 ; contains illegal value.
 ;
 ; The function does not allow to use '%' in the routine and
 ; tag names (this is prohibited by VistA SAC).
 ;
 ; If the function cannot obtain the source code of the callback
 ; function (because the code does not exist yet or has been stripped)
 ; or there are not enough formal parameters in the definition of the
 ; function, it issues a warning but does not reject the value.
 ;
 ; Return Values:
 ;        0  Ok
 ;        1  Illegal name (X is killed)
 ;
EP(MNFP) ;
 Q:$G(X)="" 0
 N ENTPNT,TMP
 ;--- Check if the value has the "$$TAG^ROUTINE" format
 I '(X?2"$"1.8UN1"^"1.8UN)  K X  Q 1
 ;--- Check if the routine exists
 S ENTPNT=X,X=$P(X,U,2)
 X ^%ZOSF("TEST")  E  D  K X  Q 1
 . D EN^DDIOL("The '"_X_"' routine does not exist!")
 S X=ENTPNT
 ;--- Skip the enhanced checks when verifying fields
 Q:$G(DIUTIL)="VERIFY FIELDS" 0
 ;--- Get the line of source code
 S ENTPNT=$P(X,"$$",2),TMP=$TR($P($T(@ENTPNT),";")," ")
 ;--- Display a warning if there is no source line
 I TMP=""  D  Q 0
 . S TMP="Make sure that the '"_$P(ENTPNT,U)_"' tag"
 . D EN^DDIOL(TMP_" exists in the '"_$P(ENTPNT,U,2)_"' routine.")
 ;--- Display a warning if there are not enough formal parameters
 I $G(MNFP)>1,$L(TMP,",")<MNFP  D  Q 0
 . S TMP="Make sure that the entry point has at least "_MNFP
 . D EN^DDIOL(TMP_" formal parameter(s).")
 Q 0
 ;
 ;***** VALIDATES A SELECTION RULE EXPRESSION
 ;
 ; FILE          File number that the expression is associated with
 ;
 ; This function is intended for use in the input transforms
 ; of registry definition fields. It kills the X variable if
 ; it contains an illegal value.
 ;
 ; Return Values:
 ;        0  Ok
 ;        1  Illegal expression (X is killed)
 ;
EXPR(FILE) ;
 Q:($G(FILE)'>0)!($G(X)="") 0
 N EXPR,RC,RESULT,RORERROR,RORLOG,RORPARM,TMP
 ;--- Check if the parser routine exists in the UCI
 S EXPR=X,X="RORUPEX"  X ^%ZOSF("TEST")  S X=EXPR  E  Q 0
 ;--- Parse and validate the expression
 S RC=$$PARSER^RORUPEX(FILE,X,.RESULT)
 Q:RC'<0 0  K X
 ;--- Field does not exist
 I RC=-7   D  Q 1
 . S TMP="One of the referenced fields"
 . D EN^DDIOL(TMP_" does not exist in the file #"_FILE_"!")
 ;--- Syntax error in the expression
 I RC=-21  D  Q 1
 . D EN^DDIOL("Invalid expression: '"_EXPR_"'")
 . D EN^DDIOL("Parsed to: '"_$G(RESULT)_"' ")
 ;--- File does not exist
 I RC=-58  D  Q 1
 . D EN^DDIOL("Referenced file #"_FILE_" does not exist!")
 Q 1
 ;
 ;***** CHECKS IF A FIELD OF A NATIONAL DEFINITION CAN BE DELETED
 ;
 ; FILE          Top-level file number
 ; [IEN]         IEN of the current record of the top-level file
 ; [FIELD]       Number of the NATIONAL field.
 ;               If value of this parameter less than zero, local
 ;               modifications of all records will be prohibited.
 ;               By default, the .09 field is used.
 ;
 ; This function is intended for use in the "DEL" node logic
 ; of registry definition fields.
 ;
 ; Return Values:
 ;        0  The value of the field can be deleted
 ;        1  Deletion is prohibited
 ;
VADEL(FILE,IEN,FIELD) ;
 Q:$G(XPDNM)'="" 0
 ;--- An authorized developer can delete anything
 Q:$G(RORPARM("DEVELOPER")) 0
 ;--- Check if the registry definition is a national one
 N RC,RORMSG
 I $G(FIELD)'<0  S RC=0  D:$G(IEN)>0  Q:'RC 0
 . S:'$G(FIELD) FIELD=.09
 . S RC=$$GET1^DIQ(FILE,IEN_",",FIELD,"I",,"RORMSG")
 D EN^DDIOL("You cannot edit a national registry definition!")
 Q 1
 ;
 ;***** CHECKS IF A FIELD OF A NATIONAL DEFINITION CAN BE EDITED
 ;
 ; FILE          Top-level file number
 ; [IEN]         IEN of the current record of the top-level file
 ; [FIELD]       Number of the NATIONAL field.
 ;               If value of this parameter less than zero, local
 ;               modifications of all records will be prohibited.
 ;               By default, the .09 field is used.
 ;
 ; This function is intended for use in the input transforms
 ; of registry definition fields. It kills the X variable if
 ; it contains illegal value.
 ;
 ; Return Values:
 ;        0  The field can be edited
 ;        1  Editing is prohibited (X is killed)
 ;
VAEDT(FILE,IEN,FIELD) ;
 Q:($G(DIUTIL)="VERIFY FIELDS")!($G(XPDNM)'="") 0
 ;--- An authorized developer can edit anything
 Q:$G(RORPARM("DEVELOPER")) 0
 ;--- Check if the registry definition is a national one
 N RC,RORMSG
 I $G(FIELD)'<0  S RC=0  D:$G(IEN)>0  Q:'RC 0
 . S:'$G(FIELD) FIELD=.09
 . S RC=$$GET1^DIQ(FILE,IEN_",",FIELD,"I",,"RORMSG")
 K X
 D EN^DDIOL("You cannot edit a national registry definition!")
 Q 1
