XULMU ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;11/16/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;
 ; Miscellaneous utilities
 ;
GETLOCKS(LOCKS) ;
 N NODE,QUIT,RSET
 ;
 S NODE=$$NODE
 S @LOCKS@("XULM REPORTED NODE")=NODE
 S QUIT=0
 D LOCKQRY^%ZLMLIB(.RSET)
 F  D  Q:QUIT
 .N PID,LOCK
 .I '$$NXTLOCK^%ZLMLIB(.RSET,.LOCK) S QUIT=1 Q
 .S PID=LOCK(LOCK,"PID")
 .D:PID
 ..S @LOCKS@(LOCK,NODE)=LOCK(LOCK)
 ..S @LOCKS@(LOCK,NODE,"SYSTEM")=$$IFSYSTEM(LOCK)
 ..S @LOCKS@(LOCK,NODE,"PID")=PID
 ..S @LOCKS@(LOCK,NODE,"TASK")=$G(^XUTL("XQ",PID,"ZTSKNUM"))
 ..S @LOCKS@(LOCK,NODE,"OWNER")=$$OWNER(PID,@LOCKS@(LOCK,NODE,"SYSTEM"))
 Q
 ;
OWNER(PID,SYSTEM) ;Return the DUZ^<name> of owner of this process
 N OWNER,OWNERDUZ
 S (OWNER,OWNERDUZ)=""
 I PID=$J S OWNERDUZ=$G(DUZ)
 S:'OWNERDUZ OWNERDUZ=$G(^XUTL("XQ",PID,"DUZ"))
 S:OWNERDUZ OWNER=$P($G(^VA(200,OWNERDUZ,0)),"^")
 I OWNER="",'$G(SYSTEM) S OWNER=$$OSUSER^%ZLMLIB(PID)
 I OWNER="" S OWNER="{?}"
 I OWNER="{?}",$E(LOCK,1,4)["%ZT" S OWNER="TASKMAN"
 Q OWNERDUZ_"^"_OWNER
 ;
 ;
PAT(DFN) ;
 ;Returns ID() array with patient information
 K ID
 I 'DFN S ID(0)=0,ID("IEN")="" Q
 S ID("IEN")=DFN
 D ADDPAT(DFN)
 Q
ADDPAT(DFN) ;
 ;Adds patient information to the existing ID() array.
 Q:'DFN
 N NODE
 S NODE=$G(^DPT(DFN,0))
 Q:NODE=""
 S ID(0)=+$G(ID(0))
 S ID(ID(0)+1)="Patient Name:"_$P(NODE,"^"),ID(ID(0)+2)="Sex:"_$S($P(NODE,"^",2)="M":"MALE",1:"FEMALE"),ID(ID(0)+3)="DOB:"_$$FMTE^XLFDT($P(NODE,"^",3)),ID(ID(0)+4)="SSN:"_$P(NODE,"^",9),ID(0)=ID(0)+4
 Q
 ; 
PAUSE(MSG) ;
 ;Screen pause without scrolling. Returns 1 if the user quits out
 ;
 I $L($G(MSG)) W !,MSG,!
 N DIR,DIRUT,X,Y
 S DIR(0)="E"
 D ^DIR
 Q:('(+Y))!$D(DIRUT) 1
 Q 0
PAUSE2(MSG) ;
 ;First scroll to the bottome of the page, then does a screen pause. Returns 1 if user decides to quit, otherwise returns 0
 ;
 I $L($G(MSG)) W !,MSG,!
 N DIR,X,Y,QUIT
 S QUIT=0
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q QUIT
 ;
ASKYESNO(PROMPT,DEFAULT) ;
 ;Description: Displays PROMPT, appending '?'.  Expects a YES NO response
 ;Input:
 ;   PROMPT - text to display as prompt.  Appends '?'
 ;   DEFAULT - (optional) YES or NO.  If not passed, defaults to YES
 ;Output:
 ;  Function value: 1 if yes, 0 if no, "" if '^' entered or timeout
 ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")=PROMPT
 S DIR("B")=$S($G(DEFAULT)="NO":"NO",1:"YES")
 D ^DIR
 Q:$D(DIRUT) ""
 Q Y
 ;
 ;
IFSYSTEM(LOCK) ;returns 1 if system lock, 0 otherwise
 N SUB,LEN,FOUND,NOTFOUND
 I $P(LOCK,"(")["%" Q 1
 S (FOUND,NOTFOUND)=0
 S LEN=$L(LOCK)
 F I=1:1:LEN S SUB=$E(LOCK,1,I) D  Q:FOUND  Q:NOTFOUND
 .I $D(^XLM(8993.1,"AC",SUB)) S FOUND=1 Q
 .N NEXT
 .S NEXT=$O(^XLM(8993.1,"AC",SUB))
 .I NEXT="" S NOTFOUND=1 Q
 .I NEXT]LOCK S NOTFOUND=1 Q
 Q FOUND
 ;
NODE() ;Get Cache' instance name for this process
 Q ##class(%SYS.System).GetInstanceName()
 ;
VOLUME() ;Returns the namespace of current environment
 Q $SYSTEM.SYS.NameSpace()
 ;
SAMENODE(NODE) ;Is the current process running on the indicated node?
 N SNODE
 S SNODE=$$NODE()
 I $G(NODE)=SNODE Q 1
 Q 0
 ;
OS() ;Get OS
 N X
 S X=$$VERSION^%ZOSV(1)
 Q $S(X["VMS":"VMS",X["UNIX":"LNX",X["Linux":"LNX",X["Windows":"WIN",1:"? OS")
 ;
 ;
HEX(DEC) ;Convert decimal number to hexidecimal
 Q $$BASE^XLFUTL(DEC,10,16)
 ;
ADD(FILE,DA,DATA,ERROR,IEN) ;
 ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DA - Traditional FileMan DA array with same
 ;  meaning. Pass by reference.  Only needed if adding to a
 ;  subfile.
 ;   DATA - Data array to file, pass by reference
 ;Format: DATA(<field #>)=<value>
 ;   IEN - internal entry number to use (optional)
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created 
 ;record, else returns NULL.
 ;  DA - returns the ien of the new record, NULL if none created.  If needed, pass by reference.
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To add a record in subfile 2.0361 in the record with ien=353
 ;with the field .01 value = 21:
 ;  S DATA(.01)=21,DA(1)=353 I $$ADD(2.0361,.DA,.DATA) W !,"DONE"
 ;
 ; Example: If creating a record not in a subfile, would look like this:
 ;S DATA(.01)=21 I $$ADD(867,,.DATA) W !,"DONE"
 ;
 N FDA,FIELD,IENA,IENS,ERRORS,DIERR
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;IENA - the Internal Entry Number Array defined by FM
 ;FDA - the FDA array defined by FM
 ;IEN - the ien of the new record
 ;
 S DA="+1"
 S IENS=$$IENS^DILF(.DA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 I $G(IEN) S IENA(1)=IEN
 D UPDATE^DIE("","FDA","IENA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 .S IEN=""
 E  D
 .S IEN=IENA(1)
 .S ERROR=""
 D CLEAN^DILF
 S DA=IEN
 Q IEN
 ;
DELETE(FILE,DA,ERROR) ;
 ;Delete an existing record.
 N DATA
 S DATA(.01)="@"
 Q $$UPD(FILE,.DA,.DATA,.ERROR)
 Q
 ;
UPD(FILE,DA,DATA,ERROR) ;File data into an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DA - Traditional DA array, with same meaning.
 ;  Pass by reference.
 ;   DATA - Data array to file (pass by reference)
 ;Format: DATA(<field #>)=<value>
 ;
 ; Output:
 ;  Function Value -     0=error and 1=no error
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To update a record in subfile 2.0361 in record with ien=353,
 ;subrecord ien=68, with the field .01 value = 21:
 ;    S DATA(.01)=21,DA=68,DA(1)=353 I $$UPD(2.0361,.DA,.DATA,.ERROR) W !,"DONE"
 ;
 N FDA,FIELD,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(DA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q 0
 S IENS=$$IENS^DILF(.DA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 D FILE^DIE("","FDA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 D CLEAN^DILF
 Q $S(+$G(DIERR):0,1:1)
 ;
SETCLEAN(RTN,VAR) ;
 ;Description:  The purpose of this API is to register a cleanup routine
 ;   that should be executed when the process is terminated by the 
 ;   Kernel Lock Manager.  An entry is created on a stack kept for the
 ;   process.  The location is ^XTMP("XULM","XULM CLEANUP_"_$J,0) where $J
 ;   uniquely identifies the process.  A process may call SETCLEAN^XULMU
 ;   repeatedly, and each time a new entry is placed on the stack.
 ;
 ;Input:
 ;  RTN -   The routine to be executed when the process is terminated.
 ;  VAR - A list of variables that should be defined whent the routine
 ;        is executed.  It is up to the application to insure that
 ;        all the required variables are defined. 
 ;  Function:  An integer is returned that identifies the entry created
 ;             on the stack.  The application needs to retain this only
 ;             if it may need to later remove the entry from the stack.
 ;
 ;  Example:
 ;      S VAR("DFN")=DFN
 ;      S CLNENTRY=$$SETCLEAN^XULMU("MYCLEAN^MYRTN",.VAR)
 ;
 N I,GBL
 S GBL=$NA(^XTMP("XULM","XULM CLEANUP_"_$J,0))
 ;I '$D(@GBL@(0)) S @GBL@(0)=$$FMADD^XLFDT($$NOW^XLFDT\1,2)_"me^here"_$$NOW^XLFDT\1
 I '$D(@GBL@(0)) D
 .S @GBL@(0)=$$FMADD^XLFDT($$NOW^XLFDT\1,2)
 .S @GBL@(0)=@GBL@(0)_"^"_($$NOW^XLFDT\1)
 S I=+$O(@GBL@(9999999),-1)+1
 S @GBL@(I,"ROUTINE")=RTN
 M @GBL@(I,"VARIABLES")=VAR
 Q I
 ;
CLEANUP(XULAST,DOLLARJ) ;
 ;Description:  This API will execute the housecleaning stack set by the
 ;process identified by DOLLARJ. Entries are executed in the FIFO order,
 ;with the last entry added being the first to be executed, and XULAST
 ;being the last entry executed. If LAST is not passed in,
 ;then the entire stack is executed.
 ;
 ;Input:
 ;  XULAST (optional) - This is the last entry that will be executed.
 ;     If not passed in, then the entire housecleaning stack is executed.
 ;  DOLLARJ - The $J value of the process that created the housecleaning
 ;     stack. If DOLLARJ is not passed in, the value defaults to be $J. 
 ;
 N XUGBL,XUENTRY
 I $G(DOLLARJ)="" S DOLLARJ=$J
 S XUGBL=$NA(^XTMP("XULM","XULM CLEANUP_"_DOLLARJ,0))
 S XULAST=+$G(XULAST)
 S XUENTRY=9999
 F  S XUENTRY=$O(@XUGBL@(XUENTRY),-1) Q:XUENTRY<XULAST  D
 .N XURTN,XUVAR
 .S XURTN=$G(@XUGBL@(XUENTRY,"ROUTINE"))
 .S XUVAR=""
 .F  S XUVAR=$O(@XUGBL@(XUENTRY,"VARIABLES",XUVAR)) Q:XUVAR=""  N @XUVAR S @XUVAR=@XUGBL@(XUENTRY,"VARIABLES",XUVAR)
 .D:$L(XURTN) @XURTN
 .K @XUGBL@(XUENTRY)
 Q
UNCLEAN(LAST,DOLLARJ) ;
 ;Description - this removes entries form the housecleaning stack set by
 ;calling SETCLEAN^XULMU. Entries are removed in FIFO order.  If LAST is
 ;not passed in, then the entire stack is deleted, otherwise just the
 ;entries back to LAST are removed.
 ;Input:
 ;  LAST - Identifies the last entry on the housekeeping stack to remove.
 ;       Entries are removed in FIFO order, so the first entry removed is
 ;       the last entry that was added, and the last entry removed is
 ;       LAST. If not passed in, the entire housecleainging stack is
 ;       deleted. 
 ;  DOLLARJ (optional) The $J value of process that set the stack.  If
 ;          not passed in then its value is assumed to be $J.
 ;
 N GBL,ENTRY
 I $G(DOLLARJ)="" S DOLLARJ=$J
 S GBL=$NA(^XTMP("XULM","XULM CLEANUP_"_DOLLARJ,0))
 S LAST=+$G(LAST)
 I 'LAST K @GBL Q
 S ENTRY=9999
 F  S ENTRY=$O(@GBL@(ENTRY),-1)  Q:ENTRY<LAST  K @GBL@(ENTRY) I 'ENTRY K @GBL
 Q
 ;
TEMPLATE(IEN) ;Returns the lock template, with the "^" prefix if it is on a global
 N LOCK
 S LOCK=$G(^XLM(8993,IEN,0))
 I $P($G(^XLM(8993,IEN,1)),"^",2) S LOCK="^"_LOCK
 Q LOCK
 ;
 ;
