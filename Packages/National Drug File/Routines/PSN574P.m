PSN574P ;HDSO/DSK - PSN*4.0*574 Post-install routine; Aug 11, 2022@15:00
 ;;4.0;NATIONAL DRUG FILE;**574**; 30 Oct 98;Build 5
 ;
 ; Reference to ^GMR(120.8 in ICR #2545
 ; Reference to ^GMR(120.8 in ICR #905
 ; (ICR #2545 pertains to write access.)
 ; (ICR #905 pertains to read access.)
 Q
 ;
EN ;
 ;This post-install routine for PSN*4.0*574 will:
 ;
 ;1. Correct a "ORPHENADRINE" entry in the NDC/UPN (#50.67) file
 ;   which has the TRADE NAME (#4) field defined as "COFLEX".
 ;
 ;2. Update records in the PATIENT ALLERGIES (#120.8) file which
 ;   are defined as against "ORPHENADRINE" but the entry in the
 ;   REACTANT (#.02) field is defined with "COFLEX".
 ; 
 ;This routine is not deleted after install since it is tasked.
 ;A future patch will delete the routine.
 ;
 N PSNDUZ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE
 S ZTRTN="START^PSN574P"
 S ZTDESC="PSN*4.0*574 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S PSNDUZ=DUZ
 S ZTSAVE("PSNDUZ")=""
 D ^%ZTLOAD
 D BMES^XPDUTL($$CJ^XLFSTR("PSN*4.0*574 Post-Install Routine has been tasked.",80))
 D BMES^XPDUTL($$CJ^XLFSTR("Task Number: "_$G(ZTSK),80))
 D BMES^XPDUTL($$CJ^XLFSTR("You as well as holders of the PSNMGR security key will receive",80))
 D BMES^XPDUTL($$CJ^XLFSTR("a MailMan message when the search completes.",80))
 Q
 ;
START ;
 ;Killing ^XTMP in case routine is run more than once during testing.
 K ^XTMP("PSN*4.0*574 POST INSTALL")
 S ^XTMP("PSN*4.0*574 POST INSTALL",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^PSN*4.0*574 POST INSTALL"
 ;
 N PSNMAILSQ,PSNSPACE
 F PSNMAILSQ=1:1:50 S PSNSPACE=$G(PSNSPACE)_" "
 D NDCUPN,GMR,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
NDCUPN ;Correct entries in the NDC/UPN (#50.67) file.
 S ^XTMP("PSN*4.0*574 POST INSTALL",1)=" "
 S ^XTMP("PSN*4.0*574 POST INSTALL",2)="The following entries in the NDC/UPN (#50.67) file have been corrected"
 S ^XTMP("PSN*4.0*574 POST INSTALL",3)="to replace the TRADE NAME (#4) field entry of ""COFLEX"" with"
 S ^XTMP("PSN*4.0*574 POST INSTALL",4)="""ORPHENADRINE CITRATE""."
 S ^XTMP("PSN*4.0*574 POST INSTALL",5)=" "
 S ^XTMP("PSN*4.0*574 POST INSTALL",6)="NDC/UPN (#50.67)"
 S ^XTMP("PSN*4.0*574 POST INSTALL",7)="FILE IEN          NDC           VA PRODUCT NAME"
 S ^XTMP("PSN*4.0*574 POST INSTALL",8)="----------------  ------------  ------------------------------"
 ;Following line will be overwritten if corrections are made.
 S ^XTMP("PSN*4.0*574 POST INSTALL",9)="No entries were found which needed correction."
 ;
 N DIE,DR,DA,PSNX,PSNSTR
 S DIE="^PSNDF(50.67,",DR="4////ORPHENADRINE CITRATE"
 S (PSNX,PSNSTR)="",PSNMAILSQ=9
 F  S PSNX=$O(^PSNDF(50.67,"T","COFLEX",PSNX)) Q:PSNX=""  D
 . ;Double check:
 . Q:$$GET1^DIQ(50.67,PSNX,4)'="COFLEX"
 . ;Triple check:
 . Q:$$GET1^DIQ(50.67,PSNX,5)'["ORPHENADRINE CITRATE"
 . S DA=PSNX
 . D ^DIE
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=PSNX_$E(PSNSPACE,1,18-$L(PSNX))_$$GET1^DIQ(50.67,PSNX,1)
 . S PSNSTR=$L(^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ))
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)_$E(PSNSPACE,1,32-PSNSTR)
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)_$E($$GET1^DIQ(50.67,PSNX,5),1,30)
 . S PSNMAILSQ=PSNMAILSQ+1
 ;Adjust if entries were corrected.
 I PSNMAILSQ>9 S PSNMAILSQ=PSNMAILSQ-1
 Q
 ;
GMR ;Correct records in the PATIENT ALLERGIES (#120.8) file.
 ;Adding extra spacing for readability of message.
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+1)=" "
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+2)="The following entries in the PATIENT ALLERGIES (#120.8) file have been"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+3)="corrected to replace the REACTANT (#.02) field entry of ""COFLEX"" with"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+4)="""ORPHENADRINE CITRATE"". (The replacement is performed only if the"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+5)="GMR ALLERGIES (#1) field entry equals ""ORPHENADRINE CITRATE"".)"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+6)=" "
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+7)="****************************************************************"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+8)="*   It is recommended that the patients on this report have    *"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+9)="*   their charts reviewed for accuracy.                        *"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+10)="****************************************************************"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+11)=" "
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+12)="                1st LETTER  PATIENT ALLERGIES   PATIENT ALLERGIES"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+13)="PATIENT (#2)    LAST NAME   ORIGINATION         (#120.8) FILE"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+14)="FILE IEN        LAST 4 SSN  DATE/TIME           IEN"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+15)="--------------  ----------  ------------------  ------------------"
 ;Following line will be overwritten if corrections are made.
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+16)="No entries were found which needed correction."
 ;
 N DIE,DR,DA,PSNX,PSNSTART,DFN,VADM,PSNL4,PSNSTR,PSNORIG
 S DIE="^GMR(120.8,",DR=".02////ORPHENADRINE CITRATE"
 S PSNX="",(PSNSTART,PSNMAILSQ)=PSNMAILSQ+16
 F  S PSNX=$O(^GMR(120.8,"C","COFLEX",PSNX)) Q:PSNX=""  D
 . ;Double check:
 . Q:$$GET1^DIQ(120.8,PSNX,.02)'="COFLEX"
 . ;Triple check:
 . Q:$$GET1^DIQ(120.8,PSNX,1)'="ORPHENADRINE CITRATE"
 . S DA=PSNX
 . D ^DIE
 . ;File 2 IEN for patient
 . S DFN=$$GET1^DIQ(120.8,PSNX,.01,"I")
 . D DEM^VADPT
 . ;PSNL4 = First letter of last name_last four of SSN
 . S PSNL4=$E(VADM(1))_$P(VADM(2),"-",3)
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=DFN_$E(PSNSPACE,1,16-$L(DFN))_PSNL4
 . ;Origination date/time of allergy.
 . S PSNORIG=$P($$GET1^DIQ(120.8,PSNX,4),":",1,2)
 . S PSNSTR=$L(^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ))
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)_$E(PSNSPACE,1,28-PSNSTR)
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)_PSNORIG
 . ;File 120.8 IEN
 . S PSNSTR=$L(^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ))
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)_$E(PSNSPACE,1,48-PSNSTR)
 . S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)=^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ)_PSNX
 . S PSNMAILSQ=PSNMAILSQ+1
 ;Adjust if entries were corrected.
 I PSNMAILSQ'=PSNSTART S PSNMAILSQ=PSNMAILSQ-1
 Q
 ;
