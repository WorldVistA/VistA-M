YTS ;SLC/DKG,TGA,HIOFO/FT - START TESTS, QUESTIONNAIRES & REPORTS ;9/29/11 17:01
 ;;5.01;MENTAL HEALTH;**37,54,60,187**;Dec 30, 1994;Build 73
 ;
 ;Reference to ^XUSEC( supported by DBIA #10076
 ;Reference to ^DPT( supported by DBIA #10035
 ;Reference to ^XLFDT APIs supported by DBIA #10103
 ;Reference to %ZISC supported by IA #10089
 ;
 ; 7 June 2011
 ;
 ;ADM ; Called by MENU option YSADMTEST
 ;Q  ; disabled by Patch 60
 ;D ^YSLRP G:YSDFN<1 END S:'$D(^YTD(601.2,"B",YSDFN,YSDFN)) ^(YSDFN)=""
C ;
 I $P(^DPT(YSDFN,0),U,2)']"" W !!,"Patient's SEX required to administer instruments!" Q
 D ENPT^YSUTL,NX G ^YTAR
 ;
RPT ; Called by MENU option YSPRINT
 ; disabled by Patch 60
 Q  D ^YSLRP G:YSDFN<1 END S YSNO=1 D NX G ^YTDP
NX ;
 S %=$H>21549+$H-.1,%Y=%\365.25+141,%=%#365.25\1,YSPTD=%+306#(%Y#4=0+365)#153#61#31+1,YSPTM=%-YSPTD\29+1,Y=%Y_"00"+YSPTM_"00"+YSPTD,YSDT(0)=$$FMTE^XLFDT(Y,"5ZD")
 S YSSX=YSSEX,YSBL="           ",YSHDR=$$MASKSSN(YSSSN)_"  "_YSNM_YSBL_YSBL_YSBL,YSHDR=$E(YSHDR,1,44)_YSSX_" AGE "_YSAGE_" "_YSDT(0),YSHD=DT
 S YSRSLMT=$P($G(^YSA(602,1,0)),U,3)
 I $G(A9)="A" G NX1
 W @IOF,!!?2,YSHDR
NX1 ;
 S YSHDT="" Q:$D(YSXT)
 S T2=$S($D(^XUSEC("YSP",DUZ)):0,1:2)
 S N=0 F  S N=$O(^YTD(601.2,YSDFN,1,N)) Q:'N  I $D(^YTT(601,N)) S N2=0 F  S N2=$O(^YTD(601.2,YSDFN,1,N,1,N2)) Q:'N2  D CK
 S YSNT=0,N1="" F  S N1=$O(A(N1)) Q:N1=""  S N2="" F  S N2=$O(A(N1,N2)) Q:N2=""  S YSNT=YSNT+1,A1(YSNT)=N1_"^"_N2_"^"_A(N1,N2) I N1="MMPI",$D(^YTD(601.2,YSDFN,1,A(N1,N2),1,N2,99)),^(99)="MMPIR" S A1(YSNT,"R")="R"
 Q
CK ;
 S X=^YTT(601,N,0),N4=$P(X,U),X9=$P(X,U,9) G:$P(X,U,10)="Y" CK1
 I X9="T",T2>1,$D(YSNO) Q
 I X9="T",$P(X,U,8)'="V",T2>0,$D(YSNO) Q
CK1 ;
 S A(N4,N2)=N Q
KAR ;
 I $D(YSTXTED),$G(YSLFT) S YSTXTED=1
 K %ZIS,%Y,A,A1,B,B1,C,D0,DA,DIC,DIE,DQ,DR,DTOUT,DUOUT,H,I,I0,J,K,L,M,N,N1,N2,N3,N4,P0,P1,P3,R1,T,T1,T2,X0,X1,X3,X4,X7,X8,X9,XMB,XMDUZ,Y1,Y2,YS4D,YSAGE,YSBAT,YSBEGIN,YSBL,YSCD,YSCH,YSCHN,YSCL,YSCLN,YSCON
 K YSDEMO,YSDTA,YSDTM,YSDOB,YSED,YSEN,YSENT,YSET,YSFHDR,YSFTR,YSHD,YSHDR,YSHDT,YSJT,YSLFT,YSLN,YSNM,YSNO,YSNQ,YSNT
 K YSNX,YSOK,YSORD,YSORDD,YSORDP,YSPTM,YSRESTRT,YSRP,YSSEX,YSQ,YSSSN,YSSX,YSTEST,YSTESTN,YSTF,YSTIN,YSTM,YSTX,YSTY,YSXTP,YSYI,YSYTX,YSZZ,Z,Z1,Z3
END ;
 K %,%DT,A9,X,Y,YSCLERK,YSD,YSDFN,YSPTD,YSRSLMT,YSXT,ZTSK D ^%ZISC
 Q
 ;
HX2F ;
 S YSNT=0,N1=$O(^YTT(601,"B",YSXT,0)) Q:N1'>0  I $D(^YTD(601.2,+YSDFN,1,"B",N1)) S N=$O(^(N1,0)) F N3=0:0 S N3=$O(^YTD(601.2,+YSDFN,1,N,1,N3)) Q:'N3  D HX2FS
 Q
HX2FS ;
 S YSNT=YSNT+1,A1(YSNT)=YSXT_"^"_N3_"^"_N Q
 ;
 ;ENT ; Called by MENU option YSCLERK
 ; disabled by Patch 60
 ;Q  S YSCLERK=$O(^YTT(601,"B","CLERK",0)) G ADM ;CLERK ENTRY
 ;
 ;ENSTAF ; Called by MENU option YSDIRTEST
 ; disabled by Patch 60
 ;Q  S YSM=1 G ADM
INT ;
 D ^YSLRP G:YSDFN<1 END D C:$P(YSDFN(0),U,2)="" G:YSDFN<1 END S YSXTP=1 D NX,HX2F S T1=1,YSXT=$O(^YTT(601,"B",YSXT,0)),T1(0)=$P(^YTT(601,YSXT,"P"),U,4) G ^YTAR:A9="A",^YTDP
 Q
 ;
 ;HX2A ; Called by MENU option YSHXPAST
 ;S YSXT="HX2",A9="A" G INT
 ;
 ;HX2R ; Called by MENU option YSHXPASTR
 ;S YSXT="HX2",A9="R" G INT
 ;
 ;MROSA ; Called by MENU option YSREVSYS
 ;S YSXT="MROS",A9="A" G INT
 ;
 ;MROSR ; Called by MENU option YSREVSYSR
 ;S YSXT="MROS",A9="R" G INT
 ;
 ;PSOCA ; Called by MENU option YSPERSHX
 ;S YSXT="PSOC",A9="A" G INT
 ;
 ;PSOCR ; Called by MENU option YSPERSHXR
 ;S YSXT="PSOC",A9="R" G INT
 ;
BECK ; Called by YTAR -> BECK msg.
 I YSTESTN="BECK" D  ; modification made 11/2/94 mjd
 .  W !!,"You have selected the ""BECK"" instrument, the ""BDI"" "
 .  W !,"instrument will be administered in its place.",!
 .  S YSTESTN="BDI"
 Q
 ;
MMPI ; Called by YTAR -> MMPI msg.
 I YSTESTN="MMPI" D  ; modification made 08/08/99 mjd
 .  W !!,"You have selected the ""MMPI"" instrument, the ""MMPI2"" "
 .  W !,"instrument will be administered in its place.",!
 .  S YSTESTN="MMPI2"
 Q
MASKSSN(YSSSN) ; return only last 4 of SSN
 Q "xxx-xx-"_$E(YSSSN,$L(YSSSN)-3,$L(YSSSN))
