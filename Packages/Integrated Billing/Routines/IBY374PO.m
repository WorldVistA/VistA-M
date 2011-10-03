IBY374PO ;PRXM/CMW - Post install routine for patch 374 ; 10 May 2007  9:41 AM
 ;;2.0;INTEGRATED BILLING;**374**;21-MAR-94;Build 16
 ;
 ; Call at tags only
 Q
 ; This routine will clean up entries in the file with NPIs delete status (2)
 ;
EN ; Post Install Routine primary entry point
 ;
 D DEL
 D CLEAN
 Q
 ;
DEL ; Look for NPI with delete status of "2"
 N IBIEN,STA,DA,IBOLDNPI
 S IBIEN=0
 F  S IBIEN=$O(^IBA(355.93,IBIEN)) Q:'IBIEN  D
 . S DA="A"
 . ; Loop through deleted NPIs (Status "2")
 . S STA=2
 . F  S DA=$O(^IBA(355.93,IBIEN,"NPISTATUS","NPISTATUS",STA,DA),-1) Q:'DA  D
 . . S IBOLDNPI=$P(^IBA(355.93,IBIEN,"NPISTATUS",DA,0),U,3)
 . . D COMP
 Q
 ;
COMP ;COMPLETELY DELETE THE NPI
 ;If NPI has status of "2" remove all entries related to this NPI.
 N OIEN
 S OIEN="A"
 F  S OIEN=$O(^IBA(355.93,IBIEN,"NPISTATUS","C",IBOLDNPI,OIEN),-1) Q:'OIEN  D
 . NEW DIE,DIK,DIC,DA,DR,D,D0,DI,DIC,DQ,X
 . NEW DP,DM,DK,DL,DIEL
 . S DA(1)=IBIEN,DIK="^IBA(355.93,"_DA(1)_",""NPISTATUS"",",DA=OIEN
 . D ^DIK
 . ; kill 41.01 references
 . K ^IBA(355.93,"NPI",IBOLDNPI,DA),^IBA(355.93,"NPIHISTORY",IBOLDNPI,DA)
 Q
 ;
CLEAN ; Clean up ^IBA(355.93,IEN,"NPISTATUS",0) if there are no multiples in the sub-file.
 N IBIEN
 S IBIEN=0
 F  S IBIEN=$O(^IBA(355.93,IBIEN)) Q:'IBIEN  D
 . Q:$G(^IBA(355.93,IBIEN,"NPISTATUS",0))=""
 . I +$P($G(^IBA(355.93,IBIEN,"NPISTATUS",0)),U,4)=0 D
 . . K ^IBA(355.93,IBIEN,"NPISTATUS",0)
 Q
