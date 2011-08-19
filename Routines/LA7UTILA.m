LA7UTILA ;DALOI/JMC - Browse UI message ; 6/19/96 09:00
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**23,27,46,64**;Sep 27, 1994
 ;
EN ; Select a Universal Interface message to browse.
 D EXIT ; Housekeeping before we start.
 S DIC="^LAHM(62.49,",DIC("W")="W ""   "",$P(^(0),U,6)"
 S VAUTVB="LA7LIST",VAUTSTR="Message",VAUTNI=2,VAUTNALL=1
 D FIRST^VAUTOMA
 I Y<1!('$O(LA7LIST(0))) D EXIT Q
 ;
DEV ; Called from LA7UXQA - when viewing message via alert system.
 S DIR(0)="YO",DIR("A")="Parse message fields based on HL7 segments",DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT) D EXIT Q
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
 . S DIR(0)="YO",DIR("A")="Use Browser to display message(s)",DIR("B")="YES"
 . D ^DIR
 . I $D(DIRUT) S LA7TEST=-1 Q
 . S LA7TEST=+Y
 I LA7TEST<0 D EXIT Q
 D WAIT^DICD
 ;
DQ ; Dequeue entry point.
 U IO
 K ^TMP($J),^TMP("DDB",$J)
 S LA7IEN=0
 F  S LA7IEN=$O(LA7LIST(LA7IEN)) Q:'LA7IEN  S LA7J=1 D BRO("LA7 UI Message Display",LA7IEN,LA7IEN)
 I LA7TEST D  Q  ; Display using browser.
 . D DOCLIST^DDBR("^TMP($J,""LIST"")","R")
 . D EXIT
 S (LA7IEN,LA7QUIT)=0
 S HDR=""
 F  S HDR=$O(^TMP($J,"LIST",HDR)) Q:HDR=""  D  Q:LA7QUIT
 . I IOST["C-" W @IOF
 . W $$CJ^XLFSTR(HDR,IOM," "),!
 . S LA7ROOT=^TMP($J,"LIST",HDR),LA7ROOT=$E(LA7ROOT,1,$L(LA7ROOT)-1)
 . S LA7CONT=0 ; Flag to determine if line has been continue on followng line.
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
BRO(LA7HDR,LA7DOC,LA7IEN,LA7J) ; Setup text for browser.
 ; Called from above.
 N LA7,LA7DT,LA7X,I,J,K,X,Y
 D GETS^DIQ(62.49,LA7IEN,".01:149;160;161","ENR","LA7") ; Retrieve data from file 62.49
 S J=$G(LA7J,1)
 S ^TMP("DDB",$J,LA7DOC,J)=" ["_$$CJ^XLFSTR(" Message Statistics ",IOM-4,"*")_"]"
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" "
 S I="LA7(62.49)",K=0,J(0)=J
 F  S I=$Q(@I) Q:I=""  Q:$QS(I,1)'=62.49  D
 . S X=$QS(I,3)_": "_@I
 . I K=0,$L(X)>((IOM\2)-1) S K=1,Y=""
 . I K=0 S K=1,Y=$$LJ^XLFSTR(X,(IOM\2)+2)
 . E  S K=0,J=J+1,^TMP("DDB",$J,LA7DOC,J)=Y_$QS(I,3)_": "_@I
 I K=1 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=Y
 I J(0)=J S J=J+1,^TMP("DDB",$J,LA7DOC,J)=$$CJ^XLFSTR(" [None Found]",IOM-1)
 S LA7X=$G(^LAHM(62.49,LA7IEN,0))
 S LA7DT=$P(LA7X,"^",5) ; Date/time message received
 S LA7DT(0)=LA7DT\1 ; Date message received.
 S LA7DT(1)=LA7DT#1 ; Time message received.
 S K="LA7ERR^"_(LA7DT(0)-.1)
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" "
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" ["_$$CJ^XLFSTR(" Error Message ",IOM-4,"*")_"]"
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" "
 S J(0)=J ; Save value of "J", determine if any error message found.
 F  S K=$O(^XTMP(K)) Q:K=""!($P(K,"^")'="LA7ERR")  D
 . I LA7DT(0)=$P(K,"^",2) S I=LA7DT(1)-.00000001 ; Start looking after date/time of message.
 . E  S I=0
 . F  S I=$O(^XTMP(K,I)) Q:'I  D
 . . S X=^XTMP(K,I)
 . . I $P(X,"^",2)=LA7IEN D
 . . . S J=J+1,^TMP("DDB",$J,LA7DOC,J)="Date: "_$$FMTE^XLFDT($P(K,"^",2)+I,1)
 . . . S J=J+1,^TMP("DDB",$J,LA7DOC,J)="Text: "_$P(X,"^",4) ; Get error message.
 . . . S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" "
 I J(0)=J S J=J+1,^TMP("DDB",$J,LA7DOC,J)=$$CJ^XLFSTR("[None Found]",IOM-1)
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" "
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" ["_$$CJ^XLFSTR(" Text of Message ",IOM-4,"*")_"]"
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" "
 ;
 ; Retrieve text of message from 62.49.
 S I=0,J(0)=J
 F  S I=$O(^LAHM(62.49,LA7IEN,150,I)) Q:'I  D
 . S J=J+1
 . S ^TMP("DDB",$J,LA7DOC,J)=$G(^LAHM(62.49,LA7IEN,150,I,0))
 . ; Parse each message segment.
 . I '$G(LA7PARS) Q
 . S X=$G(^LAHM(62.49,LA7IEN,150,I,0))
 . ; Obtain field separator and encoding characters.
 . I $E(X,1,3)="MSH" S HLFS=$E(X,4),HLECH=$E(X,5,8)
 . ; Segement ID code.
 . S Y=$P(X,HLFS)
 . ; Parse fields.
 . D PF
 ;
 I J(0)=J S J=J+1,^TMP("DDB",$J,LA7DOC,J)=$$CJ^XLFSTR("[None Found]",IOM-1)
 ;
 ; If linked to another entry go pasrse that entry also
 I $P(LA7X,"^",7) D BRO("LA7 UI Message Display",LA7DOC,$P(LA7X,"^",7),J)
 ;
 ; Setup document list.
 S LA7HDR=LA7HDR_" Msg #"_LA7DOC_" - "_$P(^LAHM(62.49,LA7DOC,0),"^",6)
 S ^TMP($J,"LIST",LA7HDR)="^TMP(""DDB"",$J,"_LA7DOC_")"
 Q
 ;
PF ; Parse message fields
 ;
 F K=$S(Y="MSH":1,1:2):1:$L(X,HLFS) D
 . S Z=$P(X,HLFS,K)
 . ; Don't display blank segments.
 . I $P(LA7PARS,"^",2),Z="" Q
 . S J=J+1
 . I Y="MSH" S V=Y_"-"_K_" = "_$S(K=1:HLFS,1:$P(X,HLFS,K))
 . E  S V=Y_"-"_(K-1)_" = "_$P(X,HLFS,K)
 . S ^TMP("DDB",$J,LA7DOC,J)=V
 . I Z="" Q  ; Don't parse blank segments.
 . I Y="MSH",K<3 Q  ; Don't parse MSH-1/2.
 . ; Parse components.
 . D PC
 ; Separate segments with blank line.
 S J=J+1,^TMP("DDB",$J,LA7DOC,J)=" "
 Q
 ;
PC ; Parse field components
 ;
 F L=1:1:$L(Z,$E(HLECH,1)) D
 . S V=$P(Z,$E(HLECH,1),L) Q:V=""
 . I Z[$E(HLECH,1) D
 . . S J=J+1
 . . S ^TMP("DDB",$J,LA7DOC,J)=Y_"-"_($S(Y="MSH":K,1:K-1))_"-"_L_" = "_V
 . I V'[$E(HLECH,2) Q
 . ; Parse repetition of components.
 . F M=1:1:$L(V,$E(HLECH,2)) D
 . . S J=J+1
 . . S ^TMP("DDB",$J,LA7DOC,J)=Y_"-"_($S(Y="MSH":K,1:K-1))_"-"_L_"-"_M_" = "_$P(V,$E(HLECH,2),M)
 Q
 ;
EOP ; End of page.
 I LA7CONT W !!,"NOTE: '--->' indicates continuation of previous line." S LA7CONT=0
 I $D(ZTQUEUED)!(IOST'["C-") Q
 S DIR(0)="E" D ^DIR K DIR S:Y'=1 LA7QUIT=1
 Q
 ;
EXIT ; Clean up.
 W @IOF
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 K ^TMP($J),^TMP("DDB",$J)
 K LA7CONT,LA7IEN,LA7J,LA7LIST,LA7PARS,LA7QUIT,LA7ROOT,LA7TEST,LA7X,LA7Y
 K DIC,DIR,HDR,HLECH,HLFS,I,J,K,L,M,V,X,Y,Z
 K VAUTVB,VAUTNI,VAUTSTR,VAUTNALL
 Q
 ;
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
