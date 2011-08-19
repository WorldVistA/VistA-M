HLTASK ;AISC/SAW-Create a Background Task to Start the HL7 Lower Level Routine for a Non-DHCP Application and Purge HL7 Transmissions ;12/28/94  09:57
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
 ;This routine is used for the Version 1.5 Interface Only
 W !!,"Note:  You must select a Non-DHCP Application for which an HL7 Device has",!,"been defined."
 S HLF1=1,DIC="^HL(770,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),""^"",6)]""""" D ^DIC G EXIT:Y<0 K DIC S HLNDAP=+Y,HLNDAP0=Y(0),HLION=$P(HLNDAP0,"^",6)
TASK S ZTDESC="HL7 Message Processor for "_$P(HLNDAP0,"^") ;D ISQED^%ZTLOAD I ZTSK(0)=1 W:$D(HLF1) *7,!!,ZTDESC," is already tasked." G EXIT
 S ZTRTN="^HLLP",ZTDTH=$H,ZTIO=HLION,ZTSAVE("HLION")="",ZTSAVE("HLNDAP")="",ZTSAVE("HLNDAP0")=""
 D ^%ZTLOAD
EXIT K DIC,X,Y,ZTDESC,ZTRTN,ZTDTH,ZTIO,ZTSAVE K:$D(HLF1) HLF1,HLION,HLNDAP,HLNDAP0 Q
