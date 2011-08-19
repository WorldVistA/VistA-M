LRAPQAFS ;AVAMC/REG - FROZEN SECTION/SURG PATH RPTS ;8/14/95  18:13
 ;;5.2;LAB SERVICE;**72,242,252**;Sep 27, 1994
 S LRDICS="SP" D ^LRAP G:'$D(Y) END
 W !!,"Frozen section search with optional permanent path reports.",!,"This report may take a while and should be queued to print at non-peak hours.",!,"OK to continue " S %=2 D YN^LRU G:%'=1 END
 D ASK Q:%<1  W ! D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 W ! S ZTRTN="QUE^LRAPQAFS" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRN="ALL",LRS(99)=1,LR("DIWF")="W",(LR,LR("A"),LR(1),LR(2),LR(3),LRQ(2))=0,LRO="" D L^LRU,S^LRU,XR^LRU,L1^LRU
 S S(7)="PROCEDURE",LRSN=61.5,V=4,S(2)="ALL",LRN="FS",LRN(1)=3082,LRM(1)=4,LRN(2)=3081,LRM(2)=4,LRN(3)=3090,LRM(3)=4
 S ^TMP($J,0)=S(2)_U_"FS"_U_LRO(68)_U_S(7)
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN^LRAPSM
 D ^LRAPSM1 G:LR("Q") OUT D EN2^LRUA,SET^LRUA S LRQ=0,LRA=1
 I LRQA F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=A,%DT="" D ^%DT S LRY=$E(X,1,3) F B=0:0 S B=$O(^TMP($J,A,B)) Q:'B  S ^TMP("LRAP",$J,LRY,B)=""
 F LRY=0:0 S LRY=$O(^TMP("LRAP",$J,LRY)) Q:'LRY!(LR("Q"))  F LRAN=0:0 S LRAN=$O(^TMP("LRAP",$J,LRY,LRAN)) Q:'LRAN!(LR("Q"))  S LRDFN=$O(^LR(LRXREF,LRY,LRABV,LRAN,0)),LRI=$O(^(LRDFN,0)) D EN^LRSPRPT D:LRC L^LRAPQAMR
OUT K ^TMP("LRAP",$J) D END^LRUTL,END Q
 ;
ASK W !!,"Do you want corresponding permanent pathology reports",!,"to print following search " S %=2 D YN^LRU S LRQA=$S(%=1:1,1:0),LRC=0 Q:'LRQA
 W !!,"Include cum path data summaries on report " S %=2 D YN^LRU S LRC=$S(%=1:1,1:0) Q
 ;
END D V^LRU Q
