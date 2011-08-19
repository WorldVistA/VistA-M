LRBLA2 ;AVAMC/REG/CYM - BB ADM DATA ;6/21/96  09:20
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !,"|",?30,"BLOOD DONOR DATA",?70,"|  Total",?79,"|",!,LR("%"),!,"|No donation",?70,"|",$J(^TMP("LR",$J,"N"),6),?79,"|"
 W !,LR("%"),!,"|",?3,"Temporary deferrals",?70,"|",$J(^TMP("LR",$J,"N","T"),6),?79,"|"
 W !,LR("%"),!,"|",?3,"Permanent deferrals",?70,"|",$J(^TMP("LR",$J,"N","P"),6),?79,"|" I IOST?1"C".E W !,LR("%") D M Q:LR("Q")
 D H W !,LR("%"),!,"|WHOLE BLOOD" S X=25,Y=0 F LRB="WH","WD","WA","WT" D P
 D B W !,"|",?2,"COLLECTION DISCARDED" S X=25,Y=0 F LRB="WH","WD","WA","WT" D P1
 N NAME D B,A F LRA=12:1:20 W !,"|",?3 D FIELD^DID(65.54,LRA,"","LABEL","NAME") S NAME=NAME("LABEL") W NAME S V="W",X=25,Y=0 D W
 S V="W" D C,B W !,LR("%") I IOST?1"C".E D M Q:LR("Q")  D H W !,LR("%")
 W !,"|PLASMAPHERESIS" S X=25,Y=0 F LRB="PH","PD","PA","PT" D P
 D B W !,"|",?2,"COLLECTION DISCARDED" S X=25,Y=0 F LRB="PH","PD","PA","PT" D P1
 N NAME D B,A F LRA=12:1:20 W !,"|",?3 D FIELD^DID(65.54,LRA,"","LABEL","NAME") S NAME=NAME("LABEL") W NAME S V="P",X=25,Y=0 D W
 S V="P" D C,B W !,LR("%") I IOST?1"C".E D M Q:LR("Q")  D H W !,LR("%")
 W !,"|CYTAPHERESIS" S X=25,Y=0 F LRB="CH","CD","CA","CT" D P
 D B W !,"|",?2,"COLLECTION DISCARDED" S X=25,Y=0 F LRB="CH","CD","CA","CT" D P
 N NAME D B,A F LRA=12:1:20 W !,"|",?3 D FIELD^DID(65.54,LRA,"","LABEL","NAME") S NAME=NAME("LABEL") W NAME S V="C",X=25,Y=0 D W
 S V="C" D C,B W !,LR("%") Q
 ;
B W ?70,"|",$J(Y,6),?79,"|" Q
W F LRB=V_"H",V_"D",V_"A",V_"T" D P2
 D B Q
C W !,"| MULTIPLE POSITIVE TESTS" S X=25,Y=0 F LRB=V_"H",V_"D",V_"A",V_"T" D P3
 Q
P S Z=^TMP("LR",$J,LRB) W ?X,"|",$J(Z,6) S X=X+11,Y=Y+Z Q
P1 S Z=^TMP("LR",$J,LRB,"D") W ?X,"|",$J(Z,6) S X=X+11,Y=Y+Z Q
P2 S Z=^TMP("LR",$J,"Y",LRA,LRB) W ?X,"|",$J(Z,6) S X=X+11,Y=Y+Z Q
P3 S Z=^TMP("LR",$J,"Y",LRB) W ?X,"|",$J(Z,6) S X=X+11,Y=Y+Z Q
 ;
A W !,"|",?2,"POSITIVE TESTS",?25,"|",?36,"|",?47,"|",?58,"|",?70,"|",?79,"|" Q
 ;
H W !,LR("%"),!,"|DONATIONS",?25,"|Homologous",?34,"|Directed",?47,"|Autologous",?57,"|Therapeutic",?70,"|  Total",?79,"|" Q
M D M^LRU Q:LR("Q")  W @IOF Q
 ;
R ;Set transfusion reaction type
 S:'$D(^TMP("LR",$J,LRB,"C",F,B)) ^(B)=0 S ^(B)=^(B)+1
 S:'$D(^TMP("LR",$J,"S","C",F,B)) ^(B)=0 S ^(B)=^(B)+1 Q
S ;Ck transfusion reactions
 F B=0:0 S B=$O(^TMP("LR",$J,LRB,"C",A,B)) Q:'B  S ^TMP($J,A,B)=^(B)
 S ^TMP($J,A)=^TMP("LR",$J,LRB,"C",A) Q
D W !,LRB(LRB)," Transfusion Reactions:" F A=0:0 S A=$O(^TMP($J,A)) Q:'A!(LR("Q"))  S X=^(A) W !?3,LRA(A)," (",X," Transfusion",$S(X>1:"s",1:""),")" D:$Y>(IOSL-6) F Q:LR("Q")  D E
 K ^TMP($J) Q
E F B=0:0 S B=$O(^TMP($J,A,B)) Q:'B!(LR("Q"))  S B(1)=^(B) W !?6,$P(^LAB(65.4,B,0),"^"),?40,$J(B(1),4) D:$Y>(IOSL-6) F
 Q
F S LRF=1 D H^LRBLA1 Q:LR("Q")  S LRF=0 W !,LRB(LRB)," Transfusion Reactions:",!?3,LRA(A) Q
