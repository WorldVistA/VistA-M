DG933PO ;DAL/JCH - PATCH DG*5.3*933 POST INSTALL ;06/18/2017
 ;;5.3;Registration;**933**;Aug 13, 1993;Build 44
 ; This routine uses the following IAs:
 ; #4640 - ^HDISVF01 calls (supported)
 ; #4639 - ^HDISVCMR calls     (supported)
 ; #4651 - ^HDISVF09 calls     (supported)
 ;
EN ;MAIN ENTRY POINT
 N SUCCESS,DEMFAC,X,Y,DA,X1,X2,ZTRTN,ZTDESC,ZTDTH,TMP,DOMPTR,DIE,DA,DR,FIL,DOMPTR,DOMAIN
 S DEMFAC=$$KSP^XUPARAM("INST")
 S DOMAIN="DEMOGRAPHICS"
 S SUCCESS=$$GETIEN^HDISVF09(DOMAIN,.DOMPTR)
 I 'SUCCESS!'+$G(DOMPTR) D  Q
 .D MES^XPDUTL("***** Error retrieving the IEN for the "_DOMAIN_" domain.")
 .D PSTHALT("Seeding for files #10.99, #11.99, and #13.99 was not peformed.")
 F FIL=10.99,11.99,13.99 D HDIS(FIL,DOMPTR,DOMAIN)
 Q
 ;
HDIS(FIL,DOMPTR,DOMAIN) ; Do dummy 'seeding'
 N TMP,HDIMSG,B,C
 ;
 ; New file can't be seeded if there is no data?
 I FIL=10.99 D  Q
 .I '$O(^DGRAM(10.99,0)) D DUMSEED(10.99,"SEEDGRAM")
 .D PSEED(10.99,DOMPTR,DOMAIN)
 I FIL=11.99 D  Q
 .I '$O(^DGMMS(11.99,0)) D DUMSEED(11.99,"SEEDGMMS")
 .D PSEED(11.99,DOMPTR,DOMAIN)
 I FIL=13.99 D  Q
 .I '$O(^DGMR(13.99,0)) D DUMSEED(13.99,"SEEDGMR")
 .D PSEED(13.99,DOMPTR,DOMAIN)
 ;
 Q
 ;
PSEED(FIL,DOMPTR,DOMAIN)  ;  Check for previous "seeding"(deployment), quit if already done.
 N ASTATUS,TMP,XPROD,DGSITE,XMSUB,XMDUZ,XMY,HDITEXT,FILNAM,MSG,XMTEXT,XMZ
 ;
 S ASTATUS=$P($$GETSTAT^HDISVF01(FIL),U)
 I ASTATUS>3 S MSG="File: "_FIL_" Has already been seeded. Status is: "_ASTATUS D PSTHALT(MSG) Q
 ;
 ; set the seeding status to complete for data deployments.
 D SETSTAT^HDISVF01(FIL,,4)
 ;
 ; send message to STS that patch is installed and the current status
 D FILE^DID(FIL,"","NAME","FILNAM","ERR")
 S FILNAM=$G(FILNAM("NAME"))
 S XPROD=$$PROD^XUPROD()
 S DGSITE=$$SITE^VASITE()
 S XMSUB="Site: "_$P(DGSITE,"^",2)_" File: "_FIL_" in "_($S(XPROD:"PRODUCTION",1:"TEST"))_" ready for ERT Update"
 S XMY("G.HDIS ERT NOTIFICATION@DOMAIN.EXT")=""
 S XMDUZ="Site: "_$P(DGSITE,"^",3)_" Patch Install DG*5.3*933 is Complete"
 S XMY(DUZ)=""
 K HDITEXT
 S HDITEXT(1)=""
 S HDITEXT(2)="Site: "_$P(DGSITE,"^",2)_" - "_$P(DGSITE,"^",3)
 S HDITEXT(2)=HDITEXT(2)_" with Domain/IP Address of "_$G(^XMB("NETNAME"))  ;facility name
 S HDITEXT(3)="Has Installed Patch DG*5.3*933 into their "_$S(XPROD:"PRODUCTION",1:"TEST")_" System Environment"
 S HDITEXT(4)="The Patch was Installed on: "
 S B=$$NOW^XLFDT N Y S Y=B D DD^%DT S HDITEXT(4)=HDITEXT(4)_Y ;date/time
 S HDITEXT(5)=""
 S HDITEXT(6)="Patch DG*5.3*933 has standardized file: "_FILNAM_" (#"_FIL_")"
 S HDITEXT(7)=""
 S HDITEXT(8)="The current HDIS status of file #"_FIL_"is:  "_$P($$GETSTAT^HDISVF01(FIL),U)
 S HDITEXT(9)=""
 S HDITEXT(10)="Site: "_$P(DGSITE,"^",2)_" - "_$P(DGSITE,"^",3)_"  needs full file update of the "_FILNAM_" file (#"_FIL_" as soon as possible."
 S HDITEXT(11)=""
 N DIFROM S XMTEXT="HDITEXT(" D ^XMD K DIFROM
 S MSG="File: "_FIL_" Has been 'seeded'. Message Number: "_$G(XMZ) D PSTDONE(MSG)
 Q
 ;
