DIS ;SFISC/GFT-GATHER SEARCH CRITERIA ;23JUN2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,97,144**
 ;
 K ^UTILITY($J),DC,DIS,%ZIS,O,N,R D ^DICRW
 G Q:'$D(DIC)!$D(DTOUT)
EN ;
 S:DIC DIC=$G(^DIC(DIC,0,"GL")) Q:DIC=""
 K DI,DX,DY,I,J,DL,DC,DA,DTOUT,^UTILITY($J) G Q:'$D(@(DIC_"0)"))
 S (R,DI,I(0))=DIC,(DL,DC)=1,DY=999,N=0,Q="""",DV=""
R ;
 I +R=R S (J(N),DK)=R,R=""
 E  S @("(J(N),DK)=+$P("_R_"0),U,2)"),R=$P(^(0),U)
F ;
 G UP:DC>58
 W ! K X,DIC,DISPOINT,DE D W
 S DIC(0)="EZ",C=",",DIC="^DD("_DK_",",DIC("W")="S %=$P(^(0),U,2) W:% $S($P(^DD(+%,.01,0),U,2)[""W"":""   (word-processing)"",1:""   (multiple)"")",DIC("S")="I $P(^(0),U,2)'[""m"""_$S($D(DICS):" "_DICS,1:""),DU=""
 W "SEARCH FOR "_R_" "_$P(^DD(DK,0),U)_": "
 R X:DTIME S:'$T DTOUT=1 G Q:X=U!'$T,TEM^DIS2:X?1"[".E D  I Y>0 K DISPOINT S DE=Y(0),O(DC)=$P(DE,U),DU=+Y,Z=$P(DE,U,3),E=$P(DE,U,2) G G
 .N DISVX S DISVX=X D ^DIC S:Y=-1 X=DISVX Q
HARD G UP:X="",F:X?."?",Q:X=U!($D(DTOUT)),COMP^DIS2
 Q
