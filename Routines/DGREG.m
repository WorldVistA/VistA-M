DGREG ;ALB/JDS,MRL/PJR/PHH-REGISTER PATIENT ; 8/24/05 1:40pm
 ;;5.3;Registration;**1,32,108,147,149,182,245,250,513,425,533,574,563,624,658**;Aug 13, 1993
START ;
EN D LO^DGUTL S DGCLPR=""
 N DGDIV
 S DGDIV=$$PRIM^VASITE
 S:DGDIV %ZIS("B")=$P($G(^DG(40.8,+DGDIV,"DEV")),U,1)
 I $P(^DG(43,1,0),U,39) S %ZIS="NQ",%ZIS("A")="Select 1010 printer: " D ^%ZIS Q:POP  S (DGIO(10),DGIO("PRF"),DGIO("RT"),DGIO("HS"))=ION,DGASKDEV="" I $E(IOST,1,2)'["P-" W !,$C(7),"Not a printer" G DGREG
 K %ZIS("B")
 I '$D(DGIO),$P(^DG(43,1,0),U,30) S %ZIS="N",IOP="HOME" D ^%ZIS I $D(IOS),IOS,$D(^%ZIS(1,+IOS,99)),$D(^%ZIS(1,+^(99),0)) S Y=$P(^(0),U,1) W !,"Using closest printer ",Y,! F I=10,"PRF","RT","HS" S DGIO(I)=Y
A D ENDREG($G(DFN))
 W !! S DIC=2,DIC(0)="ALEQM",DLAYGO=2 K DIC("S"),DIC("B") D ^DIC K DLAYGO G Q1:Y<0 S (DFN,DA)=+Y,DGNEW=$P(Y,"^",3) N Y D PAUSE^DG10 D BEGINREG(DFN) I DGNEW D NEW^DGRP
 ;
 ;; ask to continue if patient died - DG*5.3*563 - pjr 10/12/04
 S DOD="" I $G(DFN) S DOD=$P($G(^DPT(DFN,.35)),"^",1)
 I DOD S Y=DOD,DGPME=0 D DIED^DGPMV I DGPME K DFN,DGRPOUT G A
 ;
 D CIRN
 ;
 I +$G(DGNEW) D
 . ; query CMOR for Patient Record Flag Assignments if NEW patient and
 . ; display results.
 . I $$PRFQRY^DGPFAPI(DFN) D DISPPRF^DGPFAPI(DFN)
 ;
 D ROMQRY
 ;
 S (DGFC,CURR)=0
 D:'$G(DGNEW) WARN S DA=DFN,DGFC="^1",VET=$S($D(^DPT(DFN,"VET")):^("VET")'="Y",1:0)
 S %ZIS="N",IOP="HOME" D ^%ZIS S DGELVER=0 D EN^DGRPD I $D(DGRPOUT) D ENDREG($G(DFN)) D HL7A08^VAFCDD01 K DFN,DGRPOUT G A
 D HINQ^DG10
 I $D(^DIC(195.4,1,"UP")) I ^("UP") D ADM^RTQ3
 D REG^IVMCQ($G(DFN))  ; send financial query  
 G A1
 ;
RT I $D(^DIC(195.4,1,"UP")) I ^("UP") S $P(DGFC,U,1)=DIV D ADM^RTQ3
 Q
 ;
A1 W !,"Do you want to ",$S(DGNEW:"enter",1:"edit")," Patient Data" S %=1 D YN^DICN D  G H:'%,CK:%'=1 S DGRPV=0 D EN1^DGRP G Q:'$D(DA)
 .I +$G(DGNEW) Q
 .I $$ADD^DGADDUTL($G(DFN)) ;
 G CH
PR W !!,"Is the patient currently being followed in a clinic for the same condition" S %=0 D YN^DICN G Q:%=-1
 I '% W !?4,$C(7),"Enter 'Y' if the patient is being followed in clinic for condition for which",!?6,"registered, 'N' if not." G PR
 S CURR=% G SEEN
 ;
