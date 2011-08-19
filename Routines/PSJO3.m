PSJO3 ;BIR/CML3,PR-GET AND PRINT INPATIENT ORDERS ;08 MAR 95 / 1:12 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENGET ;
 S ENGET=1
 S PG=$D(PSGVWA),(ON,SLS)="",$P(SLS," -",15)="",TF=1
 S RB=$S(PSJPRB]"":PSJPRB,1:"* NF *")
 ;
ENNP I PSJON,'PSJDEV W $C(7) R !," '^' TO QUIT ",NP:DTIME W:'$T $C(7) S:'$T NP="^" W:NP'["^" *13,"                     ",*13,# Q
 I PSJON,PSJDEV D BOT
 ;
ENHEAD ; print new page, name, ssn, dob, and ward
 S PG=PG+1
 S PSJOPC="ALL" S PSJTEAM=$S($D(PSJSEL("TM")):1,1:0)
 D ENTRY^PSJHEAD(DFN,PSJOPC,PG,$G(PSJNARC),PSJTEAM)
 W:PG>1 !,LN2 K ENGET Q
 ;
BOT ; print name, ssn, and dob on bottom of page
 F Q=$Y:1:IOSL-4 W !
 W !,?2,$P(PSGP(0),"^"),?40,PSJPPID,?70,$E($P(PSJPDOB,"^",2),1,8) Q
 ;
ENL ;
 I $D(PSJEXTP) S PSJOL="L" Q
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
LM D FULL^VALM1 W !!?2,"Enter 'SHORT' (or 'S', or press the RETURN key) to exclude this patient's",!,"discontinued and expired orders in the following profile.  Enter 'LONG' (or 'L') to include those orders."
 W "  Enter 'NO' (or 'N') to bypass the profile com-",!,"pletely.  Enter '^' if you wish to go no further with this patient." D PAUSE^PSJLMUTL Q
 ;
PENDIU ; Help when asking if pending med order is to be an IV or UD.
 W !!,?5,"Enter ""I"" to complete this as an IV Medication order.",!,?5,"Enter ""U"" to complete this as an Unit Dose Medication order.",!!
 Q
