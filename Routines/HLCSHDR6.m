HLCSHDR6 ;OIRMFO/LJA - Make HL7 header for TCP ;1/27/03 15:30
 ;;1.6;HEALTH LEVEL SEVEN;**93**;Oct 13, 1995
 ;
MARKERRA ; Mark 772 & 773 entries in error (to stop messaging)...
 N %ZHO,ERR,ERREA,HLD,HLTCP,IEN772,IEN773,MSH,N02,POSX,X
 D HDERR
 R !!,"Enter ERROR REASON: ",ERREA:999 Q:'$T!(ERREA']"")!(ERREA[U)  ;->
 F  D  Q:'IEN772  W !!,$$REPEAT^XLFSTR("-",IOM)
 .  R !!," 772:  ",IEN772:9999 Q:IEN772'>0!('$T)  ;->
 .  S N02=$G(^HL(772,+IEN772,0))
 .  W !!,"772-0: "
 .  S POSX=$X
 .  W $E(N02,1,IOM-POSX)
 .  S X=$G(^HL(772,+IEN772,"P")) I X]"" W !,?(POSX-3),"P: ",$E(X,1,IOM-POSX)
 .  KILL HLD
 .  W:$D(^HLMA("B",+IEN772)) !!,"773s:",?POSX
 .  S IEN773=0
 .  F  S IEN773=$O(^HLMA("B",+IEN772,IEN773)) Q:IEN773'>0  D
 .  .  W:$X>POSX ! W:$X<POSX ?POSX
 .  .  S HLD(IEN773)=""
 .  .  S X=$G(^HLMA(+IEN773,"P")) I X]"" W "  P: ",$E(X,1,IOM-$X)
 .  .  W:$X>POSX ! W:$X<POSX ?POSX
 .  .  W "MSH: "
 .  .  S POSX=$X
 .  .  S MSH=$G(^HLMA(+IEN773,"MSH",1,0))
 .  .  F  D  Q:MSH']""
 .  .  .  W:$X>POSX ! W:$X<POSX ?POSX
 .  .  .  W $E(MSH,1,IOM-POSX)
 .  .  .  S MSH=$E(MSH,IOM-POSX+1,999)
 .  R !!,"Press RETURN to mark errored, or enter '^' to abort... ",X:999 I '$T!(X]"") D  QUIT  ;->
 .  .  W "  no action taken..."
 .  W !!,?10,"Marking 772's #",IEN772," errored... "
 .  S ERR=$$ERR(772,IEN772,ERREA)
 .  W $S(ERR:"  done...",1:"Aborted!! "_$P(ERR,U,2)_"...")
 .  I '$D(HLD) QUIT  ;->
 .  S IEN773=0
 .  F  S IEN773=$O(HLD(IEN773)) Q:IEN773'>0  D
 .  .  W !,?10,"Marking 773's #",IEN773," errored... "
 .  .  S ERR=$$ERR(773,IEN773,ERREA)
 .  .  W $S(ERR:"  done...",1:"Aborted!! "_$P(ERR,U,2)_"...")
 ;
 Q
 ;
MARKERRG ; Global-based error marking of 772, 773...
 N %ZHO,ERR,ERREA,HLD,HLTCP,IEN772,IEN773,MSH,N02,POSX,X
 D HDERR
 R !!,"Enter ERROR REASON: ",ERREA:999 Q:'$T!(ERREA']"")!(ERREA[U)  ;->
 I '$D(^TMP("HLCSHDR5 ERR",$J)) D  QUIT  ;->
 .  W !!,"No ^TMP(""HLCSHDR5 ERR"",$J) data exists..."
 .  W !
 W !!,"The entries in ^TMP(""HLCSHDR5 ERR"",$J) will be marked in error now."
 R !!,"Press RETURN to start error marking... ",X:999 Q:'$T!(X]"")  ;->
 ;
ERRQ S IEN772=0
 F  S IEN772=$O(^TMP("HLCSHDR5 ERR",$J,IEN772)) Q:IEN772'>0  D
 .  W !,"Marking 772's #",IEN772,"... "
 .  S ERR=$$ERR(772,IEN772,ERREA)
 .  W $S(ERR:"  done...",1:"Aborted!! "_$P(ERR,U,2)_"...")
 .  S IEN773=0
 .  F  S IEN773=$O(^HLMA("B",IEN772,IEN773)) Q:IEN773'>0  D
 .  .  S ERR=$$ERR(773,IEN773,ERREA)
 .  .  W !,"   - 773# ",IEN773," checked..."
 Q
 ;
HDERR W @IOF,$$CJ^XLFSTR("Error Marking Utility",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
ERR(FILE,IEN,ERREA) ; Change status to ERROR for 772 or 773 (if the P
 ; node status exists.)
 ;
 N DATA,ERR,HLTCP
 ;
 I FILE=772 D  QUIT:ERR U_$P(ERR,U,2,99) ;->
 .  S ERR=""
 .  I $G(^HL(772,+$G(IEN),0))']"" S ERR="1^NO 772 0 NODE" QUIT  ;->
 ;
 I FILE=773 D  QUIT:ERR U_$P(ERR,U,2,99) ;->
 .  S HLTCP=1 ; Used by STATUS^HLTF0
 .  S ERR=""
 .  I $G(^HLMA(+$G(IEN),0))']"" S ERR="1^NO 773 0 NODE" ;->
 ;
 QUIT:$G(ERREA)']"" "^NO REASON" ;->
 ;
 ; Does entry need to be marked in error.  (Only mark if status
 ; already exists)
 S DATA=$S(FILE=772:$G(^HL(772,+IEN,"P")),1:$G(^HLMA(+IEN,"P")))
 QUIT:$P(DATA,U)']"" 1 ;->
 ;
 D STATUS^HLTF0(IEN,4,"",ERREA,1)
 ;
 Q 1
 ;
EOR ;HLCSHDR6 - Make HL7 header for TCP ;1/27/03 15:30
