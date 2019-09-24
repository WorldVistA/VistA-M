GMRC123P ;;MS/PB/MJ - CCRA PRE INSTALL;APR 22, 2019
 ;;3.0;CONSULT/REQUEST TRACKING;**123**;APR 22, 2019;Build 51
 ;;Per VA directive 6402, this routine should not be modified.
 ;Pre install routine for patch GMRC*3.0*123.
 ;
 ;Checks for the CCRA-NAK logical link, if it exists, it doesn't re-install the link
 ;if it doesn't exist, it gets the HealthShare server address and port and installs
 ;and configures the link.
 Q
LINK ; update the TMP_Send Link
 N LIEN,OPSITE,DOMAIN,VAL,GMRCERR,FDA,PRE1,PRE2,X,STOP
 D MES^XPDUTL("Checking VistA system for CCRA-NAK logical link setup...")
 S VAL="CCRA-NAK",STOP=0
 S LIEN=$$FIND1^DIC(870,,"B",.VAL)
 I LIEN D MES^XPDUTL("Link already exists, no new setup needed") Q
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("CCRA-NAK logical link being set up now.  We'll need some information from you.")
 D MES^XPDUTL("Please have the HealthConnect server IP address and Port number ready.")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 ;
Q1 ; QUESTION 1 - IP ADDRESS - PRE 1
 S DIR("A")="PLEASE ENTER THE HEALTHCONNECT SERVER IP ADDRESS"
 S DIR(0)="F"
 D ^DIR S PRE1=X
 I $G(PRE1)="^"!($G(PRE1)="") D
 . N X,Y,DIR,DTOUT,DUOUT,DIRUT
 . S DIR(0)="Y"
 . S DIR("A",1)="Quitting out will result in the CCRA-NAK logical link not being installed."
 . S DIR("A",2)="The CCRA-NAK logical link is required and must be configured for this patch to work properly."
 . S DIR("A")="Are you sure you want to exit out of the PRE-install process?"
 . D ^DIR
 . S:$G(Y)'=0 STOP=1
 . G:$G(Y)=0 Q1
 . D APPERROR^%ZTER("pre-install Q1 after '^' entered on 2nd DIR call")
 . G:$G(STOP)=1 QABORT
 ;
Q2 ; QUESTION 2 - PORT NUMBER - PRE 2
 G:$G(STOP)=1 QABORT
 N X,Y,DIR,DTOUT,DUOUT,DIRUT
 S DIR("A")="PLEASE ENTER THE HEALTHCONNECT SERVER PORT NUMBER"
 S DIR(0)="F"
 D ^DIR S PRE2=X
 I $G(PRE2)="^"!($G(PRE2)="") D
 . N X,Y,DIR,DTOUT,DUOUT,DIRUT
 . S DIR(0)="Y"
 . S DIR("A",1)="Quitting out will result in the CCRA-NAK logical link not being installed."
 . S DIR("A",2)="The CCRA-NAK logical link is required and must be configured for this patch to work properly."
 . S DIR("A")="Are you sure you want to exit out of the PRE-install process?"
 . D ^DIR
 . S:$G(Y)'=0 STOP=1
 . G:$G(Y)=0 Q2
 G:$G(STOP)=1 QABORT
 ;
 ; file link with IP address and port entered
 K FDA,LIEN,GMRCERR
 S FDA(870,"+1,",.01)="CCRA-NAK"
 S FDA(870,"+1,",.02)=$$KSP^XUPARAM("INST") ; site station number
 S FDA(870,"+1,",2)=4              ; TCP/IP
 S FDA(870,"+1,",4.5)=1            ; auto start
 S FDA(870,"+1,",400.01)=$G(PRE1) ; ip address
 S FDA(870,"+1,",400.02)=$G(PRE2) ; hl7 port
 S FDA(870,"+1,",400.03)="C"       ; Client (Sender) TCP/IP Service Type
 ; S FDA(870,"+1,",400.08)=$G(PRE2) ; hlo port
 D UPDATE^DIE(,"FDA","LIEN","GMRCERR") K FDA
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when creating the CCCRA-NAK Link.")
 D MES^XPDUTL("CCRA-NAK Link has been updated.")
QEND K DIR Q
 ;
QABORT S XPDABORT=1 K DIR Q
