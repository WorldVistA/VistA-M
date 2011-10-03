PSJPDIR ;BIR/MLM-PATIENT PROFILE CALLS ;10 MAY 96 / 9:56 AM
 ;;5.0; INPATIENT MEDICATIONS ;**53,111**;16 DEC 97
 ;
 ; Reference to ^DIC is supported by DBIA 10006
 ; Reference to ^DIR is supported by DBIA 10026
 ; Reference to ^VADPT is supported by DBIA 10061
 ;
GWP ; Ask for seletion by WARD GROUP,WARD or PATIENT.
 K PSJSEL,DIR S PSJSTOP="",DIR(0)="SAO^G:Ward Group;W:Ward;P:Patient",DIR("A")="Select by WARD GROUP (G), WARD (W), or PATIENT (P): "
 S DIR("?")="To select by PATIENT, enter a 'P'."
 S DIR("?",1)="To select the entire WARD GROUP, enter a 'G'."
 S DIR("?",2)="To select a single WARD, enter a 'W'."
 W !! D ^DIR K DIR S PSJSTOP=$S(Y="":1,Y<0:1,$$STOP:1,1:0)
 I 'PSJSTOP S PSJSEL("SELECT")=Y D @Y Q:($G(PSJSEL("WG"))="^OTHER")  G:PSJSTOP GWP D:PSJSEL("SELECT")'="P" RBPPN G:PSJSTOP GWP
 Q
 ;
