PSGOEL ;BIR/CML3-DISPLAY LOGS ;27 JUN 95 / 6:14 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENLM(PSGP,PSGORD) ;
 S DIR(0)="SAO^1:Short Activity Log;2:Long Activity Log;3:Dispense Log;4:History Log",DIR("A")="Select LOG to display: ",DIR("A",1)="   1 - Short Activity Log",DIR("A",2)="   2 - Long Activity Log",DIR("A",3)="   3 - Dispense Log"
 S DIR("A",4)="   4 - History Log",DIR("A",5)="",DIR("?")="^D ENH^PSGOEL" W ! D ^DIR K DIR G:'Y DONE I Y<3 S AT=$E("SL",Y) D ENA^PSGVW0 G DONE
 I Y=4 D ENHIS^PSJHIS(PSGP,PSGORD,"U") Q
 I '$O(^PS(55,PSGP,5,+PSGORD,11,0)) W !!,"There is NO DISPENSE LOG for this order at this time."
 E  S Q=0 F C=1:1 S Q=$O(^PS(55,PSGP,5,+PSGORD,11,Q)) Q:'Q  S ND=$G(^(Q,0)) D PDL Q:'Y
 ;
DONE ;
 Q
 ;
PDL ; print dispense log
 I '(C#5) K DIR S DIR(0)="E" W ! D ^DIR Q:'Y
 S Y=1,PSGOD=$$ENDTC^PSGMI(+ND),DRG=$$ENDDN^PSGMI($P(ND,"^",2)),HOW=$P("UNKNOWN^THROUGH THE PICK LIST^AS PRE-EXCHANGE UNITS^AS EXTRA UNITS^AS RETURNS","^",$P(ND,"^",5)+1),WHO=$$ENNPN^PSGMI($P(ND,"^",6))
 W !!?3,"Date: ",PSGOD,?33,"Drug: ",DRG,!,"Entered: ",HOW W:$P(ND,"^",5)'=1 ?35,"By: ",WHO W !?2,"Units: ",$P(ND,"^",3)
 Q
 ;
ENH ;
 W !!?2,"Select '1' to view a SHORT ACTIVITY LOG for this order.  A short activity log",!,"shows only the main activities associated with the order."
 W !?2,"Select '2' to view a LONG ACTIVITY LOG for this order.  A long activity log",!,"shows all activities associated with the order."
 W !?2,"Select '3' to view the DISPENSE LOG for this order.  The dispense log shows",!,"the information about the order pertaining to the medication(s) dispensed for",!,"it, such as how many, when, by whom, etc."
 W !?2,"Select '4' to view the HISTORY LOG for this order.  The history log shows",!,"every order associated with this order.  Associated orders include orders",!,"created from renewing an order or editing certain fields of an order."
 Q
