TIUDTBP0 ;AITC/CR/SGM - BOOKMARK TIU NOTE AFTER DOWNTIME ;8/20/18 4:02pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**305**;JUN 20, 1997;Build 27
 ;
 ;  Last Edited: 09/22/2017 09:46 / Leidos/sgm
 ;  *** This routine only invoked by routine TIUDTBPN ***
 ;  Pertinent programmer notes at the end of this routine
 ;
 ; ICR Documentation for the TIUDTBP0 and TIUDTBPN routines
 ; ICR#    TYPE   DESCRIPTION
 ;-----  -------  -------------------------------------------
 ;  358  ContSub  File 405, Read access to fields and assoc. indexes
 ;                  Field #.02, transaction_type = 3^Discharge
 ;                              Cross_ref: ^DGPM("ATT3",d/t,da)=""
 ;                Flds: .01,.02,.04,.06,.07,.08,.09,.1,.11,.12,.18,.19
 ;  664  ContSub  DIVISION^VAUTOMA [TIU a subscriber]
 ; 1519  Sup      XUTMDEVQ: EN, $$NODEV
 ; 1557  Sup      $$ESBLOCK^XUSESIG1
 ; 2051  Sup      $$FIND1^DIC
 ; 2056  Sup      $$GET1^DIQ
 ; 2325  ContSub  $$CANDO^USRLA [TIU a subscriber]
 ; 2343  Sup      ^XUSER: $$ACTIVE, $$NAME, $$LOOKUP
 ; 3104  Private  File 8930.8, .01 field lookup of name
 ; 3869  ContSub  GETPLIST^SDAMA202 [TIU a subscriber]
 ;10006  Sup      ^DIC
 ;10026  Sup      ^DIR
 ;10028  Sup      EN^DIWE
 ;10035  Sup      File 2, multiple fields and their indexes
 ;                  fields: .01, .105, "ACA" index
 ;10039  Sup      File 42, Fileman lookup, fields .01, .015, 44
 ;10040  Sup      File 44, Fileman lookup, fields 2505,2506, "B" index
 ;10050  Sup      SIG^XUSESIG
 ;10060  Sup      File 200, all fields accessible by FM
 ;10061  Sup      IN5^VADPT
 ;10070  Sup      ^XMD
 ;10103  Sup      ^XLFDT: $$DOW, $$FMDIFF, $$FMTE, $$NOW
 ;10104  Sup      ^XLFSTR: $$CJ, $$UP
 ;10142  Sup      EN^DDIOL
 ;
 ;
 ;=====================================================================
 ;          DIC Lookup Module
 ;---------------------------------------------------------------------
