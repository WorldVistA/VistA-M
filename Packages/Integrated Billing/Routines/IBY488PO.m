IBY488PO ;BAA/GEF - Post-Installation for IB patch 488 ;19-APR-2011
 ;;2.0;INTEGRATED BILLING;**488**;15-APR-14;Build 184
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 D RIT
 Q
 ;
RIT ; recompile billing screen templates
 N X,Y,DMAX,IBN
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:9,"10","102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN)
 .S Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B")
 .S DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL(" Done.")
 Q
