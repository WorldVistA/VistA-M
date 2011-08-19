IBDFN4 ;ALB/CJM - ENCOUNTER FORM - (entry points for selection routines);5/21/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,51**;APR 24, 1997
 ;
CPT ;select ambulatory procedures
 N NAME,CODE,SCREEN,IBDESCR,IBDESCLG,QUIT
 S QUIT=0
 ;;I '$D(@IBARY@("SCREEN")) D CPTSCRN Q:QUIT
 ;;E  S SCREEN=$G(@IBARY@("SCREEN"))
 S SCREEN="I $P($$CPT^ICPTCOD(Y),U,7)=1" ;List only active codes
 K DIC S DIC=81,DIC(0)="AEMQZ",DIC("S")=SCREEN
 I $D(^ICPT) D ^DIC K DIC I +Y>0 D
 .;;change to api cpt;dhh
 .S CODE=$P(Y(0),U)
 .S CODE=$$CPT^ICPTCOD(CODE)
 .I +CODE=-1 K @IBARY Q
 .S NAME=$P(CODE,"^",3)
 .S IBDESCLG=$$CPTD^ICPTCOD(+CODE,.IBCPTD)
 .S IBDESCR=$G(IBCPTD(1))_" "_$G(IBCPTD(2))
 .S @IBARY=$P(CODE,"^",2)_"^"_NAME_"^"_IBDESCR
 E  K @IBARY ;kill either if file doesn't exist or nothing chosen
 Q
CPTSCRN ;This code is probably not called, but will modify to be safe.
 ;;S SCREEN="I '$P(^(0),U,4)"
 S SCREEN="I $P($$CPT^ICPTCOD(Y),U,7)=1"
 ;
 ;don't ask the user about categories - it doesn't work well 
 ;K DIR S DIR(0)="YA",DIR("A")="Do you want to select a CPT from a particular CPT category? ",DIR("?")="Answer YES if you want to screen out all CPT codes that do not belong to a particular category",DIR("B")="NO"
 ;I $D(^DIC(81.1)) D ^DIR K DIR S:$D(DIRUT) QUIT=1 Q:$D(DIRUT)  I +Y D
 ;.K DIC S DIC="81.1",DIC(0)="AEQ",DIC("S")="I $P(^(0),U,2)=""m"""
 ;.D ^DIC K DIC I +Y>0 S SCREEN=SCREEN_",$P($G(^DIC(81.1,+$P(^(0),U,3),0)),U,3)="_+Y
 S @IBARY@("SCREEN")=SCREEN
 Q
 ;
ICD9 ;select ICD-9 codes
 N IBDX,CODE,SCREEN,IBDESCR,QUIT
 S QUIT=0
 ;;I $D(@IBARY@("SCREEN")) S SCREEN=$G(@IBARY@("SCREEN"))
 ;;E  D ICD9SCRN Q:QUIT
 S SCREEN="I $P($$ICDDX^ICDCODE(Y),U,10)=1" ;List only active codes
 S DIC=80,DIC(0)="AEMQZI",DIC("S")=SCREEN
 I $D(^ICD9) D ^DIC K DIC I +Y>0 D
 .S CODE=$P(Y(0),U),IBDX=$P(Y(0),U,3),IBDESCR=$P($G(^ICD9(+Y,1)),"^")
 .S @IBARY=CODE_"^"_IBDX_"^"_IBDESCR
 E  K @IBARY ;kill if either file doesn't exist or nothing chosen - this is how to let the encounter form utilities know nothing was selected
 Q
ICD9SCRN ;This code is probably not called, but will modify to be safe.
 ;;S SCREEN="I '$P(^(0),U,9)"
 S SCREEN="I $P($$ICDDX^ICDCODE(Y),U,10)=1"
 ;
 ;don't ask the user about categories - it doesn't work well 
 ;K DIR S DIR(0)="YA",DIR("A")="Do you want to select an ICD diagnosis from a particular diagnostic category? ",DIR("B")="NO"
 ;S DIR("?")="Answer YES if you want to screen out all diagnosis codes that do not belong to a particular category"
 ;I $D(^DIC(80.3)) D ^DIR K DIR S:$D(DIRUT) QUIT=1 Q:$D(DIRUT)  I +Y D
 ;.K DIC S DIC="80.3",DIC(0)="AEQ"
 ;.D ^DIC K DIC I +Y>0 S SCREEN=SCREEN_",+$P(^(0),U,5)="_+Y
 S @IBARY@("SCREEN")=SCREEN
 Q
NULL ;returns NOTHING for selection
 S @IBARY=""
 Q
 ;
VSIT ; -- Select only visit cpt codes
 N NAME,CODE,IBDESCR,QUIT,DIC,X,Y,IBHDR,IBTXT
 S QUIT=0
 ;
 ;;S DIC="^IBE(357.69,",DIC(0)="AEMQZ",DIC("S")="I '$P(^(0),U,4)"
 S DIC="^IBE(357.69,",DIC(0)="AEMQZ"
 S DIC("S")="I $P($$CPT^ICPTCOD(Y),U,7)=1" ;List only active codes
 D ^DIC K DIC I +Y>0 D
 .;;----change to api cpt;dhh
 .S CODE=$P(Y(0),U),IBHDR=$P(Y(0),U,2),IBTXT=$P(Y(0),U,3)
 .S NODE=$$CPT^ICPTCOD(CODE)
 .I +NODE=-1 S IBSNM="" Q
 .S IBSNM=$P(NODE,U,3)
 .S @IBARY=CODE_"^"_IBTXT_"^"_IBHDR_"^"_IBSNM
 E  K @IBARY ;kill if nothing chosen
 Q
 ;
PRVDR ;for selecting provider
 D GETPRO^IBDF18B(IBCLINIC,IBARY)
 Q
 ;
IBPFID ;for printing the form # assigned by form tracking
 S @IBARY=$G(IBPFID)
 Q
 ;
PCPR ; -- get primary care provider for a patient
 S @IBARY=$P($$OUTPTPR^SDUTL3(DFN,DT),"^",2)
 Q
 ;
PCTM ; -- get primary care team for a patient
 S @IBARY=$P($$OUTPTTM^SDUTL3(DFN,DT),"^",2)
 Q
 ;
SCCOND ; -- display sc conditions
 Q:'$G(DFN)
 D DIS^DGRPDB
 W !
 Q
 ;
 ;
CPTMOD ;- Select active CPT Modifiers
 ;- (used in selecting CPT Modifier(s) when creating the CPT Modifier
 ;   Display ToolKit Block)
 ;
 N CODE,DIC,NAME,SCREEN
 Q:$G(IBARY)=""
 ;
 ;- Screen out inactive CPT modifiers
 ;;S SCREEN="I '$P(^(0),U,5)"
 ;;I '$D(@IBARY@("SCREEN")) S @IBARY@("SCREEN")=SCREEN
 ;
 ;List only active modifiers
 S SCREEN="I $P($$MOD^ICPTMOD(Y,""I""),U,7)=1"
 S DIC=81.3
 S DIC(0)="AEMQZ"
 S DIC("S")=SCREEN
 D ^DIC
 I +Y>0 D
 . ;- Use first 35 chars of modifier description
 . S CODE=$P(Y(0),"^"),NAME=$E($P(Y(0),"^",2),1,35)
 . S @IBARY=CODE_"^"_NAME
 ;
 ;- Kill if file doesn't exist or nothing chosen
 E  K @IBARY
 Q
