ECMFLOC ;ALB/JAM-Event Capture Management Location Filer ;16 Feb 01
 ;;2.0; EVENT CAPTURE ;**25**;8 May 96
 ;
FILE ;Used by the RPC broker to file local procedures in #4
 ;     Variables passed in
 ;       ECIEN  - Location IEN
 ;       ECST   - Location Status
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #4^Message
 ;
 N ECERR,ECNO
 S ECERR=0 D CHKDT I ECERR Q
 K DIC S DIC=4,DIC(0)="XN",X=ECIEN D ^DIC I Y<0 D  Q
 . S ^TMP($J,"ECMSG",1)="0^Location Not on File"
 I ECST="C" D
 . K DIE,DR S DIE=4,DR="720///1",DA=ECIEN D ^DIE
 . S ^TMP($J,"ECMSG",1)="1^Location flagged for Event Capture"
 I ECST="R" D
 . S ECNO=0 I '$D(^DIC(4,ECIEN,"EC")) S ECNO=1
 . I $D(^DIC(4,ECIEN,"EC")),+$P(^("EC"),"^")=0 S ECNO=1
 . I ECNO S ^TMP($J,"ECMSG",1)="0^Not flagged as current location." Q
 . K DIE,DR S DIE=4,DA=ECIEN,DR="720///@" D ^DIE
 . S ^TMP($J,"ECMSG",1)="1^Location inactivated for Event Capture"
 K DA,DR,DIE,DIC
 Q
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="ECIEN","ECST" D
 .I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
 ;
HFS ;Used by the RPC broker to add/update or delete an entry in the
 ;PARAMETER file #8989.5
 ;     Variables passed in
 ;       ECDIV  - Division IEN
 ;       ECHFS  - Directory/path
 ;       ECOPER - Operation (add/update or delete)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #8989.5^Message
 ;
 N ECERR,ECPAR
 S ECERR=0 D CHKDT1 I ECERR Q
 K DIC S DIC=4,DIC(0)="XN",X=ECDIV D ^DIC I Y<0 D  Q
 . S ^TMP($J,"ECMSG",1)="0^Division Not on File"
 I '$G(^DIC(4,ECDIV,"EC")) S ^TMP($J,"ECMSG",1)="0^Not an EC Division" Q
 S ECDIV=ECDIV_";DIC(4,",ECPAR="EC HFS SCRATCH"
 I ECOPER="A" D  Q
 . D EN^XPAR(ECDIV,ECPAR,,ECHFS,.ECERR)
 . I '+ECERR S ^TMP($J,"ECMSG",1)="1^Directory successful added" Q
 . S ^TMP($J,"ECMSG",1)="0^Error adding directory"
 I ECOPER="D" D
 . D NDEL^XPAR(ECDIV,ECPAR,.ECERR)
 . I '+ECERR S ^TMP($J,"ECMSG",1)="1^Directory successful deleted" Q
 . S ^TMP($J,"ECMSG",1)="0^Error deleting directory"
 Q
CHKDT1 ;Required Data Check
 N I,C
 S C=1
 F I="ECDIV","ECHFS","ECOPER" D
 .I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
