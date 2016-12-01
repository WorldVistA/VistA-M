IBY517PR ;FA/ALB - Pre-Install for IB patch 517 ;01-Jan-2015
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Standard Entry Point
 D CLEAR,DDFIX
 Q
 ;
CLEAR ; Clear indices for 365* descriptions prior to installing new set and kills
 N DIK,IX
 F IX=365.013,365.015,365.016,365.021,365.022,365.025 D
 . S DIK="^IBE("_IX_","
 . S DIK(1)=".02^C"
 . D ENALL2^DIK
 ; clear out file 356.023 - values have changed
 S DIK="^IBT(356.023,",DA=0
 F  S DA=$O(^IBT(356.023,DA)) Q:DA'=+DA  D ^DIK
 Q
 ;
DDFIX ; removed prior Mumps index definitions before installing patch with New Standard indexes
 N I,FILE
 F I=1:1:22 D
 . I I<10 S FILE="356.00"_I
 . I I=10!(I=20) S FILE="356.0"_$E(I)
 . I I>10,I'=20 S FILE="356.0"_I
 . D DELIX^DDMOD(FILE,.02,1,"K")
 . Q
 Q
