LRWU6 ;SLC/RWF/BA - MODIFY AN EXISTING DATA NAME ; 5/19/87  23:54 ;
 ;;5.2;LAB SERVICE;**316,402**;Sep 27, 1994;Build 1
ACCESS I '$D(^XUSEC("LRLIASON",DUZ)) W $C(7),!,"You do not have access to this option" Q
BEGIN S U="^",DTIME=$S($D(DTIME):DTIME,1:300) W !!,"This option allows modifying an existing data name." D DT^LRX,TEST
END K %,DA,DIC,DIK,I,LRDEC,LRHI,LRLO,LRMAX,LRMIN,LRNAME,LROK,LRPIECE,LRSET,LRTYPE,LROK1,Q1,Q2,Q3,Q4,Q5,X,Y
 Q
TEST S LROK=1,DIC="^DD(63.04,",DIC(0)="AEM",DIC("S")="I Y>1.999999" D ^DIC Q:Y'>0  S DA=+Y,LRNAME=$P(^DD(63.04,DA,0),U)
 D DISPLAY W ! F I=0:0 W !,"Do you wish to modify this data name" S %=2 D YN^DICN Q:%  W "Answer 'Y'es or 'N'o"
 Q:%'=1
 F I=0:0 W !,"Enter data type for ",LRNAME,": (N)umeric, (S)et of Codes, or (F)ree text? " R X:DTIME Q:X[U!(X="")!(X="N")!(X="S")!(X="F")  W !,"Enter 'N', 'S', 'F', or '^'"
 I X=""!(X[U) Q
 ;VMP OIFO BAY PINES;VGF;LR*5.2*316;ADDED H 5 SO USER CAN SEE ERROR MSG
 S Q1=X D @$S(Q1="N":"NUM^LRWU5",Q1="S":"CODES^LRWU5",1:"FREE^LRWU5") I 'LROK W !,"Nothing has been changed." H 5 Q
 S DIK="^DD(63.04,",DA(1)=63.04 D IX1^DIK
 W !!,"'",LRNAME,"' has been modified to:" D DISPLAY
 Q
DISPLAY S LRTYPE=$P(^DD(63.04,DA,0),U,2) D @$S(LRTYPE["N":"NUM",LRTYPE["S":"SET",1:"FREE")
 Q
NUM S Q2=$P(^DD(63.04,DA,0),U,5,99) W !!,"Data Name: ",LRNAME,"    Subfield #: ",DA,"    Type: NUMERIC",!,"Input Transform: ",Q2
 I Q2["S Q9=" S Q1=$P($P(Q2,"S Q9=",2),"""",2),LRLO=$P(Q1,","),LRHI=$P(Q1,",",2),LRDEC=$P(Q1,",",3)
 I Q2'["S Q9=" S LRLO=$S(Q2["X<":+$P(Q2,"X<",2),1:""),LRHI=$S(Q2["X>":+$P(Q2,"X>",2),1:""),LRDEC=$S(Q2["X?.E1"".""":-1+$P(Q2,"X?.E1"".""",2),1:"")
 W !,"Minimum value: ",LRLO,!,"Maximum value: ",LRHI,!,"Maximum # decimal digits: ",LRDEC
 Q
FREE S Q2=$P(^DD(63.04,DA,0),U,5,99) W !!,"Data Name: ",LRNAME,"    Subfield #: ",DA,"    Type: FREE TEXT",!,"Input Transform: ",Q2
 S LRMIN=$S(Q2["$L(X)<":+$P(Q2,"$L(X)<",2),1:""),LRMAX=$S(Q2["$L(X)>":+$P(Q2,"$L(X)>",2),1:"")
 W !,"Minimum length: ",LRMIN,!,"Maximum length: ",LRMAX
 Q
SET S Q2=$P(^DD(63.04,DA,0),U,3) W !!,"Data Name: ",LRNAME,"    Subfield #: ",DA,"    Type: SET OF CODES"
 F LRPIECE=1:1 S LRSET=$P(Q2,";",LRPIECE) Q:LRSET'[":"  W !,$P(LRSET,":"),"  -  ",$P(LRSET,":",2)
 Q
FIX S P=0 F I=0:0 S P=$O(^LR(P)) Q:P<1  S T=0 F I=0:0 S T=$O(^LR(P,"CH",T)) Q:T<1  I $D(^LR(P,"CH",T,O))&('$D(^(N))) S ^(N)=^(O) K ^(O) W "."
 K P,T,O,N,I
 Q
