LA7UTILA ;DALOI/JMC - Browse UI message ;05/01/09  16:43
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**23,27,46,64,74**;Sep 27, 1994;Build 229
 ;
EN ; Select a Universal Interface message to browse.
 N LA7LIST,DIC,DIR,DIRUT,DTOUR,DUOUT,PARAM,X
 D EXIT ; Housekeeping before we start.
 S PARAM("SHOIDS")=$$GET^XPAR("USR^SYS","LA7UTILA SHOIDS",1,"Q")
 S PARAM("SHOIDS LAST")=$$GET^XPAR("USR^SYS","LA7UTILA SHOIDS LAST",1,"Q")
 S X=PARAM("SHOIDS")
 I X="L" S X=PARAM("SHOIDS LAST")
 I X="" S X=PARAM("SHOIDS")
 I X="" S X=1
 I X'=+X S X=$S(X="Y":1,X="N":0,1:1)
 K PARAM
 S DIR("B")=$S(X:"YES",1:"NO")
 S DIR(0)="Y",DIR("A")="Display identifiers during message selection"
 D ^DIR
 I $D(DIRUT) D EXIT Q
 I Y<1 S DIC("W")="D DICW^LA7UTILA"
 ; save PARAM setting
 D EN^XPAR("USR","LA7UTILA SHOIDS LAST",1,$S(+Y>0:1,1:0))
 S DIC="^LAHM(62.49,"
 S DIC(0)="EQMZ"
 S X=$$SELECT^LRUTIL(.DIC,.LA7LIST,"Message",10,0,1,1)
 K DIC,DIR
 I '$O(LA7LIST(0)) D EXIT Q
 D DEV
 Q
 ;
DEV ; Called from LA7UXQA - when viewing message via alert system.
 N PARAM,DIR,X
 ; DFLT = N,Y,L (no,yes,last)
 S PARAM("PARSE")=$$GET^XPAR("USR^SYS","LA7UTILA PARSE",1,"Q")
 S PARAM("PARSE LAST")=$$GET^XPAR("USR^SYS","LA7UTILA PARSE LAST",1,"Q")
 S DIR(0)="YO"
 S DIR("A")="Parse message fields based on HL7 segments"
 S X=PARAM("PARSE")
 I X="L" S X=PARAM("PARSE LAST")
 I X="" S X=PARAM("PARSE")
 I X="" S X=1
 I X'=+X S X=$S(X="Y":1,X="N":0,1:1)
 S DIR("B")=$S(X:"YES",1:"NO")
 D ^DIR K DIR
 I $D(DIRUT) D EXIT Q
 D EN^XPAR("USR","LA7UTILA PARSE LAST",1,$S(+Y>0:1,1:0))
 S LA7PARS=+Y ; Save flag to parse message.
 I LA7PARS D  I $D(DIRUT) D EXIT Q
 . S DIR(0)="YO",DIR("A")="Suppress blank segments",DIR("B")="YES"
 . D ^DIR K DIR Q:$D(DIRUT)
 . S $P(LA7PARS,"^",2)=+Y
 ; Ask device and task if requested.
 S %ZIS="Q" D ^%ZIS K %ZIS
 I POP D EXIT Q
 I $D(IO("Q")) D  G EXIT
 . S LA7TEST=0 ; Tasked - not a CRT.
 . S ZTRTN="DQ^LA7UTILA",ZTDESC="Print LA7 UI Messages",ZTSAVE("LA7*")=""
 . D ^%ZTLOAD
 . W !,"Request ",$S($D(ZTSK):"",1:"NOT "),"Queued"
 . K IO("Q")
 U IO(0)
 ;
 ; Flag to determine if okay to use browser (default=true).
 S LA7TEST=1
 ;
 ; Home device not current device or using non-CRT terminal type.
 I IO'=IO(0)!($E(IOST,1,2)'="C-") S LA7TEST=0
 ;
 ; If not queued and home device then test for browser
 I LA7TEST,'$$TEST^DDBRT D
 . S LA7TEST=0 ; Unable to use browser.
 . W !,$C(7),"This terminal does not support the needed functionality to use the Browser!"
 . W !,"Will use standard FileMan Data Display.",!
 I LA7TEST D
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . K PARAM
 . S PARAM("BROWSER")=$$GET^XPAR("USR^SYS","LA7UTILA USE BROWSER",1,"Q")
 . S PARAM("BROWSER LAST")=$$GET^XPAR("USR^SYS","LA7UTILA USE BROWSER LAST",1,"Q")
 . S X=PARAM("BROWSER")
 . I X="L" S X=PARAM("BROWSER LAST")
 . I X="" S X=PARAM("BROWSER")
 . I X="" S X=1
 . I X'=+X S X=$S(X="Y":1,X="N":0,1:1)
 . ;S X=$$GET^XPAR("USR^SYS","LA7UTILA USE BROWSER",1,"Q")
 . S DIR(0)="YO",DIR("A")="Use Browser to display message(s)"
 . S DIR("B")=$S(X:"YES",1:"NO")
 . D ^DIR
 . I $D(DIRUT) S LA7TEST=-1 Q
 . D EN^XPAR("USR","LA7UTILA USE BROWSER LAST",1,$S(+Y>0:1,1:0))
 . S LA7TEST=+Y
 I LA7TEST<0 D EXIT Q
 D WAIT^DICD
 ;
