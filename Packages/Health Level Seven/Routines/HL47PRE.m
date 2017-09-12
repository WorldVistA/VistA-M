HL47PRE ;SF/RJH   Delete data in file #771.7  ;04/12/99  10:57
 ;;1.6;HEALTH LEVEL SEVEN;**47**;Oct 13, 1995
 ;
 ; This is a pre-install routine for patch HL*1.6*47.  It deletes all
 ; the entries in HL7 Message Status file (#771.6) and HL7 Error
 ; Message file (#771.7).  And it moves purging dates stored in Option 
 ; Scheduling file to HL Communication Server Parameters file
 ;
 Q
 ;
DIK ;
 N DIK,DA
 S HLIEN=0
 S DIK="^HL(771.7,"
 F  S HLIEN=$O(^HL(771.7,HLIEN)) Q:'HLIEN  D
 .  S DA=HLIEN
 .  D ^DIK
 ;
 S HLIEN=0
 S DIK="^HL(771.6,"
 F  S HLIEN=$O(^HL(771.6,HLIEN)) Q:'HLIEN  D
 .  S DA=HLIEN
 .  D ^DIK
 ;
MVDATE ; move purging dates stored in Option Scheduling file to 
 ; HL Communication Server Parameters file
 N HLDT,HLDT1,HLDT2,HLDT3,HLDIC192
 S HLDIC192=$$FIND1^DIC(19.2,"","X","HL PURGE TRANSMISSIONS")
 Q:'HLDIC192
 S HLDIC192=HLDIC192_","
 S HLDT=$$GET1^DIQ(19.2,HLDIC192,15)
 S HLDT1=-$P(HLDT,";")
 S HLDT2=-$P(HLDT,";",2)
 S HLDT3=-$P(HLDT,";",3)
 I HLDT1>0 S $P(^HLCS(869.3,1,4),"^")=HLDT1
 I HLDT2>0 S $P(^HLCS(869.3,1,4),"^",2)=HLDT2
 I HLDT3>0 S $P(^HLCS(869.3,1,4),"^",3)=HLDT3
 Q
