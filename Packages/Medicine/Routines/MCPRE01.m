MCPRE01 ;HIRMFO/DAD-PROTOCOL DELETION ;7/25/96  12:33
 ;;2.3;Medicine;;09/13/1996
 ;
 N TEMP,DA
 S TEMP(1)=""
 S TEMP(2)="Removing the 'Select a new patient' item from the 'Medicine"
 S TEMP(3)="/Consult Interface Menu' entry in the Protocol file (#101)."
 D MES^XPDUTL(.TEMP)
 S TEMP=$O(^ORD(101,"B","GMRCACT NEW PATIENT",0))
 S DA(1)=$O(^ORD(101,"B","GMRCACTM MEDICINE PKG MENU",0))
 S DA=$O(^ORD(101,+DA(1),10,"B",+TEMP,0))
 I DA]"",DA(1)]"",TEMP]"" D
 . S DIK="^ORD(101,"_DA(1)_",10," D ^DIK
 . Q
 Q
