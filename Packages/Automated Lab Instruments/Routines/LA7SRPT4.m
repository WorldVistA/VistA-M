LA7SRPT4 ;DALOI/JDB - SCT OVERRIDE REPORT ;03/07/12  09:38
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
EN ;
 ; Prompts for #62.48 entry, device, then branches
 N QUE,RTN,R6248,DIC,DTOUT,DUOUT,POP,X,Y,HASSCT,LASEL,ZTSAVE
 S HASSCT=0
 D  Q:'HASSCT  ;
 . ; any SCT Overrides on file?
 . N R6248
 . S R6248=0
 . F  S R6248=$O(^LAHM(62.48,R6248)) Q:'R6248  D  Q:HASSCT  ;
 . . Q:'$D(^LAHM(62.48,R6248,"SCT"))
 . . S HASSCT=1
 . Q:HASSCT
 . W !,"  No SCT Overrides on file."
 ;
 S R6248=0
 S DIC=62.48
 S DIC("S")="I $D(^(""SCT""))"
 S X=$$SELECT^LRUTIL(.DIC,.LASEL,"MESSAGE CONFIGURATION",10,0,0,1)
 K DIC
 ; If LASEL=1 then "ALL" was selected
 I X<1 I X'="*" Q
 I $D(DTOUT)!$D(DUOUT) Q
 S RTN="MAIN^LA7SRPT4("_R6248_")"
 I $D(LRSEL)>1 S ZTSAVE("LASEL")=""
 S QUE=$$QUE^LRUTIL(RTN,"SCT OVERRIDE",.ZTSAVE)
 I QUE Q
 D MAIN(R6248)
 D HOME^%ZIS
 Q
 ;
MAIN(R6248) ;
 ; Setup variables, branch, print footer, perform cleanup.
 ; Expects LASEL array from EN (used with VAUTOMA) to pick
 ; multiple #62.48s (passed in sym tbl for queuing)
 ;
 ; Inputs
 ;  R6248 : #62.48 IEN
 N STOP,PGDATA
 S R6248=$G(R6248)
 U IO
 S STOP=0
 S PGDATA("RPTDT")=$$NOW^XLFDT() ;Report Date
 S PGDATA("PGNUM")=1 ;Page Number
 S PGDATA("BM")=0 ;Bottom Margin (lines from bottom)
 S PGDATA("HDR")="D HDR^LA7SRPT4" ;Header exec code
 S PGDATA("FTR")="D FTR^LA7SRPT4" ; Footer exec code
 D HDR^LA7SRPT4
 I R6248 D SCTOVER(R6248,.STOP)
 I 'R6248 D LOOP(.STOP,.LASEL)
 ; Write last footer if needed
 I 'STOP I '$G(PGDATA("WFTR")) D  ;
 . I $G(PGDATA("FTR"))="" Q
 . I $E($G(IOST),1,2)'="C-" D  ;
 . . N I,BM
 . . S BM=$G(PGDATA("BM"))
 . . F I=$Y+1:1:($G(IOSL,60)-BM-1) W !
 . X PGDATA("FTR")
 I $D(ZTQUEUED) S ZTREQ="@"
 I 'STOP I $E(IOST,1,2)="C-" D MORE^LRUTIL()
 D ^%ZISC
 Q
 ;
LOOP(STOP,SEL) ;
 ; Inputs
 ;  STOP : <byref> see Outputs below
 ;   SEL : <byref> Array of #62.48s to display
 ; Outputs
 ;  STOP : Tracks if user has stopped display
 N R6248,NODE
 ;S R6248=0
 S NODE="^LAHM(62.48,""B"")"
 ;F  S R6248=$O(^LAHM(62.48,"B",R6248)) Q:'R6248  D  Q:STOP  ;
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="B"  D  Q:STOP  ;
 . S R6248=$QS(NODE,4)
 . Q:'$D(^LAHM(62.48,R6248,"SCT"))
 . I $D(SEL)>1 I '$D(SEL(R6248)) Q
 . D SCTOVER(R6248,.STOP)
 . D NP(.STOP) Q:STOP
 . I $O(^LAHM(62.48,R6248)) W ! D NP(.STOP) Q:STOP  W !
 . D NP(.STOP) Q:STOP
 Q
 ;
