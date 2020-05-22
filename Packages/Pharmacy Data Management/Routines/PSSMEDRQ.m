PSSMEDRQ ;BIR/RTR-Request New Standard Medication Route ;10/17/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129,147,164,240**;9/30/97;Build 1
 ;
 ; 11/08/19 KAM PSS*1*240 - Change the URL (Website) for Requesting a
 ;                          Medication Route change
 ;
REQ ;Request Med Route change
 D WLINK Q
 N DDWAUTO,DDWTAB,DWDISABL,DIWEPSE,DIWETXT,DDWLMAR,DDWRMAR,DDWRW,DDWC,DDWFLAGS,PSSTACCT
 N J,%,D0,D1,D2,DG,DIC,DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT,DIWESUB,DWLW,DWPK,PSSMQANS,PSSMQOUT,PSSMQIEN,PSSMQNME,PSSMQNDU,PSSMQFDB,PSSMQMED,PSSMQTXT,PSSMQVIS
 K PSSMQANS,PSSMQOUT,PSSMQIEN,PSSMQNME,PSSMQNDU,PSSMQFDB,PSSMQMED,PSSMQTXT,PSSMQVIS
 S PSSMQOUT=0
 K DIR S DIR(0)="SO^N:New Medication Route;C:Change to Existing Medication Route",DIR("A")="Request New Medication Route or Change existing Medication Route",DIR("B")="N"
 S DIR("?")=" ",DIR("?",1)="Enter 'N' to request that a new Medication Route be added to the"
 S DIR("?",2)="STANDARD MEDICATION ROUTES (#51.23) File, enter 'C' to request a change",DIR("?",3)="to an existing entry in the STANDARD MEDICATION ROUTES (#51.23) File."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS Q
 I Y'="N",Y'="C" D MESS Q
 S PSSMQANS=Y
 I PSSMQANS="C" W ! K DIC S DIC=51.23,DIC(0)="QEAMZ" D ^DIC K DIC S PSSMQIEN=+Y I Y<0!($D(DUOUT))!($D(DTOUT)) D MESS Q
 I PSSMQANS="C" S PSSMQNME=$P($G(^PS(51.23,PSSMQIEN,0)),"^")
 I PSSMQANS="N" D NEWMR I PSSMQOUT D MESS Q
 W ! K DIR,PSSMQMED S DIR(0)="FO^1:78",DIR("A",1)="Give an example of a medication administered by this route (optional).",DIR("A")="Medication (Free Text)",DIR("?")=" ",DIR("?",1)="Give an example of a medication that would be administered"
 S DIR("?",2)=$S(PSSMQANS="N":"by the new Medication Route you are requesting, 1 to 78 characters.",1:"by the Medication Route you are requesting a change to, 1 to 78 characters.")
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S PSSMQOUT=1 D MESS Q
 S PSSMQMED=Y
 I $G(PSSMQMED)'="" S PSSMQMED=$$UP^XLFSTR(PSSMQMED)
 W !!,"You'll now be prompted for a reason or references for this request (optional).",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y D MESS Q
 W ! K ^TMP($J,"PSSMQTXT") K DIC S DIWESUB="References/Reason for Request",DWLW=78,DWPK=1,DIC="^TMP($J,""PSSMQTXT""," D EN^DIWE
 W ! D TEST K DIR S DIR(0)="Y",DIR("A")="Transmit Medication Route Request",DIR("B")="Y"
 S DIR("?")=" ",DIR("?",1)="Enter 'Y' to transmit this request for review. (For production accounts only)"
 S DIR("?",2)="If you enter 'N', the message will be sent to you only, in Vista mail.",DIR("?",3)="Enter '^' to exit, and not send the message."
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) D KLM D MESS Q
 S PSSMQVIS=0
 I Y'=1 S PSSMQVIS=1 D SENDRT W !!,"Mail message only sent to you in Vista Mail.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 D SENDRT W !!,"Mail message transmitted for review.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
