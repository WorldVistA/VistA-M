PSO810PI ;BIRM/KML - PSO*7*810 Post-install routine ;10/15/2025
 ;;7.0;OUTPATIENT PHARMACY;**810**;DEC 1997;Build 9
 ;
 Q  ; Must be run from the POST or BACKOUT tag
 ;
 ;
 ;  This post-install routine does the following:
 ;  
 ;  POST tag:
 ;  1. Updates the description for element PAT22 for versions 4.1 and 4.2
 ;
 ;  BACKOUT tag:
 ;  2. Backs out updates to the description for element PAT22 versions 4.1 and 4.2
 ;
 ;
POST ; Main Entry Point
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("  Starting Post-Install for PSO*7.0*810.")
 D MES^XPDUTL("  This Post-Install Routine updates the description verbiage")
 D MES^XPDUTL("  for File #58.4 [SPMP ASAP RECORD DEFINITION] for the PAT22")
 D MES^XPDUTL("  element only for Versions 4.1 and 4.2.")
 ;
 N PSODUZ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,ZTSK
 S ZTRTN="START^PSO810PI"
 S ZTDESC="PSO*7.0*810 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S PSODUZ=DUZ
 S ZTSAVE("PSODUZ")=""
 D ^%ZTLOAD
 ;
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("  The PSO*7.0*810 Post-Install Routine has been tasked.")
 D MES^XPDUTL("  Task Number: "_$G(ZTSK))
 D MES^XPDUTL("  You will receive a MailMan message when it completes.")
 D BMES^XPDUTL("  ")
 Q
 ; 
