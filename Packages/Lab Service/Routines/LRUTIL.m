LRUTIL ;DALOI/JDB -- Lab Utilities ;Aug 15, 2008
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;File ^XUSEC/10076
 Q
 ;
SELECT(DIC,OUT,FNAME,SELS,SORT,NOALL,MODE) ;
 ; convenience method
 ; Package replacement for FIRST^VAUTOMA
 ; Allows user to select multiple entries from a file.
 Q $$SELECT^LRUTIL1(.DIC,.OUT,FNAME,SELS,SORT,NOALL,MODE)
 ;
 ;
GETLOCK(ZZZZTARG,ZZZZSECS,ZZZZSHOW) ;
 ; Acquire a Lock on the specified resource.
 ; Note: "ZZZ*" variable names used to avoid possible variable
 ;  name clashes with @TARG -- "^GBL(1,X)" N X then @TARG would
 ;  change the intended resource for lock since X would be different.
 ; Inputs
 ;   TARG : The Resource to Lock (ie "^GBL(1)")
 ;   SECS : Total # of seconds to wait for the lock
 ;        :  (Minimum value is 5 seconds)
 ;        : Negative value means one solid wait (no breaks)
 ;   SHOW : >0:show progress, 0:dont show progress
 ;        :    1:dots  2:countdown  3: timeleft+dots
 ; Output
 ;         1 if lock obtained, 0 if not.
 ;         If SHOW>0 API outputs progress info
 ;
 N ZZZZZZZI,ZZZZLOCK,ZZZTRIES,ZZZZZZTO
 S ZZZZLOCK=0
 S ZZZZTARG=$G(ZZZZTARG)
 S ZZZZSECS=+$G(ZZZZSECS)
 S ZZZZSHOW=+$G(ZZZZSHOW)
 S ZZZZZZTO=$G(DILOCKTM,5) ;timeout
 S:ZZZZZZTO<5 ZZZZZZTO=5
 I ZZZZSECS'<0 I ZZZZSECS<5 S ZZZZSECS=5
 S ZZZTRIES=ZZZZSECS/ZZZZZZTO
 S:ZZZTRIES["." ZZZTRIES=$P(ZZZTRIES,".",1)+1
 ;
 I ZZZZSECS>0 F ZZZZZZZI=1:1:ZZZTRIES L +(@ZZZZTARG):ZZZZZZTO S:$T ZZZZLOCK=1 Q:ZZZZLOCK  D  ;
 . I ZZZTRIES>1 I ZZZZSHOW D  ;
 . . Q:$$ISQUIET()
 . . I ZZZZSHOW=3 W:ZZZZZZZI=1 " ",ZZZTRIES-1*ZZZZZZTO W "."
 . . I ZZZZSHOW=2 W " ",(ZZZTRIES-ZZZZZZZI)*ZZZZZZTO
 . . I ZZZZSHOW=1 W "."
 ;
 I ZZZZSECS<0 D  ;
 . S ZZZZSECS=-ZZZZSECS
 . S:ZZZZSECS<ZZZZZZTO ZZZZSECS=ZZZZZZTO
 . L +(@ZZZZTARG):ZZZZSECS
 . S:$T ZZZZLOCK=1
 ;
 Q ZZZZLOCK
 ;
 ;
QUE(ZTRTN,ZTDESC,ZTSAVE,NOQUE,QUIET) ;
 ; Prompts for Device and allows queueing a routine
 ; Inputs
 ;   ZTRTN :
 ;  ZTDESC :
 ;  ZTSAVE : <byref>
 ;   NOQUE : 1=no queue  0=allow queue
 ; Outputs
 ; Returns -1 if POP=1, 0 if not queued, or the QUEUED task #
 N %ZIS,POP,QUEUED,Y,X,%X,%Y
 ; New variables for protection from %ZIS and DIR collision
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%N,%P,%S,%T,%W,%X,%Y
 N A0,C,D,DD,DDH,DDQ,DDSV,DG,DH,DIC,DIFLD,DIRO,DO,DP,DQ,DU,DZ,X1
 N XQH,DIX,DIY,DISYS,%BU,%J1,%A0,%W0,%D1,%D2,%DT,%K,%M
 ;
 S NOQUE=$G(NOQUE)
 S QUIET=$G(QUIET)
 S QUEUED=0
 S %ZIS="M"
 I 'NOQUE S %ZIS=%ZIS_"Q"
 D ^%ZIS
 I POP D HOME^%ZIS Q -1
 I $D(IO("Q")) D  ;
 . S QUEUED=$$TASK(ZTRTN,ZTDESC,.ZTSAVE,QUIET)
 . D HOME^%ZIS
 . K IO("Q")
 Q QUEUED
 ;
 ;
TASK(ZTRTN,ZTDESC,ZTSAVE,QUIET,ZTDTH,ZTIO) ;
 ; Tasks the specified routine
 ; Returns the task # or 0
 ;  ZTSAVE:<byref>
 N ZTSK,X,X1,X2,DIE,DIR,DIC,DA
 S QUIET=$G(QUIET)
 D ^%ZTLOAD
 I 'QUIET I '$$ISQUIET W !,"Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued")
 Q +$G(ZTSK)
 ;
 ;
