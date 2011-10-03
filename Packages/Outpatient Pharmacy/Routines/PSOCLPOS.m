PSOCLPOS ;BHAM ISC/SAB pre init for clozapine patch pso*6*102 ; 05/29/96
 ;;6.0;OUTPATIENT PHARMACY;**102**;APRIL 1993
 ;deletes queued clozapine options that transmit data to hines data base
 ;PSOL TRANSMIT DATA          Transmit Clozapine Dispensing Data
 ;PSOL TRANSMIT DEMOGRAPHICS          Transmit Clozapine Patient Demographics
 W ! F OPTN="PSOL TRANSMIT DATA","PSOL TRANSMIT DEMOGRAPHICS" S OPT=$O(^DIC(19,"B",OPTN,0)) I OPT D
 .S DA=$O(^DIC(19.2,"B",OPT,0)),DIK="^DIC(19.2," I DA D
 ..D ^DIK W !,"Dequeuing "_$P(^DIC(19,OPT,0),"^")_" option.",!
 K OPT,OPT,DA
 Q
