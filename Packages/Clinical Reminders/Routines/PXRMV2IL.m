PXRMV2IL ; SLC/AGP - Version 2.0 init routine. ;09/23/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;===============================================================
DELETE ;Delete PXRM list templates so the updated version will be properly
 ;installed.
 N IEN,NAME,TEMP0
 S NAME="" F  S NAME=$O(^SD(409.61,"B",NAME)) Q:NAME=""  D
 .I $P(NAME," ")'="PXRM" Q
 .S IEN=$O(^SD(409.61,"B",NAME,"")) Q:IEN=""
 .S TEMP0=$G(^SD(409.61,IEN,0))
 .K ^SD(409.61,IEN)
 .S ^SD(409.61,IEN,0)=TEMP0
 Q
 ;
