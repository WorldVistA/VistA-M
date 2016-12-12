ONCPAT1 ;Hines OIFO/GWB - PATIENT IDENTIFICATION (continued) ;10/07/11
 ;;2.2;ONCOLOGY;**1,5**;Jul 31, 2013;Build 6
 ;
CC W !,"    Source Comorbidity..........: ",ONC(160,D0,1006)
 W !,"    Comorbidity/Complication  #1.: ",ONC(160,D0,25)
 W !,"    Comorbidity/Complication  #2.: ",ONC(160,D0,25.1)
 W !,"    Comorbidity/Complication  #3.: ",ONC(160,D0,25.2)
 W !,"    Comorbidity/Complication  #4.: ",ONC(160,D0,25.3)
 W !,"    Comorbidity/Complication  #5.: ",ONC(160,D0,25.4)
 W !,"    Comorbidity/Complication  #6.: ",ONC(160,D0,25.5)
 W !,"    Comorbidity/Complication  #7.: ",ONC(160,D0,25.6)
 W !,"    Comorbidity/Complication  #8.: ",ONC(160,D0,25.7)
 W !,"    Comorbidity/Complication  #9.: ",ONC(160,D0,25.8)
 W !,"    Comorbidity/Complication #10.: ",ONC(160,D0,25.9)
 Q
 ;
CC2 W !,"    COMORBIDITY/COMPLICATION #2:"
CC3 W !,"    COMORBIDITY/COMPLICATION #3:"
CC4 W !,"    COMORBIDITY/COMPLICATION #4:"
CC5 W !,"    COMORBIDITY/COMPLICATION #5:"
CC6 W !,"    COMORBIDITY/COMPLICATION #6:"
CC7 W !,"    COMORBIDITY/COMPLICATION #7:"
CC8 W !,"    COMORBIDITY/COMPLICATION #8:"
CC9 W !,"    COMORBIDITY/COMPLICATION #9:"
CC10 W !,"    COMORBIDITY/COMPLICATION #10:"
 Q
 ;
SD W !,"    Secondary Diagnosis  #1.: ",ONC(160,D0,25.91)
 W !,"    Secondary Diagnosis  #2.: ",ONC(160,D0,25.92)
 W !,"    Secondary Diagnosis  #3.: ",ONC(160,D0,25.93)
 W !,"    Secondary Diagnosis  #4.: ",ONC(160,D0,25.94)
 W !,"    Secondary Diagnosis  #5.: ",ONC(160,D0,25.95)
 W !,"    Secondary Diagnosis  #6.: ",ONC(160,D0,25.96)
 W !,"    Secondary Diagnosis  #7.: ",ONC(160,D0,25.97)
 W !,"    Secondary Diagnosis  #8.: ",ONC(160,D0,25.98)
 W !,"    Secondary Diagnosis  #9.: ",ONC(160,D0,25.99)
 W !,"    Secondary Diagnosis #10.: ",ONC(160,D0,25.9901)
 ;
 N DIR,X S SAVEY=Y,ONCSDPMT="" W !
 S DIR("A")=" Would you like to edit the SECONDARY DIAGNOSIS #1-10 prompts"
 S DIR(0)="Y",DIR("B")="Yes" D ^DIR
 I Y=1 W ! S ONCSDPMT=1
 S Y=SAVEY Q
 Q
 ;
SD2 W !,"    SECONDARY DIAGNOSIS #2:"
SD3 W !,"    SECONDARY DIAGNOSIS #3:"
SD4 W !,"    SECONDARY DIAGNOSIS #4:"
SD5 W !,"    SECONDARY DIAGNOSIS #5:"
SD6 W !,"    SECONDARY DIAGNOSIS #6:"
SD7 W !,"    SECONDARY DIAGNOSIS #7:"
SD8 W !,"    SECONDARY DIAGNOSIS #8:"
SD9 W !,"    SECONDARY DIAGNOSIS #9:"
SD10 W !,"    SECONDARY DIAGNOSIS #10:"
 Q
 ;
SDSTF2 S $P(^ONCO(160,D0,3),"^",2)=""
SDSTF3 S $P(^ONCO(160,D0,3),"^",3)=""
SDSTF4 S $P(^ONCO(160,D0,3),"^",4)=""
SDSTF5 S $P(^ONCO(160,D0,3),"^",5)=""
SDSTF6 S $P(^ONCO(160,D0,3),"^",6)=""
SDSTF7 S $P(^ONCO(160,D0,3),"^",7)=""
SDSTF8 S $P(^ONCO(160,D0,3),"^",8)=""
SDSTF9 S $P(^ONCO(160,D0,3),"^",9)=""
SDSTF10 S $P(^ONCO(160,D0,3),"^",10)=""
 Q
 ;
CLEANUP ;Cleanup
 K D0,ONC
