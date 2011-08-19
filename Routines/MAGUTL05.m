MAGUTL05 ;WOIFO/SG - MISCELLANEOUS UTILITIES ; 3/9/09 12:53pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;##### PREPARES THE VALUE FOR INDIRECTION
 ;
 ; This function returns the value of the parameter prepared for
 ; indirect assignment:
 ;
 ;   * canonic numbers are returned as is;
 ;
 ;   * strings are enclosed in double quotes and double quotes inside 
 ;     them are doubled. ;-)
 ;
DDQ(VAL) ;
 N TMP  S TMP=$NA(A(VAL))
 Q $E(TMP,3,$L(TMP)-1)
 ;
 ;##### CHECKS IF THE TEXT BUFFER IS EMPTY
 ;
 ; MAG8NODE      Name of a local or global node that contains the
 ;               text (either in @MAG8NODE@(i) or in @MAG8NODE@(i,0)
 ;               sub-nodes).
 ;
 ; Notes
 ; =====
 ;
 ; This function considers a buffer containing just space characters
 ; as empty.
 ;
 ; Return Values
 ; =============
 ;            0  The buffer is not empty
 ;            1  The buffer is empty
 ;
ISWPEMPT(MAG8NODE) ;
 N MAG8EMPTY,MAG8I
 S MAG8I="",MAG8EMPTY=1
 F  S MAG8I=$O(@MAG8NODE@(MAG8I))  Q:MAG8I=""  D  Q:'MAG8EMPTY
 . I $G(@MAG8NODE@(MAG8I))'?." "  S MAG8EMPTY=0  Q
 . S:$G(@MAG8NODE@(MAG8I,0))'?." " MAG8EMPTY=0
 . Q
 Q MAG8EMPTY
 ;
 ;***** CHECKS IF A NEW PAGE SHOULD BE STARTED
 ;
 ; [RESERVE]     Number of reserved lines (1, by default).
 ;               If the current page does not have so many lines
 ;               available, a new page will be started.
 ;
 ; [FORCE]       Force the prompt
 ;
 ; Return Values
 ; =============
 ;           -2  Timeout
 ;           -1  User canceled the output ('^' was entered)
 ;            0  Continue
 ;            1  New page and continue
 ;
 ; Notes
 ; =====
 ;
 ; This entry point can also be called as a procedure:
 ; D PAGE^MAGUTL05(...) if you do not need its return value.
 ;
