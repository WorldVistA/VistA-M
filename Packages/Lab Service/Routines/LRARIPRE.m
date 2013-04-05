LRARIPRE ;DALISC/CKA - LRAR PRE INIT DELETE ARCHIVED FILES
 ;;5.2;LAB SERVICE;**59**;August 9, 1995
EN ;
 W !!,">>> Deleting OLD 'LAB' ARCHIVE FILES.",!
AWD W !!,"DELETING ARCHIVED WKLD DATA FILE."
 S DIU="^LRO(64.19999,",DIU(0)="D" D EN^DIU2
ALM W !!,"DELETING ARCHIVED LAB MONTHLY WORKLOADS FILE."
 S DIU="^LRO(67.99999,",DIU(0)="D" D EN^DIU2
ABI W !!,"DELETING ARCHIVED BLOOD INVENTORY FILE."
 S DIU="^LRD(65.9999,",DIU(0)="D" D EN^DIU2
 K DIU
 W !!,"The data dictionaries for these files will be reinstalled during the inits."
 Q
BXREF ;Kills B xref on PATIENT XMATCH field (#65.01)
 ;This xref is in the DD's but not the file.
 Q:'$D(^DD(65.01,0,"IX","B",65.01,.01))  ;already deleted
 S LRARI=0 F  S LRARI=$O(^DD(65.01,.01,1,LRARI)) Q:'LRARI  D
 . K:$G(^DD(65.01,.01,1,LRARI,0))="65.01^B" ^DD(65.01,.01,1,LRARI)
 K ^DD(65.01,0,"IX","B",65.01,.01)
 K:'$O(^DD(65.01,.01,1,0)) ^DD(65.01,"IX",.01) ;no xrefs left on field
 Q
