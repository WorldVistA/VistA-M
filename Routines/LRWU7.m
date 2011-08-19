LRWU7 ;SLC/BA - ADD A NEW ANTIBIOTIC TO FILE 63 ; 5/15/87  23:31 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
ACCESS I '$D(^XUSEC("LRLIASON",DUZ)) W !,"You do not have proper access for using this option." Q
BEGIN S U="^",DTIME=$S($D(DTIME):DTIME,1:300),LRSITE=+$P($G(^XMB(1,1,"XUS")),U,17),LROK=1 D:'LRSITE SITE G:'LROK END D DT^LRX,NAME G:'LROK END D NUMBER,SET
END K %,I,DA,DIC,DIK,LRINC,LRNAME,LRNAME1,LRNAME2,LRNUM,LRNUM1,LRNUM2,LROK,LRSITE,X
 Q
SITE W !,"Your site number is not defined, indicating that fileman was not ",!,"installed correctly.  Contact your site manager!"
 S LROK=0 Q
NAME W !! F I=0:0 R !,"Enter the name of the new antibiotic you wish to create: ",X:DTIME D CHECK Q:'LROK
 I X[U!('$L(X)) S LROK=0 Q
 S LROK=1,LRNAME=X,LRNAME1=LRNAME_" INTERP",LRNAME2=LRNAME_" SCREEN"
 Q
CHECK I X[U!'$L(X) S LROK=0 Q
 I $L(X)<2!($L(X)>20)!(X["?") W !,"  Name must be 2-20 characters." Q
 S DIC="^DD(63.3,",DIC(0)="XM" D ^DIC I Y>0 W $C(7),!,"  ",X," already exists!" S LROK=1,X="" Q
 S LROK=0 Q
NUMBER S LRNUM="2.00"_LRSITE,LRINC=$S($L(LRSITE)=3:.00000001,1:.000000001),LRNUM=LRNUM+LRINC I $D(^DD(63.3,"GL",LRNUM)) F I=0:0 S LRNUM=LRNUM+LRINC Q:'$D(^DD(63.3,"GL",LRNUM))
 S LRNUM1=+$S($L(LRSITE)=3:LRNUM+.000000001,1:LRNUM+.0000000001),LRNUM2=+$S($L(LRSITE)=3:LRNUM+.000000002,1:LRNUM+.0000000002),LRNUM=+LRNUM
 Q
SET F I=0:0 W !,"Are you sure you wish to create ",LRNAME,!," (DRUG NODE will be ",LRNUM,")" S %=1 D YN^DICN Q:%  W "answer 'Y'es or 'N'o."
 I %'=1 S LROK=0 Q
 S ^DD(63.3,LRNUM,0)=LRNAME_"^FX^^"_LRNUM_";1^D ^LRMISR",^(3)="",^(4)="D EN^LRMISR",^("DT")=DT
 S ^DD(63.3,LRNUM1,0)=LRNAME1_"^FX^^"_LRNUM_";2^D INT^LRMISR",^(3)="",^(4)="D HINT^LRMISR",^("DT")=DT
 S ^DD(63.3,LRNUM2,0)=LRNAME2_"^S^A:ALWAYS DISPLAY;N:NEVER DISPLAY;R:RESTRICT DISPLAY;^"_LRNUM_";3^Q",^("DT")=DT
 S $P(^DD(63.3,0),U,4)=$P(^DD(63.3,0),U,4)+3,DIK="^DD(63.3,",DA(1)=63.3 F DA=LRNUM,LRNUM1,LRNUM2 D IX1^DIK
 W !!,LRNAME," has now been created.",!,"You must now add a new antibiotic in the ANTIMICROBIAL SUSCEPTIBILITY file",!,"and use ",LRNAME," as the entry for the INTERNAL NAME field."
 Q
