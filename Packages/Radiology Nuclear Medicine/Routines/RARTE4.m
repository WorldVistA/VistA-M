RARTE4 ;HISC/GJC - Edit/Delete Reports (cont) ;11/4/97  08:02
 ;;5.0;Radiology/Nuclear Medicine;**15,27,41,82,56**;Mar 16, 1998;Build 3
 ;Supported IA #10060 ^VA(200
 ;Supported IA #10007 DO^DIC1
LOCK ;Try to lock next avail IEN, if locked - fail, if used - increment again
 S I=I+1 S RAXIT=$$LOCK^RAUTL12("^RARPT(",I) I RAXIT D UNLOCK2 D INCRPT G START^RARTE
 I $D(^RARPT(I))!($D(^RARPT("B",I))) D UNLOCK^RAUTL12("^RARPT(",I) G LOCK
 S ^RARPT(I,0)=RARPTN,RARPT=I,^(0)=$P(^RARPT(0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)#2:DUZ,1:0),"^RARPT(")=I S:'$D(^RARPT(RARPT,"T")) ^("T")=""
 S ^RARPT(RARPT,0)=RARPTN_"^"_RADFN_"^"_RADTE_"^"_RACN_"^D",DIK="^RARPT(",DA=RARPT D IX1^DIK
 K %,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 S DIE="^RADPT("_RADFN_",""DT"","_RADTI_",""P"","
 S DR="17////"_RARPT D ^DIE
 K %,D,D0,DA,DI,DIC,DIE,DQ,DR,RAY1,X,Y
 I RAPRTSET D PTR^RARTE2
 I RAXIT D UNLOCK2,UNLOCK^RAUTL12("^RARPT(",RARPT) Q
 G IN0
IN ;lock rpt for the 1st time if editing existing rpt
 S RAXIT=$$LOCK^RAUTL12("^RARPT(",RARPT) I RAXIT D UNLOCK2,Q Q
IN0 ;skip to here if rpt created in this session and already locked
 G IN1:'$P(RAMDV,"^",14) K RACOPY
 S DIC("S")="I RARPT'=+Y,$P(^(0),U,5)'=""X""" ;omit same & deleted rpt
 ; Remedy ticket #245679, remove multi-index lookup
 S DIC("A")="Select Report to Copy: ",DIC(0)="AEQ",DIC="^RARPT("
 D DICW,^DIC K DIC("S"),DIC("A") S RAY1=Y
 I X="^" D UNLOCK^RAUTL12("^RARPT(",RARPT),UNLOCK2 S RAXIT=$$EN3^RAUTL15(RARPT) D INCRPT G START^RARTE
 G IN1:RAY1<0
 F J="H","R","I" K ^RARPT(RARPT,J)
 F J="R","I" F I=1:1 Q:'$D(^RARPT(+Y,J,I,0))  S ^RARPT(RARPT,J,I,0)=^(0)
 ;F I=1:1 Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",1,"H",I,0))  S ^RARPT(RARPT,"H",I,0)=^RADPT(RADFN,"DT",RADTI,"P",1,"H",I,0)
 S RACOPY=""
IN1 ;skip to here if div param disallows rpt copying
 I $P(RAMDV,"^",14) W !,RAI
 K RAFIN
 S DR="50///"_RACN
 S DR(2,70.03)="12//^S X=$S($D(RARES)&($D(RABTCH)):RARES,1:"""");S:$D(^VA(200,+X,0)) RARES=$P(^(0),U);I X'>0 S Y=""@15"";70;@15;15"
 I $P(RAMDV,"^",28) S DR(2,70.03)=DR(2,70.03)_"R" ; req'd for DIVISION
 S DR(2,70.03)=DR(2,70.03)_"//^S X=$S($D(RASTFF)&($D(RABTCH)):RASTFF,1:"""");S:$D(^VA(200,+X,0)) RASTFF=$P(^(0),U);I X'>0 S Y=""@1"";60;@1;S RAFIN="""""
 S DA(1)=RADFN,DA=RADTI,DIE="^RADPT("_DA(1)_",""DT""," D ^DIE K DE,DQ
 D ELOC^RABWRTE ; Billing Aware -- ask Inter. Img Loc
 I RAPRTSET S RADRS=2 D COPY^RARTE2 ; copy resid and staff
 G PRT:'$D(RAFIN) W !,RAI
 ;
 ; **BNT - Commented out to stop copying history from file 70 to 74
 ; in patch RA*5*27.  The history is now referenced directly from file 70.
 ; I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H")),'$D(^RARPT(RARPT,"H")) F I=1:1 Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",I,0))  S ^RARPT(RARPT,"H",I,0)=^(0)
 ; **
 I '$D(RACOPY),$P(RAMDV,"^",12) D STD^RARTE1 I X="^" G PRT
 W !,RAI D EDTRPT^RARTE1
PRT D UNLOCK^RAUTL12(RAPNODE,RACNI)
 ; --- copy diags to other cases of print set
 I RAPRTSET S RADRS=1,RAXIT=0 D COPY^RARTE2 L -^RADPT(RADFN,"DT",RADTI) ;unlock dt level only after copying is done
 ; wait til report has been checked for completeness before unlocking it
 S RAXIT=$$EN3^RAUTL15(RARPT) D UNLOCK^RAUTL12("^RARPT(",RARPT)
 I RAXIT S RAXIT=0 D UNLOCK2 D INCRPT G START^RARTE
 ; ---
 D  K RAAB G PRT1:'$D(RABTCH),PRT1:'$D(^RABTCH(74.2,+RABTCH,0))
 .; RAHLTCPB flag is inactive
 .N RAHLTCPB S RAHLTCPB=1 D:$S('$D(RACT):0,RACT="V":1,1:0) UPSTAT^RAUTL0
 .D:$S('$D(RACT):1,RACT'="V":1,1:0) UP1^RAUTL1
ASKREP W !!,"Do you want to place this report in the batch ",RABTCHN,"? Yes// " R X:DTIME S:'$T!(X["^") X="N" S:X="" X="Y" G PRT1:"Nn"[$E(X)
 I "Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to place this report in the batch, or 'NO' not to." G ASKREP
 I $D(^RABTCH(74.2,"D",RARPT,RABTCH)) W !?5,"...report is already part of the '",RABTCHN,"' batch" D INCRPT G START^RARTE
 W !?5,"...will now place report in the '",RABTCHN,"' batch" S DIE="^RABTCH(74.2,",DA=RABTCH,DR="25///"_$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN,DR(2,74.21)="2////N" D ^DIE K DQ,DE D INCRPT G START^RARTE
PRT1 R !!,"Do you wish to print this report? No// ",X:DTIME S:'$T!(X["^") X="N" S:X="" X="N" ;030497
 I "Nn"[$E(X) D INCRPT G START^RARTE
 I "Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to print this report, or 'NO' not to." G PRT1
 S ION=$P(RAMLC,"^",10),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 S RAMES="W !!?3,""Report has been queued for printing on device "",ION,""."""
 D Q^RARTR D INCRPT G START^RARTE
 ;
Q I $D(RABTCH),$D(^RABTCH(74.2,+RABTCH,"R",0)) D ASKPRT^RARTE1,BTCH^RABTCH:"Yy"[$E(X)
Q1 K %,%DT,%W,%Y,%Y1,C,D0,D1,DA,DIC,DIE,DR,OREND,RABTCH,RABTCHN,RACN,RACNI,RACOPY,RACS,RACT,RADATE,RADFN,RADTE,RADTI,RADUZ,RAELESIG,RAFIN,RAHEAD,RAI,RAJ1
 K RALI,RALR,RANME,RANUM,RAOR,RAORDIFN,RAPNODE,RAPRC,RAPRIT,RAQUIT,RAREPORT,RARES,RARPDT,RARPT,RARPTN,RARPTZ,RARTPN,RASET,RASI,RASIG,RASN,RASSN,RAST,RAST1,RASTI,RASTFF,RAVW,XQUIT,W,X,Y
 K D,D2,DDER,DI,DIPGM,DLAYGO,J,RAEND,RAF5,RAFL,RAFST,RAIX,RAPOP,RAY1
 K ^TMP($J,"RAEX")
 K POP,DUOUT
 Q
DICW ; Build DIC("W") string
 N DO D DO^DIC1
 S DIC("W")=$S($G(DIC("W"))]"":DIC("W")_" ",1:"")_"W ""   "",$$FLD^RARTFLDS(+Y,""PROC"")"
 Q
INCRPT ; Kill extraneous variables to avoid collisions.
 ; Incomplete report information, select another case #.
 K %,%DT,D,D0,D1,D2,DI,DIC,DIWT,DN,I,J,RACN,RACNI,RACT,RADATE,RADTE
 K RADTI,RAFIN,RAI,RALI,RALR,RANME,RAPRC,RARPT,RARPTN,RASSN,RAST,RAVW,X
 Q
UNLOCK2 D UNLOCK^RAUTL12(RAPNODE,RACNI) L -^RADPT(RADFN,"DT",RADTI)
 Q