DQ ; Dequeue entry point.
 U IO
 K ^TMP($J),^TMP("DDB",$J)
 ;
 S LA7IEN=0
 F  S LA7IEN=$O(LA7LIST(LA7IEN)) Q:'LA7IEN  D
 . S LA7J=1
 . D BRO^LA7UTILC("LA7 UI Message Display",LA7IEN,LA7IEN)
 ;
 ; Display using browser.
 I LA7TEST D  Q
 . D DOCLIST^DDBR("^TMP($J,""LIST"")","R")
 . D EXIT
 ;
 S (LA7IEN,LA7QUIT)=0
 S HDR=""
 F  S HDR=$O(^TMP($J,"LIST",HDR)) Q:HDR=""  D  Q:LA7QUIT
 . I IOST["C-" W @IOF
 . W $$CJ^XLFSTR(HDR,IOM," "),!
 . S LA7ROOT=^TMP($J,"LIST",HDR),LA7ROOT=$E(LA7ROOT,1,$L(LA7ROOT)-1)
 . S LA7CONT=0 ; Flag if line is continued on following line.
 . S I=0
 . F  S I=$O(@(LA7ROOT_","_I_")"))  Q:'I  D  Q:LA7QUIT
 . . S LA7X=^(I)
 . . I LA7X="" W ! Q  ; Print blank separator line
 . . F  S LA7Y=$E(LA7X,1,IOM-1) Q:LA7Y=""  D  Q:LA7QUIT
 . . . S LA7X=$E(LA7X,IOM,$L(LA7X))
 . . . I $L(LA7X) S LA7CONT=1,LA7X="--->"_LA7X
 . . . W !,LA7Y
 . . . I $Y+7>IOSL D EOP W @IOF Q:LA7QUIT
 . I 'LA7QUIT D EOP
 . W !!
 D EXIT
 Q
 ;
EOP ; End of page.
 I LA7CONT W !!,"NOTE: '--->' indicates continuation of previous line." S LA7CONT=0
 I $D(ZTQUEUED)!(IOST'["C-") Q
 S DIR(0)="E" D ^DIR K DIR S:Y'=1 LA7QUIT=1
 Q
 ;
EXIT ; Clean up.
 I $G(IOF)'="" W @IOF
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 K ^TMP($J),^TMP("DDB",$J)
 K ^TMP("LA7UTILC")
 K LA7CONT,LA7IEN,LA7J,LA7LIST,LA7PARS,LA7QUIT,LA7ROOT,LA7TEST,LA7X,LA7Y
 K DIC,DIR,HDR,HLECH,HLFS,I,J,K,L,M,V,X,Y,Z
 K VAUTVB,VAUTNI,VAUTSTR,VAUTNALL
 Q
 ;
FMT(LA76249) ; Perform test to determine storage format, each segment on one
 ;  node or segment has continuation nodes separated with null "" nodes.
 ; Call with LA76249 = ien of entry in file #62.49
 ;      Returns LA7Y = 0-old format, 1-new format
 ;
 N LA7END,LA7Y,LA7ROOT
 S (LA7END,LA7Y)=0,LA7ROOT="^LAHM(62.49,LA76249,150,0)"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7END  D
 . I $QS(LA7ROOT,1)'="62.49"!($QS(LA7ROOT,2)'=LA76249)!($QS(LA7ROOT,3)'=150) S LA7END=1 Q
 . I @LA7ROOT="" S (LA7Y,LA7END)=1
 Q LA7Y
 ;
DICW ;
 ; Private method for EN above.
 ; Displays certain identifier for lookup.
 ; Called by ^DIC through DIC("W")
 N LADATA,LAY,LAX,LAF1,LAF3,LAF4,LAF103,LAF105
 ; Y = IEN of entry DIC is at.
 ; ^(0) is at the global level @(DIC_"Y,0)"
 S LAX=""
 S LADATA=^(0)
 S LAF1=$P(LADATA,U,2)
 S:LAF1="" LAF1="?"
 S LAF3=$$LOW^XLFSTR($P(LADATA,U,3))
 S:LAF3="" LAF3="-"
 S LAF4=$P(LADATA,U,5)
 S LAY=$P(LADATA,U,6)
 I LAY'="" D  ; Instrument name
 . S LAX=LAY
 I LAX="" D  ;
 . S LAY=$G(^LAHM(62.49,Y,.5))
 . S LAY=$P(LAY,U,1)
 . Q:LAY=""
 . S LAY=$G(^LAHM(62.48,LAY,0))
 . S LAY=$P(LAY,U,1)
 . I LAY'="" D  ; Config name
 . . S LAX=LAY
 . ;
 S LADATA=$G(^LAHM(62.49,Y,100))
 S LAF103=$P(LADATA,U,4) ;sending fac
 S LAF105=$P(LADATA,U,6) ;receiving fac
 S LAY=""
 I LAF1="I" I LAF103'="" S LAY="  "_LAF103
 I LAF1="O" I LAF105'="" S LAY="  "_LAF105
 W " "_LAF1_LAF3_"  "_LAX_LAY_"  "_$$FMTE^XLFDT(LAF4,5)
 Q
