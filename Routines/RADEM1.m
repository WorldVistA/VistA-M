RADEM1 ;HISC/GJC-Display Patient Demographics ;4/19/96  08:17
 ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
EXAM D HDR S RAXIT=0
 S X1=DT,X2=-7 D C^%DTC S RACHKDT=X,X1=DT,X2=-3 D C^%DTC S RACHKDT1=X
 S (RADTE,RASEQ)=0 F RADTI=0:0 Q:(RASEQ>4)&(RADTE<RACHKDT)!RAXIT  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0!RAXIT  I $D(^(RADTI,0)) S Y=^(0),RALOC=+$P(Y,"^",4),(RADTE,Y)=+Y Q:(RASEQ>4)&(RADTE<RACHKDT)  D D^RAUTL S RADATE=Y D RACN
 I $G(RAXIT) G Q
 D ORDER ;Check for outstanding orders
 W:'RASEQ !!?5,"No registered exams filed for this patient.",!
 W:$D(RABARFL) !?2,"  *Exam with Barium performed in last 7 days."
 W:$D(RAORFL) !?2," **Oral Cholecystographic medium used in last 7 days."
 I $D(RACNFL) D
 .N DIWF,DIWL,DIWR,DIWT,X K ^UTILITY($J,"W")
 .S:'$D(RAZDFN)#2 X="***Exam with contrast media performed in last 3 days."
 .S:$D(RAZDFN)#2 X="***Exam with "_$$CM(RAZDFN,RAZDTI,RAZCNI)_" performed in last 3 days."
 .S DIWL=3,DIWF="C60" D ^DIWP,^DIWW ;UTILITY($J,"W") killed in DIWW
 .Q
 I '$D(RACONT),('+$G(RAXIT)) R !!,"Press <RETURN> key to continue.",X:DTIME
Q K %,%H,DIC,POP,RACNFL,RAORFL,RACODE,RACONT,RABAR,RABARFL,RACHKDT,RACHKDT1,RACN,RACNI,RADATE,RADTE,RADTI,RAPR1,RAPRI,RASEQ,RAST,RASTI,RAXIT,RAZDFN,RAZDTI,RAZCNI Q
 ;
RACN S RALOC=$S($D(^RA(79.1,RALOC,0)):$P(^(0),"^"),1:"") S RALOC=$S($D(^SC(+RALOC,0)):$P(^(0),"^"),1:"Unknown")
 F RACNI=0:0 Q:(RASEQ>4)&(RADTE<RACHKDT)!RAXIT  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0!RAXIT  I $D(^(RACNI,0)) S Y=^(0) D PRT
 Q
 ;
