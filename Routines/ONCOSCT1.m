ONCOSCT1 ;Hines OIFO/GWB - CROSS TAB SETUP ;7/27/92
 ;;2.11;ONCOLOGY;**5,22,34,43**;Mar 07, 1995
GC ;GET CUTS
 ;
ABORT S ROWDD=""
 Q
 ;
SETUP ;get options
 ;in:  ^DD,^DIPT,FNUM,ONCOS,TEMPL
 ;out: COLCUTS,COLDD,HEADER,PCT,ROWCUTS,ROWDD
 ;do:  ^ONCOSINP,^DIC
 N CUTS,DIC,FDD,FLD
S1 S ROWDD="",DIC="^DD("_FNUM_",",DIC("S")="I +$P(^(0),U,2)=0 "
 F FLD="COLUMN","ROW" D GETFLD Q:FDD(F)=""
 Q:FDD(F)=""  S COLDD=FDD("C"),ROWDD=FDD("R")
 S COLCUTS=CUTS("C"),ROWCUTS=CUTS("R")
 I $D(ONCOS("P")) S PCT=ONCOS("P") G W
 W ! S DIR("A")="       Print Percents",DIR("B")="No",DIR(0)="Y",DIR("?")="Enter 'Y' to include total percents" D ^DIR Q:Y="^"!(Y="")  S PCT=Y
W U IO W !!,$S(COLDD="":"One",1:"Two"),"-Way Table with ",$P(ROWDD,U,1)_" Values"
 I COLDD]"" W " for Rows ",!,"and ",$P(COLDD,U,1)," Values for Columns"
 W !,"For ",$S(TEMPL:"Entries in Search Template "_HEADER,1:"ALL Cases")
 Q:$D(ONCOS("Y"))  S Y="OK? Yes// ",Z="" D GETYES^ONCOSINP
 E  G ABORT:Y=-1,S1
 Q
 ;
GETFLD ;get field & cuts
 ;N F
 S F=$E(FLD,1),CUTS(F)="",FDD(F)=""
 I $D(ONCOS(F)) S X=$P(ONCOS(F),U,1),DIC(0)="EOQ",FDD(F)=X Q:FDD(F)=""
 E  S DIC(0)="AEQ",DIC("A")="Select "_FLD_" field: "
 D ^DIC Q:Y="^"!(Y=-1)
 S X=^DD(FNUM,+Y,0),FDD(F)=X,X=$P(X,U,2) Q:X["N"!(X["J")!(X["C")=0
 I $D(ONCOS(F)) S X=$P(ONCOS(F),U,2) S:X]"" CUTS(F)=X_":99999999" Q
CUTS W !!?10,"You may enter cutpoints for this variable: "_$P(FDD(F),U)
 W !?10,"E.g., enter '4:7:12:30' to count the values"
 W !?10,"in 5 categories (LE 4),(GT4-LE7),...,(GT30)"
C R !!?5,"Define CUTPOINTS: ",X:DTIME G ABORT:'$T!(X="^") Q:X=""  I X["?" D HLP G CUTS
CK ;Check cutpoint format
 F I=1:1:$L(X) S Y=$E(X,I) I Y'?1N.N&(Y'=":") W ?50,*7,"ERROR = '"_Y_"' ~ Try Again!" G CUTS
 S NC=$L(X,":") F I=1:1:NC S X(I)=$P(X,":",I) I I>2 Q:X(I)'>X(I-1)
 ; I I=NC F I=1:1:NC I I>2,X(I)'<X(I-1) Q
 ; W !!?10,"Cutpoints not properly defined",!?10,"Use increasing or decreasing numbers",!,?10,"Must have ':' as delimiter only!!" G CUTS
 S CUTS(F)=X_":99999999" Q
HLP ;Help on cutpoints
 W !!?10,"Cutpoints are used to partition data into groups"
 W !?10,"where there is no computed field like 'AGE GROUP'."
 W !?10,"Use a series of increasing or decreasing numbers"
 W !?10,"separated by colons (':') to create the RANGE.",!!
 Q
