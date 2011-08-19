PSGSH ;BIR/CML3-SCHEDULE HELP TEXT ;07 OCT 97 / 9:17 AM 
 ;;5.0; INPATIENT MEDICATIONS ;**111**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; 
ENSH3 ; from ^DD(53.1,26,4)
 S:'$D(PSGST) PSGST=$P($G(^PS(53.1,DA,0)),"^",7),PSGDDFLG=1 G ENSH
 ;
ENSH5 ; from ^DD(55.06,26,4)
 S:'$D(PSGST) PSGST=$P($G(^PS(55,DA(1),5,DA,0)),"^",7),PSGDDFLG=1 G ENSH
 ;
ENQ ;
 ;W:$D(^DD(53.1,26,3)) !?3,^(3)
 D FIELD^DID(53.1,26,"N","HELP-PROMPT","PSJFDESC")
 I $D(PSJFDESC("HELP-PROMPT")) W PSJFDESC("HELP-PROMPT")
 ;
ENSH ;
 N D,DA,DIC,DIE,DZ,Y
 I X?1"???".E F Q=1:1 Q:$P($T(HT+Q),";",3)=""  W !?5,$P($T(HT+Q),";",3)
 I X?1"???".E R !,"(Press RETURN to continue.) ",Q:DTIME W:'$T $C(7) S:'$T Q="^" I Q="^" K:$D(PSGDDFLG) PSGDDFLG,PSGST Q
 K DIC S DIC="^PS(51.1,",DIC(0)="E",D="APPSJ",DIC("W")="W ""  ""," I $D(PSJPWD),PSJPWD S DIC("W")=DIC("W")_"$S($D(^PS(51.1,+Y,1,PSJPWD,0)):$P(^(0),""^"",2),1:$P(^PS(51.1,+Y,0),""^"",2))"
 E  S DIC("W")=DIC("W")_"$P(^(0),""^"",2)"
 I $D(PSGST) S DIC("S")="I $P(^(0),""^"",5)"_$E("'",PSGST'="O")_"=""O"""
 D IX^DIC K DIC K:$D(PSGDDFLG) PSGDDFLG,PSGST Q
 ;
 ;
HT ;
 ;;  This is the frequency (ONLY) with which the doses are to be administered.
 ;;Several forms of entry are acceptable, such as Q6H, 09-12-15, STAT, QOD,
 ;;and MO-WE-FR@AD (where MO-WE-FR are days of the week, and AD is the admin
 ;;times).  The schedule will show on the MAR, labels, etc.  No more than ONE
 ;;space (Q3H 4 or Q4H PRN) in the schedule is acceptable.  If the letters PRN
 ;;are found as part of the schedule, no admin times will print on the MAR or
 ;;labels, and the PICK LIST will always show a count of zero (0).
 ;;Avoid using notation such as W/F (with food) or WM (with meals) in the
 ;;schedule as it may cause erroneous calculations.  That information should
 ;;be entered into the SPECIAL INSTRUCTIONS.
 ;;  When using the MO-WE-FR@AD schedule, please remember that this type of
 ;;schedule will not work properly without the "@" character and at least one
 ;;admin time, and that at least the first two letters of each weekday entered
 ;;is needed.
