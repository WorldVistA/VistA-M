FSCQU ;SLC/STAFF-NOIS Query Utility ;3/12/99  14:27
 ;;1.1;NOIS;**1**;Sep 06, 1998
 ;
LOOK(DIC,HELP,HFRAME) ; from FSCQCA, FSCQCAV
 N CNT,DONE,ROU,X
 S (Y,Y(0))="",DONE=0 F  W !,DIC("A") W:$D(DIC("B")) DIC("B"),"// " R X:DTIME S:'$T DTOUT=1 D  Q:DONE
 .I $D(DTOUT) S DONE=1 Q
 .I '$L(X) S X=$G(DIC("B")) I '$L(X) S Y=-1,DONE=1 Q
 .I X[U S DONE=1,DUOUT=1 S Y=$S(X["^^":"^^",1:-1) Q
 .I X["??" S XQH=$S($D(HFRAME):HFRAME,1:"FSC U1 NOIS") D EN^XQH Q
 .I X="?" S X="??" I $D(DIR("?")) D
 ..I $L($P($G(DIR("?")),U,2)) S ROU=$P(DIR("?"),U,2,99) X ROU Q
 ..S CNT=0 F  S CNT=$O(DIR("?",CNT)) Q:CNT<1  W !,DIR("?",CNT)
 ..I $D(DIR("?"))#2 W !,DIR("?")
 .D ^DIC I Y>0 S DONE=1
 I Y<0 S (Y,Y(0))=""
 Q