P ;*** Select by Patient
 N PSJACNWP,PSGDICA,PSGPAT S PSJACNWP=""
 F PFLG=0:1 S:PFLG PSGDICA="another" D ^PSJP Q:PSGP<0  S PSJSEL("P",PSGP(0),PSGP)="" S:'$G(PSJPWDO) (PSGWD,PSJPWDO)=PSJPWD S PSGWD=$S('$G(PSGWD):0,PSJPWDO=PSJPWD:PSJPWD,1:0)
 S PSJSTOP=$S($D(DTOUT):1,$D(DUOUT):1,(Y<0)&'$D(PSGDICA):1,1:0)
 Q
 ;
W ;*** Select by WARD
 K DIC S DIC="^DIC(42,",DIC(0)="QEAMIZ",DIC("A")="Select a Ward: " W !! D ^DIC
 S PSJSTOP=$S(Y="":1,Y<0:1,$$STOP:1,1:0)
 I 'PSJSTOP S PSJSEL("W")=Y D ADMTM
 Q
 ;
G ;***Select by WARD GROUP
 K DIC S DIC="^PS(57.5,",DIC(0)="QEAMI",DIC("A")="Select a Ward Group: " W !! D ^DIC
 S PSJSTOP=$S(X="^OTHER":2,Y="":1,Y<0:1,$$STOP:1,1:0)
 ;I PSJSTOP=2 S PSJSTOP=0,PSJSEL("WG")="^OTHER" Q
 I PSJSTOP=2 S PSJSEL("WG")="^OTHER" Q
 I 'PSJSTOP S PSJSEL("WG")=Y
 Q
 ;
ADMTM ;*** Askif user want to sort by admin team
 N DIR S DIR(0)="YO",DIR("A")="Do you want to sort by Administration Team (Y/N)",DIR("B")="NO",DIR("?")="Enter ""YES"" to sort this report by Administration Team." W !! D ^DIR Q:$$STOP!'+Y
 ;
 ;*** Because "ALL" is not a team, must use DIR to include "ALL"
 ;    default and then call DIC to look up the selected team
 ;
 F  Q:$$STOP!(X="")!$D(PSJSEL("TM","ALL"))  D ADMTM2
 Q
ADMTM2 ;
 K DIR S DIR(0)="FAO",DIR("A")="Select Administration Team: ",DIR("B")="ALL",DIR("?")="^D TM2HLP^PSJPDIR,DICTM^PSJPDIR"
 W !! D ^DIR Q:$$STOP  I Y="ALL" S PSJSEL("TM","ALL")="" Q
 D DICTM
 S PSJSTOP=$S($D(DTOUT):1,$D(DUOUT):1,(Y<0)&'$D(PFLG):1,1:0)
 Q
TM2HLP W !!,"Enter the name of an Administration Team that you want",!,"to include on the report."," Enter ""ALL"" (or accept the",!,"default) to include all teams on the report.",!
 Q
 ;
DICTM ;*** LooK up a team.
 ;
 K DIC S DIC="^PS(57.7,"_+PSJSEL("W")_",1,",DIC(0)="QEMIZ"
 F PFLG=0:1 D ^DIC Q:Y<0  I PFLG S DIC(0)=DIC(0)_"A",DIC("A")="Select another Administration Team: " S PSJSEL("TM",+Y)=Y(0,0)
 Q
 ;
RBPPN ;*** Sort by ROOM-BED or PATIENT
 ;
 K DIR S DIR(0)="SAO^R:Room-Bed;P:Patient",DIR("A")="Do you wish to sort by Room-Bed (R), Patient (P): ",DIR("B")="Patient"
 W !! D ^DIR Q:$$STOP  S PSJSEL("RBP")=Y
 Q
ENL ;
 F  W !!,"SHORT, LONG, or NO Profile?  ",$S('$D(PSJPWD):"SHORT",PSJPWD:"SHORT",1:"LONG"),"// " R PSJOL:DTIME W:'$T $C(7) S:'$T PSJOL="^" Q:PSJOL="^"  D LCHK Q:"^SLN"[PSJOL&($L(PSJOL)=1)
 Q
 ;
LCHK ;
 I PSJOL?1."?" D LM Q
 I PSJOL="" S PSJOL=$S('$D(PSJPWD):"S",PSJPWD:"S",1:"L") W $P("  SHORT^  LONG","^",PSJOL="L"+1) Q
 I PSJOL?.ANP,PSJOL?.E1L.E F Q=1:1:$L(PSJOL) I $E(PSJOL,Q)?.L S PSJOL=$E(PSJOL,1,Q-1)_$C($A(PSJOL,Q)-32)_$E(PSJOL,Q+1,$L(PSJOL))
 I PSJOL?.ANP F X="NO PROFILE","LONG","SHORT" I $P(X,PSJOL)="" W $P(X,PSJOL,2) S PSJOL=$E(PSJOL) Q
 W:'$T $C(7),"  ??" Q
 ;
LM ;Profile Type
 W !!?2,"Enter 'SHORT' (or 'S', or press the RETURN key) to exclude this patient's",!,"discontinued and expired orders in the following profile.  Enter 'LONG' (or 'L') to include those orders."
 W "  Enter 'NO' (or 'N') to bypass the profile com-",!,"pletely.  Enter '^' if you wish to go no further with this patient." Q
ENDPT ;*** get patient ***
 K DIC,PSGP,Y W !!,"Select "_$S($D(PSGDICA):PSGDICA_" ",1:"")_"PATIENT: " R X:DTIME I "^"[X S (Y,PSGP)=-1 G DONE
 D EN^PSJDPT
 I Y'>0 G ENDPT
 K DIC
 ;
CHK ;*** Check patient status ***
 S PPN=$P(Y,U,2),(DFN,PSGP)=+Y,VA200=1 D INP^VADPT Q:VAIN(4)
 S PSJPCAF="",VAIP("D")="L" D IN5^VADPT I 'VAIP(13,1) W $C(7),!!?3,"PATIENT HAS NEVER BEEN ADMITTED." G ENDPT
 S X=+VAIP(4)=12!(+VAIP(4)=38) W $C(7),!!?3,"PATIENT IS FOUND TO BE D",$P("ISCHARG^ECEAS",U,X+1),"ED AS OF ",$$ENDTC^PSGMI(+VAIP(3)),"." G ENDPT
 Q
 ;
STOP() ;
 ;
 S PSJSTOP=$S($D(DTOUT):1,$D(DUOUT):1,$D(DIRUT):1,1:0)
 Q PSJSTOP
 ;
DONE ;
 K DA,DIC,DIK
 Q
