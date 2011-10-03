DVBHQDE ;ISC-ALBANY/PKE-generate HINQ direct ; 7/19/05 9:43pm
 ;;4.0;HINQ;**52,49,55**;03/25/92 
 G EN
RD R Y:DTIME IF  I Y'="^",Y'["?" S:Y'="" X1(N)=Y S:Y="@" X1(N)="" S:Y="SS"&(N>2) X1(N)=X1(2) Q
 S N=0 Q
 ;
EN ;D EN^DVBHQTM I $D(DVBSTOP) K DVBSTOP Q
 F Z=1:1:4 S X1(Z)=""
 S Y=-1 K Y(0)
NAM ;DVB*4*49 - name queries no longer accepted
 S X1(1)=""
 ;
 ;with DVB*4*49 only one number can be entered - first choice CN, 
 ;then SSN, then SN
TXT W !,"Enter one of the following numbers - Social Security Number, Claim Number",!,"or Service Number."
 W !
 D SS
 I Y?9N G EDIT
 I Y="^" Q
 D CNUM
 I Y?8.9N G EDIT
 I Y="^" Q
 D SNUM
 G EDIT
 Q
SS W !,"Social Security: ",X1(2)_$S($L(X1(2)):"// ",1:"") S N=2 D RD G SS:Y="@" I Y["?" S H=3 D HELP G SS
 Q:'N
 I X1(2)'="",X1(2)'?9N S X1(2)="" W $C(7) S H=4 D HELP S H=3 D HELP G SS G SS
 Q
 ;
CNUM W !,"Claim Number: ",X1(3)_$S($L(X1(3)):"// ",1:"") S N=3 D RD G CNUM:Y="@" I Y["?" S H=10 D HELP G CNUM
 Q:'N
 I X1(3)'="",(X1(3)'?1N.N!($L(X1(3))<1)!($L(X1(3))>9)) S X1(3)="" S H=6 D HELP S H=7 D HELP G CNUM
 Q
 ;
SNUM W !,"Service Number : ",X1(4)_$S($L(X1(4)):"// ",1:"") S N=4 D RD G SNUM:Y="@" S T=$L(X1(4)) I Y["?" S H=7 D HELP G SNUM
 Q:'N
 I X1(4)'="",(X1(4)'?1N.N!($L(X1(4))<4)!($L(X1(4))>9)) S X1(4)="" W $C(7) S H=8 D HELP S H=7 D HELP G SNUM
 Q
 ;
EDIT W !,?4," OK  " S %=1 D YN^DICN
 Q:%Y="^"  G:"Yy"[%Y CHK
 G:"Nn"[$E(%Y_1) NAM
 I %Y["?" W ?17 S H=9 D HELP G EDIT
 Q
 ;
CHK I X1(1)="",X1(2)="",X1(3)="",X1(4)="" Q
 S $P(Y(0),U,1)=X1(1)
 S $P(Y(0),U,9)=X1(2)
 S DVBCN=X1(3)
 S DVBSN=X1(4)
 ;
PASS X ^%ZOSF("EOFF") R !,"Enter HINQ PASSWORD: ",DVBP:DTIME X ^%ZOSF("EON") S:'$T DVBP="^" Q:'$T!("^."[DVBP)  S X=DVBP X ^DD("FUNC",13,1) S DVBP=X I DVBP'?4E W !,*7,"Please enter 4 characters." G PASS
 ;VBA has changed the format of the HINQ password to allow numbers and 
 ;special characters - DVB*4*55,ERC
 ;
BYPASS S DFN="XXXZ"
 N I,I1,I2,I3,I4,I5
 I '$D(Y(0)) S Y=-1 Q
 S DVBNAM=$P(Y(0),"^",1),I=$P(DVBNAM,","),I2=$P(DVBNAM,",",2)
 F J=$L(I):-1:0 Q:$E(I,J)?1A  S I=$E(I,1,J-1)
 F J=1:1 Q:$F(I," ")=0  S K=$F(I," "),I4=$E(I,K,99),I=$E(I,1,K-2)
 I $D(I4),$L(I4)<4 S I5=""
 E  I $D(I4),$L(I4)>3 I "SRJRIII"[$P(I4," ",2) S:"SRJRIII"'[$P(I4," ") I5=$P(I4," ") S I4=$P(I4," ",2)
 I $D(I4),I4=" " K I4
 I $D(I4) F J=$L(I4):-1:0 Q:$E(I4,J)'=" "  S I4=$E(I4,1,J-1)
 I '$D(I5),$D(I4) S I5=I4 K I4
 F J=0:0 Q:$E(I2)'=" "  S I2=$E(I2,2,99)
 F J=$L(I2):-1:0 Q:$E(I2,J)'=" "  S I2=$E(I2,1,J-1)
 I I2[" " S I3=$P(I2," ",2,99),I2=$P(I2," ") F J=0:0 Q:$E(I3)'=" "  S I3=$E(I3,2,99)
 I '$D(I4),$D(I3) S I4=$P(I3," ",2),I3=$P(I3," ",1)
 S DVBNAM=I_$S($D(I5):I5,1:"")_","_I2_$S($D(I3):","_I3,1:"")_$S($D(I4):","_I4,1:"")
 I DVBNAM["'" S DVBNAM=$P(DVBNAM,"'")_$P(DVBNAM,"'",2)
 I DVBNAM["." S DVBNAM=$P(DVBNAM,".")_$P(DVBNAM,".",2)
 I DVBNAM["(" S DVBNAM=$P(DVBNAM,"(")
 I DVBNAM?1"," S DVBNAM=""
 S:DVBNAM]"" DVBNAM="NM"_$E(DVBNAM,1,30)_"/"
 I $D(^DVB(395,1,0)) S DVBSTN=$P(^DVB(395,1,0),U,2) Q:'DVBSTN
 E  W !,*7,"Station number not defined in HINQ Parameters file." Q
ST ;;;CHANGED P TO E FOR TESTING NEW STRING
 S DVBZ="HINQ"_DVBSTN_" "_"E"_$S($P(Y(0),"^",9)]""&($P(Y(0),"^",9)'["P"):"SS"_$P(Y(0),"^",9),1:"")_DVBNAM
CN S I=DVBCN G SN:I="" F J=1:1 Q:$L(I)'<8  S I=0_I
 S:$L(I)=8 I=" "_I S DVBZ=DVBZ_"CN"_I
SN S I=DVBSN G VDI:I="" F J=1:1 Q:$L(I)'<8  S I=0_I
 S:$L(I)=8 I=" "_I S DVBZ=DVBZ_"SN"_I
 ;
VDI S DVBZ=DVBZ_DVBNUM_DVBP,DVBZ=$E(DVBZ,1,9)_"              "_$E(DVBZ,10,999)
 ;
 S Y=0 K %Y,I,I1,I2,I3,I4,I5,DVBNAM,DVBSTN,DVBTGT,Y(0) QUIT
 ;
HELP W "  ",$P($T(HELP+H),";;",2) K H Q
 ;;Enter last name,first name  up to 30 characters
 ;;At the last prompt ' OK ? YES// ' you may enter No to edit
 ;;Enter 9 digits only
 ;;Bad SSN
 ;;Enter 1-9 digits or SS for Social Security
 ;;Bad Claim #
 ;;Enter 4-9 digits or SS for Social Security
 ;;Bad Service #
 ;;Enter No to edit data   Return to continue
 ;;Identifying Number must be 1 - 9 digits
