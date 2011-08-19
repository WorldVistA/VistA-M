DGYMPKG ;ALB/MLI - Clean-up MAS package names ; 3/28/95@1340
 ;;5.3;Registration;**56**;Aug 13, 1993
 ;
 ; This routine cleans up old entries in the package file for
 ; all MAS package file entries (DG, DPT, SD).  If there are
 ; multiple entries in the PACKAGE file which have the DG, SD,
 ; or DPT package namespace, the erroneous ones will be removed.
 ;
EN ; clean up package file
 S DIK="^DIC(9.4,",DGFL=0
 F DGNMSP="DG","SD","DPT" S DGI=0 F  S DGI=$O(^DIC(9.4,"C",DGNMSP,DGI)) Q:'DGI  D
 . S DGX=$G(^DIC(9.4,DGI,0))
 . I $P(DGX,"^",1)=$P($T(@DGNMSP),";;",2) Q  ; correct entry
 . S DA=DGI D ^DIK
 . W !,"...",$P(DGX,"^",1)," [",DGNMSP,"] entry deleted from PACKAGE file (IEN=",DA,")"
 . S DGFL=1
 W !!,"All set."  I 'DGFL W "..No problems found."
 K DA,DIK,DGI,DGFL,DGNMSP,DGX
 Q
 ;
 ; the following are the official names of the package file entries
 ;
DG ;;REGISTRATION
SD ;;SCHEDULING
DPT ;;PATIENT FILE
