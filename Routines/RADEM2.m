RADEM2 ;HISC/CAH,FPT,GJC-Display Patient Demographics (short) ;10/20/94  09:18
 ;;5.0;Radiology/Nuclear Medicine;**31**;Mar 16, 1998
PAT Q:'$D(^DPT(RADFN,0))  S Y=^(0),RANME=$P(Y,"^"),RASEX=$P(Y,"^",2),RASSN=$$SSN^RAUTL,RADOB=$P(Y,"^",3),X1=DT,X2=RADOB D ^%DTC S RAGE=X\365.25
 S:$E(DT,4,7)=$E(RADOB,4,7) RAGE=RAGE+1 ; today is birthday
 S Y=RADOB D D^RAUTL S RADOB=Y
 N RAVETELI S RAVETELI=$$VETELI(RADFN)
 S RAVET=$P(RAVETELI,"^"),RAELIG=$P(RAVETELI,"^",2)
 I $D(^DPT(RADFN,.1)),^(.1)]"" D ^RASERV
DIS W @IOF,!,"           ***********    Patient Demographics   ***********",!
 W !?2,"Name         : ",$E(RANME,1,20) W:$D(RAWARD) ?37,"Currently is an inpatient."
 W !?2,"Pt ID        : ",RASSN W:$D(RAWARD) ?39,"Ward/Service: ",$E(RAWARD_"/"_RASER,1,25)
 W !?2,"Date of Birth: ",RADOB," (",RAGE,")" W:$D(RABED) ?39,"Bedsection  : ",RABED
 W !?2,"Veteran      : ",RAVET,?39,"Eligibility : ",$E(RAELIG,1,25)
 W !?2,"Sex          : ",$S(RASEX="M":"MALE",RASEX="F":"FEMALE",1:"Unknown") I $D(^RADPT(RADFN,1)) W !?2,"Narrative    : ",^(1)
 W !?2,"Other Allergies:",!?7,"'V' denotes verified allergy   'N' denotes non-verified allergy",!
 S DFN=RADFN D ALLERGY^RADEM I '$D(GMRAL) W !?20,"** No allergies on file. **" G ALER
 F I=1:1 Q:'$D(PI(I))  W:I#2 !?2,PI(I) W:I#2=0 ?40,PI(I)
 ;
ALER ;
 S RAPOP=0 I $D(^DPT(RADFN,.35)),$P(^(.35),"^") W !!?2,$C(7),"**** Patient has died ****",!!,"Do you want to continue? NO// " R X:DTIME S:"Nn"[X RAPOP=1
Q K RAWD,PI,RADOB,RAELIG,RAGE,RASSN,RAVET,I,VAIN,VAERR,X,Y Q:RAPOP  S RACONT="" G ^RADEM1
 ;
RADFN S DIC(0)="AEZMQ" D ^RADPA Q:Y<0  S RADFN=+Y G PAT
 ;
VETELI(DFN) ; Is this patient a veteran?  Does this patient have a
 ; primary eligibility code?
 ; RAELI=Primary Eligibility code <-> RAVET=Veteran (Yes/No)
 N RAELI,RAVET Q:DFN'=+DFN "Unknown^Unknown"
 I 'DFN!('$D(^DPT(DFN,0))#2) S (RAELI,RAVET)="Unknown"
 E  D
 . K VAEL,VAERR D ELIG^VADPT
 . S RAELI=$P($G(VAEL(1)),"^",2)
 . S RAELI=$S(RAELI]"":RAELI,1:"Unknown")
 . S RAVET=+$G(VAEL(4))
 . S RAVET=$S(RAVET:"Yes",'RAVET:"No",1:"Unknown")
 . K VAEL,VAERR
 . Q
 Q RAVET_"^"_RAELI
