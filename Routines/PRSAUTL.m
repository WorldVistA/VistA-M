PRSAUTL ; HISC/REL-Utilities ;6/4/93  11:19
 ;;4.0;PAID;**21**;Sep 21, 1995
 S USR="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN="" W !!,*7,"Your SSN was not found in the New Person File!" S TLI="" Q
 S USR=$O(^PRSPC("SSN",SSN,0))
TL ; Select T&L from among those allowed
 K DIC I PRSTLV>5 G P1
 S Z1=$S(PRSTLV=2:"T",PRSTLV="3":"S",1:"*")
 S TLI=$O(^PRST(455.5,"A"_Z1,DUZ,0)) I TLI<1 W !!,*7,"No T&L Units have been assigned to you!" Q
 I $O(^PRST(455.5,"A"_Z1,DUZ,TLI))<1 G P2
 S DIC("S")="I $D(^PRST(455.5,+Y,Z1,DUZ))"
P1 S DIC="^PRST(455.5,",DIC(0)="AEQM",DIC("A")="Select T&L Unit: " W ! D ^DIC K DIC I "^"[X!$D(DTOUT) S TLI="" Q
 G:Y<1 P1 S TLI=+Y
P2 S TLE=$P($G(^PRST(455.5,TLI,0)),"^",1) Q
QUE ; Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE S ZTRTN=PRSAPGM,ZTREQ="@"
 S ZTSAVE("ZTREQ")="",ZTSAVE("PRSTLV")="",ZTDESC=$P(XQY0,"^",1)
 F V3=1:1 S V1=$P(PRSALST,"^",V3) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",! K V1,V3,PRSAPGM,PRSALST,ZTSK Q
CONTINUE() ;ASK USER TO CONTINE
 ;
 S ANSWER=1
 S DIR("A")="Continue"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 I $D(DIRUT)!(Y=0) S ANSWER=0
 Q ANSWER
