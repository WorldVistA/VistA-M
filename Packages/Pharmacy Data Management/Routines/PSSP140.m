PSSP140 ;BIR/JMC-Pharmacy system site parameters ;6/4/09 11:00am
 ;;1.0;PHARMACY DATA MANAGEMENT;**140**;9/30/97;Build 9
 ; Post-Install to set new field to 1
 K DIE,DA,DR S DIE="^PS(59.7,",DR="80.7////"_1,DA=1 D ^DIE K DIE,DA,DR
 Q
