IBY516PO ;LITS/TAZ - IB*2*516 POST-INSTALL ;4/1/14
 ;;2.0;INTEGRATED BILLING;**516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;Post Install Routine primary entry point
 N IBY,Y,QUIT,ROUT
 S QUIT=0
 F IBY="RIT","TMOPT" D  I QUIT Q
 . S ROUT=IBY_"^IBY516PO"
 . S Y=$$NEWCP^XPDUTL(IBY,ROUT)
 . I 'Y D BMES^XPDUTL("ERROR Creating "_IBY_" Checkpoint.") S QUIT=1 Q
 Q
 ;
TMOPT ; Delete scheduled TaskMan option
 ;
 NEW IBZ,T,FST,TMERR,OPTNM,DIFROM
 D MES^XPDUTL("Delete Scheduled TaskMan Option ...")
 ;
 I '$$PROD^XUPROD(1) D MES^XPDUTL("Not a production account. No further action taken.") G TMOPTX
 ;
 S OPTNM="IBCN INS BILL PROV FLAG RPT"     ; option name to be unscheduled
 D OPTSTAT^XUTMOPT(OPTNM,.IBZ)
 S ZTSK=$G(IBZ(1)) K IBZ
 I 'ZTSK D MES^XPDUTL("Option not scheduled. No further action taken.") G TMOPTX
 D DQ^%ZTLOAD
 I 'ZTSK(0) D MES^XPDUTL("Schedule not deleted.") G TMOPTX
 D MES^XPDUTL("Schedule deleted.")
 ;
TMOPTX ;
 Q
 ;
RIT ; recompile billing screen templates
 N X,Y,DMAX,IBN
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:8,"10","102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN),Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B"),DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL(" Done.")
 Q