ISQUIET() ;
 ; Is "Quiet" or not (Should we Write output?)
 N QUIET
 S QUIET=0
 S:$G(LRQUIET) QUIET=1
 S:$G(DIQUIET) QUIET=1
 Q QUIET
 ;
 ;
RDELTSK(LRDELRTN,ZTDESC,ZTDTH) ;
 ; Delete routines via a tasked job it creates
 ; Inputs
 ;  LRDELRTN: <byref> Array that holds the routines to delete
 ;    ZTDESC: <opt> Description to use for tasked job
 ;     ZTDTH: <opt> Date/Time (in $H) for job to run
 ; Outputs
 ;   The task number
 N QUE,ZTSAVE
 S ZTDESC=$G(ZTDESC)
 I ZTDESC="" S ZTDESC="Delete routines via tasked job"
 S ZTSAVE("LRDELRTN")=""
 S ZTSAVE("LRDELRTN(")=""
 S ZTSAVE("XPD*")="" ;called from a patch install?
 S QUE=$$TASK("DELRTNS^LRUTIL(,1)",ZTDESC,.ZTSAVE,"",$G(ZTDTH),"")
 Q QUE
 ;
 ;
DELRTNS(RTNS,USELRDEL) ;
 ; Delete routines
 ; Useful for deleting routines via TaskMan
 ; For easier use with TaskMan, the LRDELRTN array can also be
 ; setup prior to calling with TaskMan to delete multiple routines.
 ;  Inputs
 ;      RTNS : <byref> The routine(s) to delete
 ;           :  RTNS="rtn" or  RTNS("rtn")="" or RTNS(#)=rtn
 ;  USELRDEL : 1=use LRDELRTN array 0=dont use 
 ;           : Setup array LRDELRTN(rtn) or LRDELRTN(#)=rtn
 ;           : and then call.
 ;  LRDELRTN : <symtbl><opt> Array of routines to delete
 N X,I,DEL,RTN
 S RTNS=$G(RTNS)
 S USELRDEL=$G(USELRDEL)
 ; Honor KIDS "No Delete" setting if called from a KIDS install.
 I $G(XPDNM)'="" I $$GET^XUPARAM("XPD NO_EPP_DELETE") D  Q  ;
 . I $D(ZTQUEUED) S ZTREQ="@"
 ;
 I RTNS'="" S DEL=RTNS
 S I=""
 F  S I=$O(RTNS(I)) Q:I=""  D  ;
 . I RTNS(I)="" S DEL(I)=""
 . I RTNS(I)'="" S DEL(RTNS(I))=""
 ;
 S I=""
 I USELRDEL I $D(LRDELRTN) F  S I=$O(LRDELRTN(I)) Q:I=""  D  ;
 . I LRDELRTN(I)="" S DEL(I)=""
 . I LRDELRTN(I)'="" S DEL(LRDELRTN(I))=""
 ; now delete
 S RTN=""
 F  S RTN=$O(DEL(RTN)) Q:RTN=""  D  ;
 . Q:"^LR^LA^"'[("^"_$E(RTN,1,2)_"^")
 . S X=RTN
 . X ^%ZOSF("TEST")
 . Q:'$T
 . X ^%ZOSF("DEL")
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
NP(ABORT,PGDATA) ;
 ; Next Page Handler
 ; Generic display utility.  Prints HDR and FTR when needed.
 ; Caller should check ABORT and terminate when 1.
 ; Caller needs to make initial call to their HDR code
 ; and to call their FTR code at end if needed.
 ; Note: Header code should place cursor on start
 ; of newline when done.
 ; Inputs
 ;  ABORT : <byref> Equals 1 if user enters "^" at "MORE" prompt
 ; PGDATA : <byref> Page Data array
 ;        :  "PGNUM": current page number
 ;        :  "BM": Bottom Margin (# of lines in footer)
 ;        :  "HDR": Executable M code for header
 ;        :  "FTR": Executable M code for footer
 ;        : "NOPROMPT": Dont show "more" prompt (0 or 1) <dflt=0>
 ;        :  "PROMPT": (string) Replacement for "More" prompt
 ;        :  "PROMPTX": Executable M code to run for "More" prompt
 ;        :    The M Code must set var X equal to the prompt to use.
 ;        :  "WFTR": the footer was written (=1)
 ;        :  "ERASE": Erase MORE prompt (1=Erase 0=Dont erase dflt=1)
 ;        :  "IOF": <opt>IOF control.
 ;        :   IOF=0: IOF not issued for non "C-" type devices.
 ;        :   IOF=1: IOF issued for "C-" type devices.
 ;Outputs
 ;  ABORT : 0 or 1 if user wants to quit display
 ; PGDATA : "PGNUM" incremented as needed
 ;        : "WFTR" = 1 if footer was written
 ;        : "NP": Is it a "New Page"? (Was "MORE" prompt displayed)
 ;
 ;
 ; Example code to write last footer if needed
 ; I 'STOP I '$G(PGDATA("WFTR")) D  ;
 ; . I $G(PGDATA("FTR"))="" Q
 ; . I $E($G(IOST),1,2)'="C-" D  ;
 ; . . N I,BM
 ; . . S BM=$G(PGDATA("BM"))
 ; . . F I=$Y+1:1:($G(IOSL,60)-BM-1) W !
 ; . X PGDATA("FTR")
 ;
 N X,PGNUM,BM,HDR,FTR,INHDR,INFTR,ERASE
 S ABORT=$G(ABORT)
 S PGNUM=$G(PGDATA("PGNUM"))
 S BM=$G(PGDATA("BM"))
 S PGDATA("WFTR")=0
 S PGDATA("NP")=0
 I PGNUM<1 S PGNUM=1 S PGDATA("PGNUM")=PGNUM
 Q:ABORT
 I BM<0 S BM=0
 I $Y+1<($G(IOSL,24)-BM) Q
 ;
 S HDR=$G(PGDATA("HDR"))
 S FTR=$G(PGDATA("FTR"))
 S ERASE=$G(PGDATA("ERASE"),1)
 S (INHDR,INFTR)=0
 S PGDATA("NP")=1
 ;
 I FTR'="" I 'INFTR D  ;
 . N POSY
 . S POSY=$Y
 . S INFTR=1
 . X FTR
 . S PGDATA("WFTR")=1
 . S INFTR=0
 . ;handle form feed
 . I $G(IOF)'="",POSY<$Y D
 . . I $E(IOST,1,2)="C-",$G(PGDATA("IOF"))="1" W @IOF
 . . ;
 . . I $E($G(IOST),1,2)'="C-",$G(PGDATA("IOF"))'="0" W @IOF
 ;
 ; do "MORE" prompting
 I $E($G(IOST),1,2)="C-" D  Q:ABORT  ;
 . Q:$G(PGDATA("NOPROMPT"))
 . S X=0
 . Q:$D(ZTQUEUED)
 . I $G(PGDATA("PROMPTX"))'="" D  ;
 . . K X
 . . X PGDATA("PROMPTX")
 . . S X=$G(X)
 . . S ABORT=$$MORE(X,ERASE)
 . ;
 . I $G(PGDATA("PROMPTX"))="" S ABORT=$$MORE($G(PGDATA("PROMPT")),ERASE)
 . ;
 ;
 S $Y=0
 S PGNUM=PGNUM+1
 S PGDATA("PGNUM")=PGNUM
 I HDR'="",'INHDR D  ;
 . S INHDR=1
 . X HDR
 . S INHDR=0
 Q
 ;
 ;
MORE(PROMPT,ERASE) ;
 ; Prompts user to hit ENTER to continue
 ; Returns 1 if user enters "^" else returns 0
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S PROMPT=$G(PROMPT)
 S ERASE=$G(ERASE,1)
 I '$D(ZTQUEUED) D  ;
 . I $E($G(IOST),1,2)'="C-" Q
 . S DIR(0)="E"
 . I PROMPT'="" S DIR("A")=PROMPT S DIR(0)="EA"
 . D ^DIR
 . I ERASE W $C(13)_$J("",$G(IOM,80))_$C(13)
 I $Q Q $D(DIRUT)
 Q
 ;
 ;
DATAOK(LRFILE,LRFLD,LRVAL) ;
 ; Checks if a value is appropriate for storing in the field
 ; Inputs
 ;  LRFILE : File #
 ;   LRFLD : Field #
 ;   LRVAL : Value of the field
 ;
 ; Returns 0 (invalid) or 1 (valid)
 ;
 N STATUS,LROUT,LRMSG,DIERR
 S STATUS=0
 D CHK^DIE(LRFILE,LRFLD,"",LRVAL,.LROUT,"LRMSG")
 I $G(LROUT)'="^" S STATUS=1
 I $D(LRMSG) S STATUS=0
 Q STATUS
 ;
 ;
OWNSKEY(KEY,IEN) ;
 ;File ^XUSEC/10076
 ; Does user own specific key?
 ; Inputs
 ;   KEY:  The Key's NAME
 ;   IEN:  User's IEN <dflt=DUZ>
 ; Outputs
 ;   Returns 1 if user owns key, 0 otherwise.
 ;
 N LRLIST,LROWNS
 S LRLIST(1)=KEY,IEN=$G(IEN,$G(DUZ))
 D OWNSKEY^XUSRB(.LROWNS,.LRLIST,IEN)
 ;
 Q +$G(LROWNS(1))
