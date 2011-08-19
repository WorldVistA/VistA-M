FBCHPRC1 ;AISC/DMK-PRINT REPORT OF CONTACT CONT ;08/02/88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 W ?70,"Page ",FB("PG"),!
 W ?40,L,?58,L,!,?8,">>  REPORT  OF  CONTACT  <<",?40,L,$E(FBSITE,1,18),?58,L,?60,$P(VADM(2),"^",2),!,?40,L,$E(FBSITE,19,30),?58,L,"DOB: ",$P(VADM(3),"^",2),!,Q,!,?3," Name of Veteran",?34,L,"Telephone No. of Vet.",?58,L,"Date of Contact",!
 W ?34,L,?58,L,!,?3,$E(VADM(1),1,30),?34,L,VAPA(8),?58,L,?61,FB(4),!,Q,!,?3," Address of Veteran",?58,L,"Type of Contact",!,?3,VAPA(1),?58,L,!,?3,VAPA(4),",",$P(VAPA(5),"^",2)
 W " ",$S('+$G(VAPA(11)):VAPA(6),$P(VAPA(11),U,2)]"":$P(VAPA(11),U,2),1:VAPA(6)),?58,L
 W ?63,$S(FB(6)="T":"Telephone",1:"Personal"),!,Q,!,?3," Person Contacted",?58,L,"Telephone Number of",!,?3,FB(7),?58,L,"  Person Contacted",!,?3,FB(8),?58,L,?61,FB(18)
 W !?3,$S(FB(9)]"":FB(9),1:FB(10)_", "_$S(FB(11)="":"Unknown",$D(^DIC(5,FB(11),0)):$P(^(0),"^"),1:"Unknown")_", "_FB(12)) I FB(9)="" W !,Q
 I FB(9)]"" W !?3,FB(10),", ",$S($D(^DIC(5,+FB(11),0)):$P(^(0),"^"),1:"Unknown"),", ",FB(12),!,Q
 W !?15,"NOTIFICATION OF ADMISSION TO PRIVATE HOSPITAL",!?14,$E(Q,1,47)
 W !?3,"AUTHORIZATION FROM DATE/TIME: ",FB(5),!?3,"DATE/TIME OF ADMISSION: ",FB(19),!?9,"NAME of HOSPITAL: ",FBVEN,!?18,"ADDRESS: ",FBVEN(1),?54,"PHONE: ",FBVEN(6),!?27,$S(FBVEN(2)]"":FBVEN(2),1:FBVEN(3)_", "_FBVEN(4)_" "_FBVEN(5))
 I FBVEN(2)]"" W !?27,FBVEN(3),", ",FBVEN(4)," ",FBVEN(5)
 W !?9,"PHYSICIAN'S NAME: ",$S(FB(13)="":"Not Entered",1:FB(13))
 W ?50,"PHONE: ",FB(14)
 W !?6,"TENTATIVE DIAGNOSIS: ",FB(15),!?11,"INSURANCE TYPE: ",FB(16),!?3,"MODE of TRANSPORTATION: ",FB(17)
 W !,?3,"ELIGIBILITY: ",$P(VAEL(1),"^",2),", " I $O(VAEL(1,0)) F J=0:0 S J=$O(VAEL(1,J)) Q:J'>0  S X=$P(VAEL(1,J),"^",2)_", " W:$X+$L(X)>80 !,?16 W X
 W !,Q D RPTC^FBCHPRC
BOT W ! S BOT=IOSL-($Y+11) F BT=1:1:BOT W !
 W ?3,"APPROVED/DISAPPROVED",!!?2,"______________________"
 W !?3,$$SIGBLK^FBAAPRC($P(FB1(0),U,6))
 W !,Q,!,?6,"Division or Section",?40,L,"   Executed by(signature and title)",!,?7,"FEE BASIS SECTION",?40,L,"   ",!,Q,!?3,"VA form 119C"
 Q
