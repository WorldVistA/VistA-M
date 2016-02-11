SRTOVRF ;BIR/SJA - TIME OUT VERIFIED FOR SURGERY ;12/16/10
 ;;3.0;Surgery;**175,182,184**;24 Jun 93;Build 35
 ;
 ; entry point called by 'AE' x-ref of the 600-611 surgery fields
IN N SRJ,SRK,SRTN1,SRYN S SRTN1=$S($D(SRTN):SRTN,1:DA) Q:'SRTN1
 S SRJ=85
ASK D EN^DDIOL("Checklist Comments should be entered when a ""NO"" response is entered for any of  the Time Out Verified Utilizing Checklist fields.",,"!!")
 D FIELD^DID("130.0"_SRJ,.01,"","TITLE","SRK")
 D EN^DDIOL("Do you want to enter "_SRK("TITLE")_" ?  YES// ",,"!")
 R SRYN:DTIME I '$T!(SRYN["^") Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I SRYN["?" D HELP G ASK
 I "YyNn"'[SRYN D EN^DDIOL("Enter 'YES' to enter checklist comments now, 'NO' to quit, or '?' for more help.",,"!!") G ASK
 I "Nn"[SRYN Q
 ; edit the associated comments fields
 N DR,DIE,DA,DP,DC,DL,DE,DI,DIEL,DIETMP,DIFLD,DIP,DK,DM,DP,DQ,DU,DV,DW
 W ! S DIE=130,DA=SRTN1,DR=SRJ_"T" D ^DIE
 Q
HELP D EN^DDIOL("Enter 'YES' to enter time out comments.  Enter 'NO' to quit without entering time out comments.",,"!!")
 Q
WSXR(SRTN) ; prompt the user for the wound sweep & intraoperative X-Ray fields
 N SRC,SRSSDT
 Q:'$D(^TMP("SR182",$J))
 S Y=$E($P(^SRF(SRTN,0),"^",9),1,7) D D^DIQ S SRSSDT=Y
 W @IOF,!," "_VADM(1)_" ("_VA("PID")_")   Case #"_SRTN_" - "_SRSSDT
 S SRC(1)="Wound Sweep & Intraoperative X-Ray fields must be entered when a ""NO"" response  is entered for any of the following fields: ",SRC(1,"F")="!!"
 S SRC(2)=" - SPONGE FINAL COUNT CORRECT, OR",SRC(2,"F")="!!?5"
 S SRC(3)=" - SHARPS FINAL COUNT CORRECT, OR",SRC(3,"F")="!?5"
 S SRC(4)=" - INSTRUMENT FINAL COUNT CORRECT",SRC(4,"F")="!?5"
 S SRC(5)=""
 D EN^DDIOL(.SRC,,"!")
 K DR,DA,DIE S DR="633T;636T",DA=SRTN,DIE=130 D ^DIE K DR,DA
 D:$P($G(^SRF(SRTN,25)),"^",7)="N" COM(635)
 D:$P($G(^SRF(SRTN,25)),"^",8)="N" COM(637)
 W !!,"Press <RET> to continue  " R X:DTIME
 Q
COM(SRJ) ;prompt the user for the wound sweep/Intraoperative X-Ray comments fields
SK D EN^DDIOL($S(SRJ=635:"Wound Sweep",1:"Intraoperative X-Ray")_" comments should be entered when a ""NO"" response is entered for the "_$S(SRJ=635:"Wound Sweep",1:"Intraoperative X-Ray")_" field.",,"!!")
 D FIELD^DID("130.0"_SRJ,.01,"","TITLE","SRK")
 D EN^DDIOL("Do you want to enter "_SRK("TITLE")_" ?  YES// ",,"!")
 R SRYN:DTIME I '$T!(SRYN["^") Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I SRYN["?" D  G SK
 .D EN^DDIOL("Enter 'YES' to enter"_$S(SRJ=635:"Wound Sweep",1:"Intraoperative X-Ray")_" comments.  Enter 'NO' to quit without entering time out comments.",,"!!")
 I "YyNn"'[SRYN D EN^DDIOL("Enter 'YES' to enter"_$S(SRJ=635:"Wound Sweep",1:"Intraoperative X-Ray")_" Comments now, 'NO' to quit, or '?' for more help.",,"!!") G SK
 I "Nn"[SRYN Q
 ; edit the related comments field
 W ! S DIE=130,DA=SRTN,DR=SRJ_"T" D ^DIE
 Q
ABORT(SRTN) ; check if the case is aborted
 N SRNP2 S SRNP2=$G(^SRF(SRTN,.2))
 I $P($G(^SRF(SRTN,30)),"^")'=""!($P($G(^SRF(SRTN,31)),"^",8)'="") I $P(SRNP2,"^")!($P(SRNP2,"^",10))&($P($G(^SRF(SRTN,30)),"^",6)>1) Q 1
 Q 0
 ;
VER1(SRTN) ; check before displaying [SROMEN-VERF1] fields
 N SRCPT
 S SRCPT=$P($G(^SRF(SRTN,"OP")),"^",2) I 'SRCPT Q 0
 I ",32851,32852,32853,32854,33935,33945,44135,44136,47135,47136,48160,48554,50360,50365,"[(","_SRCPT_",") Q 1
 Q 0
 ;
VER2(SRTN) ; check before displaying [SROMEN-VERF2] fields
 N SRCPT
 S SRCPT=$P($G(^SRF(SRTN,"OP")),"^",2) I 'SRCPT Q 0
 I ",44133,47140,47141,47142,48550,50320,50547,"[(","_SRCPT_",") Q 1
 Q 0
 ;
SPIN(SRCPT) ; check to see if the case is spinal case
 N SRF,SCPT S SRF=0
 S SRTN=$S($D(SRTN):SRTN,$D(DA):DA,1:"") I SRTN S SROP=$G(^SRF(SRTN,"OP"))
 S SCPT=$S($D(SRCPT):SRCPT,$P(SROP,"^",2):$P(SROP,"^",2),1:"")
 S:'SCPT SRF=0
 I $G(SCPT),$D(^SRO(131.4,SCPT,0)) S SRF=1
 I SRF=0 S $P(^SRF(SRTN,1.1),"^",4)=""
 Q SRF
 ;
SCR(SRF) ; screen items that are not matching case specialty
 N SRSPEC
 S SRSPEC=$P($G(^SRF($S($D(SRTN):SRTN,1:DA),0)),"^",4)
 I '$O(^SRO(SRF,Y,1,"B",0)) Q 1
 I '$D(^SRO(SRF,Y,1,"B",SRSPEC)) Q 0
 Q 1
