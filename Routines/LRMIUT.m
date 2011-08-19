LRMIUT ;SLC/CJS/BA/AVAMC/REG - MICROBIOLOGY UTILITIES ; 10/9/87  16:19 ;
 ;;5.2;LAB SERVICE;**254,266**;Sep 27, 1994
 ;
 ; Reference to ^DIC(42 supported by IA #10039
 ; Reference to ^%ZTLOAD supported by DBIA #10063
 ; Reference to ^DIC supported by DBIA #10006
 ; Reference to IN5^VADPT supported by DBIA #10061
 ;
STF ;from LRMIEDZ2, LRMISTF1
 I $D(LRSB),$L(LRSB),$D(^LR(LRDFN,"MI",LRIDT,LRSB)) S D=$P(^(LRSB),U),^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)=DUZ_U_D
 S:'$D(D) D=0 D TSKM:$P(LRPARAM,U,5)&D
 ; CareVue supported ward - now tasking routine for CareVue-PWC-10/00
 I $G(D)>0 D
 . N I,LR7DLOC D IN5^VADPT S LR7DLOC=$G(^DIC(42,+$P($G(VAIP(5)),"^"),44))
 . Q:'LR7DLOC  D:$D(^LAB(62.487,"C",LR7DLOC))   ;good ward location
 .. S LRH="",LRSS="MI",ZTRTN="^LA7DLOC",ZTIO="",ZTDTH=$H
 .. S ZTSAVE("L*")="",ZTDESC="LAB AUTOMATION CAREVUE SUPPORTED WARDS"
 .. D ^%ZTLOAD
 .. K ZTRTN,ZTDTH,ZTSAVE,ZTIO,ZTSK,ZTDESC,ZTQUEUED,ZTREQ
 Q
TSKM ;from LRMINEW1
 S LRH="",LRSS="MI",LRWRDVEW="",ZTRTN="DQ^LRTP",ZTIO="",ZTDTH=$H,ZTSAVE("L*")="" D ^%ZTLOAD
 K LRH,LRWRDVEW,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTSAVE
 Q
LRAA ;from LRMINEW, LRMIPLOG, LRMISEZ, LRMISTF, LRMIVER
 K DIC S DIC=68,DIC(0)="AEMOQ",DIC("S")="I $P(^(0),U,2)=""MI""" D ^DIC
 S LRAA=+Y K DIC
 Q
LRAN ;from LRMINEW1, LRMIPLOG, LRMISTF1, LRMIVER1
 K LRAN F I=0:0 R !,"Enter #'s: ",X:DTIME D:X'="?" NUMS Q:X=""!(X=U)  I X="?" W !,"Enter a string of numbers separated with , . ^ or space,",!,"or a range of numbers, e.g. 50-75.  You may enter more than one line."
 Q
NUMS S D=$S(X[",":",",X[".":".",X[U:U,1:" ") F I=1:1 S LRAN=$P(X,D,I) D:LRAN["-" RANGE Q:LRAN=""  S LRAN(+LRAN)=""
 Q
RANGE F R=$P(LRAN,"-"):1:$P(LRAN,"-",2) S LRAN(R)=""
 K R Q
