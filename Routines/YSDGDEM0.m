YSDGDEM0 ;ALB/ASF,ALB/XAK-Patient Demographic Lookup (cont.) ;4/4/90  08:34 ;08/12/93 15:33
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;
 ;  Called by routine YSDGDEM
A ;
 S DFN=YSDFN D IN5^VADPT,INP^VADPT W !!,"Inpatient Status: " I VAIP(1)="" W "Not admitted" G SA
LOSS ;
 S (YSADM,YSADM(0),L,YSTRN,YSTRN(0),DIS)=0,YSNOW=$P($H,",",2)\60,YSNOW=YSNOW\60*100+(YSNOW#60)+1/10000+DT
YSADM ;
 S YSADM=VAIN(1),YSADMDT=$P(VAIN(7),U) G INP:YSADM'>0 S (YSTRN,YSTRN(0),DIS)=0
 G YSADM:YSADMDT>YSNOW!(YSADMDT<YSADM(0)) S YSADM(0)=^DGPM(YSADM,0)
L I VAIN(4)]"" S L=$P(VAIN(4),U)
YSTRN ;
 S YSTRN=VAIP(1),YSTRNDT=$P(VAIP(4),U) G YSADM:YSTRN="",YSTRN:YSTRNDT<YSTRN(0)!(YSTRNDT)>YSNOW S YSTRN(0)=^DGPM(YSTRN,0) I VAIP(5)]"" S L=$P(VAIP(5),U)
INP ;
 G DIS:'L W "Active",!,"Admitted: ",$P(VAIN(7),U,2),?30,"Ward: ",$P(VAIN(4),U,2),"  -"
 I $P(YSTRN(0),U,2)<6!($P(YSTRN(0),U,2)>9) W "On ward  Bed: ",$P(VAIP(6),U,2)
 E  W "Absent  Due: " W:VAIP(11)]"" $P(VAIP(11),U,2)
 I $D(^DPT("AS","S",YSDFN)) W !?26,"Seriously Ill"
 G SA
DIS ;
 S X1=$P(VAIP(17,1),U),X2=$P(VAIP(13),U) D ^%DTC
 W "Inactive",?28,"Discharged: ",$P(VAIP(17,1),U,2)," Type: ",$P(VAIP(17,4),U,2),?72,"LOS: ",X
SA ;
 I $D(^DIC(42,"ARSV",YSDFN)) S X=$O(^(YSDFN,0)) I X,$D(^DIC(42,X,"RSV",YSDFN,0)),$P(^(0),U,2)'<DT S L=$P(^(0),U,2) W !?18,"Scheduled Admission on ward ",$P(^DIC(42,X,0),U)," on ",$E(L,4,5),"/",$E(L,6,7),"/",$E(L,2,3)
CL ;
 G YSFA:'$O(^DPT(YSDFN,"DE",0)) W !!,"Currently enrolled in " S I=0 F  S I=$O(^DPT(YSDFN,"DE",I)) Q:'I  I $D(^(I,0)),$P(^(0),U,2)'="I" W:$X>60 !?22 W $S($D(^SC(+^(0),0)):$P(^(0),U)_", ",1:"")
 ;
YSFA ;
 S YSCT=0 W !!,"Future Appointments: " I '$O(^DPT(YSDFN,"S",DT)) W "NONE" G RMK
 W ?22,"Date",?34,"Time",?42,"Clinic",!?22 F I=22:1:75 W "="
 F YSFA=DT:0 S YSFA=$O(^DPT(YSDFN,"S",YSFA)) G RMK:'YSFA S L=^(YSFA,0),C=+L I $P(L,U,2)'["C" D YSCOV,YSCOV1 Q:YSCT>5
 I $O(^DPT(YSDFN,"S",YSFA)) W !,"See Scheduling options for additional appointments."
RMK ;
 W !!,"Remarks: ",$P(PTI(0),U,10) I $D(^DPT(YSDFN,.35)),^(.35)]"" W "  PATIENT HAS DIED."
 K Y,YSADM,YSTRN,DIS,YSSSN,YSFA,C,L,YSCOV,YSNOW,YSCT,PTI D WAIT^YSUTL Q
YSCOV ;
 S YSCOV=$S($P(L,U,7)=7:" (Collateral) ",1:""),YSCT=YSCT+1 Q
YSCOV1 ;
 S YSFDT=$$FMTE^XLFDT(YSFA,"5P")
 W !?22,$P(YSFDT," "),?34,$P(YSFDT," ",2),?42,$P($S($D(^SC(C,0)):^(0),1:""),U)," ",YSCOV Q
