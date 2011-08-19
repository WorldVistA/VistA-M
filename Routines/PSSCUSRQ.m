PSSCUSRQ ;BIR/RTR-Request Customization changes ;04/01/09
 ;;1.0;PHARMACY DATA MANAGEMENT;**117**;9/30/97;Build 101
 ;
 ;Request customization changes
 ;
EN ;
 N DDWAUTO,DDWTAB,DWDISABL,DIWEPSE,DIWETXT,DDWLMAR,DDWRMAR,DDWRW,DDWC,DDWFLAGS,DIWESUB,DWLW,DWPK
 N J,%,D0,D1,D2,DG,DIC,DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT
 N PSSCQOUT,PSSCQANS,PSSCQPRM,PSSCQPMM,PSSCQVIS,PSSCQVAL,PSSCQCCT
 S PSSCQOUT=0
 K DIR S DIR(0)="SO^N:New Drug Interaction;S:Drug Interaction Severity Change;T:Duplicate Therapy Change;D:Dosing Change",DIR("A")="Select one of the above"
 S DIR("?")=" ",DIR("?",1)="Enter 'N' to request that a new Drug/Drug interaction be added, enter 'S' to"
 S DIR("?",2)="request a severity change to an existing Drug/Drug interaction, enter 'T' to",DIR("?",3)="request a Duplicate Therapy change, enter 'D' to request a Dosing change."
 ;DOSING - When Dosing comes out, uncomment previous 3 lines, delete next 3 lines
 ;K DIR S DIR(0)="SO^N:New Drug Interaction;S:Drug Interaction Severity Change;T:Duplicate Therapy Change",DIR("A")="Select one of the above"
 ;S DIR("?")=" ",DIR("?",1)="Enter 'N' to request that a new Drug/Drug interaction be added, enter 'S' to"
 ;S DIR("?",2)="request a severity change to an existing Drug/Drug interaction, enter 'T' to",DIR("?",3)="request a Duplicate Therapy change."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS Q
 I Y'="N",Y'="S",Y'="T",Y'="D" D MESS Q
 ;DOSING - When Dosing comes out, uncomment previous line, delete next line
 ;I Y'="N",Y'="S",Y'="T" D MESS Q
 S PSSCQANS=Y
 D FIN
 I PSSCQANS="N" D NDI D FIN D:PSSCQOUT MESS Q
 I PSSCQANS="S" D DISC D FIN D:PSSCQOUT MESS Q
 I PSSCQANS="T" D DTC D FIN D:PSSCQOUT MESS Q
 ;DOSING - Uncomment next line when Dosing comes out
 I PSSCQANS="D" D DC D FIN D:PSSCQOUT MESS
 Q
 ;
 ;
MESS ;Exit Message
 W !!,"No Action Taken.",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
 ;
NDI ;New Drug Interaction
 N PSSCQNDD,PSSCQNSV
 W ! K DIR,Y S DIR(0)="FO^1:78",DIR("A")="Enter Interacting Drug Names (free text)",DIR("?")=" ",DIR("?",1)="Enter the names of the Drugs for the new Drug/Drug Interaction"
 S DIR("?",2)="that you are requesting, 1 to 78 characters."
 D ^DIR K DIR I $D(DIRUT)!($D(DUOUT))!($D(DTOUT)) S PSSCQOUT=1 Q
 S PSSCQNDD=Y
 ;
 K DIR,Y S DIR(0)="SO^1:Critical;2:Significant",DIR("A")="Enter Severity"
 S DIR("?")=" ",DIR("?",1)="Enter '1' to request that this new Drug/Drug interaction be classified"
 S DIR("?",2)="as Critical, enter '2' to request it be classified as Significant."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S PSSCQOUT=1 Q
 I Y'=1,Y'=2 S PSSCQOUT=1 Q
 S PSSCQNSV=Y
 ;
 W !!,"You must now enter a reason or references for this request. <word processing>",!
 K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSCQOUT=1 Q
 W ! D KLWRD S DIWESUB="References/Reason for Request",DWLW=78,DWPK=1,DIC="^TMP($J,""PSSCQWP""," D EN^DIWE
 I '$D(^TMP($J,"PSSCQWP")) W !!,"No data was entered." S PSSCQOUT=1 Q
 ;
 W ! S PSSCQPRM=1 D TEST(PSSCQPRM)
 Q
 ;
 ;
