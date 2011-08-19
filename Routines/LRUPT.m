LRUPT ;AVAMC/REG/WTY - PATIENT TESTS ORDERED BY DATE ;9/25/00
 ;;5.2;LAB SERVICE;**1,153,201,248**;Sep 27, 1994
 ;
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to ^DIC supported by IA #10006
 ;
 S:$D(LRSS)#2 Z(0)=LRSS S:$D(LRAA)#2 Z(1)=LRAA S:$D(LRAA(1)) Z(2)=LRAA(1)
 S LRDPAF=1,IOP="HOME" D ^%ZIS
ASK I $D(Z(0)),Z(0)="BB" S DIC("B")="BLOOD BANK"
 K LRSS W ! S DIC=68,DIC(0)="AEMOQZ" D ^DIC K DIC I Y<1 K LRSS,LRAA S:$D(Z(0)) LRSS=Z(0) S:$D(Z(1)) LRAA=Z(1) S:$D(Z(2)) LRAA(1)=Z(2) K Z G END
 D REST K Z(0) G ASK
REST S LRSS=$P(Y(0),U,2),Z(3)=$P(Y(0),U,3),LRAA=+Y,LRAA(1)=$P(Y,U,2),Z(8)=$P(Y(0),U,11)
GETP K T W ! S A("A")="Y" K DIC D ^LRDPA Q:LRDFN=-1  Q:'$D(^LR(LRDFN,0))
 W !,"Is this the patient " S %=1 D YN^LRU Q:%<1  G:%=2 GETP D SHOW G GETP
SHOW W @IOF,!,LRAA(1),?20,LRP," ID: ",SSN I "AUCYEMSP"'[LRSS W "  TESTS ORDERED"
 I LRSS="AU" D AUTO Q
 I '$D(^LR(LRDFN,LRSS)) W $C(7),!!,"No ",LRAA(1),$S("SPCYEM"'[LRSS:" Tests",1:""),!! Q
 D HDR S N=0 F A=1:1 S N=$O(^LR(LRDFN,LRSS,N)) Q:'N  I $D(^LR(LRDFN,LRSS,N,0)) S Z(7)=^(0) D S Q:A("A")'?1"Y".E
 I A=1 W !?5,"*** No ",LRAA(1)," entries ***",!!
 Q
