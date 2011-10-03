ORUPREF1 ; slc/dcm - Key allocation ;12/11/91  08:12 [3/13/02 11:42am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**132**;Dec 17, 1997
EN ;
 K ORC W $C(27),"[44;37m"
 S ORC(1)="Black^0",ORC(2)="Red^1",ORC(3)="Green^2",ORC(4)="Yellow^3",ORC(5)="Blue^4",ORC(6)="Magenta^5",ORC(7)="Cyan^6",ORC(8)="White^7"
 S ORC("B","BLACK",1)="",ORC("B","RED",2)="",ORC("B","GREEN",3)="",ORC("B","YELLOW",4)="",ORC("B","BLUE",5)="",ORC("B","MAGENTA",6)="",ORC("B","CYAN",7)="",ORC("B","WHITE",8)=""
 K ORBACK D DISP,SEL S ORF=$S(Y'=-1:Y,1:37)
 S ORBACK=1 D DISP,SEL S ORB=$S(Y'=-1:Y,1:40)
 W !,$C(27),"["_(29+ORF)_";"_(39+ORB)_"m"
END K ORBACK,ORF,ORB,ORC,ORI
 Q
DISP F ORI=1:1:8 W !?10,$C(27),"["_($S($D(ORBACK):40+$P(ORC(ORI),"^",2),1:30+$P(ORC(ORI),"^",2))_"m"),ORI_"  ",$P(ORC(ORI),"^")_$E("       ",1,7-$L($P(ORC(ORI),"^"))) W $C(27),"["_($S($D(ORBACK):"44;37",1:"44;37")_"m")
 Q
SEL S Y=-1 W !!,"Select "_$S($D(ORBACK):"BACKGROUND",1:"FOREGROUND")_" COLOR: " R X:DTIME Q:'$T!(X["^")!(X="")  D UP
 I X="BL" W !,"Please be more specific" G SEL
 I $D(ORC("B",X)) S X=$O(ORC("B",X,0)) G S1
 I $E($O(ORC("B",X)),1,$L(X))=X,X'="BL" S X=$O(ORC("B",X)),X=$O(ORC("B",X,0)) G S1
 I X'?1N!('$D(ORC(X))) W !,"Select a number for one of the choices shown" G SEL
S1 W "   ",$C(27),"["_($S($D(ORBACK):40+$P(ORC(X),"^",2),1:30+$P(ORC(X),"^",2))_"m"),$P(ORC(X),"^") S Y=X
 W $C(27),"["_($S($D(ORBACK):"44;37",1:"44;37")_"m")
 Q
UP ;Upper case
 F %=1:1:$L(X) I $E(X,%)?1L S X=$E(X,1,%-1)_$C($A(X,%)-32)_$E(X,%+1,99)
 Q
KEY ;Edit user security keys
 S OREND=0,ORVER=+($G(^DD(200,0,"VR")))
 F ORKEY="ORES","ORELSE","OREMAS" D K1 Q:OREND  W ! F I=1:1:(IOM-1) W "="
 S OREND=0 K DLAYGO,DA,DR,DIE,DIC,OREND,ORK,ORKEY,ORHEAD,ORVER
 Q
K1 I '$D(^DIC(19.1,"B",ORKEY)) W !,ORKEY_" is not in the Security Key file" Q
 S ORK=$O(^DIC(19.1,"B",ORKEY,0)) I 'ORK!('$D(^DIC(19.1,ORK))) W !,ORKEY_" is not in the Security Key file" Q
 W !!,"KEY: "_ORKEY,! S I=0 F  S I=$O(^DIC(19.1,ORK,1,I)) Q:I<1  W !,^(I,0)
K2 W !!,"Edit Holders" S %=1 D YN^DICN S:%=-1 OREND=1
 I %=0 W !!,"Enter YES to edit holders of this key, NO to quit." G K2
 Q:%'=1
 W ! D K7
 Q
K7 ;edits holders for Kernel V7.0 in file #200
 S DIC=200,DIC(0)="AEQM",DIC("A")="Select HOLDER: "
 F  D ^DIC Q:Y<1  S ORDUZ=Y,ORHAVE=$D(^XUSEC(ORKEY,+ORDUZ)) D K7SET:'ORHAVE,K7DEL:ORHAVE Q:OREND
 K ORDUZ,ORHAVE Q
K7DEL ;deletes ORKEY from person
 N DA,DIC,DIK
 W !?10,"Delete key" S %=1 D YN^DICN I (%<0) S OREND=1 Q
 I %=2 W !?15,"Nothing changed!",! Q
 I %=0 D  G K7DEL
 .W !?7,"This person already holds the "_ORKEY_" key; answer YES"
 .W !?7,"to de-allocate this key from this user."
 .W !!?7,"HOLDER: "_$P(ORDUZ,"^",2)
 S DA=$O(^VA(200,+ORDUZ,51,"B",ORK,0)),DA(1)=+ORDUZ
 I DA S DIK="^VA(200,"_DA(1)_",51," D ^DIK
 W !?15,$S(DA:"DELETED!",1:"Error: ^XUSEC not consistent with keys in User file"),!
 Q
K7SET ;allocates ORKEY to person
 N DIC,DA
 I '$D(^VA(200,+ORDUZ,51,0)) S ^VA(200,+ORDUZ,51,0)="^200.051PA^^"
 S DA(1)=+ORDUZ,DIC="^VA(200,"_DA(1)_",51,",DIC(0)="L",(DINUM,X)=ORK
 D FILE^DICN W !?15,$S(Y>0:"Added.",1:"Error - not added."),!
 Q
