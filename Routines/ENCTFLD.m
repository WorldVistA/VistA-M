ENCTFLD ;(WASH ISC)/RGY-Enter/edit File 446.5 ;1-11-90
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;Copy of PRCTFLD ;DH-WASH ISC
 S ENCTF=+$P(^PRCT(446.5,DA(1),0),"^",2),ENCTFLDS="",ENCTEXT=0 S ENCTDEF=$P(^(2,DA,0),"^",4) I 'ENCTF W *7 D NOFIL^ENCTMES2 G Q
 I ENCTDEF]"" W !!,"The following field translates as the" S ENCTE=ENCTDEF,FL=ENCTF F Y=0:0 S Y=+ENCTE,ENCTE=$P(ENCTE,+ENCTE,2,999) Q:Y=0  D DIS S ENCTE=$E(ENCTE,2,999)
A S X="  "_$S($D(^DIC(ENCTF,0,"GL")):$P(@(^("GL")_"0)"),"^"),1:$P(^DD(ENCTF,0),"^"))_" FIELD:"_$S(ENCTDEF]"":" "_ENCTDEF_"//",1:"")_"^^^^^^1" D ^ENCTQUES G:X="^" Q
 S DIC("W")="I $P(^(0),U,2) W $P(""  (multiple)^  (word-processing)"",U,$P(^DD(+$P(^(0),U,2),.01,0),U,2)[""W""+1)"
 S:$L(X,":")-1 ENCTEXT=1,X=$P(X,":",1,$L(X,":")-1) S DIC="^DD("_ENCTF_",",DIC(0)="QEM" D ^DIC G A:X["?",Q:X=""&(Y<0) G:Y<0 A S X=+Y
 I ENCTEXT S ENCTEXT=0,Y=+$P($P(^DD(ENCTF,X,0),"^",2),"P",2) W:'Y *7," ... Field not a pointer !" S:Y ENCTF=Y,ENCTDEF="",ENCTFLDS=ENCTFLDS_X_":" G A
 I $P(^DD(ENCTF,+X,0),"^",2) S ENCTFLDS=ENCTFLDS_X_",",ENCTF=+$P(^DD(ENCTF,+X,0),"^",2),ENCTDEF="" G A
 S $P(^PRCT(446.5,DA(1),2,DA,0),"^",4)=ENCTFLDS_X
Q K FL,ENCTDEF,ENCTFLDS,ENCTF,ENCTEXT,DIC Q
DIS ;
 W !,$S($D(^DD(FL,Y,0)):$P(^(0),"^"),1:"*** UNKNOWN ***")," field of the ",$S($D(^DIC(FL,0)):$P(^(0),"^")_" file",$D(^DD(FL,0)):$P(^(0),"^")_" multiple",1:"*** UNKNOWN ***")
 I $E(ENCTE)]"" W " which extends to the" S FL=$S($D(^DD(FL,Y,0)):$S($E(ENCTE)=":":+$P($P(^(0),"^",2),"P",2),1:+$P(^(0),"^",2)),1:-1)
 Q
