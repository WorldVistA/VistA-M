LRAPTT ;DALOI/STAFF - TURNAROUND TIME PATH ;09/09/11  11:39
 ;;5.2;LAB SERVICE;**1,72,201,397,350**;Sep 27, 1994;Build 230
 ;
EN ; Entry point for TAT report setup
 ;
 D ^LRAP Q:'$D(Y)
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LRPROC,LRSPEC
 I LRSS="AU" D  Q:'$G(LR("AU"))
 . S DIR(0)="S^1:Turnaround time for PAD;2:Turnaround time for FAD"
 . S DIR("?",1)="Enter 1 for Provisional Anatomic Diagnoses (PAD)"
 . S DIR("?")="Enter 2 for Final Anatomic Diagnoses (FAD)"
 . D ^DIR
 . I $D(DIRUT) D END Q
 . S LR("AU")=+Y
 ;
 D B^LRU
 G:Y<0 END
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99,LRL=0
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="Identify cases exceeding turnaround time limit",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) D END Q
 I Y=1 D  Q:'$G(LRB)
 . K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . S DIR(0)="N^1:120:0",DIR("A")="Enter limit in days"
 . D ^DIR
 . I $D(DIRUT) D END Q
 . S LRB=+Y,LRL=LRB+1
 ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S^0:Include All;1:Include Selected;2:Exclude Selected",DIR("A")="Include/Exclude Specimens",DIR("B")=0
 D ^DIR
 I $D(DIRUT) D END Q
 S LRSPEC=+Y
 I LRSPEC>0 D
 . N DIC
 . S DIC="^LAB(61,",DIC(0)="AEQM",DIC("A")="Select SPECIMEN: ",LRSPEC=+Y
 . F  D ^DIC Q:Y<1  S LRSPEC(+Y)=""
 ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^0:Include All;1:Include Selected;2:Exclude Selected",DIR("A")="Include/Exclude Procedures",DIR("B")=0
 D ^DIR
 I $D(DIRUT) D END Q
 S LRPROC=+Y
 I LRPROC>0 D
 . N DIC
 . S DIC="^LAB(61.5,",DIC(0)="AEQM",DIC("A")="Select PROCEDURE: ",LRPROC=+Y
 . F  D ^DIC Q:Y<1  S LRPROC(+Y)=""
 ;
 I LRPROC>0 D  I $D(DIRUT) D END Q
 . K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="Y",DIR("A")="Count multiple procedure occurrence/case",DIR("B")="NO"
 . S DIR("?",1)="Answer 'yes' if you want to count each occurrence of the same procedure/case."
 . S DIR("?",2)="Answer 'no' if you want a procedure counted only once per case."
 . S DIR("?",3)="This applies when a given accession (case) has the same procedure"
 . S DIR("?")="specified for multiple topographies."
 . D ^DIR
 . I $D(DIRUT) Q
 . S $P(LRPROC,"^",2)=+Y
 ;
 S ZTRTN="QUE^LRAPTT" D BEG^LRUTL
 G:POP!($D(ZTSK)) END
 ;
 ;
QUE ;
 N LRPROCI,LRSPECI
 U IO K ^TMP($J)
 S LRD="",(LRE,LRF,LRA,LRM)=0
 D XR^LRU,L^LRU,S^LRU,^LRAPTT1
 S LR("F")=1 F A=0:0 S A=$O(^DIC("AC","LR",A)) Q:'A  S (LRE(A),LRF(A),LRM(A),LRA(A))=0
 F  S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D I
 F LRH=0:0 S LRH=$O(^TMP($J,LRH)) Q:'LRH!(LR("Q"))  D N
 G:LR("Q") OUT S B=0 F A=0:0 S A=$O(LRM(A)) Q:'A  I A'=2,LRM(A) S B=1 Q
 ;
 I B D:$Y>(IOSL-8) ^LRAPTT1 Q:LR("Q")  W !!,"If '#', '*' or '?' is after Acc # then demographic data is in file indicated:",!?7,"# = Referral file  * = Research file  ? = Other file listed below"
 ;
 I LRSS="AU" W !?6,"F= FULL AUTOPSY  H= HEAD ONLY T= TRUNK ONLY  O=OTHER LIMITATION"
 D:$Y>(IOSL-8) ^LRAPTT1 Q:LR("Q")
 S X=LRM-LRF W !!,"Total cases:",$J(LRM,4) W:X !?3,"Incomplete cases:",$J(X,4) W !?3,"Complete   cases:",$J(LRF,4)
 W:LRF !?5,"Average turnaround time (days): ",$J(LRE/LRF,2,2)
 W:LRL&(LRF) ?44,"Cases exceeding limit: ",LRA," (",$J(LRA/LRF*100,2,2),"%)"
 D F^LRAPTT1
 I LRSPEC>0 D SPECTOT
 ;
 I LRPROC>0 D PROCTOT
 ;