DISC ;Drug Interaction Severity Change
 N PSSCQSDD,PSSCQSSV
 W ! K DIR,Y S DIR(0)="FO^1:78",DIR("A")="Enter Interacting Drug Names (free text)",DIR("?")=" ",DIR("?",1)="Enter the names of the Drugs of the Drug/Drug Interaction that you"
 S DIR("?",2)="would like to see the severity changed for, 1 to 78 characters."
 D ^DIR K DIR I $D(DIRUT)!($D(DUOUT))!($D(DTOUT)) S PSSCQOUT=1 Q
 S PSSCQSDD=Y
 ;
 K DIR,Y S DIR(0)="SO^1:Critical;2:Significant",DIR("A")="Change Severity To"
 S DIR("?")=" ",DIR("?",1)="Enter '1' to request that this Drug/Drug interaction severity be changed"
 S DIR("?",2)="to Critical, enter '2' to request it be changed to Significant."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S PSSCQOUT=1 Q
 I Y'=1,Y'=2 S PSSCQOUT=1 Q
 S PSSCQSSV=Y
 ;
 W !!,"You must now enter a reason or references for this request. <word processing>",!
 K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSCQOUT=1 Q
 W ! D KLWRD S DIWESUB="References/Reason for Request",DWLW=78,DWPK=1,DIC="^TMP($J,""PSSCQWP""," D EN^DIWE
 I '$D(^TMP($J,"PSSCQWP")) W !!,"No data was entered." S PSSCQOUT=1 Q
 ;
 W ! S PSSCQPRM=2 D TEST(PSSCQPRM)
 Q
 ;
 ;
DTC ;Duplicate Therapy Change
 W !!,"You must now enter a description of the change/problem. <word processing>",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSCQOUT=1 Q
 W ! D KLWRD S DIWESUB="Description of change/problem",DWLW=78,DWPK=1,DIC="^TMP($J,""PSSCQWP""," D EN^DIWE
 I '$D(^TMP($J,"PSSCQWP")) W !!,"No data was entered." S PSSCQOUT=1 Q
 ;
 W ! S PSSCQPRM=3 D TEST(PSSCQPRM)
 Q
 ;
 ;
DC ;Dosing Change
 ;DOSING - This code should never be called until Dosing comes out, when it does remove next line (Quit)
 ;Q
 W !!,"You must now enter a description of the change/problem. <word processing>",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSCQOUT=1 Q
 W ! D KLWRD S DIWESUB="Description of change/problem",DWLW=78,DWPK=1,DIC="^TMP($J,""PSSCQWP""," D EN^DIWE
 I '$D(^TMP($J,"PSSCQWP")) W !!,"No data was entered." S PSSCQOUT=1 Q
 ;
 W ! S PSSCQPRM=4 D TEST(PSSCQPRM)
 Q
 ;
 ;
FIN ;Clean Up
 K ^TMP($J,"PSSCQTXT")
 K ^TMP($J,"PSSCQWP")
 Q
 ;
 ;
TEST(PSSCQPMM) ;Prompt to send Mail Message
 ;For Dosing, add a check for 4 in the next line
 I PSSCQPMM'=1,PSSCQPMM'=2,PSSCQPMM'=3,PSSCQPMM'=4 W !!,"Problem with option, please enter a Remedy ticket." S PSSCQOUT=1 Q
 S PSSCQCCT=1
 I '$$PROD^XUPROD S PSSCQCCT=0 W !!,"NOTE: This is a test account. Regardless of your response to the 'Transmit'",!,"prompt, this request will NOT be sent forward for national review.",!
 K DIR,Y S DIR(0)="Y",DIR("B")="Y"
 S DIR("A")=$S(PSSCQPMM=1:"Transmit New Drug Interaction Request",PSSCQPMM=2:"Transmit Drug Interaction Severity Change Request",PSSCQPMM=3:"Transmit Duplicate Therapy Change Request",PSSCQPMM=4:"Transmit Dosing Change Request",1:"Transmit")
 ;DOSING - when dosing comes out, remove next line and uncomment previous line
 ;S DIR("A")=$S(PSSCQPMM=1:"Transmit New Drug Interaction Request",PSSCQPMM=2:"Transmit Drug Interaction Severity Change Request",PSSCQPMM=3:"Transmit Duplicate Therapy Change Request",1:"Transmit")
 S DIR("?")=" ",DIR("?",1)="Enter 'Y' to transmit this request for review. (For production accounts only)"
 S DIR("?",2)="If you enter 'N', the message will sent to you only, in Vista mail.",DIR("?",3)="Enter '^' to exit, and not send the message."
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S PSSCQOUT=1 Q
 S PSSCQVIS=0
 I Y'=1 S PSSCQVIS=1 D SEND(PSSCQPMM) W !!,"Mail message only sent to you in Vista Mail.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 D SEND(PSSCQPMM) W !!,"Mail message transmitted for review.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
 ;
SEND(PSSCQVAL) ;Send Mail Message
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMDUN,DIFROM,XMYBLOB,XMZ,PSSCQLP,PSSCQCNT
 I PSSCQVAL=1 D NDITXT G PASS
 I PSSCQVAL=2 D DISCTXT G PASS
 I PSSCQVAL=3 D DTCTXT G PASS
 ;DOSING - when Dosing comes out, uncomment next line
 I PSSCQVAL=4 D DCTXT