START ; Start correction process
 N PSOSUB,PSOFROM,PSOTEXT
 K ^XTMP("PSO810PI",$J),^XTMP("PSO*7.0*810 POST INSTALL")  ;if Post Install run multiple times
 ;
 S ^XTMP("PSO*7.0*810 POST INSTALL",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^PSO*7.0*810 POST INSTALL"
 D CHANGE,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
CHANGE ; INC39935062 - Update Description for PAT22 element
 ;ASAP versions 4.1 and 4.2
 N PSOLINE,COUNT,FOUND,X1,X2
 N V,S,D,E,VER
 S PSOLINE=0
 ;
 D SETTXT("==================== PSO*7.0*810 Summary Report =========================")
 D SETTXT("List of ASAP Versions where PAT22 element description has been corrected.")
 D SETTXT("=========================================================================")
 D SETTXT("")
 ; 
 S V="VER",S="SEG",D="DAT",E="DES"
 S FOUND=0
 ;Check if correct version before proceeding
 I $P(^PS(58.4,1,V,2,0),"^",1)="4.1"  D
 . ;Check for the verbiage that needs to be removed
 . I $G(^PS(58.4,1,V,2,S,2,D,1,E,1,0))["PAT12" D
 . . S FOUND=FOUND+1
 . . D SETTXT("ASAP Version 4.1 - PAT22 Description Before Post-Install Routine")
 . . D SETTXT("----------------------------------------------------------------")
 . . S X1=$G(^PS(58.4,1,V,2,S,2,D,1,E,1,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,2,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,3,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,4,0))
 . . D SETTXT(X1)
 . . D SETTXT("")
 . . S ^PS(58.4,1,V,2,S,2,D,1,E,1,0)="Used when the patient's address is a foreign country."
 . . S ^PS(58.4,1,V,2,S,2,D,1,E,2,0)="This is a freeform text field. ASAP does not provide a list"
 . . D SETTXT("ASAP Version 4.1 - PAT22 Description After Post-Install Routine")
 . . D SETTXT("---------------------------------------------------------------")
 . . S X2=$G(^PS(58.4,1,V,2,S,2,D,1,E,1,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,2,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,3,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,4,0))
 . . D SETTXT(X2)
 . . D SETTXT("")
 ;Check if correct version before proceeding
 I $P(^PS(58.4,1,V,7,0),"^",1)="4.2"  D
 . ;Check for the verbiage that needs to be removed
 . I $G(^PS(58.4,1,V,7,S,2,D,1,E,1,0))["PAT12" D
 . . S (X1,X2)="" S FOUND=FOUND+1
 . . D SETTXT("ASAP Version 4.2 - PAT22 Description Before Post-Install Routine")
 . . D SETTXT("----------------------------------------------------------------")
 . . S X1=$G(^PS(58.4,1,V,7,S,2,D,1,E,1,0))_" "_$G(^PS(58.4,1,V,7,S,2,D,1,E,2,0))
 . . D SETTXT(X1)
 . . D SETTXT("")
 . . S ^PS(58.4,1,V,7,S,2,D,1,E,1,0)="Used when the patient's address is a foreign country."
 . . K ^PS(58.4,1,V,7,S,2,D,1,E,2,0)
 . . ;Check header node
 . . S COUNT=$O(^PS(58.4,1,V,7,S,2,D,1,E,"Z"),-1)
 . . I COUNT'=$P(^PS(58.4,1,V,7,S,2,D,1,E,0),"^",3) S $P(^PS(58.4,1,V,7,S,2,D,1,E,0),"^",3)=COUNT S $P(^PS(58.4,1,V,7,S,2,D,1,E,0),"^",4)=COUNT
 . . D SETTXT("ASAP Version 4.2 - PAT22 Description After Post-Install Routine")
 . . D SETTXT("---------------------------------------------------------------")
 . . S X2=$G(^PS(58.4,1,V,7,S,2,D,1,E,1,0))
 . . D SETTXT(X2)
 ;
 D SETTXT("")
 I FOUND D SETTXT("Total ASAP Versions Corrected = "_FOUND)
 I 'FOUND D SETTXT("No ASAP Versions Were Corrected.")
 D SETTXT("")
 ;
 D BMES^XPDUTL("  Mailman message sent.")
 D BMES^XPDUTL("  Finished Post-Install for PSO*7.0*810.")
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSO810PI",$J,PSOLINE)=TXT
 Q
 ; 
MAIL ; Sends Mailman message
 S PSOSUB="PSO*7.0*810 Post-Install Information"
 S PSOFROM="PSO*7.0*810 Post-Install"
 S PSOTEXT="^XTMP(""PSO810PI"",$J)"
 D MAILMSG(PSOSUB,PSOFROM,PSOTEXT)
 Q
MAILMSG(MSGSUBJ,MSGFROM,MSGTEXT) ; Build and send a MailMan message
 N PSOREC,PSOMY,PSOMIN,PSOMZ
 I '$D(PSODUZ) S PSODUZ=DUZ
 S PSOMIN("FROM")=MSGFROM
 S PSOREC=""
 F  S PSOREC=$O(^XUSEC("PSNMGR",PSOREC)) Q:PSOREC=""  S PSOMY(PSOREC)=""
 S PSOMY(PSODUZ)=""
 D SENDMSG^XMXAPI(PSODUZ,MSGSUBJ,MSGTEXT,.PSOMY,.PSOMIN,.PSOMZ,"")
 Q
BACKOUT ; Main Entry Point for Backout - Backout Description changes for PAT22 element
 ;ASAP versions 4.1 and 4.2
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("  Starting Post-Install Backout for PSO*7.0*810.")
 D MES^XPDUTL("  This Backout will remove updates to the description")
 D MES^XPDUTL("  verbiage for File #58.4 [SPMP ASAP RECORD DEFINITION]")
 D MES^XPDUTL("  for the PAT22 element only for Versions 4.1 and 4.2.")
 ;
 N PSODUZ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,ZTSK
 S ZTRTN="STARTBO^PSO810PI"
 S ZTDESC="PSO*7.0*810 Post-Install Backout"
 S ZTIO="",ZTDTH=$H
 S PSODUZ=DUZ
 S ZTSAVE("PSODUZ")=""
 D ^%ZTLOAD
 ;
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("  The PSO*7.0*810 Post-Install Backout has been tasked.")
 D MES^XPDUTL("  Task Number: "_$G(ZTSK))
 D MES^XPDUTL("  You will receive a MailMan message when it completes.")
 D BMES^XPDUTL("  ")
 Q
 ;
STARTBO ; Start Backout Process
 N PSOSUB,PSOFROM,PSOTEXT
 K ^XTMP("PSO810PI",$J),^XTMP("PSO*7.0*810 POST INSTALL BACKOUT")  ;if Post Install run multiple times
 ;
 S ^XTMP("PSO*7.0*810 POST INSTALL BACKOUT",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^PSO*7.0*810 POST INSTALL BACKOUT"
 D REMOVE,MAIL2
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
REMOVE ; INC39935062 - Remove Post-Install Updates to Description for PAT22 element
 ;ASAP versions 4.1 and 4.2
 N PSOLINE,COUNT,FOUND,X1,X2
 N V,S,D,E,VER
 S PSOLINE=0
 ;
 D SETMSG("==================== PSO*7.0*810 BACKOUT Report =========================")
 D SETMSG("List of ASAP Versions where PAT22 element description has been BACKED OUT")
 D SETMSG("=========================================================================")
 D SETMSG("")
 ; 
 S V="VER",S="SEG",D="DAT",E="DES"
 S FOUND=0
 ;Check if correct version before proceeding
 I $P(^PS(58.4,1,V,2,0),"^",1)="4.1"  D
 . ;Check for the verbiage that needs to be reinstated
 . I $G(^PS(58.4,1,V,2,S,2,D,1,E,1,0))["foreign country." D
 . . S FOUND=FOUND+1
 . . D SETMSG("ASAP Version 4.1 - PAT22 Description Before BACKOUT")
 . . D SETMSG("---------------------------------------------------")
 . . S X1=$G(^PS(58.4,1,V,2,S,2,D,1,E,1,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,2,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,3,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,4,0))
 . . D SETMSG(X1)
 . . D SETMSG("")
 . . S ^PS(58.4,1,V,2,S,2,D,1,E,1,0)="Used when the patient's address is a foreign country and PAT12 through PAT16"
 . . S ^PS(58.4,1,V,2,S,2,D,1,E,2,0)="are left blank. This is a freeform text field. ASAP does not provide a list"
 . . D SETMSG("ASAP Version 4.1 - PAT22 Description After BACKOUT")
 . . D SETMSG("--------------------------------------------------")
 . . S X2=$G(^PS(58.4,1,V,2,S,2,D,1,E,1,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,2,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,3,0))_" "_$G(^PS(58.4,1,V,2,S,2,D,1,E,4,0))
 . . D SETMSG(X2)
 . . D SETMSG("")
 ;Check if correct version before proceeding
 I $P(^PS(58.4,1,V,7,0),"^",1)="4.2"  D
 . ;Check for the verbiage that needs to be reinstated
 . I $G(^PS(58.4,1,V,7,S,2,D,1,E,1,0))["foreign country." D
 . . S (X1,X2)="" S FOUND=FOUND+1
 . . D SETMSG("ASAP Version 4.2 - PAT22 Description Before BACKOUT")
 . . D SETMSG("---------------------------------------------------")
 . . S X1=$G(^PS(58.4,1,V,7,S,2,D,1,E,1,0))_" "_$G(^PS(58.4,1,V,7,S,2,D,1,E,2,0))
 . . D SETMSG(X1)
 . . D SETMSG("")
 . . S ^PS(58.4,1,V,7,S,2,D,1,E,1,0)="Used when the patient's address is a foreign country and PAT12 through"
 . . S ^PS(58.4,1,V,7,S,2,D,1,E,2,0)="PAT16 are left blank."
 . . ;Check header node
 . . S COUNT=$O(^PS(58.4,1,V,7,S,2,D,1,E,"Z"),-1)
 . . I COUNT'=$P(^PS(58.4,1,V,7,S,2,D,1,E,0),"^",3) S $P(^PS(58.4,1,V,7,S,2,D,1,E,0),"^",3)=COUNT S $P(^PS(58.4,1,V,7,S,2,D,1,E,0),"^",4)=COUNT
 . . D SETMSG("ASAP Version 4.2 - PAT22 Description After BACKOUT")
 . . D SETMSG("--------------------------------------------------")
 . . S X2=$G(^PS(58.4,1,V,7,S,2,D,1,E,1,0))_" "_$G(^PS(58.4,1,V,7,S,2,D,1,E,2,0))
 . . D SETMSG(X2)
 ;
 D SETMSG("")
 I FOUND D SETMSG("Total ASAP Versions Corrected By BACKOUT = "_FOUND)
 I 'FOUND D SETMSG("No ASAP Versions Were Affected By BACKOUT.")
 D SETMSG("")
 ;
 D BMES^XPDUTL("  Mailman message sent.")
 D BMES^XPDUTL("  Finished BACKOUT for PSO*7.0*810.")
 Q
 ;
SETMSG(TXT) ; Setting Plain Text
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSO810PI",$J,PSOLINE)=TXT
 Q
MAIL2 ; Sends Mailman message
 S PSOSUB="PSO*7.0*810 Post-Install BACKOUT Info"
 S PSOFROM="PSO*7.0*810 Post-Install BACKOUT"
 S PSOTEXT="^XTMP(""PSO810PI"",$J)"
 D MAILMSG(PSOSUB,PSOFROM,PSOTEXT)
 Q
