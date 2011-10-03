LRLSTWRL ;SLC/CJS/DALISC/DRH - BRIEF ACCESSION LIST PART 2 ;2/6/91  07:41 ;
 ;;5.2;LAB SERVICE;**153,201**;Sep 27, 1994
EN ;from LRLSTWRK
CONTROL ;
 S LROK=1,LREND=0
 W:$E(IOST,1,2)="C-" @IOF
 D INIT
 D LOOP1
 D END
 Q
INIT ;
 S CNT=0
 S LR("TIME")="$$FMTE^XLFDT($$NOW^XLFDT,""1"")"
 Q
LOOP1 ;
 F LRPGC=1:1:LRNTP S LRPTO=LRPGC-1*LRNTPP D L1
 Q
L1 ;
 Q:$G(LREND)
 U IO
 I $G(CNT)=1 D LRSTOP Q:$G(LREND)=1  W @IOF,!
 W:LRAD'<1 @LR("TIME")
 D LOOP2
 Q
LOOP2 ;
 F LRAA=1:1:LR(1) D  Q:$G(LREND)=1
 . W !,?20,"SHORT ",$P(^LRO(68,LRAA(LRAA),0),U,1)," ACCESSION"
 I $D(LRSTAR),$D(LAST),LRSTAR>1,LAST>1 D
 . W !,"FROM DATE: "
 . S Y=LRSTAR\1
 . D DD^LRX
 . W Y,!,"TO DATE: "
 . S Y=LAST\1 D DD^LRX W Y,!
 D HEAD1
 D LOOP3
 Q
HEAD1 ;
 D ^LRWLHEAD
 W !
 D L27
 Q
LOOP3 ;
 S LRAN=0
 F  S LRAN=$O(^TMP($J,LRPGC,LRAN)) Q:LRAN<1!($G(LREND)=1)  D L24
 Q
L24 ;
 S LRACC=""
 F  S LRACC=$O(^TMP($J,LRPGC,LRAN,LRACC)) Q:LRACC=""  D
 . S LRDFN=0 Q:$G(LREND)=1  D
 .. F  S LRDFN=$O(^TMP($J,LRPGC,LRAN,LRACC,LRDFN)) Q:LRDFN<1  D
 ... Q:$G(LREND)=1  D L26
 Q
L26 ;
 Q:$G(LREND)=1
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX
 S LRTEST=$O(^TMP($J,LRPGC,LRAN,LRACC,LRDFN,0)),X=^(LRTEST)
 S LRLLOC=$P(X,U,1)
 S LRURG=$P(X,U,2)
 S LRCEN=$P(X,U,5)
 S T(2)=$P(X,U,6)
 S T(5)=$P(X,U,8)
 S LRUID=$P(X,U,9)
 S LRSPEC=$S($D(^LAB(61,+$P(X,U,4),0)):$E($P(^(0),U,1),1,5),1:"")
 I +T(2) S Y=+T(2) D DD^LRX S LRCDT=Y_$E(T(2),$L(T(2)))
 I '+T(2) S LRCDT=T(2)
 ;Q:$G(LREND)=1
 F I=1:1:LR(4) W !
 Q:$G(LREND)=1
 W $P(LRACC," ",1)," ",$P(LRACC," ",3),?11," ",$E(LRLLOC,1,4),?18," ",$E(SSN,$L(SSN)-3,$L(SSN)),?23," ",$E(PNM,1,15)
 I 'LR(3) W ! W:LRCEN ?11,"ORD:",LRCEN W ?20," ",LRCDT
 E  W ?40 W:LRCEN "ORD:",LRCEN W " ",LRCDT
 W !,?11,"UID: ",LRUID
 D LOOP4
 Q
