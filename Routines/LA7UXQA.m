LA7UXQA ;;DALOI/JMC - HL7 Utility - Send alert to users; Jan 12, 2004
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,67**;Sep 27, 1994
 ;
XQA(LA7CTYP,LA76248,LA762485,LA76249,LA7AMSG,LA7DATA,LA7PALRT) ; Send alert when requested.
 ; Input
 ;   LA7CTYP  - Condition for alert (1=New Results, 2=Error on message, 3=New Orders)
 ;   LA76248  - Pointer to file 62.48
 ;   LA762485 - Optional, pointer to file 62.485 if condition=2
 ;   LA76249  - Optional, pointer to file 62.49 if condition=2 or 3
 ;   LA7AMSG  - Optional, alert message if missing will use default message
 ;   LA7DATA  - Optional, pass values for specific conditions
 ;   LA7PALRT - Keep previous alerts (1-yes,0-no)
 ;
 ; Called by LA7LOG, LA7UIIN, LA7VORM, LRVRPOC, LA7VIN1
 ;
 N XQA,XQAID,XQADATA,XQAFLAG,XQAMSG,XQAOPT,XQAROU,X,Y
 S XQAMSG=$G(LA7AMSG)
 ;
 I $G(LA7CTYP)=1 D
 . S XQAID="LA7-CONFIG-"_$S($G(LA76248):LA76248,1:"UNKNOWN-"_$H)
 . I XQAMSG="" S XQAMSG="Lab Messaging - New results received for "_$P($G(^LAHM(62.48,+$G(LA76248),0),"UNKNOWN"),"^")
 ;
 I $G(LA7CTYP)=2 D
 . S XQAID="LA7-MESSAGE-"_$S($G(LA76249):LA76249,1:"UNKNOWN-"_$H)
 . I XQAMSG="" S XQAMSG="Lab Messaging error #"_$G(LA762485,"UNKNOWN")_" on message #"_$G(LA76249,"UNKNOWN")
 . I $G(LA76249) D  ; Error processing message, setup action alert.
 . . S XQAROU="DIS^LA7UXQA" ; Alert action.
 . . S XQADATA=LA76249 ; Alert data (ien of message in 62.49, date of error and error number).
 ;
 I $G(LA7CTYP)=3 D
 . S LA7DATA=$G(LA7DATA)
 . S XQAID="LA7-ORDERS-"_$S($L(LA7DATA):$P(LA7DATA,"^"),$G(LA76249):LA76249,1:"UNKNOWN-"_$H)
 . I XQAMSG="" S XQAMSG="Lab Messaging - Manifest# "_$P(LA7DATA,"^")_" received from "_$P($G(^LAHM(62.48,+$G(LA76248),0),"UNKNOWN"),"^")
 ;
 ; Determine mail group
 S X=""
 F  S X=$O(^LAHM(62.48,+$G(LA76248),20,"B",LA7CTYP,X)) Q:'X  D
 . S Y=$G(^LAHM(62.48,LA76248,20,X,0))
 . I $L($P(Y,"^",2)) S XQA("G."_$P(Y,"^",2))="" ; Send to mail group.
 ;
 ; Fail safe mail group when no mail group defined.
 I '$D(XQA) S XQA("G.LAB MESSAGING")=""
 ;
 ; Delete previous alerts with same id
 I '$G(LA7PALRT),$G(XQAID)'="" D DEL(XQAID)
 ;
 D SETUP^XQALERT
 Q
 ;
 ;
DEL(ID) ; Delete previous alerts if present
 ; Call with ID = alert id
 ; Clear previous alert with same pkg id.
 N XQAID,XQAMSG,XQAROU,XQADATA,XQA
 S XQAKLL=0
 S XQAID=ID
 D DELETEA^XQALERT
 Q
 ;
 ;
DIS ; Display alert.
 N DIR,I,J,K,LA7LIST,X,Y
 K ^TMP("DDB",$J),^TMP($J)
 I 'XQADATA W !,$C(7),"Missing message number, unable to proceed.",! Q
 I '$D(^LAHM(62.49,XQADATA)) W !,$C(7),"Message number# ",XQADATA," has been deleted, unable to proceed.",! Q
 S DIR(0)="YO",DIR("A")="Display message associated with this alert",DIR("B")="YES"
 D ^DIR K DIR
 I Y S LA7LIST(+XQADATA)="" D DEV^LA7UTILA
 Q
 ;
 ;
DISIC ; Display Integrity Checker alert.
 N DIR,I,J,K,LA7IC,X,Y
 I XQADATA="" D  Q
 . W !,$C(7),"Missing error report to display, unable to proceed.",!
 ;
 I '$D(^XTMP(XQADATA)) D  Q
 . W !,$C(7),"Message number# ",XQADATA," has been deleted, unable to proceed.",!
 ;
 S DIR(0)="YO",DIR("A")="Display Integrity Check Report associated with this alert",DIR("B")="YES"
 D ^DIR K DIR
 I Y S LA7IC=XQADATA D DEV^LA7CHKFP
 Q
