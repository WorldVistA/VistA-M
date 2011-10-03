DPTLK3 ;ALB/RMO - MAS Patient Look-up Check for Duplicates ; 22 JUN 87 1:00 pm
 ;;5.3;Patient File;**73,197,633**;Aug 13, 1993
 I $D(DDS) D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X DDXY
 I '$D(DPTX)!('$D(DPTIDS(.03)))!('$D(DPTIDS(.09))) W !?3,*7,"Unable to search for potential duplicates, Date of Birth and",!?3,"Social Security Number must be defined." S DPTDFN=-1 G Q
EP2 ; -- Entry point 2
 S DPTNM=DPTX,DOB=DPTIDS(.03),SSN=DPTIDS(.09),(DPTKD,DPTKS)=0 W ! W:'$D(DDS) !?3 W "...searching for potential duplicates" D ^DPTDUP I 'DPTD W !!?3,"No potential duplicates have been identified." S DPTDFN=1 G Q
 W ! W:'$D(DDS) !?3 W *7,"The following patients have been identified as potential duplicates:",! F Y=0:0 S Y=$O(DPTD(Y)) Q:'Y  W !?5,$P(^DPT(Y,0),U) X "N DDS X DIC(""W"")"
 ;
ASKADD W !!?3,"Do you still want to add '",DPTX,"' as a new patient" S %=2 D YN^DICN S DPTDFN=$S(%<0!(%=2):-1,%=1:1,1:0) I 'DPTDFN W !!?6,"Enter 'YES' to add new patient, or 'NO' not to." G ASKADD
 ;
Q K DOB,DPTD,DPTKD,DPTKS,DPTNM,SSN
 Q
VAADV(DFN) ;Check if VA ADVANTAGE PLAN
 ;Returns 0, or 1 (VA ADVANTAGE PLAN)
 N DGARRY,DGVAADV,DGINS
 S (DGVAADV,DGINS)=0
 I $$INSUR^IBBAPI(DFN,,,.DGARRY,20) D
 . F  S DGINS=$O(DGARRY("IBBAPI","INSUR",DGINS)) Q:'DGINS  D  Q:+DGVAADV
 . . I +DGARRY("IBBAPI","INSUR",DGINS,20) S DGVAADV=1
 Q DGVAADV
