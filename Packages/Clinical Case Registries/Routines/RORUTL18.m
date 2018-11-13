RORUTL18 ;HCIOFO/SG - MISCELLANEOUS UTILITIES ; 4/4/07 1:19pm
 ;;1.5;CLINICAL CASE REGISTRIES;**2,33**;Feb 17, 2006;Build 81
 ;
 ; This routine uses the following IA's:
 ;
 ; #10035        Access to the field #63 of the file #2
 ; #10063        %ZTLOAD
 ; #1472         XUTMOPT
 ; #10070        XMD
 ; #10061        VADPT
 ; #10104        XLFSTR
 ; #10081        XQALERT
 ;
 ;***************************************************************************
 ;***************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*33   MAY  2018   F TRAXLER    Added GETSCHED, SETSCHED, QSCHED, TASKCHK
 ;                                      
 ;***************************************************************************
 ;***************************************************************************
 Q
 ;
 ;***** STRIPS NON-NUMERIC CHARACTERS FROM THE LAB RESULT VALUE
 ;
 ; VAL           Source value
 ;
CLRNMVAL(VAL) ;
 Q $TR(VAL," <>,")
 ;
 ;***** CHECKS FOR 'CONFIRMED' STATUS
 ;
 ; IEN           IEN of the registry record (in file #798)
 ;
 ; Return Values:
 ;        0  Not confirmed
 ;       >0  Confirmation date/time
 ;
CONFDT(IEN) ;
 N CONF  S CONF=$P($G(^RORDATA(798,+IEN,0)),U,4,5)
 Q $S('$P(CONF,U,2):$P(CONF,U),1:0)
 ;
 ;***** DATE RANGE COMPARISON FUNCTIONS
DTMAX(DT1,DT2) ;
 I DT1>0  Q $S(DT2>DT1:DT2,1:DT1)
 Q $S(DT2>0:DT2,1:0)
 ;
DTMIN(DT1,DT2) ;
 I DT1>0  Q $S(DT2'>0:DT1,DT2<DT1:DT2,1:DT1)
 Q $S(DT2>0:DT2,1:0)
 ;
 ;***** RETURNS THE INSTITUTION IEN FOR THE HOSPITAL LOCATION
 ;
 ; IEN44         IEN in the HOSPITAL LOCATION file (#44)
 ;
 ; Return Values:
 ;       <0  Error
 ;       ""  Location has no corresponding institution
 ;       >0  Institution IEN
 ;
IEN4(IEN44) ;
 N IEN4,RC,RORMSG
 Q:$G(IEN44)'>0 ""
 S IEN4=+$$GET1^DIQ(44,IEN44_",",3,"I",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,44,IEN44_",")
 Q $S(IEN4>0:IEN4,1:"")
 ;
 ;***** RETURNS A LAB REFERENCE (IEN IN 'LAB DATA') FOR THE PATIENT
 ;
 ; PTIEN         Patient IEN
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  No lab data
 ;       >0  IEN of the record in LAB DATA file
 ;
LABREF(PTIEN) ;
 N LABREF,RORMSG
 Q:$G(PTIEN)'>0 0
 Q:$$MERGED(PTIEN) 0
 S LABREF=+$$GET1^DIQ(2,PTIEN_",",63,"I",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,PTIEN,2,PTIEN_",")
 Q LABREF
 ;
 ;***** RETURNS THE NEW DFN OF A MERGED PATIENT RECORD
 ;
 ; DFN           Patient IEN
 ;
 ; Return values:
 ;        0  The patient has not been merged
 ;       >0  New DFN
 ;
MERGED(DFN) ;
 N NEWDFN
 F  S DFN=+$G(^DPT(+DFN,-9))  Q:DFN'>0  S NEWDFN=DFN
 Q +$G(NEWDFN)
 ;
 ;***** SENDS THE CPRS-COMPATIBLE INFORMATIONAL ALERT
 ;
 ; MSG           Text of the alert message.  The text is truncated
 ;               to 50 characters and '^' are replaced with '~'.
 ;
 ; [DFN]         Patient IEN
 ;
 ; [.XQA]        List of addressees.  By default, the
 ;               alert is sent to the current user.
 ;
ORALERT(MSG,DFN,XQA) ;
 N LAST4,NAME,VA,VADM,VAHOW,VAROOT,XQADATA,XQAID,XQAMSG,XQAROU
 S XQAMSG="",XQAID="ROR,,"
 I $G(DFN)>0  D
 . D DEM^VADPT
 . S NAME=$E($G(VADM(1)),1,9)         ; Patient name
 . S LAST4=$E($P($G(VADM(2)),U),6,9)  ; Last 4 of SSN
 . S XQAMSG=$$LJ^XLFSTR(NAME_" ("_$E(NAME,1)_LAST4_"):",19)
 . S $P(XQAID,",",2)=+DFN
 S XQAMSG=XQAMSG_$TR(MSG,"^","~")
 S:$L(XQAMSG)>70 $E(XQAMSG,68,999)="..."
 I $D(XQA)<10  Q:$G(DUZ)'>0  S XQA(+DUZ)=""
 D SETUP^XQALERT
 Q
 ;
 ;***** CHECKS FOR 'PENDING' STATUS
 ;
 ; IEN           IEN of the registry record (in file #798)
 ;
 ; Return Values:
 ;        0  Non-pending
 ;        1  Pending patient
 ;
PENDING(IEN) ;
 Q ($P($G(^RORDATA(798,+IEN,0)),U,5)=4)
 ;
 ;***** EMULATES $QUERY WITH 'DIRECTION' PARAMETER
 ;
 ; NODE          Closed root of a node
 ;
 ; [DIR]          Direction:
 ;                  $G(DIR)'<0  forward
 ;                  DIR<0       backward
 ;
Q(NODE,DIR) ;
 Q:$G(DIR)'<0 $Q(@NODE)
 N I,DN,PI,TMP
 S TMP=$QL(NODE)  Q:TMP'>0 ""
 S I=$QS(NODE,TMP),NODE=$NA(@NODE,TMP-1)
 S PI=""
 F  S I=$O(@NODE@(I),-1)  Q:I=""  D  Q:PI'=""
 . S DN=$D(@NODE@(I))
 . I DN#10  S PI=$NA(@NODE@(I))  Q
 . S:DN>1 PI=$$Q($NA(@NODE@(I,"")),-1)
 Q PI
 ;
 ;***** COUNTS THE REGISTRY PATIENTS
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as the subscripts and optional registry IENs
 ;               as the values.
 ;
 ; [FLAGS]       Flags (can be combined)
 ;                 A  Skip non-active patients
 ;                 S  Skip patients marked as "Do not Send"
 ;
 ; [ROR8DST]     Closed root of the global node that will contain a
 ;               list of patients. By default ($G(ROR8DST)=""), the
 ;               ^TMP("RORUTL18",$J) global node is used internally
 ;               (it is deleted before exiting the function).
 ; @ROR8DST@(
 ;  PatIEN,
 ;    RegIEN)    Registry Record IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  All provided registries are empty
 ;       >0  Number of unique patients
 ;
REGPTCNT(REGLST,FLAGS,ROR8DST) ;
 N CNT,IEN,NODE,PLKILL,PTIEN,REGIEN,REGNAME
 S:$G(ROR8DST)="" ROR8DST=$NA(^TMP("RORUTL18",$J)),PLKILL=1
 S FLAGS=$G(FLAGS),NODE=$$ROOT^DILFD(798,"",1),CNT=0
 K @ROR8DST
 ;--- Build a list of unique patients and count them
 S REGNAME=""
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D
 . ;--- Get the registry IEN
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  D  Q:REGIEN'>0
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . ;--- Count the registry patients
 . S IEN=0
 . F  S IEN=$O(@NODE@("AC",REGIEN,IEN))  Q:IEN'>0  D
 . . I FLAGS["A"  Q:'$$ACTIVE^RORDD(IEN)
 . . I FLAGS["S"  Q:$P($G(^RORDATA(798,IEN,2)),U,4)
 . . S PTIEN=$$PTIEN^RORUTL01(IEN)  Q:PTIEN'>0
 . . I '$D(@ROR8DST@(PTIEN))  D  S CNT=CNT+1
 . . . S @ROR8DST@(PTIEN,REGIEN)=IEN
 ;--- Cleanup
 K:$G(PLKILL) @ROR8DST
 Q CNT
 ;
 ;***** SELECTS A REGISTRY DESCRIPTOR IN THE FILE #798.1
 ;
 ; [.REGNAME]    Registry name is returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  Timeout, "^" entered, or an error in ^DIC
 ;        0  There are no records in the file #798.1
 ;       >0  IEN of the selected registry
 ;
SELREG(REGNAME) ;
 N DA,DIC,DLAYGO,DTOUT,DUOUT,RC,RORBUF,RORMSG,X,Y
 S REGNAME=""
 ;--- If there are less than two records, do not ask a user
 D LIST^DIC(798.1,,"@;.01E",,2,,,"B",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.1)
 I $G(RORBUF("DILIST",0))<2  D  Q +$G(RORBUF("DILIST",2,1))
 . S REGNAME=$G(RORBUF("DILIST","ID",1,.01))
 ;--- Select a registry
 S DIC=798.1,DIC(0)="AENQZ"
 S DIC("A")="Select a Registry: "
 D ^DIC
 S:Y>0 REGNAME=Y(0,0)
 Q $S($D(DTOUT)!$D(DUOUT):"",Y<0:"",1:+Y)
 ;
 ;***** RETURNS THE CLINIC'S STOP CODE
 ;
 ; CLIEN         Clinic IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  No stop code
 ;       >0  Stop code
 ;
STOPCODE(CLIEN) ;
 N RORMSG,STOP
 I CLIEN>0  D
 . S STOP=$$GET1^DIQ(44,CLIEN_",","#8:#1","I",,"RORMSG")
 . S:$G(DIERR) STOP=$$DBS^RORERR("RORMSG",-99,,,44,CLIEN_",")
 E  S STOP=""
 Q STOP
 ;
GETSCHED(RORNAME) ;Function to get option schedule information from FILE 19.1
 ;  Input: RORNAME = option name (file 19, field .01)
 ; Output:     (1) = task number^scheduled time^reschedule freq^special queueing flag
 ; Example:    (1) = "1466544^3180427.154^1D^"
 ; Returns null if option name not defined or option is not scheduled.
 ;
 N RORINFO
 S RORNAME=$G(RORNAME)
 I RORNAME="" Q ""
 D OPTSTAT^XUTMOPT(RORNAME,.RORINFO) ;NOTE: API also returns variable: RORINFO=count
 I +$G(RORINFO)=0 Q ""
 Q $G(RORINFO(1))
 ;
SETSCHED(RORNAME,ROR1,ROR2,ROR3,ROR4,ROR5,ROR6) ;Function to set option schedule in FILE 19.1
 ;  Input: RORNAME = option name (file 19, field .01)
 ;            ROR1 = date/time to run
 ;            ROR2 = device to use
 ;            ROR3 = re-sechedule frequency
 ;            ROR4 = flags
 ;            ROR5 = error array
 ;            ROR6 = queueing flag (0:don't queue{default}, 1:queue)
 ; Output: 1 = changes made
 ;         0 = changes not made 
 ;
 N RORVAR,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO
 S RORNAME=$G(RORNAME)
 I RORNAME="" Q 0
 S ROR1=$G(ROR1),ROR2=$G(ROR2),ROR3=$G(ROR3),ROR4=$G(ROR4),ROR5=$G(ROR5),ROR6=$G(ROR6,0)
 I ROR6=1 D  Q 1
 .S ZTRTN="QSCHED^RORUTL18",ZTDESC="ROR reschedule option",ZTDTH=$$NOW^XLFDT(),ZTIO=""
 .F RORVAR="RORNAME","ROR1","ROR2","ROR3","ROR4","ROR5" S ZTSAVE(RORVAR)=""
 .D ^%ZTLOAD
 D RESCH^XUTMOPT(RORNAME,ROR1,ROR2,ROR3,ROR4,.ROR5)
 I $G(ROR5)=-1 Q 0
 Q 1
 ;
TASKCHK(RORNAME) ;Function: Is option currently running? 
 ;Calls %ZTLOAD API with option name.
 ;  Input: RORNAME = option name (file 19, field .01)
 ; Output:  1 = task is running
 ;          0 = task is not running
 ;         -1 = error
 ;
 N RORARRAY,RORFLAG,ZTSK
 S RORFLAG=0
 S RORNAME=$G(RORNAME)
 I RORNAME="" Q -1
 D OPTION^%ZTLOAD(RORNAME,.RORARRAY) ;returns data in ^TMP($J)
 S ZTSK=0
 F  S ZTSK=$O(@RORARRAY@(ZTSK)) Q:'ZTSK  D  I $G(ZTSK(1))=2 S RORFLAG=1 Q
 . D STAT^%ZTLOAD
 ;don't want to K ^TMP($J). may kill something that is needed elsewhere.
 S ZTSK=0 F  S ZTSK=$O(@RORARRAY@(ZTSK)) Q:'ZTSK  K @RORARRAY@(ZTSK)
 Q RORFLAG
 ;
QSCHED ;Reschedule an option as a tasked job to avoid date/time from writing to the display
 D RESCH^XUTMOPT(RORNAME,ROR1,ROR2,ROR3,ROR4,.ROR5)
 Q
