FBUCUTL1 ;ALBISC/TET - UNAUTHORIZED CLAIMS UTILITY (CONT'D) ;5/19/93  15:35
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
SELECT(I,DIRA) ;select from displayed list
 ;INPUT:  FBAR and FBAR array - choices from which to select
 ;        DIRA - optional, DIR("A")/ FBOUT = 0
 ;OUTPUT: FBARY and FBARY array - selection
 ;         or FBOUT = 1 if no selection or time out or up arrow
 Q:'+$G(FBAR)  N FBDCT S DIR(0)="LO^1:"_I_"^K:X#1 X",DIR("A")=$S('$D(DIRA):"Enter selection",DIRA']"":"Enter selection",1:DIRA) W ! D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) FBOUT=1 Q:FBOUT!('Y)  I +Y S FBARY(0)=Y D SET(FBARY(0)) ;K FBARY(0)
 Q
SET(FBY) ;set up tmp global
 ;INPUT:  FBY = user selection from list call
 ;OUTPUT: TMP(FBARY array = user selection array
 ;        FBARY = counter;piece location node
 N FBDCT,I
 S FBDCT=($L(FBY,","))-1,FBARY=FBDCT,$P(FBARY,";",2)=$S($G(FBAR)]"":$P(FBAR,";",2),1:""),^TMP("FBARY",$J,"FBARY")=FBARY F I=1:1:FBDCT I '($P(FBY,",",I)#1) S ^TMP("FBARY",$J,$P(FBY,",",I))=$G(^TMP("FBAR",$J,$P(FBY,",",I)))
 Q
DISPX(DISP,SCR) ;display array for user selection
 ;INPUT:  DISP=0 to display only; make no selection
 ;            =1 to display prior to selection only
 ;            =2 to display what was selected in addition to what to select
 ;        SCR = flag if data was screened; used in message if nothing found <optional>
 ;        TMP("FBAR",$J,"FBAR")=count;piece position
 ;        TMP("FBAR"=display global array of what to select
 ;OUTPUT:  FBOUT = 0 if ok, 1 if time out or quit or no selection
 K ^TMP("FBARY") S:'$D(FBOUT) FBOUT=0 G:FBOUT END S DISP=+$G(DISP),SCR=+$G(SCR) N I,P,FBA,FBAR,FBCT,FBNODE,FBPL,FBW S (FBCT,FBARY)=0 S:$G(DISP)']"" DISP=0
 S FBAR=$G(^TMP("FBAR",$J,"FBAR")) I '+FBAR W ! W:'SCR "No data on file." W:SCR "Nothing found which meets the criteria." W ! H 2 G END
 D PARSE^FBUCUTL4(FBAR) ;I +FBAR=1 S FBARY(0)=1 D SET(FBARY(0)) ;S ^TMP("FBARY",$J,1)=^TMP("FBAR",$J,1),^TMP("FBARY",$J,"FBARY")=FBAR,FBARY=$G(^TMP("FBARY",$J,"FBARY"))
 I +FBAR!(DISP=0) W:DISP>0 @IOF W:DISP>0 !?3,"Select from the following:",!! S FBA="Enter RETURN for more, or Select",I=0 F  S I=$O(^TMP("FBAR",$J,I)) Q:'I!(FBARY&(DISP>0))  D  G:FBOUT END
 .I ($Y+5)>IOSL D SELECT(FBCT,FBA):FBCT&(DISP),CR:FBCT&('DISP) Q:FBOUT!(+FBARY&(DISP>0))  W @IOF,!
 .S FBCT=FBCT+1,FBNODE=$G(^TMP("FBAR",$J,I)) D LINE^FBUCUTL4(FBNODE,FBCT,$L(FBNODE,"^"),FBW)
 Q:FBOUT  W:'DISP ! I DISP,'+FBARY S FBCT=$S(FBCT:FBCT,1:+FBAR) D SELECT(FBCT) Q:FBOUT
DISPY ;display user selection
 ;INPUT:  FBARY( - user selection array
 ;        FBARY  - count in array;position locations (delimitted by ^)
 ;        FBP    - number or '^' piece delimiters
 ;        FBW    - write positions, delimited by '^'
 ;OUTPUT: FBOUT  - 1 if time out or up arrow, 0 if OK
 S:'$D(FBOUT) FBOUT=0 S FBARY=$G(^TMP("FBARY",$J,"FBARY")) I $S('+FBARY:1,DISP'=2:1,1:0) G END
 N FBNODE,I I '$G(FBPL)!('$G(FBW)) N FBPL,FBW D PARSE^FBUCUTL4(FBARY)
 W ! S I=0 F  S I=$O(^TMP("FBARY",$J,I)) Q:'I  S FBNODE=$G(^(I)) D LINE^FBUCUTL4(FBNODE,I,FBPL,FBW) ;W ! F P=1:1:FBP W ?($P(FBW,U,P)),$P($P(FBARY(I),";",2),U,P) W:P=5 !
 I +FBARY S DIR(0)="Y",DIR("A")="You have selected the above.  OK",DIR("B")="YES" D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) FBOUT=1 I 'Y,'FBOUT D DISPX(DISP)
END ;kill variables and quit
 K DIRUT,DTOUT,DUOUT,FBAR,X,Y Q
CR ;end of page
 W ! S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) FBOUT=1
 Q
