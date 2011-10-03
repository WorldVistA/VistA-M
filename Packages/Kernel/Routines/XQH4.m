XQH4 ;SEA/AMF,JLI - HELP FRAME LISTER ;01/26/99  08:56
 ;;8.0;KERNEL;**113**;Jul 10, 1995
LKUP S DIC=9.2,DIC("A")="Select primary HELP FRAME from which to list: ",DIC(0)="AEQMZ" D ^DIC K DIC G:Y<0 OUT S XQHFY=+Y
FMT W !!,"Select LISTING FORMAT: TEXT ONLY// " R X:DTIME S:'$T X=U S:'$L(X) X="T" S XQI=X
 I X="?" S XQH="XQHELP-LIST-FORMAT" D EN^XQH G FMT
 G:X[U OUT S X=$E(X,1) I "TtRrCc"'[X W *7," ??",!,"Enter '?' for HELP" G FMT
 W $C(13),"Select LISTING FORMAT: TEXT ONLY// ",$S("Cc"[X:"COMPLETE","Tt"[X:"TEXT ONLY",1:"RELATED FRAMES"),$J("",20)
ACTENT S Y=XQHFY,XQFMT=$S("Tt"[X:-1,"Rr"[X:0,1:1),%ZIS="MQ" D ^%ZIS G:POP OUT I $D(IO("Q")) K IO("Q") S ZTSAVE("XQHFY")="",ZTSAVE("XQFMT")="",ZTRTN="DQ^XQH4",ZTDESC="PRINT HELP FRAMES" D ^%ZTLOAD K ZTSAVE,ZTSK,ZTRTN,ZTDESC,ZTDTH G OUT
 ;
DQ ; Entry point for queued job.
 S Y=XQHFY D INIT,SET,LIST^XQH5
OUT D ^%ZISC K IOP,XQFMT,XQHDR,XQHFY,X,XQDOT,XQDSH,XQI,XQII,XQIJ,XQIL,XQJ,XQK,XQL,XQM,XQN,XQPG,XQRN,XQSTR,XQTB,XQHY,XQTOC,%ZIS,DIC,L,X,XQHDIC,XQH,XQUI,Y,XQX,C
 Q
SET0 ;
 S X(L)=$O(^DIC(9.2,XQHDIC,2,X(L))) Q:(X(L)="")!(X(L)'=+X(L))
 S Y=$P(^DIC(9.2,XQHDIC,2,X(L),0),U,2) G:'$L(Y) SET0 G:'$D(^DIC(9.2,Y,0)) SET0 I $D(^TMP($J,"XQM",Y)) G SET0
SET ;
 S XQSTR=U F XQI=1:1:L S:XQSTR[(U_XQHDIC(XQI)_U) XQSTR=-1 Q:(XQSTR=-1)  S XQSTR=XQSTR_XQHDIC(XQI)_"^"
 G:XQSTR=-1 SET0 S:'$D(^TMP($J,"XQM",Y)) ^TMP($J,"XQM","PG",XQPG)=Y,^TMP($J,"XQM",Y)=XQPG,XQPG=XQPG+1
 S ^TMP($J,"XQM","TOC",XQTOC)=L_U_Y_XQSTR,XQTOC=XQTOC+1 I $S('$D(^DIC(9.2,XQHDIC,2)):1,'$P(^(2,0),U,3):1,1:0) S XQL=XQL+1 G SET0
 S L=L+1,X(L)=0,(Y,XQHDIC,XQHDIC(L))=+Y D SET0
 Q:L=1  S L=L-1,XQHDIC=XQHDIC(L) G SET0
INIT K ^TMP($J,"XQM"),XQJ S L=0,(XQL,XQPG)=1,(XQHDIC,Y)=+Y,X(0)=0,XQTOC=1
 S XQDSH="---------------------------------------------------------------------------------------------------"
 S XQDOT="" F XQII=1:1:112 S XQDOT=XQDOT_"."
 S XQRN="   i  ii iii  iv   v  vi viiviii  ix   x  xi xiixiii xiv  xv xvixvii",XQUI=0
 Q
 ;
ACTION ; Entry point for a specific action option - The action must set XQHFY to the name of the desired help frame, in quotes, then D ACTION^XQH4
 ; The variable XQFMT may be set "T","R", or "C" for text only, related
 ;     frames or complete.  If XQFMT is undefined or something else, it
 ;     will be set to T (Text only)
 S:'($D(XQFMT)#2) XQFMT="T" S XQFMT=$E(XQFMT),XQFMT=$S("CcRr"[XQFMT:XQFMT,1:"T")
 S X=XQHFY,DIC=9.2,DIC(0)="MZ" D ^DIC K DIC I Y<0 W !,$C(7),"The Help Frame '"_XQHFY_"' is not unique or was not found.",$C(7),! G OUT
 S XQHFY=+Y
 S Y=XQHFY,X=XQFMT
 G ACTENT