MAIL ;
 N PSNREC,PSNTEXT,PSNMY,PSNSUB,PSNMIN
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+1)=" "
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+2)="Information pertaining to each modified entry will be stored in the global"
 S ^XTMP("PSN*4.0*574 POST INSTALL",PSNMAILSQ+3)="^XTMP(""PSN*4.0*574 POST INSTALL"" for 90 days."
 S PSNTEXT="^XTMP(""PSN*4.0*574 POST INSTALL"")"
 S PSNREC=""
 F  S PSNREC=$O(^XUSEC("PSNMGR",PSNREC)) Q:PSNREC=""  D
 . S PSNMY(PSNREC)=""
 S PSNMY(PSNDUZ)=""
 S PSNSUB="PSN*4.0*574 Post-Install Information"
 S PSNMIN("FROM")="PSN*4.0*574 Post-Install"
 D SENDMSG^XMXAPI(PSNDUZ,PSNSUB,PSNTEXT,.PSNMY,.PSNMIN,"","")
 Q
 ;
BACKOUT ;This section is invoked from the programmer's prompt if patch back out is required.
 N DIR,Y
 S DIR("A",1)="This action will back out the file modifications that were performed"
 S DIR("A",2)="after the install of PSN*4.0*574."
 S DIR("A")="Are you sure you wish to proceed",DIR("B")="NO",DIR(0)="Y"
 D ^DIR
 Q:Y<1
 ;Killing ^XTMP in case routine is run more than once during testing.
 K ^XTMP("PSN*4.0*574 BACK OUT")
 S ^XTMP("PSN*4.0*574 BACK OUT",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^PSN*4.0*574 BACK OUT"
 S ^XTMP("PSN*4.0*574 BACK OUT",1)=" "
 S ^XTMP("PSN*4.0*574 BACK OUT",2)="Patch PSN*4.0*574 was backed out by "_$$GET1^DIQ(200,DUZ,.01)_"."
 S ^XTMP("PSN*4.0*574 BACK OUT",3)=" "
 ;
 N PSNMAILSQ,PSNSPACE,PSNZ
 F PSNMAILSQ=1:1:50 S PSNSPACE=$G(PSNSPACE)_" "
 W !!,"Please wait until the back out completes."
 W !,"Working."
 D NDCBACK,GMRBACK,MAILBACK
 Q
 ;
NDCBACK ;
 S ^XTMP("PSN*4.0*574 BACK OUT",4)="The following entries in the NDC/UPN (#50.67) file have been restored"
 S ^XTMP("PSN*4.0*574 BACK OUT",5)="to replace the TRADE NAME (#4) field entry of ""ORPHENADRINE CITRATE"""
 S ^XTMP("PSN*4.0*574 BACK OUT",6)="with ""COFLEX""."
 S ^XTMP("PSN*4.0*574 BACK OUT",7)=" "
 S ^XTMP("PSN*4.0*574 BACK OUT",8)="NDC/UPN (#50.67)"
 S ^XTMP("PSN*4.0*574 BACK OUT",9)="FILE IEN          NDC           VA PRODUCT NAME"
 S ^XTMP("PSN*4.0*574 BACK OUT",10)="----------------  ------------  ------------------------------"
 ;Following line will be overwritten if corrections are made.
 S ^XTMP("PSN*4.0*574 BACK OUT",11)="No entries were found which needed to be backed out."
 ;
 N DIE,DR,DA,PSNX,PSNQUIT,PSNSTR
 S DIE="^PSNDF(50.67,",DR="4////COFLEX"
 S PSNQUIT=0,PSNSTR="",PSNZ=8,PSNMAILSQ=11
 ;Sites should only have one entry that was corrected, but looping just in case.
 F  S PSNZ=$O(^XTMP("PSN*4.0*574 POST INSTALL",PSNZ)) Q:PSNZ=""  Q:PSNQUIT  D
 . S PSNX=$P(^XTMP("PSN*4.0*574 POST INSTALL",PSNZ)," ")
 . I PSNX="" S PSNQUIT=1 Q
 . ;Double check:
 . Q:$$GET1^DIQ(50.67,PSNX,4)'="ORPHENADRINE CITRATE"
 . ;Triple check:
 . Q:$$GET1^DIQ(50.67,PSNX,5)'["ORPHENADRINE CITRATE"
 . S DA=PSNX
 . D ^DIE
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=PSNX_$E(PSNSPACE,1,18-$L(PSNX))_$$GET1^DIQ(50.67,PSNX,1)
 . S PSNSTR=$L(^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ))
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)_$E(PSNSPACE,1,32-PSNSTR)
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)_$E($$GET1^DIQ(50.67,PSNX,5),1,33)
 . S PSNMAILSQ=PSNMAILSQ+1
 . W "."
  ;Adjust if entries were backed out.
 I PSNMAILSQ>11 S PSNMAILSQ=PSNMAILSQ-1
 Q
 ;