OUT ;
 K ^TMP($J)
 W:IOST'?1"C".E @IOF
 K LRSPEC
 D END^LRUTL,V^LRU
 Q
 ;
 ;
N ;
 S LRZ=0 F  S LRZ=$O(^TMP($J,LRH,LRZ)) Q:LRZ=""!(LR("Q"))  D:$Y>(IOSL-6) ^LRAPTT1 Q:LR("Q")  S Y=^TMP($J,LRH,LRZ) D B
 Q
 ;
 ;
B ;
 W !,$J(LRZ,5),?5,$P(Y,U,8),?6,$P(Y,U,9),?8,$P(Y,U),?19,$E($P(Y,U,2),1,20),?40,$P(Y,U,3),?46,$P(Y,U,5),?51,$P(Y,U,4),?62,$J($P(Y,U,6),3),?66,$E($P(Y,U,7),1,13)
 Q
 ;
 ;
I ;
 S LRDFN=0
 F  S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  S M(2)="" D @($S("CYEMSP"[LRSS:"L",1:"A"))
 Q
 ;
 ;
L ;
 Q:'$D(^LR(LRDFN,0))
 S LRI=0
 F  S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $D(^LR(LRDFN,LRSS,LRI,0)) S X=^(0) D G:$P($P(X,"^",6)," ")=LRABV
 S LREND=0
 Q
 ;
 ;
G ;
 N LR61,LR615,LROK,LRJ,LRK
 ;
 ; Check if include/exclude specific specimens
 I LRSPEC>0 D  Q:'LROK
 . S LRJ=0,LROK=$S(LRSPEC=1:0,1:1)
 . F  S LRJ=$O(^LR(LRDFN,LRSS,LRI,.1,LRJ)) Q:'LRJ  D
 . . S LR61=+$P(^LR(LRDFN,LRSS,LRI,.1,LRJ,0),"^",6)
 . . I LR61<1 S:LRSPEC=2 LRSPECI(LR61)=$G(LRSPECI(LR61))+1
 . . I $D(LRSPEC(LR61)) S LRSPEC(LR61)=LRSPEC(LR61)+1
 . . I LRSPEC=1,'LROK S LROK=$S($D(LRSPEC(LR61)):1,1:0) Q
 . . I LRSPEC=2,LROK S LROK=$S($D(LRSPEC(LR61)):0,1:1) S:LROK LRSPECI(LR61)=$G(LRSPECI(LR61))+1
 ;
 ; Check if include/exclude specific procedures
 I LRPROC>0 D  Q:'LROK
 . N LRDUP
 . S LRJ=0,LROK=$S($P(LRPROC,"^")=1:0,1:1)
 . F  S LRJ=$O(^LR(LRDFN,LRSS,LRI,2,LRJ)) Q:'LRJ  D
 . . S LRK=0
 . . F  S LRK=$O(^LR(LRDFN,LRSS,LRI,2,LRJ,4,LRK)) Q:'LRK  D
 . . . S LR615=+^LR(LRDFN,LRSS,LRI,2,LRJ,4,LRK,0)
 . . . I '$P(LRPROC,"^",2),$D(LRDUP(LR615)) Q  ; Already counted one and no duplicates
 . . . S LRDUP(LR615)=""
 . . . I $D(LRPROC(LR615)) S LRPROC(LR615)=LRPROC(LR615)+1
 . . . I $P(LRPROC,"^")=1,'LROK S LROK=$S($D(LRPROC(LR615)):1,1:0) Q
 . . . I $P(LRPROC,"^")=2,LROK S LROK=$S($D(LRPROC(LR615)):0,1:1) S:LROK LRPROCI(LR615)=$G(LRPROCI(LR615))+1
 ;
 S Y=$P(X,U,11),Z=+$P($P(X,U,6)," ",3),W=$P(X,U,15),LRC=$S(W>1:W,Y>1:Y,Y=1:$P(X,U,3),1:""),H(4)=$P(X,U,2),LRR=$P(X,U,10),H(9)=$P(X,U,9),X=^LR(LRDFN,0) S:Z="" Z="??"
 D S
 Q
 ;
 ;
S ;
 D ^LRUP Q:$G(LREND)  S LRX=P("F") S:'$D(LRF(LRX))#2 LRF(LRX)=0
 S:LRC LRF=LRF+1,LRF(LRX)=LRF(LRX)+1
 S LRM=LRM+1,LRM(LRX)=LRM(LRX)+1
 S X1=LRC,X2=LRR D ^%DTC S:X=0 X="<1" S LRT=X
 I X>1 S LRY=X-1,Y=0,X=$P(LRR,".") D D
 S LRE=LRE+LRT,LRE(LRX)=LRE(LRX)+LRT
 I LRC,LRL,LRT<LRL Q
 ;
 I H(4),$D(^VA(200,H(4),0)) S X=$P(^(0),U),H(4)=$S(X[",":$E($P(X,","),1,16),1:$E(X,1,16))
 S H(5)=$$Y2K^LRX(LRR,"5D"),H("F")=$S(+LRC:$$Y2K^LRX(LRC,"5D"),1:""),X=$S(LRX=2:"",LRX=67:"#",LRX=67.1:"*",1:"?")
 S:'LRR LRR="?"
 I $D(^TMP($J,$E(LRR,1,3),Z))!(LRR="?") D
 .S LRM=LRM-1,LRM(LRX)=LRM(LRX)-1
 S ^TMP($J,$E(LRR,1,3),Z)=H(5)_U_LRP_U_SSN(1)_U_H("F")_U_H(9)_U_LRT_U_H(4)_U_X_U_LRD
 S:LRC LRA=LRA+1,LRA(LRX)=LRA(LRX)+1
 Q
 ;
 ;
A ;
 S X=$G(^LR(LRDFN,"AU")) Q:$P($P(X,U,6)," ")'=LRABV
 S LRR=$P(X,U),Z=$P($P(X,U,6)," ",3),LRC=$S(LR("AU")=1:$P(X,U,17),1:$P(X,U,3)),LRD=$P(X,U,11),H(4)=$P(X,U,10),H(9)=$P(X,U,13),X=^LR(LRDFN,0)
 D S
 Q
 ;
 ;
D ;
 N K
 F K=1:1:LRY S X1=X,X2=1 D C^%DTC,H^%DTC S K(X)=%Y
 S K=0
 F  S K=$O(K(K)) Q:'K  D
 . I "06"[K(K) S Y=Y+1 Q
 . S:$D(^HOLIDAY(K)) Y=Y+1
 S LRT=LRT-Y
 Q
 ;
 ;
SPECTOT ; Print specimen totals section
 N LR61,LRCNT,LRHLEN,LRPSNM,LRSHDR
 ;
 S LRPSNM=$$GET^XPAR("DIV^PKG","LR AP SNOMED SYSTEM PRINT",1,"Q")
 I LRPSNM<1 S LRPSNM=2
 I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")
 S (LRCNT,LRJ)=0
 F  S LRJ=$O(LRSPEC(LRJ)) Q:LRJ=""  S LRCNT=LRCNT+LRSPEC(LRJ)
 S LRSHDR="Specimens "_$S(LRSPEC=1:"included on",1:"excluded from")_" report",LRHLEN=40
 W !!,$$LJ^XLFSTR(LRSHDR,LRHLEN,"."),": ",$J(LRCNT,5)
 ;
 S LR61=""
 F  S LR61=$O(LRSPEC(LR61)) Q:LR61=""  D  Q:LR("Q")
 . I $Y>(IOSL-3) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . I LR61 S LR61(0)=^LAB(61,LR61,0),LRX=$P(LR61(0),"^")
 . E  S LRX="Specimen not specified"
 . I $L(LRX)>(LRHLEN) D
 . . I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . . F  W !,$E(LRX,1,(LRHLEN)) S LRX=$E(LRX,LRHLEN+1,999) Q:$L(LRX)<(LRHLEN)
 . W !,$$LJ^XLFSTR(LRX,LRHLEN,"."),": ",$J(LRSPEC(LR61),5)
 . I LR61,LRPSNM D
 . . I LRPSNM?1(1"1",1"3") W !,"T-",$P(LR61(0),"^",2)," (SNM)"
 . . I LRPSNM>1,$D(^LAB(61,LR61,"SCT")) W:LRPSNM=2 ! W:LRPSNM=3 " / " W $P(^LAB(61,LR61,"SCT"),"^")," (SCT)"
 . . W !
 ;
 I LRSPEC=2,$D(LRSPECI) D
 . I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")
 . S LRCNT=0,LR61=""
 . F  S LR61=$O(LRSPECI(LR61)) Q:LR61=""  S LRCNT=LRCNT+LRSPECI(LR61)
 . S LRSHDR="Specimens included on report"
 . W !!,$$LJ^XLFSTR(LRSHDR,LRHLEN,"."),": ",$J(LRCNT,5)
 . S LR61=""
 . F  S LR61=$O(LRSPECI(LR61)) Q:LR61=""  D  Q:LR("Q")
 . . I $Y>(IOSL-3) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . . I LR61 S LR61(0)=^LAB(61,LR61,0),LRX=$P(LR61(0),"^")
 . . E  S LRX="Specimen not specified"
 . . I $L(LRX)>(LRHLEN) D
 . . . I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . . . F  W !,$E(LRX,1,(LRHLEN)) S LRX=$E(LRX,LRHLEN+1,999) Q:$L(LRX)<(LRHLEN)
 . . W !,$$LJ^XLFSTR(LRX,LRHLEN,"."),": ",$J(LRSPECI(LR61),5)
 . . I LR61,LRPSNM D
 . . . I LRPSNM?1(1"1",1"3") W !,"T-",$P(LR61(0),"^",2)," (SNM)"
 . . . I LRPSNM>1,$D(^LAB(61,LR61,"SCT")) W:LRPSNM=2 ! W:LRPSNM=3 " / " W $P(^LAB(61,LR61,"SCT"),"^")," (SCT)"
 . . . W !
 Q
 ;
 ;
PROCTOT ; Print procedure totals section
 N LR61,LRCNT,LRHLEN,LRPSNM,LRSHDR
 ;
 S LRPSNM=$$GET^XPAR("DIV^PKG","LR AP SNOMED SYSTEM PRINT",1,"Q")
 I LRPSNM<1 S LRPSNM=2
 I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")
 S (LRCNT,LRJ)=0
 F  S LRJ=$O(LRPROC(LRJ)) Q:LRJ=""  S LRCNT=LRCNT+LRPROC(LRJ)
 S LRSHDR="Procedures "_$S($P(LRPROC,"^")=1:"included on",1:"excluded from")_" report",LRHLEN=40
 W !!,$$LJ^XLFSTR(LRSHDR,LRHLEN,"."),": ",$J(LRCNT,5)
 ;
 S LR615=""
 F  S LR615=$O(LRPROC(LR615)) Q:LR615=""  D  Q:LR("Q")
 . I $Y>(IOSL-3) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . I LR615 S LR615(0)=^LAB(61.5,LR615,0),LRX=$P(LR615(0),"^")
 . E  S LRX="Procedure not specified"
 . I $L(LRX)>(LRHLEN) D
 . . I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . . F  W !,$E(LRX,1,(LRHLEN)) S LRX=$E(LRX,LRHLEN+1,999) Q:$L(LRX)<(LRHLEN)
 . W !,$$LJ^XLFSTR(LRX,LRHLEN,"."),": ",$J(LRPROC(LR615),5)
 . I LR615,LRPSNM D
 . . I LRPSNM?1(1"1",1"3") W !,"P-",$P(LR615(0),"^",2)," (SNM)"
 . . I LRPSNM>1,$D(^LAB(61.5,LR615,"SCT")) W:LRPSNM=2 ! W:LRPSNM=3 " / " W $P(^LAB(61.5,LR615,"SCT"),"^")," (SCT)"
 . . W !
 ;
 I $P(LRPROC,"^")=2,$D(LRPROCI) D
 . I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")
 . S LRCNT=0,LR615=""
 . F  S LR615=$O(LRPROCI(LR615)) Q:LR615=""  S LRCNT=LRCNT+LRPROCI(LR615)
 . S LRSHDR="Procedures included on report"
 . W !!,$$LJ^XLFSTR(LRSHDR,LRHLEN,"."),": ",$J(LRCNT,5)
 . S LR615=""
 . F  S LR615=$O(LRPROCI(LR615)) Q:LR615=""  D  Q:LR("Q")
 . . I $Y>(IOSL-3) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . . I LR615 S LR615(0)=^LAB(61.5,LR615,0),LRX=$P(LR615(0),"^")
 . . E  S LRX="Procedure not specified"
 . . I $L(LRX)>(LRHLEN) D
 . . . I $Y>(IOSL-6) D ^LRAPTT1 Q:LR("Q")  W !,$$LJ^XLFSTR(LRSHDR,LRHLEN,".")," (cont'd)"
 . . . F  W !,$E(LRX,1,(LRHLEN)) S LRX=$E(LRX,LRHLEN+1,999) Q:$L(LRX)<(LRHLEN)
 . . W !,$$LJ^XLFSTR(LRX,LRHLEN,"."),": ",$J(LRPROCI(LR615),5)
 . . I LR615,LRPSNM D
 . . . I LRPSNM?1(1"1",1"3") W !,"P-",$P(LR615(0),"^",2)," (SNM)"
 . . . I LRPSNM>1,$D(^LAB(61.5,LR615,"SCT")) W:LRPSNM=2 ! W:LRPSNM=3 " / " W $P(^LAB(61.5,LR615,"SCT"),"^")," (SCT)"
 . . . W !
 ;
 W !!,"Count multiple procedure occurrence/case.: ",$S($P(LRPROC,"^",2):"YES",1:"NO")
 ;
 Q
 ;
 ;
END ;
 D V^LRU
 Q