LOOP4 ;
 F LRTEST=LRPTO+1:1:LRPTO+LRNTPP D
 . ;I '$D(LRTEST(LRTEST)) S LREND=1 Q
 . W ?($S(LR(4)>1:7,1:5)*(LRTEST-LRPTO)+35+LR(3))
 . W $S('$D(^TMP($J,LRPGC,LRAN,LRACC,LRDFN,LRTEST)):"|",1:"") I $D(^(LRTEST)) W $P(^(LRTEST),U,3)
 W ?($S(LR(4)>1:7,1:5)*(LRNTPP+1)+34+LR(3))
 W " ",LRSPEC
 I $Y>(IOSL-7) D LRSTOP Q:$G(LREND)=1  W @IOF W:LRAD'<1 @LR("TIME") D L27
 I LRDPF=2,'T(5) W "  NC"
 Q
L27 ;
 Q:$G(LREND)
 F I=1:1:10 D L30
 W !,"ACC #"
 Q
LRSTOP ;
 S CNT=1
 Q:$E(IOST,1,2)="P-"
 K DIR
 S DIR(0)="E"
 D ^DIR
 I $D(DUOUT)!($D(DIRUT)) S LREND=1 Q
 Q
L15 D ^%ZISC U IO(0) W:$D(^LRO(68,LRAA(LRAA),1,LRAD,1,LRAN,.2)) !,"Accession:  ",^(.2),"  added too many tests to the display."
 W !,"Need more columns on the display than are available, Either use a wider",!,"device or try fewer accessions (fewer tests may be encountered, resulting in",!,"a narrower display)."
 Q
L30 W !,$P("Key:^done = mult test comp.^ pen = mult test incomp.^spen = stat mult incomp.^number = result^.... = incomplete^S... = STAT incomp.^ | = not ordered",U,I)
 F J=1:1:LRNTPP I $D(LRTEST(LRPTO+J)) S C1=$E(LRTEST(LRPTO+J),I) W ?($S(LR(4)>1:7,1:5)*J+25+I+LR(3)),$S(C1'="":C1,1:".")
 Q
END ;from LRLSTWRK
 W ! W:$E(IOST,1,2)="P-" @IOF
 K LR,LRCDT,LRURG,LREXPD,LRTS,LRSTAR,LRY,LRSS,LRAD,LRAN,LRAA,LRTEST,LRNTP,LRNTPP,LRPGM,LRSDT,LRSN,LRSPEC,T,ZTSK,LRACC,LRCEN,LRENT,LRFAN,LRIDT,LRLLOC,LRPGC,LRPTO,LRWRD,LREX,^TMP("LR",$J)
 K %,%H,B,C1,LAST,LREDT,LRLINE,LRWDTL,POP,T1,LRORD,LRTSTS,LRUID
 K AGE,A,DFN,DIC,DOB,I,J,K,LRLAN,LRDFN,LRDPF,PNM,S2,S3,S4,SEX,SSN,T5,X,Y,Z
 K LRXX,LROK,T4,OK
 D ^%ZISC Q
 ;NTPP=number tests/page, LRPTO=page test offset, LRPGC=page cnt, LRNTP=number of test pages
 ;LR(1)=# of acc areas, 2=see unverified, 3=wide, 4=spacing
LRAA ;from LRLSTWRK
 K LRSTAR,LRAA,W2 F J=0:0 D ^DIC Q:Y<1  D CHKDAT Q:Y<1  S DIC("A")="ANOTHER ACCESSION AREA: " I '$D(W2(+Y)) S LR(1)=LR(1)+1,LRAA(LR(1))=+Y,W2(+Y)="",LRSS(LR(1))=$P(LR,U,2) D:$P(LR,U,3)="Y"&'$D(LRSTAR) STAR^LRWU3
 K W2,DIC,J,T2 S LREND=(X[U)!(LR(1)=0) Q
CHKDAT ;from LRLIST
 S LR=^LRO(68,+Y,0),T=$P(LR,U,3) I T="Y",$E(LRAD,4,7)'="0000" W !,"Accession area selected has a YEARLY Accession date, you didn't choose that." S (LR(1),Y)=-1 Q
 I T="D",$E(LRAD,4,5)="00"!($E(LRAD,6,7)="00") W !,"Accession area selected has a DAILY Accession date, you didn't choose that." S (LR(1),Y)=-1 Q
 I T="M",$E(LRAD,4,5)="00"!($E(LRAD,6,7)'="00") W !,"Accession area selected has a MONTHLY Accession date, you didn't choose that." S (LR(1),Y)=-1 Q
 Q