DIC(LIN) ;  extrinsic function
 ; return -2:timeout, -1:'^'-out,  null/selection
 ; this calls returns the value of X
 N I,X,Y,DIC,DTOUT,DUOUT,LAB
 I LIN=1 D
 . ;   select note title
 . D TEXT("T2",1,12)
 . S DIC=8925.1,DIC(0)="AEMQ"
 . S DIC("S")="I $$GET1^DIQ(8925.1,+Y,1501)=""COMPUTER DOWNTIME"""
 . S Y=$$DICALL I Y>0 S TIUD("TITLE")=+Y,TIUD("TITLE",0)=$P(Y,U,2)
 . S X=(Y>0)
 . Q
 I LIN=2 D
 . ;   select signer/author of note, only active users
 . ;   with admin closure, author not required to be ASU certified
 . S DIC("S")="I +$$ACTIVE^XUSER(+Y)"
 . I TIUD("TYPE")="E" D
 . . N X,Y,EVENT,STAT,TX
 . . S STAT=$$FIND1(8925.6,,,"UNSIGNED") Q:STAT<1
 . . S EVENT=$$FIND1(8930.8,,,"SIGNATURE") Q:STAT<1
 . . S X=",$$CANDO^USRLA("_TIUD("TITLE")_","_STAT_","_EVENT_",+Y)"
 . . S DIC("S")=DIC("S")_X
 . . D TEXT("T15",0,0,0,0,,.TX) M DIC("A")=TX
 . . Q
 . S DIC=200,DIC(0)="AEMQ"
 . S DIC("A")="Who will be the AUTHOR of the note? "
 . S DIC("B")=$$UP^XLFSTR($$NAME^XUSER(DUZ,"F"))
 . S Y=$$DICALL I Y>0 S TIUD("SIGN")=+Y,TIUD("SIGN",0)=$P(Y,U,2)
 . S X=(Y>0)
 . Q
 I LIN=3 D
 . ;  select clinics to get notes
 . I $G(TIUD("CLSEL"))'=1 S X=1 Q
 . N INC,TIUDIC
 . S TIUDIC=44,TIUDIC(0)="QAEM"
 . S TIUDIC("A")="Select HOSPITAL LOCATION for Outpatient Notes: "
 . S X=TIUD("TIMS"),Y=TIUD("TIME")
 . S TIUDIC("S")="I $$DIC31^TIUDTBP0"
 . ;    this FOR loop will actually get all the selected locations
 . F INC=1:1 D  Q:Y<1
 . . K DIC M DIC=TIUDIC
 . . S Y=$$DICALL Q:Y<1  S TIUD("CLSEL",+Y)=$P(Y,U,2)
 . . I INC=1 S TIUDIC("A")="Select another HOSPITAL LOCATION: "
 . . Q
 . S X=+$O(TIUD("CLSEL",0)) ;   if no clinics selected, abort
 . Q
 I LIN=4 D
 . ;  select mail recipients
 . N INC,TIUDIC
 . D TEXT("T4",1,,,3)
 . S TIUDIC=200,TIUDIC(0)="QAEM"
 . S X="I $S($D(TIUD(""MAIL"",+Y)):0,DUZ=+Y:0,(Y>0&(Y<1)):1,1:$$ACTIVE^XUSER(+Y))>0"
 . S TIUDIC("S")=X
 . S Y=0 F INC=1:1 D  Q:Y<.5
 . . K DIC M DIC=TIUDIC
 . . S Y=$$DICALL Q:Y<.5  S TIUD("MAIL",+Y)=$P(Y,U,2)
 . . I INC=1 S TIUDIC("A")="Select another NEW PERSON NAME: "
 . . Q
 . S X=$S(Y<-1:0,1:1) I X S TIUD("MAIL",DUZ)=""
 . Q
 Q X
 ;
DICALL() ;
 N X,Y,D0,DA,DTOUT,DUOUT
 D ^DIC S:$D(DTOUT) Y=-3 S:$D(DUOUT) Y=-2
 Q Y
 ;
DIC31() ;
 ;  Called from ^DIC("S"), naked is set and Y is ien
 ;  Expects TIUD("TIMS") & TIUD("TIME")
 ;  If no date range, default to T @0000 - @2400
 ;  "I" node is inactive_dt^reactivated_dt
 ;  Do not allow selection of a clinic more than once
 ;  Return 1 if clinic is allowed
 N Z,ED,ST
 S ST=+$G(TIUD("TIMS")) I 'ST S ST=DT
 S ED=+$G(TIUD("TIME")) S:ED<ST ED=ST S:ED?7N ED=ED+.25
 S Z=$G(^("I"))
 S ST(0)=+Z,ED(0)=+$P(Z,U,2)
 I $D(TIUD("CLSEL",+Y)) S Z=0 ;  prevent picking twice
 I 'ST(0) S Z=1
 I ST(0)>0 D  ;                  has inactive date
 . I ST(0)'<ED S Z=1 Q  ;        inactive>downtime_end
 . I 'ED(0),ST(0)'>ST S Z=0 Q  ; inactive =< downtime start, no react
 . I ED(0),ED(0)'>ST S Z=1 Q  ;  reactivate =< downtime start
 . S Z=1 ;                    inact>downtime_start,react<downtime_end
 . Q
 Q Z
 ;
 ;=====================================================================
 ;          DIR PROMPTER
 ;=====================================================================
