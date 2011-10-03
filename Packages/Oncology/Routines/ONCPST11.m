ONCPST11 ;HIRMFO/GWB - Post-init for Patch ONC*2.11*11;5/21/97
 ;;2.11;ONCOLOGY;**11**; Mar 07, 1995
 ;Restage RECTUM/ANUS/CANAL OVERLAP (C21.0)
 ;        CERVIX, ENDOCERVIX        (C53.0)
 ;        SINUS, ACCESSORY OVERLAP  (C31.8)
 ;DATE DX (#165.5, #3) must be > 12/31/91.
 W !,"Restaging primaries with an ICD0-TOPOGRAPHY of C21.0, C53.0 or C31.8 and a"
 W !,"DATE DX > 12/31/91.",!
 S IEN=0 F  S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D 
 .S DATEDX=$P($G(^ONCO(165.5,IEN,0)),U,16) Q:DATEDX<2920101
 .S TOPIEN=$P($G(^ONCO(165.5,IEN,2)),U,1) Q:TOPIEN=""
 .S TOPCOD=$P($G(^ONCO(164,TOPIEN,0)),U,2)
 .I (TOPCOD="C21.8")!(TOPCOD="C31.8")!(TOPCOD="C53.0") D
 ..S SITE=$$GET1^DIQ(165.5,IEN,.01)
 ..S PT=$$GET1^DIQ(165.5,IEN,.02)
 ..W !,"Restaging ",SITE," primary for patient ",PT," ..."
 ..S (DA,D0)=IEN
 ..S STGIND="C" D ES^ONCOTN
 ..S STGIND="P" D ES^ONCOTN
 ..W "******************************************************************"
 K IEN,DATEDX,TOPIEN,TOPCOD,SITE,PT Q
