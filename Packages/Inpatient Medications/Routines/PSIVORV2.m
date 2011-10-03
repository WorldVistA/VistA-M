PSIVORV2 ;BIR/MLM-VIEW AN ORDER (PHARMACY) ;20 Jul 98 / 2:22 PM
 ;;5.0; INPATIENT MEDICATIONS ;**15,81**;16 DEC 97
 ;
 Q
 ;***
 ;V5.0 will be using ^PSJLIFN instead. Other sub-modules in this routine
 ;are being used by IPF...
 ;***
EN ; Display order with numbers.
 D EN^PSJLIORD(DFN,ON) Q
 N PSIVNUM S PSIVNUM=1
 ;
ENNONUM(DFN,PSJORD) ; Display order with no numbers.
 S UL80="",$P(UL80,"=",80)=""
 W:'$G(PSJPRF)&($Y) @IOF W !!,"Patient: ",VADM(1)," (",$P(VADM(2),U,2),")",?52,"Wt (kg): ",PSJPWT," ",PSJPWTD
 W !?3,"Ward: ",$S(VAIN(4):$P(VAIN(4),U,2),1:"OUTPATIENT"),?52,"Ht (cm): ",PSJPHT," ",PSJPWTD
 W !,?1,"Status: ",$$CODES^PSIVUTL(P(17),$S(P("PON")'["V":53.1,1:55.01),$S(P("PON")'["V":28,1:100)) W:P("PON")["V" ?47,"Order number: ",+P("PON") W !,UL80,!
 ;
ENPRO ; Profile view.
 N PSIVAC,Y,PSGEBN,PSGLI,PSJSTAR,PSIV531
 S (PSGEBN,PSGLI)=""
 S PSIVAC="C",P("PON")=ON
 S PSIVUP=+$$GTPCI^PSIVUTL
 S P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I")
 NEW PSJL
 N PSIVNUM S PSIVNUM=1
 I P("OT")="I" D
 . S PSJSTAR="(1)^(4)^(5)^(6)^(7)^(9)^(10)"
 . D ^PSJLIVMD
 I P("OT")'="I" D
 . S PSJSTAR="(1)^(2)^(3)^(4)^(5)^(6)^(7)^(9)"
 . D ^PSJLIVFD
 NEW PSIVX
 F PSIVX=0:0 S PSIVX=$O(^TMP("PSJI",$J,PSIVX)) Q:'PSIVX  W !,^(PSIVX,0)
 K ^TMP("PSJI",$J)
 Q
LONG(Y) ; Display long fields.
 F X=1:1:$L(Y," ") D:$X+$L($P(Y," ",X))>$S(LN<11:42,1:80) RC W ?5,$P(Y," ",X)," "
 Q ""
WTPC ; Write provider comments.
 W ?3,Y,!
 ;
PAUSE ;Hold display if end screen, do FF if eop.
 I $E(IOST)="C",($Y#IOSL)>20 N DIR,X,Y S DIR(0)="E" D ^DIR Q:$D(DUOUT)!$D(DTOUT)  W !
 Q
 ;
RC ; Print field by line number
 N X,Y S LN=LN+1 D:LN<11 @LN W !
 Q
 ;
1 ; Type
 W ?56,"Type: " S X=$$CODES^PSIVUTL(P(4),53.1,53) W $S($E(X)="C":"CHEMO",1:X),$S(P(23)'="":" ("_P(23)_")",1:""),$S(P(5)=1:" (I)",P(5)=0:"(C)",1:"")
 Q
 ;
2 ;Syringe Size
 W:P("SYRS")]"" ?51,"Syr. Size: ",$E(P("SYRS"),1,13) W:$L(P("SYRS"))>13 "..."
 Q
 ;
3 ; IV Room
 W ?53,"IV Room: ",$P(P("IVRM"),U,2)
 Q
 ;
4 ; Start Date
 S X="" I $D(PSIVNUM) S:P("DTYP") X=$S(P(17)="P"!(PSIVAC="PN"):" ",1:"*")_$S(P("DTYP")=1:"(12)",$E(P("OT"))="I":"(10)",1:"(8)")
 W ?48-$L(X),X,?50,"Start Date: ",$$WDTE^PSIVUTL(P(2))
 Q
 ;
5 ; Stop Date
 S X="" I $D(PSIVNUM) S:P("DTYP") X=$S(P(17)="P"!(PSIVAC="PN"):" ",1:"*")_$S(P("DTYP")=1:"(13)",$E(P("OT"))="I":"(11)",1:"(9)")
 W ?48-$L(X),X,?51,"Stop Date: ",$$WDTE^PSIVUTL(P(3))
 Q
 ;
6 ; Log-in Date
 W ?50,"Login Date: ",$$WDTE^PSIVUTL(P("LOG"))
 Q
 ;
7 ; Last fill date.
 S Y=$$WDTE^PSIVUTL(P("LF")) W ?51,"Last Fill: ",$S(Y="******":"** Not printed **",1:Y)
 Q
 ;
8 ;Last fill qty.
 W ?52,"Quantity: ",+P("LFA")
 Q
 ;
9 ; Entry Code
 W ?50,"Entry Code: ",$S($P(P("CLRK"),U,2)]"":$E($P(P("CLRK"),U,2),1,18),1:"*** Undefined")
 Q
 ;
10 ; Provider
 S X="" I $D(PSIVNUM),P("DTYP") S X=$S(PSIVAC="PN":" ",1:"*")_$S(P("DTYP")=1:"(14)",$E(P("OT"))="I":"(12)",1:"(10)") ;I P(17)="P",(+P("CLRK")=+P(6)) S X=""
 W ?48-$L(X),X,?52,"Provider: ",$S($P(P(6),U,2)]"":$E($P(P(6),U,2),1,18),1:"*** Undefined")
 Q
ENNH(ON) ;
 I ON'["V" D GT531^PSIVORFA(DFN,ON) S:P(4)="" P(4)="P",(P(2),P(3))="" N PSIV531 S PSIV531=1
 I ON["V" D GT55^PSIVORFB
 N UL S UL="",$P(UL,"-",70)="" W !!,?5,UL,!,?5,"Patient: ",PSGP(0),?54,"Status: ",$S(P(17)="DE":"DC (EDIT)",1:$$CODES^PSIVUTL(P(17),$S(ON'["V":53.1,1:55.01),$S(ON'["V":28,1:100))),!
 D ENPRO
 Q
