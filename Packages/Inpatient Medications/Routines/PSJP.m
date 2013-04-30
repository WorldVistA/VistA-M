PSJP ;BIR/CML3-INPATIENT LOOK-UP ; 15 Apr 98 / 9:05 AM
 ;;5.0;INPATIENT MEDICATIONS ;**10,53,60,181,273,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PS(59.7 is supported by DBIA 2181
 ; Reference to ^%ZIS is supported by DBIA 10086
 ; Reference to ^DICN is supported by DBIA 10009
 ; Reference to ^DIR is supported by DBIA 10026
 ; Reference to ^VADPT is supported by DBIA 10061
 ;
ENDPT ; get any patient
 K DIC,PSGP,Y W !!,"Select "_$S($D(PSGDICA):PSGDICA_" ",1:"")_"PATIENT: " R X:DTIME S:'$T X="^" W:'$T $C(7) I "^"[X S (Y,PSGP)=-1 S QFLG=1 G DONE
 D EN^PSJDPT
 I Y'>0 G ENDPT
 K DIC
 ;
CHK ;
 ;Clean out arrays use in order checks
 K PSJEXCPT,PSJOCER
 S (DFN,PSGP)=+Y,VA200=1 D INP^VADPT
 I VAIN(4) S PSJPCAF=1_"^"_VAIN(1),PSJPWD=+VAIN(4),PSJPWDN=$P(VAIN(4),"^",2),PSJPTS=+VAIN(3),PSJPTSP=+VAIN(2),PSJPRB=VAIN(5),PSJPAD=+VAIN(7),PSJPDX=VAIN(9),PSJPTD=$S($D(^PS(55,PSGP,5.1)):$P(^(5.1),"^",4),1:""),PSJPDD="" G CNV
 S PSJPCAF="",VAIP("D")="L" D IN5^VADPT I 'VAIP(13,1) W $C(7),!!?3,"PATIENT HAS NEVER BEEN ADMITTED." D ENCONT G:%'=1 ENDPT S PSJPDD=""
 ;*273 - Recognize patient death not from discharge
 D DEM^VADPT
 S PSGID=$S($G(VADM(6))]"":+VADM(6),1:+VAIP(3)),X=+VAIP(4)=12!(+VAIP(4)=38)!($G(VADM(6))),PSGOD=$$ENDTC^PSGMI(PSGID)
 I $S(X:1,1:VAIP(13,1)) W $C(7),!!?3,"PATIENT IS FOUND TO BE ",$P("DISCHARGED^DECEASED","^",X+1)," AS OF ",PSGOD,"." S PSJH=$S(X:2,1:3),PSJPDD=PSGID_"^"_PSGOD S:X PSJPDD=PSJPDD_"^1" D ENCONT G:%'=1 ENDPT
 S PSJPAD=VAIP(13,1),PSJPWD=+VAIP(5),PSJPWDN=$P(VAIP(5),"^",2),PSJPRB=$P(VAIP(6),"^",2),PSJPTSP=+VAIP(7),PSJPTS=+VAIP(8),PSJPDX=VAIP(9),PSJPTD=""
 ;
CNV ;
 I $G(DFN) I '$$AA^PSJDPT(DFN) S Y=-1 G ENDPT
 I $D(PSJEXTP) W ! K DIR S DIR(0)="DO",DIR("A")="Date to start searching from (optional)",DIR("?")="Enter a date to start searching from, or <RETURN> for all orders" D ^DIR S PSJHDATE=Y K DIR
 D DEM^VADPT,PID^VADPT,HTWT^PSJAC(DFN)
 S PSGP(0)=VADM(1),PSJPSSN=VADM(2),PSJPDOB=+VADM(3),PSJPAGE=VADM(4),PSJPSEX=$S(VADM(5)]"":VADM(5),1:"?^____"),PSJPPID=VA("PID"),PSJPBID=VA("BID")
 F X="PSJPAD","PSJPDOB","PSJPTD" I @X S $P(@X,"^",2)=$$ENDTC^PSGMI(+@X)
 ;
WP ; ward parameters
 S PSJSYSW0="",PSJSYSW=0 I $G(PSJPWD) S PSJSYSW=+$O(^PS(59.6,"B",PSJPWD,0)) I PSJSYSW S PSJSYSW0=$G(^PS(59.6,PSJSYSW,0))
 S PSJSYSL="",X=$P(PSJSYSU,";",3)>1,PSJSYSL=$S(X=0:$P(PSJSYSW0,"^",12),1:$P(PSJSYSW0,"^",16))
 S PSJDCEXP=$$RECDCEXP()
 I PSJSYSL D
 .S:X X='$P(PSJSYSP0,"^",10) S IOP=$S($P(PSJSYSP0,"^",13)]"":$P(PSJSYSP0,"^",13),$P(PSJSYSW0,"^",19+X)]"":$P(PSJSYSW0,"^",19+X),1:"") I IOP]"" D
 ..S IOP="`"_IOP K %ZIS S %ZIS="NQ" D ^%ZIS S:'POP $P(PSJSYSL,"^",2,3)=ION_"^"_IO D HOME^%ZIS
 ;
DONE ;
 K DA,DIC,NB,ND,NS,PSGID,PSGOD,VA200,VAIP,VAMT,X,Y(0),Y(0,0),QFLG Q
 ;
ENCONT ;
 I $D(PSGH) S %=1 Q
 F FQ=0:0 W !!,"Do you wish to continue with this patient" S %=0 D YN^DICN Q:%  W:%Y'?1."?" $C(7) W "  (A 'YES' or 'NO' response is required.)" D:%Y?1."?" @("CH"_PSJH)
 S:%'=1 Y=-1 Q
 ;
CH1 ;
 W !!?2,"The patient selected has never been admitted to this medical facility.  You",!,"will be able to enter IV orders for this patient but NOT Unit Dose orders." Q
CH2 ;
 W !!?2,"This patient is shown as deceased.  You will not be able to enter orders for",!,"this patient." Q
CH3 ;
 W !!?2,"This patient is shown to be currently discharged.  You will be able to enter",!,"IV orders for this patient but NOT Unit Dose orders." Q
 Q
RECDCEXP() ;
 ;Determent the Hours to display Recently DC/Expired orders on the short profile
 ;Returning P1^P2
 ;P1 = Number of hours defined in 59.6 or 59.7.  Set to 24 if no value set in either file.
 ;P2 = Date.time from Now - P1 hours
 ;
 NEW PSJDCEXP,PSJWD,PSJWD1,PSJSYS,X,%
 S PSJWD1=$S(+$G(PSJPWD):PSJPWD,+$G(VAIN(4)):+VAIN(4),1:0)
 S:PSJWD1 X=$O(^PS(59.6,"B",PSJWD1,0))
 S:+$G(X) PSJWD=$P($G(^PS(59.6,X,0)),U,33)
 S PSJSYS=+$P($G(^PS(59.7,1,26)),U,8)
 S PSJDCEXP=$S($G(PSJWD):PSJWD,PSJSYS:PSJSYS,1:24)
 D NOW^%DTC
 S X=$$FMADD^XLFDT(%,0,-PSJDCEXP,0,0)
 Q PSJDCEXP_U_X
