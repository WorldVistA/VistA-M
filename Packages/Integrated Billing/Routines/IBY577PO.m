IBY577PO ;ALB/VD - POST-INSTALL FOR IB*2.0*577 ;22-FEB-2017
 ;;2.0;INTEGRATED BILLING;**577**;21-MAR-94;Build 38
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 S IBA(2)="IB*2*577 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D RIT
 D:$$PROD^XUPROD(1) EMAIL
 S IBA(2)="IB*2*577 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
RIT ; Recompile billing screen templates due to changes to Field #399,.21 cross-references.
 N X,Y,DMAX,IBN
 D MES^XPDUTL(">> Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:10,"102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN),Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B"),DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL("     Recompile Completed.")
 Q
 ;
EMAIL ; Send an email message to MCCF Developer Team identifying which forms [#353] are being used by this site.
 N SITE,SUBJ,MSG,XMTO,LN,GLO,GLB,II
 D BMES^XPDUTL(">> Checking to see which Forms are in Use at this Site...")
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending email notification to MCCF Developers ... ")
 S SITE=$$SITE^VASITE
 S SUBJ="Form #7 "_$S($D(^IBE(353,7)):"*IS*",1:" is not")_" used at Station# "_$P(SITE,U,3)_" - "_$P(SITE,U,2)
 S SUBJ=$E(SUBJ,1,65)
 S MSG(1)="The following site:"
 S MSG(2)=""
 S MSG(3)="        Name: "_$P(SITE,U,2)
 S MSG(4)="    Station#: "_$P(SITE,U,3)
 S MSG(5)="      Domain: "_$G(^XMB("NETNAME"))
 S MSG(6)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S MSG(7)=""
 S MSG(8)="uses the following Forms:"
 S MSG(9)=""
 S LN=9,II=0
 F  S II=$O(^IBE(353,II)) Q:'+II  D
 . S LN=LN+1,MSG(LN)="  Form # "_II_" - for '"_$P($G(^IBE(353,II,0)),"^",1)_"'"
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="---------------"
 ;
 S XMTO("Vito.D'Amico@domain.ext")=""
 S XMTO("William.Jutzi@domain.ext")=""
 S XMTO("John.Smith5@domain.ext")=""
 ;
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO)
 ;
EMAILX ;
 D MES^XPDUTL(" Done.")
 D CLEAN^DILF
 Q
 ;