CK S DGEDCN=1 D ^DGRPC
CH S X=$S('$D(^DPT(DFN,.36)):1,$P(^(.36),"^",1)']"":1,1:0),X1=$S('$D(^DPT(DFN,.32)):1,$P(^(.32),"^",3)']"":1,1:0) I 'X,'X1 G CH1
CH1 S DA=DFN G PR:'$D(^DPT("ADA",1,DA)) W !!,"There is still an open disposition--register aborted.",$C(7),$C(7) G Q
SEEN W !!,"Is the patient to be examined in the medical center today" S %=1 D YN^DICN S SEEN=% G:%<0 Q I %'>0 W !!,"Enter 'Y' if the patient is to be examined today, 'N' if not.",$C(7) G SEEN
ABIL D ^DGREGG
ENR ; next line appears to be dead code.  left commented just to test.  mli 4/28/94
 ;S DE=0 F I=0:0 S I=$O(^DPT(DA,"DE",I)) Q:'I  I $P(^(I,0),"^",3)'?7N Q  D PR:'DE S L=+$P($S($D(^SC(L,0)):^(0),1:""),"^",1)
REG S (DIE,DIC)="^DPT("_DFN_",""DIS"",",%DT="PTEX",%DT("A")="Registration login date/time: NOW// "
 W !,%DT("A") R ANS:DTIME S:'$T ANS="^" S:ANS="" ANS="N" S X=ANS G Q:ANS="^" S DA(1)=DFN D CHK^DIE(2.101,.01,"E",X,.RESULT) G REG:RESULT="^"!('$D(RESULT)),PR3:'(RESULT#1) S Y=RESULT
 I (RESULT'="^") W "  ("_RESULT(0)_")"
 S DINUM=9999999-RESULT
 S (DFN1,Y1)=DINUM,APD=Y I $D(^DPT(DFN,"DIS",Y1)) W !!,"You must enter a date that does not exist.",$C(7),$C(7) G REG
 G:$D(^DPT("ADA",1,DA)) CH1 L @(DIE_DINUM_")"):2 G:'$T MSG S:'($D(^DPT(DA(1),"DIS",0))#2) ^(0)="^2.101D^^" S DIC(0)="L",X=+Y D ^DIC
 ;
 ;SAVE OFF DATE/TIME OF REGISTRATION FOR HL7 V2.3 MESSAGING, IN VAFCDDT
 S VAFCDDT=X
 ;
 S DA=DFN1,DIE("NO^")="",DA(1)=DFN,DP=2.101,DR="1///"_$S(SEEN=2:2,CURR=1:1,1:0)_";Q;2"_$S(CURR=1:"///3",1:"")_";2.1;3//"_$S($P(^DG(43,1,"GL"),"^",2):"",1:"/")_$S($D(^DG(40.8,+$P(^DG(43,1,"GL"),"^",3),0)):$P(^(0),"^",1),1:"")_";4////"_DUZ
 D EL K DIC("A") N DGNDLOCK S DGNDLOCK=DIE_DFN1_")" L +@DGNDLOCK:2 G:'$T MSG D ^DIE L -@DGNDLOCK
 I $D(DTOUT) D  G Q
 .K DTOUT
 .N DA,DIK
 .S DA(1)=DFN,DA=DFN1,DIK="^DPT("_DFN_",""DIS"","
 .D ^DIK
 .W !!?5,"User Time-out.  Required registration data could be missing."
 .W !,?5,"This registration has been deleted."
 ; check whether facility applying to (division) is inactive
 I '$$DIVCHK^DGREGFAC(DFN,DFN1) G CONT
ASKDIV W !!?5,"The facility chosen either has no pointer to an Institution"
 W !?5,"file record or the Institution file record is inactive."
 W !?5,"Please choose another division."
 S DA=DFN1,DIE("NO^")="",DA(1)=DFN,DP=2.101,DR="3" D ^DIE
 I $$DIVCHK^DGREGFAC(DFN,DFN1) G ASKDIV
CONT ; continue
 S DGXXXD=1 D EL^DGREGE I $P(^DPT(DFN,"DIS",DFN1,0),"^",3)=4 S DA=DFN,DIE="^DPT(",DR=".368;.369" D ^DIE S DIE="^DPT("_DFN_",""DIS"",",DA(1)=DFN,DA=DFN1
 S DA=DFN,DR="[DGREG]",DIE="^DPT(" D ^DIE K DIE("NO^")
 I $D(^DPT(DFN,"DIS",DFN1,2)),$P(^(2),"^",1)="Y" S DIE="^DPT(",DR="[DG EMPLOYER]",DA=DFN D ^DIE
 G ^DGREG0
PR2 W !!,"You can only enter new registrations through this option.",$C(7),$C(7) G REG
PR3 W !!,"Time is required to register the patient.",!!,$C(7),$C(7) G REG
H W !?5,"Enter 'YES' to enter/edit registration data or 'NO' to continue." G A1
Q K DG,DQ G Q1^DGREG0
Q1 K DGIO,DGASKDEV,DGFC,DGCLRP,CURR,DGELVER,DGNEW Q
EL S DR=DR_";13//" I $D(^DPT(DFN,.36)),$D(^DIC(8,+^(.36),0)) S DR=DR_$P(^(0),"^",1) Q
 S DR=DR_"HUMANITARIAN EMERGENCY" Q
FEE S DGRPFEE=1 D DGREG K DGRPFEE G Q1
 ;
WARN I $S('$D(^DPT(DFN,.1)):0,$P(^(.1),"^",1)']"":0,1:1) W !,$C(7),"***PATIENT IS CURRENTLY AN INPATIENT***",! H 2
 I $S('$D(^DPT(DFN,.107)):0,$P(^(.107),"^",1)']"":0,1:1) W !,$C(7),"***PATIENT IS CURRENTLY A LODGER***",! H 2
 Q
