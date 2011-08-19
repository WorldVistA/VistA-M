LRUTT ;AVAMC/REG/CYM - LAB TEST TURNAROUND TIME; 2/19/98 ;
 ;;5.2;LAB SERVICE;**153,201,354**;Sep 27, 1994
 D END W !!?24,"Laboratory Test Turnaround Times"
AT S DIC=60,DIC(0)="AEQM" D ^DIC K DIC I Y>0 S LRT(+Y)=$P(Y,U,2) G AT
 I '$D(LRT) W $C(7),!,"NO TESTS SELECTED" G END
HL W ! S LRL="",INSTFLAG=0 K DIR S DIR("?",1)="Select an entry from the HOSPITAL LOCATION file (#44) or an entry from",DIR("?",2)="the INSTITUTION file (#4).",DIR("?",3)=""
 S DIR("?",4)="To specify a selection from the HOSPITAL LOCATION file (#44), enter your",DIR("?",5)="selection with the 'L.' prefix.  Enter 'L.?' to see the list of entries in",DIR("?",6)="the HOSPITAL LOCATION file (#44)."
 S DIR("?",7)="",DIR("?",8)="To specify a selection from the INSTITUTION file (#4), enter your selection",DIR("?",9)="with the 'I.' prefix.  Enter 'I.?' to see the list of entries in the",DIR("?",10)="INSTITUTION file (#4)."
 S DIR("?",11)="",DIR("?",12)="If the selection entered does not have the 'L.' or 'I.' prefix, the HOSPITAL",DIR("?",13)="LOCATION file (#44) will be searched for a match first.  If no match is"
 S DIR("?")="found, the INSTITUTION file (#4) will then be searched for a match."
 S DIR("A")="Select HOSPITAL LOCATION NAME: ",DIR(0)="FOA" D ^DIR I $D(DIRUT) G END
 S LRY=Y D LOC I LRL="" G HL
 W ! D B^LRU G:Y<0 END S LRSDT=LRSDT-.1,LRLDT=LRLDT+.9
 W !!,"Print patients " S %=2 D YN^LRU S:%=1 LRI=1
 S ZTRTN="QUE^LRUTT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU,H S LR("F")=1 F A=0:0 S A=$O(LRT(A)) Q:'A  S (LRG(A),LRH(A))=0
 F LRA=LRSDT:0 S LRA=$O(^LRO(69,LRA)) Q:'LRA!(LRA>LRLDT)  D
 . I 'INSTFLAG D
 . . F LRB=0:0 S LRB=$O(^LRO(69,LRA,1,"AC",LRL,LRB)) Q:'LRB  F T=0:0 S T=$O(^LRO(69,LRA,1,LRB,2,"B",T)) Q:'T  D:$D(LRT(T)) C
 . I INSTFLAG D
 . . S XLRL="" F  S XLRL=$O(^LRO(69,LRA,1,"AC",XLRL)) Q:XLRL=""  I $$INSTHIT(XLRL) F LRB=0:0 S LRB=$O(^LRO(69,LRA,1,"AC",XLRL,LRB)) Q:'LRB  F T=0:0 S T=$O(^LRO(69,LRA,1,LRB,2,"B",T)) Q:'T  D:$D(LRT(T)) C
 F A=0:0 S A=$O(LRT(A)) Q:'A!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !,LRT(A),?30,"Count: ",$J(LRH(A),5),?45,"Average time:" I LRG(A) S X=LRG(A)\LRH(A),Y=X\60,X=X#60 W:Y $J(Y,3)," hr" W:X ?65,$J(X,2)," min"
 F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=^LR(A,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)") S ^TMP($J,"B",$P(X,"^"),A)=$P(X,"^",9)
 W ! S LRP=0 F Q=0:0 S LRP=$O(^TMP($J,"B",LRP)) Q:LRP=""!(LR("Q"))  F A=0:0 S A=$O(^TMP($J,"B",LRP,A)) Q:'A!(LR("Q"))  S SSN=^(A),LRDPF=$P(^LR(A,0),U,2) D SSN^LRU D:$Y>(IOSL-6) H Q:LR("Q")  W !,LRP,?31,SSN D L
 D END^LRUTL,END Q
T S V=$P(X,".",2)_"000",V=$E(V,1,2)*60+$E(V,3,4) D H^%DTC S X=%H_"."_$E("0000",1,4-$L(V))_V Q
L F T=0:0 S T=$O(^TMP($J,A,T)) Q:'T!(LR("Q"))  F B=0:0 S B=$O(^TMP($J,A,T,B)) Q:'B!(LR("Q"))  F C=0:0 S C=$O(^TMP($J,A,T,B,C)) Q:'C!(LR("Q"))  F E=0:0 S E=$O(^TMP($J,A,T,B,C,E)) Q:'E!(LR("Q"))  D W
 K T,B,C,E
 Q
