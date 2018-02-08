XU671PO ;BPFO/CLT - PATCH XU*8.0*671 POST INSTALL ; 31 Aug 2016  11:24 AM
 ;;8.0;KERNEL;**671**;JUL 03, 1995;Build 16
 ;
 ; This routine uses the following IAs:
 ; #4640 - ^HDISVF01 calls (supported)
 ; #4639 - ^HDISVCMR calls     (supported)
 ; #4651 - ^HDISVF09 calls     (supported)
 ;
HDIS ;
 N DIC,DA,PXVTMP,HDISP,DOMAIN,FIL,XPROD,XMSUB,HDITEXT,XMY,XMDUZ,XMTEXT,XMZ,XMMG,XMYBLOB,XMMG,XMSTRIP
 N XMTO,XMINSTR,XMDF,DOMPTR,TMP,XMY
 N XUMAILGROUP,XUMAILGROUPXQA,XUSITE,XUSTN,XUST,XUTEXT,XUX,XUDTA,XUMSG,WB,XUXNM,HDIMSG,X,Y
 S U="^" I $G(DT)="" S DT=$$DT^XLFDT
 ;
 D HDISAV
 D SMSG
 G HDISQ
 ;
HDISAV ; entry for hdis process
 ; 8932.1 data save into ^XTMP
 S WB=$$SITE^VASITE,WB=$P(WB,U,1)
 S XUXNM="XU PATCH 671 SAVE OF FILE 8932-1",XUX=0
 S XUDTA=$G(^XTMP(XUXNM,0)) S:XUDTA="" $P(XUDTA,U,3)="Save of file 8932.1 for patch XU*8.0*671"
 S $P(XUDTA,U,1)=$$FMADD^XLFDT(DT,90),$P(XUDTA,U,2)=DT,^XTMP(XUXNM,0)=XUDTA
 S XUX=$G(^XTMP(XUXNM,"D",0)),XUX=XUX+1,^XTMP(XUXNM,"D",0)=XUX
 ;save 8932.1
 M ^XTMP(XUXNM,"D",XUX,"8932.1")=^USC(8932.1)
 ;
 ; check if process has already been done
 S DOMAIN="PROVIDERS",FIL=8932.1
 S A=$P($$GETSTAT^HDISVF01(FIL),U)
 ; if status already set do not re-run
 I A>3 S MSG="File: "_FIL_" Has already been seeded. Status is: "_A D PSTHALT(MSG) Q
 ;
 S TMP=$$GETIEN^HDISVF09(DOMAIN,.DOMPTR)
 I '+DOMPTR D MES^XPDUTL("***** Error retrieving the IEN for the "_DOMAIN_" domain."),PSTHALT("") Q
 ; set the seeding status to complete for data deployments.
 D SETSTAT^HDISVF01(FIL,,4)
 ; send message to STS that patch is installed and the current status
 S XPROD=$$PROD^XUPROD()
 S PXVTMP=$$SITE^VASITE()
 S XMSUB="Site: "_$P(PXVTMP,"^",2)_" File: 8932.1 in "_($S(XPROD:"PRODUCTION",1:"TEST"))_" ready for ERT Update"
 S XMY("G.HDIS ERT NOTIFICATION@DOMAIN.EXT")=""
 S XMDUZ="Site: "_$P(PXVTMP,"^",3)_" Patch Install XU*8*671 is Complete"
 S XMY(DUZ)=""
 K HDITEXT
 S HDITEXT(1)=""
 S HDITEXT(2)="Site: "_$P(PXVTMP,"^",2)_" - "_$P(PXVTMP,"^",3)
 S HDITEXT(2)=HDITEXT(2)_" with Domain/IP Address of "_$G(^XMB("NETNAME")) ;facility name
 S HDITEXT(3)="Has Installed Patch XU*8*671 into their "_$S(XPROD:"PRODUCTION",1:"TEST")_" System Environment"
 S HDITEXT(4)="The Patch was Installed on: "
 S B=$$NOW^XLFDT N Y S Y=B D DD^%DT S HDITEXT(4)=HDITEXT(4)_Y ;date/time
 S HDITEXT(5)=""
 S HDITEXT(6)="Patch XU*8*671 has standardized file: PERSON CLASS (#8932.1)"
 S HDITEXT(7)=""
 S HDITEXT(8)="The current HDIS status of file #8932.1 is:  "_$P($$GETSTAT^HDISVF01(FIL),U)
 S HDITEXT(9)=""
 S HDITEXT(10)="Site: "_$P(PXVTMP,"^",2)_" - "_$P(PXVTMP,"^",3)_"  needs full file update of the PERSON CLASS file (#8932.1) as soon as possible."
 S HDITEXT(11)=""
 N DIFROM S XMTEXT="HDITEXT(" D ^XMD K DIFROM
 ;
 S MSG="File: "_FIL_" Has been 'seeded'. Message Number: "_$G(XMZ) D PSTDONE(MSG)
 Q
 ;
 ; send message to G.PERSON CLASS UPDATE group
