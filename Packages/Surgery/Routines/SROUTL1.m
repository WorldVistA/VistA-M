SROUTL1 ;BIR/ADM - UTILITY ROUTINE ;1/13/2011
 ;;3.0;Surgery;**134,175,184**;24 Jun 93;Build 35
ATT ; check for attend surg when completing case
 I $P($G(^SRF(DA,.1)),"^",13) Q
 D ASK I '$P($G(^SRF(DA,.1)),"^",13) K X
 Q
ASK N SREQ,X,Y
 D EN^DDIOL("The Attending Surgeon field has not been entered. You must first enter the",,"!!")
 D EN^DDIOL("Attending Surgeon before the computer will accept entry of the Time Patient",,"!")
 D EN^DDIOL("Out of O.R.",,"!")
 K DIR S DIR("A",1)="",DIR("A")="Attending Surgeon",DIR(0)="130,.164" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I +Y S SREQ(130,DA_",",.164)=+Y D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 Q
ATTP ; check for attend provider when completing non-OR procedure
 I $P($G(^SRF(DA,"NON")),"^",7) Q
 D ASKP I '$P($G(^SRF(DA,"NON")),"^",7) K X
 Q
ASKP N SREQ,X,Y
 D EN^DDIOL("The Attending Provider field has not been entered. You must first enter",,"!!")
 D EN^DDIOL("the Attending Provider before the computer will accept entry of the Time",,"!")
 D EN^DDIOL("Procedure Ended.",,"!")
 K DIR S DIR("A",1)="",DIR("A")="Attending Provider",DIR(0)="130,124" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I +Y S SREQ(130,DA_",",124)=+Y D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 Q
ZERO ; add leading zero to Dose amounts between 0 and 1 for clarity purposes, e.g. Dose entered as .5, will display as 0.5; called from input transform on the following Dose flds:
 ; .375 Medications mult 130.33, subfld 1 Time Adm mult 130.34, subfld 1 Dose
 ; .37 Anesthesia Technique mult 130.06, subfld 24 Anesthesia Agents mult 130.47, subfld 1 Dose (mg)
 ; .37 Anesthesia Technique mult 130.06, subfld 32 Test Does mult 130.48, subfld 1 Dose (mg)
 S:(X>0)&(X<1) X="0"_+X
 Q
WOND(Y) ; screen called by wound classification field #1.09 
 N SRCPT,SRF,SRX,SRY,SRJ,SRLIST,SRI S SRF=0
 S SRTN=$S($D(SRTN):SRTN,$D(DA):DA,1:"") Q:'SRTN 0
 I SRTN,($P($G(^SRF(SRTN,"1.0")),"^",8)]"") Q 0
 S SRCPT=$P($G(^SRF(SRTN,"OP")),"^",2) I 'SRCPT Q 0
 F SRJ=0:1 S SRLIST=$P($T(WCPT+SRJ),";;",2) Q:SRLIST="END"  D  Q:SRF
 .F SRI=1:1 S SRX=$P(SRLIST,",",SRI) Q:SRX=""  I $D(^ICPT("B",SRX)) D  Q:SRF
 ..S SRY=0,SRY=$O(^ICPT("B",SRX,SRY)) Q:SRY=""  S:SRCPT=SRY SRF=1
 Q SRF
WCPT ;;43108,43113,43118,43123,43361,43645,43845,43847,44020,44021,44110,44111,44120,44121
 ;;44125,44126,44127,44128,44139,44140,44141,44143,44144,44145,44146,44147,44150,44151,44155
 ;;44156,44157,44157,44158,44158,44160,44202,44203,44204,44205,44206,44207,44208,44210,44211
 ;;44212,44213,44227,44322,44602,44603,44620,44625,44625,44626,44626,44701,44900,44950,44955
 ;;44960,44970,45000,45005,45020,45108,45111,45113,45119,45120,45121,45126,45130,45135,45160
 ;;45171,45172,45190,45355,45390,45397,45562,45563,45910,46040,46060,46288,46707,47010,47120
 ;;47122,47125,47130,47133,47140,47141,47142,47143,47144,47145,47361,47400,47420,47425,47480
 ;;47490,47510,47511,47525,47530,47550,47552,47560,47561,47562,47563,47564,47570,47600,47605
 ;;47610,47612,47620,47700,47700,47711,47712,47720,47721,47740,47741,47760,47765,47780,47785
 ;;47800,47802,47900,48001,48001,48020,48105,48140,48145,48146,48150,48152,48153,48154,48155
 ;;48160,48500,48510,48520,48540,48545,48547,48548,48550,48551,48551,48552,48554,48556,49020
 ;;49407,49442,49450,50815,50825,50845,51596,51597,51597,58200,58240,58260,58262,58263,58267
 ;;58270,58275,58280,58285,58290,58291,58292,58293,58294,58550,58552,58553,58554,59857,0184T
 ;;END
