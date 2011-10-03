PSSDELOI ;BIR/RTR-Delete Orderable Item File and all pointers; 09/02/97 8:34
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 S PSSITE=+$O(^PS(59.7,0)) I +$P($G(^PS(59.7,PSSITE,80)),"^",2)>1 W !?3,"Orderable Item Auto-create has already run to completion!",! K PSSITE Q
 K DIR S DIR(0)="Y",DIR("A")="Are you sure it's OK to delete the Orderable Item File",DIR("B")="N" D ^DIR K DIR I Y'=1 W !!?3,"No action taken!",! G END
 W !,"THIS WILL JUST TAKE A FEW MINUTES, PLEASE WAIT",!
 S PSCREATE=1
 W "." F ZZ=0:0 S ZZ=$O(^PS(50.7,ZZ)) Q:'ZZ  S DA=ZZ,DIK="^PS(50.7," D ^DIK
 W "." F XX=0:0 S XX=$O(^PSDRUG(XX)) Q:'XX  S RR=$P($G(^PSDRUG(XX,2)),"^") I RR S DA=XX,DIE="^PSDRUG(",DR="2.1////"_"@" D ^DIE
 W "." F YY=0:0 S YY=$O(^PS(52.6,YY)) Q:'YY  S RR=$P($G(^PS(52.6,YY,0)),"^",11) I RR S DA=YY,DIE="^PS(52.6,",DR="15////"_"@" D ^DIE
 W "." F BB=0:0 S BB=$O(^PS(52.7,BB)) Q:'BB  S RR=$P($G(^PS(52.7,BB,0)),"^",11) I RR S DA=BB,DIE="^PS(52.7,",DR="9////"_"@" D ^DIE
 S $P(^PS(59.7,PSSITE,80),"^",2)=0
 W !,"DONE!",!
END K DIE,DA,YY,BB,XX,ZZ,PSSITE,PSCREATE Q