PASS ;
 S XMSUB=$S(PSSCQVAL=1:"New Drug Interaction Request",PSSCQVAL=2:"Drug Interaction Severity Change Request",PSSCQVAL=3:"Duplicate Therapy Change Request",PSSCQVAL=4:"Dosing Change Request",1:"Unknown Request")
 ;DOSING - when Dosing comes out, remove next line and uncomment previous line
 ;S XMSUB=$S(PSSCQVAL=1:"New Drug Interaction Request",PSSCQVAL=2:"Drug Interaction Severity Change Request",PSSCQVAL=3:"Duplicate Therapy Change Request",1:"Unknown Request")
 S XMDUZ=DUZ
 S XMTEXT="^TMP($J,""PSSCQTXT"","
 S XMY(DUZ)=""
 I 'PSSCQVIS,PSSCQCCT S XMY("VAOITVHITPSCUSTOMREQ@va.gov")=""
 D ^XMD
 Q
 ;
 ;
NDITXT ;Format text message for New Drug Interaction
 S ^TMP($J,"PSSCQTXT",1,0)="Request New Drug Interaction:"
 S ^TMP($J,"PSSCQTXT",2,0)=$G(PSSCQNDD)
 S ^TMP($J,"PSSCQTXT",3,0)=" "
 S ^TMP($J,"PSSCQTXT",4,0)="Severity:"
 S ^TMP($J,"PSSCQTXT",5,0)=$S($G(PSSCQNSV)=1:"CRITICAL",$G(PSSCQNSV)=2:"SIGNIFICANT",1:"UNKNOWN")
 S ^TMP($J,"PSSCQTXT",6,0)=" "
 S PSSCQCNT=7
 F PSSCQLP=0:0 S PSSCQLP=$O(^TMP($J,"PSSCQWP",PSSCQLP)) Q:'PSSCQLP  S ^TMP($J,"PSSCQTXT",PSSCQCNT,0)=$G(^TMP($J,"PSSCQWP",PSSCQLP,0)) S PSSCQCNT=PSSCQCNT+1
 Q
 ;
 ;
DISCTXT ;Format text message for Drug Interaction Severity Change
 S ^TMP($J,"PSSCQTXT",1,0)="Drug-Drug Interaction:"
 S ^TMP($J,"PSSCQTXT",2,0)=$G(PSSCQSDD)
 S ^TMP($J,"PSSCQTXT",3,0)=" "
 S ^TMP($J,"PSSCQTXT",4,0)="Severity Change To:"
 S ^TMP($J,"PSSCQTXT",5,0)=$S($G(PSSCQSSV)=1:"CRITICAL",$G(PSSCQSSV)=2:"SIGNIFICANT",1:"UNKNOWN")
 S ^TMP($J,"PSSCQTXT",6,0)=" "
 S PSSCQCNT=7
 F PSSCQLP=0:0 S PSSCQLP=$O(^TMP($J,"PSSCQWP",PSSCQLP)) Q:'PSSCQLP  S ^TMP($J,"PSSCQTXT",PSSCQCNT,0)=$G(^TMP($J,"PSSCQWP",PSSCQLP,0)) S PSSCQCNT=PSSCQCNT+1
 Q
 ;
 ;
DTCTXT ;Format text message for Duplicate Therapy Change
 S ^TMP($J,"PSSCQTXT",1,0)="Duplicate Therapy Change Description/Problem:"
 S ^TMP($J,"PSSCQTXT",2,0)=" "
 S PSSCQCNT=3
 F PSSCQLP=0:0 S PSSCQLP=$O(^TMP($J,"PSSCQWP",PSSCQLP)) Q:'PSSCQLP  S ^TMP($J,"PSSCQTXT",PSSCQCNT,0)=$G(^TMP($J,"PSSCQWP",PSSCQLP,0)) S PSSCQCNT=PSSCQCNT+1
 Q
 ;
 ;
DCTXT ;Format text message for Dosing Change
 ;DOSING - Should never be called until Dosing comes out. When Dosing does come out, remove next line (Quit)
 ;Q
 S ^TMP($J,"PSSCQTXT",1,0)="Dosing Change Description/Problem:"
 S ^TMP($J,"PSSCQTXT",2,0)=" "
 S PSSCQCNT=3
 F PSSCQLP=0:0 S PSSCQLP=$O(^TMP($J,"PSSCQWP",PSSCQLP)) Q:'PSSCQLP  S ^TMP($J,"PSSCQTXT",PSSCQCNT,0)=$G(^TMP($J,"PSSCQWP",PSSCQLP,0)) S PSSCQCNT=PSSCQCNT+1
 Q
 ;
 ;
KLWRD ;
 K DDWAUTO,DDWTAB,DWDISABL,DIWEPSE,DIWETXT,DDWLMAR,DDWRMAR,DDWRW,DDWC,DDWFLAGS,DIWESUB,DWLW,DWPK,DIC
 K ^TMP($J,"PSSCQWP")
 Q
