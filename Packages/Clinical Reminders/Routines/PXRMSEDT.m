PXRMSEDT ; SLC/PJH - Edit a reminder resolution status ;05/11/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Called from PXRMGEDT
 ;
 ;Edit/Delete resolution status
 ;-----------------------------
EDIT(ROOT,DA) ;
 N DIC,DIE,DR,LIEN,TAX,NATIONAL,DIDEL
 S DIE=ROOT,LIEN=DA
 ;
 ;Check if this is a restricted edit status (i.e. national status)
 S NATIONAL=+$P($G(^PXRMD(801.9,DA,0)),U,6)
 ;
 ;If national status only allow entry of sub-status or inactive
 I NATIONAL S DR="10;.04"
 ; 
 ;Otherwise do not allow entry of restricted edit or sub-status
 I 'NATIONAL S DR=".01;1;.02;.03;.04;.05///"_DUZ S DIDEL=801.9
 ;
 D ^DIE Q:$D(Y)  I '$D(DA) S VALMBCK="Q" Q
 ;
 ;If a local status - warning if not allocated to a national status
 Q:NATIONAL  Q:$D(^PXRMD(801.9,"AC",DA))
 ;Select National code
 W !!,"This resolution status must be linked to a national status",!
 N DA,DIC
 S DIC="^PXRMD(801.9,"
 S DIC(0)="AEMQ"
 S DIC("S")="I $P(^(0),U,6)=1"
 S DIC("A")="SELECT NATIONAL RESOLUTION STATUS: "
 ;Get the next name.
 D ^DIC
 S:Y=-1 DUOUT=1 Q:$D(DUOUT)!$D(DTOUT)
 ;Update sub-status field in national status
 N FDA,FDAIEN,MSG
 S FDA(801.9001,"+2,"_+Y_",",.01)=LIEN
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 I $D(MSG) D ERR
 Q
 ;
 ;Error Messages from UPDATE^DIE
 ;------------------------------
ERR N IC,ERROR,REF
 ;Move MSG into ERROR
 S REF="MSG",ERROR(1)="Error in UPDATE^DIE, needs further investigation"
 F IC=2:1 S REF=$Q(@REF) Q:REF=""  S ERROR(IC)=REF_"="_@REF
 ;Screen message
 D BMES^XPDUTL(.ERROR)
 Q
 ;
KILLAC ;This only applies if deleting a sub-status
 I '$D(^PXRMD(801.9,DA)) Q
 ;
 N SUB,NAT
 ;Get the national status for this sub status, quit if none
 S NAT=""
 F  S NAT=$O(^PXRMD(801.9,"AC",DA,NAT)) Q:NAT=""  D
 .;Get sub status position in the national code, quit if none
 .S SUB=$O(^PXRMD(801.9,"AC",DA,NAT,"")) Q:SUB=""
 .;Kill the sub-status on the national code
 .N DIC,DIK,DA S DIK="^PXRMD(801.9,NAT,10,",DA(1)=NAT,DA=SUB D ^DIK
 Q
