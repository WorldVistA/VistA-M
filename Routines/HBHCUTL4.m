HBHCUTL4 ; LR VAMC(IRMS)/MJT-HBHC Utility module, Entry points: EN1 & KILL, called from: ^HBHCRP17 & ^HBHCRP22 ; Apr 2000
 ;;1.0;HOSPITAL BASED HOME CARE;**11,15,16**;NOV 01, 1993
EN1 ; Entry point 1
 D START^HBHCUTL
 G:(HBHCBEG1=-1)!(HBHCEND1=-1) EXIT
 S HBHCMSG="CPT Code must contain 5 numerics for use in a range."
 W ! K DIR,DIRUT S DIR(0)="YO",DIR("A")="Will CPT Codes selected be a Range of codes  (Y/N)",DIR("?")="Enter 'Y' for Yes, a range of CPT Codes is requested, 'N' for No, individual CPT codes will be selected." D ^DIR G:$D(DIRUT) EXIT S HBHCDIR=Y
 W ! K DIC,DTOUT,DUOUT S DIC="^ICPT(",DIC(0)="AEMNQZ",DIC("A")="Select Beginning CPT Code:  "
BEGCPT ; Prompt for beginning CPT code of range
 I HBHCDIR=1 D ^DIC G:(Y=-1)!($D(DTOUT))!($D(DUOUT)) EXIT I +$P(Y,U)'?3.5N W $C(7),!!,HBHCMSG,! G BEGCPT
 S:HBHCDIR=1 HBHCCPTB=$P(Y,U),DIC("A")="Select Ending CPT Code:  "
ENDCPT ; Prompt for Ending CPT Code of range
 I HBHCDIR=1 D ^DIC G:(Y=-1)!($D(DTOUT))!($D(DUOUT)) EXIT I +$P(Y,U)'?3.5N W $C(7),!!,HBHCMSG,! G ENDCPT
 I HBHCDIR=1 S:($P(Y,U)'<HBHCCPTB) HBHCCPTE=$P(Y,U) I ($P(Y,U)<HBHCCPTB) W $C(7),!!,"Ending CPT Code in range must be greater than the Beginning CPT Code",! G ENDCPT
 I HBHCDIR=0 K DIC("A"),HBHCTMP
CPT ; Prompt for CPT code(s)
 I HBHCDIR=0 D ^DIC G:(Y=-1)!($D(DTOUT))!($D(DUOUT)) EXIT S HBHCTMP(""_$P(Y(0),U)_"")=$P(Y(0),U,2) G CPT
EXIT ; Exit module
 Q
KILL ; Kill variables
 K DIR,DIRUT,HBHCBEG2,HBHCCC,HBHCCNT,HBHCCOLM,HBHCCPTA,HBHCCPT,HBHCDATE,HBHCDFN,HBHCDIR,HBHCDPT0,HBHCEND2,HBHCHDR,HBHCI,HBHCMSG,HBHCNOD0,HBHCPAGE,HBHCTDY,HBHCTMP,HBHCTOT,HBHCY,HBHCZ,X,X1,X2,^TMP("HBHC",$J)
 Q
