LRMIV1 ;SLC/DLG - LAB ROUTINE DATA VERIFICATION ;2/25/03  22:44
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
PAT S X=LRAN F I=0:0 R:'$D(LRAN) !!,"Accession #: ",X:DTIME Q:X=""!(X[U)  S LRANOK=1,LRCAPOK=1 D LRANX^LRMIU4 D:LRANOK PAT1 D:LRCAPOK&(LRANOK)&($P(LRPARAM,U,14)) LOOK^LRCAPV1 K:LRANOK LRAN I 'LRANOK W !,"Enter the accession number" K LRAN
 Q
PAT1 ;
 K LRPRGSQ S N=0,I=0 F  S I=$O(^LAH(LRLL,1,"C",LRAN,I)) Q:I<1  S N=N+1,LRSQ=I,LRPRGSQ(I)="" W !,?5,I
 G T4:N=1,T3 Q
T1 R !,"What tray: ",X:DTIME Q:X["^"!'$T  I X["?"!(X'?.N) W !,"Enter a number" G T1
 I X'="" S LRTRAY=X G T2
 I $D(^LRO(68.2,"AS",LRLL)) W !,"Can't MANUALLY add to a SEQUENCE instrument data file." Q
 W !,"Enter manually" S %=1 D YN^DICN Q:%<1  G T1:%=2 S LRSQ=-1 G T3
 G T3
T2 R !,"What cup: ",X:DTIME Q:X["^"!'$T  I X["?"!(X'?.N) W !,"Enter a number" G T2
 Q:X=""  S LRTRCP=LRTRAY_";"_X
 K LRPRGSQ S N=0,I=0 F  S I=$O(^LAH(LRLL,1,"B",LRTRCP,I)) Q:I<1  S N=N+1,LRSQ=I,LRPRGSQ(I)="" W !,?5,I
T3 I N=0 W !,"No data for that accession." Q
 I N>1 R !,"Choose sequence number: ",X:DTIME Q:'$T  I X["?"!(X'?.N) W !,"Enter a number" G T3
 I X["^"!(X="") K LRPRGSQ Q
 S:N'=1 LRSQ=X I '$D(^LAH(LRLL,1,LRSQ,0)) W !,"No data there" G T3
T4 Q:LRSQ'>0  K LRPRGSQ(LRSQ)
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRIDT=9999999-^(3),LRCDT=+^(3),LREAL=$P(^(3),U,2),LRI=+$O(^(5,0)),LRSPEC=$S($D(^(LRI,0)):+^(0),1:"")
 I $D(^LR(LRDFN,"MI",LRIDT,0)) S Y(0)=^(0)
 I '$D(^LR(LRDFN,"MI",LRIDT,3,0)) D:'$D(^LR(LRDFN,"MI",LRIDT,0)) BB^LRMIV2 S ^LR(LRDFN,"MI",LRIDT,3,0)="^63.3PA^^"
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3),LRUNDO=0 D PT^LRX W ?25,"  ",PNM,?47," ",SSN
T5 S %=2 I $D(^LR(LRDFN,"MI",LRIDT,1)),+^(1) W !,"The Bact data has been approved, ADDING Data MAY change previous reported",!,"values.  Are you sure you want to do this " D YN^DICN I %=2 W !,"DATA NOT LOADED.",! K % Q
 I %<1 W !,"Enter YES to reload data.  NO to not reload data." K % G T5
 K % I $P(^LR(LRDFN,"MI",LRIDT,0),U,3)!$P(^LR(LRDFN,"MI",LRIDT,0),U,9) S LRUNDO=1 ;W:$P(^(0),U,9) !,"(This is an AMENDED report)",!
 K LRORG S LRORG=0 F I1=0:0 S I1=$O(^LR(LRDFN,"MI",LRIDT,3,I1)) Q:I1'>0  S LRORG(+^(I1,0))=I1,LRORG=I1
 F I1=0:0 S I1=$O(^LAH(LRLL,1,LRSQ,3,I1)) Q:I1'>0  S X=+^(I1,0),I2=$S($D(LRORG(X)):LRORG(X),1:0) D MOVE
 S X=^LAH(LRLL,1,LRSQ,0) K ^LAH(LRLL,1,LRSQ),^LAH(LRLL,1,"B",($P(X,U,1)_";"_$P(X,U,2)),LRSQ),^LAH(LRLL,1,"C",+$P(X,U,5),LRSQ)
 W !!,"Data moved over" S LRHC=1
T51 D BRMK^LRMIPSZ2 S DIE="^LR(LRDFN,""MI"",LRIDT,",DA(1)=LRDFN,DA=LRIDT,DR=5,DR(1,63)=5,DR(2,63.05)="11;11.5;11.6;12;13;",DR(3,63.29)=".01;",DR(3,63.3)=".01;1;",DR(3,63.33)=".01;" D ^DIE
 S LREND=0 D BACT^LRMIV4
T6 R !,"ENTER 'E' TO EDIT OR INITIALS TO VERIFY: ",X:DTIME
 I X="E" D PAT1^LRMIV2 K LRPRGSQ W !,"DATA APPROVED BUT NOT VERIFIED",! D UPDATE^LRPXRM(LRDFN,"MI",LRIDT) G T51
 I $L(X)>1,$O(^VA(200,"C",X,0))=DUZ S $P(^LR(LRDFN,"MI",LRIDT,0),U,3)=DT,^(1)=DT_"^F^"_DUZ W !,"DATA APPROVED AND VERIFIED",! D UPDATE^LRPXRM(LRDFN,"MI",LRIDT) Q
 I X=""!X="^" W "DATA NOT APPROVED OR VERIFIED. " Q
 I $L(X)>1,$O(^VA(200,"C",X,0))'=DUZ W "INITIALS DO NOT MATCH." G T6
 Q
WAIT W !,"Type ""^"" to skip "
WAIT1 R X:10 G LRMIV1:X[U,WAIT1:$O(^LAH(LRLL,1,"C",LRAN,0))<1 G LRMIV1
 Q
MOVE ;Move data into ^LR(LRDFN,"MI",LRIDT,3,
 I I2'>0 S X=^LAH(LRLL,1,LRSQ,3,I1,0),DIC="^LR(LRDFN,""MI"",LRIDT,3,",DIC(0)="AMQ",DA(1)=LRIDT,DA(2)=LRDFN D FILE^DICN S I2=+Y K DIC
 S %X="^LAH(LRLL,1,LRSQ,3,I1,",%Y="^LR(LRDFN,""MI"",LRIDT,3,I2," D %XY^%RCR
