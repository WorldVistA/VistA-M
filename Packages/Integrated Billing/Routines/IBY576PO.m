IBY576PO ;AITC/JRA - POST-INSTALL FOR IB*2.0*576 ;22-FEB-2017
 ;;2.0;INTEGRATED BILLING;**576**;21-MAR-94;Build 45
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 S IBA(2)="IB*2*576 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D UPDERR,RIT
 S IBA(2)="IB*2*576 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
UPDERR ; Update existing error code message for 350.8
 N IBCODE,IBMESN,IBIEN,DIE,DIC,DA,DR,X,Y
 S IBCODE="IB099",IBMESN="Occ. Codes Onset of Illness (11) and LMP (10) not allowed on same bill."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE Q
 ;
 S DIE="^IBE(350.8,",DA=IBIEN,DR=".02////"_IBMESN D ^DIE K DIE,DIC,DA,DR
 D MES^XPDUTL(">> Updated IB ERROR Code 'IB099' in D350.8 <<")
 Q
 ;
CREATE ;Create entry for 'IB099' in D350.8 if not there
 N Y,IBIEN,FNUM,IEN,NODE0,VAL,PCE3,I,II,MSG,NODE0P3
 S DIC="^IBE(350.8,",DIC(0)="",X="IB099" D FILE^DICN K DIC,X
 I Y=-1 D MES^XPDUTL(">> IB ERROR - Entry 'IB099' not found in D350.8 and unable to create <<") Q
 S IBIEN=+Y
 S DIE="^IBE(350.8,",DA=IBIEN,DR=".02////"_IBMESN_";.03////IB099;.04////1;.05////3" D ^DIE K DIE,DIC,DA,DR
 Q
 ;
RIT ; Recompile billing screen templates due to changes to Field #399,.21 cross-references.
 N X,Y,DMAX,IBN
 D MES^XPDUTL(">> Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:10,"102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN),Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B"),DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL("     Recompile Completed.")
 Q
 ;
