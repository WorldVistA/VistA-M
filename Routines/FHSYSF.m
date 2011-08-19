FHSYSF ; HISC/REL - File Manager Search/Print ;7/8/93  13:34 
 ;;5.5;DIETETICS;;Jan 28, 2005
PRNT ; File Manager Print
 D DICRW Q:Y<1  S L=1 D EN1^DIP G KIL
SRCH ; File Manager Search
 D DICRW Q:Y<1  D EN^DIS G KIL
DIC ; List Dictionary
 W ! D ^DID G KIL
INQ ; Inquire to File
 D DICRW Q:Y<1  S DI=DIC,DPP(1)=+Y_"^^^@",DK=+Y
 D B^DII G KIL
DICRW ; Select File
 K ^UTILITY($J),%,%ZIS,DTOUT,DC,O,N,R,BY,DA,DHD,DI,DIC,DPP,DK,DIQ,DIS,DUOUT,FR,L,TO
 D NOW^%DTC S DT=%\1 K %,%H,%I
 S DIC="^DIC(",DIC("S")="I +Y>109.99,+Y<120",DIC(0)="AEQM",DIC("A")="OUTPUT FROM WHAT FILE: "
 W ! D ^DIC K DIC I $D(DTOUT)!(Y<1) Q
 I $D(^DIC(+Y,0,"GL")) K DIC S DIC=^("GL") Q
 K DIC S Y=-1 Q
KIL ; Kill Variables
 G KILL^XUSCLEAN