SENDRT ;Send Med Route Mail Message
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMDUN,PSSMQLP,PSSMQCNT
 K ^TMP($J,"PSSMQSND")
 S ^TMP($J,"PSSMQSND",1,0)=$S(PSSMQANS="N":"Request New Medication Route:",PSSMQANS="C":"Request Medication Route Change For:",1:"Medication Route Request:")
 S ^TMP($J,"PSSMQSND",2,0)=$S(PSSMQANS="N":$G(PSSMQNDU),PSSMQANS="C":$G(PSSMQNME),1:"Unknown")
 S ^TMP($J,"PSSMQSND",3,0)=" "
 S ^TMP($J,"PSSMQSND",4,0)="Medication:"
 S ^TMP($J,"PSSMQSND",5,0)=$S($G(PSSMQMED)'="":$G(PSSMQMED),1:"<None Entered>")
 S PSSMQCNT=7 S ^TMP($J,"PSSMQSND",6,0)=" "
 F PSSMQLP=0:0 S PSSMQLP=$O(^TMP($J,"PSSMQTXT",PSSMQLP)) Q:'PSSMQLP  S ^TMP($J,"PSSMQSND",PSSMQCNT,0)=$G(^TMP($J,"PSSMQTXT",PSSMQLP,0)) S PSSMQCNT=PSSMQCNT+1
 K ^TMP($J,"PSSMQTXT")
 S XMSUB="Medication Route Request"
 S XMDUZ=DUZ
 S XMTEXT="^TMP($J,""PSSMQSND"","
 S XMY(DUZ)=""
 I 'PSSMQVIS,PSSTACCT S XMY("VAOITVHITHDSSTSPEPSNTRT@domain.ext")=""
 D ^XMD
 K ^TMP($J,"PSSMQSND")
 Q
 ;
KLM ;Kill Med Route TMP global
 K ^TMP($J,"PSSMQTXT")
 Q
 ;
NEWMR ;New Med Route
 W ! K DIR,PSSMQNDU S DIR(0)="FO^3:50",DIR("A")="Enter Medication Route name",DIR("?")=" ",DIR("?",1)="Enter the name of the Medication Route you are requesting to be added"
 S DIR("?",2)="to the STANDARD MEDICATION ROUTES (#51.23) File, 3 to 50 characters."
 D ^DIR K DIR I $D(DIRUT)!($D(DUOUT))!($D(DTOUT)) S PSSMQOUT=1 Q
 S PSSMQNDU=Y
 S PSSMQNDU=$$UP^XLFSTR(PSSMQNDU)
 I $L(PSSMQNDU)>50!($L(PSSMQNDU)<3)!($E(PSSMQNDU,1)=" ")!($E(PSSMQNDU,$L(PSSMQNDU))=" ")!(PSSMQNDU["  ")!(PSSMQNDU'?.UNP)!'(PSSMQNDU'?1P.E) D  G NEWMR
 .W !!!,"The Medication Route must be 3-50 characters in length, comprised only of"
 .W !,"uppercase letters, numeric's, and punctuation, but no leading punctuation,"
 .W !,"and contain no leading, trailing, or consecutive spaces.",!
 I $O(^PS(51.23,"B",PSSMQNDU,0)) D  S PSSMQOUT=1 Q
 .W !!,PSSMQNDU_" is already an entry in the",!,"STANDARD MEDICATION ROUTES (#51.23) File. To request a change to this entry"
 .W !,"re-enter this option and select 'Change to Existing Medication Route'."
 S PSSMQFDB=$O(^PS(51.23,"C",PSSMQNDU,0)) I PSSMQFDB D  S PSSMQOUT=1 Q
 .W !!,PSSMQNDU_" is already a First DataBank Med Route",!,"in the STANDARD MEDICATION ROUTES (#51.23) File for",!
 .W $P($G(^PS(51.23,+$G(PSSMQFDB),0)),"^")_". To request a change to this",!,"entry, re-enter this option and select 'Change to Existing Medication Route'."
 Q
 ;
 ;
DOSE ;Request Dose Unit change
 N DDWAUTO,DDWTAB,DWDISABL,DIWEPSE,DIWETXT,DDWLMAR,DDWRMAR,DDWRW,DDWC,DDWFLAGS,PSSTACCT
 N J,%,D0,D1,D2,DG,DIC,DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT,PSSRQANS,PSSRQIEN,PSSRQOUT,PSSRQNDU,PSSRQSYN,PSSRQFDB,PSSRQVIS,PSSRQNME,DIWESUB,DWLW,DWPK
 K PSSRQANS,PSSRQIEN,PSSRQOUT,PSSRQNDU,PSSRQSYN,PSSRQFDB,PSSRQVIS,PSSRQNME
 S PSSRQOUT=0
 K DIR S DIR(0)="SO^N:New Dose Unit;C:Change to Existing Dose Unit",DIR("A")="Request New Dose Unit or Change existing Dose Unit",DIR("B")="N"
 S DIR("?")=" ",DIR("?",1)="Enter 'N' to request that a new Dose Unit be added to the DOSE UNITS"
 S DIR("?",2)="(#51.24) File, enter 'C' to request a change to an existing entry",DIR("?",3)="in the DOSE UNITS (#51.24) File."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS Q
 I Y'="N",Y'="C" D MESS Q
 S PSSRQANS=Y
 I PSSRQANS="C" W ! K DIC S DIC=51.24,DIC(0)="QEAMZ",D="UPCASE" D IX^DIC K DIC,D S PSSRQIEN=+Y I Y<0!($D(DUOUT))!($D(DTOUT)) D MESS Q
 I PSSRQANS="C" S PSSRQNME=$P($G(^PS(51.24,PSSRQIEN,0)),"^")
 I PSSRQANS="N" D NEW I PSSRQOUT D MESS Q
 W !!,"You must now enter a reason or references for this request.",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y D MESS Q
 W ! K ^TMP($J,"PSSRQTXT") K DIC S DIWESUB="References/Reason for Request",DWLW=78,DWPK=1,DIC="^TMP($J,""PSSRQTXT""," D EN^DIWE
 I '$D(^TMP($J,"PSSRQTXT")) W !!,"No data was entered." D KL D MESS Q
 W ! D TEST K DIR S DIR(0)="Y",DIR("A")="Transmit Dose Unit Request",DIR("B")="Y"
 S DIR("?")=" ",DIR("?",1)="Enter 'Y' to transmit this request for review. (For production accounts only)"
 S DIR("?",2)="If you enter 'N', the message will sent to you only, in Vista mail.",DIR("?",3)="Enter '^' to exit, and not send the message."
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) D KL D MESS Q
 S PSSRQVIS=0
 I Y'=1 S PSSRQVIS=1 D SEND W !!,"Mail message only sent to you in Vista Mail.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 D SEND W !!,"Mail message transmitted for review.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
KL ;Kill Dose Unit TMP global
 K ^TMP($J,"PSSRQTXT")
 Q
 ;
MESS ;Exit Message
 W !!,"No Action Taken.",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
NEW ;New Dose Unit
 W ! K DIR,PSSRQNDU S DIR(0)="FO^1:30",DIR("A")="Enter Dose Unit name",DIR("?")=" ",DIR("?",1)="Enter the name of the Dose Unit you are requesting"
 S DIR("?",2)="to be added to the DOSE UNITS (#51.24) File, 1 to 30 characters."
 D ^DIR K DIR I $D(DIRUT)!($D(DUOUT))!($D(DTOUT)) S PSSRQOUT=1 Q
 S PSSRQNDU=Y
 S PSSRQNDU=$$UP^XLFSTR(PSSRQNDU)
 I $L(PSSRQNDU)>30!($L(PSSRQNDU)<1)!($E(PSSRQNDU,1)=" ")!($E(PSSRQNDU,$L(PSSRQNDU))=" ")!(PSSRQNDU["  ")!(PSSRQNDU'?.ANP)!'(PSSRQNDU'?1P.E) D  G NEW
 .W !!!,"The Dose Unit must be 1-30 characters in length, comprised of upper and lower-"
 .W !,"case letters, numeric's, and punctuation, but no leading punctuation, and"
 .W !,"contain no leading, trailing, or consecutive spaces.",!
 I $O(^PS(51.24,"B",PSSRQNDU,0)) D  S PSSRQOUT=1 Q
 .W !!,PSSRQNDU_" is already an entry in the DOSE UNITS (#51.24)"
 .W !,"File. To request a change to this entry, re-enter this option and",!,"select 'Change to Existing Dose Unit'."
 S PSSRQSYN=$O(^PS(51.24,"D",PSSRQNDU,0)) I PSSRQSYN D  S PSSRQOUT=1 Q
 .W !!,PSSRQNDU_" is already a synonym in the DOSE UNITS (#51.24)"
 .W !,"File for "_$P($G(^PS(51.24,+$G(PSSRQSYN),0)),"^")_". To request a change to this entry,"
 .W !,"re-enter this option and select 'Change to Existing Dose Unit'."
 S PSSRQFDB=$O(^PS(51.24,"C",PSSRQNDU,0)) I PSSRQFDB D  S PSSRQOUT=1 Q
 .W !!,PSSRQNDU_" is already a First DataBank Dose Unit",!,"in the DOSE UNITS (#51.24) File for "_$P($G(^PS(51.24,+$G(PSSRQFDB),0)),"^")_"."
 .W !,"To request a change to this entry, re-enter this option and select",!,"'Change to Existing Dose Unit'."
 Q
 ;
SEND ;Send Dose Unit Mail Message
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMDUN,DIFROM,XMYBLOB,XMZ,PSSRQLP,PSSRQCNT
 K ^TMP($J,"PSSRQSND")
 S ^TMP($J,"PSSRQSND",1,0)=$S(PSSRQANS="N":"Request New Dose Unit:",PSSRQANS="C":"Request Dose Unit Change For:",1:"Dose unit Request:")
 S ^TMP($J,"PSSRQSND",2,0)=$S(PSSRQANS="N":$G(PSSRQNDU),PSSRQANS="C":$G(PSSRQNME),1:"Unknown")
 S ^TMP($J,"PSSRQSND",3,0)=" "
 S PSSRQCNT=4
 F PSSRQLP=0:0 S PSSRQLP=$O(^TMP($J,"PSSRQTXT",PSSRQLP)) Q:'PSSRQLP  S ^TMP($J,"PSSRQSND",PSSRQCNT,0)=$G(^TMP($J,"PSSRQTXT",PSSRQLP,0)) S PSSRQCNT=PSSRQCNT+1
 K ^TMP($J,"PSSRQTXT")
 S XMSUB="Dose Unit Request"
 S XMDUZ=DUZ
 S XMTEXT="^TMP($J,""PSSRQSND"","
 S XMY(DUZ)=""
 I 'PSSRQVIS,PSSTACCT S XMY("VAOITVHITPSDOSEUNITREQ@domain.ext")=""
 D ^XMD
 K ^TMP($J,"PSSRQSND")
 Q
 ;
TEST ;
 S PSSTACCT=1
 I '$$PROD^XUPROD S PSSTACCT=0 W !!,"NOTE: This is a test account. Regardless of your response to the 'Transmit'",!,"prompt, this request will NOT be sent forward for national review.",!
 Q
 ;
 ;
WLINK ;Refer to website with patch PSS*1*147
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 W !!!,"Standard Medication Route requests must now be made at the following website:",!
 ; 11/08/19 PSS*1*240 Changed the URL (Website) on next line
 W !?3,"https://vaww.vashare.domain.ext/sites/ntrt/SitePages/Home.aspx",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
