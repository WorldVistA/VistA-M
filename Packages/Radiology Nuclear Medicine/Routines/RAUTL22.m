RAUTL22 ;HCIOFO/SG - GENERAL UTILITIES ; 2/24/09 3:13pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; Error codes -3, -8, and -10 can be returned by entry points of this
 ; routine. Therefore, if you export this routine, then the dialogs
 ; #700000.003, #700000.008, and 700000.01 should be exported as well.
 ;
 Q
 ;
 ;***** CHECKS IF ALL VARIABLES FROM THE LIST ARE NOT EMPTY
 ;
 ; ZZLST         List of variable names separated by commas
 ;
 ; [ZZFLAGS]     Flags that control the execution (can be combined):
 ;
 ;                 V  By default, error messages (-8 and -10)
 ;                    reference parameters. If this flag is provided,
 ;                    then the messages that reference variable/nodes
 ;                    (-56 and -57) are used.
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
CHKREQ(ZZLST,ZZFLAGS) ;
 N ZZCNT,ZZI,ZZL,ZZVAR
 S ZZL=$L(ZZLST,","),ZZCNT=0
 F ZZI=1:1:ZZL  S ZZVAR=$P(ZZLST,",",ZZI)  D:ZZVAR'=""
 . I $G(@ZZVAR)?." "  D  S ZZCNT=ZZCNT+1
 . . D ERROR^RAERR($S($G(ZZFLAGS)["V":-56,1:-8),,ZZVAR)
 Q $S(ZZCNT>0:$$ERROR^RAERR($S($G(ZZFLAGS)["V":-57,1:-10)),1:0)
 ;
 ;***** RETURNS FORMATTED TEXT OF THE DIALOG
 ;
 ; DLGNUM        Dialog number (file #.84)
 ;
 ; [.PARAMS]     Reference of a local array containing parameters for 
 ;               the BLD^DIALOG.
 ;
 ; [DIWR]        The right margin for the text. Default: 75.
 ;
 ; [DIWF]        Flags that control the execution (can be combined).
 ;
 ;                 A  Append the text to the buffer. By default,
 ;                    the output buffer is cleared in the beginning
 ;                    of each call to DLGTXT.
 ;
 ;                 S  Suppress blank lines added between chunks of
 ;                    text appended to the buffer. A blank line is
 ;                    never inserted if the buffer is empty.
 ;
 ;                 Any format control parameters supported by the
 ;                 ^DIWP except "I" and "W" can also be used.
 ;
 ; Return values:
 ;   Closed root of the node in the ^UTILITY global that contains
 ;   formatted text (output of the ^DIWP). Caller should KILL this
 ;   node after retrieving the text.
 ;
DLGTXT(DLGNUM,PARAMS,DIWR,DIWF) ;
 N DIWL,RA8BUF,RAI,X
 S DIWL=1  S:$G(DIWR)'>0 DIWR=75
 ;--- Check the flags
 S DIWF=$G(DIWF)
 I DIWF["A"  D:DIWF'["S"
 . S:$G(^UTILITY($J,"W",DIWL))>0 RA8BUF(1)=" "
 E  K ^UTILITY($J,"W")
 ;--- Load the text
 D BLD^DIALOG(DLGNUM,.PARAMS,,"RA8BUF","S")
 ;--- Remove the "A", "I", "S", and "W" flags
 S DIWF=$TR($G(DIWF),"ASW")
 F  S RAI=$F(DIWF,"I")  Q:'RAI  D  S $E(DIWF,RAI-1,X-1)=""
 . F X=RAI:1  Q:$E(DIWF,X)'?1N
 ;--- Reformat the text
 S RAI=""
 F  S RAI=$O(RA8BUF(RAI))  Q:RAI=""  S X=RA8BUF(RAI)  D ^DIWP
 ;---
 Q $NA(^UTILITY($J,"W",DIWL))
 ;
 ;***** CHECKS IF THE DATE IS EXACT (INCLUDES MONTH AND DAY)
 ;
 ; DTE           Date/time (FileMan)
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Date is not exact
 ;        1  Date is exact
 ;
ISEXCTDT(DTE) ;
 N TMP  S TMP=$G(DTE)\1
 Q:(TMP<1000000)!(TMP>9991231) $$IPVE^RAERR("DTE")
 Q ($E(TMP,4,5)>0)&($E(TMP,6,7)>0)
 ;
 ;***** CHECKS IF THE TEXT BUFFER IS EMPTY
 ;
 ; RA8NODE       Name of a local or global node that contains the
 ;               text (either in @RA8NODE@(i) or in @RA8NODE@(i,0)
 ;               sub-nodes).
 ;
 ; NOTE: This function considers a buffer containing just space
 ;       characters as empty.
 ;
 ; Return values:
 ;        0  The buffer is not empty
 ;        1  The buffer is empty
 ;
ISWPEMPT(RA8NODE) ;
 N RA8EMPTY,RA8I
 S RA8I="",RA8EMPTY=1
 F  S RA8I=$O(@RA8NODE@(RA8I))  Q:RA8I=""  D  Q:'RA8EMPTY
 . I $G(@RA8NODE@(RA8I))'?." "  S RA8EMPTY=0  Q
 . S:$G(@RA8NODE@(RA8I,0))'?." " RA8EMPTY=0
 Q RA8EMPTY
 ;
 ;***** CHECKS IF A NEW PAGE SHOULD BE STARTED
 ;
 ; [RESERVE]     Number of reserved lines (1, by default).
 ;               If the current page does not have so many lines
 ;               available, a new page will be started.
 ;
 ; [FORCE]       Force the prompt
 ;
 ; Return values:
 ;
 ;       -2  Timeout
 ;       -1  User canceled the output ('^' was entered)
 ;        0  Continue
 ;        1  New page and continue
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D PAGE^RAUTL22(...) if you do not need its return value.
 ;
PAGE(RESERVE,FORCE) ;
 Q:$G(XPDNM)'="" 0  ; KIDS pre/post-install
 ;---
 N RC
 I ($Y'<($G(IOSL,24)-$G(RESERVE,1)-1))!$G(FORCE)  D  S $Y=0
 . I $E(IOST,1,2)'="C-"  W @IOF  Q
 . N DA,DIR,DIROUT,DTOUT,DUOUT,I,X,Y
 . S DIR(0)="E"
 . D ^DIR
 . S RC=$S($D(DUOUT):-1,$D(DTOUT):-2,1:1)
 ;---
 I $G(RC)<0  D:$G(RAPARAMS("PAGECTRL"))["E"
 . S $ECODE=$S(RC=-2:",UTIMEOUT,",1:",UCANCEL,")
 ;---
 Q:$QUIT +$G(RC)  Q
 ;
 ;***** TRANSLATES FLAGS
 ;
 ; FLAGS         Source flags
 ;
 ; SRC           Source and destination patterns for translation
 ; DST           (see the $TRANSLATE function for details).
 ;
 ; This function works similarly to the $TRANSLATE but it removes
 ; those flags (characters) that are not included in the SRC.
 ;
TRFLAGS(FLAGS,SRC,DST) ;
 N TMP
 ;--- Get flags that are not included in the SRC
 S TMP=$TR(FLAGS,SRC)
 ;--- Remove these flags
 S TMP=$TR(FLAGS,TMP)
 ;--- Translate valid flags
 Q $TR(TMP,SRC,DST)
 ;
 ;***** TRUNCATES THE STRING AND APPENDS "..."
 ;
 ; STR           Source string
 ; MAXLEN        Maximum allowed length
 ;
TRUNC(STR,MAXLEN) ;
 Q $S($L(STR)>MAXLEN:$E(STR,1,MAXLEN-3)_"...",1:STR)
 ;
 ;***** VALIDATES THE IENS
 ;
 ; IENS          IENS of a record or a subfile; placeholders are not
 ;               allowed (see FileMan DBS API manual for details).
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  Subfile IENS are allowed
 ;
 ; Return Values:
 ;        0  Invalid IENS
 ;        1  Ok
 ;
VALIENS(IENS,FLAGS) ;
 N I,L,IEN,RC
 S L=$L(IENS,",")
 ;--- The last piece should be empty (trailing comma is required)
 Q:$P(IENS,",",L)'="" 0
 ;--- The first piece should be either a canonic number or empty
 S I=$S(($P(IENS,",")="")&($G(FLAGS)["S"):2,1:1)
 ;--- All pieces in between should be canonic numbers
 S RC=1
 F I=I:1:L-1  S IEN=$P(IENS,",",I)  I (IEN'>0)!(+IEN'=IEN)  S RC=0  Q
 Q RC
 ;
 ;***** WRITES THE MESSAGE (ACCORDING TO THE ENVIRONMENT)
 ;
 ; MSG           Message
 ;
 ; [SKIP]        If this parameter is defined and non-zero, then an
 ;               empty line is written above the message.
 ;
W(MSG,SKIP) ;
 I $D(XPDENV)!($G(XPDNM)="")  W:$G(SKIP) !  W !,MSG  Q
 I $G(SKIP)  D BMES^XPDUTL(MSG)  Q
 D MES^XPDUTL(MSG)
 Q
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
 ; ZZ8NODE       Closed root of the sub-tree to display
 ;               (either local array or global variable)
 ;
 ; [ZZ8TTL]      Title of the output
 ;
 ; [ZZ8FLG]      Flags that control the execution (can be combined):
 ;
 ;                 N  Do not print node names
 ;
 ;                 P  Paginate the output
 ;
 ;                 S  Skip a line before the output
 ;
ZW(ZZ8NODE,ZZ8TTL,ZZ8FLG) ;
 Q:ZZ8NODE=""  Q:'$D(@ZZ8NODE)
 N ZZ8FLT,ZZ8L,ZZ8PI,ZZ8RC
 S ZZ8FLG=$G(ZZ8FLG),ZZ8RC=0
 ;
 ;--- Skip a line before the output
 I ZZ8FLG["S"  D  Q:ZZ8RC<0
 . I ZZ8FLG["P"  S ZZ8RC=$$PAGE(1)  Q:ZZ8RC<0
 . W !
 ;
 ;--- Write the title (if provided)
 I $G(ZZ8TTL)'=""  D  Q:ZZ8RC<0
 . I ZZ8FLG["P"  S ZZ8RC=$$PAGE(2)  Q:ZZ8RC<0
 . W !,ZZ8TTL,!
 ;
 ;--- Write the root node's value (if defined)
 I $D(@ZZ8NODE)#10  D  Q:ZZ8RC<0
 . I ZZ8FLG["P"  S ZZ8RC=$$PAGE()  Q:ZZ8RC<0
 . W !  W:ZZ8FLG'["N" ZZ8NODE_"="  W """"_@ZZ8NODE_""""
 ;
 ;--- Write values of sub-nodes
 S ZZ8L=$L(ZZ8NODE)  S:$E(ZZ8NODE,ZZ8L)=")" ZZ8L=ZZ8L-1
 S ZZ8FLT=$E(ZZ8NODE,1,ZZ8L),ZZ8PI=ZZ8NODE
 F  S ZZ8PI=$Q(@ZZ8PI)  Q:$E(ZZ8PI,1,ZZ8L)'=ZZ8FLT  D  Q:ZZ8RC<0
 . I ZZ8FLG["P"  S ZZ8RC=$$PAGE()  Q:ZZ8RC<0
 . W !  W:ZZ8FLG'["N" ZZ8PI_"="  W """"_@ZZ8PI_""""
 Q