PAGE(RESERVE,FORCE) ;
 N RC
 I ($Y'<($G(IOSL,24)-$G(RESERVE,1)))!$G(FORCE)  D  S $Y=0
 . I $E(IOST,1,2)'="C-"  W @IOF  Q
 . N DA,DIR,DIROUT,DTOUT,DUOUT,I,X,Y
 . S DIR(0)="E"
 . D ^DIR
 . S RC=$S($D(DUOUT):-1,$D(DTOUT):-2,1:1)
 . Q
 ;---
 Q:$QUIT +$G(RC)  Q
 ;
 ;##### EMULATES $QUERY WITH 'DIRECTION' PARAMETER
 ;
 ; MAG8NODE       Name of a node
 ;
 ; [MAG8DIR]      Direction:
 ;                  $G(MAG8DIR)'<0  forward
 ;                  MAG8DIR<0       backward
 ;
Q(MAG8NODE,MAG8DIR) ;
 Q:$G(MAG8DIR)'<0 $Q(@MAG8NODE)
 N MAG8I,MAG8PI,MAG8TMP
 S MAG8TMP=$QL(MAG8NODE)  Q:MAG8TMP'>0 ""
 S MAG8I=$QS(MAG8NODE,MAG8TMP),MAG8PI=$NA(@MAG8NODE,MAG8TMP-1)
 ;--- Find the previous node on the "lowest" level.
 S MAG8I=$O(@MAG8PI@(MAG8I),-1)
 ;--- If there is none, then either return the parent node if it
 ;--- has data or perform the recursive query for the parent node.
 Q:MAG8I="" $S($D(@MAG8PI)#10:MAG8PI,1:$$Q(MAG8PI,-1))
 ;--- Otherwise, get the last "lowest" child node.
 F  S MAG8PI=$NA(@MAG8PI@(MAG8I))  Q:$D(@MAG8PI)<10  D
 . S MAG8I=$O(@MAG8PI@(""),-1)
 . Q
 Q MAG8PI
 ;
 ;##### "SENTENCE" CASE CONVERSION OF THE STRING
 ;
 ; STR           Source string
 ; 
 ; Return Values
 ; =============
 ;               The source string converted to lover case except the
 ;               first character, which is converted to upper case.
 ;
SNTC(STR) ;
 Q $$UP^XLFSTR($E(STR))_$$LOW^XLFSTR($E(STR,2,$L(STR)))
 ;
 ;##### TRANSLATES CONTROL FLAGS
 ;
 ; FLAGS         Source flags
 ;
 ; SRC           All characters that are not included in the value
 ;               of the SRC parameter are removed from the string
 ;               passed in the FLAGS parameter.
 ;
 ; [DST]         If the DST parameter is defined and not empty, then
 ;               flags defined by the SRC parameter are translated to 
 ;               their counterparts in this parameter (see the
 ;               $TRANSLATE function for additional details).
 ;
TRFLAGS(FLAGS,SRC,DST) ;
 N TMP
 ;--- Get flags that are not included in the SRC
 S TMP=$TR(FLAGS,SRC)
 ;--- Remove these flags
 S TMP=$TR(FLAGS,TMP)
 ;--- Translate valid flags if necessary
 Q $S($G(DST)'="":$TR(TMP,SRC,DST),1:TMP)
 ;
 ;##### TRUNCATES THE STRING AND APPENDS "..."
 ;
 ; STR           Source string
 ; MAXLEN        Maximum allowed length
 ;
TRUNC(STR,MAXLEN) ;
 Q $S($L(STR)>MAXLEN:$E(STR,1,MAXLEN-3)_"...",1:STR)
 ;
 ;##### CHECKS IF THE PARAMETER VALUE IS A VALID PATIENT IEN (DFN)
 ;
 ; DFN           Internal Entry Number of the patient record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ;               After a successful call, this parameter is empty.
 ;
 ;               These descriptors are NOT stored regarless of the
 ;               mode set by the CLEAR^MAGUERR. If you need to store
 ;               them (e.g. to return from an RPC), then you have to
 ;               do this in your code (see the STORE^MAGUERR).
 ;
 ; Return Values
 ; =============
 ;            0  Parameter value is not a valid patient IEN (DFN);
 ;               check the value of the ERR parameter for details.
 ;            1  Ok
 ;
 ;
VALDFN(DFN,ERR) ;
 S ERR=""
 I (DFN'>0)!(+DFN'=DFN)  S ERR=$$ERROR^MAGUERR("-3S",,"DFN",DFN)  Q 0
 I '($D(^DPT(DFN,0))#2)  S ERR=$$ERROR^MAGUERR("-5S",,DFN)        Q 0
 Q 1
 ;
 ;##### VALIDATES THE IENS
 ;
 ; IENS          IENS of a record or a subfile; placeholders are not
 ;               allowed (see FileMan DBS API manual for details).
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  Subfile IENS are allowed
 ;
 ; Return Values
 ; =============
 ;            0  Invalid IENS
 ;            1  Ok
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
 ;##### CREATES/UPDATES THE NODE HEADER IN THE ^XTMP GLOBAL
 ;
 ; SUBSCR        Subscript of the node in the ^XTMP global
 ; [DKEEP]       Number of days to keep the node (1 by default)
 ; [DESCR]       Description of the node
 ;
XTMPHDR(SUBSCR,DKEEP,DESCR) ;
 N DATE  S DATE=$$DT^XLFDT  S:$G(DKEEP)'>0 DKEEP=1
 S ^XTMP(SUBSCR,0)=$$FMADD^XLFDT(DATE,DKEEP)_U_DATE_U_$G(DESCR)
 Q
