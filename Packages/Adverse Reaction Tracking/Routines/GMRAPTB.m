GMRAPTB ;HIRMFO/RM-BULLETIN SEND FOR E/E REACTIONS ;5/10/96  08:04
 ;;4.0;Adverse Reaction Tracking;**2**;Mar 29, 1996
EN1 ; SEND BULLETIN TO P&T COMMITTEE
 ; This option is to fire of an alert to the P&T that a sign has changed
 Q:$G(GMRAPA)<1  ;Bad or invalid IEN
 S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""  ;No zero Node
 Q:$P(GMRAPA(0),U,6)'="o"  ;Check to see that reaction is observed
 Q:$P(GMRAPA(0),U,20)'["D"  ;Check to see that reaction is a drug type
 N GMRAPA1,GMRAPT,GMRAX
 ;Check to see if in 120.85
 S GMRAPA1=$O(^GMR(120.85,"C",GMRAPA,0)) Q:GMRAPA1<1
 Q:$G(^GMR(120.85,GMRAPA1,0))=""  ;No zero Node
 ;Check to see if the reaction has changed
 ;  v--Check for add reactions
 I $D(GMRARAD) S GMRAX=0 F  S GMRAX=$O(GMRARAD(GMRAX)) Q:GMRAX<1  S GMRAPT("ADD",$P(GMRARAD(GMRAX),U))=""
 ;  v--Check for other add reactions
 I $D(GMRAROT) S GMRATXT="" F  S GMRATXT=$O(GMRAROT(GMRATXT)) Q:GMRATXT=""  S GMRAPT("ADD",GMRATXT)=""
 ;  v--Check for deleted reactions
 I $D(GMRARDL) S GMRAX=0 F  S GMRAX=$O(GMRARDL(GMRAX)) Q:GMRAX<1  S GMRATXT=$P($G(^GMRD(120.83,GMRAX,0)),U) S:GMRATXT'="" GMRAPT("DELETE",GMRATXT)=""
 ;  v--Check for other deleted reactions
 I $D(GMRAROTD) S GMRATXT="" F  S GMRATXT=$O(GMRARAD(GMRATXT)) Q:GMRATXT=""  S GMRAPT("DELETE",GMRATXT)=""
 Q:'$D(GMRAPT)  ; Nothing was added or deleted
 D MAIL
 Q
MAIL ; INDICATING MEDWATCH FOR NEEDS TO BE UPDATED NEEDS UPDATES
 Q:'$D(GMRAPT)
 N GMRAGRUP,%,GMRANAM,GMRALOC,GMRASSN
 S GMRANAM="",GMRALOC="",GMRASSN=""
 D VAD^GMRAUTL1($P(GMRAPA(0),U),"",.GMRALOC,.GMRANAM,"",.GMRASSN)
 I GMRALOC'="",+$G(^DIC(42,GMRALOC,44)) S GMRALOC=$P($G(^SC(+$G(^DIC(42,GMRALOC,44)),0)),U)
 I GMRALOC="" S GMRALOC="OUT PATIENT"
 S XMB="GMRA SIGNS/SYMPTOMS UPDATE"
 ; Build XMB array
 S XMB(1)=GMRANAM ; Patient Name
 S XMB(2)=GMRASSN ; Patient SSN
 S XMB(3)=$P(GMRAPA(0),"^",2) ; Reaction
 S XMB(4)=GMRALOC ; Location
 S XMB(5)=$S($P(GMRAPA(0),U,5)'="":$P($G(^VA(200,$P(GMRAPA(0),U,5),0)),U),1:"<None>") ; Originator
 ; Get reactains that were changed
 K ^TMP($J,"GMRAPT")
 S GMRACNT=1,GMRASP="                                                                           "
 ; v--Add s/s
 I $D(GMRAPT("ADD")) K GMRAX D
 .S ^TMP($J,"GMRAPT",GMRACNT)="     The following Signs/Symptoms have been ADDED to this reaction:" S GMRACNT=GMRACNT+1
 .S GMRAX="" F  S GMRAX=$O(GMRAPT("ADD",GMRAX)) Q:GMRAX=""  S ^TMP($J,"GMRAPT",GMRACNT)="             "_GMRAX,GMRACNT=GMRACNT+1
 .Q
 ; v--Deleted s/s
 I $D(GMRAPT("DELETE")) K GMRAX D
 .S ^TMP($J,"GMRAPT",GMRACNT)="     The following Signs/Symptoms have been DELETED from this reaction:" S GMRACNT=GMRACNT+1
 .S GMRAX="" F  S GMRAX=$O(GMRAPT("DELETE",GMRAX)) Q:GMRAX=""  S ^TMP($J,"GMRAPT",GMRACNT)="             "_GMRAX,GMRACNT=GMRACNT+1
 .Q
 S XMTEXT="^TMP($J,""GMRAPT"","
 ; Build XMY array
 S XMY("G.GMRA P&T COMMITTEE FDA")=""
 D ^XMB
 K XMB,XMY,XMTEXT,GMRATEXT,^TMP($J,"GMRAPT")
 Q
