DVBHIQD ;ISC-ALBANY/XAK,PKE-generate a HINQ request  ;6/1/83@08:00
 ;;4.0;HINQ;**21,52,55**;03/25/92
 ;
TM ;D EN^DVBHQTM I $D(DVBSTOP) K DVBSTOP Q
 S DIC="^DPT(",DIC(0)="QEAMZ" D ^DIC Q:Y<0  S DFN=+Y
 D:'$D(DT) DT^DICRW D EN Q
 ;
EN I $D(^DVB(395.5,DFN,0)),"PNEA"[$P(^(0),U,4) W !,$C(7),"A HINQ Request has already been made for this patient",!,"Do you wish to make another request " S %=2 D YN^DICN Q:%'=1
 ;
PASS X ^%ZOSF("EOFF") R !,"Enter HINQ PASSWORD: ",DVBP:DTIME X ^%ZOSF("EON") S:'$T DVBP="^" Q:'$T!("^."[DVBP)  S X=DVBP X ^DD("FUNC",13,1) S DVBP=X I DVBP'?4E W !,*7,"Please enter 4 characters." G PASS
 ;VBA has changed the format of the HINQ password to allow numbers and 
 ;special characters - DVB*4*55,ERC
 ;
BYPASS Q:'$D(DFN)  I '$D(Y(0)),$D(^DPT(DFN,0)) S Y(0)=^(0)
 N I,I2,I3,I4,I5
 ;
 Q:'$D(Y(0))  S DVBNAM=$P(Y(0),"^",1),I=$P(DVBNAM,",",1),I2=$P(DVBNAM,",",2),I3=$P(I2," ",2,99),I2=$P(I2," ",1)
 F J=$L(I):-1:0 Q:$E(I,J)?1A  S I=$E(I,1,J-1)
 F J=1:1 Q:$F(I," ")=0  S K=$F(I," "),I4=$E(I,K,99),I=$E(I,1,K-2)
 I $D(I4),$L(I4)<4 S I5=""
 E  I $D(I4),$L(I4)>3 I "SRJRIII"[$P(I4," ",2) S:"SRJRIII"'[$P(I4," ") I5=$P(I4," ") S I4=$P(I4," ",2)
 I $D(I4),I4=" " K I4
 I $D(I4) F J=$L(I4):-1:0 Q:$E(I4,J)'=" "  S I4=$E(I4,1,J-1)
 I '$D(I5),$D(I4) S I5=I4 K I4
 F J=0:0 Q:$E(I3)'=" "  S I3=$E(I3,2,99)
 I '$D(I4) S I4=$P(I3," ",2),I3=$P(I3," ",1)
 I I2["-" S I2=$P(I2,"-")_$P(I2,"-",2)
 I I3["-" S I3=$P(I3,"-")_$P(I3,"-",2)
 S DVBNAM=I_$S($D(I5):I5,1:"")_","_I2_$S($D(I3):","_I3,1:"")_$S($D(I4):","_I4,1:"") K I,I2,I3,I4,I5
 I DVBNAM["'" S DVBNAM=$P(DVBNAM,"'")_$P(DVBNAM,"'",2)
 I DVBNAM["." S DVBNAM=$P(DVBNAM,".")_$P(DVBNAM,".",2)
 I DVBNAM["(" S DVBNAM=$P(DVBNAM,"(")
 S:DVBNAM]"" DVBNAM="NM"_$E(DVBNAM,1,30)_"/"
 I $D(^DVB(395,1,0)) S DVBSTN=$P(^DVB(395,1,0),U,2) Q:'DVBSTN
 E  W !,*7,"Station number not defined in HINQ Parameters file." Q
ST ;
 S DVBZ="HINQ"_DVBSTN_" "_"E"_$S($P(Y(0),"^",9)]""&($P(Y(0),"^",9)'["P"):"SS"_$E($P(Y(0),"^",9),1,9),1:"")_DVBNAM
 I $P(Y(0),"^",9)]"",$P(Y(0),"^",9)'["P" S DVBZ="HINQ"_DVBSTN_" "_"E"_"SS"_$E($P(Y(0),"^",9),1,9)_DVBNAM G CN
 S DVBZ="HINQ"_DVBSTN_" "_"E"_DVBNAM
 ;send C#, S#
CN S I=$S($D(^DPT(DFN,.31)):$P(^(.31),"^",3),1:"") G SN:I="",SN:I["P" F J=1:1 Q:$L(I)'<8  S I=0_I
 S:$L(I)=8 I=" "_I S DVBZ=DVBZ_"CN"_I
 G VDI
SN S I=$S($D(^DPT(DFN,.32)):$P(^(.32),"^",8),1:"") G VDI:I="",VDI:I["P",VDI:I'?1N.N,VDI:$L(I)>9 F J=1:1 Q:$L(I)'<8  S I=0_I
 S:$L(I)=8 I=" "_I S DVBZ=DVBZ_"SN"_I
 ;
VDI S DVBZ=DVBZ_DVBP,DVBZ=$E(DVBZ,1,9)_$E(DFN_"              ",1,14)_$E(DVBZ,10,999)
 ;
 K DVBNAM,DVBSTN QUIT
 ;
BYPASS1 I '$D(^DVB(395.5,DFN,"HQ")) D BYPASS QUIT
 E  S DVBZ=^DVB(395.5,DFN,"HQ")_DVBP
 QUIT
