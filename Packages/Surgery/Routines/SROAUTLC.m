SROAUTLC ;BIR/ADM - CARDIAC RISK ASSESSMENT UTILITY ;08/23/07
 ;;3.0; Surgery ;**38,71,90,88,95,97,102,96,125,153,163,164,166,174**;24 Jun 93;Build 8
 ;
 ; Reference to ^DIC(45.3 supported by DBIA #218
 ;
SITE ; determine if site is a cardiac facility
 I $$CARD Q
 W @IOF,!,"The SURGERY SITE PARAMETERS file indicates this site/division does not use ",!,"the Cardiac Risk Assessment module. Therefore, this option is not available",!,"for use.",!
 S XQUIT="" W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 Q
CARD() ; extrinsic call to determine if site is cardiac facility
 N CARD S CARD=0 Q:'$G(SRSITE) CARD
 I $P($G(^SRO(133,SRSITE,0)),"^",5)="Y" S CARD=1
 Q CARD
NOW ; update date/time of surgical priority entry
 N X I $$CARD,$P($G(^SRF(DA,208)),"^",12)'="" D NOW^%DTC S $P(^SRF(DA,208),"^",13)=$E(%,1,12)
 Q
KNOW ; delete date/time of surgical priority entry
 I $D(^SRF(DA,208)) S $P(^SRF(DA,208),"^",13)=""
 Q
EM ; input transform logic on Case Schedule Type field (.035)
 Q:'$$CARD  N DIR,SREM,SRNOT,SRQ,SRSP
 I X'="EM" S:X="U" $P(^SRF(DA,208),"^",12)=2 S:X'="U" $P(^SRF(DA,208),"^",12)=1 D NOW Q
 S SRQ=0,SRSP=$P(^DIC(45.3,$P(^SRO(137.45,$P(^SRF(DA,0),"^",4),0),"^",2),0),"^") Q:SRSP'=48&(SRSP'=58)  D:SRSP=58 YN Q:SRQ
 D CAT
 Q
CAT N X K DIR S DIR("A",1)="",DIR("A",2)="     Enter category of emergency.",DIR("A",3)="     1. Emergent (ongoing ischemia)",DIR("A",4)="     2. Emergent (hemodynamic compromise)",DIR("A",5)="     3. Emergent (arrest with CPR)"
 S DIR("A",6)="",DIR("A")="     Enter number (1, 2 or 3): ",DIR(0)="NA^1:3",DIR("?")="^D HELP^SROAUTLC" D ^DIR I $D(DTOUT)!$D(DUOUT) Q
 S SREM=Y,$P(^SRF(DA,208),"^",12)=SREM+2 D NOW
 Q
YN N X K DIR S DIR("A",1)="",DIR("A",2)="     Is this emergency case a cardiac procedure requiring cardiopulmonary",DIR("A")="     bypass (Y/N)? ",DIR(0)="YA" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 I 'Y S SRQ=1
 Q
HELP K SRHLP S SRHLP(1)="This is the category of emergency reflecting the patient's cardiovascular",SRHLP(2)="condition at the time of transport to the operating room:",SRHLP(3)=""
 S SRHLP(4)="1. Emergent (ongoing ischemia) - Clinical condition mandates immediate",SRHLP(5)="surgery usually on day of catheterization because of ischemia despite"
 S SRHLP(6)="medical therapy, such as intravenous nitroglycerine.  Ischemia should",SRHLP(7)="be manifested as chest pain and/or ST-segment depression."
 S SRHLP(8)="",SRHLP(9)="2. Emergent (hemodynamic compromise) - Persistent hypotension (arterial",SRHLP(10)="systolic pressure < 80 mm Hg) and/or low cardiac output (cardiac index"
 S SRHLP(11)="< 2.0 L/min/MxM) despite iontropic and/or mechanical circulatory",SRHLP(12)="support mandates immediates surgery within hours of the cardiac",SRHLP(13)="catheterization."
 S SRHLP(14)="",SRHLP(15)="3. Emergent (arrest with CPR) - Patient is taken to the operating room in",SRHLP(16)="full cardiac arrest with the circulation supported by cardiopulmonary"
 S SRHLP(17)="resuscitation (excludes patients being adequately perfused by a",SRHLP(18)="cardiopulmonary support system).",SRHLP(19)=""
 S SRHLP(20)="Enter the appropriate number to designate the category of emergency.",SRHLP(21)="",SRHLP(22)="" D EN^DDIOL(.SRHLP) K SRHLP
 N DIR S DIR(0)="FOA",DIR("A")="Enter RETURN to continue: " D ^DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 Q
 Q
CHK ; check for missing cardiac assessment information
 K SRX,SRZZ F SRC="CLIN","LAB","CATH","OP","CAR","OUT","R" K DA,DIC,DIQ,DR,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="I" D @SRC D EN^DIQ1 D ^SROAUTL4
 D RED^SROAUTL4
 Q
CLIN S DR="236;237;475;203;347;209;348;510;349;350;240;351;205;352;485;265;264;267;207;353;354;355;474;463;509"
 Q
CATH S DR="476;357;358;359;360;363;415;477;361;362.1;362.2;362.3;478;479;480"
 Q
R S DR="418;419;440;.205;.22;.23;.232;470;471;473;472;442"
 Q
OP S DR="364;364.1;1.13;414;414.1"
 Q
OUT S DR="384"
 Q
CAR S DR="365;366;464;465;416;367;368;369;493;371;481;483;512;376;380;378;377;379;373;372;505;502;381;382;451;450;468;469"
 I $P($G(^SRF(SRTN,209)),"^",13)="Y"!($P($G(^SRF(SRTN,209)),"^",13)="") S DR=DR_";484"
 Q
LAB S DR="457;457.1;461;461.1;462;462.1;458;458.1;459;459.1;460;460.1;223;290;225;292;219;239;504;504.1;507;507.1"
 Q
