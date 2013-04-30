LRMIUT ;DALOI/STAFF - MICROBIOLOGY UTILITIES ;Sep 29, 2008
 ;;5.2;LAB SERVICE;**254,266,350**;Sep 27, 1994;Build 230
 ;
 ; File 42/10039
 ; Reference to ^%ZTLOAD supported by DBIA #10063
 ; Reference to ^DIC supported by DBIA #10006
 ; Reference to IN5^VADPT supported by DBIA #10061
 ;
STF ;from LRMIEDZ2, LRMISTF1
 ;
 N D
 S D=0
 I $G(LRSB)'="",$D(^LR(LRDFN,"MI",LRIDT,LRSB)) S D=$P(^(LRSB),U),^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)=DUZ_U_D
 I $P(LRPARAM,U,5),D D TSKM
 ;
 ; CareVue supported ward - now tasking routine for CareVue-PWC-10/00
 I D>0 D
 . N LR7DLOC
 . D IN5^VADPT S LR7DLOC=$G(^DIC(42,+$P($G(VAIP(5)),"^"),44))
 . I LR7DLOC>0,$D(^LAB(62.487,"C",LR7DLOC)) D  ; good ward location
 . . N LRH,LRSS,ZTRTN,ZTDTH,ZTSAVE,ZTIO,ZTSK,ZTDESC,ZTQUEUED,ZTREQ
 . . S LRH="",LRSS="MI",ZTRTN="^LA7DLOC",ZTIO="",ZTDTH=$H,ZTSAVE("L*")="",ZTDESC="LAB AUTOMATION CAREVUE SUPPORTED WARDS"
 . . D ^%ZTLOAD
 Q
 ;
 ;
TSKM ; from LRMINEW1
 N LRH,LRWRDVEW,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTSAVE
 S LRH="",LRSS="MI",LRWRDVEW="",ZTRTN="DQ^LRTP",ZTIO="",ZTDTH=$H,ZTSAVE("L*")=""
 D ^%ZTLOAD
 Q
 ;
 ;
LRAA ; from LRMINEW, LRMIPLOG, LRMISEZ, LRMISTF, LRMIVER
 N DIC
 S DIC=68,DIC(0)="AEMOQ",DIC("S")="I $P(^(0),U,2)=""MI""" D ^DIC
 S LRAA=+Y
 Q
 ;
 ;
LRAN ; from LRMINEW1, LRMIPLOG, LRMISTF1, LRMIVER1
 ;
 N DIR,DIRUT,DTOUT,DUOUT,J,K,X,Y
 K LRAN
 ;
 S DIR(0)="LOA^1:99999:0",DIR("A")="Enter #'s: "
 F  D  Q:$D(DIRUT)
 . K Y
 . D ^DIR
 . I $D(DIRUT) Q
 . I $O(Y(""),-1)>50 W !,"Too many numbers selected, choose a smaller group" Q
 . S J=""
 . F  S J=$O(Y(J)) Q:J=""  D
 . . F K=1:1  Q:$P(Y(J),",",K)=""  S LRAN($P(Y(J),",",K))=""
 Q
