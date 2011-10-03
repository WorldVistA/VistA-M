LA7UTIL ;DALISC/JRR - Utilities for Messenger
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,42**;Sep 27, 1994
CPT(X) N LA7,LA7CNT,Y
 K ^TMP("LA",$J) S LA7CNT=0
 F LA7=0:0 S LA7=$O(^LAB(64.4,LA7)) Q:'LA7  D
 . I ^LAB(64.4,LA7,0)[X S LA7CNT=LA7CNT+1 S ^TMP("LA",$J,LA7CNT)=LA7
 . ;KAT  ADDED FULL GLOBAL REFERENCE ^LAB(64.4,LA7,0) VS ^(LA7,0)
 I '$O(^TMP("LA",$J,0)) W "  ???" K X,LA7,^TMP("LA",$J) QUIT
 S X=""
 F LA7=0:0 S LA7=$O(^TMP("LA",$J,LA7)) Q:'LA7  D  Q:X!(LA7="")
 . S LA7(0)=^LAB(64.4,^TMP("LA",$J,LA7),0)
 . W !,?5,$J("("_LA7_") ",6),$P(LA7(0),"^"),?22,$TR($P(LA7(0),"^",2,99),"^","   ")
 . I (LA7#10=0)!('$O(^TMP("LA",$J,LA7))) D
 . . K DIR S DIR(0)="NOA^0:"_LA7,DIR("A")="Select [1-"_LA7_"]: "
 . . D ^DIR
 . . I X!$D(DUOUT)!$D(DTOUT) S LA7=""
 I X S X=$P(^LAB(64.4,^TMP("LA",$J,X),0),"^")
 I 'X K X
 K DIR,DTOUT,DUOUT,^TMP("LA",$J)
 QUIT
 ;
BU2 N J,S1,T,X
 S (J,S1)=0,(T,X)=LA7
 D TREE
 QUIT
TREE I '$D(^LAB(60,X,0)) Q  ;BAD LRTEST NUMBER;
 I $P(^LAB(60,X,0),U,5)]"",$D(^TMP("LA7TREE",$J,X,X)) S ^TMP("LA7TREE",$J,T,X)=^TMP("LA7TREE",$J,X,X)
 ;KAT ADDED FULL GLOBAL REFERENCE ^LAB(60,X,0) VS $P(^(0),U,5)
 Q:'$D(^LAB(60,X,2,0))  Q:$O(^(0))<1  ;NOT A PANEL
 S S1=S1+1,S1(S1)=X,J1(S1)=J
 F J=0:0 S J=$O(^LAB(60,S1(S1),2,J)) Q:J<1  S X=^(J,0) D TREE
 S J=J1(S1),X=S1(S1),S1=S1-1
 Q
UNWIND(LA760) ;unwind one panel, calls itself recursively to unwind all
 ;panels within other panels.  Returns all atomic tests in ^TMP global.
 ;Calling routine is responsible for killing ^TMP("LA7TREE" before and
 ;after the call.
 Q:$G(LA7TREEN)>999  ;recursive panel, caught in loop
 Q:'$D(^LAB(60,LA760,0))
 S ^TMP("LA7TREE",$J,LA760)=""
 S LA7TREEN=$G(LA7TREEN)+1
 Q:'$D(^LAB(60,LA760,2,0))  Q:$O(^(0))<1
 N I,II
 F I=0:0 S I=$O(^LAB(60,LA760,2,I)) Q:'I  D
 .  S II=+$G(^LAB(60,LA760,2,I,0)) I II D UNWIND(II)
 QUIT
PRETTY(LA76249) ;Store an HL7 message text in pretty print format, stored in 
 ;^TMP("LA7PRETTY",$J,.  Required variable is LA76249 = pointer to 
 ;^LAHM(62.49), passed as parameter.
 ;
 K ^TMP("LA7PRETTY",$J)
 Q:'$D(^LAHM(62.49,LA76249,0))
 Q:'$D(^LAHM(62.49,LA76249,150,1,0))
 N LA7,LA7624,LA7FS,LA7INST,X,Y,Z,%
 S LA7=$P(^LAHM(62.49,LA76249,0),"^",2)
 S LA7FS=$E($G(^LAHM(62.49,LA76249,150,1,0)),4)
 S:LA7FS="" ^TMP("LA7PRETTY",$J,2)="<Bad Message Header>"
 Q:LA7FS=""
 G:LA7="O" PRETOUT
 G:LA7="I" PRETIN
 QUIT
PRETIN S ^TMP("LA7PRETTY",$J,1)="Result received from "
 S LA7INST=$P(^LAHM(62.49,LA76249,0),"^",6)
 I LA7INST="" D
 . F LA7=0:0 S LA7=$O(^LAHM(62.49,LA76240,150,LA7)) Q:LA7=""  D
 . . S Z=$G(^LAHM(62.49,LA76249,150,LA7,0))
 . . Q:Z=""!($E(Z,1,3)'="OBR")
 . . S LA7INST=$P(Z,LA7FS,19)
 S ^LAHM(62.49,LA76240,150,1)=^TMP("LA7PRETTY",$J,1)_LA7INST
 ;KAT ADDED ^LAHM(62.49,LA76240,150,LA7 VS ^(1)
 S Y=$P(^LAHM(62.49,LA76249,0),"^",5)
 D DD^%DT
 S ^LAHM(62.49,LA76249,1)=^TMP("LA7PRETTY",$J,1)_",  "_Y
 ;KAT ADDED ^LAHM(62.49,LA76249 VS ^(1)
 S LA7624=$O(^LAB(62.4,"B",LA7INST,0))
 F LA7=0:0 S LA7=$O(^LAHM(62.49,LA76249,150,LA7)) Q:LA7=""  D
 . S X=$G(^LAHM(62.49,LA76249,150,LA7,0))
 . Q:(X="")!($E(X,1,3)'="PID")  ;find PID segment for SSN
 . S Y=+$P(X,LA7FS,4) ;get ssn
 . S Z=Y
 . S Y=+$O(^DPT("SSN",Y,0)) ;get dfn
 . S ^TMP("LA7PRETTY",$J,2)="Patient: "_$P($G(^DPT(Y,0)),"^")_"   SSN: "_Z
 Q
PRETOUT ;
 ;
LOG ;Print the error log which is stored in ^XTMP.  Errors are logged
 ;only if the Debug Log field is turned on in 62.48
 N LA7,LA76249,LA7DT,LA7TM,LA7TXT,LA7XTMP
 D DT^DICRW
 S LA7XTMP="LA7"_DT
 I '$O(^XTMP(LA7XTMP,0)) W !!,?5,"Nothing logged for Today!"
 K DIR
 S DIR("A")="Look at log for what date? "
 S DIR("B")="TODAY"
 S DIR("?")="^D HELP^%DTC"
 S DIR(0)="DA^:DT:EX"
 D ^DIR
 Q:$D(DIRUT)
 S LA7XTMP="LA7"_Y
 I '$O(^XTMP(LA7XTMP,0)) D  G LOG
 . W !!,?5,"Nothing logged for " X ^DD("DD") W Y
 S LA7TM=""
 F  S LA7TM=$O(^XTMP(LA7XTMP,LA7TM),-1) Q:LA7TM=0  D  Q:LA7QUIT
 . S LA7QUIT=0
 . I $Y>(IOSL-3) D  W @IOF Q:LA7QUIT
 . . I "Pp"'[$E(IOST) K DIR S DIR(0)="E" D ^DIR I 'Y S LA7QUIT=1 Q
 . S LA7=$E(LA7XTMP,4,10)
 . W:$X !! W $E(LA7,4,5),"/",$E(LA7,6,7)
 . W "@",$E(LA7TM,1,4)_$E("0000",$L($E(LA7TM,1,4)),3)," "
 . W $P(^XTMP(LA7XTMP,LA7TM),"^",2)," " S X=$P($P(^(LA7TM),"^",3),":")
 . F LA7=1:1:$L(X," ") S Y=$P(X," ",LA7) W:($L(Y)+$X+1)>IOM ! W " ",Y
 Q
 ;
CADT(LA7AA) ; Calculate current accession date based on accession area transform
 ; Call with LA7AA = ien of accession area
 N LA7AD,X
 S DT=$$DT^XLFDT
 S X=$P($G(^LRO(68,+$G(LA7AA),0)),"^",3) ; Accession transform
 S LA7AD=$S(X="D":DT,X="M":$E(DT,1,5)_"00",X="Y":$E(DT,1,3)_"0000",X="Q":$E(DT,1,3)_"0000"+(($E(DT,4,5)-1)\3*300+100),1:DT) ; Calculate date
 Q LA7AD
