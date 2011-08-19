LRAPQOR3 ;AVAMC/REG - QA AUTOPSY DATA ;9/17/90  07:52
 ;;5.2;LAB SERVICE;**234,242**;Sep 27, 1994
 ;15-MAR-1999;WTY;Changes for HIN-1298-42595
 ;
 S (LRA,LRD)="",EXTOT=0,LRSDT=LRSDT(1) K LRC
 S A=0 F B=0:0 S A=$O(^DG(405.2,"B",A)) Q:A=""  D
 .I A["DEATH"!(A="WHILE ASIH") S X=$O(^DG(405.2,"B",A,0)) D
 ..I X S:A["DEATH" LRC(X)="" S:A["ASIH" LRJ(X)=""
 S F=1 F A=LRSDT:0 S A=$O(^LR("AAU",A)) Q:'A!(A>LRLDT)  D
 .F LRDFN=0:0 S LRDFN=$O(^LR("AAU",A,LRDFN)) Q:'LRDFN  D A
 Q:LR("Q")
 I IOST?1"C".E W !!,"Please hold, calculating Autopsy% ...",!
 S F=0 F A=LRSDT:0 S A=$O(^DPT("AEXP1",A)) Q:'A!(A>LRLDT)  D
 .F DFN=0:0 S DFN=$O(^DPT("AEXP1",A,DFN)) Q:'DFN  D
 ..D P I $D(LRK) S LRD=LRD+1 D Q K LRK
 S LRF=1 D H Q:LR("Q")
 W !?35,$J(LRD,7),?45,$J(LRA,8),?60,$J(LRA/$S('LRD:1,1:LRD)*100,5,1)
 F A=0:0 S A=$O(^TMP($J,"T",A)) Q:'A  D
 .S ^TMP($J,"T","B",$P(^DIC(45.7,A,0),"^"),A)=""
 W ! S A=0
 F  S A=$O(^TMP($J,"T","B",A)) Q:A=""!(LR("Q"))  D
 .F B=0:0 S B=$O(^TMP($J,"T","B",A,B)) Q:'B!(LR("Q"))  D
 ..S X=^TMP($J,"T",B)
 ..W !,A,?39,$J(X,3)
 ..D:$Y>(IOSL-6) H Q:LR("Q")
 ..S Y=$G(^TMP($J,"Z",B))
 ..I Y,Y'>X W ?46,$J(Y,7),?60,$J(Y/X*100,5,1)
PREXC ;Print Exceptions
 Q:LR("Q")
 W !!,"Treating Specialty Exceptions:",?46,$J(EXTOT,7)
 Q:'EXTOT
 D H2
 S A="" F  S A=$O(^TMP($J,"EXC",A)) Q:A=""!(LR("Q"))  D
 .S TSN=^TMP($J,"EXC",A)
 .S TSA=$P(TSN,"^"),TSD=$P(TSN,"^",2)
 .Q:TSD=""
 .D:$Y>(IOSL-6) H1 Q:LR("Q")
 .W !,A,?17,$E("("_TSD_") "_$P(^DIC(45.7,TSD,0),"^"),1,30)
 .W ?49,$E("("_TSA_") "_$P(^DIC(45.7,TSA,0),"^"),1,30)
 Q
A ;
 S LRG=0,LRX=^LR(LRDFN,"AU"),C=$P(LRX,"^",14),ACC=$P(LRX,"^",6)
 I C D
 .S:'$D(^TMP($J,"Z",C)) ^(C)=0
 .S ^TMP($J,"Z",C)=^TMP($J,"Z",C)+1
 .S ^TMP($J,"EXC",ACC)=C
 S X=^LR(LRDFN,0),DFN=$P(X,"^",3) Q:$P(X,"^",2)'=2
 D P
 I '$D(LRK) D  Q
 .Q:C=""
 .S:$D(^TMP($J,"Z",C)) ^TMP($J,"Z",C)=^TMP($J,"Z",C)-1
 S LRA=LRA+1,LRG=1 D:'C Q K LRK
 Q
P ;
 S Y=0,X=$O(^DGPM("ATID3",DFN,0)) Q:'X
 S Y=$O(^DGPM("ATID3",DFN,X,0)) Q:'Y
 S E=$G(^DGPM(Y,0)),Z=$P(E,"^",18) Q:'Z
 I $D(LRC(Z)) S LRK=1 Q
 Q:'$D(LRJ(Z))
 S X=$O(^DGPM("ATID3",DFN,X)) Q:'X
 S Y=$O(^DGPM("ATID3",DFN,X,Y)) Q:'Y
 S E=$G(^DGPM(Y,0)),Z=+$P(E,"^",18)
 S:$D(LRC(Z)) LRK=1
 Q
Q ;
 S E=+$P(E,"^",14),E(1)=+$O(^DGPM("ATS",DFN,E,0))
 S C=+$O(^DGPM("ATS",DFN,E,E(1),0))
 I F D  Q
 .S:'$D(^TMP($J,"Z",C)) ^(C)=0
 .S ^TMP($J,"Z",C)=^TMP($J,"Z",C)+1
 D EXC
 S:'$D(^TMP($J,"T",C)) ^(C)=0
 S ^TMP($J,"T",C)=^TMP($J,"T",C)+1
 Q
H ;
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"AUTOPSY DATA REVIEW (",LRSTR,"-",LRLST,")"
 W !?35,"|----------In-patient-------------|"
 W !,"Treating Specialty",?35,"| #Deaths",?45," #Autopsies"
 W ?60,"Autopsy% |",!,LR("%")
 Q
H1 ;
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"AUTOPSY DATA REVIEW (",LRSTR,"-",LRLST,")"
 W !,"Treating Specialty Exceptions (Continued)"
 W !,LR("%")
H2 ;
 W !!,"Autopsy #",?17,"PATIENT MOVEMENT File",?49,"LAB DATA File",!
 Q
EXC ;Check for treating specialty exceptions
 S LRDFN=$$LRDFN^LR7OR1(DFN)
 Q:'LRDFN
 I $D(^LR(LRDFN,"AU")) D
 .S AUREC=^LR(LRDFN,"AU")
 .S ACC=$P(AUREC,"^",6)
 .I $D(^TMP($J,"EXC",ACC)) D
 ..Q:+^TMP($J,"EXC",ACC)=C
 ..S $P(^TMP($J,"EXC",ACC),"^",2)=C,EXTOT=EXTOT+1
 ..S TSA=$P(^TMP($J,"EXC",ACC),"^")
 ..S ^TMP($J,"Z",TSA)=^TMP($J,"Z",TSA)-1
 Q
