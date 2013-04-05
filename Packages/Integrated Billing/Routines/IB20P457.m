IB20P457 ;WOIFO/KJS/PO - POST-INIT FOR IB*2.0*457;11-1-2011
 ;;2.0;INTEGRATED BILLING;**457**;21-MAR-94;Build 30
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine contains the post-initialization code for
 ; Integrated Billing package v2.0. Patch 457
 ;
 Q
 ;
POST ;
 ;
 D DOMSET
 D PARMSET
 D MAILGRP
 Q
 ;
DOMSET ; set up the domain file
 N IBDOMARR,DA,DDER,IBDOMAIN,DIC,X,Y,DDER
 S IBDOMARR("Q-IBH.domain.ext")=""
 S IBDOMARR("Q-IBK.domain.ext")=""
 S IBDOMARR("Q-IBN.domain.ext")=""
 S IBDOMARR("Q-IBX.domain.ext")=""
 S IBDOMAIN=""
 F  S IBDOMAIN=$O(IBDOMARR(IBDOMAIN)) Q:IBDOMAIN=""  D
 . Q:$O(^DIC(4.2,"B",IBDOMAIN,0))         ;quit if domain already exist.
 . D MES^XPDUTL("Creating "_IBDOMAIN_" domain... ")
 . S DIC="^DIC(4.2,",DIC(0)="L",X=IBDOMAIN,DIC("DR")="1///S;2///FOC-AUSTIN.domain.ext;1.7///YES" D FILE^DICN K DIC,X
 Q
 ;
PARMSET ;
 ;setup 350.9
 Q:$D(^IBE(350.9,1,13))  ;already setup
 N SITE,EXTFILE,DMIQ,EXTTYP,PARMS,IENS1,IENS2,IBD0,IBD1,DIK,DA
 S SITE=$P($$SITE^VASITE(),U,3)
 S PARMS(350.9,"1,",13.01)="USER$:[HMS]"
 S PARMS(350.9,"1,",13.02)=0
 S PARMS(350.9,"1,",13.03)="VA"_SITE_".TXT"
 S PARMS(350.9,"1,",13.04)=31
 S PARMS(350.9,"1,",13.05)=2
 S PARMS(350.9,"1,",13.06)=24
 S PARMS(350.9,"1,",13.07)=100
 D UPDATE^DIE("","PARMS","IENS1")
 ;
 ; delete the Extract File sub-file, if any, before creating the 
 S IBD0=1    ; this is hard coded is only one ien
 S IBD1=0
 F  S IBD1=$O(^IBE(350.9,IBD0,13.08,IBD1)) Q:'IBD1  D
 . S DA(1)=IBD0
 . S DA=IBD1
 . S DIK="^IBE(350.9,"_DA(1)_",13.08,"
 . D ^DIK
 ;
 F I=1:1:4 S IENS2(I)=I
 S PARMS(350.9006,"+1,1,",.01)="NOINSUR"
 S PARMS(350.9006,"+1,1,",.02)=1
 S PARMS(350.9006,"+1,1,",.03)="VEHMN"_SITE_".TXT"
 S PARMS(350.9006,"+1,1,",.04)="XXX@Q-IBN.domain.ext"
 S PARMS(350.9006,"+1,1,",.05)=1
 S PARMS(350.9006,"+1,1,",.06)=2
 S PARMS(350.9006,"+2,1,",.01)="ENHNOIN"
 S PARMS(350.9006,"+2,1,",.02)=1
 S PARMS(350.9006,"+2,1,",.03)="VEHMH"_SITE_".TXT"
 S PARMS(350.9006,"+2,1,",.04)="XXX@Q-IBH.domain.ext"
 S PARMS(350.9006,"+2,1,",.05)=1
 S PARMS(350.9006,"+2,1,",.06)=2
 S PARMS(350.9006,"+3,1,",.01)="NORXINS"
 S PARMS(350.9006,"+3,1,",.02)=1
 S PARMS(350.9006,"+3,1,",.03)="VEHMX"_SITE_".TXT"
 S PARMS(350.9006,"+3,1,",.04)="XXX@Q-IBX.domain.ext"
 S PARMS(350.9006,"+3,1,",.05)=1
 S PARMS(350.9006,"+3,1,",.06)=2
 S PARMS(350.9006,"+4,1,",.01)="NONVERINS"
 S PARMS(350.9006,"+4,1,",.02)=1
 S PARMS(350.9006,"+4,1,",.03)="VEHMK"_SITE_".TXT"
 S PARMS(350.9006,"+4,1,",.04)="XXX@Q-IBK.domain.ext"
 S PARMS(350.9006,"+4,1,",.05)=0
 S PARMS(350.9006,"+4,1,",.06)=2
 D UPDATE^DIE("","PARMS","IENS2")
 Q
 ;
MAILGRP ;
 N EC,MG,MGDESC,MGNAM,X,MGTYP,MGORG,MGSE,MGSIL,XMTEXT,MGMEM,XMY
 ;Call the MailMan API to Create Mail Groups.
 ;Code for the mail groups MUST remain for later rounds.
 S MG("IBH")=""
 S MG("IBK")=""
 S MG("IBN")=""
 S MG("IBX")=""
 S MGNAM="",MGORG=DUZ
 S (MGTYP,MGSE)=0,MGSIL=1,MGMEM=""
 ;
 ;need to add the server option this way as it doesn't have a DUZ
 S MGMEM="S.IBCNF EII GET SERVER"
 D ADDMBRS^XMXAPIG(MGORG,.MG,MGMEM)
 ;
 ;setup IRM mail group
 S MGNAM="IBCNF EII IRM"
 S MGMEM(DUZ)="" ; put person running this patch in group initially
 S X=$$MG^XMBGRP(MGNAM,MGTYP,MGORG,MGSE,.MGMEM,.MGDESC,MGSIL)
 I X D
 . D BMES^XPDUTL(">>> "_MGNAM_" mail group added successfully!")
 . D BMES^XPDUTL(">>> You have been added as a member of this mail group.")
 . D MES^XPDUTL("    Please add members or remove yourself as appropriate.")
 ;
 ;setup XML mail group
 S MGNAM="IBCNF EII XML READY"
 S MGMEM(DUZ)="" ; put person running this patch in group initially
 S X=$$MG^XMBGRP(MGNAM,MGTYP,MGORG,MGSE,.MGMEM,.MGDESC,MGSIL)
 I X D
 . D BMES^XPDUTL(">>> "_MGNAM_" mail group added successfully!")
 . D BMES^XPDUTL(">>> You have been added as a member of this mail group.")
 . D MES^XPDUTL("    Please add members or remove yourself as appropriate.")
 ;
 Q
