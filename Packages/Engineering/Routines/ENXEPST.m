ENXEPST ;(Wash IRMFO)/DH-Post Init for Consolidation Patch ;9.25.95
 ;;7.0;ENGINEERING;**21**;August 17, 1993
POST ;
 I $D(^ENG(6914,"OEE")) G END ; already done
 W !,"Re-indexing Equipment File by bar code labels"
 ;S DIK="^ENG(6914,",DIK(1)=".01^EE"
 ;K ^ENG(6914,"EE") D ENALL^DIK
 S DIK="^ENG(6914,",DIK(1)="28.1^OEE"
 K ^ENG(6914,"OEE") D ENALL^DIK
 K DIK
END ;
 W !,"Post-init complete. Patch fully installed."
 Q
 ;ENXEPST
