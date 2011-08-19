DGMTP ;ALB/RMO,CAW,EG - Print Means Test 10-10F ; 03/07/2005
 ;;5.3;Registration;**45,300,610**;Aug 13, 1993
 ;
EN ;Entry point to select a means test to print
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S DFN=+Y
 ;
DT S DIC("A")="Select DATE OF TEST: "
 I $D(^DGMT(408.31,+$$LST^DGMTU(DFN,"",DGMTYPT),0)),"^1^3^"'[("^"_$P(^(0),"^",3)_"^") S DIC("B")=$P(^(0),"^")
 S DIC("S")="I $P(^(0),U,2)=DFN,""^1^3^""'[(U_$P(^(0),U,3)_U)"
 S DIC="^DGMT(408.31,",DIC(0)="EQ" W ! D EN^DGMTLK K DIC G Q:Y<0
 S DGMTI=+Y,DGMTDT=$P(Y,"^",2)
 ;
DEV ;Ask device
 S DGPGM="START^DGMTP",DGVAR="DFN^DGMTI^DGMTDT^DGMTYPT"
 ;
 ;added code to not allow a slave printer to be selected
 ;eg 03/07/2005
 W !!,*7,"THIS OUTPUT REQUIRES 132 COLUMN OUTPUT TO THE PRINTER."
 W !,"DO NOT SELECT A SLAVE DEVICE FOR QUEUED OUTPUT.",!
 S %ZIS="QM",%ZIS("S")="I $P($G(^(1)),U)'[""SLAVE""&($P($G(^(0)),U)'[""SLAVE"")",%ZIS("B")="",IOP="Q"
 D ZIS^DGUTQ
 I POP D  G Q
 . I $D(IO("Q")) K IO("Q")
 . U 0 W !,"Print request cancelled!"
 . Q
 I IO=IO(0),$E(IOST,1,2)="C-" W !,*7,"CANNOT QUEUE TO HOME DEVICE!",! G DEV
 Q
 ;
START ;Entry point to print a means test
 ; Input  -- DFN     Patient IEN
 ;           DGMTDT  Date of Test
 ;           DGMTI   Annual Means Test IEN
 ;           DGOPT   Registration Flag
 ;           DGMTYPT Type of Test 1=MT 2=COPAY
 ; Output -- Print of 10-10F
 U IO
 S DGUL=$S('($D(IOST)#2):"-",IOST["C-":"-",1:"_"),(DGLNE,DGLNE1)="",$P(DGLNE,"=",131)="",$P(DGLNE1,DGUL,131)=""
 D ALL^DGMTU21(DFN,"V",DGMTDT,"IPR",$S($G(DGMTI):DGMTI,1:""))
 G Q:'$D(DGINC("V"))!('$D(DGINR("V")))!('$D(DGREL("V")))
 S DGVPRI=+DGREL("V"),DGVINI=DGINC("V"),DGVIRI=DGINR("V")
 S DGLY=$$LYR^DGMTSCU1(DGMTDT) D PAR^DGMTSCU G Q:DGMTPAR=""
 D SET^DGMTSCU2,SET^DGMTSC31
 S DGMT0=$G(^DGMT(408.31,DGMTI,0))
 D EN^DGMTP1
 ;
Q K DGCAT,DGDC,DGDCS,DGDEP,DGDET,DGFL,DGIN0,DGIN1,DGIN2,DGINC,DGINR,DGINT,DGINTF,DGLNE,DGLNE1,DGLP,DGLY,DGMT0,DGMTPAR,DGMTS,DGNC,DGND,DGNWT,DGNWTF,DGPGE,DGPGM,DGREL,DGSP,DGTYC,DGTHA,DGTHB,DGUL,DGVINI,DGVIRI,DGVIR0,DGVPRI
 K DTOUT,DUOUT,POP,X,Y
 I '$D(DGOPT) K DFN,DGMTDT,DGMTI W ! D CLOSE^DGUTQ
 Q
 ;
HD ;Print header
 W @IOF,!,$$NAME^DGMTU1(DGVPRI),?116,$$SSN^DGMTU1(DGVPRI),!,DGLNE
 Q
 ;
FT ;Print footer
 N Y,%
 W !,DGLNE S Y=+DGMT0 X ^DD("DD") W !,"Date of Test: ",Y
 S Y=$P(DGMT0,"^",7) X ^DD("DD") W ?31,"Completion Date/time: ",Y
 ;
 ; retrieve who completed the means test and print initials
 N X,INI S X=$P(DGMT0,U,6),INI=""
 I X'="" S INI=$$GET1^DIQ(200,X,1)
 I INI'="" S INI=INI_"/"_X
 W ?75,"By: ",INI
 ;
 D NOW^%DTC S Y=% X ^DD("DD") W ?98,"Printed: ",Y
 W !!!!,"VA FORM 10-10F",?120,"PAGE ",DGPGE
 W:DGPGE=2 @IOF
 Q
