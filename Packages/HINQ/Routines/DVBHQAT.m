DVBHQAT ;ISC-ALbany/JLU HINQ packing routine  [ 09/21/94  1:23 PM ]
 ;;4.0;HINQ;**22,32,36,49**;03/25/92 
 ;
KIL K J,LF,D,K,N,T,Y0,Z1,LP,L2,L3,DVBLEN,DVBIO,DVBNUM,F1,F2,X1,G,I,T1,DVBTIME,Z,L,DVBDEV,DVBDSCH,DVBECHO,DVBEND,DVBLOG,DVBPRGM,DVBTIM,DVBTMX,DVBXM,DVBZ,DVBABORT,DVBVDI,DVBTSK,DVBCN,DVBP,DVBSN,DFN,DIC,X,Y,R,DVBDXSC,DVBIXMZ,DVBUSER,DVBCS
 K DVBI,DVBFUE,DVBFUF,DVBBAS,DVBBIR,DVBINC,DVBP,DVBV1
 K DVBID,DVBIDCU,DVBPU,DVBPW,DVBS,DVBV2,LP2,LX,LY,NXL,SPN
 K DVBTRY,DVBRTC,DVBNRT
 Q
 ;
HP W !!," Input from the 'P'atient File only requires you to select a Patient Name.",!," 'D'irect input will prompt for Social Security Number, Claim Number or Service Number.",!," You may enter Patients not in the Patient file."
 W !," Direct input will not enter Patients in the Patient File."
 Q
 ;
E S DVB12=1
 F A=0:0 S A=$O(X(A)) Q:'A  D S
 K X
 Q:'$D(XY(1))
 F A=0:0 S A=$O(XY(A)) Q:'A  S X(A)=XY(A) K XY(A)
 ;
EX K DVB12,A,XY,B,L
 Q
 ;
S I $L(X(A))=245 S XY(DVB12)=X(A),DVB12=DVB12+1 K X(A) Q
 I $L(X(A))<245 D S1 Q
 I $L(X(A))>245 D S2 Q
 Q
 ;
S1 S XY(DVB12)=X(A) K X(A) F B=0:0 S B=$O(X(B)) Q:'B  S L=245-$L(XY(DVB12)),XY(DVB12)=XY(DVB12)_$E(X(B),1,L),X(B)=$E(X(B),L+1,999) K:'$L(X(B)) X(B) I $L(XY(DVB12))=245 S DVB12=DVB12+1 Q
 Q
 ;
S2 F B=0:0 S XY(DVB12)=$E(X(A),1,245),X(A)=$E(X(A),246,999),DVB12=DVB12+1 I $L(X(A))<245 S A=0 Q
 Q
 ;
CNLKUP S CN=$S($D(^DPT(DFN,.31)):$P(^(.31),"^",3),1:"")
 I 'CN Q
 I CN["P" S CN="" Q
 S CN=$E(" 00000000",1,9-$L(CN))_CN
 S DVBZ=$E(DVBZ,1,$L(DVBZ)-8)_"CN"_CN_$E(DVBZ,$L(DVBZ)-7,99)
 S CN=$F(DVBZ,"/CN",24) Q
 ;
STUFF Q:'DFN
 S DVBNOWRT="",DVBZSAV=DVBZ,DVBZ=$E(DVBZ,1,$L(DVBZ)-4)
 D DIV^DVBHQZ4,EN1^DVBHQUT
 S DVBZ=DVBZSAV K DVBZSAV Q
