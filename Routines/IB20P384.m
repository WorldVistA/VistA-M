IB20P384 ;ALB/BDB - IB*2.0*384 POST INIT: ADD REASON NOT BILLABLE ;08-NOV-2007
 ;;2.0;INTEGRATED BILLING;**384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*384 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 D SCREEN7 ; Recompile the Screen 7 input template
 D SCEIEDIT ; Edit SCEI's to be ECME selectable in Claims Tracking Non-Billable Reasons file(#356.8)
 D IBERRAD ; New IB328 'ROI form required for sensitive record' IB Error file (#350.8)
 ;populate new #350.9 field #11.02 and add one record with reject code=70 to the subfile #350.912 
 ;for NON-COVERED DRUGS functionality; add new non-billable reason "NON COVERED DRUG PER PLAN"
 D NONCOVDR
 D NEWR ; add new RNB to CT RNB file (#356.8)
 S IBA(1)="",IBA(2)="    IB*2*384 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
SCEIEDIT ; Edit SCEI's to be ECME selectable in Claims Tracking Non-Billable Reasons file(#356.8)
 N DD,DO,DLAYGO,DINUM,DIC,DIE,DA,DR,X,Y,IBA,IBFOUND,IBFOUND1,IBATFN,IBNUM,IBAT,IBFN,IBIEN
 S IBA(1)="",IBA(2)="      >> Editing Service Connected/Environmental Indicators to be ECME"
 S IBA(3)="      >> selectable in the Claims Tracking Non-Billable Reasons file (#356.8)"
 S IBFOUND1=""
 F IBNUM=1:1:8 S IBIEN=$O(^IBE(356.8,"B",$P("SC TREATMENT^AGENT ORANGE^IONIZING RADIATION^SOUTHWEST ASIA^MILITARY SEXUAL TRAUMA^HEAD/NECK CANCER^COMBAT VETERAN^PROJECT 112/SHAD",U,IBNUM),"")) D
 .S IBFOUND="" I +IBIEN S IBFOUND=$G(^IBE(356.8,IBIEN,0))
 .I IBFOUND="" S IBFOUND1=1 D MSG(" "),MSG("     *** ERROR: Entry "_$P("SC^AO^IR^SWA^MST^HNC^CV^SHAD",U,IBNUM)_" missing, could not edit") Q
 .S DR=".02////1;.03////0"
 .S DIE="^IBE(356.8,",DA=IBIEN D ^DIE K DIE,DA,DR,X,Y
 D:IBFOUND1="" MSG("         Done. Service Connected/Environmental Indicators edited")
 D:'(IBFOUND1="") MSG("     *** ERROR: One or more entries could not be edited")
SCEIQ D MES^XPDUTL(.IBA) K IBA
 Q
 ;
IBERRAD ; New IB328 'ROI form required for sensitive record' IB Error file (#350.8)
 N DD,DO,DINUM,DIC,DIE,DA,DR,X,Y,IBA,IBFOUND,IBATFN,IBAT,IBIEN
 S IBA(1)="      >> Adding IB328 'ROI form required for sensitive record'"
 S IBA(2)="      >> in the IB Error file (#350.8)"
 S IBAT="IB328",IBIEN=$G(^IBE(350.8,"AC",IBAT))
 S IBFOUND="" I +IBIEN S IBFOUND=$G(^IBE(350.8,IBIEN,0))
 I IBFOUND="IB328^ROI form required for sensitive record^IB328^1^3" D MSG("         Done. IB328 'ROI form required for sensitive record' already exists") G IBERRADQ
 I IBFOUND'="" D MSG(" "),MSG("     *** ERROR: Entry already exists, could not add") G IBERRADQ
 K DD,DO S DIC="^IBE(350.8,",DIC(0)="L",X=IBAT D FILE^DICN K DIC S IBIEN=+Y
 I Y<1 K X,Y D MSG(" "),MSG("     *** ERROR: New entry could not be added") G IBERRADQ
 S DR=".02////ROI form required for sensitive record;.03////IB328;.04////1;.05////3"
 S DIE="^IBE(350.8,",DA=+IBIEN D ^DIE K DIE,DA,DR,X,Y
 D MSG("         Done. IB328 'ROI form required for sensitive record'  added")
IBERRADQ D MES^XPDUTL(.IBA) K IBA
 Q
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
 ;
 ;populate fields for NON-COVERED DRUGS functionality
NONCOVDR ;
 I $P($G(^IBE(350.9,1,11)),U,2)>0 D  Q
  . D BMES^XPDUTL("      >>   Skipping: NON-COVERED DRUGS functionality has been already activated")
 N IBZZ,IBNREC
 D BMES^XPDUTL("      >> Populating new #350.9 fields for NON-COVERED DRUGS functionality")
 D BMES^XPDUTL("      >>   turning off the NON-COVERED DRUGS functionality by default")
 S IBZZ=$$FILLFLDS^IBNCPUT1(350.9,11.02,1,0)
 I IBZZ'>0 D BMES^XPDUTL("     *** ERROR: "_$P(IBZZ,U,3))
 I '$O(^IBE(350.9,1,12,"B","70",0)) D
 . D BMES^XPDUTL("      >>   adding '70 Product/Service Not Covered' as default reject code")
 . I $$INSITEM^IBNCPUT1(350.912,1,"70","","E")'>0 D BMES^XPDUTL("     *** ERROR: could not add")
 ;add a new non-billable reason "NON COVERED DRUG PER PLAN"
 ;to the file (#356.8) CLAIMS TRACKING NON-BILLABLE REASONS file
 I '$O(^IBE(356.8,"B","NON COVERED DRUG PER PLAN",0)) D
 . D BMES^XPDUTL("      >>   adding a new 'NON COVERED DRUG PER PLAN' non-billable reason to the file #356.8")
 . S IBNREC=$$INSITEM^IBNCPUT1(356.8,"","NON COVERED DRUG PER PLAN","","E") I IBZZ'>0 D BMES^XPDUTL("     *** ERROR: could not add") Q
 . D BMES^XPDUTL("      >>   setting the ECME FLAG to 'Yes'")
 . S IBZZ=$$FILLFLDS^IBNCPUT1(356.8,.02,+IBNREC,1) I IBZZ'>0 D BMES^XPDUTL("     *** ERROR: "_$P(IBZZ,U,3))
 . D BMES^XPDUTL("      >>   setting the ECME PAPER FLAG to 'No'")
 . S IBZZ=$$FILLFLDS^IBNCPUT1(356.8,.03,+IBNREC,0) I IBZZ'>0 D BMES^XPDUTL("     *** ERROR: "_$P(IBZZ,U,3))
 Q
 ;
SCREEN7 ;Recompile Screen 7 Input Template
 N DMAX,IBIEN,IBRTN,X,Y
 S DMAX=$$ROUSIZE^DILF
 D MES^XPDUTL("Recompiling Screen 7 input template ...")
 ;
 ;find the ien of the input template
 S IBIEN=$O(^DIE("B","IB SCREEN7",0)) Q:'IBIEN
 ;
 ;quit if input template not compiled
 S IBRTN=$P($G(^DIE(IBIEN,"ROUOLD")),U) Q:IBRTN=""
 ;
 D MES^XPDUTL("Compiling IB SCREEN7, compiled routine is "_IBRTN_" ...")
 S X=IBRTN,Y=IBIEN
 D EN^DIEZ
 D MES^XPDUTL("Completed compiling input template.")
 D MES^XPDUTL("")
 Q
 ;
NEWR ; Add new RNBs (if RNB already exists ensure Code is set)
 N IBI,IBJ,IBLN,IBNM,IBRNB,IBTOT,IBTNC,IBTCH,DIC,DR,DO,X,Y,DLAYGO,DINUM,IBA
 S (IBTOT,IBTNC,IBTCH)=0 S DLAYGO=356.8
 ;
 D MSG("    Add 1 New Reason Not Billable (#356.8)...")
 ;
 F IBI=1:1 S IBLN=$P($T(NEW+IBI),";;",2,999) Q:'IBLN  D
 . S IBNM=$P(IBLN,U,6) S IBRNB=$O(^IBE(356.8,"B",IBNM,0))
 . I IBRNB Q
 . ;
 . F IBJ=61:1 I '$D(^IBE(356.8,IBJ,0)),IBJ'=72,IBJ'=90 Q
 . ;
 . S IBTOT=IBTOT+1
 . ;
 . S DIC("DR")=".02////"_$P(IBLN,U,4)_";.03////"_$P(IBLN,U,5)
 . S DIC="^IBE(356.8,",DIC(0)="L",X=IBNM,DINUM=IBJ D FILE^DICN K DIC I 'Y D MSG(IBNM_" Not Added, ERROR ****") Q
 . S IBTCH=IBTCH+1 D MSG("    - "_IBNM_" added")
 ;
 I 'IBTCH D MSG("    No Change: "_IBTNC_" of "_IBTOT_" New RNBs Already Exist")
 I +IBTCH D MSG("    Updated: "_IBTCH_" of "_IBTOT_" New RNBs Added")
 ;
 D MES^XPDUTL(.IBA)
 ;
 Q
 ;
 ; RNB'S to add to CT RNB file
NEW ;;
 ;;61^NEW^CV15^1^0^NO PHARMACY COVERAGE
 ;;
 Q
