PSB372P ;MNT/BJR - Move Units Given field to Units Ordered ; 
 ;;3.0;BAR CODE MED ADMIN;**72**;Mar 2004;Build 16
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 Q
EN ;This routine will move the date in the units given field to the units ordered field for patch PSB*3*72
 N DR,DA,DIE
 D MES^XPDUTL("")
 D MES^XPDUTL("*** PSB*3*72 Post Install Running ***")
 D MES^XPDUTL("")
 N X,PSBIEN,PSBADD,PSBDOSE,PSBSTAT,PSBSOL
 D NOW^%DTC S ^XTMP("PSB72P",0)=$$FMADD^XLFDT(X,30)_"^"_X_"^"_"PSB*3.0*72 Changed Entries"
 S PSBIEN=999999999999 F  S PSBIEN=$O(^PSB(53.79,PSBIEN),-1) Q:'PSBIEN  D
 .I $G(^PSB(53.79,PSBIEN,.6,0))'="" S PSBADD=0 F  S PSBADD=$O(^PSB(53.79,PSBIEN,.6,PSBADD)) Q:'PSBADD  D
 ..M:'$D(^XTMP("PSB72P",PSBIEN,.6)) ^XTMP("PSB72P",PSBIEN,.6)=^PSB(53.79,PSBIEN,.6) S PSBDOSE=$$GET1^DIQ(53.796,PSBADD_","_PSBIEN,.03),PSBSTAT=$$GET1^DIQ(53.79,PSBIEN,.09,"I")
 ..I PSBDOSE'="" S DR=".02///^S X=PSBDOSE",DIE="^PSB(53.79,"_PSBIEN_",.6,",DA(1)=PSBIEN,DA=PSBADD D ^DIE K DR,DA,DIE
 ..I PSBSTAT'="G",PSBSTAT'="RM",PSBSTAT'="I",PSBSTAT'="C" S DR=".03///^S X=""@""",DIE="^PSB(53.79,"_PSBIEN_",.6,",DA(1)=PSBIEN,DA=PSBADD D ^DIE K DR,DA,DIE
 .I $G(^PSB(53.79,PSBIEN,.7,0))'="" S PSBSOL=0 F  S PSBSOL=$O(^PSB(53.79,PSBIEN,.7,PSBSOL)) Q:'PSBSOL  D
 ..M:'$D(^XTMP("PSB72P",PSBIEN,.7)) ^XTMP("PSB72P",PSBIEN,.7)=^PSB(53.79,PSBIEN,.7) S PSBDOSE=$$GET1^DIQ(53.797,PSBSOL_","_PSBIEN,.03),PSBSTAT=$$GET1^DIQ(53.79,PSBIEN,.09,"I")
 ..I PSBDOSE'="" S DR=".02///^S X=PSBDOSE",DIE="^PSB(53.79,"_PSBIEN_",.7,",DA(1)=PSBIEN,DA=PSBSOL D ^DIE K DR,DA,DIE
 ..I PSBSTAT'="G",PSBSTAT'="RM",PSBSTAT'="I",PSBSTAT'="C" S DR=".03///^S X=""@""",DIE="^PSB(53.79,"_PSBIEN_",.7,",DA(1)=PSBIEN,DA=PSBSOL D ^DIE K DR,DA,DIE
 D MES^XPDUTL("")
 D MES^XPDUTL("*** PSB*3*72 Post Install Complete ***")
 D MES^XPDUTL("*** You may review global ^XTMP(""PSB72P"") for a list of entries modified ***")
 D MES^XPDUTL("")
 Q
