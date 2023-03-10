LRLSTWRK ;SLC/CJS/DALISC/DRH - BRIEF ACCESSION LIST ;2/19/91  10:44 ;
 ;;5.2;LAB SERVICE;**153,381,536**;Sep 27, 1994;Build 18
EN ;
 K ^TMP($J),LRTEST,LR,LRTSTS,LRAA
 D ADATE^LRWU3
 G END^LRLSTWRL:LREND
 S LRAD=Y,DIC="^LRO(68,",DIC(0)="AEMOQ",LR(1)=0,LRTEST(0)=0
 D LRAA^LRLSTWRL G END:LREND,LRLSTWRK:LR(1)<1
 I '$D(LRSTAR) S LREND=0 D LRAN^LRWU3 G END:LREND
L2 ;
 W !,"Expand panels" S %=2 D YN^DICN
 S LREX=(%=1)
 G END:%=-1
 I %=0 W !,"If yes, each panel encountered will be expanded." G L2
L2B ;
 W !,"Do you wish to see unverified data"
 S %=2 D YN^DICN
 S LR(2)=(%=1)
 G END:%=-1
 I %=0 W !,"If yes, unverified data may also be displayed." G L2B
L2A ;
 S LREND=0,LRCEN("W")=0
 R !,"Spacing: 1// ",LR(4):DTIME
 Q:'$T!(LR(4)["^")  W:LR(4)["?" !,"Single, Double, Triple spacing, etc."
 G:X["?" L2A S LR(4)=+LR(4) S:LR(4)<1 LR(4)=1
 S %ZIS="QM" D ^%ZIS G END:POP
 I $D(IO("Q")) D  G END
 . S ZTRTN="DQ^LRLSTWRK",ZTSAVE("L*")=""
 . D ^%ZTLOAD K ZTSK,ZTRTN,ZTIO,ZTSAVE,IO("Q")
ENT ;
 U IO D URG^LRX K ^TMP("LR",$J)
 S LRNTPP=((IOM-4)-45)/$S(LR(4)>1:7,1:5)\1,LRNTP=0
 I '$D(LRSTAR) F LRAA=1:1:LR(1) D L11 Q:LREND
 I $D(LRSTAR) F LRAA=1:1:LR(1) D L3 Q:LREND
 I $O(^TMP($J,0))<1 W !!,"NO DATA TO REPORT" G END
 S:LRTEST(0)<LRNTPP LRNTPP=LRTEST(0) G EN^LRLSTWRL
 Q
L11 W "." S LRAN=LRFAN-1 F K=0:0 S LRAN=$O(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN)) Q:LRAN=""!(LRAN>LRLAN)!(LRAN'?.N)  D L12 Q:LREND
 Q
L12 Q:'$D(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,0))#2
 S X=^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,0),LRCEN=$S($D(^(.1)):^(.1),1:0),LRACC=$S($D(^(.2)):^(.2),1:"?"),LRIDT=$S($D(^(3)):^(3),1:"")
 S LRUID=$P($G(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,.3)),"^")
 S T(2)="",T(5)="",T(3)="",LRDFN=+X,LRSDT=$P(X,U,4)\1,LRSN=+$P(X,U,5),LRLLOC=$P(X,U,7)
 S:LRCEN&'LRCEN("W") LRCEN("W")=1
 I LRIDT'="" D
 . I +LRIDT S T(2)=+LRIDT_$S($P(LRIDT,U,2):"r",1:"d")
 . E  S T(2)="No Collect Date/Time"
 . S T(3)=$P(LRIDT,U,4),T(5)=$P(LRIDT,U,3),LRIDT=$P(LRIDT,U,5)
 S II=0 F  S II=$O(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,4,II)) Q:II<1!LREND  S X=^(II,0) D L13
 S LR(3)=$S(LR(4)>1:7,1:5)*LRTEST(0)+67+$S('LRCEN("W"):0,1:8)<(IOM-4) S:LR(3) LR(3)=22+$S('LRCEN("W"):0,1:8)
 Q
