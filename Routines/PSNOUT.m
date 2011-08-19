PSNOUT ;BIR/CCH&WRT-output transform routine ; 10/31/98 19:19
 ;;4.0; NATIONAL DRUG FILE;**2,82,92**; 30 Oct 98
INGRED ; output transform for ingredient
 K X,LIST,^TMP($J,"PSNING") S K=PSNFNM,X=$$PSJING^PSNAPIS(,K,.LIST),STOP=X D ING0,ING00 F PSNXZ=0:0 S PSNXZ=$O(^TMP($J,"PSNING",PSNXZ)) Q:PSNXZ'?1.N  S INGT=^TMP($J,"PSNING",PSNXZ) D DISP,BREAK
 K ^TMP($J,"PSNING")
 Q
DISP W !?5,$P(INGT,"^",1)_" "_$P(INGT,"^",2)_" "_$P(INGT,"^",3)
 Q
BREAK I PSNXZ#7=0,STOP'=7 W !,"Press ANY key to continue Ingredient listing: " R PSNCON:DTIME S:'$T PSNCON="^" Q:PSNCON="^"
 Q
ING0 F INT=0:0 S INT=$O(LIST(INT)) Q:'INT  S ^TMP($J,"PSNING",$P(LIST(INT),"^",2),INT)=LIST(INT)
 Q
ING00 S PSNRAN=0 S IN="" F  S IN=$O(^TMP($J,"PSNING",IN)) Q:IN=""  D ING000
 Q
ING000 F IN1=0:0 S IN1=$O(^TMP($J,"PSNING",IN,IN1)) Q:'IN1  D ARRAY
 Q
ARRAY S PSNRAN=PSNRAN+1 S ^TMP($J,"PSNING",PSNRAN)=IN_"^"_$P(LIST(IN1),"^",3)_"^"_$P(LIST(IN1),"^",4)
 Q
FORM ; output transform for va product code
 I $D(^PSDRUG(D0,"ND")) S PSNLOCL=^PSDRUG(D0,"ND")
 Q:'$O(^PSNDF(50.68,0))  Q:'$D(PSNLOCL)  Q:$P(PSNLOCL,"^",1)']""
 S PSNDF=$P(PSNLOCL,"^",1),PSNPTR=$P(PSNLOCL,"^",3)
 S Y=$P(^PSNDF(50.68,PSNPTR,0),"^",1) K PSNLOCL,PSNDF,PSNPTR Q
 Q
REACT ; code for reactivation of inactive drug in local drug file
 I $D(^PSDRUG(DA,"ND")) I $P(^PSDRUG(DA,"ND"),"^",2)]"" W !!,"points to ",$P(^("ND"),"^",2)," in the National Drug File."
REACT1 I $O(^PSNDF(50.6,0)) S XX=$S('$D(^PSDRUG(DA,"ND")):1,1:$P(^("ND"),"^",2)="") I XX S (PSNB,PSNDRG,Z9)=DA,PSNLOC=$P(^PSDRUG(PSNB,0),"^",1) K ^PSNTRAN(PSNB) D GONE^PSNDRUG,BLDIT^PSNCOMP S DA=Z9 D CHK^PSNVFY,SET^PSNMRG,GONE^PSNDRUG K Z9,XX
 Q
PKSIZE ; output transform for package size
 I $D(^PS(50.609,PSNSIZE,0)) S PSNSZE=$P(^PS(50.609,PSNSIZE,0),"^",1)
 Q
PKTYPE ; output transform for package type
 I $D(^PS(50.608,PSNTYPE,0)) S PSNTPE=$P(^PS(50.608,PSNTYPE,0),"^",1)
 Q
INGRED1 ; output transform for ingredient-used in NDF Info Report
 K LIST,X S K=FNM,X=$$PSJING^PSNAPIS(,K,.LIST) D INGRD1,INGRD2 K IN,VV,VVV
 Q
INGRD1 K ^TMP($J,"PSNING") F INT=0:0 S INT=$O(LIST(INT)) Q:'INT  S ^TMP($J,"PSNING",$P(LIST(INT),"^",2),INT)=LIST(INT)
 Q
INGRD2 S IN="" F  S IN=$O(^TMP($J,"PSNING",IN)) Q:IN=""  S IN1=$O(^TMP($J,"PSNING",IN,0)) W !,?42,IN,"  ",$P(^TMP($J,"PSNING",IN,IN1),"^",3)," ",$P(^TMP($J,"PSNING",IN,IN1),"^",4)
 Q
