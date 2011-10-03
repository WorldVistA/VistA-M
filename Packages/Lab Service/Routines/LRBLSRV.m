LRBLSRV ;DALLAS CIOFO/RLM/CYM - BLOOD BANK SERVER ;10/25/99  17:52 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
START ;
 K ^TMP($J,"LRBLDATA")
 S LRBLSITE=$P($$SITE^VASITE,U,2)
 ;Determine station number
 S LRBLSUB=$TR(XQSUB,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;Translate the subject into upper case and place it into a locally
 ;namespaced variable.
 S ^TMP("LRBL",$J,1,0)=LRBLSUB_" triggered at "_LRBLSITE_" by "_XMFROM_" on "_XQDATE
 ;The first line of the message tells who requested the action and when.
 S %DT="T",X="NOW" D ^%DT,DD^LRX S LRBLNOW=Y
 I XQSUB["REPORT" D ^LRBLINTG G EXIT
 K XMTEXT,XMSUB,LRBLSITE,LRBLNOW,XMY
 ;Call a routine based on the "Subject" line of the message.
 ;Skip the rest of the routine (down to exit) if the subject
 ;is a valid call.
 S LRBLSITE=$P($$SITE^VASITE,U,2)
 S ^TMP($J,"LRBLDATA",1)=""
 S ^TMP($J,"LRBLDATA",2)="Sorry, but I don't know how to "_XQSUB
 S ^TMP($J,"LRBLDATA",3)="No action taken"
 S XMY("G.bloodbank@ISC-CHICAGO.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT,DD^LRX S LRBLNOW=Y
 S XMSUB="Invalid BB Server Request From "_LRBLSITE_" run on "_LRBLNOW
 S XMTEXT="^TMP($J,""LRBLDATA"",",XMDUZ="Blood Bank Monitor" D ^XMD
 ;Send a message to the designated mail group if the server is triggered with
 ;an invalid command.  This lets the users know that they either made
 ;a typo, or that someone is attempting to improperly invoke the server.
EXIT K %DT,XMTEXT,XMSUB,LRBLSITE,LRBLNOW,XMY,^TMP($J,"LRBLDATA")
 Q
