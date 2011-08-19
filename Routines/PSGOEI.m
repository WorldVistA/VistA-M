PSGOEI ;BIR/CML3-MARK (OR UNMARK) NON-VERIFIED ORDERS AS INCOMPLETE ;23 SEP 97 / 9:13 AM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 I PSJORD'["P"!(($P($G(^PS(53.1,+PSJORD,0)),"^",9)'="N")&($P($G(^PS(53.1,+PSJORD,0)),"^",9)'="I")) W !,"Order must be Non-Verified to change status to incomplete." H 2 G DONE
 S STAT=$S($D(^PS(53.1,"AS","I",PSGP,+PSJORD)):"N",1:"I")
 F  W !!,$S(STAT="I":"Mark this order as INCOMPLETE",1:"This order is marked INCOMPLETE.  Unmark it") S %=1 D YN^DICN Q:%  D H
 G:%'=1 DONE
 ;
 D FULL^VALM1
I S DIE="^PS(53.1,",DA=+PSJORD,DR="28////"_STAT_";40;" W ! D ^DIE
 ;I STAT="N",PSGACT'["V",PSJSYSU,'$P(PSJSYSW0,"^",PSJSYSU+14) S PSGACT=PSGACT_"V"
 ;I STAT="I",PSGACT["V" S PSGACT=$P(PSGACT,"V")_$P(PSGACT,"V",2)
 D GETUD^PSJLMGUD(DFN,PSJORD),INIT^PSJLMUDE(DFN,PSJORD)
 ;
DONE ;
 K DA,DIE,DR,STAT Q
 ;
H ;
 W !!?2,"Enter a 'Y' (or press the RETURN key) to ",$E("un",1,STAT="N"*2),"mark this order.  Enter an 'N'",!,"(or '^') to quit now.  (An order marked as incomplete cannot be verified",!,"until unmarked.)" Q
 ;
ENOR ;
 S STAT=$S($D(^PS(53.1,"AS","I",PSGP,+PSJORD)):"N",1:"I") G I