PRT N RAESITY,RAITYPE
 S RAPRI=+$P(Y,"^",2),RAPR1=99 S:$D(^RAMIS(71,RAPRI,0)) RAPR1=$P(^(0),"^") S RABAR=0
 I $P(Y,U,10)="Y" D
 .I RADTE'<RACHKDT,($O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM","B",""))="B") S (RABAR,RABARFL)=1,RACODE="  *"
 .I RADTE'<RACHKDT,(+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM","B","C",0))>0) S (RABAR,RAORFL)=1,RACODE=" **"
 .I RADTE'<RACHKDT1 D
 ..S (RABAR,RACNFL)=1,RACODE="***"
 ..I +$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",0)) S RAZDFN=RADFN,RAZDTI=RADTI,RAZCNI=RACNI
 ..Q
 .Q
 S RASTI=+$P(Y,"^",3)
 S RAST=$S($D(^RA(72,RASTI,0)):$P(^(0),"^"),1:"Unknown")
 S RAESITY=+$P($G(^RA(72,RASTI,0)),U,7)
 S RAITYPE=$P($G(^RA(79.2,RAESITY,0)),U)
 S RAITYPE=$S(RAITYPE]"":RAITYPE,1:"Unknown")
 S RACN=$S($D(^RA(72,"AA",RAITYPE,9,RASTI)):"",1:+Y)
 ; flag if print set and if lowest case of set
 N RAPRTSET,RAMEMLOW,RADISP D EN1^RAUTL20
 S RADISP=$S(RAMEMLOW&(RAPRTSET):"+",RAPRTSET:".",1:" ")
 S RASEQ=RASEQ+1 W:RASEQ<6!(RABAR) !,RACN,?6,RADISP,?7,$S(RABAR:RACODE,1:""),?10,$E(RAPR1,1,28),?39,$E(RADATE,1,11),?51,$E(RAST,1,12),?67,$E(RALOC,1,12)
 I $E(IOST,1,2)="C-",($Y>(IOSL-4)) D
 . N DIR S DIR(0)="E" D ^DIR S RAXIT=$S(Y'>0:1,1:0)
 . I 'RAXIT W @IOF D HDR
 . Q
 Q
ORDER ; Check for pat rad orders before registering a patient in rad
 ; Created by GJC@1/3/94
 N RALP,RA751,DIROUT,DIRUT,DTOUT,DUOUT S (RALP,RAXIT)=0
 F  S RALP=$O(^RAO(75.1,"B",RADFN,RALP)) Q:RALP'>0!(RAXIT)  D
 . Q:$D(^RADPT("AO",RALP,RADFN))\10  ;Check for entry in file 70.
 . Q:+$P($G(^RAO(75.1,RALP,0)),U,5)<3
 . S RA751(0)=$G(^RAO(75.1,RALP,0)),RA751(2)=$P(RA751(0),U,2)
 . S RA751(16)=$P(RA751(0),U,16),RA751(20)=$P(RA751(0),U,20)
 . S RA751(5)=+$P(RA751(0),U,5) Q:RA751(5)=1  ;GJC@4/4/94 Cancelled xam
 . S Y=RA751(2),C=$P($G(^DD(75.1,2,0)),U,2) D:Y]"" Y^DIQ S RA751(2)=Y
 . S Y=RA751(20),C=$P($G(^DD(75.1,20,0)),U,2) D:Y]"" Y^DIQ S RA751(20)=Y
 . W !?10,$E(RA751(2),1,28),?51,"Ord "
 . W $S(RA751(16)]"":$$FMTE^XLFDT(RA751(16),"2D"),1:"")
 . W ?67,$E(RA751(20),1,12) ; prints 'SUBMIT REQUEST TO' data
 . I $E(IOST,1,2)="C-",($Y>(IOSL-4)) D
 .. K DIR S DIR(0)="E" D ^DIR K DIR S:'+Y RAXIT=1
 .. I 'RAXIT W @IOF D HDR
 .. Q
 . Q
 Q
HDR ; Header
 ; Created by GJC@1/3/94
 ; The variable: RAOPT("ORDEREXAM") is defined in the entry action of
 ; the option RA ORDEREXAM.  It is subsequently kill in the exit action
 ; of the option.
 D HOME^%ZIS W:$D(RAOPT("ORDEREXAM"))#2 @IOF
 W !!,"Case #",?10,"Last 5 Procedures/New Orders",?39,"Exam Date",?51,"Status of Exam",?67,"Imaging Loc."
 W !,"------",?10,"----------------------------",?39,"---------",?51,"--------------",?67,"------------"
 Q
 ;
CM(RADFN,RADTI,RACNI) ;Return the contrast media used while performing an
 ;exam.
 ;Input: RADFN=patient DFN
 ;       RADTI=inverse date/time of exam
 ;       RACNI=IEN of an individual case
 ;Return: contrast media used with exam delimited by ', '.
 N I,X S X="",I=0
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",I)) Q:'I  D
 .S I(0)=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",I,0),U)
 .S X=X_$$EXTERNAL^DILFD(70.3225,.01,"",I(0))_", "
 .Q
 I $L(X,", ")'>2 S X=$P(X,", ")
 E  S X=$P(X,", ",1,($L(X,", ")-1))
 Q X
 ;