MSG W !,"Another user is editing, try later ..." G Q
 ;
BEGINREG(DFN) ;
 ;Description: This is called at the beginning of the registration process.
 ;Concurrent processes can check the lock to determine if the patient is
 ;currently being registered.
 ;
 Q:'$G(DFN) 0
 I $$QRY^DGENQRY(DFN) W !!,"Enrollment/Eligibility Query sent ...",!!
 L +^TMP(DFN,"REGISTRATION IN PROGRESS"):1
 I $$LOCK^DGENPTA1(DFN) ;try to lock the patient record
 Q
 ;
ENDREG(DFN) ;
 ;Description: releases the lock obtained by calling BEGINREG.
 ;
 Q:'$G(DFN)
 L -^TMP(DFN,"REGISTRATION IN PROGRESS")
 D UNLOCK^DGENPTA1(DFN)
 Q
 ;
IFREG(DFN) ;
 ;Description: tests whether the lock set by BEGINREG is set
 ;
 ;Input:  DFN
 ;Output:
 ;      Function Value = 1 if lock is set, 0 otherwise
 ;
 N RETURN
 Q:'$G(DFN) 0
 L +^TMP(DFN,"REGISTRATION IN PROGRESS"):1
 S RETURN='$T
 L -^TMP(DFN,"REGISTRATION IN PROGRESS")
 Q RETURN
 Q
CIRN ;MPI QUERY
 ;check to see if CIRN PD/MPI is installed
 N X S X="MPIFAPI" X ^%ZOSF("TEST") Q:'$T
 K MPIFRTN
 D MPIQ^MPIFAPI(DFN)
 K MPIFRTN
 Q
ROMQRY ;
 I +$G(DGNEW) D
 . ; query LST for Patient Demographic Information if NEW patient and
 . ; file into patient's record.
 . N A
 . I $$ROMQRY^DGROAPI(DFN) D
 . . ;display busy message to interactive users
 . .S DGMSG(1)="Data retrieval from LST site has been completed successfully"
 . .S DGMSG(2)="Thank you for your patience."
 . .D EN^DDIOL(.DGMSG) R A:5
 . E  D
 . . ;display busy message to interactive users
 . .S DGMSG(1)="Data retrieval from LST site has not been successful."
 . .S DGMSG(2)="Please continue the Registration Process."
 . .D EN^DDIOL(.DGMSG) R A:5
 . ;
 Q
