RORUTL01 ;HCIOFO/SG - UTILITIES  ; 5/12/05 3:29pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #3301         Access to the .6 field of the file #2
 ; #3744         $$TESTPAT^VADPT
 ; #10035        Access to the .01 and .09 fields of the file #2
 ; #10038        Access to the HOLIDAY file (supported)
 Q
 ;
 ;***** SENDS ALERT TO REGISTRY COORDINATORS
 ;
 ; [.]REGLST     Either name of the registry or reference to a local
 ;               array containing registry names as subscripts and
 ;               optional registry IENs as values
 ;
 ; MSG           Text of the message or negative error code. The '^'
 ;               characters are replaced with spaces in the text.
 ;
 ; [XQAROU]      Indicates a ROUTINE or TAG^ROUTINE to run when
 ;               the alert is processed
 ;
 ; [XQADATA]     Use this to store a package-specific data string,
 ;               in any format
 ;
 ; [PATIEN]      Patient IEN
 ;
 ; [ARG2-ARG5]   Optional parameters as for the $$ERROR^RORERR
 ;
ALERT(REGLST,MSG,XQAROU,XQADATA,PATIEN,ARG2,ARG3,ARG4,ARG5) ;
 N IR,RC,REGIEN,REGNAME,RORBUF,RORMSG,TMP,XQA,XQAFLG,XQAMSG
 ;--- Prepare the notification list
 I $D(REGLST)=1  Q:REGLST=""  S REGLST(REGLST)=""
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  D  Q:REGIEN'>0
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . ;--- Load the notification list from the registry parameters
 . K RORBUF  S TMP=","_REGIEN_","
 . D LIST^DIC(798.114,TMP,"@;.01I","U",,,,"B",,,"RORBUF","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0
 . S IR=""
 . F  S IR=$O(RORBUF("DILIST","ID",IR))  Q:IR=""  D
 . . S TMP=+$G(RORBUF("DILIST","ID",IR,.01))  S:TMP>0 XQA(TMP)=""
 Q:$D(XQA)<10
 ;--- Get text of the error message (if necessary)
 I +MSG=MSG  Q:MSG'<0  D
 . S MSG=$$MSG^RORERR20(+MSG,,.PATIEN,.ARG2,.ARG3,.ARG4,.ARG5)
 S MSG=$TR(MSG,"^"," "),XQAMSG="ROR: ",TMP=70-$L(XQAMSG)-3
 S XQAMSG=XQAMSG_$S($L(MSG)>TMP:$E(MSG,1,TMP)_"...",1:MSG)
 ;--- Setup default alert processing routine
 I $G(XQAROU)="",$G(XQADATA)=""  D
 . S XQADATA=$E(MSG,1,78)_U_$G(PATIEN)
 . S REGNAME=""
 . F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D
 . . S XQADATA=XQADATA_U_REGNAME
 . S XQAROU="ALERTRTN^RORUTL01"
 ;--- Send the alert
 S XQAFLG="D"  D SETUP^XQALERT
 Q
 ;
 ;***** DEFAULT ALERT PROCESSING ROUTINE
 ;
 ; XQADATA       Alert data
 ;                 ^1: Message
 ;                 ^2: Patient DFN
 ;                 ^3: Registry name
 ;                     ...
 ;                 ^N: Registry name
 ;
ALERTRTN ;
 Q:$G(XQADATA)=""
 N I,REGNAME
 W !!,$P(XQADATA,"^"),!
 W:$P(XQADATA,"^",2) "Patient DFN: ",$P(XQADATA,"^",2),!
 W "Processed Registries",!
 F I=3:1  S REGNAME=$P(XQADATA,"^",I)  Q:REGNAME=""  W ?3,REGNAME,!
 Q
 ;
 ;***** INITIALIZES THE VARIABLES
 ;
 ; NAMESP        Namespace to kill in the ^TMP global
 ;               (must start with "ROR")
 ; [XPURGE]      Purge namespaced nodes in the ^XTMP global.
 ;               The ^XTMP(NAMESP_$J) node is always killed.
 ;
INIT(NAMESP,XPURGE) ;
 N I,L,NOW  K ^TMP($J)
 S:$G(U)="" U="^"  S:'$G(DT) DT=$$DT^XLFDT
 Q:$E($G(NAMESP),1,3)'="ROR"
 ;--- Kill namespaced nodes in the ^TMP global
 S I=NAMESP,L=$L(NAMESP)
 F  K ^TMP(I,$J)  S I=$O(^TMP(I))  Q:$E(I,1,L)'=NAMESP
 ;--- Purge old namespaced nodes in the ^XTMP global
 K ^XTMP(NAMESP_$J)
 D:$G(XPURGE)
 . S NOW=$$NOW^XLFDT,I=NAMESP,L=$L(NAMESP)
 . F  D  S I=$O(^XTMP(I))  Q:$E(I,1,L)'=NAMESP
 . . K:$G(^XTMP(I,0))<NOW ^XTMP(I)
 Q
 ;
 ;***** INVERTS THE DATE
 ;
 ; DATE          Date in FileMan format
 ; [MODE]        Mode of inversion
 ;                 1  Strip the time BEFORE inversion
 ;                 2  Strip the time AFTER inversion
 ;                 3  Do not invert the time
 ;
INVDATE(DATE,MODE) ;
 Q:$G(MODE)=1 9999999-$P(DATE,".")
 Q:$G(MODE)=2 $P(9999999-DATE,".")
 I $G(MODE)=3  Q:$P(DATE,".",2) (9999999-$P(DATE,"."))_"."_+$P(DATE,".",2)
 Q 9999999-DATE
 ;
 ;***** RETURNS THE PATIENT IEN (DFN) FROM THE REGISTRY RECORD
 ;
 ; IEN           IEN of the registry record
 ;
PTIEN(IEN) ;
 Q +$P($G(^RORDATA(798,+IEN,0)),U)
 ;
 ;***** RETURNS IEN OF THE PATIENT'S RECORD IN THE REGISTRY
 ;
 ; PATIEN        Patient IEN
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;       ""  The registry record has not been found
 ;       >0  IEN of the patient's registry record
 ;
PRRIEN(PATIEN,REGIEN) ;
 Q:(PATIEN'>0)!(REGIEN'>0) 0
 Q $O(^RORDATA(798,"KEY",+PATIEN,+REGIEN,0))
 ;
 ;***** RETURNS NAME AND SHORT DESCRIPTION OF THE REGISTRY
 ;
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;
 ; An empty string is returned in case of an error or if there
 ; is no registry with such IEN. Otherwise, the name and short
 ; description of the registry separated by "^" are returned.
 ;
REGNAME(REGIEN) ;
 N IENS,NAME,RORBUF,RORMSG
 Q:'$D(^ROR(798.1,+REGIEN)) ""
 S IENS=+REGIEN_","
 D GETS^DIQ(798.1,IENS,".01;4",,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q ""
 . D DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 Q RORBUF(798.1,IENS,.01)_U_$G(RORBUF(798.1,IENS,4))
 ;
 ;***** CHECKS IF THE PATIENT IS A TEST ONE
 ;
 ; PATIEN        Patient IEN
 ;
 ; Return Values:
 ;        0  The patient is NOT a test patient
 ;        1  The patient IS a test patient
 ;
TESTPAT(PATIEN) ;
 Q:$$TESTPAT^VADPT(PATIEN) 1
 Q:$E($G(^DPT(PATIEN,0)),1,2)="ZZ" 1  ; NAME starts with "ZZ"
 Q 0
 ;
 ;***** VERIFY THE ENTRY POINT
 ;
 ; ENTRY         Entry point of the external MUMPS function
 ; [RECERR]      Record the errors (do not record by default)
 ;
 ; Return Values:
 ;       -18  Routine does not exist
 ;       -17  Invalid entry point
 ;         0  Ok
 ;
VERIFYEP(ENTRY,RECERR) ;
 N X
 S X="S Y="_ENTRY  D ^DIM
 Q:'$D(X) $S($G(RECERR):$$ERROR^RORERR(-17,,,,ENTRY),1:-17)
 S X=$P(ENTRY,U,2)
 X ^%ZOSF("TEST")  E  Q $S($G(RECERR):$$ERROR^RORERR(-18,,,,X),1:-18)
 Q 0
 ;
 ;***** CHECKS IF THE DATE IS A WORKING DAY
 ;
 ; DATE          The date to be checked
 ;
 ; Return Values:
 ;        0  Weekend or Holiday
 ;        1  Working day
 ;
WDCHK(DATE) ;
 N DOW,RORMSG
 ;--- Return zero if Saturday (6) or Sunday (0)
 S DOW=$$DOW^XLFDT(DATE,1)  Q:'DOW!(DOW>5) 0
 ;--- Return 1 if cannot be found in the HOLIDAY file
 Q $$FIND1^DIC(40.5,,"QX",DATE\1,"B",,"RORMSG")'>0
 ;
 ;***** RETURNS THE NEXT WORKING DAY DATE
 ;
 ; DATE          The source date
 ;
 ; The function returns a date of the next working day.
 ;
WDNEXT(DATE) ;
 N DOW,RORMSG
 F  D  Q:$$FIND1^DIC(40.5,,"QX",DATE,"B",,"RORMSG")'>0
 . S DOW=$$DOW^XLFDT(DATE,1)  S:'DOW DOW=7
 . ;--- Get the next day and skip a weekend if necessary
 . S DATE=$$FMADD^XLFDT(DATE,$S(DOW<5:1,1:8-DOW))
 Q DATE
 ;
 ;***** CREATES A HEADER OF THE NODE IN THE ^XTMP GLOBAL
 ;
 ; SUBSCR        Subscript of the node in the ^XTMP global
 ; [DKEEP]       Number of days to keep the node (1 by default)
 ; [DESCR]       Description of the node
 ;
XTMPHDR(SUBSCR,DKEEP,DESCR) ;
 N DATE  S DATE=$$DT^XLFDT  S:$G(DKEEP)'>0 DKEEP=1
 S ^XTMP(SUBSCR,0)=$$FMADD^XLFDT(DATE,DKEEP)_U_DATE_U_$G(DESCR)
 Q
 ;
 ;***** EMULATES AND EXTENDS THE ZWRITE COMMAND :-)
 ;
 ; ROR8NODE      Closed root of the sub-tree to display
 ;               (either local array or global variable)
 ; [TITLE]       Title of the output
 ;
ZW(ROR8NODE,TITLE) ;
 Q:ROR8NODE=""  Q:'$D(@ROR8NODE)
 N FLT,L,PI  W !
 W:$G(TITLE)'="" TITLE,!!
 W:$D(@ROR8NODE)#10 ROR8NODE_"="_@ROR8NODE,!
 S L=$L(ROR8NODE)  S:$E(ROR8NODE,L)=")" L=L-1
 S FLT=$E(ROR8NODE,1,L),PI=ROR8NODE
 F  S PI=$Q(@PI)  Q:$E(PI,1,L)'=FLT  W PI_"="_@PI,!
 Q