SMSG S XUSITE=$$SITE^VASITE,XUSTN=$P(XUSITE,"^",2),XUST=$P(XUSITE,"^",3)
 S XMSUB="SITE: "_XUST_" "_XUSTN_" PERSON CLASS File (#8932.1) updates have transitioned From Kernel "_DT
 K XMY S XMY(DUZ)="",XMY("G.PERSON CLASS UPDATE")=""
 K XUTEXT
 S XUTEXT(1)="*************************************************************************"
 S XUTEXT(2)="* NOTE: FOR MEMBERS OF THE PERSON CLASS UPDATE MAIL GROUP               *"
 S XUTEXT(3)="*                                                                       *"
 S XUTEXT(4)="* PLEASE NOTE: The Kernel Team will no longer be deploying the updates  *"
 S XUTEXT(5)="* to the PERSON CLASS File (#8932.1). The deployment of the file has    *"
 S XUTEXT(6)="* been transitioned to the Standards & Terminology Services Team (STS). *"
 S XUTEXT(7)="*                                                                       *"
 S XUTEXT(8)="* The Standards & Terminology Services Team (STS) will use an automated *"
 S XUTEXT(9)="* e-mail delivery 'listserv' to notify users of updates to the PERSON   *"
 S XUTEXT(10)="* CLASS File (#8932.1).                                                 *"
 S XUTEXT(11)="* All personnel that maintain associations between users and the Person *"
 S XUTEXT(12)="* Class file MUST subscribe to the NTRT_NOTIFICATION-L listserv (       *"
 S XUTEXT(13)="* detailed below) to receive communications about deployments of the    *"
 S XUTEXT(14)="* PERSON CLASS File (#8932.1).                                          *"
 S XUTEXT(15)="* (Note: STS will not use the Kernel Team's G.PERSON CLASS UPDATE mail  *"
 S XUTEXT(16)="* group for updates.)                                                   *"
 S XUTEXT(17)="*                                                                       *"
 S XUTEXT(18)="* The responsible person will initially need to run the following       *"
 S XUTEXT(19)="* options twice.                                                        *"
 S XUTEXT(20)="* The options will need to be run whenever an update                    *"
 S XUTEXT(21)="* deployment of the PERSON CLASS File (#8932.1) has been sent.          *"
 S XUTEXT(22)="*                                                                       *"
 S XUTEXT(23)="* Once when the patch has been installed and has received this          *"
 S XUTEXT(24)="* notification. The second time when notified by the NTRT_NOTIFICATION-L*"
 S XUTEXT(25)="* listserv that the PERSON CLASS File (#8932.1) has been deployed.      *"
 S XUTEXT(26)="* The purpose of the first is to set the baseline of which users are    *"
 S XUTEXT(27)="* associated to inactive Person Class entries and allows the facility   *"
 S XUTEXT(28)="* to associate those users to active Person Class entries.              *"
 S XUTEXT(29)="* The second allows the facility to identify users who are associated   *"
 S XUTEXT(30)="* to newly inactivated Person Class entries and associate them to active*"
 S XUTEXT(31)="* Person Class entries.                                                 *"
 S XUTEXT(32)="*                                                                       *"
 S XUTEXT(33)="*OPTIONS:                                                               *"
 S XUTEXT(34)="* Use the 'List Inactive Person Class Users' [XU-INACTIVE PERSON CLASS  *"
 S XUTEXT(35)="* USERS] option to list all users who currently have inactive person    *"
 S XUTEXT(36)="* classes assigned.                                                     *"
 S XUTEXT(37)="*                                                                       *"
 S XUTEXT(38)="* Use the 'Person Class Edit' [XU-PERSON CLASS EDIT] option to assign   *"
 S XUTEXT(39)="* an active Person Class to the users that are associated to inactive   *"
 S XUTEXT(40)="* Person Classes.                                                       *"
 S XUTEXT(41)="* Do NOT use FM Enter/Edit the edit a users person class.               *"
 S XUTEXT(42)="*                                                                       *"
 S XUTEXT(43)="* If you do not have access to either of these options, please contact  *"
 S XUTEXT(44)="* your regional support team for assignment to the                      *"
 S XUTEXT(45)="* correct menu options.                                                 *"
 S XUTEXT(46)="*                                                                       *"
 S XUTEXT(47)="*                                                                       *"
 S XUTEXT(48)="* When STS deploys an update to the PERSON CLASS file (#8932.1) a       *"
 S XUTEXT(49)="* message is sent to the NTRT_NOTIFICATION-L listserv.                  *"
 S XUTEXT(50)="*                                                                       *"
 S XUTEXT(51)="*                                                                       *"
 S XUTEXT(52)="* SUBSCRIBE TO THE LISTSERV                                             *"
 S XUTEXT(53)="* The VA's listserv is an e-mail list and e-mail delivery solution to   *"
 S XUTEXT(54)="* manage electronic newsletters, discussion groups, and direct e-mail.  *"
 S XUTEXT(55)="*                                                                       *"
 S XUTEXT(56)="* lISTSERV: NTRT_NOTIFICATION-L                                         *"
 S XUTEXT(57)="* The personnel at the facility who are responsible for entering        *"
 S XUTEXT(58)="* or editing 'Persons' associations to the PERSON CLASS file (#8932.1)  *"
 S XUTEXT(59)="* shall subscribe to this list using the following web site:            *"
 S XUTEXT(60)="*                                                                       *"
 S XUTEXT(61)="* http://vaww.listserv.domain.ext/scripts/wa.exe.                           *"
 S XUTEXT(62)="*                                                                       *"
 S XUTEXT(63)="* The STS group does not own the List Serve application. The List Serve *"
 S XUTEXT(64)="* is a VA service.                                                      *"
 S XUTEXT(65)="* The responsible personnel will need to create an account using a      *"
 S XUTEXT(66)="* username and password that does NOT synchronize with their VA network *"
 S XUTEXT(67)="* account.                                                              *"
 S XUTEXT(68)="*************************************************************************"
 S XUTEXT(69)=" "
 S XUTEXT(70)="Please refer to the 'Assigning Person Class to Providers User Guide"
 S XUTEXT(71)="(XU*8.0*531)'located at https://www4.domain.ext/VDL/documents/Infrastructure/"
 S XUTEXT(72)="Kernel/xu_8_0p671sp.pdf. for a listing of PERSON CLASS File entries that"
 S XUTEXT(73)="are inactive with this patch."
 S XUTEXT(74)=""
 N DIFROM S XMTEXT="XUTEXT(" D ^XMD K DIFROM
 K XUTEXT,XMTEXT
 ;
 Q
 ;
HDISQ ; quit point
 K DIC,DA,PXVTMP,HDISP,DOMAIN,FIL,XMSUB,HDITEXT,XMY,XMDUZ,XMTEXT,XMZ,XMMG,XMYBLOB,XMMG,XMSTRIP
 K XMTO,XMINSTR,XMDF,DOMPTR,TMP,XMY
 K XUSITE,XUSTN,XUST,XUTEXT,XUX,XUDTA,XUMSG,WB,XUXNM,HDIMSG,X,Y
 Q
 ;
PSTHALT(MSG) ; display error message
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch XU*8.0*671 HDIS 'seeding' has been halted."
 S HDIMSG(4)="***** Please contact Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
PSTDONE(MSG) ; display FINISHED message
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch XU*8.0*671 HDIS 'seeding' has Completed."
 S HDIMSG(4)="***** An update message has been sent to Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
