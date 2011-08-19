RMPRUTL2 ;PHX/HPL-Patient Letter Date look-up in chronological order ;05/22/1995
 ;;3.0;PROSTHETICS;;Feb 09, 1996
EN1 ;entry point to ask patient
 I '$D(RMPR) D DIV4^RMPRSIT
 D GETPAT^RMPRUTIL Q:'$D(RMPRDFN)
EN ;entry point pass RMPRDFN
 ;return RMPRPRIN as ien of 665.4 if a selection is made, otherwise
 ;RMPRIN is PASSED BACK AS -1.
 I $G(RMPRDFN)'>0 S:$G(DFN)>0 RMPRDFN=DFN D:$G(DFN)'>0 EN1^RMPRUTL2
 I '$D(^RMPR(665.4,"AH",RMPRDFN)) W !!,$C(7),?5,"NO LETTERS FOR THIS PATIENT!" S RMPRIN=-1 Q
 N RMPRBDT,DIC,RI,DR,RB,DA,RMPLET,DIQ,Y,RO
 S (RMPRBDT,RI,RB,RO)=0,RMPRIN=-1,DIC=665.4,DR=".01;1;2;4;11",DIQ="RMPRLET"
 W !!,"#",?5,"Patient",?28,"Type of letter",?45,"Employee"
 W ?65,"Date of letter"
 W !,RMPR("L")
 F  S RMPRBDT=$O(^RMPR(665.4,"AH",RMPRDFN,RMPRBDT)) Q:RMPRBDT=""  D  Q:RO=1
 .;check for more than one letter per day
 .S DA=0
 .F  S DA=$O(^RMPR(665.4,"AH",RMPRDFN,RMPRBDT,DA)) Q:'DA  D  Q:RO=1
 ..S RI=RI+1,RI(RI)=DA D EN^DIQ1 Q:'$D(RMPRLET)
 ..S RB=RB+1
 ..W !,RI
 ..W ?5,RMPRLET(665.4,DA,.01),?28,$G(RMPRLET(665.4,DA,1))
 ..W ?45,$E($G(RMPRLET(665.4,DA,4)),1,15)
 ..W ?65,$G(RMPRLET(665.4,DA,2))_$G(RMPRLET(665.4,DA,11))
 ..K RMPRLET
 ..I RB>4&(RMPRIN<1) D ASK Q:RMPRIN>0  S RB=0
 G:$D(DTOUT)!($D(DUOUT)) EXIT
 I RMPRIN'>0 S:'RI(RI) RI=RI-1 D ASK Q
 G EXIT
 Q
ASK ;get record
 I RMPRBDT="",DA="" W !!,"End of Patient's Letter Listing."
 W !!,"Enter '^' to stop or "
 N DIR S DIR(0)="NO^1:"_RI_":0" D ^DIR
 I ($D(DTOUT))!($D(DUOUT)) S RO=1 Q
 I +Y>0 S RMPRIN=RI(Y),RO=1 Q
 Q
EXIT ;common exit point
 K DTOUT,DUOUT,RMPRBDT
 Q
