ONCPM ;Hines OIFO/GWB Performance Measures ;08/15/11
 ;;2.11;ONCOLOGY;**54**;Mar 07, 1995;Build 10
 ;
 N COC,ICDO,SITE,Z
 N D0,DA,DD,DI,DIC,DIE,DIEL,DINUM,DIR,DK,DL,DLAYGO,DM,DO,DOV,DP,DQ,DR
 K PCEITC
 ;Build PCEITC array of eligible topography codes
 S PCEITC("C18.0")="" ;Cecum
 S PCEITC("C18.1")="" ;Appendix
 S PCEITC("C18.2")="" ;Ascending
 S PCEITC("C18.3")="" ;Hepatic flexure
 S PCEITC("C18.4")="" ;Transverse
 S PCEITC("C18.5")="" ;Splenic flexure
 S PCEITC("C18.6")="" ;Descending
 S PCEITC("C18.7")="" ;Sigmoid
 S PCEITC("C18.8")="" ;Overlapping lesion
 S PCEITC("C18.9")="" ;Colon, NOS
 S PCEITC("C19.9")="" ;Rectosigmoid junction
 S PCEITC("C20.9")="" ;Rectum
 S PCEITC("C34.0")="" ;Main Bronchus
 S PCEITC("C34.1")="" ;Upper lobe lung
 S PCEITC("C34.2")="" ;Middle lobe lung
 S PCEITC("C34.3")="" ;Lower lobe lung
 S PCEITC("C34.8")="" ;Overlapping lesion of lung
 S PCEITC("C34.9")="" ;Lung, NOS
 S PCEITC("C50.0")="" ;Nipple
 S PCEITC("C50.1")="" ;Central portion breast
 S PCEITC("C50.2")="" ;Upper-inner quadrant breast
 S PCEITC("C50.3")="" ;Lower-inner quadrant breast
 S PCEITC("C50.4")="" ;Upper-outer quadrant breast
 S PCEITC("C50.5")="" ;Lower-outer quadrant breast
 S PCEITC("C50.6")="" ;Axillary tail breast
 S PCEITC("C50.8")="" ;Overlapping lesion breast
 S PCEITC("C50.9")="" ;Breast, NOS
 S PCEITC("C61.9")="" ;Prostate
 ;
 ;Check PRIMARY SITE  (165.5,2)
 ;      CLASS OF CASE (165.5,.04)
 ;      DATE DX       (165.5,3)
 S SITE=$P($G(^ONCO(165.5,ONCONUM,2)),U,1)
 S ICDO=0
 I SITE'="" S ICDO=$P(^ONCO(164,SITE,0),U,2)
 S COC=$E($$GET1^DIQ(165.5,ONCONUM,.04),1,2)
 I SITE="" W !!,?10,"There is no PRIMARY SITE for this primary." R Z:10 G EXIT
 I COC=""  W !!,?10,"There is no CLASS OF CASE for this primary." R Z:10 G EXIT
 I COC>22  W !!,?10,"CLASS OF CASE = ",COC," (non-anlytic)." R Z:10 G EXIT
 I DATEDX<3120000 W !!,?10,"DATE DX is before 2012." R Z:10 G EXIT
 I '$D(PCEITC(ICDO)) W !!,?10,"Performance Measures are not being recorded for this primary site" R Z:10 G EXIT
 I $E(ICDO,2,3)=34 D ^ONCPML G EXIT
 I ($E(ICDO,2,3)=18)!($E(ICDO,2,3)=19)!($E(ICDO,2,3)=20) D ^ONCPMC G EXIT
 I $E(ICDO,2,3)=50 D ^ONCPMB G EXIT
 I ICDO="C61.9" D ^ONCPMP G EXIT
 Q
 ;
EXIT ;Exit
 K PCEITC
 Q
 ;
CLEANUP ;Cleanup
 K DATEDX,ONCONUM
