SRENSCS ;BIR/SJA - ENSURING CORRECT SURGERY ;04/26/04
 ;;3.0; Surgery ;**129,153**;24 Jun 93;Build 11
 ;
 ; entry point called by 'AIN' x-ref of the correct surgery fields
IN I X'="N"!(X'=Y) Q
 N SRJ,SRK,SRTN1,SRYN S SRTN1=$S($D(SRTN):SRTN,1:DA) Q:'SRTN1
 S SRJ=$S(+DI=71:"3;82",+DI=72:"4;83",1:"5;84")
ASK D EN^DDIOL("Correct Surgery Comments should be entered when a ""NO"" response is entered.",,"!!")
 D FIELD^DID("130.0"_$P(SRJ,";",2),.01,"","TITLE","SRK")
 D EN^DDIOL("Do you want to enter "_SRK("TITLE")_" ?  YES// ",,"!")
 R SRYN:DTIME I '$T!(SRYN["^") Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I SRYN["?" D HELP G ASK
 I "YyNn"'[SRYN D EN^DDIOL("Enter 'YES' to enter correct surgery comments now, 'NO' to quit, or '?' for more help.",,"!!") G ASK
 I "Nn"[SRYN Q
 ; edit the associated comments fields
 N DR,DIE,DA,DP,DC,DL,DE,DI,DIEL,DIETMP,DIFLD,DIP,DK,DM,DP,DQ,DU,DV,DW
 W ! S DIE=130,DA=SRTN1,DR=$P(SRJ,";",2)_"T" D ^DIE
 Q
HELP D EN^DDIOL("Enter 'YES' to enter correct surgery comments.  Enter 'NO' to quit without entering correct surgery comments.",,"!!")
 Q
HR ;entry point called by 'AN' x-ref of the Sur Site Hair Removal Method field
 I X'="S"&(X'="O") Q
 N SRTN1,SRYN,SRSEL S SRSEL=X,SRTN1=$S($D(SRTN):SRTN,1:DA) Q:'SRTN1
HRASK I SRSEL="O" D  G HRC
 .D EN^DDIOL("Because OTHER has been selected, information must be entered into the comments",,"!!")
 .D EN^DDIOL("field explaining the other technique.",,"!")
SH D EN^DDIOL("It has been determined that shaving the surgical site results in a greater",,"!!")
 D EN^DDIOL("likelihood of infection. Current best practices suggest that clippers should",,"!")
 D EN^DDIOL("be used instead of shaving. Whenever hair is removed by shaving, a comment must",,"!")
 D EN^DDIOL("be entered explaining why this process was used instead of safer techniques.",,"!")
HRC ; edit the associated comments fields
 N DR,DIE,DA,DP,DC,DL,DE,DI,DIEL,DIETMP,DIFLD,DIP,DK,DM,DP,DQ,DU,DV,DW
 W ! S DIE=130,DA=SRTN1,DR=508_"T" D ^DIE
 Q