G ;^DOPT("DIS",1,0)=NULL
 ;^DOPT("DIS",2,0)=CONTAINS
 ;^DOPT("DIS",3,0)=MATCHES
 ;^DOPT("DIS",4,0)=LESS THAN
 ;^DOPT("DIS",5,0)=EQUALS
 ;^DOPT("DIS",6,0)=GREATER THAN
 K X,DIC S DIC="^DOPT(""DIS"",",DIC(0)="QEZ" I E["B" S X="" G OK
 I E S N(DL)=N,N=N+1,DV(DL)=DV,DL(DL)=DK,DK=+E,J(N)=DK,X=$P($P(DE,U,4),";"),I(N)=$S(+X=X:X,1:""""_X_""""),Y(0)=^DD(DK,.01,0),DL=DL+1 G WP:$P(Y(0),U,2)["W" S DV=DV_+Y_"," G F
 S X=$P(E,"p",2) I X,$D(^DIC(+X,0,"GL")) S DISPOINT=$S(Y:+Y,1:-DC)_U_U_^("GL") ;Y will be FIELD lookup, unless it's COMPUTED EXPRESSION from ^DIS2
 I E["P" S DISPOINT=+Y_U_Y(0) S X=+$P(E,"P",2) F  Q:'X  D
 .S DA=$P($G(^DD(X,.01,0)),U,2) I DA["D" S E="D"_E,X="" Q
 .S X=+$P(DA,"P",2)
 I $D(DISPOINT),Y>0 S X="(#"_+Y_")",DA="DIS("""_$C(DC+64)_DL_""",",DICOMP=N S:$D(O(DC))[0 O(DC)=X D EN^DICOMP G X:'$D(X) S DA(DC)=X,DU=-DC F %=0:0 S %=$O(X(%)) Q:'%  S @(DA_%_")")=X(%)
C K X D W R "CONDITION: ",X:DTIME S:'$T DTOUT=1 G Q:X[U!'$T
 S DN=$S("'-"[$E(X):"'",1:""),X=$E(X,DN]""+1,99)
 S:E["S" DIC("S")="I Y<3!(Y=5)" D ^DIC K DIC("S")
 G:Y<0 Q:X[U,B:X="",DISC^DIQQQ:X["?",C
 S O=$P("NOT ",U,DN]"")_$P(Y,U,2)
 I +Y=1 S X=DN_"?."" """,O(DC)=O(DC)_" "_O G OK
 S DQ=Y
VALUE D W W O I E["D",Y-3 R " DATE: ",X:DTIME S:'$T DTOUT=1 G F:X=U,Q:'$T S %DT="TE" D ^%DT S X=Y_U_X G X:Y<0 X ^DD("DD") S Y=X_U_Y G GOT
 ;POINTERS
PT I $D(DISPOINT),+DQ=5 K DIC,DIS($C(DC+64)_DL) S DIC=U_$P(DISPOINT,U,4),DIC(0)="EMQ",DU=+DISPOINT W " "_$P(@(DIC_"0)"),U)_": " R X:DTIME S:'$T DTOUT=1 G F:U[X,Q:'$T D ^DIC G GOT:Y>0,PT
 R ": ",Y:DTIME E  S DTOUT=1 G Q
 G X:Y="" I Y[U,$P($G(DE),U,4)'[";E",'$P($G(DE),U,2),E'["C" G F ;We can look for "^" in WP or $E-stored actual data
 I +DQ=3 S X="I X?"_Y D ^DIM G GOT:$D(X) S Y="?" ;Is it a good PATTERN-MATCH?
 I DQ=4!(DQ=6),+Y'=Y G X ;> or < have to be numeric
 I Y?."?" D DIS^DIQQQ G VALUE
 W:Y[""""&($L(Y)>1) "    (Your answer includes quotes)"
SET I E["S" D  K DIS("XFORM",DC) G GOT:$D(X) K DIS(U,DC) D DIS^DIQQQ G VALUE
 .N D S X=1 I +DQ=5!(Y["""") D  K:D="" X Q
 ..N DIR,DDER S X=Y,DIR(0)="S^"_Z,DIR("V")=1 D ^DIR I $G(DDER) S D="" Q
 ..F X=1:1 S D=$P(Z,";",X) Q:D=""  I Y=$P(D,":") S Y=""""_$$CONVQQ^DILIBF($P(D,":"))_"""^"_$P(D,":",2) Q
 .N N,%,C W !?7 S Y=""""_Y_"""",N="DE"_DN_$E(" [?<=>",DQ)_Y
 .F X=1:1 S D=$P(Z,";",X),DE=$P(D,":",2) Q:D=""  S DIS(U,DC,$P(D,":"))=DE I @N S:'$D(%) %="[ Will match" W % S C=$G(C)+1,%="'"_DE_"'" W:C>1 "," W " " W:$X+$L(%)>73 !?7
 .I '$D(%) K X Q
 .W:C>1 "and " W %_" ]"
 I Y?.E2A.E S DIS("XFORM",DC)="$$UP^DILIBF(;)",Y=$$UP^DILIBF(Y)
 D
 .N P,YY,C S C="""",YY=C_$$CONVQQ^DILIBF($P(Y,U)) F P=2:1:$L(Y,U)  S YY="("_YY_"""_$C(94)_"""_$$CONVQQ^DILIBF($P(Y,U,P)),C=C_")"
 .S Y=YY_C
GOT S X=DN_$E(" [?<=>",DQ)_$P(Y,U) I E["D" D
 .I $P(Y,U)'[".",$E(Y,6,7) S %=$P("^^^^ any time during^ the entire day",U,DQ) I %]"" S DIS("XFORM",DC)="$P(;,""."")",O=O_%
 .S Y=$P(Y,U,3)_U_$P(Y,U,2)
 I $G(DIS("XFORM",DC))="$$UP^DILIBF(;)" S O=O_" (case-insensitive)"
 S O(DC)=O(DC)_" "_O_" "_Y
OK S DC(DC)=DV_DU_U_X,%=DL-1_U_(N#100)
 I DL>1,O(DC)'[R S O(DC)=R_" "_O(DC)
 S:DU["W" %=DL-2_U_(N#100-1) S DX(DC)=%,DC=DC+1 S:DC=27 DC=33 ;go from "Z" to "a"
B G F:(DU'["W"&(DC<59))
UP I DC>1 G ^DIS0:DL<$S('$D(DIARF0):2,1:2) S DL=DL-1,DV=DV(DL),DK=DL(DL),N=N(DL),R=$S($D(R(DL)):R(DL),1:R) K R(DL) S %=N F  S %=$O(I(%)) S:%="" %=-1 G F:%<0 K I(%),J(%)
Q G Q^DIS2:'$D(DIARU),^DIS2
 ;
WP S DIC("S")="I Y<3",DU=+Y_"W" G C
 ;
X ;
 W $C(7),"??",!! K O(DC) G B
 ;
W W !?DL*2,"-"_$C(DC+64)_"- " Q
 ;
 ;
 ;
 ;
 ;
 ;
 ;
ENS ; ENTRY POINT FOR RE-DOING THE SORT USING AN EXISTING SORT TEMPLATE
 G EN^DIS3