GMRBACK ;
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+1)=" "
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+2)="The following entries in the PATIENT ALLERGIES (#120.8) file have been"
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+3)="restored to replace the REACTANT (#.02) field entry of ""ORPHENADRINE"""
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+4)="""CITRATE"" with ""COFLEX"". (The replacement is only performed if the entry"
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+5)="was modified by the PSN*4.0*574 patch post-install.)"
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+6)=" "
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+7)="                1st LETTER  PATIENT ALLERGIES   PATIENT ALLERGIES"
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+8)="PATIENT (#2)    LAST NAME   ORIGINATION         (#120.8) FILE"
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+9)="FILE IEN        LAST 4 SSN  DATE/TIME           IEN"
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+10)="--------------  ----------  ------------------  ------------------"
 ;Following line will be overwritten if corrections are made.
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+11)="No entries were found which needed to be backed out."
 ;
 N DIE,DR,DA,PSNX,PSNSTART,PSNQUIT,PSNSTR,PSNCOUNT,PSNCHAR,DFN,PSNL4
 S DIE="^GMR(120.8,",DR=".02////COFLEX"
 ;First file 120.8 correction will be 16 lines ahead in the MailMan message.
 S PSNZ=PSNZ+12,(PSNMAILSQ,PSNSTART)=PSNMAILSQ+11,PSNQUIT=0
 F  S PSNZ=$O(^XTMP("PSN*4.0*574 POST INSTALL",PSNZ)) Q:PSNZ=""  Q:PSNQUIT  D
 . ;Need to pluck out the entry at the end of the string.
 . S PSNSTR=^XTMP("PSN*4.0*574 POST INSTALL",PSNZ)
 . I PSNSTR=" " S PSNQUIT=1 Q
 . S PSNX=""
 . F PSNCOUNT=0:1 S PSNCHAR=$E(PSNSTR,$L(PSNSTR)-PSNCOUNT) Q:PSNCHAR=" "  S PSNX=PSNCHAR_PSNX
 . ;Double check:
 . Q:$$GET1^DIQ(120.8,PSNX,.02)'="ORPHENADRINE CITRATE"
 . ;Double check again:
 . Q:$$GET1^DIQ(120.8,PSNX,1)'="ORPHENADRINE CITRATE"
 . S DA=PSNX
 . D ^DIE
 . S DFN=$$GET1^DIQ(120.8,PSNX,.01,"I")
 . D DEM^VADPT
 . ;PSNL4 = First letter of last name_last four of SSN
 . S PSNL4=$E(VADM(1))_$P(VADM(2),"-",3)
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=DFN_$E(PSNSPACE,1,16-$L(DFN))_PSNL4
 . ;Origination date/time of allergy.
 . S PSNORIG=$P($$GET1^DIQ(120.8,PSNX,4),":",1,2)
 . S PSNSTR=$L(^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ))
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)_$E(PSNSPACE,1,28-PSNSTR)
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)_PSNORIG
 . ;File 120.8 IEN
 . S PSNSTR=$L(^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ))
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)_$E(PSNSPACE,1,48-PSNSTR)
 . S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)=^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ)_PSNX
 . S PSNMAILSQ=PSNMAILSQ+1
 . W "."
 ;Adjust if entries were backed out.
 I PSNMAILSQ'=PSNSTART S PSNMAILSQ=PSNMAILSQ-1
 W !,"Finished back out. Now queueing MailMan message.",!
 Q
MAILBACK ;
 N PSNREC,PSNTEXT,PSNMY,PSNSUB,PSNMIN,PSNMZ,DIR
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+1)=" "
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+2)="The text of this message will be stored in the global"
 S ^XTMP("PSN*4.0*574 BACK OUT",PSNMAILSQ+3)="^XTMP(""PSN*4.0*574 BACK OUT"" for 90 days."
 S PSNTEXT="^XTMP(""PSN*4.0*574 BACK OUT"")"
 S PSNREC=""
 F  S PSNREC=$O(^XUSEC("PSNMGR",PSNREC)) Q:PSNREC=""  D
 . S PSNMY(PSNREC)=""
 S PSNMY(DUZ)=""
 S PSNSUB="PSN*4.0*574 Back Out Information"
 S PSNMIN("FROM")="PSN*4.0*574 BACK OUT"
 D SENDMSG^XMXAPI(DUZ,PSNSUB,PSNTEXT,.PSNMY,.PSNMIN,.PSNMZ,"")
 S DIR("A",1)="MailMan message #"_PSNMZ_" has been sent to you as well as"
 S DIR("A",2)="holders of the PSNMGR security key."
 S DIR("A")="Press any key to continue"
 S DIR(0)="E"
 D ^DIR
 Q
 ;
