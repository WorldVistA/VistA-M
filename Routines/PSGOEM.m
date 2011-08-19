PSGOEM ;BIR/CML3-PSGOE MESSAGES ;26 NOV 97 / 8:28 AM 
 ;;5.0; INPATIENT MEDICATIONS ;**81**;16 DEC 97
 ;
 ; Reference to ^DD(53.1 is supported by DBIA# 2256.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
ENVM ;
 W !!,"  Enter ORDER",$S(PSJON>1:"S (1-"_PSJON,1:" (1"),") you wish to ",$S('$D(PSJPRF):"select.",1:"view.") Q
 ;
ENCAM ;
 W !!,"Enter a 'Y' (or press the RETURN key) to ",$S(PSJSYSU:"",1:"mark for "),"discontinu",$S(PSJSYSU:"e",1:"ation")," all of this"
 W:'PSJSYSU ! W:PSJSYSU " " W "patient's" W:PSJSYSU ! W:'PSJSYSU " " W "orders.  Enter an 'N' (or '^') to leave this option now." Q
 ;
ENCOM ;
 W !!,"Enter a 'Y' to ",$S(CF:"discontinue this order",1:"mark this order for discontinuation"),".  Press the RETURN key (or" W:'CF ! W:CF " " W "enter an 'N'" W:CF ! W:'CF " " W "or '^') to leave this option now." Q
 ;
ENUMK ;
 W " BEEN 'MARKED FOR DISCONTINUATION'."
 F  W !,"DO YOU WANT TO 'UNMARK' ",$S($D(PSGORD):"IT",1:"THEM") S %=2 D YN^DICN Q:%  W !!?2,"Enter 'Y' to UNMARK "_$S($D(PSGORD):"this order",1:"these orders")_".  Enter 'N' to leave the order"_$E("s",$D(PSGORD)[0)_" MARKED AS IS.",!
 Q
 ;
ENHLP(F1,F2) ; order entry fields' help
 ; Input: F1 - File #
 ;        F2 - Field #
 N F,F0,F3,PSJD,PSJHP,PSJX
 ;I X="?",$D(^DD(F1,F2,3)) S F=^(3) W !?5 F F0=1:1:$L(F," ") S F3=$P(F," ",F0) W:$L(F3)+$X>78 !?5 W F3_" "
 ;
 D FIELD^DID(F1,F2,"","HELP-PROMPT","PSJHP")
 I X="?",$D(PSJHP("HELP-PROMPT")) S F=$G(PSJHP("HELP-PROMPT")) W !?5 F F0=1:1:$L(F," ") S F3=$P(F," ",F0) W:$L(F3)+$X>78 !?5 W F3_" "
 ;
 ;W:$D(^DD(F1,F2,12)) !,"("_^(12)_")" I $D(^(4)) X ^(4)
 W:$D(^DD(F1,F2,12)) !,"("_^(12)_")" D FIELD^DID(F1,F2,"","XECUTABLE HELP","PSJX") I $D(PSJX("XECUTABLE HELP")) X PSJX("XECUTABLE HELP")
 ;
 ;  new code
 D FIELD^DID(F1,F2,"","DESCRIPTION","PSJD")
 G:$S(X="?":1,1:'$O(PSJD("DESCRIPTION",0))) SC F F=0:0 S F=$O(PSJD("DESCRIPTION",F)) Q:'F  I $D(PSJD("DESCRIPTION",F)) W !?2,PSJD("DESCRIPTION",F)
 ;I F W:X="??" !?2,"..." I X?3."?" F F=F-1:0 S F=$O(^DD(F1,F2,21,F)) Q:'F  I $D(^(F,0)) W !?2,^(0)
 I F2=106 W !?5,"CHOOSE FROM:",!?7,"W",?16,"WRITTEN",!?7,"P",?16,"TELEPHONE",!?7,"V",?16,"VERBAL",!
 ; old code
 ;G:$S(X="?":1,1:'$O(^DD(F1,F2,21,0))) SC F F=0:0 S F=$O(^DD(F1,F2,21,F)) Q:'F  I $D(^(F,0)) W !?2,^(0)
 ;I F W:X="??" !?2,"..." I X?3."?" F F=F-1:0 S F=$O(^DD(F1,F2,21,F)) Q:'F  I $D(^(F,0)) W !?2,^(0),"RB.."
 ;I F2=106 W !?5,"CHOOSE FROM:",!?7,"W",?16,"WRITTEN",!?7,"P",?16,"TELEPHONE",!?7,"V",?16,"VERBAL",!
 ;
SC ;
 I F2=5!(F2=6) W !,"CHOOSE FROM:",!?8,0,?16,"NO",!?8,1,?16,"YES" Q
 Q
 ;
ENFF ; up-arrow to another field
 S Y=-1 I '$D(PSGFOK) W $C(7),"  ??" Q
 ;I X="^301"!($P("^DOSAGE ORDERED",X)="") W:X="^301" "  " S:X="^301" X="^" W $P("^DOSAGE ORDERED",X,2) S Y=301 Q
 S X=$E(X,2,99) I X=+X S Y=$S($D(PSGFOK(X)):X,1:-1) W "  " W:Y>0 $$CODES2^PSIVUTL(53.1,X) W:Y'>0 $C(7),"??" Q
 K DIC S DIC="^DD(53.1,",DIC(0)="QEM",DIC("S")="I $D(PSGFOK(+Y))" D ^DIC K DIC S Y=+Y Q
 ;
ENAH ; help text for "ACTION" prompt
 W !!,"YOU MAY SELECT:"
 W:PSGACT["B" !?5,"B to bypass (take no action on) a pending order."
 W:PSGACT["D" !?5,"D (or DC) to discontinue an order.  *WARNING* If you discontinue a",!?7,"non-verified order it is deleted from the system."
 W:PSGACT["E" !?5,"E to edit an active or non-verified order.  NOTE: Nursing must be notified",!?7,"of all changes."
 W:PSGACT["F" !?5,"F to finish a pending order."
 I PSGACT["H" S HF=$S('$D(^PS(55,PSGP,5,+PSGORD,0)):1,1:$P(^(0),"^",9)'="H") W !?5,"H to ",$S(HF:"place this order on",1:"take this order off of")," hold."
 W:PSGACT["I" !?5,"I to mark a non-verified order as incomplete, or to unmark a non-verified",!?7,"order so marked.  An order marked as incomplete may not be verified."
 W:PSGACT["L" !?5,"L to display either the activity log or the dispense log associated with",!,?7,"this order."
 W:PSGACT["N" !?5,"N to mark this order as 'NOT TO BE GIVEN'.  Orders so marked may not be",!?7,"renewed,"_$S(PSJSYSU:"",1:" or")_" reinstated"_$S(PSJSYSU:", or copied.",1:".")
 W:PSGACT["R" !?5,"R to ",$S(PSGRRF:"reinstate",1:"renew")," this order."
 W:PSGACT["V" !?5,"V to verify (make active) a non-verified order.  NOTE: You cannot verify",!?7,"an order that has been marked as incomplete."
 I $D(PSGOEA),PSGOEA?2."?" W !!,"You may also select:" I 'PSGOENG,'$D(PSGODF),PSJPCAF,'PSGDI,'PSGPI W !?5,"C to copy (duplicate) this order into a new, non-verified order."
 I $D(PSGOEA),PSGOEA?2."?" W !?5,"P to print this order to a device.",!?5,"S to show this order again."
 I PSGOEAV W !!,"PLEASE NOTE: This order is automatically verified, and unless discontinued",!?13,"now, will show as active."
 W !!?2,"You may also press the RETURN key if you are finished with this order or wish",!,"to take no action on it." W:'$D(PSGOETOF) "  Enter an '^' if you do not wish to take any action on any other orders."
 Q
