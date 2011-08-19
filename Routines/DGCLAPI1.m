DGCLAPI1 ;ALB/TMK - Utilities for OEF/OIF/UNKNOWN OEF/OIF conflict loc; 10/20/05
 ;;5.3;Registration;**673**;Aug 13, 1993
 Q
 ;
OEIFUPD(DGDFN,DGOEIF) ;
 ;Entry point for OEF, OIF, UNKNOWN OEF/OIF conflict data
 ; updates via the ZMH HL7 message upload.
 ;
 ;  Input:
 ;    DGDFN  - PATIENT file (#2) IEN
 ;    DGOEIF  - update values array passed by reference
 ;      DGOEIF("COUNT") - count of the # of entries
 ;      DGOEIF("LOC") - Conflict Location Indicator
 ;      DGOEIF("FR") - OEF/OIF/UNKNOWN OEF/OIF Date From
 ;      DGOEIF("TO") - OEF/OIF/UNKNOWN OEF/OIF Date To
 ;      DGOEIF("SITE") - Source of data (ptr to file 4 or null for CEV)
 ;
 ;  Output:
 ;    Function result 1-success, 0-failure
 ;
 N DA,DIC,DIK,DGRSLT,DGX,DGX1,DGARY,DGCHG,X,Y,DO,DD
 ;
 S DGCHG=0,DGRSLT=1,DGDFN=+$G(DGDFN)
 I DGDFN>0,$D(^DPT(DGDFN)),$$CHANGE(DGDFN,.DGOEIF) S DGCHG=1
 ; If changes found, delete the existing data, add new records
 I DGCHG D
 . S DGRSLT=0
 . S DA=0 F  S DA=$O(^DPT(DGDFN,.3215,DA)) Q:'DA  S DA(1)=DGDFN,DIK="^DPT("_DA(1)_",.3215," D ^DIK
 . F DGX="LOC","FR","TO","LOCK","SITE" S DGX1=0 F  S DGX1=$O(DGOEIF(DGX,DGX1)) Q:'DGX1  S DGARY(DGX1,DGX)=DGOEIF(DGX,DGX1)
 . S DGX=0 F  S DGX=$O(DGARY(DGX)) Q:'DGX  D  Q:'DGRSLT
 .. ; Add a new entry
 .. S DIC(0)="L",DIC("DR")=".02////"_$G(DGARY(DGX,"FR"))_";.03////"_$G(DGARY(DGX,"TO"))_";.04////1"_$S($G(DGARY(DGX,"SITE"))'="":";.06////"_DGARY(DGX,"SITE"),1:"")
 .. S DA(1)=DGDFN,DIC="^DPT("_DA(1)_",.3215,"
 .. S X=$G(DGARY(DGX,"LOC")),X=$S(X="OIF":1,X="OEF":2,X="UNK":3,1:"") I X D FILE^DICN K DIC S DGRSLT=(Y>0)
 Q DGRSLT
 ;
CHANGE(DGDFN,DGOEIF) ;Did the data change?
 ;  Input
 ;      DGDFN    - Patients DFN
 ;      DGOEIF("COUNT") - the count of the # of entries in the multiple
 ;      DGOEIF("LOC",n)=Conflict Location Indicator
 ;      DGOEIF("FR",n)=OEF/OIF/UNKNOWN OEF/OIF Date From
 ;      DGOEIF("TO",n)=OEF/OIF/UNKNOWN OEF/OIF Date To
 ;      DGOEIF("LOCK")=Lock flag for HEC data
 ;      DGOEIF("site",n)=Source of data if a site or null if CEV
 ;
 ;  Output
 ;      Returns 0 if no status change
 ;              1 if status changed
 ;
 N DGCHG,DGOEIFO,DGX,DGX1,Z
 ;
 I +$G(DGDFN)'>0 Q 0
 S DGOEIF("COUNT")=$G(DGOEIF("COUNT"))
 S DGCHG=0
 I 'DGOEIF("COUNT"),'$O(^DPT(DGDFN,.3215,0)) S DGCHG=0 G CHNGQ
 S Z=+$$GET^DGENOEIF(DGDFN,.DGOEIFO,0)
 I DGOEIF("COUNT")'=Z S DGCHG=1 G CHNGQ
 S Z=0 F  S Z=$O(DGOEIFO("LOC",Z)) Q:'Z  S DGOEIFO("LOC",Z)=$E($$EXTERNAL^DILFD(2.3215,.01,,+DGOEIFO("LOC",Z)),1,3)
 S DGX="" F  S DGX=$O(DGOEIF(DGX)) Q:DGX=""!DGCHG  D  Q:DGCHG
 . S DGX1=0 F  S DGX1=$O(DGOEIF(DGX,DGX1)) Q:'DGX1  D  Q:DGCHG
 .. I DGX="SITE",$S($G(DGOEIF("SITE",DGX1))="":$G(DGOEIFO("SITE",DGX1))="CEV",1:0) Q
 .. I DGX="LOCK",$G(DGOEIFO("LOCK",DGX1))=1 Q
 .. I $G(DGOEIFO(DGX,DGX1))'=$G(DGOEIF(DGX,DGX1)) S DGCHG=1 Q
CHNGQ Q DGCHG
 ;
