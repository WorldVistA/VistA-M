GMTSP112 ;BP/WAT - Pre/Post Init GMTS*2.7*112 ;03/26/15  05:27
 ;;2.7;Health Summary;**112**;Oct 20, 1995;Build 3
 ;post-install routine to add HS Components released in GMTS*2.7*99 to the PDX exchange process
 ;ICR reference
 ;2053, WP^DIE
 ;10141 B/MES^XPDUTL
 ;
POST ; do post
 D DOPDX
 D WPDIE
 Q
 ;
DOPDX ;add to PDX
 N GMTSNAME,GMTSTIML,GMTSOCCL,GMTSLIST,GMTSCNTR
 S GMTSLIST="MAS CONTACTS^MAS MH CLINIC VISITS FUTURE^MH HIGH RISK PRF HX^MH TREATMENT COORDINATOR^"
 F GMTSCNTR=1:1:4 D
 .S GMTSNAME=$P(GMTSLIST,U,GMTSCNTR),GMTSTIML="",GMTSOCCL="" D PDX^GMTSXPD5(GMTSNAME,GMTSTIML,GMTSOCCL)
 Q
 ;
WPDIE ;udpate CNB description field
 ;OLD DESCRIPTION:   This component displays Consults in a brief format, to include
 ;the consult number, request date, requesting service, last action, last action
 ;date, and the consult "TO" service.
 D BMES^XPDUTL("Updating the DESCRIPTION for the CNB component...")
 N FILE,IENS,FIELD,GMTSERR
 S FILE="142.1",IENS="240,",FIELD="3.5"
 K ^TMP($J,"CNB")
 S ^TMP($J,"CNB",1)="This component displays Consults in a brief format, to include the consult "
 S ^TMP($J,"CNB",2)="number, request date, requesting service, last action, clinically indicated "
 S ^TMP($J,"CNB",3)="date, last action date, and the consult ""TO"" service."
 D WP^DIE(FILE,IENS,FIELD,,"^TMP($J,""CNB"")")
 I $D(^TMP("DIERR",$J,1,"TEXT"))=10 D  Q
 .D BMES^XPDUTL("Recording an error has ocurred")
 .D MES^XPDUTL(^TMP("DIERR",$J,1,"TEXT",1))
 D BMES^XPDUTL("Update completed...")
 Q
