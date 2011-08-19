PSGVDS ;BIR/CML3-VARIOUS DATA SETS ;16 DEC 97 / 1:38 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENL ; Adds entries to 53.41 for NV UD, V UD, and IV orders.
 S ^PS(53.41,PSGTOL,1,PSGUOW,1,PSGP,1,PSGTOO,1,DA,0)=DA_"^"_$S($D(PSJSYSW):PSJSYSW,1:"")_"^"_PSGDT
 I $D(^PS(53.41,PSGTOL,1,PSGUOW,1,PSGP,1,PSGTOO,1,0))#2 S $P(^(0),"^",3,4)=DA_"^"_($P(^(0),"^",4)+1) Q
 S ^(0)="^53.4104A^"_DA_"^1" Q:$D(^PS(53.41,PSGTOL,1,PSGUOW,1,PSGP,1,PSGTOO,0))  S ^(0)=PSGTOO ; naked refers to line above it
 I $D(^PS(53.41,PSGTOL,1,PSGUOW,1,PSGP,1,0))#2 S $P(^(0),"^",3,4)=PSGTOO_"^"_($P(^(0),"^",4)+1) Q
 S ^(0)="^53.4103SA^"_PSGTOO_"^1" Q:$D(^PS(53.41,PSGTOL,1,PSGUOW,1,PSGP,0))  S ^(0)=PSGP ; naked refers to line above it
 I $D(^PS(53.41,PSGTOL,1,PSGUOW,1,0))#2 S $P(^(0),"^",3,4)=PSGP_"^"_($P(^(0),"^",4)+1) Q
 S ^(0)="^53.4102PA^"_PSGP_"^1" Q:$D(^PS(53.41,PSGTOL,1,PSGUOW,0))  S ^(0)=PSGUOW ; naked refers to line above it
 I $D(^PS(53.41,PSGTOL,1,0))#2 S $P(^(0),"^",3,4)=PSGUOW_"^"_($P(^(0),"^",4)+1) Q
 S ^(0)="^53.4101A^"_PSGUOW_"^1" Q:$D(^PS(53.41,PSGTOL,0))  S ^(0)=PSGTOL ; naked refers to line above it
 I $D(^PS(53.41,0))#2 S $P(^(0),"^",3,4)=PSGTOL_"^"_($P(^(0),"^",4)+1) Q
 S ^(0)="MAR LABELS^53.41S^"_PSGTOL_"^2" Q  ; naked refers to line above it
 ;
ENPOS ; provider order set
 F Y=1:1 I '$D(^PS(53.44,DUZ,1,PSGP,1,Y)) Q
 S ^PS(53.44,DUZ,1,PSGP,1,Y,0)=PSGORD_"^"_PSGPOSA_"^"_PSGPOSD,^PS(53.44,DUZ,1,PSGP,1,"AA",PSGPOSA,Y)="",^PS(53.44,DUZ,1,PSGP,1,"AD",+PSGPOSD,Y)="",^PS(53.44,DUZ,1,PSGP,1,"B",PSGORD,Y)=""
 I $D(^PS(53.44,DUZ,1,PSGP,1,0))#2 S $P(^(0),"^",3,4)=Y_"^"_($P(^(0),"^",4)+1) Q
 S ^(0)="^53.4402P^"_Y_"^1" Q:$D(^PS(53.44,DUZ,1,PSGP,0))  S ^(0)=PSGP I $D(^PS(53.44,DUZ,1,0))#2 S $P(^(0),"^",3,4)=PSGP_"^"_($P(^(0),"^",4)+1) Q  ; naked refers to line above it
 S ^(0)="^53.4401P^"_PSGP_"^1" I $D(^PS(53.44,DUZ,0))#2 S $P(^(0),"^",3,4)=DUZ_"^"_($P(^(0),"^",4)+1) Q  ; naked refers to line above it
 S ^(0)=DUZ I $D(^PS(53.44,0))#2 S $P(^(0),"^",3,4)=DUZ_"^"_($P(^(0),"^",4)+1) Q  ; naked refers to line above it
 S ^(0)="PROVIDER'S ORDERS^53.44P^"_DUZ_"^1" Q  ; naked refers to line above it