L13 S T(1)=$P(X,U,6),LRURG=+$P(X,U,2),LRURG=$S($D(LRURG(LRURG)):LRURG(LRURG),1:""),T(3)=$P(X,U,5),LRTS=+X
 I $G(LRURG)>49,'$P($G(LRPARAM),U,3) Q
 ;LR*5.2*536 - additional logic for Microbiology
 ;A Microbiology test may have a complete date/time in file 68 but the
 ;[area] RPT DATE APPROVED field might be null - which means results are
 ;not displaying in CPRS, and the accession is pending
 I T(3),$P(^LRO(68,LRAA(LRAA),0),U,2)="MI" D MICRO
 S T(4)=$S(T(3):"done",$L(T(1)):"#"_$J(T(1),3),LRURG["STAT":"Spen",1:" pen"),LRSPEC=$S($D(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,5,1,0)):+^(0),1:""),S4=$S($D(^LAB(60,LRTS,0)):$P(^(0),U,5),1:""),T4=T(4)
 D STORE I LREX S LRTEST=LRTS,LRTSTLM=100 D ^LREXPD S JJ=0 F  S JJ=$O(LRORD(JJ)) Q:JJ<1  S LRTS=LRORD(JJ),S4=$P(^LAB(60,LRTS,0),U,5) D STORE
 K JJ,LRORD,^TMP("LR",$J,"T")
 Q
 ;
MICRO ;further evaluation for Microbiology test
 N LRDFNX,LRIDTX,LREXCODE,LRMIAREA
 S LRDFNX=$P(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,0),U)
 S LRIDTX=$P($G(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,3)),U,5)
 S LREXCODE=$P($G(^LAB(60,II,0)),"^",14)
 Q:'LREXCODE
 S LREXCODE=$G(^LAB(62.07,LREXCODE,.1))
 ;Logic below is the same as the logic in result verification
 ;routine LRMIEDZ2 which determines which Microbiology area is
 ;defined for a Microbiology test
 S LRMIAREA=$S(LREXCODE["11.5":1,LREXCODE["23":11,LREXCODE["19":8,LREXCODE["15":5,LREXCODE["34":16,1:"")
 ;If the [area] RPT DATE APPROVED field is null, display this test as "pending"
 I $D(^LR(LRDFNX,"MI",LRIDTX,LRMIAREA)),$P(^(LRMIAREA),U)="" S T(3)=""
 Q
 ;
STORE S:'$D(LRTEST("B",LRTS)) LRTEST(0)=LRTEST(0)+1,LRTEST(LRTEST(0))=$S($D(^LAB(60,LRTS,0)):$P(^(0),U,1),1:"deleted test"),LRTEST("B",LRTS)=LRTEST(0),LRNTP=LRTEST(0)-1\LRNTPP+1
 S LRSS=$P(S4,";",1),S2=$P(S4,";",2),S3=$P(S4,";",3),T(4)=T4
 I $L(S4) D
 . S T(4)=$S(LRURG["STAT":"S...",1:"....")
 . I LRIDT,$D(^LR(LRDFN,LRSS,LRIDT,S2)),$P(^(0),U,3)!LR(2),$L($P(^(S2),U,S3)) S T(4)=$S($P(^(S2),U,S3)'="pending":$P(^(S2),U,S3),1:"pen")
 S ^TMP($J,(LRTEST("B",LRTS)-1\LRNTPP+1),LRAN,LRACC,LRDFN,LRTEST("B",LRTS))=LRLLOC_U_LRURG_U_T(4)_U_LRSPEC_U_LRCEN_U_T(2)_U_LRACC_U_T(5)_U_LRUID
 Q
END G END^LRLSTWRL
 Q
YN R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G YN
L3 S LRAD=$E(LRSTAR,1,3)_"0000"-.00001 F  S LRAD=$O(^LRO(68,LRAA(LRAA),1,LRAD)) Q:LRAD<1!(LRAD>LRWDTL)  D AC Q:LREND
AC S T1=LRSTAR-.00001 F  S T1=$O(^LRO(68,+LRAA(LRAA),1,+LRAD,1,"E",T1)) Q:T1<1!(LAST>1&(T1\1>LAST))  D AC1
 Q
AC1 S LRAN=0 F  S LRAN=$O(^LRO(68,+LRAA(LRAA),1,LRAD,1,"E",T1,LRAN)) Q:LRAN<1  I $D(^LRO(68,+LRAA(LRAA),1,LRAD,1,LRAN,0)) D L12 Q:LREND
 Q
DQ S:$D(ZTQUEUED) ZTREQ="@" U IO K ^TMP($J) G ENT
 Q