W D:$Y>(IOSL-6) H1 Q:LR("Q")
 W !?3,LRT(T),?32,$$Y2K^LRX(B,"5D"),?44 S X(1)=^TMP($J,A,T,B,C,E),X=+X(1),Y=X\60,X=X#60 W:Y $J(Y,3)," hr" W:X ?50,$J(X,2)," min" W ?60,"Arr time:" S X=$P(X(1),"^",2) W $E(X,1,2)_":"_$E(X,3,4) Q
 ;
C S E=$O(^LRO(69,LRA,1,LRB,2,"B",T,0)),LRS=$S($D(^LRO(69,LRA,1,LRB,3)):+^(3),1:0),E=$S($D(^(2,E,0)):^(0),1:""),W=$P(E,"^",4),LRC=$P(E,"^",3),LRX=$P(E,"^",5)
 I $P(E,"^",11)'="" Q
 I $$CANCEL Q
 I LRS,W,LRC,LRX,$D(^LRO(68,W,1,LRC,1,LRX,4,T,0)) S X=$P(^(0),"^",5) Q:X'["."  Q:$P(^(0),"^",8)=""  D T S LRF=X D S
 Q
S S (LRS(1),X)=LRS D T S LRS=X,LRDFN=+^LRO(68,W,1,LRC,1,LRX,0) S X=$P(LRF,".")-$P(LRS,".") S:X X=X*1440 S LRT=X+$P(LRF,".",2)-$P(LRS,".",2)
 S LRG(T)=LRG(T)+LRT,LRH(T)=LRH(T)+1 S:$D(LRI) ^TMP($J,LRDFN,T,LRA,W,LRX)=LRT_"^"_$P(LRS(1),".",2)_"000" Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Location: ",LRL,!,"Laboratory test turnaround times from: ",LRSTR," to ",LRLST,!,LR("%") Q
 ;
H1 D H Q:LR("Q")  W !,LRP,?31,SSN Q
 ;
END D V^LRU K INSTFLAG,XLRL Q
LOC ; check file 44 for location entered
 I $E(LRY,1,2)="L."!($E(LRY,1,2)="l.") S LRY=$E(LRY,3,99) D HLOC Q
 I $E(LRY,1,2)="I."!($E(LRY,1,2)="i.") S LRY=$E(LRY,3,99) D INST Q
 D HLOC I Y<1 D INST
 Q
HLOC S X=LRY,DIC=44,DIC(0)="EMZ" D ^DIC K DIC I Y'<1 S LRL=$P(Y(0),U,2) I LRL="" W $C(7),!!,"There must be an abbreviation entered for the hospital location!"
 Q
INST ; check file 4 for location entered
 S X=LRY,DIC=4,DIC(0)="EQMZ",DIC("S")="I $G(^DIC(4,Y,99))" D ^DIC K DIC I Y'<1 S LRL=$P(Y(0),"^"),INSTFLAG=1
 Q
INSTHIT(XLOC) ;
 N HIT,LOCNUM,INSTNUM,X99
 S HIT=0
 S LOCNUM=$O(^SC("C",XLOC,0))
 I LOCNUM'="" D
 . S INSTNUM=$P($G(^SC(LOCNUM,0)),U,4)
 . Q:INSTNUM=""
 . I $D(^DIC(4,"B",LRL,INSTNUM)) D
 . . S X99=$G(^DIC(4,INSTNUM,99))
 . . Q:X99=""
 . . I $P(X99,U,4) Q
 . . S HIT=1
 Q HIT
CANCEL() ;
 ; This function checks to see if a test was cancelled. 
 ; If the test was cancelled the function evaluates as "true".
 N CANFLAG,COLTIME,LRTIME,LRID,TESTNUM,LR63,PC1
 S CANFLAG=0
 S COLTIME=$P($G(^LRO(69,LRA,1,LRB,1)),"^",1)
 I COLTIME D
 . S LRTIME=9999999-COLTIME
 . S LRID=$P($G(^LRO(69,LRA,1,LRB,0)),"^",1)
 . I LRID="" Q
 . S TESTNUM=$G(^LAB(60,T,.2))
 . I TESTNUM="" Q
 . S LR63=$G(^LR(LRID,"CH",LRTIME,TESTNUM))
 . I LR63="" Q
 . S PC1=$P(LR63,"^",1)
 . I PC1="" Q
 . I $E(PC1,1,$L(PC1))=$E("CANCELLED",1,$L(PC1))!($E(PC1,1,$L(PC1))=$E("cancelled",1,$L(PC1))) S CANFLAG=1
 Q CANFLAG
