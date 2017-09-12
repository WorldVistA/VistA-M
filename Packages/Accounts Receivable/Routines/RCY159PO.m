RCY159PO ;MAF/ALB - POST-INIT FOR PATCH PRCA*159 AR/RCI ;FEB 19,2004
 ;;4.5;Accounts Receivable;**159**;Mar 20, 1995
 D BMES^XPDUTL("This Post-Installation populates new fields (34) RC MAIL ADDRESS and ")
 D MES^XPDUTL("(35) RC DEATH NOTIFICATION ADDRESS in file 349.1 AR TRANSMISSIONS TYPE")
 D MES^XPDUTL("with the new Regional Counsel Mail Address and Death Notification addresses.")
 I $D(^RCT(349.1,"B","RC")) S RCIFN=$O(^RCT(349.1,"B","RC",0)) I RCIFN]"",$D(^RCT(349.1,RCIFN,6,0)),$O(^RCT(349.1,RCIFN,6,0)) D
 .D BMES^XPDUTL("If sites are currently testing the software for patch IB*2.0*159 and have")
 .D MES^XPDUTL("information in the new DIVISION OF CARE field (61), this information will be")
 .D MES^XPDUTL("updated with the new RC mail address and death notification address that")
 .D MES^XPDUTL("corresponds with the division.")
 .D BMES^XPDUTL("New fields (.03) RC MAIL ADDRESS and (.04) RC DEATH NOTIFICATION ADDRESS")
 .D MES^XPDUTL("are updated in the DIVISION OF CARE multiple in file 349.1")
 ;
