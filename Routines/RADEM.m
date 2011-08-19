RADEM ;HISC/CAH AISC/MJK,RMO,DMK-Display Patient Demographics ;1/22/97  11:10
 ;;5.0;Radiology/Nuclear Medicine;**31**;Mar 16, 1998
PAT G Q:'$D(^DPT(RADFN,0)) S Y=^(0),RANME=$P(Y,"^"),RASEX=$S($P(Y,"^",2)="M":"MALE",$P(Y,"^",2)="F":"FEMALE",1:"Unknown"),RASSN=$$SSN^RAUTL,RADOB=$P(Y,"^",3),X1=DT,X2=RADOB D ^%DTC S RAGE=X\365.25
 S:$E(DT,4,7)=$E(RADOB,4,7) RAGE=RAGE+1 ;today is birthday
 S Y=RADOB D D^RAUTL S RADOB=Y
 ; obtain patient address data
 K VAERR,RAPA S DFN=RADFN,VAROOT="RAPA" D ADD^VADPT K VAROOT
 I VAERR D  ; Error, invalid DFN or corrupt ^DPT(DFN,0) node
 . F RAI=1:1:3 S RAPA(RAI)="Unknown"
 . S RATWN="Unknown",RAPA(8)="Unknown"
 . Q
 I 'VAERR D
 . S RATWN=$G(RAPA(4))_", "_$P($G(^DIC(5,+$G(RAPA(5)),0)),U,2)_" "_$G(RAPA(6))
 . Q
 N RAVETELI S RAVETELI=$$VETELI^RADEM2(RADFN)
 S RAVET=$P(RAVETELI,"^"),RAELIG=$E($P(RAVETELI,"^",2),1,25)
 S (RAMED,RAUSAL)="Unknown" S Y=$$ORCHK^GMRAOR(RADFN,"CM") S RAMED=$S(Y=1:"Yes",Y=0:"No",1:RAMED)
 I $D(^RADPT(RADFN,0)) S Y=^(0) D
 . S RAUSAL=$P($P(^DD(70,.04,0),$P(Y,"^",4)_":",2),";")
 . S:RAUSAL']"" RAUSAL="Unknown"
 . Q
 I $D(^DPT(RADFN,.1)),^(.1)]"" D ^RASERV
DIS D HOME^%ZIS W @IOF,"               ***********    Patient Demographics   ***********",!
 W !?2,"Name         : ",$E(RANME,1,20),?40,"Address: ",?50,$G(RAPA(1))
 W !?2,"Pt ID        : ",RASSN,?38,$S($G(RAPA(9))]"":"(temporary)",1:""),?50,$G(RAPA(2))
 W !?2,"Date of Birth: ",RADOB,?50,$G(RAPA(3))
 W !?2,"Age          : ",RAGE,?50,$G(RATWN)
 W !?2,"Veteran      : ",RAVET W:$D(RAWARD) ?40,"Currently is an inpatient."
 W !?2,"Eligibility  : ",RAELIG W:$D(RAWARD) ?42,"Ward       : ",RAWARD
 W !?2,"Exam Category: ",RAUSAL W:$D(RASER) ?42,"Service    : ",RASER
 W !?2,"Sex          : ",RASEX W:$D(RABED) ?42,"Bedsection : ",RABED
 W !?2,"Phone Number : ",$G(RAPA(8))
 I $D(^RADPT(RADFN,1)) W !?2,"Narrative    : ",^(1)
 W !!?2,"Contrast Medium Reaction: ",RAMED
 W !,?2,"Other Allergies:",!?7,"'V' denotes verified allergy   'N' denotes non-verified allergy",!
 S DFN=RADFN D ALLERGY I '$D(GMRAL) W !?20,"** No allergies on file **" G Q
 S RAXIT=0 F I=1:1 Q:'$D(PI(I))!RAXIT  D
 . W:I#2 !?2,PI(I) W:I#2=0 ?40,PI(I)
 . I $E(IOST,1,2)="C-",($Y>(IOSL-7)),$D(PI(I+1))#2,(I#2=0) D
 .. N DIR S DIR(0)="E" D ^DIR S RAXIT=$S(Y'>0:1,1:0) Q:RAXIT
 .. W @IOF,!,?2,"Other Allergies:",!?7,"'V' denotes verified allergy   'N' denotes non-verified allergy",!
 .. Q
 . Q
 I RAXIT G Q^RADEM1
Q I $D(^DPT(RADFN,.35)),$P(^(.35),"^") W !!?2,$C(7),"**** Patient has died ****" H 3
 K %,%H,POP,RATWN,RASEX,RAWD,PI,RADOB,RAELIG,RAGE,RAI,RAMED,RANME,RAPA
 K RASER,RASSN,RAUSAL,RAVET,RAWARD,ST,I,VAIN,VAERR,RABED,GMRAL G ^RADEM1
 ;
RADFN S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC K DIC Q:Y<0  S RADFN=+Y G PAT
 ;
ALLERGY ;get allergies DFN must be defined
 ;returns PI(CNT)
 S X="GMRADPT" X ^%ZOSF("TEST") Q:'$T
 N I,CNT
 Q:'$D(DFN)  D ^GMRADPT Q:'$D(GMRAL)
 S (I,CNT)=0
 F  S I=$O(GMRAL(I)) Q:'I  I $P(GMRAL(I),"^",2)]"" S CNT=CNT+1,PI(CNT)=$E($P(GMRAL(I),"^",2),1,35) D
 .S PI(CNT)=PI(CNT)_"("_$S($P(GMRAL(I),"^",4)=1:"V",1:"N")_")" Q
 Q
