DG10 ;ALB/MRL,DAK,AEG,PHH,TMK-LOAD/EDIT PATIENT DATA ; 08/26/08
 ;;5.3;Registration;**32,109,139,149,182,326,513,425,574,642,658,773**;Aug 13, 1993;Build 7
START ;
 D LO^DGUTL
 I $G(DGPRFLG)=1,$G(DGPLOC)=1 D  G Q:$G(DGRPOUT),A1
 .; D EN^DGRPD,REG^IVMCQ($G(DFN))
 . D EN^DGRPD
 . Q:$G(DGRPOUT)
 . D REG^IVMCQ($G(DFN))
 . D HINQ
 ;
A W !! K VET,DIE,DIC,CARD S DIC=2,DLAYGO=2,DIC(0)="ALEQM" K DIC("S") D ^DIC G Q:Y<0 S (DFN,DA)=+Y,DGNEW=$P(Y,"^",3) K DLAYGO
 N Y D PAUSE I DGNEW D NEW^DGRP S DA=DFN,VET=$S($D(^DPT(DFN,"VET")):^("VET")'="Y",1:0)
 ;
 ;MPI QUERY
 ;check to see if CIRN PD/MPI is installed
 N X S X="MPIFAPI" X ^%ZOSF("TEST") G:'$T SKIP
 K MPIFRTN
 D MPIQ^MPIFAPI(DFN)
 K MPIFRTN
 ;
 N DGNOIVMUPD
 S DGNOIVMUPD=1 ; Set flag to prevent MT Event Driver from updating converted IVM test
 I +$G(DGNEW) D
 . ; query CMOR for Patient Record Flag Assignments if NEW patient and
 . ; display results
 . I $$PRFQRY^DGPFAPI(DFN) D DISPPRF^DGPFAPI(DFN)
 ;
SKIP ;
 S DGELVER=0 D EN^DGRPD I $D(DGRPOUT) K DGRPOUT G A
 D HINQ,REG^IVMCQ($G(DFN)) G A1
 ;
HINQ ;
 S Y=$S($D(^DG(43,1,0)):^(0),1:0) I $P(Y,U,27) S X="DVBHQZ4" X ^%ZOSF("TEST") I $T D
 .N DGROUT
 .S DGROUT=X
 .I $G(DFN) D
 ..N X,Y,DGRP
 ..F X=.3,.32 S DGRP(X)=$G(^DPT(DFN,X))
 ..W !,"     Money Verified: " S Y=$P(DGRP(.3),"^",6) X:Y]"" ^DD("DD") W $S(Y]"":Y,1:"NOT VERIFIED")
 ..W ?40,"   Service Verified: " S Y=$P(DGRP(.32),"^",2) X:Y]"" ^DD("DD") W $S(Y]"":Y,1:"NOT VERIFIED")
 .D @("EN^"_DGROUT) K Y Q  ;from dgdem0
 Q
 ;
 ;   SDIEMM is used as a flag by AMBCARE Incomplete Encounter Management 
 ;   to bypass the embossing routines when calling load/edit from IEMM
 ;
A1 D  G H:'%,CK:%'=1 S DGRPV=0 D EN1^DGRP,MT(DFN),CP G Q:$G(DGPRFLG)=1 G Q:$G(SDIEMM) G Q:'$D(DA),EMBOS
 .W !,"Do you want to ",$S(DGNEW:"enter",1:"edit")," Patient Data"
 .S %=1 D YN^DICN
 .I +$G(DGNEW) Q
 .I $$ADD^DGADDUTL($G(DFN)) ;
 ;
H W !?5,"Enter 'YES' to enter/edit registration data or 'NO' to continue without",!?5,"editing."
 G A1
 ;
CK S DGEDCN=1 D ^DGRPC,MT(DFN),CP
 G Q:$G(DGPRFLG)=1 G Q:$G(SDIEMM)
 I $G(DGER)[55 K DIR S DIR(0)="Y",DIR("A")="Do you wish to return to Screen #9 to enter missing Income Data? " D ^DIR K DIR
 ;G:Y ^DGRP9
 ;
EMBOS ;W ! D EMBOS^DGQEMA G A
 G A
 ;
 ;
Q K X,Y,Z,DIC,DGELVER,DGNEW,DGRPV,VET Q
 ;
MT(DFN) ; Check if user requires a means test.  Ask user if they want to proceedif
 ; one is required
 I '$D(SDIEMM) DO
 .N DGREQF,DIV
 .D EN^DGMTR
 .I DGREQF D EDT^DGMTU(DFN,DT):$P($$MTS^DGMTU(DFN),U,2)="R"
 .Q
 I $D(SDIEMM) DO
 .N DGMTI
 .S DGMTI=$$LST^DGMTU(DFN,SCINF("ENCOUNTER"),1)
 .I $P(DGMTI,U,4)="R" D  I 1
 ..S DGMT0=$G(^DGMT(408.31,+DGMTI,0)),DGMTDT=$P(DGMT0,"^")
 ..I '$$OKTOCONT(DGMTDT) Q
 ..S DGMTI=+DGMTI,DGMTYPT=1,DGMTACT="COM",DGMTROU="COM^DGMTEO" D EN^DGMTSC
 .E  D WARNING
 .Q
 Q
 ;
WARNING ;
 ;prints a warning to the screen about means test
 ;
 W !!,"A means test for this encounter date was not found and may be required!"
 W !,"Further investigation will be needed."
 W !
 D PAUSE
 Q
 ;
PAUSE ;
 N DIR
 S DIR(0)="FAO",DIR("A")="Press ENTER to continue " D ^DIR
 Q
 ;
OKTOCONT(Y) ;
 ;
 N DIR
 W !!,"Patient Requires a means Test"
 X ^DD("DD")
 W !,"Primary Means Test Required from '",Y,"'",!
 ;
 I $D(SDIEMM),'$D(^XUSEC("SCENI MEANS TEST EDIT",DUZ)) DO  G OKQ
 .W !,$C(7),"You do not have the appropriate IEMM Security Key.  Contact your supervisor.",!
 .D PAUSE
 .S Y=0
 ;
 S DIR("A")="Do you wish to proceed with the means test at this time"
 S DIR("B")="YES"
 S DIR(0)="Y"
 D ^DIR
OKQ Q $S(Y=1:1,1:0)
 ;
CP ;If not (autoexempt or MTested) & no CP test this year then
 ;prompt for add/edit cp test
 N DIV,DGIB,DGIBDT,DGX,X,DIRUT,DTOUT
 G:'$P($G(^DG(43,1,0)),U,41) QTCP ;USE CP FLAG
 S DGIBDT=$S($D(DFN1):9999999-DFN1,1:DT)
 D EN^DGMTCOR
 I +$G(DGNOCOPF) S DGMTCOR=0
 I DGMTCOR D THRESH^DGMTCOU1(DGIBDT) D EDT^DGMTCOU(DFN,DT)
 K DGNOCOPF
QTCP Q
