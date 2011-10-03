PSNHELP1 ;BIR/WRT-help text routine ; 02/08/00 8:39
 ;;4.0; NATIONAL DRUG FILE;**22,33**; 30 Oct 98
 ;Reference to ^PSDRUG supported by DBIA #2352
 ;Reference to EN1^PSSUTIL supported by DBIA #3107
 ;
AUTO ; auto ndc help prompt
 W !!,"If you wish to start the automatic match by NDC Code process, respond ""Y""",!,"The automatic match by NDC will only run the first initial time you respond ""Y"""
 W !,"If you do not wish to start this process, respond ""N""" D UPAR^PSNHELP K ANS Q
VACLS ; class unmatched drug 1 or multiple help prompt
 W !!,"If you wish to class more than one unmatched drug (automatically looping by",!,"local generic name) respond ""Y""",!,"If you wish to class one unmatched drug, respond ""N""" D UPAR^PSNHELP K ANS1 Q
CL ; help prompt for reset classification option
 W !!," Enter VA Drug Classification code",!,"Format for code is 2 alphabetics followed by 3 numerics (i.e. AA999)"
 W !,"If the ""Merge National Drug File Data Into Local File"" option has been run",!,"for this drug, the Classification cannot be changed!" D UPAR^PSNHELP K PSNCLANS W:$D(NAM) !!,NAM Q
CLS ; help prompt to view class description
 W !!,"If you would like to view class descriptions, respond ""Y""",!,"If you do not wish to view class descriptions, respond ""N""" D UPAR^PSNHELP K ANS Q
CONVT W !!,"Enter a number for your choice or enter an ""N"" to leave this drug as a manually",!,"classed drug and proceed to the next entry to be matched. You may also enter an",!,"""^"" to exit.",! K PSNANS Q
CONVT1 W !!,"Press RETURN to see the rest of your choices, or you may enter a number",!
 W "for your choice or enter an ""N"" to leave this drug as a manually classed",!,"drug and proceed to the next entry to be matched. You may also enter an",!,"""^"" to exit.",! K PSNANS Q
CONVN ; help prompt for conversion rematch option
 W !!,"If you wish to start the Conversion Rematch process, respond ""Y""",!,"This option will only run the first initial time you respond ""Y"""
 W !,"If you do not wish to start this process, respond ""N""" D UPAR^PSNHELP K PSNAW Q
 Q
SETNULL K:$D(^PSNTRAN(+Y,0)) ^PSNTRAN(+Y,0)
 S PSNSAVEY=$G(Y) S X="PSSUTIL" X ^%ZOSF("TEST") I  D EN1^PSSUTIL(+$G(PSNSAVEY),0)
 S Y=$G(PSNSAVEY) K PSNSAVEY
 S ZXZX=$P(^PSDRUG(+Y,"ND"),"^",2),$P(^PSDRUG(+Y,"ND"),"^",1)="",$P(^PSDRUG(+Y,"ND"),"^",2)="",$P(^PSDRUG(+Y,"ND"),"^",3)="",$P(^PSDRUG(+Y,"ND"),"^",4)="",$P(^PSDRUG(+Y,"ND"),"^",5)="",$P(^PSDRUG(+Y,"ND"),"^",10)="" D NULL1
 Q
NULL1 S $P(^PSDRUG(+Y,"ND"),"^",11)="" I ZXZX]"" S ZXZX=$E(ZXZX,1,30) I $D(^PSDRUG("VAPN",ZXZX,+Y)) K ^PSDRUG("VAPN",ZXZX,+Y) K ZXZX
 Q
