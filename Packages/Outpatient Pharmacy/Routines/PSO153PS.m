PSO153PS ;BIR/RTR-Patch 153 Post Install routine ;09/17/03
 ;;7.0;OUTPATIENT PHARMACY;**153**;DEC 1997
 ;External reference to File 870 supported by DBIA 1496
 ;
 ;Set AUTOSTART to Enabled for PSOTPBAAC Logical Link
 N DIE,DR,DIC,DA,X,Y
 K DIC S DIC(0)="X",DIC=870,X="PSOTPBAAC" D ^DIC K DIC
 I +Y>0 K DIE S DA=+Y,DIE=870,DR="4.5////"_1 D ^DIE K DA,DR,DIE
 ;
 ;Add patch installer to the HL7 mail group
 I '$G(DUZ) Q
 N XMY,PSOADDMG S XMY(DUZ)="" S PSOADDMG=$$MG^XMBGRP("PSO TPB HL7 EXTRACT",0,"","",.XMY,"",1)
 Q