S S Y=+Z(7),Z(4)=$P(Z(7),U,7),(Z(6),Z(12))=$P(Z(7),U,6)
 S Z(5)=$P(Z(7),U,5),Z(11)=$S(LRSS="MI":$P(Z(7),U,11),1:"")
 S:Z(5) Z(5)=$S($D(^LAB(61,Z(5),0)):$P(^(0),U),1:"UNKNOWN")
 I Z(3)["M" S Y=$E(+Z(7),1,3)_$P($P(Z(7),"^",6)," ",2)
 I "SPCYEM"[LRSS&(+Z(12)=Z(12)) D
 .S Z(12)=LRSS_$E($P(Z(7),"^",10),2,3)_" "_Z(12)
FIX I Z(6)'="" Q:Z(8)'=$P(Z(6)," ")  S Z(6)=$P(Z(6)," ",3)
 S Z(9)=$S("D"[Z(3)&("BBCH"[LRSS):$E(Y,1,3)_$P($P(Z(7),"^",6)," ",2),Z(3)="Y":$E(Y,1,3)_"0000","M"[Z(3):$E(Y,1,5)_"00","Q"[Z(3):$E(Y,1,3)_"0000"+(($E(Y,4,5)-1)\3*300+100),1:$P(Y,"."))
 S LRDATE=$TR($$Y2K^LRX(Y,"5M"),"@"," ")
 S (QFLG,FND)=0
 D:$Y>21 MORE Q:A("A")'?1"Y".E!('Z(9))!(Z(6)="")
 I "SPCYEM"[LRSS D  G A
 .S Z(5)="" S:Z(4) Z(5)=$P($G(^VA(200,Z(4),0)),"^")
 I LRSS="BB",'$D(^LRO(68,LRAA,1,Z(9),1,Z(6),0)) D  Q
 .W !!,LRDATE,?18,Z(12),?32,$E(Z(5),1,12)
 I LRSS'="BB" D  I QFLG D DATA Q
 .I '$D(^LRO(68,LRAA,1,Z(9),1,Z(6),0)) D  Q:QFLG
 ..; Accession was not found in file 68.
 ..; Determine if accession is found in next year.
 ..D YRCHK  Q:QFLG
 ..S FND=1 ;Accession was found in next year
 .I LRDFN'=+^LRO(68,LRAA,1,Z(9),1,Z(6),0)!(+^(3)'=+Z(7)) D
 ..; The LRDFN does not match so let's do further checking
 ..I FND S QFLG=1 Q   ;Year increment was already done so quit
 ..;Check to see if it's in the next year
 ..D YRCHK  Q:QFLG
 ..I LRDFN'=+^LRO(68,LRAA,1,Z(9),1,Z(6),0)!(+^(3)'=+Z(7)) S QFLG=1
 I LRSS="BB" Q:LRDFN'=+^LRO(68,LRAA,1,Z(9),1,Z(6),0)!(+^(3)'=+Z(7))
 S:LRSS="CH" Z(11)=""
 I Z(11)>0 D
 .S Z(11)=$P(^LAB(62,+Z(11),0),U),Z(11)=$S(Z(11)'=Z(5):Z(11),1:"")
A D DATA
 W " ",$E(Z(11),1,10) D @($S("CYEMSP"[LRSS:"AP",1:"DAY"))
 Q
YRCHK ;Increment year and look for accession
 S X1=$E(Z(9),1,3),X2=$E(Z(9),4,7)
 S X1=X1+1,Z(15)=X1_X2
 I '$D(^LRO(68,LRAA,1,Z(15),1,Z(6),0)) S QFLG=1 Q
 S Z(9)=Z(15)  ;It was found in the next year.
 Q
DATA W !!,LRDATE,?18,Z(12),?37,$E(Z(5),1,12)
 W:QFLG ?58,"Data Unavailable"
 Q
DAY Q:'Z(9)!(Z(6)="")  S (B,X)=0 F  S X=$O(^LRO(68,LRAA,1,Z(9),1,Z(6),4,X)) Q:'X  S T(X)=+^(X,0) D:$Y>20 MORE Q:A("A")'?1"Y".E  D LIST
 Q
LIST S X(0)=$G(^LAB(60,T(X),0)) Q:$P(X(0),U,4)="WK"!($P(X(0),U)="")  D  Q
 .S B=B+1 I B>2 W !
 .W ?56,$J(B,3),")",?60,$E($P(X(0),U),1,18)
 .I B=1 W ! S LRUID=$P($G(^LRO(68,LRAA,1,Z(9),1,Z(6),.3)),"^") I LRUID'="" W ?13,"UID: "_LRUID
 .D REF
MORE Q:A("A")?1"N".E!(A("A")="")  R !,"MORE TESTS ?  NO// ",A("A"):DTIME Q:A("A")=""!(A("A")[U)!(A("A")?1"N".E)  I A("A")'?1"Y".E W $C(7),!,"Answer  YES  or NO" G MORE
 W @IOF,LRP,"  SSN: ",SSN D HDR W LRDATE,?18,Z(12) Q
HDR W !,"Spec Date/time",?18,"Acc #" I "AUCYEMSP"'[LRSS W ?32,"Site/specimen" I LRSS'="CY" W ?59,"Tests"
 W:"CYEMSP"[LRSS ?37,"PHYSICIAN",?51,"SPECIMEN(S)" W ! Q
AUTO I '$D(^LR(LRDFN,"AU")) W $C(7),!,"No autopsy !!!" Q
 S Z(7)=^LR(LRDFN,"AU"),Y=+Z(7),Z(6)=$P(Z(7),U,6) D D^LRU
 W !,"Autopsy date/time",?19,"Autopsy #"
 W !,$S(Y[1700:"???",1:Y),?23,$S($D(Z(6)):Z(6),1:"??")
 Q
AP S C=0 F B=0:1 S C=$O(^LR(LRDFN,LRSS,N,.1,C)) Q:'C  D
 .W:B !
 .W ?51,$E($P(^(C,0),U),1,27)
 Q
REF ; if referred test, get referral status
 N LREVNT,LRMAN,LRX
 S LRMAN="",LREVNT=$$STATUS^LREVENT(LRUID,T(X),LRMAN)
 I LREVNT'="" D
 .S LRMAN=$P(LREVNT,"^",3) I LRMAN'="" W:B>1 ! W ?35,"Shipping Manifest: "_LRMAN
 .S LRX="Referral Status: "_$P(LREVNT,"^")_" ("_$P(LREVNT,"^",2)_")" W !,?(79-$L(LRX)),LRX I B=1 W !
 Q
END K LRDPAF,LRP,LRLLOC,SSN,%,A,B,DFN,DIC,DOB,I,K,Z,LRADM,LRADX,LRAWRD
 K LRDFN,LRDPF,LREXP,LRFNAM,LRMD,LREND,LRPF,LRPFN,LRS,P,PNM,POP,LRSVC
 K LRTEST,LRUID,N,SEX,X,X1,X2,Y,QFLG,FND
 Q
