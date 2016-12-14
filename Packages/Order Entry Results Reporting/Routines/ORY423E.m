ORY423E ;WAT/ISP env check for OR*3.0*423; ;06/29/16  06:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**423**;Dec 17, 1997;Build 19
 N DIR,ORCONT
 S ORCONT=0
 S DIR("A")="Continue"
 S DIR("A",1)="GMRCOR CONSULT in ORDER DIALOG (#101.41) will be overwritten."
 S DIR("?")="Please refer to the OR*3.0*423 patch description for details."
 S DIR("?",1)="GMRCOR CONSULT is being updated by this patch. The target system may have"
 S DIR("?",2)="local modifications to GMRCOR CONSULT. Installers should coordinate with"
 S DIR("?",3)="site personnel to ensure any local modifications have been backed up."
 S DIR("?",4)=""
 S ORCONT=$$QUES(.DIR)
 I $G(ORCONT)=0 D  Q
 . W !!,"OK - You have opted to abort the installation.",!
 . W !,"Transport global will be unloaded.",!
 . W !,"Please reload the distribution when you are ready.",!! H 3
 . S XPDABORT=1
 W !!,"Environment check complete. Install will proceed.",! H 2
 Q
QUES(DIR) ;
 ;ASK A QUESTION
 Q:$G(DIR("A"))=""
 N DIRUT,Y
 F  D  Q:$D(Y)
 .N X,DTOUT,DUOUT,DIROUT
 .S DIR(0)="Y"_U,DIR("B")="NO"
 .D ^DIR
 .I $D(DIRUT) W !,"A response is required.",! K Y
 Q $G(Y)
 ;
