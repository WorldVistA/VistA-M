PSGWOD2 ;BHAM ISC/MPH,PTD,CML-Enter an On-Demand Request (for Pharmacy Use) - CONTINUED ; 16 Apr 93 / 7:38 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;**17**;4 JAN 94
DIENEW S PSGWD=$S('$D(^PSI(58.1,AOU,2,0)):0,$P(^PSI(58.1,AOU,2,0),"^",3)'="":$P(^PSI(58.1,AOU,2,$P(^PSI(58.1,AOU,2,0),"^",3),0),"^",1),1:0)
 S DR="1///0;30///TODAY;31///O;33///ONE TIME REQ.;16///"_PSGWODT
 ;I %=2 S DR(2,58.11)="1;10;3;5//^S X=$S(PSGWD'=0:$P(^DIC(42,PSGWD,0),""^"",1),1:"""");30;I X="""" S Y=16;31//O;I X'=""O"" S Y=16;33//ON-DEMAND REQ.;16///"_PSGWODT
 S DR(2,58.13)=".01"
 S DR(2,58.28)="S OLD=$P(^PSI(58.1,AOU,1,DA(1),5,DA,0),""^"",2);1;S QD=X-OLD;2////"_DUZ
 Q
 ;
SCR ;This subroutine will ONLY be called from DIC("S")
 S DRGDA=+^(0)
 I '$D(^PSDRUG(DRGDA,"I")) D SCR2 Q  ;Drug is NOT inactive in file #50 - OK
 I +^PSDRUG(DRGDA,"I")>DT D SCR2 Q  ;Drug is inactive in file #50 IN FUTURE - OK
 I '$D(^PSI(58.1,AOU,1,+Y,"I")) D SCR2 Q  ;Drug is inactive in file #50 but NOT file #58.1 - OK
 I +$O(^PSI(58.1,AOU,1,+Y,"I",0))>DT D SCR2 Q  ;Drug is inactive in file #50 and inactive in file #58.1 IN FUTURE - OK
 Q
SCR2 ;Check for NON-PHARMACY ITEMS
 I $S('$D(^PSDRUG(DRGDA,2)):1,$P(^(2),"^",3)="":1,$P(^(2),"^",3)["O":1,$P(^(2),"^",3)["U":1,$P(^(2),"^",3)["I":1,$P(^(2),"^",3)["X":1,1:$P(^(2),"^",3)["N") Q
