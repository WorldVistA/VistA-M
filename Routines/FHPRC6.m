FHPRC6 ; HISC/REL/NCA - Edit Meal Production Diets ;2/26/96  10:04
 ;;5.5;DIETETICS;;Jan 28, 2005
R0 S DIC="^FH(116.1,",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:U[X!$D(DTOUT),R0:Y<1 S D0=+Y
R1 S DIC="^FH(116.1,D0,""RE"",",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:X[U!$D(DTOUT),R0:X="",R1:Y<1 S D1=+Y
 Q:$O(^FH(116.1,D0,"RE",D1,"R",0))<1
R11 S DIC="^FH(116.1,D0,""RE"",D1,""R"",",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:X[U!$D(DTOUT),R1:X="",R11:Y<1 S CAT=+Y
 S OLD=$P(^FH(116.1,D0,"RE",D1,"R",CAT,0),"^",2)
 I $E(OLD,$L(OLD))=" " S OLD=$E(OLD,1,$L(OLD)-1)
 S NEW=OLD D IN
R2 D LI R !!,"Action: ",Y:DTIME G:'$T KIL I "^"[Y S:OLD'=NEW $P(^FH(116.1,D0,"RE",D1,"R",CAT,0),"^",2)=NEW G R1
 I Y["?" D IN G R2
 S X=Y D TR^FH S Y=X
 S Z=$E(Y,1),FLG=0 G AD:Z="+",DE:Z="-",MO
 Q
AD S FHX1=$E(Y,2,999) F LL=1:1 Q:$P(FHX1," ",LL,99)=""  S FHX2=$P(FHX1," ",LL),PD=$P(FHX2,";",1) D A1 Q:'$D(X)
 W:'FLG "  ok"
 G R2
A1 D CK I X6<0 S FLG=1 Q
 I X6 W *7,!?5,"  ",FHX2," already exists! Use Modify option." S FLG=1 Q
 S X=NEW_" "_FHX2 S:$E(X,1)=" " X=$E(X,2,999) D EN2^FHPRC1 I $D(X) S NEW=X
 Q
DE S FHX1=$E(Y,2,999) F LL=1:1 Q:$P(FHX1," ",LL,99)=""  S FHX2=$P(FHX1," ",LL),PD=$P(FHX2,";",1) D D1
 W:'FLG "  ok"
 G R2
D1 D CK I X6<0 S FLG=1 Q
 I 'X6 W *7,!?5,"  ",FHX2," does not exist!" S FLG=1 Q
 S X=$P(NEW," ",1,X6-1)_" "_$P(NEW," ",X6+1,999) S:$E(X,1)=" " X=$E(X,2,999) S:$E(X,$L(X))=" " X=$E(X,1,$L(X)-1)
 D EN2^FHPRC1 I $D(X) S NEW=X
 Q
MO S PD=$E(Y,1,2) D CK G:X6<0 R2
 I 'X6 W *7,"  ",PD," does not exist!" G R2
 S X=NEW,$P(X," ",X6)=Y I $L(X)>200 W *7,!!?5,"String Length >200." K X G R2
 D EN2^FHPRC1 I $D(X) S NEW=X W "  ok"
 G R2
CK S:PD'?1U1UN PD="---" I '$D(^FH(116.2,"C",PD)) W *7,!?5,"  ",PD," Not a valid Production Diet code!" S X6=-1 Q
 S X6=0 F K=1:1 S Z=$P(NEW," ",K) Q:Z=""  I $E(Z,1,2)=PD S X6=K Q
 Q
E1 W *7,"  Illegal Production Diet code" G R2
LI W !!,"Production Diets: " S X=NEW
L1 I $L(X)<61 W ?19,X Q
 F N1=61:-1:1 Q:$E(X,N1)=" "
 W ?19,$E(X,1,N1-1) S X=$E(X,N1+1,999) Q:X=""  W ! G L1
IN W !!?5,"Enter + to add (example: +RG;C50)"
 W !?5,"Enter -Production Diet to delete (example: -RG)"
 W !?5,"Enter new code to modify (example: LS;C30)" Q
KIL G KILL^XUSCLEAN
