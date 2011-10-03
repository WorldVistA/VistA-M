XPARLIST ; SLC/KCM - List parameter values ;8/30/07  16:27
 ;;7.3;TOOLKIT;**26,72,109**;Apr 25, 1995;Build 5
 ;
ALLPARS ; Select parameter and list values
 N PAR
 D GETPAR^XPAREDIT(.PAR) Q:'PAR
 D ALLPAR(+PAR)
 Q
ALLPAR(PAR) ; List values given parameter
 N ENT,INST,VAL,LN,DIRUT,DUOUT,DTOUT
 W !!,"Values for "_$P(^XTV(8989.51,PAR,0),U),!! S LN=1
 D HEADER
 S ENT=0 F  S ENT=$O(^XTV(8989.5,"AC",PAR,ENT)) Q:'ENT  D  Q:$D(DIRUT)
 . S INST=""
 . F  S INST=$O(^XTV(8989.5,"AC",PAR,ENT,INST)) Q:INST=""  D  Q:$D(DIRUT)
 . . D WAIT Q:$D(DIRUT)
 . . S VAL=^XTV(8989.5,"AC",PAR,ENT,INST)
 . . W $E($$ENTNAME(ENT),1,30),?31
 . . W $E($$EXT^XPARDD(INST,PAR,"I"),1,20),?52
 . . W $E($$EXT^XPARDD(VAL,PAR,"V"),1,28),!
 I '$D(DIRUT) S DIR(0)="E" D ^DIR
 Q
ALLENTS ; Select entity and list values
 N PAR,ENT
 S PAR=$O(^XTV(8989.51,"B","XPAR ALL ENTITIES",0))
 D GETENT^XPAREDIT(.ENT,PAR_"^Entities") Q:'ENT
 D ALLENT(ENT)
 Q
ALLPKG ; Select package
 N DIC,Y
 S DIC=9.4,DIC(0)="AEMQ" D ^DIC Q:Y<0
 D ALLENT(+Y_";DIC(9.4,")
 Q
ALLENT(ENT) ; List values given entity
 N IEN,PAR,INST,VAL,LN,DIRUT,DUOUT,DTOUT
 K ^TMP($J)
 W !!,"Values for "_$$ENTNAME(ENT),!! S LN=1
 D HEADER
 S IEN=0 F  S IEN=$O(^XTV(8989.5,"B",ENT,IEN)) Q:'IEN  D
 . S X=^XTV(8989.5,IEN,0),VAL=$G(^XTV(8989.5,IEN,1)) ;p109
 . Q:($P(X,U,2)="")!($P(X,U,3)="")
 . S ^TMP($J,$P(X,U,2),$P(X,U,3))=VAL
 . S ^TMP($J,$P(X,U,2),$P(X,U,3),IEN)=""
 S PAR=0 F  S PAR=$O(^TMP($J,PAR)) Q:'PAR  D  Q:$D(DIRUT)
 . I '$D(^XTV(8989.51,PAR)) W ">> BROKEN PTR TO PARAMETER ("_PAR_")",! Q
 . S INST="" F  S INST=$O(^TMP($J,PAR,INST)) Q:INST=""  D  Q:$D(DIRUT)
 . . D WAIT Q:$D(DIRUT)
 . . S VAL=^TMP($J,PAR,INST)
 . . W $E($P(^XTV(8989.51,PAR,0),U),1,30),?31
 . . W $E($$EXT^XPARDD(INST,PAR,"I"),1,20),?52
 . . W $E($$EXT^XPARDD(VAL,PAR,"V"),1,28),!
 I '$D(DIRUT) S DIR(0)="E" D ^DIR
 K ^TMP($J)
 Q
TMPLT(TLT) ; List values given template
 N DIC,Y,ALLENT,ALLINST,DTOUT,DUOUT,DIRUT
 I '$G(TLT),$L($G(TLT)) S TLT=$O(^XTV(8989.52,"B",TLT,0))
 I '$D(^XTV(8989.52,+$G(TLT),0)) N TLT S DIC=8989.52,DIC(0)="AEMQ" D ^DIC Q:Y<0  S TLT=+Y
 D SELENT^XPAREDT3(.ALLENT,TLT) Q:$D(DTOUT)!$D(DUOUT)
 D SELINST^XPAREDT3(.ALLINST,ALLENT,TLT) Q:$D(DTOUT)!$D(DUOUT)
 D SHWTLT^XPAREDT3(ALLENT,ALLINST,TLT)
 S DIR(0)="E" D ^DIR
 Q
WAIT ; pause display
 S LN=LN+1 I LN>(IOSL-4) S DIR(0)="E" D ^DIR W !! D:'$D(DIRUT) HEADER S LN=0
 Q
ENTNAME(ENT) ; Return TYP: Entity
 N X,FN
 S FN=+$P(@(U_$P(ENT,";",2)_"0)"),U,2),X=$P(^XTV(8989.518,FN,0),U,2)
 S X=X_": "_$$EXTPTR^XPARDD(+ENT,FN)
 Q X
 ;
HEADER ;
 W "Parameter",?31,"Instance",?52,"Value",!
 W $$REPEAT^XLFSTR("-",IOM-4),!
 Q