PSTDONE(MSG) ; display FINISHED message
 N HDIMSG
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch DG*5.3*933 HDIS 'seeding' "_FILNAM_" file (#"_FIL_") has Completed."
 S HDIMSG(4)="***** An update message has been sent to Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
DUMSEED(DGMFILE,DGDTAG) ; New file <#nn.99> contains no data, can't be seeded unless there is at least one entry
 ; RACE MASTER (#10.99) file initial population data elements from DAT1099 line tag
 ; MASTER MARITAL STATUS (#11.99) file initial population data elements from DAT1199 line tag;
 ; MASTER RELIGION (#13.99) file initial population data elements from DAT1399 line tag;
 ;
 ;   DGDATA ";" PIECE - FIELD # - FIELD NAME
 ;          PIECE #1  -   n/a   - IEN 
 ;          PIECE #2  -  .01    - NAME
 ;          PIECE #3  -    1    - CODE
 ;
 N DGMFI,DGDATA,DGDATLN,DGFDA,DGRSLT,XUMF
 S XUMF=1
 F DGDATLN=1:1 S DGDATA=$P($T(@DGDTAG+DGDATLN),";",3,10) Q:DGDATA=""  D
 .N DGMFI,DGFDA,DGFDAIEN,DGEFFDT
 .S DGMFI=$P(DGDATA,";")
 .S DGFDA(DGMFILE,"+1,",.01)=$P(DGDATA,";",2)
 .S DGFDA(DGMFILE,"+1,",1)=$P(DGDATA,";",3)
 .S DGRSLT=$$INSREC(DGMFILE,DGMFI,.DGFDA)
 Q
 ;
INSREC(DGFILE,DGIEN,DGFDA) ; Insert DGIEN into file DGFILE with data in DGFDA
 I ('$G(DGFILE)) Q "0^Invalid parameter"
 N DGDERR
 D UPDATE^DIE("","DGFDA","","DGDERR")
 I $D(DGDERR) Q -1
 Q +$G(DGFDA)
 ;
PSTHALT(MSG) ; display error message
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch DG*5.3*933 HDIS 'seeding' has been halted."
 S HDIMSG(4)="***** Please contact Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
SEEDGRAM  ; Data to populate the RACE MASTER (#10.99) file.
 ;;1;American Indian or Alaska Native;1002-5
 ;;2;Asian;2028-9
 ;;3;Black or African American;2054-5
 ;;4;Native Hawaiian or Other Pacific Islander;2076-8
 ;;5;White;2106-3
 Q
 ;
SEEDGMMS  ; Data to populate the MASTER MARITAL STATUS (#11.99) file.
 ;;1;Annulled;A
 ;;2;Divorced;D
 ;;3;Interlocutory;I
 ;;4;Legally Separated;L
 ;;5;Married;M
 Q
 ;
SEEDGMR  ; Data to populated the MASTER RELIGION (#13.99) file.
 ;;1;Adventist;1001
 ;;2;African Religions;1002
 ;;3;Afro-Caribbean Religions;1003
 ;;4;Agnosticism;1004
 ;;5;Anglican;1005
 Q
