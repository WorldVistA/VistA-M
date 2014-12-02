DGVPP ;ALB/MTC - DG PRE-PRE-INIT DRIVER ; 05 JUN 87
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ; -- main entry point
 S XQABT1=$H
 D H^DGUTL S IOP="HOME" D ^%ZIS
 D USER,VERS:$D(DIFQ),DPT:$D(DIFQ),ALR:$D(DIFQ),ROU:$D(DIFQ)
 I $D(DIFQ) S DGVFLD=100 D PKG I $D(DIFQ),DGVCUR D EN^DGV53PP
 I '$D(DIFQ) W !!,"'DG' INITIALIZATION ABORTED!!" G Q
 S XQABT2=$H
ENQ Q
 ;
Q K DGVFLD,DGI,DGVCUR,DGVNEW,DGVNEWVR,DGVREQ,DGVREL,DGTIME,DGDATE,SDVCUR,DGER,DGDIU,J,ON
 K DFN,DGDAY,DGDJ,DGDOCFL,DGDOMB,DGENDT,DGSTDT,STIME,CT,CURPT,DMRG,I2,XCNP,XMZ,DPTIME,DGCFLBD,DGCFLCN,DGTOTBD,DGTOTCN
 Q
 ;
USER I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to initialize.",! K DIFQ
 Q
 ;
VERS ;Set-up variables for Current, New and Required versions of PIMS
 S DGVCUR=+$S($D(^DG(43,1,"VERSION")):^("VERSION"),1:"")
 S DGVREQ=$$REQ()
 S DGVREL=$$REL()
 S DGVNEWVR=$P($T(DGVPP+1),";",3),DGVNEW=+DGVNEWVR
 S SDVCUR=$S($D(^DG(43,1,"SCLR")):$P(^("SCLR"),"^",5),1:0)
 ;
 I DGVCUR,(DGVCUR<DGVREQ) D MSG G VERSQ
 ;
 I DGVCUR>DGVNEW W !!,"Current version (",DGVCUR,") is greater than this version (",DGVNEW,")." K DIFQ
VERSQ Q
 ;
REQ() ; -- release required
 Q 5.2
 ;
REL() ; -- this release's final version
 Q 5.3
 ;
MSG ;Print message if this version of PIMS can not be installed
 W !!,*7,"A search of your system indicates that the Version of the PIMS module which you",!,"are currently running on this system is Version ",DGVCUR,"."
 W !!,"This initialization requires that Version ",DGVREQ,", or higher, of the PIMS module be installed",!,"prior to installing this release."
 W !!,"If you do not have a copy of the necessary previous release(s) of MAS, which",!,"must be installed prior to this release of the module, please contact your",!,"local Information Systems Center for assistance." K DIFQ
 Q
 ;
DPT ;Check if DPTINIT has been installed prior to installing DG
 I $S('$D(^DG(48,DGVREL,"R")):1,$P(^("R"),"^",8)']"":1,1:0) W !!,"'DPTINIT' must be run before initializing 'DG'!!" K DIFQ
 Q
 ;
ALR ;Check if this version of PIMS has already been installed
 S %=1
 I DGVCUR=DGVNEWVR W !!,"YOU'VE ALREADY INSTALLED VERSION ",DGVNEW," ONCE.",!,"DO YOU REALLY WANT TO REINSTALL" S %=2 D YN^DICN
 I '% W !!?3,"Enter 'YES' to reinstall, or 'NO' not to." G ALR
 K:%<0!(%=2) DIFQ
 Q
PKG ;Check other packages required for this version of PIMS
 I '$D(^ORD(100.99)) D
 .W !!,">>> You must install ORDER ENTRY/RESULTS REPORTING (OR*) before"
 .W !,"    running this installation.",!
 .K DIFQ
 ;
 N X S X="IBARXEU" X ^%ZOSF("TEST") I '$T D
 .W !!,">>> Copay-Exemption patches must be installed before running"
 .W !,"    this installation. Patches: IB*1.5*9"
 .W !,"			     DG*5.2*22"
 .W !,"			     SD*5.2*9"
 .W !,"			     PRCA*3.7*8"
 .K DIFQ
 ;
 I '$D(^HL(770,0)) D
 .W !!,">>> You must install the DHCP HL7 package before running this"
 .W !,"    installation.",!
 .K DIFQ
 Q
 ;
ROU ;Check compiled routine size parameter
 I $G(^DD("ROU"))<4000 D  K DIFQ
 .W !!,*7,"Your FileMan compiled routine size parameter [^DD(""ROU"")] is too small."
 .W !,"It is currently set to '",+^DD("ROU"),"'."
 .W !!,"Please use ^DIEZ to reset this value to 4000 or higher."
 Q
 ;
LINE ; -- write separator line
 N X
 S $P(X,"_",81)="" W !,X
 Q
