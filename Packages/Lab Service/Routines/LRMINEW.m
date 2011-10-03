LRMINEW ;SLC/CJS/BA - NEW DATA TO BE REVIEWED/VERIFIED ;4/24/89  14:36 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;from option LRMINEWD
ACCESS D ^LRPARAM I $S('$D(LRLABKY):1,'$P(LRLABKY,U):1,1:0) W !,"You must have the 'LRVERIFY' key to verify results.",! Q
BEGIN S LREND=0,LRDAT=LRDT0,LRFREE=0,LRDXZ=DUZ,LRVT="VT" D VER
END K %,%DT,A,AGE,D,DFN,DOB,DTOUT,DUOUT,I,LRAA,LRACC,LRAD,LRAN,LRCDT,LRDAT,LRDFN,LRDPF,LRDXZ,LREND,LRFREE,LRIDT,LRLLOC,LRLLT,LRLOCA,LRLTR,LRMIQUE,LRODT,LROK,LRONESPC,LRONETST,LRPG,LRSB,LRWRD,LRWRDVEW,LRVT,PNM,POP,SEX,SSN,X,Y
 Q
VER I $P(LRLABKY,U,2) D SUPER Q:LREND
 K DIC D LRAA^LRMIUT Q:LRAA<1
 S %DT="AE",%DT("A")="Micro Accession Year: ("_$E(DT,2,3)_")//" D ^%DT K %DT("A") Q:X[U  S:X="" Y=$E(DT,1,3) S LRAD=$E(Y,1,3)_"0000"
 F I=0:0 D AREA Q:LREND  D EXCLUDE Q:%=1
 I LREND Q
 S LRAN=0 F I=0:0 S LRAN=$O(LRAN(LRAN)) Q:LRAN=""  K ^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)
 F I=0:0 W !!,"Would you like to review the data as the (W)ards will see it, as",!,"the (L)ab will see it, or (N)ot review the data?  W// " R X:DTIME S:'$T X=U S:'$L(X) X="W" Q:X[U!("WLN"[X&($L(X)=1))  D INFO
 I X'[U S:X="W" LRWRDVEW="" D @$S(X="N":"^LRMINEW1",1:"^LRMINEW2")
 Q
AREA F I=0:0 R !!,"Area to review:",!?20,"1  Bacteriology",!?20,"2  Mycology",!?20,"3  Parasitology",!?20,"4  Mycobacteriology",!?20,"5  Virology",!,"Choice: ",X:DTIME Q:X>0&(X<6)&(X?1N)!(X=""!(X=U))  W !,"Enter a number 1,2,3,4 or 5"
 I X=""!(X=U) S LREND=1 Q
 S LRSB=$S(X=1:1,X=2:8,X=3:5,X=4:11,X=5:16,1:"")
 Q
EXCLUDE W !!,"Here's what's been edited:",!
 S LRAN=0 F I=0:0 S LRAN=$O(^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)) Q:LRAN<1  S A=^(LRAN) D:+A=LRDXZ!(LRDXZ=0) SHOW
 W !!,"Indicate those you wish to permanently exclude (unless re-edited) from review."
 D CHECK^LRMINEW1 I $O(LRAN(0))'>0 S %=1 Q
 W !,"Excluding the following:" S LRAN=0 F I=0:0 S LRAN=$O(LRAN(LRAN)) Q:LRAN=""  W !,LRAN
 F I=0:0 W !!,"Are you sure you want to exclude" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 Q
SHOW Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  Q:'$D(^(3))  S LRDFN=+^(0),LRIDT=9999999-^(3)
 I '$D(^LR(LRDFN,"MI",LRIDT,LRSB)) K ^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN) Q
 S Y=+^LR(LRDFN,"MI",LRIDT,LRSB) D D^LRU S LRMAPDT=Y
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX W !,LRAN,?6,PNM,?36,SSN W:$P(A,U,2) ?49,"Approved","  ",LRMAPDT K LRMAPDT
 Q
SUPER F I=0:0 W !,"Verify all work edited for a given area" S %=2 D YN^DICN Q:%  W !,"You may verify one person's work or all person's work."
 I %=-1 S LREND=1 Q
 I %=1 S LRDXZ=0 Q
 S DIC(0)="AEQM",DIC("A")="Whose work?: ",DIC="^VA(200," D ^DIC S:X[U LREND=1 Q:Y<1  S LRDXZ=+Y
 Q
INFO W !!,"Answer 'W', 'L', 'N' or '^' to exit.",!,"Ward copies may have certain data suppressed from review.",!,"If you've already reviewed the data, answer 'N' to approve the data."
 Q
