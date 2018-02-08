IBE585PO ;DAL/JCH - Patch IB*2.0*585 Post Install ;22-JUN-17
 ;;2.0;INTEGRATED BILLING;**585**;21-MAR-94;Build 68
 ; This routine uses the following IAs:
 ; #4640 - ^HDISVF01 calls (supported)
 ; #4639 - ^HDISVCMR calls     (supported)
 ; #4651 - ^HDISVF09 calls     (supported)
 ;
EN ;MAIN ENTRY POINT
 N SUCCESS,DEMFAC,X,Y,DA,X1,X2,ZTRTN,ZTDESC,ZTDTH,TMP,DOMPTR,DIE,DA,DR,FIL,DOMPTR,DOMAIN
 S DEMFAC=$$KSP^XUPARAM("INST")
 S DOMAIN="PAYERS"
 S SUCCESS=$$GETIEN^HDISVF09(DOMAIN,.DOMPTR)
 I 'SUCCESS!'+$G(DOMPTR) D  Q
 .D MES^XPDUTL("***** Error retrieving the IEN for the "_DOMAIN_" domain.")
 .D PSTHALT("File #355.99 'seeding' was not performed.")
 S FIL=355.99 D HDIS(FIL,DOMPTR,DOMAIN)
 Q
 ;
HDIS(FIL,DOMPTR,DOMAIN) ; do HDIS "seeding"
 N TMP,HDIMSG,B,C
 ;
 ; New file can't be seeded if there is no data?
 I '$O(^IBEMTOP(355.99,0)) D DUMSEED
 D PSEED(355.99,DOMPTR,DOMAIN)
 ;
 Q
 ;
PSEED(FIL,DOMPTR,DOMAIN)  ;  Check for previous "seeding"(deployment), quit if already done.
 N ASTATUS,TMP,XPROD,IBSITE,XMSUB,XMDUZ,XMY,HDITEXT,FILNAM,MSG,XMTEXT,XMZ
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
 S IBSITE=$$SITE^VASITE()
 S XMSUB="Site: "_$P(IBSITE,"^",2)_" File: "_FIL_" in "_($S(XPROD:"PRODUCTION",1:"TEST"))_" ready for ERT Update"
 S XMY("G.HDIS ERT NOTIFICATION@DOMAIN.EXT")=""
 S XMDUZ="Site: "_$P(IBSITE,"^",3)_" Patch Install IB*2.0*585 is Complete"
 S XMY(DUZ)=""
 K HDITEXT
 S HDITEXT(1)=""
 S HDITEXT(2)="Site: "_$P(IBSITE,"^",2)_" - "_$P(IBSITE,"^",3)
 S HDITEXT(2)=HDITEXT(2)_" with Domain/IP Address of "_$G(^XMB("NETNAME"))  ;facility name
 S HDITEXT(3)="Has Installed Patch IB*2.0*585 into their "_$S(XPROD:"PRODUCTION",1:"TEST")_" System Environment"
 S HDITEXT(4)="The Patch was Installed on: "
 S B=$$NOW^XLFDT N Y S Y=B D DD^%DT S HDITEXT(4)=HDITEXT(4)_Y ;date/time
 S HDITEXT(5)=""
 S HDITEXT(6)="Patch IB*2.0*585 has standardized file: "_FILNAM_" (#"_FIL_")"
 S HDITEXT(7)=""
 S HDITEXT(8)="The current HDIS status of file #"_FIL_"is:  "_$P($$GETSTAT^HDISVF01(FIL),U)
 S HDITEXT(9)=""
 S HDITEXT(10)="Site: "_$P(IBSITE,"^",2)_" - "_$P(IBSITE,"^",3)_"  needs full file update of the "_FILNAM_" file (#"_FIL_" as soon as possible."
 S HDITEXT(11)=""
 N DIFROM S XMTEXT="HDITEXT(" D ^XMD K DIFROM
 S MSG="File: "_FIL_" Has been 'seeded'. Message Number: "_$G(XMZ) D PSTDONE(MSG)
 Q
 ;
PSTDONE(MSG) ; display FINISHED message
 N HDIMSG
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch IB*2.0*585 HDIS 'seeding' "_FILNAM_" file (#"_FIL_") has Completed."
 S HDIMSG(4)="***** An update message has been sent to Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
PSTHALT(MSG) ; display error message
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch IB*2.0*585 HDIS 'seeding' has been halted."
 S HDIMSG(4)="***** Please contact Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
DUMSEED ; New file 355.99 contains no data, can't be seeded unless there is at least one entry?
 ;
 ; MASTER TYPE OF PLAN (#355.99) file initial population data elements from DAT35599 line tag;
 ;
 ; IBDATA ";" PIECE - FIELD # - FIELD NAME
 ;        PIECE #1  -   n/a   - IEN 
 ;        PIECE #2  -  .01    - PLAN NAME
 ;        PIECE #3  -    1    - PHDSC SOURCE OF PAYMENT
 ;
 N IBMTOPI,IBMFILE,IBDATA,IBDATLN,IBFDA,IBRSLT,XUMF
 S IBMFILE=355.99
 S XUMF=1
 F IBDATLN=1:1 S IBDATA=$P($T(DAT35599+IBDATLN),";",3,10) Q:IBDATA=""  D
 .N IBMTOPI,IBFDA,IBFDAIEN,IBEFFDT
 .S IBMTOPI=$P(IBDATA,";")
 .S IBFDA(355.99,"+1,",.01)=$P(IBDATA,";",2)
 .S IBFDA(355.99,"+1,",1)=$P(IBDATA,";",3)
 .S IBFDAIEN(1)=IBMTOPI
 .S IBRSLT=$$INSREC(IBMFILE,IBMTOPI,.IBFDA,.IBFDAIEN)
 Q
 ;
INSREC(IBFILE,IBIEN,IBFDA,IBFDAIEN) ; Insert IBIEN into file IBFILE with data in IBFDA
 I ('$G(IBFILE)) Q "0^Invalid parameter"
 N IBDERR
 I '$G(IBFDAIEN(1)) S IBFDAIEN="",IBFDAIEN(1)=""
 D UPDATE^DIE("","IBFDA","IBFDAIEN","IBDERR")
 I $D(IBDERR) Q -1
 Q +$G(IBFDA)
 ;
 ;
 ; IBDATA ";" PIECE - FIELD # - FIELD NAME
 ;        PIECE #1  -   n/a   - IEN 
 ;        PIECE #2  -  .01    - PLAN NAME
 ;        PIECE #3  -    1    - PHDSC SOURCE OF PAYMENT
 ;
DAT35599 ; Data to populate the MASTER TYPE OF PLAN (#355.99) file
 ;;1;MEDICARE;1
 ;;2;Medicare (Managed Care);11
 ;;3;Medicare HMO;111
 ;;4;Medicare PPO;112
 ;;5;Medicare POS;113
 ;;6;Medicare Managed Care Other;119
 ;;7;Medicare (Non-managed Care);12
 ;;8;Medicare FFS;121
 ;;9;Medicare Drug Benefit;122
 ;;10;Medicare Medical Savings Account (MSA);123
 ;;11;Medicare Non-managed Care Other;129
 ;;12;Medicare Hospice;13
 ;;13;Dual Eligibility Medicare/Medicaid Organization;14
 ;;14;Medicare Other;19
 ;;15;Medicare Pharmacy Benefit Manager;191
 Q
