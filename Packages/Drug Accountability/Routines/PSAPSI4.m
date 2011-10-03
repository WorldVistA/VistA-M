PSAPSI4 ;BIR/LTL-IV Dispensing (Single Drug) & (All Drugs) ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3**; 10/24/97
 ;This routine gets and sets the IV conversion factors.
 ;
 N PSADD,PSASOL,PSAC,Y,DIE,DA,DR
ADD S PSADD=$O(^PS(52.6,"AC",+PSAIT,0)) D:PSADD
 .W !,PSAIT(2)," is an IV Additive and will therefore be"
 I 'PSADD S PSASOL=$O(^PS(52.7,"AC",+PSAIT,0)) W !,PSAIT(2)," is an IV Solution and will therefore be"
 W !!,"dispensed in the IV module by the " D:PSADD
 .S Y=$P($G(^PS(52.6,+PSADD,0)),U,3),C=$P(^DD(52.6,2,0),U,3)
 .D Y^DIQ W Y
 W:$G(PSASOL) "ML"
 W ", but in ",PSALOCN," by the ",$P(PSAIT(4),U,8),".",!!
 W:PSADD "Please enter the number of ",Y,"s per ",$P(PSAIT(4),U,8),".",!
 S DIE="^PSD(58.8,+PSALOC,1,",DA(1)=PSALOC,DA=PSAIT,DR="25"
 I $G(PSASOL) W "The IV conversion factor is set to " S PSASOL(1)=+$P($G(^PS(52.7,+PSASOL,0)),U,3),DR="25////"_PSASOL(1) W PSASOL(1),".  <determined by IV Solution volume>",!
 D ^DIE K DIE,DA,DR,PSADD,PSASOL
