SRTOVRF ;BIR/SJA - TIME OUT VERIFIED FOR SURGERY ;12/16/10
 ;;3.0;Surgery;**175**;24 Jun 93;Build 6
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
