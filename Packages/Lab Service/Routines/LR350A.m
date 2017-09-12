LR350A ;DALOI/JMC - LR*5.2*350 KIDS ROUTINE CONT ;12/05/11  12:11
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
 ;
PRE ;
 ; KIDS Pre install for LR*5.2*350
 N X,DA,DIU,DIK,LRERR,LRFN,LRFLD,LRMSG
 D BMES("*** Pre install started ***")
 ; Delete SNOMED fields - (field is now not required)
 D BMES("Purging field #2 DD for file #61 and file #61.2")
 K DA,DIK
 S DA=2,DA(1)=61,DIK="^DD(61," D ^DIK K DA,DIK
 S DA=2,DA(1)=61.2,DIK="^DD(61.2," D ^DIK K DA,DIK
 ;
 ; Delete SNOMED CT fields #20-24 in files 61, 61.2, 62
 ;  if installed due to previous test build to insure clean install of these fields.
 F LRFN=61,61.2,62 D
 . F LRFLD=20:1:24 D
 . . I '$$VFIELD^DILFD(LRFN,LRFLD) Q
 . . N DA,DIK
 . . D BMES("Purging field #"_LRFLD_" DD for file #"_LRFN)
 . . S DA=LRFLD,DA(1)=LRFN,DIK="^DD("_LRFN_"," D ^DIK
 ;
 ; Purge NLT files
 D BMES("Purging DDs and data for files #64.061, #64.062, #95.4")
 K DA,DIU
 S DIU="^LAB(64.061,",DIU(0)="DS" D EN^DIU2 K DIU,DA
 S DIU="^LAB(64.062,",DIU(0)="DS" D EN^DIU2 K DIU,DA
 S DIU="^LAHM(95.4,",DIU(0)="DS" D EN^DIU2 K DIU,DA
 ;
 ; Purge Micro Audit subfile DD (leave data)
 D BMES("Deleting DD for Micro Audit subfile #63.539")
 K DA,DIU
 S DIU=63.539,DIU(0)="S" D EN^DIU2 K DIU,DA
 ;
 ; Delete "AB" xref on COLLECTION SAMPLE field (60.03,.01)
 K LRERR,LRMSG
 D BMES("Deleting ""AB"" cross reference on COLLECTION SAMPLE field (#60.03,.01)")
 D DELIX^DDMOD(60.03,.01,2,"K","LRMSG","LRERR")
 I $G(LRERR("DIERR",1))=202  D BMES("""AB"" cross reference previously removed")
 ;
 ;
 ; Delete "AE" xref on CANCELED BY field (69.03,10)
 K LRERR,LRMSG
 D BMES("Deleting ""AE"" cross reference on CANCELED BY field (#69.03,10)")
 D DELIX^DDMOD(69.03,10,1,"","LRMSG","LRERR")
 I $G(LRERR("DIERR",1))=202  D BMES("""AE"" cross reference previously removed")
 ;
 D BMES("*** Pre install completed ***")
 Q
 ;
 ;
POST ; KIDS Post install for LR*5.2*350
 N LRX,LRI,LRMSG,STR,X
 ;
 ;ZEXCEPT:  XPDNM
 ;
 D BMES("*** Post install started ***")
 D BMES("*** Configuring mail group 'LAB MAPPING' ***")
 D LABMAP
 S STR="Patch LR*5.2*350 - add local members to mail group 'LAB MAPPING'"
 D ALERT(STR)
 ;
 D BMES("Re-Indexing ""B"" cross-reference of file #61")
 D RINDXB61
 D BMES("Re-Indexing completed")
 ;
 ;D MICHECK1
 D MICHECK2
 D LRWU9
 ;
 D BMES("*** Post install completed ***")
 D BMES("Sending install completion alert to mail group G.LMI")
 S STR="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 D ALERT(STR)
 Q
 ;
 ;
ALERT(MSG,RECIPS) ;
 D ALERT^LR350(MSG,.RECIPS)
 Q
 ;
 ;
BMES(STR) ;
 D BMES^LR350(STR)
 Q
 ;
 ;
MES(STR,CJ,LM) ;
 D MES^LR350(STR,$G(CJ),$G(LM))
 Q
 ;
 ;
LABMAP ;
 ;
 N DIERR,LRIEN,LRFDA,LRMSG
 S LRIEN=$O(^XMB(3.8,"B","LAB MAPPING",0))
 I LRIEN<1 Q
 ; Set access levels
 S LRIEN=LRIEN_","
 S LRFDA(1,3.8,LRIEN,4)="PU" ; type
 S LRFDA(1,3.8,LRIEN,7)="n" ; self enroll
 D FILE^DIE("","LRFDA(1)","LRMSG")
 Q
 ;
 ;
MICHECK1 ; Task routine LR350M to check for bad nodes in MI subscript.
 ;
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D BMES("*** Tasking post-install check of MI subscript in LAB DATA file ***")
 S ZTRTN="EN^LR350M",ZTDTH=$H,ZTIO=""
 S ZTDESC="Check file #63 MI subscript (post-LR*5.2*350)"
 D ^%ZTLOAD
 I $G(ZTSK)>0 D BMES("*** Task #"_ZTSK_" created ***")
 I $G(ZTSK)<1 D
 . D BMES("*** Tasking FAILED ***")
 . D BMES("***   with error "_$G(%ZTLOAD("ERROR"))_" ***")
 ;
 Q
 ;
 ;
MICHECK2 ; Task routine LRUW8 to check for bad antibiotic field definition in MI subscript.
 ;
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D BMES("*** Tasking post-install check of MI Antibiotic Field Definitions in LAB DATA file ***")
 S ZTRTN="KIDS^LRWU8",ZTDTH=$H,ZTIO=""
 S ZTDESC="Check file #63 MI Antibiotic Field Definitions (post-LR*5.2*350)"
 D ^%ZTLOAD
 I $G(ZTSK)>0 D BMES("*** Task #"_ZTSK_" created ***")
 I $G(ZTSK)<1 D
 . D BMES("*** Tasking FAILED ***")
 . D BMES("***   with error "_$G(%ZTLOAD("ERROR"))_" ***")
 ;
 Q
LRWU9 ;Task LRWU9 to check for bad Chemistry test names
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;
 S ZTDESC="*** Tasking post-install check of bad test names"
 D BMES^XPDUTL($$CJ^XLFSTR(ZTDESC,80))
 ;
 S ZTRTN="KIDS^LRWU9",ZTDTH=$H,ZTIO=""
 S ZTDESC="Check file #63 for bad test Chemistry names."
 D ^%ZTLOAD
 ;
 I $G(ZTSK)<1 D
 . S ZTDESC="*** Tasking FAILED ***"
 . D BMES^XPDUTL($$CJ^XLFSTR(ZTDESC,80))
 . S ZTDESC="***   with error "_$G(%ZTLOAD("ERROR"))_" ***"
 . D BMES^XPDUTL($$CJ^XLFSTR(ZTDESC,80))
 ;
 Q
 ;
 ;
RINDXB61 ; Re-index "B" cross-reference of File #61 (as it changed from 30 to 80 chars)
 ;
 N DA,DIK,LRFMERTS
 ;
 S LRFMERTS=1
 K ^LAB(61,"B")
 S DIK="^LAB(61,"
 S DIK(1)=".01^B"
 D ENALL^DIK
 K DIK
 S DIK="^LAB(61,"
 S DIK(1)="6^B"
 D ENALL^DIK
 ;
 Q
