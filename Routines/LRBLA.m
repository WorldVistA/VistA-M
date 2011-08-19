LRBLA ;AVAMC/REG/CYM - BB ADM DATA ;6/21/96  07:34
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 S LRC=0,%=0 I $P($G(^LAB(69.9,1,8.1,DUZ(2),0)),U,6) W !,"Print inventory data for only one division",!,"(Donor data will be included for all divisions) " S %=2 D YN^LRU G:%<1 END
 I %=1 S LRC=1,DIC=4,DIC("A")="Select DIVISION: ",DIC(0)="AEQM",DIC("S")="I +$G(^DIC(4,+Y,99))=+$$SITE^VASITE" D ^DIC K DIC S LRC(1)=+Y,LRC(2)=$P(Y,U,2)
 W ! D B^LRU G:Y=-1 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRBLA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J),^TMP("LR",$J) D L^LRU,S^LRBLA1
 S DIWF="W",DIWR=IOM-5,DIWL=5,LRB="S" D H^LRBLA1 S LR("F")=1,A=LRSDT F  S A=$O(^LRE("AD",A)) Q:'A!(A>LRLDT)  F C=0:0 S C=$O(^LRE("AD",A,C)) Q:'C  D P
 S A=LRSDT F  S A=$O(^LRD(65,"A",A)) Q:'A!(A>LRLDT)  F C=0:0 S C=$O(^LRD(65,"A",A,C)) Q:'C  D T,R
 S A=LRSDT F  S A=$O(^LRD(65,"AB",A)) Q:'A!(A>LRLDT)  F C=0:0 S C=$O(^LRD(65,"AB",A,C)) Q:'C  D T,D
 F LRB="S","H","A","D" Q:LR("Q")  D:LRB'="S" H^LRBLA1 Q:LR("Q")  D C
 D:'LR("Q") ^LRBLA1 D END,END^LRUTL Q
C F A=0:0 S A=$O(LRA(A)) Q:'A!(LR("Q"))  D W Q:LR("Q")  W !,LR("%")
 Q:LR("Q")  D:$D(^TMP($J)) D^LRBLA2 Q
W D:$Y>(IOSL-6) H^LRBLA1 Q:LR("Q")  W !,"|",LRA(A),?20,"|",$J(^TMP("LR",$J,LRB,"A",A),8),?30,"|",$J(^TMP("LR",$J,LRB,"B",A),8),?40,"|",$J(^TMP("LR",$J,LRB,"C",A),9)
 W ?51,"|",$J(^TMP("LR",$J,LRB,"D",A),6),?59,"|",$J(^TMP("LR",$J,LRB,"E",A),8),?69,"|",$J(^TMP("LR",$J,LRB,"F",A),8),?79,"|" D:$O(^TMP("LR",$J,LRB,"C",A,0)) S^LRBLA2 Q
 ;
P S I=9999999-A,Y=^LRE(C,5,I,0),X=$P(Y,"^",2),LRB=$P(Y,"^",11),Y=$P(Y,"^",10) D A Q:LRB=""!(Y=2)
 F E=0:0 S E=$O(^LRE(C,5,I,66,E)) Q:'E  S Y=$P(^(E,0),U,8),F=$S($D(^LAB(66,E,0)):$P(^(0),U,26),1:"") D:F P1
 Q
P1 S ^(F)=^TMP("LR",$J,"S","A",F)+1 S:Y=2 ^(F)=^TMP("LR",$J,"S","F",F)+1 S ^(F)=^TMP("LR",$J,LRB,"A",F)+1 S:Y=2 ^(F)=^TMP("LR",$J,LRB,"F",F)+1
 Q
R I '$D(^LRD(65,C,0)) K ^LRD(65,"A",A,C) Q
 I LRC Q:$P(^LRD(65,C,0),"^",16)'=LRC(1)
 S X=^LRD(65,C,0),E=+$P(X,"^",4),Y=$P(X,"^",2),F=$S($D(^LAB(66,E,0)):$P(^(0),"^",26),1:"") Q:'F
 I "2346"[F,Y["SELF" S LRG=1 D CK I LRG S ^(F)=^TMP("LR",$J,"S","A",F)+1,^(F)=^TMP("LR",$J,LRB,"A",F)+1 Q
 Q:Y["SELF"  S ^(F)=^TMP("LR",$J,"S","B",F)+1,^(F)=^TMP("LR",$J,LRB,"B",F)+1 Q
CK S D=$P(X,"^"),LRP=$O(^LRE("C",D,0)) Q:'LRP  S I=$O(^LRE("C",D,LRP,0)) Q:'I  F G=0:0 S G=$O(^LRE(LRP,5,I,66,G)) Q:'G  I E=G S LRG=0 Q
 Q
D I '$D(^LRD(65,C,0)) K ^LRD(65,"AB",A,C) Q
 I LRC Q:$P(^LRD(65,C,0),"^",16)'=LRC(1)
 S E=+$P(^LRD(65,C,0),"^",4),F=$S($D(^LAB(66,E,0)):$P(^(0),"^",26),1:"") I F S Y=$S($D(^LRD(65,C,4)):$P(^(4),"^"),1:"") D:Y]"" D1
 Q
D1 I Y="T" S B=$P($G(^LRD(65,C,6)),"^",8),X=1 D:$O(^LRD(65,C,9,0)) ^LRBLAB S ^(F)=^TMP("LR",$J,"S","C",F)+X,^(F)=^TMP("LR",$J,LRB,"C",F)+X D:B R^LRBLA2 Q
 S LRT=$P(^LRD(65,C,0),"^",6),LRT(2)=$P(^(4),"^",2) I LRT'["."!(LRT(2)'[".") S LRT=$P(LRT,"."),LRT(2)=$P(LRT(2),".")
 I LRT<LRT(2) S ^(F)=^TMP("LR",$J,"S","E",F)+1,^(F)=^TMP("LR",$J,LRB,"E",F)+1 Q
 I "RS"[Y S ^(F)=^TMP("LR",$J,"S","D",F)+1,^(F)=^TMP("LR",$J,LRB,"D",F)+1 Q
 I Y="D" S ^(F)=^TMP("LR",$J,"S","F",F)+1,^(F)=^TMP("LR",$J,LRB,"F",F)+1 Q
 Q
T S LRB=$S($D(^LRD(65,C,8)):$P(^(8),"^",3),1:"H") S:LRB="" LRB="H" Q
 ;
A I X="N" S ^(X)=^TMP("LR",$J,X)+1 D A1 Q
 I X]"",LRB]"" S Z=X_LRB,^(Z)=^TMP("LR",$J,Z)+1 S:Y=2 ^("D")=^TMP("LR",$J,Z,"D")+1 D B
 Q
A1 I $P(^LRE(C,0),"^",10) S Y=$P(^(0),"^"),^("P")=^TMP("LR",$J,"N","P")+1,^TMP("LR",$J,"N","P",Y,C,I)=""
 S ^("T")=^TMP("LR",$J,"N","T")+1 F E=0:0 S E=$O(^LRE(C,5,I,1,E)) Q:'E  S D=+^(E,0) S:'$D(^TMP("LR",$J,"N","T",D)) ^(D)=0 S ^(D)=^(D)+1
 Q
B S Z=X_LRB,B=0 F E=12:1:20 I $P($G(^LRE(C,5,I,E)),"^") S B=B+1,^(Z)=^TMP("LR",$J,"Y",E,Z)+1
 S:B>1 ^(Z)=^TMP("LR",$J,"Y",Z)+1 Q
 ;
END D V^LRU Q
