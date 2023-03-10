PREAPO2 ;BIR/RTR - Post Install routine for patch PREA*1*2 ; JUL 31, 2020
 ;;1.0;ADVANCED MEDICATION PLATFORM;**2,3**;9/1/20;Build 19
 ; Reference to ^XWB(8994.5 in ICR #5032
 ;
EN ;PREA*1*2 Post Install
 N PREAFLG
 S PREAFLG=1
 K ^TMP($J,"PREATXT")
 D BMES^XPDUTL("Adding ADVANCED MEDICATION PLATFORM to Remote Application File.")
 D ADD,MAIL
 D BMES^XPDUTL("Post-Installation Complete, please see VistA mail message for results.")
 Q
 ;
 ;
MAIL ;Send mail message
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ
 S XMSUB="PREA*1*2 Post Install ** "_$S(PREAFLG:"SUCCESSFUL",1:"UNSUCCESSFUL")_" **"
 S XMDUZ="PREA*1*2 Installation Message"
 S XMTEXT="^TMP($J,""PREATXT"","
 S XMY(DUZ)=""
 N DIFROM,DUZ D ^XMD
 K ^TMP($J,"PREATXT")
 Q
 ;
 ;
ADD ;Add Advanced Medication Platform entry to Remote Application File
 N PREAERR,PREARSLT,PREADATA,PREARIEN,PREASIEN
 ;Check for existing entry
 S PREARSLT=$$FIND1^DIC(8994.5,"","X","ADVANCED MEDICATION PLATFORM","B",,"PREAERR")
 I $D(PREAERR) D  Q
 .D ERR
 .S ^TMP($J,"PREATXT",4)="looking for an ADVANCED MEDICATION PLATFORM entry"
 .S ^TMP($J,"PREATXT",5)="in the REMOTE APPLICATION File:",^TMP($J,"PREATXT",6)=""
 .S ^TMP($J,"PREATXT",7)=$G(PREAERR("DIERR",1,"TEXT",1))
 .D BMES^XPDUTL("Problem with ADVANCED MEDICATION PLATFORM entry in REMOTE APPLICATION File.")
 I PREARSLT>0 D  Q
 .S ^TMP($J,"PREATXT",1)="Successful Post-Init, ADVANCED MEDICATION PLATFORM"
 .S ^TMP($J,"PREATXT",2)="entry already exists in the REMOTE APPLICATION File.",^TMP($J,"PREATXT",3)=""
 .S ^TMP($J,"PREATXT",4)="No further action required for patch PREA*1.0*2."
 .D BMES^XPDUTL("ADVANCED MEDICATION PLATFORM already exists in REMOTE APPLICATION File.")
 ;
 ;Add entry to file
 K PREARSLT D OPT Q:'PREAFLG
 K PREAERR
 S PREADATA(8994.5,"+1,",.01)="ADVANCED MEDICATION PLATFORM"
 S PREADATA(8994.5,"+1,",.02)=PREARSLT
 S PREADATA(8994.5,"+1,",.03)=$$SHAHASH^XUSHSH(256,"pharmacy gui application","B")
 D UPDATE^DIE("","PREADATA","PREARIEN","PREAERR")
 I $D(PREAERR)!('$G(PREARIEN(1))) D  Q
 .D ERR
 .S ^TMP($J,"PREATXT",4)="adding an ADVANCED MEDICATION PLATFORM entry to the REMOTE APPLICATION File:"
 .S ^TMP($J,"PREATXT",5)=""
 .S ^TMP($J,"PREATXT",6)=$G(PREAERR("DIERR",1,"TEXT",1))
 .D BMES^XPDUTL("Problem with adding ADVANCED MEDICATION PLATFORM to REMOTE APPLICATION File.")
 ;
 K PREADATA
 S PREADATA(8994.51,"+2,"_PREARIEN(1)_",",.01)="S"
 S PREADATA(8994.51,"+2,"_PREARIEN(1)_",",.02)="N/A"
 S PREADATA(8994.51,"+2,"_PREARIEN(1)_",",.03)="N/A"
 S PREADATA(8994.51,"+2,"_PREARIEN(1)_",",.04)="N/A"
 D UPDATE^DIE("","PREADATA","PREASIEN","PREAERR")
 I $D(PREAERR)!('$G(PREASIEN(2))) D  Q
 .D ERR
 .S ^TMP($J,"PREATXT",4)="adding an entry to the CALLBACKTYPE multiple to the ADVANCED MEDICATION"
 .S ^TMP($J,"PREATXT",5)="PLATFORM entry of the REMOTE APPLICATION File:"
 .S ^TMP($J,"PREATXT",6)=""
 .S ^TMP($J,"PREATXT",7)=$G(PREAERR("DIERR",1,"TEXT",1))
 .D BMES^XPDUTL("Problem with adding CALLBACKTYPE data to the ADVANCED MEDICATION")
 .D BMES^XPDUTL("PLATFORM entry of the REMOTE APPLICATION File.")
 S ^TMP($J,"PREATXT",1)="Successful Post-Init, ADVANCED MEDICATION PLATFORM"
 S ^TMP($J,"PREATXT",2)="entry has been added to the REMOTE APPLICATION File.",^TMP($J,"PREATXT",3)=""
 S ^TMP($J,"PREATXT",4)="No further action required for patch PREA*1.0*2."
 D BMES^XPDUTL("ADVANCED MEDICATION PLATFORM successfully added to REMOTE APPLICATION File.")
 Q
 ;
 ;
OPT ;find AMPL option
 N PREAOPC,PREAOPI
 K PREAERR
 S PREARSLT=$$FIND1^DIC(19,"","X","PREA AMPL GUI","B",,"PREAERR")
 I $D(PREAERR) D  Q
 .D ERR
 .S ^TMP($J,"PREATXT",4)="looking for a PREA AMPL GUI entry in the OPTION File:"
 .S ^TMP($J,"PREATXT",5)=""
 .S ^TMP($J,"PREATXT",6)=$G(PREAERR("DIERR",1,"TEXT",1))
 .D BMES^XPDUTL("Problem with the PREA AMPL GUI entry in OPTION File.")
 I PREARSLT'>0 D
 .S PREAFLG=0
 .S ^TMP($J,"PREATXT",1)="Unsuccessful Post-Init",^TMP($J,"PREATXT",2)=""
 .S ^TMP($J,"PREATXT",3)="The PREA AMPL GUI option was not found."
 .S ^TMP($J,"PREATXT",4)="Please contact the help desk."
 .D BMES^XPDUTL("The PREA AMPL GUI entry was not found in the OPTION File.")
 Q
 ;
 ;
ERR ;Error handling
 S PREAFLG=0
 S ^TMP($J,"PREATXT",1)="Unsuccessful Post-Init",^TMP($J,"PREATXT",2)=""
 S ^TMP($J,"PREATXT",3)="Please contact the help desk, the following error was generated when"
 Q
