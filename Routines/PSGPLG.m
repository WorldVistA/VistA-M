PSGPLG ;BIR/CML3-CHOOSE A PICK LIST ;09 JUL 94 / 11:08 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
RUN D NOW^%DTC S PSGDT=%,PSGPLG="" D FA K NP,PSGID,PSGOD,S1,S2,W Q
 ;
FA ; find and show pick list(s) already started for this ward group
 W ! K W S W=0,NP="" F S1=$S(PSGPLGF="U":PSGDT,1:0):0 S S1=$O(^PS(53.5,"AB",PSGPLWG,S1)) Q:'S1  F S2=0:0 S S2=$O(^PS(53.5,"AB",PSGPLWG,S1,S2)) Q:'S2  D WRT G:NP["^" CHW
 I PSGPLGF="P",$D(^PS(53.5,"AO",PSGPLWG)) W !," - - - - - - - - - - - - - - - - - FILED AWAY - - - - - - - - - - - - - - - - - "
 I  F S1=0:0 S S1=$O(^PS(53.5,"AO",PSGPLWG,S1)) Q:'S1  F S2=0:0 S S2=$O(^PS(53.5,"AO",PSGPLWG,S1,S2)) Q:'S2  D WRT G:NP["^" CHW
 ;
CHW I 'W W !,"NO MORE PICK LISTS CURRENTLY FOR THIS WARD GROUP." Q
 I W>1 F  W !!,"Select 1 - ",W,": " R PSGPLG:DTIME W:'$T $C(7) S:'$T PSGPLG="^" Q:"^"[PSGPLG  Q:$D(W(PSGPLG))  D:PSGPLG["?" M1 W:PSGPLG'["?" $C(7),"  ??"
 I W>1 S:PSGPLG=+PSGPLG PSGPLG=W(PSGPLG) Q
 F  W !!,"THIS IS THE ONLY PICK LIST FOR THIS WARD GROUP.  OK" S %=1 D YN^DICN Q:%  D M2
 S PSGPLG=$S(%=1:W(1),%=2:"",1:"^") Q
 ;
M1 W !!,"Choose the number (1-",W,") that corresponds to the PICK LIST that you want to",!,$S(PSGPLGF="U":"UPDATE.",PSGPLGF="D":"enter UNITS DISPENSED.",1:"REPRINT.") Q
M2 W !!,"Enter a 'Y' (or press the RETURN key) to ",$S(PSGPLGF="U":"UPDATE",PSGPLGF="D":"enter UNITS DISPENSED into",1:"PRINT")," this PICK ",$S(PSGPLGF="D":"  ",1:"")
 W "LIST.  Enter an 'N' ",$S(PSGPLGF="U":"  ",PSGPLGF="P":"   ",1:""),"(or '^') to quit now." Q
 ;
WRT ;
 I W,'(W#17) W $C(7),!!,"Enter an '^' to stop, or press the RETURN key to continue. " R NP:DTIME W:'$T $C(7) S:'$T NP="^" W:NP'["^" *13,# Q:NP["^"
 S W=W+1,W(W)=S2,X=$G(^PS(53.5,S2,0)),Y=$O(^(0)),PSGID=$$ENDTC^PSGMI(S1),PSGOD=$$ENDTC^PSGMI($P(X,"^",4))
 W !,$J(W,3),"  From: ",PSGID,?30,"Through: ",PSGOD W:$S($P(X,"^",11):'$P(X,"^",9),1:0) "  (Did NOT complete run)" W:Y="" "   (NO data)" Q
