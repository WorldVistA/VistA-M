PSODRGN ;BIR/SJA-ORDER ENTRY DRUG SELECTION ;02/15/07
 ;;7.0;OUTPATIENT PHARMACY;**268**;DEC 1997;Build 9
 ;Reference ^PSDRUG supported by DBIA 221
 ;
SELECT ;
 K:'$G(PSORXED) CLOZPAT
 K DIC,X,Y,PSODRUG("TRADE NAME"),PSODRUG("NDC"),PSODRUG("DAW") S:$G(POERR)&($P($G(OR0),"^",9)) Y=$P(^PSDRUG($P(OR0,"^",9),0),"^")
 I $G(PSODRUG("IEN"))]"" S Y=PSODRUG("NAME"),PSONEW("OLD VAL")=PSODRUG("IEN")
 S (PSDC,PSI)=0 W !!!,"The following Drug(s) are available for selection:"
 F PSI=0:0 S PSI=$O(^PSDRUG("ASP",PSODRUG("OI"),PSI)) Q:'PSI  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S($P($G(^PSDRUG(PSI,2)),"^",3)'["O":0,1:1) D
 .S PSDC=PSDC+1 W !,PSDC_". "_$P(^PSDRUG(PSI,0),"^")_$S($P(^(0),"^",9):"     (N/F)",1:"")
 .S PSDC(PSDC)=PSI
 I PSDC=0 D
 .N X,DRG
 .S DRG=+$P($G(^PSRX(DA,0)),"^",6)
 .S X=$$GET1^DIQ(50,DRG,100)
 .I X'="",(DT>X) D
 .. W !!,"   This Dispense Drug is now Inactive. You may select a"
 .. W !,"    new Orderable Item, or you can enter a new Order with"
 .. W !,"    an Active Drug.",!
 .E  W !!,"No drugs available!",!
 .K DIR S DIR(0)="E",DIR("A")="Press return to continue"
 .D ^DIR K DIR
 G:'PSDC ETX K PSOBDR S PSOBDR("NAME")=PSODRUG("NAME")
 I PSDC'=1 D
 .I $P($G(^PSDRUG(+$G(PSODRUG("IEN")),2)),"^")=$G(PSODRUG("OI")) Q
 .K PSODRUG("NAME"),PSODRUG("IEN")
 W ! D KV S DIR(0)="N^1:"_PSDC,DIR("A")="Select Drug by number" D ^DIR
 I $G(PSORXED),X["^" S PSORXED("DFLG")=1 G SELECTX
 I +$G(PSOEDIT)=1,X="^"!(X["^^")!($D(DTOUT)) S PSONEW("DFLG")=1 G SELECTX
 I '$G(POERR),X[U,$L(X)>1 S PSODIR("FLD")=PSONEW("FLD") D JUMP^PSODIR1 S:$G(PSODIR("FIELD")) PSONEW("FIELD")=PSODIR("FIELD") K PSODIR S PSODRG("QFLG")=1 G SELECTX
 I +$G(PSOEDIT)=1,$D(DTOUT) S PSONEW("DFLG")=1 G SELECTX
 I $D(DUOUT) K DUOUT G SELECT
 I Y<0 G SELECT
 S:$G(PSONEW("OLD VAL"))=+Y&('$G(PSOEDIT)) PSODRG("QFLG")=1
 D KV K PSOY S PSOY(0)=^PSDRUG(PSDC(Y),0),PSOY=PSDC(Y)_"^"_$P(PSOY(0),"^")
 I $P(PSOY(0),"^")="OTHER DRUG"!($P(PSOY(0),"^")="OUTSIDE DRUG") D TRADE
SELECTX K X,Y,DTOUT,DUOUT,PSDC,PSI,PSONEW("OLD VAL")
 Q
TRADE ;
 K DIR,DIC,DA,X,Y
 S DIR(0)="52,6.5" S:$G(PSOTRN)]"" DIR("B")=$G(PSOTRN) D ^DIR K DIR,DIC
 I X="@" S Y=X K DIRUT
 I $D(DIRUT) S:$D(DUOUT)!$D(DTOUT)&('$D(PSORX("EDIT"))) PSONEW("DFLG")=1 G TRADEX
 S PSODRUG("TRADE NAME")=Y
TRADEX I $G(PSORXED("DFLG")),$D(DIRUT) S PSORXED("DFLG")=1
 K DIRUT,DTOUT,DUOUT,X,Y,DA,DR,DIE
 Q
ETX S VALMBCK="R" I 'PSDC S VALMSG="NO dispense drugs tied to this orderable item!"
TX D KV K PSDC,PSI,X,Y
 Q
KV K DIR,DIRUT,DUOUT,DTOUT
 Q
6 ;Called from PSOBKDED due to it's routine size.
 I $G(PSOEDIT),$G(PSODRUG("NAME"))'=$G(PSOBDR("NAME")) D
 .S DIR(0)="Y",DIR("B")="YES"
 .S DIR("A",1)="You have changed the dispense drug from"
 .S DIR("A",2)=$P(PSOBDR("NAME"),"^")_" to "_$P(PSODRUG("NAME"),"^")_".",DIR("A",3)=""
 .F I=0:0 S I=$O(SIG(I)) Q:'I  S DIR("A",3+I)=$S(I=1:"Current SIG: ",1:"")_$G(SIG(I))
 .S DIR("A")="Do You want to Edit the SIG"
 .D ^DIR K DIR I $D(DIRUT) S PSORX("DFLG")=1 D M1^PSOOREDX Q
 .Q:$D(DIRUT)!('Y)
 .K PSOBDR D 10^PSOBKDED ;Dose
 Q
