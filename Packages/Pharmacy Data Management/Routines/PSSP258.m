PSSP258 ;HDSO/DSK - PATCH PSS*1*258 Post-Install ; Jan 19, 2023@15:30
 ;;1.0;PHARMACY DATA MANAGEMENT;**258**;9/30/97;Build 9
 ;
 ;Reference to ^XOB(18.12 in ICR #7414
 Q
 ;
EN ; post install actions
 N PSSLINE S PSSLINE=0
 K ^TMP("PSS258P",$J)
 ;
 ;Store backup data for backing out the patch
 K ^XTMP("PSSP258B")
 S ^XTMP("PSSP258B",0)=$$FMADD^XLFDT(DT,180)_"^"_DT_"^PSS*1.0*258 Post-Install"
 ;
 D WS,MAIL
 K ^TMP("PSS258P",$J)
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSSLINE=PSSLINE+1,^TMP("PSS258P",$J,PSSLINE)=TXT
 Q
 ;
WS ; Web Service update
 N PSSIEN,PSSTYPE,PSSFLAG,PSSNAME,PSSCNT,PSSDATA,FDA,PSSERR,PSSTXT,PSSOLDSSL,PSSOLDADR
 S PSSTYPE=$G(XPDQUES("POS1")) ;Get the site type entered in the Installation question POS1 
 ; PSSTYPE will be a value of 1-4 (PRE-PROD, SQA, STAGE, DEVELOPMENT) (if no value, this is a PRODUCTION system)
 I 'PSSTYPE S PSSTYPE=5
 S PSSNAME=$S(PSSTYPE=1:"PRE-PROD",PSSTYPE=2:"SQA",PSSTYPE=3:"STAGING",PSSTYPE=4:"DEVELOPMENT",1:"PRODUCTION")
 S PSSFLAG=0
 F PSSCNT=1:1 Q:PSSFLAG  S PSSDATA=$P($T(WEBS+PSSCNT),";;",2) D
 . I PSSTYPE=$P(PSSDATA,";") S PSSFLAG=1
 S PSSIEN=$$FIND1^DIC(18.12,,"B","PPSN")
 ;not likely that PPSN not defined, but checking anyway
 I 'PSSIEN D  Q
 . S PSSTXT="Update of PPSN web server not performed since PPSN web server not defined."
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 ;Some sites might have performed the updates manually without waiting for the patch (per
 ;email communications). If SSL configuration was updated, server would have been also,
 ;so no need to check both.
 I $$GET1^DIQ(18.12,PSSIEN,3.02)="encrypt_only_tlsv12" D  Q
 . S PSSTXT="Update of PPSN web server not needed since updates were"
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="already performed."
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 ;Store current settings in case backout needed.
 M ^XTMP("PSSP258B","WS",18.12,PSSIEN)=^XOB(18.12,PSSIEN)
 S PSSOLDSSL=$$GET1^DIQ(18.12,PSSIEN,3.02),PSSOLDADR=$$GET1^DIQ(18.12,PSSIEN,.04)
 S PSSIEN=PSSIEN_"," D DISABLE("PPSN",PSSIEN)
 S FDA(18.12,PSSIEN,.04)=$P(PSSDATA,";",3) ; server address
 S FDA(18.12,PSSIEN,.06)=1 ; status enabled
 S FDA(18.12,PSSIEN,3.02)="encrypt_only_tlsv12"
 D FILE^DIE("K","FDA","PSSERR") K FDA
 S PSSTXT="In this "_PSSNAME_" environment, the PSS*1.0*258 post-install routine"
 D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 I '$D(PSSERR("DIERR",1,"TEXT",1)) D
 . S PSSTXT="successfully updated web server PPSN and enabled the server."
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT=" "
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="SSL configuration -"
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="   old: "_PSSOLDSSL
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="   new: encrypt_only_tlsv12"
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="Server address -"
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="   old: "_PSSOLDADR
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="   new: "_$P(PSSDATA,";",3)
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 I $D(PSSERR("DIERR",1,"TEXT",1)) D
 . S PSSTXT="has NOT updated WEB SERVER ""PPSN"" due to FileMan error:"
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT=$S($G(PSSERR("DIERR",1,"TEXT",1))]"":$G(PSSERR("DIERR",1,"TEXT",1)),1:"No error text available.")
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 . S PSSTXT="Submit a ServiceNow ticket requesting assistance in researching the error."
 . D BMES^XPDUTL(PSSTXT),SETTXT(PSSTXT)
 Q
 ;
DISABLE(SRVNAME,PSSIEN) ; Disable PPSN server if it exists-will set it back to enabled
 N PSSERVER,PSSERR
 ; Set STATUS to DISABLED
 S PSSERVER(18.12,PSSIEN,.06)=0
 D FILE^DIE("","PSSERVER","PSSERR") ; update existing entry
 I '$D(PSSERR("DIERR",1,"TEXT",1)) D BMES^XPDUTL("o WEB SERVER '"_SRVNAME_"' server temporarily disabled.")
 ;Not aborting install if PSSERR("DIERR" is returned since the update
 ;should be instaneous, so it doesn't matter if disabling did not occur first.
 Q
 ;
MAIL ; Sends Mailman message
 N PSSMGR,XMX,XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 D BMES^XPDUTL("Sending Mailman Message with update...")
 S PSSMGR=0 F  S PSSMGR=$O(^XUSEC("PSNMGR",PSSMGR)) Q:'PSSMGR  S XMY(PSSMGR)=""
 S XMY(DUZ)="",XMSUB="PSS*1*258 Post-Install Complete"
 S XMDUZ="PSS*1*258 Install",XMTEXT="^TMP(""PSS258P"",$J,"
 D ^XMD
 Q
 ;
WEBS ;  Map the system type to the SERVER endpoint
 ;;1;PRE-PROD;vaausapppps401.aac.domain.ext
 ;;2;SQA;vaausppsapp93.aac.domain.ext
 ;;3;STAGE;vaausapppps901.aac.domain.ext
 ;;4;DEV;vaausppsapp91.aac.domain.ext
 ;;5;PROD;vaww.ppsn.domain.ext
 ;