ARRAY ;This will update two new fields in file 349.1:
 ;field RC MAIL ADDRESS #34
 ;field RC DEATH NOTIFICATION ADDRESS #35 
 ;with the new Regional Counsel addresses
 ;D BMES^XPDUTL("...Updating field (34) RC MAIL ADDRESS ") 
 ;D MES^XPDUTL("...Updating field (35) RC DEATH NOTIFICATIONS ADDRESS for file 349.1 ")
 K ADDR
 N ADDR,RCCT,RCSITE,RCRC,RCDOM,RCDETH,RCNEW,RCIFN,RCNODE,X
 ;
 ; find the primary RC mail address from file 349.1 field 33
 I $D(^RCT(349.1,"B","RC")) S RCIFN=$O(^RCT(349.1,"B","RC",0)) I RCIFN]"" D
 .S RCDOM=$P($G(^RCT(349.1,RCIFN,3)),"^",3)
 .Q
 I $G(RCDOM)="" D  G EXIT
 .D BMES^XPDUTL("...There is no primary REMOTE DOMAIN.") D BMES^XPDUTL("...Please update field (32) REMOTE DOMAIN in AR TRANSMISSION TYPE file (349.1)") D MES^XPDUTL("   for the Regional Counsel (RC) type of transmission.")
 .D BMES^XPDUTL("...After file update, run 'Restart Install of Package(s) under the Installation")
 .D MES^XPDUTL("   option of the Kernel Installation and Distributions System.") S XPDABORT=1
 .Q
 D BMES^XPDUTL("...Updating field (34) RC MAIL ADDRESS ")
 D MES^XPDUTL("...Updating field (35) RC DEATH NOTIFICATIONS ADDRESS for file 349.1 ")
 D SETARR
 I $D(ADDR(RCDOM)) D
 .S RCNODE=ADDR(RCDOM),RCNEW=$P(RCNODE,"^",2),RCDETH=$P(RCNODE,"^",4)
 .S DIE="^RCT(349.1,",DA=RCIFN,DR="34////^S X="""_RCNEW_""""_";35////^S X="""_RCDETH_""""
 .D ^DIE K DIE,DA,DR
 D BMES^XPDUTL("...Fields 34 and 35 have been updated for the primary site.")
 ;I $D(^RCT(349.1,RCIFN,6,0)) D
 I $D(^RCT(349.1,RCIFN,6,0)),$O(^RCT(349.1,RCIFN,6,0)) D
 .D BMES^XPDUTL("...Updating DIVISION OF CARE MULTIPLE fields:") D MES^XPDUTL("   (.03) RC MAIL ADDRESS and (.04) RC DEATH NOTIFICATION ADDRESS")
 .N RCNEW,RCNODE,RCDETH,RCDIVC,RCDVADD,RCDVIFN,X,RCDVSION
 .S RCDVIFN=0
 .F RCDIVC=0:0 S RCDVIFN=$O(^RCT(349.1,RCIFN,6,RCDVIFN)) Q:'RCDVIFN  S RCDVADD=$P($G(^RCT(349.1,RCIFN,6,RCDVIFN,0)),"^",2) I RCDVADD]"" D
 ..S RCDOM=$P($G(^DIC(4.2,RCDVADD,0)),"^",1)
 ..S RCDVSION=$P($G(^RCT(349.1,RCIFN,6,RCDVIFN,0)),"^",1)
 ..I RCDOM]""&($D(ADDR(RCDOM))) S RCNODE=ADDR(RCDOM),RCNEW=$P(ADDR(RCDOM),"^",2),RCDETH=$P(ADDR(RCDOM),"^",4)
 ..S DIE="^RCT(349.1,"_RCIFN_",6,",DA(1)=RCIFN,DA=RCDVIFN,DR=".03////^S X="""_RCNEW_""""_";.04////^S X="""_RCDETH_""""
 ..;S DIE="^RCT(349.1,",DA=RCDVIFN,DR="61",DR(2,349.161)=".03////^S X="""_RCNEW_""""_";.04////^S X="""_RCDETH_""""
 ..D ^DIE  K DIE,DA,DA(1),DR
 ..D BMES^XPDUTL("...Fields (.03) and (.04) have been updated for "_$P($G(^DG(40.8,RCDVSION,0)),U,1))
 D BMES^XPDUTL("Post-Installation Updates Complete.")
 Q
SETARR ;Set up the ADDR array with all of the addresses and information
 F RCCT=1:1 S RCSITE=$P($T(ADDR+RCCT),";;",2) Q:RCSITE="END"  S ADDR($P(RCSITE,"^",1))=RCSITE
 Q
EXIT ;EXIT 
 Q
 Q
 ;Regional Counsel Addresses old and new
 ;piece 1 old address to RC 
 ;piece 2 new RC address
 ;piece 3 old RC death notification address
 ;piece 4 new RC death notification address
ADDR ;
 ;;RC-BOSTON.GC.DOMAIN.EXT^OGCBOSRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-BOSTON.GC.DOMAIN.EXT^OGCRegion1DeathNotification@mail.domain.ext
 ;;RC-NEWYORK.GC.DOMAIN.EXT^OGCNYNRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-NEWYORK.GC.DOMAIN.EXT^OGCRegion2DeathNotification@mail.domain.ext
 ;;RC-BALTIMORE.GC.DOMAIN.EXT^OGCBALRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-BALTIMORE.GC.DOMAIN.EXT^OGCRegion3DeathNotification@mail.domain.ext
 ;;RC-PHILADELP.GC.DOMAIN.EXT^OGCPHIRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-PHILADELP.GC.DOMAIN.EXT^OGCRegion4DeathNotification@mail.domain.ext
 ;;RC-ATLANTA.GC.DOMAIN.EXT^OGCATLRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-ATLANTA.GC.DOMAIN.EXT^OGCRegion5DeathNotification@mail.domain.ext
 ;;RC-BAY-PINES.GC.DOMAIN.EXT^OGCBAYRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-BAY-PINES.GC.DOMAIN.EXT^OGCRegion6DeathNotification@mail.domain.ext
 ;;RC-CLEVELAND.GC.DOMAIN.EXT^OGCCLERI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-CLEVELAND.GC.DOMAIN.EXT^OGCRegion7DeathNotification@mail.domain.ext
 ;;RC-NASHVILLE.GC.DOMAIN.EXT^OGCNASRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-NASHVILLE.GC.DOMAIN.EXT^OGCRegion8DeathNotification@mail.domain.ext
 ;;RC-JACKSON.GC.DOMAIN.EXT^OGCJACRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-JACKSON.GC.DOMAIN.EXT^OGCRegion9DeathNotification@mail.domain.ext
 ;;RC-CHICAGO.GC.DOMAIN.EXT^OGCCHIRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-CHICAGO.GC.DOMAIN.EXT^OGCRegion10DeathNotification@mail.domain.ext
 ;;RC-DETROIT.GC.DOMAIN.EXT^OGCDETRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-DETROIT.GC.DOMAIN.EXT^OGCRegion11DeathNotification@mail.domain.ext
 ;;RC-STLOUIS.GC.DOMAIN.EXT^OGCSTLRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-STLOUIS.GC.DOMAIN.EXT^OGCRegion12DeathNotification@mail.domain.ext
 ;;RC-WACO.GC.DOMAIN.EXT^OGCWACRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-WACO.GC.DOMAIN.EXT^OGCRegion13DeathNotification@mail.domain.ext
 ;;RC-HOUSTON.GC.DOMAIN.EXT^OGCHOURI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-HOUSTON.GC.DOMAIN.EXT^OGCRegion14DeathNotification@mail.domain.ext
 ;;RC-MINNEAPO.GC.DOMAIN.EXT^OGCMINRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-MINNEAPO.GC.DOMAIN.EXT^OGCRegion15DeathNotification@mail.domain.ext
 ;;RC-DENVER.GC.DOMAIN.EXT^OGCDENRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-DENVER.GC.DOMAIN.EXT^OGCRegion16DeathNotification@mail.domain.ext
 ;;RC-LOSANG.GC.DOMAIN.EXT^OGCLOSRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-LOSANG.GC.DOMAIN.EXT^OGCRegion17DeathNotification@mail.domain.ext
 ;;RC-SANFRAN.GC.DOMAIN.EXT^OGCSFCRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-SANFRAN.GC.DOMAIN.EXT^OGCRegion18DeathNotification@mail.domain.ext
 ;;RC-PHOENIX.GC.DOMAIN.EXT^OGCPHORI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-PHOENIX.GC.DOMAIN.EXT^OGCRegion19DeathNotification@mail.domain.ext
 ;;RC-PORTLAND.GC.DOMAIN.EXT^OGCPORRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-PORTLAND.GC.DOMAIN.EXT^OGCRegion20DeathNotification@mail.domain.ext
 ;;RC-BUFFALO.GC.DOMAIN.EXT^OGCBUFRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-BUFFALO.GC.DOMAIN.EXT^OGCRegion21DeathNotification@mail.domain.ext
 ;;RC-INDIANAPO.GC.DOMAIN.EXT^OGCINDRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-INDIANAPO.GC.DOMAIN.EXT^OGCRegion22DeathNotification@mail.domain.ext
 ;;RC-WINSTON.GC.DOMAIN.EXT^OGCWINRI@MAIL.DOMAIN.EXT^G.RC RC REFERRALS@RC-WINSTON.GC.DOMAIN.EXT^OGCRegion23DeathNotification@mail.domain.ext
 ;;END