SCTOVER(R6248,STOP) ;
 ; Displays SCT override info for a MSG CFG (#62.48)
 ; Inputs
 ;  R6248 : #62.48 IEN
 ;  STOP : <byref> see Outputs below
 ; Outputs
 ;  STOP : Tracks if user has stopped display
 N R62482,R61,R62,D62482,SPECS,SAMPS,TMPNM,SCT,SCT1,SCTOVR,SCTCODES
 N FSIZE,NODE,I,X,REC,NM,DATA,MSIZE,POS
 N DIERR,LAIEN,LAFLDS,POP
 N IOUON,IOUOFF
 S MSIZE(1)=IOM-42 ;max field length (2+2+SCT(18)+2+SCT(18))
 S R6248=$G(R6248)
 S STOP=$G(STOP)
 S TMPNM="LA7SRPT4"
 S X="IOUON;IOUOFF"
 D  ;
 . N %ZIS
 . D ENDR^%ZISS
 ;
 D GETFLDS^LA7SRPT1(62.48,R6248_",",".01",.DATA)
 D NP(.STOP) Q:STOP
 W !,"Message Configuration: ",DATA(.01,"E")
 D NP(.STOP) Q:STOP
 I '$D(^LAHM(62.48,R6248,"SCT")) D  Q  ;
 . D NP(.STOP) Q:STOP
 . W !?5,"No SCT Overrides on file."
 . D NP(.STOP) Q:STOP
 ;
 D NP(.STOP) Q:STOP
 W !
 D NP(.STOP) Q:STOP
 S LAFLDS=".01;.02"
 S R62482=0
 F  S R62482=$O(^LAHM(62.48,R6248,"SCT",R62482)) Q:'R62482  D  ;
 . K D62482
 . S LAIEN=R62482_","_R6248_","
 . D GETFLDS^LA7SRPT1(62.482,LAIEN,LAFLDS,.D62482)
 . Q:'$D(D62482)
 . S (R61,R62)=0
 . S X=D62482(.01,"I")
 . I X["LAB(61," D  ;
 . . S R61=$P(X,";",1)
 . I X["LAB(62," D  ;
 . . S R62=$P(X,";",1)
 . I 'R61 I 'R62 Q
 . S X=$G(D62482(.02,"E"))
 . I R61 S SPECS(R61)=X
 . I R62 S SAMPS(R62)=X
 . ;setup TMP
 . K ^TMP($J,TMPNM)
 . I $D(SPECS) D BLDTMP(61,.SPECS)
 . I $D(SAMPS) D BLDTMP(62,.SAMPS)
 I '$D(^TMP($J,TMPNM)) Q
 ;
 ; ^TMP($J,TMPNM,FILE#,.01,REC)=SCT Code
 ; find max length in specimens
 S FSIZE(1)=12 ;spec/sample
 S FSIZE(1)=12+29
 S FSIZE(2)=8 ;SCT code
 S NODE="^TMP($J,TMPNM,61)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,3)'=61  Q:$QS(NODE,2)'=TMPNM  D  ;
 . S NM=$QS(NODE,4) ;.01 field (sample or topog)
 . S REC=$QS(NODE,5)
 . S X=" ["_REC_"]"
 . S I=$L(NM_X)
 . I I>FSIZE(1) S FSIZE(1)=I
 ;
 ; find max length in samples
 S NODE="^TMP($J,TMPNM,62)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,3)'=62  Q:$QS(NODE,2)'=TMPNM  D  ;
 . S NM=$QS(NODE,4) ;.01 field (sample or topog)
 . S REC=$QS(NODE,5)
 . S X=" ["_REC_"]"
 . S I=$L(NM_X)
 . I I>FSIZE(1) S FSIZE(1)=I
 ;
 ; Print Specimens header
 S NODE="^TMP($J,TMPNM,61)"
 I $D(@NODE) D  ;
 . D NP(.STOP) Q:STOP
 . W !?2 D UL(1)
 . W "Specimen [Topography file #61]"
 . S DISP(1)=FSIZE(1)
 . I DISP(1)>MSIZE(1) S DISP(1)=MSIZE(1)
 . W ?2+DISP(1)+2,"VA SCT",?2+DISP(1)+2+18+2,"Non-VA SCT"
 . D UL(0)
 . D NP(.STOP) Q:STOP
 ;
 ; Print specimens
 S NODE="^TMP($J,TMPNM,61)"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,3)'=61  Q:$QS(NODE,2)'=TMPNM  D  Q:STOP  ;
 . S NM=$QS(NODE,4)
 . S REC=$QS(NODE,5)
 . S SCT=@NODE
 . I SCT'="" S SCTCODES(" "_SCT)=""
 . S SCTOVR=SPECS(REC)
 . I SCTOVR'="" S SCTCODES(" "_SCTOVR)=""
 . S X=" ["_REC_"]"
 . I $L(NM_X)>MSIZE(1) D  ;
 . . S NM=$E(NM,1,MSIZE(1)-$L(X)-3)_"..."
 . S NM=NM_X
 . S DISP(1)=FSIZE(1)
 . I DISP(1)>MSIZE(1) S DISP(1)=MSIZE(1)
 . D NP(.STOP) Q:STOP
 . W !?2,NM
 . W ?2+DISP(1)+2,SCT,?2+DISP(1)+2+18+2,SCTOVR
 . D NP(.STOP) Q:STOP
 ;
 ; Print samples header
 S NODE="^TMP($J,TMPNM,62)"
 I $D(@NODE) D  ;
 . I $D(^TMP($J,TMPNM,61)) D NP(.STOP) Q:STOP  W !
 . D NP(.STOP) Q:STOP
 . W !?2
 . D UL(1)
 . W "Sample [Collection Sample file #62]"
 . S DISP(1)=FSIZE(1)
 . I DISP(1)>MSIZE(1) S DISP(1)=MSIZE(1)
 . W ?2+DISP(1)+2,"VA SCT",?2+DISP(1)+2+18+2,"Non-VA SCT"
 . D UL(0)
 . D NP(.STOP) Q:STOP
 ;
 ; Print samples
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,3)'=62  Q:$QS(NODE,2)'=TMPNM  D  Q:STOP  ;
 . S NM=$QS(NODE,4)
 . S REC=$QS(NODE,5)
 . S SCT=@NODE
 . I SCT'="" S SCTCODES(" "_SCT)=""
 . S SCTOVR=SAMPS(REC)
 . I SCTOVR'="" S SCTCODES(" "_SCTOVR)=""
 . S X=" ["_REC_"]"
 . I $L(NM_X)>MSIZE(1) D  ;
 . . S NM=$E(NM,1,MSIZE(1)-$L(X)-3)_"..."
 . S NM=NM_X
 . S DISP(1)=FSIZE(1)
 . I DISP(1)>MSIZE(1) S DISP(1)=MSIZE(1)
 . D NP(.STOP) Q:STOP
 . W !?2,NM
 . W ?2+DISP(1)+2,SCT,?2+DISP(1)+2+18+2,SCTOVR
 . D NP(.STOP) Q:STOP
 ;
 ; Display SCT code legend
 I 'STOP I $D(SCTCODES) D  ;
 . S SCT=""
 . F  S SCT=$O(SCTCODES(SCT)) Q:SCT=""  D  Q:STOP  ;
 . . S X=$$TRIM^XLFSTR(SCT,"L"," ")
 . . S I=$L(X)
 . . I FSIZE(2)<I S FSIZE(2)=I
 . ;
 . D NP(.STOP) Q:STOP
 . W !
 . D NP(.STOP) Q:STOP
 . S POS=0
 . W !?POS
 . D UL(1)
 . W "SCT Code"
 . S POS=POS+FSIZE(2)+2
 . W ?POS,"SCT Preferred Term"
 . D UL(0)
 . S SCT=""
 . F  S SCT=$O(SCTCODES(SCT)) Q:SCT=""  D  Q:STOP  ;
 . . S SCT1=$$TRIM^XLFSTR(SCT,"L"," ")
 . . D NP(.STOP) Q:STOP
 . . S POS=0
 . . W !?POS,SCT1
 . . S X=$$GETPREF^LRSCT(SCT1)
 . . S POS=POS+FSIZE(2)+2
 . . W ?POS
 . . D WRAP^LA7SRPT1(X,POS+1,0,.STOP,.PGDATA)
 . . D NP(.STOP)
 . . Q:STOP
 . ;
 ;
 K ^TMP($J,TMPNM)
 D UL(0)
 Q
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
 W !,"MESSAGE CONFIGURATION SCT OVERRIDES  "
 S STR="Printed "_$$FMTE^XLFDT(RPTDT,"M")
 S STR=STR_"   Page "_$G(PGNUM,1)
 W ?IOM-$L(STR)-2,STR
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
FTR ;
 Q
 ;
NP(STOP) ;
 ; Convenience method
 D NP^LRUTIL(.STOP,.PGDATA)
 Q
 ;
BLDTMP(FILE,IN) ;
 ; Builds ^TMP($J,TMPNM,FILE,.01,IEN)=SCT Code 
 ; private method
 ; Inputs
 ;  FILE : File # (61, 62)
 ;    IN :<byref> data array  IN(IEN)=SCT Code
 N REC,DATA,FLDS,TMPNM,F01,F20
 S FILE=$G(FILE)
 S TMPNM="LA7SRPT4"
 S FLDS=".01;20"
 S REC=""
 F  S REC=$O(IN(REC)) Q:'REC  D  ;
 . K DATA
 . D GETFLDS^LA7SRPT1(FILE,REC_",",FLDS,.DATA)
 . Q:'$D(DATA)
 . S F01=DATA(.01,"E")
 . S F20=$G(DATA(20,"E"))
 . S ^TMP($J,TMPNM,FILE,F01,REC)=F20
 Q
 ;
UL(I) ;
 ; Underline On/Off
 ; private method
 ; Inputs
 ;   I  I=1 turns on underline  I=0 turns off underline
 I $G(IOUON)'="" I $G(IOUOFF)'="" D  ;
 . W:'I IOUOFF
 . W:I IOUON
 Q
