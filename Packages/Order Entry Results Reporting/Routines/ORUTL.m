ORUTL ; slc/dcm,RWF - Order utilities; ;3/28/08  15:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**95,280**Dec 17, 1997;;Build 85
LOC ;;GET PT. LOCATION
 S C(1)=$S($D(ORL(2))#2:$S(ORL(2)[";":$S($D(@("^"_$P(ORL(2),";",2)_+ORL(2)_",0)")):$P(^(0),"^"),1:""),1:""),1:"")
 I 'OR4,ORVP[";DPT(",$D(ORL(2)),ORL(2) Q
 G:$L(C(1)) LOC1 S (CT,C)=0,O=1 I ORVP[";DPT(",$O(^DPT(+ORVP,"DE",0))>0 W !!,"Currently enrolled in the following clinics: ",!
 I  S I=0 F L=0:0 S I=$O(^DPT(+ORVP,"DE",I)) Q:I'>0  I $D(^(I,0)) S Y=^(0) I $P(Y,"^",2)'="I",'$P(Y,"^",3) I $D(^SC(+Y,0)) S X=^(0) D
 . I $D(^SC(+Y,"I")) S ORIA=+^("I"),ORRA=$P(^("I"),"^",2) I $S('ORIA:0,ORIA>DT:0,ORRA'>DT&(ORRA):0,1:1) Q
 . S CT=CT+1 W:(CT#2) !?17 W:'(CT#2) ?47 W $P(X,"^") S C=C+1,C(1)=$P(X,"^") S:C'=1 C=-1
 W !
LOC1 S C=1 W !,"Patient Location: " W:C=1&($L(C(1))) C(1),"//" R X:DTIME G QUIT:'$T,QUIT:C'=1&(X=""),LOC:$L(X)>20!(X'?.ANP),QUIT:X[U
 S DIC("S")="I ""FI""'[$P(^(0),""^"",3),'$P($G(^(""OOS"")),""^"")",DIC=44,DIC(0)=$S(C=1&($L(C(1)))&(X=""):"EMQOZX",1:"EMQZ")
 S:X="" X=C(1) D ^DIC G LOC:X["?" S:Y>0 ORL=+Y_";SC(",ORL(0)=$S($L($P(Y(0),"^",2)):$P(Y(0),"^",2),1:$E($P(Y(0),"^"),1,4))
 K ORIA,ORRA I $D(^SC(+Y,"I")) S ORIA=+^("I"),ORRA=$P(^("I"),U,2)
 I $S('$D(ORIA):0,'ORIA:0,ORIA>DT:0,ORRA'>DT&(ORRA):0,1:1) W $C(7)," This location has been inactivated." K ORL G LOC
 I Y<0 W "  You must select a standard location." G LOC
 K DIC,C,ORIA,ORRA Q
QUIT S OREND=1 K DIC,C Q
READ ;;Hold screen
 I $D(IOST) Q:$E(IOST)'="C"
 W ! I $D(IOSL),$Y<(IOSL-4) G READ
 W !?5,"Press return to continue  " R X:$S($D(DTIME):DTIME,1:300)
 Q
CHKNAM(X,Y) ;Input transform to not allow certain characters
 ;X is the text to be checked, Y are the characters not allowed as sent in by the input transform of the field
 N I,J I '$D(Y) S Y="-;,=^" ;if no special characters sent in, set list to all
 F I=1:1:$L(Y) I X[($E(Y,I)) S J=1
 Q +$G(J)
CHKMNE(X) ;Input transform to not allow use of standard Lmgr Mnemonics
 N Y
 S Y=$$UP^XLFSTR(X) ;check to make sure mnemonic isn't set to lower case of restricted entries.  List Manager is case insensitive
 I Y="ADPL"!(Y="DN")!(Y="Q")!(Y="FS")!(Y="GO")!(Y="?")!(Y="??")!(Y="LS")!(Y="+")!(Y="-")!(Y="PL")!(Y="PS")!(Y="RD")!(Y="SL")!(Y="<")!(Y=">")!(Y="UP")!(Y="PI")!(Y="CWAD")!(Y="TD")!(Y="EX") Q 1
 Q 0
PAD(ORX,ORL) ; Pads string to specified length
 N ORY
 S ORY="",$P(ORY," ",(ORL-$L(ORX))+1)=""
 Q ORY
