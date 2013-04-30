LA7SRPT1 ;DALOI/JDB - SHIPPING MGR REPORTS (CONT) ; 3/13/07 3:00pm
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
EN ;
 ; Displays data for a SHPCFG (#62.9) or a MSG PARAM (#62.48)
 ; entry.  Displays all #62.9s for a #62.48 .
 ; Prompts for #62.48 or #62.9, Only SCT overrides, then device.
 N X,Y,%X,%Y,DIC,DIR,R6248,R629,POP,FLAGS,DTOUT,DUOUT,DIROUT,QUE,RTN
 S (R629,R6248)=0
 S FLAGS=""
 S DIC=62.48
 S DIC(0)="AENOQV"
 D ^DIC
 Q:$D(DTOUT)
 Q:$D(DUOUT)
 I Y>0 S R6248=+Y
 I 'R6248 D  ;
 . K DIC
 . S DIC=62.9
 . S DIC(0)="AENOQV"
 . D ^DIC
 . I Y>0 S R629=+Y
 Q:$D(DTOUT)
 Q:$D(DUOUT)
 I 'R6248 I 'R629 Q
 K DIR
 S DIR(0)="YO"
 S DIR("A")="Only show SCT overrides? "
 S DIR("B")="N"
 D ^DIR
 I Y="^"!(Y="") Q
 I Y S $P(FLAGS,"O",2)="" ;insert "O"
 I 'Y S FLAGS=$TR(FLAGS,"O","") ;remove "O"
 ;
 S RTN="MAIN^LA7SRPT1("""_R629_""","""_R6248_""","""_FLAGS_""")"
 S QUE=$$QUE^LRUTIL(RTN,"SHIPPING CONFIG PRINT")
 Q:QUE=-1
 Q:QUE>0
 D MAIN(R629,R6248,FLAGS)
 I $E(IOST,1,2)="C-" D MORE^LRUTIL()
 D HOME^%ZIS
 Q
 ;
MAIN(R629,R6248,FLAGS) ;
 ; Setup variables and branch to proper display method.
 ; private method
 ; Inputs
 ;   R629 : <opt> #62.9 IEN (need R629 or R6248)
 ;  R6248 : <opt> #62.48 IEN
 ;  FLAGS : <opt> Flags (O=Only print SCT Overrides)
 ;
 N STOP,PGDATA
 S R629=$G(R629)
 S R6248=$G(R6248)
 S FLAGS=$G(FLAGS)
 U IO
 S STOP=0
 S PGDATA("RPTDT")=$$NOW^XLFDT() ;Report Date
 S PGDATA("PGNUM")=1 ;Page Number
 S PGDATA("BM")=0 ;Bottom Margin (lines from bottom)
 S PGDATA("HDR")="D HDR^LA7SRPT1" ;Header exec code
 S PGDATA("FTR")="D FTR^LA7SRPT1" ; Footer exec code
 D HDR^LA7SRPT1
 I R629 D SHPCFG(R629,FLAGS,.STOP)
 I R6248 D LOOP(R6248,FLAGS,.STOP)
 ; Write last footer if needed
 I 'STOP I '$G(PGDATA("WFTR")) D  ;
 . I $G(PGDATA("FTR"))="" Q
 . I $E($G(IOST),1,2)'="C-" D  ;
 . . N I,BM
 . . S BM=$G(PGDATA("BM"))
 . . F I=$Y+1:1:($G(IOSL,60)-BM-1) W !
 . X PGDATA("FTR")
 ;
 I $D(ZTQUEUED) D  ;
 . S ZTREQ="@"
 D ^%ZISC
 Q
 ;
LOOP(R6248,FLAGS,STOP) ;
 ; Displays all SHP CFGs (#62.9) for a MSG CFG (#62.48) entry
 ; private method
 ; Inputs
 ; R6248 : #62.48 IEN
 ; FLAGS : <opt> O=Only show tests with SCT override
 ;  STOP : <byref> See Outputs
 ; Outputs
 ;  STOP : User wants to stop display -- 1=stop
 ;
 N R629
 S R629=0
 F  S R629=$O(^LAHM(62.9,"AC",R6248,R629)) Q:'R629  D  Q:STOP  ;
 . D SHPCFG(R629,FLAGS,.STOP)
 . Q:STOP
 . I $O(^LAHM(62.9,"AC",R6248,R629)) W !!
 Q
 ;
SHPCFG(R629,FLAGS,STOP) ;
 ; Displays SHIPPING CONFIG (#62.9) entry info
 ; private method
 ; Inputs
 ;  R629 : #62.9 IEN
 ; FLAGS : <opt> O=Only show tests with SCT override
 ;  STOP : <byref> See Outputs
 ; Outputs
 ;  STOP : User wants to stop display -- 1=stop
 ;
 N D629,D629001,D60,D64,R629001,R6248,R62482,R60,R64,X,Z,SCT,SPEC,SMPL
 N CNT,WTEST,ISMAPPED,LAIEN,STR
 S FLAGS=$G(FLAGS)
 S STOP=$G(STOP)
 S CNT=0
 D GETFLDS(62.9,R629,".01;.07",.D629)
 Q:'$D(D629)
 S R6248=$G(D629(.07,"I"))
 Q:'R6248
 D NP Q:STOP
 W !,"Shipping Configuration: ",D629(.01,"E")
 D NP Q:STOP
 I FLAGS["O" I '$D(^LAHM(62.48,R6248,"SCT","B")) D  Q  ;
 . W !?5,"No SCT overrides in ",D629(.07,"E")
 ;
 D NP Q:STOP
 S R629001=0
 F  S R629001=$O(^LAHM(62.9,R629,60,R629001)) Q:'R629001  D  Q:STOP  ;
 . S ISMAPPED=0
 . S WTEST=0 ;wrote test's header
 . K D629001
 . S LAIEN=R629001_","_R629_","
 . D GETFLDS(62.9001,LAIEN,".01;.03;.09;",.D629001)
 . S LAIEN=R629001_","_R629_","
 . D GETFLDS(62.9001,LAIEN,".01;.03;.09;5.3;5.4;5.6;5.7;5.8;5.9;5.1;5.2;5.5",.D629001)
 . ;S D629001(.01,"E")=D629001(.01,"E")_"1234 56789 123 23345667533 123.2234 4567543 555 6675433 "
 . D NP Q:STOP
 . I '$D(D629001) D  Q  ;
 . . W !?8,"No Tests for this configuration."
 . S R60=D629001(.01,"I")
 . K D60
 . D GETFLDS(60,R60,".01;64",.D60)
 . S R64=$G(D60(64,"I"))
 . K D64
 . I R64 D  ;
 . . D GETFLDS(64,R64,".01;1",.D64)
 . I FLAGS'["O" D  ;
 . . I CNT>0 W !
 . . D NP Q:STOP
 . . D WTEST S WTEST=1
 . ;
 . D NP Q:STOP
 . S SPEC=$G(D629001(.03,"I"))
 . S SMPL=$G(D629001(.09,"I"))
 . I SPEC D  ;
 . . S X=SPEC_";LAB(61,"
 . . S R62482=$$ISMAPPED(R6248,X)
 . . I FLAGS["O" Q:'R62482
 . . I R62482 S ISMAPPED=1
 . . I 'WTEST D  ;
 . . . D NP Q:STOP
 . . . I CNT>0 W !
 . . . D NP Q:STOP
 . . . D WTEST S WTEST=1
 . . ;
 . . D NP Q:STOP
 . . W !?4,"Specimen: " ;,D629001(.03,"E")
 . . S STR=D629001(.03,"E")
 . . S SCT=$$GETSCT^LRSCT(61,SPEC)
 . . I SCT'="" S STR=STR_" ("_SCT_" "_$$GETPREF^LRSCT(SCT)_")"
 . . D WRAP(STR,15)
 . . S STR=$G(D629001(5.3,"E"),"")_" | "_$G(D629001(5.4,"E"),"")_" | "_$G(D629001(5.6,"E"),"")
 . . I $TR(STR,"| ","")'="" W !?6,"HL7 Info: ",STR
 . . D NP Q:STOP
 . . Q:'R62482
 . . D NP Q:STOP
 . . S SCT=$$GETMAP(R6248,R62482)
 . . S STR=SCT_" "_$$GETPREF^LRSCT(SCT)
 . . W !?6,"SCT override: "
 . . D WRAP(STR,21)
 . . D NP Q:STOP
 . ;
 . D NP Q:STOP
 . ;
 . I SMPL D  ;
 . . S X=SMPL_";LAB(62,"
 . . S R62482=$$ISMAPPED(R6248,X)
 . . I FLAGS["O" Q:'R62482
 . . S ISMAPPED=1
 . . I 'WTEST  D  ;
 . . . W:CNT>0 !
 . . . D NP Q:STOP
 . . . D WTEST S WTEST=1
 . . ;
 . . W !?4,"Sample: ",D629001(.09,"E")
 . . S SCT=$$GETSCT^LRSCT(62,SMPL)
 . . I SCT'="" W " (",SCT," ",$$GETPREF^LRSCT(SCT),")"
 . . D NP Q:STOP
 . . S STR=$G(D629001(5.7,"E"),"")_" | "_$G(D629001(5.8,"E"),"")_" | "_$G(D629001(5.9,"E"),"")
 . . I $TR(STR,"| ","")'="" W !?6,"HL7 Info: ",STR
 . . D NP Q:STOP
 . . Q:'R62482
 . . S SCT=$$GETMAP(R6248,R62482)
 . . W !?6,"SCT override: "
 . . S STR=SCT_" "_$$GETPREF^LRSCT(SCT)
 . . D WRAP(STR,21)
 . . D NP Q:STOP
 . ;
 . D NP Q:STOP
 . I FLAGS'["O" S CNT=CNT+1
 . I FLAGS["O" I ISMAPPED S CNT=CNT+1
 Q
 ;
WTEST ;
 ; Displays the "top-level" test info
 ; Expects the D64 and D629001 arrays
 ; private method
 N STR
 D NP Q:STOP
 W !?2,"Test: ",D629001(.01,"E")
 D NP Q:STOP
 I $D(D64) W !?2,D64(.01,"E")," (",D64(1,"E"),")"
 D NP Q:STOP
 ;test order code
 S STR=$G(D629001(5.1,"E"))_" | "_$G(D629001(5.2,"E"))_" | "_$G(D629001(5.5,"E"))
 I $TR(STR," |","")'="" W !,?2,"Order Code: ",STR
 D NP Q:STOP
 Q
 ;
GETFLDS(LAFILE,LAIEN,LAFLDS,DATA) ;
 ; Fields retriever
 ; Inputs
 ;  LAFILE : File #
 ;   LAIEN : IEN
 ;  LAFLDS : Field #s to retrieve ie ".01;.02;1"
 ;    DATA : <byref> See Outputs
 ; Outputs
 ;    DATA : Array that holds the internal and external field values
 ;         :  ie  DATA(.01,"I")=1  DATA(.01,"E")="value"
 N DIERR,LAMSG,LAFDA,LATARG
 S LAFILE=$G(LAFILE)
 S LAIEN=$G(LAIEN)
 S:LAIEN'["," LAIEN=LAIEN_","
 K DATA
 D GETS^DIQ(LAFILE,LAIEN,LAFLDS,"EIN","LATARG","LAMSG")
 I $D(LATARG) M DATA=LATARG(LAFILE,LAIEN)
 Q
 ;
ISMAPPED(R6248,VARPTR) ;
 ; Is this VARPTR (spec or sample) an entry in #62.482?
 ; Inputs
 ;  R6248 : #62.48 IEN
 ; VARPTR : Pointer to file #61 or #62 -- ie "123;LAB(61,"
 ; Output
 ;  0 or the #62.482 IEN of the VARPTR
 Q +$O(^LAHM(62.48,R6248,"SCT","B",VARPTR,0))
 ;
GETMAP(R6248,R62482) ;
 ; Returns the SCT code in #62.482
 N DIERR,LAMSG,LAIEN
 S LAIEN=R62482_","_R6248_","
 Q $$GET1^DIQ(62.482,LAIEN,.02,"LAMSG")
 ;
HDR ;
 ; Header
 ; Expects PGDATA array
 ; private method
 N STR,RPTDT,PGNUM
 S RPTDT=$G(PGDATA("RPTDT"))
 I RPTDT="" D  ;
 . S RPTDT=$$NOW^XLFDT()
 . S PGDATA("RPTDT")=RPTDT
 S PGNUM=$G(PGDATA("PGNUM"))
 I PGNUM<1 D  ;
 . S PGNUM=1
 . S PGDATA("PGNUM")=PGNUM
 ;
 W !,"SHIPPING CONFIGURATION DISPLAY  "
 S STR="Printed "_$$FMTE^XLFDT(RPTDT,"M")
 S STR=STR_"   Page "_$G(PGNUM,1)
 W ?IOM-$L(STR)-2,STR
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
FTR ;
 ; Footer
 ; private method
 Q
 ;
NP ;
 ; New Page handler
 ; convenience method
 D NP^LRUTIL(.STOP,.PGDATA)
 Q
 ;
WRAP(STR,LM,NL,ABORT,PGDATA) ;
 ; Formats (wraps) and prints a string
 ; Depending on desired output, caller may need to position
 ; the cursor at desired column (W ?X) before calling WRAP.
 ; Inputs
 ;  STR : The string to format
 ;   LM : Left Margin (align to column X)
 ;   NL : New Line?  0=no 1=yes (Write a new line first)
 ;
 N I,J,X,STR2,DIWL,DIWR,DIWF,SPLIT,CHARS,Z
 S STR=$G(STR)
 S LM=$G(LM,1)
 S NL=$G(NL)
 S ABORT=$G(ABORT)
 K ^UTILITY($J,"W") ;per FM
 S CHARS=" .-!+""" ; chars to split on
 S X=STR
 ; display 1st line manually since DIWW doesnt work well here
 S STR2=$E(STR,1,IOM-$X)
 S X=$E(STR,$L(STR2)+1,$L(STR2)+1) ;next char
 I CHARS'[X D  ; chars to break on
 . S SPLIT=0
 . F I=$L(STR2):-1:1 S X=$E(STR2,I,I) I CHARS[X S SPLIT=1 Q
 . I SPLIT S STR2=$E(STR2,1,I)
 I NL W !
 W STR2
 S STR2=$E(STR,$L(STR2)+1,$L(STR))
 S STR2=$$TRIM^XLFSTR(STR2,"LR"," ")
 Q:STR2=""
 S X=STR2
 S DIWL=LM
 S:DIWL<1 DIWL=1
 S DIWR=IOM
 S DIWF=""
 D ^DIWP
 ; DIWW forces an extra linefeed at end so printout manually
 S I=$O(^UTILITY($J,"W",0))
 S J=0
 F  S J=$O(^UTILITY($J,"W",I,J)) Q:'J  D  Q:ABORT  ;
 . S X=^UTILITY($J,"W",I,J,0)
 . S X=$$TRIM^XLFSTR(X,"RL"," ")
 . D NP^LRUTIL(.ABORT,.PGDATA) Q:ABORT
 . W !,?LM-1,X
 K ^UTILITY($J,"W")
 Q
