DGRUGTG ;ALB/MLI - TEST RUG-II GROUPER ; 29 DEC 87 9:00
 ;;5.3;Registration;**173**;Aug 13, 1993
 ;
ASK W !,$P(^DD(45.9,DGNO,0),U) S %=0 D YN^DICN S %=$S(%=2:1,%=1:2,1:%) Q:%<0  I '% D QR G ASK
 I DGNO=58,'DGED,%=1 S DGNO=62 F DGI=59:1:62 S $P(DGINFO,"^",DGI)=1
 Q
YN D ASK Q:%<0  D:%Y["?" QR G:%Y["?" YN S $P(DGINFO,"^",DGNO)=% Q
EDIT S DGED=1 F DGNO=0:0 S DGNO=$O(A(DGNO)) G:(DGNO<1) CH D:(DGNO<21)!((DGNO>23)&(DGNO<36))!(DGNO=58) YN G QUIT:%<0 D:'((DGNO<21)!((DGNO>23)&(DGNO<36))!(DGNO=58)) CHK G:X=U QUIT
 G CH
MAIN S (DGFLAG,DGED)=0,U="^" W !,"The information you are about to enter will be used to determine a TEST ",!,"RUG-II Grouper.  The values you enter will not be saved and will not ",!," be able to be retrieved for later use."
 W !,"Do you wish to continue" S %=1 D YN^DICN G MAIN:%Y["?",QUIT:%'=1
DT W !!!,"Enter fiscal year (4 digits): " R X:DTIME G FYH:X["?",QUIT:X=U!('$T)!(X=""),DT:X'?4N S %DT="E",%DT(0)=2870000 D ^%DT G:Y'>0 DT
MR K I S DGFY=Y,DGYR=$E(Y,1,3) I '$D(^DG(45.91,1,"FY",DGFY)) W !,"WWU values unavailable.  Want most recent ones" S %=0 D YN^DICN G FYH2:%Y["?",DT:%=2!'%,QUIT:%'>0 F I=DGFY:-10000:2860000 S DGFY=I I $D(^DG(45.91,1,"FY",DGFY)) Q
 I $D(I),I<2870000 W !,"THERE ARE NO WWU VALUES IN YOUR RUG-II FILE" G QUIT
 S DGPAF="" F DGNO=10:1:20 D ASK G:%<0 QUIT S $P(DGINFO,"^",DGNO)=%
DB F DGNO=21,23 D CHK G QUIT:X=U S $P(DGINFO,"^",DGNO)=X
 F DGNO=24:1:28,32:1:35 D ASK G:%<0 QUIT S $P(DGINFO,"^",DGNO)=%
 F DGNO=40:1:57 D CHK G:X=U QUIT
CV S DGNO=58 D ASK G:%<0 QUIT S $P(DGINFO,"^",DGNO)=%
 I DGNO<59 F DGNO=59:1:62 D CHK G:X=U QUIT
CH F DGI=1:1:6 D @(DGI_"^"_"DGRUG1") G:$D(DGFLAG) EDIT
 S E=$P(DGINFO,"^",40),E=$S(E<3:1,E=3:2,E=4:3,1:4),T=$P(DGINFO,"^",42),T=$S(T<3:1,T=3:2,1:3),J=$P(DGINFO,"^",43),J=$S(J<3:1,J<5:2,1:3),DGSUM=E+T+J
 G CVD^DGRUG1
QUIT K %,%DT,%Y,A,D,DGED,DGFL,DGFLAG,DGHM,DGI,DGINFO,DGFY,DGMAX,DGMIN,DGNO,DGPAF,DGRUG,DGSUM,DGYR,E,G,I,J,N,T,X,Y Q
QR D RESYN W !,"    ANSWER 'Y'ES OR 'N'O" Q
RES W ! F I=2:1:(N+1) W ! W:(N=6) I-2,">" W:(N=3) I-1,">" W $P($P($P(^DD(45.9,DGNO,0),U,3),":",I),";",1)
 W !
RESYN F I=0:0 S I=$O(^DD(45.9,DGNO,21,I)) Q:I'>0  W !,^(I,0)
 Q
CHK W !,$P(^DD(45.9,DGNO,0),U),": " R X:DTIME S:'$T X=U Q:X=U  G:X="" CHK
 K N,DGMIN,DGMAX,G S DGFL=0,G=$S(DGNO=21:717,DGNO=23:605,DGNO<47!(DGNO=59)!(DGNO=60):515,DGNO=47:313,DGNO=61:414,DGNO=62:919,DGNO[".5":1,'(DGNO#2):414,1:107)
 S:G=1 DGMIN=0,DGMAX=5059,N=1 I G>1 S N=$E(G,1),DGMIN=$E(G,2),DGMAX=$E(G,3)
 I G=1 D HM^DGRUGC1 I '$D(X) G CHK
 I (X'["?")&(X'="")&((X<DGMIN)!(X>DGMAX)!(X'?.N)) W !,*7,"    INVALID RESPONSE--TRY AGAIN" G CHK
 I X["?",(G>1),(G'=107) D RES G CHK
 I X["?",(G=1) D RESYN G CHK
 I X["?",(G=107) W !,^DD(45.9,DGNO,3) G CHK
 S $P(DGINFO,"^",$S(DGNO'[".":DGNO,1:DGNO+9.5+(57-$P(DGNO,".")/2)))=X
 I N=4,(DGNO<61) Q:DGED  S DGNO=DGNO+1 S:X=1 $P(DGINFO,"^",DGNO)=0,$P(DGINFO,"^",DGNO+10+(57-DGNO/2))=0 I X'=1 G CHK
 I G=107 Q:DGED  S DGNO=DGNO+.5 G CHK
 S:'DGED&(DGNO[".") DGNO=DGNO-.5 Q
FYH W !,"Enter fiscal year of RUG-II WWU values you want to use.  Must not precede 1987." G DT
FYH2 W !,"Fiscal year RUG-II WWU values not available for the year requested",!,"Enter 'Y'es to accept most recent values in file or 'N'o",!,"to choose another year" G MR
