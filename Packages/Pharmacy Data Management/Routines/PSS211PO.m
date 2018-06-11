PSS211PO ;DAL/JCH - PATCH PSS*1.0*211 POST INSTALL ;09/13/2017
 ;;1.0;PHARMACY DATA MANAGEMENT;**211**;09/30/97;Build 20
 ; This routine uses the following IAs:
 ; #4640 - ^HDISVF01 calls (supported)
 ; #4639 - ^HDISVCMR calls     (supported)
 ; #4651 - ^HDISVF09 calls     (supported)
 ;
EN ;MAIN ENTRY POINT
 N SUCCESS,DEMFAC,X,Y,DA,X1,X2,ZTRTN,ZTDESC,ZTDTH,TMP,DOMPTR,DIE,DA,DR,FIL,DOMPTR,DOMAIN
 S DEMFAC=$$KSP^XUPARAM("INST")
 S DOMAIN="PHARMACY DATA MANAGEMENT"
 S SUCCESS=$$GETIEN^HDISVF09(DOMAIN,.DOMPTR)
 I 'SUCCESS!'+$G(DOMPTR) D  Q
 .D MES^XPDUTL("***** Error retrieving the IEN for the "_DOMAIN_" domain.")
 .D PSTHALT("Seeding for file #50.60699 was not performed.")
 S FIL=50.60699 D HDIS(FIL,DOMPTR,DOMAIN)
 Q
 ;
HDIS(FIL,DOMPTR,DOMAIN) ; Do dummy 'seeding'
 N TMP,HDIMSG,B,C
 ;
 ; New file can't be seeded if there is no data?
 I FIL=50.60699 D  Q
 .I '$O(^PSMDF(50.60699,0)) D DUMSEED(50.60699,"SEEDOSF")
 .D PSEED(50.60699,DOMPTR,DOMAIN)
 ;
 Q
 ;
PSEED(FIL,DOMPTR,DOMAIN)  ;  Check for previous "seeding"(deployment), quit if already done.
 N ASTATUS,TMP,XPROD,PSSITE,XMSUB,XMDUZ,XMY,HDITEXT,FILNAM,MSG,XMTEXT,XMZ
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
 S PSSITE=$$SITE^VASITE()
 S XMSUB="Site: "_$P(PSSITE,"^",2)_" File: "_FIL_" in "_($S(XPROD:"PRODUCTION",1:"TEST"))_" ready for ERT Update"
 S XMY("G.HDIS ERT NOTIFICATION@FORUM.DOMAIN.EXT")=""
 S XMDUZ="Site: "_$P(PSSITE,"^",3)_" Patch Install PSS*1.0*211 is Complete"
 S XMY(DUZ)=""
 K HDITEXT
 S HDITEXT(1)=""
 S HDITEXT(2)="Site: "_$P(PSSITE,"^",2)_" - "_$P(PSSITE,"^",3)
 S HDITEXT(2)=HDITEXT(2)_" with Domain/IP Address of "_$G(^XMB("NETNAME"))  ;facility name
 S HDITEXT(3)="Has Installed Patch PSS*1.0*211 into their "_$S(XPROD:"PRODUCTION",1:"TEST")_" System Environment"
 S HDITEXT(4)="The Patch was Installed on: "
 S B=$$NOW^XLFDT N Y S Y=B D DD^%DT S HDITEXT(4)=HDITEXT(4)_Y ;date/time
 S HDITEXT(5)=""
 S HDITEXT(6)="Patch PSS*1.0*211 has standardized file: "_FILNAM_" (#"_FIL_")"
 S HDITEXT(7)=""
 S HDITEXT(8)="The current HDIS status of file #"_FIL_"is:  "_$P($$GETSTAT^HDISVF01(FIL),U)
 S HDITEXT(9)=""
 S HDITEXT(10)="Site: "_$P(PSSITE,"^",2)_" - "_$P(PSSITE,"^",3)_"  needs full file update of the "_FILNAM_" file (#"_FIL_" as soon as possible."
 S HDITEXT(11)=""
 N DIFROM S XMTEXT="HDITEXT(" D ^XMD K DIFROM
 S MSG="File: "_FIL_" Has been 'seeded'. Message Number: "_$G(XMZ) D PSTDONE(MSG)
 Q
 ;
PSTDONE(MSG) ; display FINISHED message
 N HDIMSG
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch PSS*1.0*211 HDIS 'seeding' "_FILNAM_" file (#"_FIL_") has Completed."
 S HDIMSG(4)="***** An update message has been sent to Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
DUMSEED(PSMFILE,PSDTAG) ; New file <#nn.99> contains no data, can't be seeded unless there is at least one entry
 ; MASTER DOSAGE FORM (#50.60699) file initial population data elements from DAT99 line tag
 ;
 ;   PSDATA ";" PIECE - FIELD # - FIELD NAME
 ;          PIECE #1  -   n/a   - IEN 
 ;          PIECE #2  -  .01    - RxNorm Name
 ;          PIECE #3  -    1    - RxNorm Code
 ;          PIECE #4  -    2    - RxNorm Term Type
 ;
 N PSMFI,PSDATA,PSDATLN,PSFDA,PSRSLT,XUMF
 S XUMF=1
 F PSDATLN=1:1 S PSDATA=$P($T(@PSDTAG+PSDATLN),";",3,10) Q:PSDATA=""  D
 .N PSMFI,PSFDA,PSFDAIEN,PSEFFDT
 .S PSMFI=$P(PSDATA,";")
 .S PSFDA(PSMFILE,"+1,",.01)=$P(PSDATA,";",2)
 .S PSFDA(PSMFILE,"+1,",1)=$P(PSDATA,";",3)
 .S PSFDA(PSMFILE,"+1,",2)=$P(PSDATA,";",4)
 .S PSRSLT=$$INSREC(PSMFILE,PSMFI,.PSFDA)
 Q
 ;
INSREC(PSFILE,PSIEN,PSFDA) ; Insert PSIEN into file PSFILE with data in PSFDA
 I ('$G(PSFILE)) Q "0^Invalid parameter"
 N PSDERR
 D UPDATE^DIE("","PSFDA","","PSDERR")
 I $D(PSDERR) Q -1
 Q +$G(PSFDA)
 ;
PSTHALT(MSG) ; display error message
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch PS*5.3*933 HDIS 'seeding' has been halted."
 S HDIMSG(4)="***** Please contact Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
SEEDOSF  ; Data to populated the MASTER DOSAGE FORM (#50.60699) file.
 ;;1;24 Hour Extended Release Tablet;316936;DF
 ;;2;Aerosol;324049;ET
 ;;3;Bar;317692;DF
 ;;4;Beads;316993;DF
 ;;5;Buccal Film;858080;DF
 Q
