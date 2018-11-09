XU8P672E ;SFISC/RSD - Environment Check ;06/24/2008
 ;;8.0;KERNEL;**672**;Jul 10, 1995;Build 28
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;during load, XPDENV=0
 N XFILE
 S XFILE=$$CHK() Q:'XPDENV
 ;during install
 N CNT,DIR,DIU,I,X,XLET,Y
 I XFILE]"" D
 . S DIR(0)="Y",DIR("A")="Do you want me to delete the "_XFILE_ " file, #1.5",DIR("B")="NO"
 . D ^DIR I Y'=1 S XPDQUIT=1 Q  ;don't want to delete, abort install and delete Transport Global
 . K ^TMP($J) S CNT=0
 . ;check for LetterMan in ALTERNATE EDITOR file #1.2
 . D BMES^XPDUTL("Ok, we will delete file 1.5, first need to check if your site is using LetterMan...")
 . S XLET=0 F  S XLET=$O(^DIST(1.2,XLET)) Q:'XLET  I $G(^(XLET,0))["LETTERMAN" Q
 . D:XLET
 .. ;check NEW PERSON file #200, check PREFERRED EDITOR #31.3 for LetterMan
 .. S I=0 F  S I=$O(^VA(200,I)) Q:'I  S X=$G(^VA(200,I,1)) D:$P(X,U,5)=XLET
 ... S CNT=CNT+1,^TMP($J,CNT)=I_"^"_$P($G(^VA(200,I,0)),U)
 ... D REMOV(I,200,31.3) Q
 .. D REMOV(XLET,1.2,.01) ;remove LetterMan from ALTERNATE EDITOR file.
 .. Q
 . S DIU=1.5,DIU(0)="ET" D EN^DIU2,BMES^XPDUTL("File 1.5 deleted")
 . D MAIL
 K ^TMP($J)
 Q
 ;
CHK() ;check file 1.5  Returns: file name or null if ENTITY.
 N X,Y
 S Y=""
 I $D(^DIC(1.5,0))#2 S Y=$P(^(0),"^"),Y=$S(Y'="ENTITY":Y,1:"") D:Y]""
 . S X(1)=" Your site has the CLASS III "_Y_" file, #1.5."
 . S X(2)="In order to install this patch the file will be deleted during install."
 . D MES^XPDUTL(.X)
 Q Y
 ;
REMOV(DA,XFIL,XFLD) ;remove value from XFIL(file) and XFLD(field) for record DA
 N CNT,I,X,XFILE,XLET,XUDATA,Y
 S XUDATA(XFIL,DA_",",XFLD)="@"
 D FILE^DIE("","XUDATA")
 Q
 ;
MAIL ;create mail message to send to Forum
 N I,XMY,XUTEXT,XMTEXT,XMDUZ,XMSUB,XMZ,XMMG
 S XMY("G.PATCH TRACKING XU_8_672@DOMAIN.EXT")=""
 ;Message for server
 S XUTEXT(1,0)="XU*8*672"
 S XUTEXT(2,0)="SITE: "_$G(^XMB("NETNAME"))
 S XUTEXT(3,0)="DATE: "_$$FMTE^XLFDT(DT)
 S XUTEXT(4,0)="Installed by: "_$P($G(^VA(200,+$G(DUZ),0)),U)
 S XUTEXT(5,0)="Install Name: "_$G(XPDNM)
 S XUTEXT(6,0)=" File "_XFILE_" #1.5 removed"
 S XUTEXT(7,0)=" The following Users had their PREFERRED EDITOR field #31.3 removed:"
 F I=1:1 Q:$G(^TMP($J,I))=""  S XUTEXT(I+7,0)=^(I)
 S XMDUZ=$G(DUZ),XMTEXT="XUTEXT(",XMSUB="Patch XU*8*672 Installation"
 D ^XMD
 Q
