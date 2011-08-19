DGMTDEL ;ALB/TET,RMO,CAW,LD,SCG - DELETE MEANS TEST for a Patient ;5/11/92  09:40
 ;;5.3;Registration;**33,45,182,344,407,433**;Aug 13, 1993
 ;
EN ;Entry point to delete means test
 I '$D(^XUSEC("DG MTDELETE",+DUZ)) W !!,"ACCESS TO THIS OPTION IS RESTRICTED!!",*7 G EXIT
 F I=1:1 S J=$P($T(TXT+I),";;",2) Q:J="END"  W !,J
 ; - if type of test = means test, diplay MT text
 I DGMTYPT=1 F I=1:1 S J=$P($T(MTTXT+I),";;",2) Q:J="END"  W !,J
 ; - if type of test = copay test, display CT text
 I DGMTYPT=2 F I=1:1 S J=$P($T(CTTXT+I),";;",2) Q:J="END"  W !,J
 ; - if type of test = LTC copay exemption test, display LTC text
 I DGMTYPT=4 F I=1:1 S J=$P($T(LTCTXT+I),";;",2) Q:J="END"  W !,J
 ;
LKP ;Patient lookup
 N DGMDOD,DGFLG
 D HOME^%ZIS S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G:$D(DTOUT)!($D(DUOUT))!(+Y<0) EXIT
 I '$O(^DGMT(408.31,"AD",DGMTYPT,+Y,0)) W !?5,$P(Y(0),U)," has no "_$S(DGMTYPT=1:"means",DGMTYPT=2:"copay",DGMTYPT=4:"LTC copay exemption",1:"")_" tests on file." K DIC,Y G LKP
 S DFN=+Y,DGNAM=$P(Y(0),U),DG0=Y(0) K DIC,Y
 I $P($G(^DPT(DFN,.35)),U)'="" S DGMDOD=$P(^DPT(DFN,.35),U)
 I $G(DGMDOD) W !,*7,"Patient died on: ",$$FMTE^XLFDT(DGMDOD,"1D") G EXIT
 W @IOF,"Name: ",$P(DGNAM,U),?40,"DOB: ",$$DATE^DGMTDEL1($P(DG0,U,3)),?60,"PT ID: ",$$PID^DGMTDEL1(DFN),!!!
 D DIS^DGMTU(DFN) W !!
VET ;determine if patient is a vet; set dgnvet flag (1=nonvet,0=vet)
 S DGNVET=0 ;,DGNVET=+$P($G(^DPT(DFN,.36)),U),DGNVET=$P($G(^DIC(8,DGNVET,0)),U,5),DGNVET=$S(DGNVET="N":1,1:0)
 S DGNVET=$S($P($G(^DIC(8,+$P($G(^DPT(DFN,.36)),U),0)),U,5)="N":1,1:0)
 I 'DGNVET S:$G(^DPT(DFN,"VET"))="N" DGNVET=1
 G:'DGNVET LKM ;Q
 S DIR("A")="Do you wish to delete all "_$S(DGMTYPT=1:"means",DGMTYPT=2:"copay",DGMTYPT=4:"LTC copay exemption",1:"")_" tests on file for this patient",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR G LKP:$D(DIRUT),LOOP^DGMTDEL1:Y
LKM ;Means test lookup
 S DIC("W")="D ID^DGMTDEL1",DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,19)=DGMTYPT"
 W ! S DIC="^DGMT(408.31,",DIC(0)="EQZ",X=DFN,D="C" D IX^DIC K DIC I X["?" W !,"Enter appropriate corresponding number." G LKM
 G LKP:$D(DTOUT)!($D(DUOUT))!(+Y<0)
 I DGMTYPT=1!(DGMTYPT=2) D  G:$G(DGFLG) LKP
 .I ('$P($G(^DG(408.34,+$P(Y(0),"^",23),0)),U,2))!('$P($G(^DGMT(408.31,+Y,"PRIM")),"^")) W !?5,*7,"This "_$S(DGMTYPT=1:"means",DGMTYPT=2:"copay")_" test is uneditable and cannot be deleted." S DGFLG=1
 I DGMTYPT=4 D  G:$G(DGFLG) LKP
 . I '$P($G(^DG(408.34,+$P(Y(0),"^",23),0)),U,2) W !,?5,*7,"This LTC Copay Exemption Test is uneditable and cannot be deleted." S DGFLG=1
 S DGMTI=+Y,DGMT0=Y(0) D VAR^DGMTDEL1 K DIC,Y
 S DIR("A")="Are you sure you want to delete the "_$$DATE^DGMTDEL1(DGMTD)_" test date",DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR G LKP:$D(DIRUT)!('Y) D DEL^DGMTDEL1 W !,$S(DGMTYPT=1:"Means",DGMTYPT=2:"Copay",DGMTYPT=4:"LTC copay exemption",1:"")_" test deleted."
 S DGMT=$$LST^DGMTU(DFN,"",DGMTYPT) I DGMTYPT=1,DGMT]"",$P(DGMT,U,2)<DGMTD D
 .Q:$P(DGMT,U,4)=$P(DGCAT,U,2)
 .W !,"Previous Means Test Category of '",$P(DGCAT,U),"'",!,"  has been changed to '",$P(DGMT,U,3),"'"
 .S DGMTACT="CAT",DGMTP=DGP,DGMTI=+DGMT D AFTER^DGMTEVT
 .S DGMTINF=0 D EN^DGMTEVT
EXIT K DFN,DGCAT,DGCT,DGI,DGN,DGNAM,DGNVET,DGP,DG0,DGMT,DGMTA,DGMTACT,DGMTD,DGMTI,DGMTINF,DGMTSRC,DGMTY,DGMT0,DGMTYPT,DGMTATYP
 K D,DA,DIC,DIE,DIK,DIR,DIRUT,DTOUT,DUOUT,DGMTA,DGMTP,I,J,VA,VADAT,VADATE,X,Y
 Q
 ;
TXT ;informational text displayed to user
 ;;
 ;;This option is used to delete financial test data which may have been
 ;;inadvertantly entered.  Under normal circumstances only individual
 ;;dates of test may be deleted using this option.  The exception is
 ;;non-veterans.  All financial tests found for a non-veteran may be
 ;;deleted.
 ;;END
MTTXT ;informational text displayed to user if type of test = means test
 ;;
 ;;A means test may not be deleted under the following conditions:
 ;;  1) The means test is an uploaded test from the IVM Center.
 ;;  2) The means test is a test that was done at the VAMC but has
 ;;     an associated uploaded means test from the IVM Center.
 ;;END
CTTXT ;informational text displayed to user if type of test = copay test
 ;;
 ;;A copay test may not be deleted under the following conditions:
 ;;  1) The copay test is an uploaded test from the IVM Center.
 ;;  2) The copay test is a test that was done at the VAMC but has
 ;;     an associated uploaded copay test from the IVM Center.
 ;;END
LTCTXT ;informational text displayed to user if type of test = LTC copay test
 ;;
 ;;A LTC copay exemption test may not be deleted under the following conditions:
 ;;  1) The LTC copay exemption test is an uploaded test from the IVM Center.
 ;;END