DIR(LIN) ;  extrinsic function
 ;  call returns the value of X
 ;  -3:timeout, -2:'^'-out,  null or value
 N X,Y,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I LIN=1 D
 . S DIR(0)="SOA^S:SCHEDULED;U:UNSCHEDULED"
 . S DIR("A")="Was the downtime (S)cheduled or (U)nscheduled? "
 . S X=0,Y=$$DIRCALL I $S(Y'?1U:0,"SU"'[Y:0,1:1) D  S Y=1
 . . S TIUD("SCH")=Y,TIUD("SCH",0)=$S(Y="S":"A ",1:"An un")_"scheduled"
 . . Q
 . S X=(Y=1)
 . Q
 I LIN=2 D
 . S X=$G(TIUD("TIMS"))
 . S DIR(0)="DOA^:"_$E($$NOW^XLFDT,1,12)_":AEPR"
 . S DIR("A")="What was the starting time of the outage? "
 . S X=0,Y=$$DIRCALL
 . I Y>0 S TIUD("TIMS")=Y,TIUD("TIMS",0)=$$DIRTIM(Y)
 . S X=(Y>0)
 . Q
 I LIN=3 D
 . N MAX,MIN
 . S X=$G(TIUD("TIMS")),(MAX,MIN)=""
 . S MIN=$G(TIUD("TIMS")),MAX=$E($$NOW^XLFDT,1,12)
 . S DIR(0)="DOA^"_MIN_":"_MAX_":AEPR"
 . S DIR("A")="What was the ending time of the outage? "
 . S X=0,Y=$$DIRCALL
 . I Y>0 S TIUD("TIME")=Y,TIUD("TIME",0)=$$DIRTIM(Y)
 . S X=(Y>0)
 . Q
 I LIN=4 D
 . S DIR(0)="DOA^::AETP"
 . S DIR("A")="What shall the Date/Time of the Note be? "
 . S DIR("B")="NOW"
 . S Y=$$DIRCALL S:Y>0 Y=$E(Y,1,12)
 . I Y>0 S TIUD("NOTEDT")=Y,TIUD("NOTEDT",0)=$$FMTE^XLFDT(Y)
 . S X=(Y>0)
 . Q
 I LIN=5 D
 . N TIUR
 . D TEXT("T3",,,,0,,.TIUR)
 . ; Outpatient word added at the request of business owner, 7-11-18, after demo 
 . S X="SO^A:All Outpatient Clinics;S:Selected Outpatient Clinics;N:No Outpatient Clinics"
 . S DIR(0)=X
 . S DIR("A")="File Notes for Outpatient Clinics? [A/S/N]"
 . S DIR("A",1)="In addition to Inpatients,"  ;added per business owner request 7-11-18
 . S DIR("?")=TIUR(6)
 . F I=1:1:5 S DIR("?",I)="   "_TIUR(I)
 . S Y=$$DIRCALL,X=0
 . I Y?1U,"ANS"[Y S TIUD("CLSEL")=$S(Y="N":0,Y="S":1,1:2),X=1
 . Q
 I LIN=6 D
 . ;    type of sig, esig or admin close
 . S TIUD("TYPE")="A",X=1
 . Q
 . ;
 . S DIR(0)=$$DIT(1),DIR("A")=$$DIT(2)
 . S Y=$$DIRCALL I Y?1U,"AE"[Y S TIUD("TYPE")=Y
 . S X=$S(Y'?1U:0,1:"AE"[Y)
 . Q
 I LIN=7 D
 . ;    edit text of note?
 . N I,J,GLX,LN,TX
 . S GLX=$NA(^TMP("TIUDT",$J)) K @GLX
 . S @GLX@(1,0)="Date/Time of Note:  "_TIUD("NOTEDT",0)
 . D TEXT("T7",0,0,0,0,,.TX)
 . S LN=1 F I=1:1:3 S LN=LN+1,@GLX@(LN,0)=TX(I)
 . F I=1:1 Q:'$D(TEXT(3,I))  S LN=LN+1,@GLX@(LN,0)=TEXT(3,I,0)
 . D EN^DDIOL(,GLX) K @GLX
 . S DIR(0)="Y",DIR("A")="Do you wish to edit the text",DIR("B")="No"
 . S X=$$DIRCALL
 . Q
 I LIN=8 D
 . S DIR(0)="Y",DIR("B")="No"
 . S DIR("A")="Do you wish to edit the text further"
 . S X=$$DIRCALL
 . Q
 I LIN=9 D
 . N TIUX
 . D TEXT("T14",1,0,1,,,.TIUX)
 . S DIR(0)="YOA",DIR("B")="Yes"  ; changed default from 'No' to 'Yes', per business owner request, 7-11-18
 . S DIR("?")="   " M DIR("?")=TIUX
 . S DIR("A")="Queue the report to Taskman?  "
 . S X=$$DIRCALL
 . Q
 Q X
 ;
DIRCALL() ;
 N X,Y,DIROUT,DIRUT,DTOUT,DUOUT
 W ! D ^DIR S:$D(DTOUT) Y=-3 S:$D(DUOUT) Y=-2
 Q Y
 ;
DIRTIM(Y) Q $$DOW^XLFDT(Y)_", "_$TR($$FMTE^XLFDT(Y),"@"," ")
 ;
DIT(L) ;
 ;;SA^E:ELECTRONIC SIGNATURE (/es/);A:ADMINSTRATIVE CLOSURE (/ac/)
 ;;Close notes by (E)lectronic Signature or (A)dministrative Closure? 
 Q $P($T(DIT+L),";",3,9)
 ;
 ;=====================================================================
 ;          Other Prompts
 ;=====================================================================
 ;
DIVISION() ;
 ;      if only one inpatient division, don't ask
 ;      VAUTOMA returns: Y=-1 or Y=1
 ;                       VAUTD = 0:if divisions selected
 ;                               1:if selected "ALL" divisions
 ;      TIUD("DIV")= 0:if multiple divisions selected
 ;                   1:if there is only one division
 ;                   2:all divisions
 ;      TIUD("DIV",ien)=division name, only if TIUD("DIV")=0
 N I,X,Y,VAUTD
 I $$CNTDIV^TIUUTL2=1 S TIUD("DIV")=1 Q 1
 D TEXT("T5",1,,,3) D DIVISION^VAUTOMA
 I Y<0!('$D(VAUTD)) Q -1
 S VAUTD=$S(VAUTD>0:2,1:0)
 M TIUD("DIV")=VAUTD
 Q 1
 ;
FIND1(FILE,IEN,FLG,VAL,IDX,SCR) ;
 N I,X,Y,DIERR,TIUER
 S FILE=$G(FILE),IEN=$G(IEN),FLG=$G(FLG),VAL=$G(VAL)
 I FLG="" S FLG="QX"
 I 'FILE!'$L(VAL) Q -1
 S Y=$$FIND1^DIC(FILE,IEN,FLG,VAL,.IDX,.SCR,"TIUER")
 I $D(DIERR) S Y=-1
 Q Y
 ;
GET1(FILE,IEN,FLD,FLG) ;
 N I,X,Y,DA,DIC,DIERR,TIUER
 S FILE=$G(FILE),FLD=$G(FLD),FLG=$G(FLG),IEN=$G(IEN)
 S:$E(IEN,$L(IEN))'="," IEN=IEN_","
 I 'FILE!'IEN!'FLD Q ""
 S X=$$GET1^DIQ(FILE,IEN,FLD,$G(FLG),,"TIUER")
 I $D(DIERR) S X=""
 Q X
 ;
 ;=====================================================================
 ;          Programmer Tools for Troubleshooting
 ;=====================================================================
TEST ;   programmer testing
 N EFORM,ERRON,NOKILL S (EFORM,ERRON,NOKILL)=1
 D START^TIUDTBPN
 Q
 ;
SAVE ;   save local and global variables to ^XTMP
 N I,X,GL
 S X=$$FMADD^XLFDT(DT,8)_U_DT_U
 S GL=$NA(^XTMP("TIUDTBP0")) L +@GL:5 E  Q
 S I=1+$P($G(@GL@(0)),U,3) S ^(0)=X_I L -@GL
 S @GL@(I)=$$NOW^XLFDT
 M @GL@(I,"VAR","TIUD")=TIUD
 S @GL@(I,"VAR","ZTSK")=$G(ZTSK)
 S @GL@(I,"VAR","DUZ")=DUZ
 M @GL@(I,"VAR-G","TMP")=@GLT
 Q
 ;
 ;=====================================================================
 ;          Generic Text Handler
 ;=====================================================================
 ; this program is not expecting the text lines to contain a ';' char.
 ; if there is formatting codes, they will be in the 3rd ';'-piece.
 ;
TEXT(TAG,WR,LF,CLR,PAD,CHR,TIUR) ;
 ; TAG - line label containing the text
 ;       all groups of text should end with ' ;;---'
 ;  WR - Boolean, write or do not write
 ;  LF - 0:no extra line feeds; 1:leading line feed; 2:trailing feed
 ; CLR - Boolean, clear screen first
 ; PAD - number of spaces begin each line with
 ;       If PAD="" then default to 3.  If PAD=0 then no padding
 ; CHR - for center justify, character to pad line, default is space
 ;.TIUR  - return array for text if desired (.TIUR(i)=text)
 ;
 N I,J,X,Y,FMT,LEN,SP
 S TAG=$G(TAG),WR=+$G(WR),LF=+$G(LF),CLR=+$G(CLR)
 S CHR=$G(CHR) S:CHR="" CHR=" "
 S PAD=$G(PAD) I PAD'?1.N S PAD=3
 S LEN=IOM S:'LEN LEN=80
 S $P(SP," ",LEN)=""
 S I=0 F J=1:1 S X=$T(@TAG+J) Q:X=" ;;---"  D
 . S I=I+1,X=$P(X,";",3,99),FMT=""
 . I X?1U1";".E S FMT=$E(X),X=$P(X,";",2,99)
 . I FMT="C" S X=$$CJ^XLFSTR(" "_X_" ",LEN,CHR)
 . I FMT="R" S X=$$RJ^XLFSTR(X,LEN,CHR)
 . I FMT="",PAD S X=$E(SP,1,PAD)_X
 . S TIUR(I)=X
 . I FMT="C" S I=I+1,TIUR(I)=" "
 . Q
 I WR W:CLR @IOF W:LF[1 ! F Y=1:1:I W !,TIUR(Y) I I=Y,LF[2 W !
 Q
 ;
T1 ;
 ;;C;Bookmark Progress Note after a Downtime
 ;;This is the utility to add a bookmark to the progress note of
 ;;each patient's electronic record after a VistA downtime.
 ;;
 ;;You will be asked a few questions, and then the utility
 ;;will place the note on the patient's record.
 ;;
 ;;---
T2 ;
 ;;Select the PROGRESS NOTE TITLE to be used for filing contingency
 ;;downtime bookmark progress notes.  The selected title must be mapped
 ;;to the VHA ENTERPRISE STANDARD TITLE of COMPUTER DOWNTIME
 ;;---
T3 ;
 ;;This option will look for all outpatients with visits that occured
 ;;during the downtime period.  You have the option to select visits
 ;;from (A)ll clinics or (S)elected clinics or (N)o clinics.
 ;;If Selected clinics is chosen, then only visits which have been
 ;;CHECKED OUT will be candidates for filing a downtime note.
 ;;   
 ;;---
T4 ;
 ;;In addition to yourself, who shall receive email notification
 ;;of this event?
 ;;---
T5 ;
 ;;Select DIVISION(s) to use when the task selects inpatients to file notes...
 ;;---
T61 ;
 ;;C;Potential Interruption in Electronic Medical Record Keeping  
 ;;|SU| interruption in access to the electronic medical records
 ;;occurred for |DUR| between:
 ;;     |ST| and |END|
 ;;
 ;;---
T62 ;
 ;;Before, during and after this period of downtime, medical record
 ;;documentation may have been collected on paper.  Documents such as
 ;;progress notes, orders, results, medication administration records
 ;;(MAR) and procedure reports may have been collected, but may not be
 ;;reflected in the electronic record or they may be scanned into the
 ;;record at a later date.
 ;;---
T7 ;
 ;;Creating TIU note text, you will have an opportunity to edit the text
 ;;The progress note will be generated with the following text:
 ;;  
 ;;---
T8 ;
 ;;     
 ;;The note(s) will have the following administrative closure (not a signature):
 ;;---
T9 ;
 ;;   
 ;;The note(s) will be signed with the following electronic signature:
 ;;---
T10 ;
 ;;You will now be asked for an electronic signature to begin this process.
 ;;If you are the author of the note, your signature will be appended.
 ;;Otherwise, the AUTHOR/SIGNER will get VistA alerts for each note.
 ;;---
T11 ;
 ;;You will now be asked for an electronic signature to begin this process.
 ;;This is a security measure to start the background task, but it is not used
 ;;to sign the notes themselves.  If you are not the AUTHOR, your name will
 ;;show for the administrative closure, but not as the author of the note.
 ;;---
T12 ;
 ;;You don't have an Electronic Signature Code on file, quitting...
 ;;---
T13 ;
 ;;You have 60 seconds/try and a maximum of 3 attempts to enter a proper code.
 ;;---
T14 ;
 ;;You can choose to queue this report to Taskman or you may run the
 ;;report to your terminal now.  In either case, a Mailman message will
 ;;be generated listing the patients who had a downtime note filed to
 ;;their medical record.
 ;;
 ;;If you choose to run this report to your terminal, you will see a
 ;;display of each patient found showing patient name, location, and
 ;;filing status of the note.
 ;;
 ;;If you do not choose to queue this report, your terminal could be
 ;;tied up for some time depending upon the inpatient and outpatient
 ;;volume seen during the downtime.
 ;;
 ;;---
T15 ;
 ;;The Author/Signer of these TIU notes must be authorized in ASU to
 ;;sign for this type of TIU Document.
 ;;  
 ;;---
T16 ;
 ;; Note  |                            |
 ;; Filed | Location                   | Patient Name
 ;;-------|----------------------------|-----------------------------------
 ;;---
T17 ;
 ;;Now generating progress notes for inpatients ...
 ;;Now generating progress notes for discharged patients ...
 ;;Now generating progress notes for outpatient clinics ...
 ;;---
 ;
 ;=====================================================================
 ;     PROGRAMMER NOTES
 ;---------------------------------------------------------------------
 ;Patch 305 - local, class III code remediated to national class I
 ; some class III original options left in code but are never executed
 ; in case in the future the VA decided it wants those original options
 ;    DIR(6) - always return admin closure
 ;    Programmer error tools
 ;      If +ERRON is defined, append output from ^TIUPNAPI call
 ;      If +NOKILL then do not kill off temp globals upon exit
 ;      If +EFORM then email has columnar versus delimited format
 ;
 ;Description of temporary global structure
 ;-------------------------------------------------------------------
 ;                                   DIV=file 4 ien
 ;     HLN=hospital location name     HL=file 44 ien
 ;     PNM=patient name              DFN=file 2 ien
 ;     WNM=ward name                WARD=file 42 ien
 ;  STATUS = p1[^p2]
 ;   p1 = Successful;Unsuccessful;Successful/unsigned;Error
 ;   p2 = [TIU_note extrinsic function return value]
 ; GLT = $NA(^TMP("TIUDTBPN",$J)
 ;@GLT@("DSP",TYP,inc)=display line    [Sort TYP = 1,2,3]
 ;@GLT@("F",2,DFN) = DFN^PNM
 ;@GLT@("F",42,s3) = WARD^WNM^DIV^HL  {s3 = WARD or WNM}
 ;@GLT@("F",44,HL) = HL^HLN^DIV
 ;@GLT@("SORT",1,WARD,PNM,DFN)="" for current inpatients
 ;@GLT@("SORT",2,PNM,DFN,DATE)="" for discharge patients
 ;@GLT@("SORT",3,PNM,DFN,DATE)=HL_U_HLN for outpatients
 ;    List of findings for mail message
 ;@GLT@("MSG",PNM,DFN,HLN,inc)=STATUS  [class III format  - p1]
 ;@GLT@("MSG",PNM,DFN,HLN,inc)=STATUS  [remediated format - p1^p2]
 ;@GLT@("SEND",0) = fm wp header
 ;@GLT@("SEND",inc,0) = line inc in mail message
 ;Merge @GLT@("VAR")=TIUD
 ;
 ;Notes on Find Patients modules to create a TIU note
 ;---------------------------------------------------------------------
 ;GETINP -  get all current inpatients whose admit<downtime_endtime
 ;   use admit movement xref as possible to admit without a ward
 ;   division check only done on inpatients
 ;
 ;GETINPD:
 ; Find any inpatients who were discharged during downtime by checking
 ; discharge movements using FOR loop on discharge movement xref.
 ;     Downtime_start '< discharge date.time < now
 ;     ^DGPM("AMV"_TT,Date,Patient,DA)
 ;
 ;INPCOM - common code for both current and discharged inpatients
 ;   Validate non-patient data, get iens, divisions, locations
 ;   Let IN5^VADPT determine if patient was an inpatient
 ;     check if patient was an inpatient at appropriate time
 ;     .VAIP - Both an input and output parameter
 ;     input: optional, VAIP("D")=<fmdt to find assoc. patient move>
 ;                                default to the end of downtime
 ; Output:
 ;   VAIP(1)    = movement ien
 ;   VAIP(2)    = trans type (1^admit 2^transfer 3^discharge...)
 ;   VAIP(5)    = ien^ward_name
 ;   VAIP(13)   = ien of admission movement
 ;   VAIP(13,4) = ien^ward_name
 ;   VAIP(17)   = ien of discharge movement
 ;   VAIP(17,4) = ien^ward_name
 ;
 ;GETOUT - Search for outpatient appts, get latest appt dt only
 ;  $$SDAPI^SDAMA301 retrieves ALL outpatients with filters applied
 ;     $$SDAPI returns -1, 0, # of records
 ;     Returns ^TMP($J,"SDAMA301",dfn,appt)= p1^p2^p3^p4 where
 ;     p1 = FM appt dt
 ;     p2 = clinic ien ; clinic name
 ;     p3 = R;SCHEDULED/KEPT  or  I;INPATIENT  or  NT;NO ACTION TAKEN
 ;     p4 = dfn ; patient name
 ;  Move and sort output from $$SDAPI
 ;  This only generates one note per patient based on location at
 ;     end of downtime
 ;  TIU API to create note kills ^TMP($J)
