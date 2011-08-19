ONCOPCE ;HINES OIFO/GWB PCE MAIN ROUTINE ;04/28/00
 ;;2.11;ONCOLOGY;**6,7,11,13,16,18,19,22,26,29**;Mar 07, 1995
 N D0,DA,DD,DIC,DIE,DINUM,DIR,DLAYGO,DO,DR,DP,DL,DQ,DM,DK,DI,DIEL,DOV
 G:'ONCOD0P EXIT S ONCONUM=+ONCOD0P N ONCOD0P
 G:'ONCOD0 EXIT S ONCOPA=ONCOD0 N ONCOD0
 K PCEITC
 S PCEITC("C16.0")="" ;Cardia, NOS
 S PCEITC("C16.1")="" ;Fundus of stomach
 S PCEITC("C16.2")="" ;Body of stomach
 S PCEITC("C16.3")="" ;Gastric antrum
 S PCEITC("C16.4")="" ;Pylorus
 S PCEITC("C16.5")="" ;Lesser curvature of stomach, NOS
 S PCEITC("C16.6")="" ;Greater curvature of stomach, NOS
 S PCEITC("C16.8")="" ;Overlapping lesion of stomach
 S PCEITC("C16.9")="" ;Stomach, NOS
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
 S PCEITC("C22.0")="" ;Liver
 S PCEITC("C34.0")="" ;Main Bronchus
 S PCEITC("C34.1")="" ;Upper lobe lung
 S PCEITC("C34.2")="" ;Middle lobe lung
 S PCEITC("C34.3")="" ;Lower lobe lung
 S PCEITC("C34.8")="" ;Overlapping lesion of lung
 S PCEITC("C34.9")="" ;Lung, NOS
 S PCEITC("C38.0")="" ;Heart
 S PCEITC("C38.1")="" ;Mediastinum, anterior
 S PCEITC("C38.2")="" ;Mediastinum, posterior
 S PCEITC("C38.3")="" ;Mediastinum, NOS
 S PCEITC("C38.4")="" ;Pleura, NOS
 S PCEITC("C38.8")="" ;Heart/Medias/Pleura, overlap
 S PCEITC("C44.0")="" ;Skin of lip, NOS
 S PCEITC("C44.2")="" ;External ear
 S PCEITC("C44.3")="" ;Skin of other and unspecified parts of face
 S PCEITC("C44.4")="" ;Skin of scalp and neck
 S PCEITC("C44.5")="" ;Skin of trunk
 S PCEITC("C44.6")="" ;Skin of upper limb and shoulder
 S PCEITC("C44.7")="" ;Skin of lower limb and hip
 S PCEITC("C44.8")="" ;Overlapping lesion
 S PCEITC("C44.9")="" ;Skin, NOS
 S PCEITC("C47.0")="" ;Nerves, head & neck
 S PCEITC("C47.1")="" ;Nerves, upper limb
 S PCEITC("C47.2")="" ;Nerves, lower limb
 S PCEITC("C47.3")="" ;Nerves, thorax
 S PCEITC("C47.4")="" ;Nerves, abdomen
 S PCEITC("C47.5")="" ;Nerves, pelvis
 S PCEITC("C47.6")="" ;Nerves, trunk
 S PCEITC("C47.8")="" ;Nerves, overlap
 S PCEITC("C47.9")="" ;Autonomic nervous system, NOS
 S PCEITC("C48.0")="" ;Retroperitoneum
 S PCEITC("C48.1")="" ;Peritoneum, specified
 S PCEITC("C48.2")="" ;Peritoneum, NOS
 S PCEITC("C48.8")="" ;Retroperitoneum overlap
 S PCEITC("C49.0")="" ;Soft tissues, head & neck
 S PCEITC("C49.1")="" ;Soft tissues, upper limb
 S PCEITC("C49.2")="" ;Soft tissues, lower limb
 S PCEITC("C49.3")="" ;Soft tissues, thorax
 S PCEITC("C49.4")="" ;Soft tissues, abdomen
 S PCEITC("C49.5")="" ;Soft tissues, pelvis
 S PCEITC("C49.6")="" ;Soft tissues, trunk
 S PCEITC("C49.8")="" ;Soft tissues overlap
 S PCEITC("C49.9")="" ;Soft tissues NOS
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
 S PCEITC("C67.0")="" ;Urinary Bladder
 S PCEITC("C67.1")="" ;Urinary Bladder
 S PCEITC("C67.2")="" ;Urinary Bladder
 S PCEITC("C67.3")="" ;Urinary Bladder
 S PCEITC("C67.4")="" ;Urinary Bladder
 S PCEITC("C67.5")="" ;Urinary Bladder
 S PCEITC("C67.6")="" ;Urinary Bladder
 S PCEITC("C67.7")="" ;Urinary Bladder
 S PCEITC("C67.8")="" ;Urinary Bladder
 S PCEITC("C67.9")="" ;Urinary Bladder
 S PCEITC("C68.0")="" ;Urinary Bladder (Urethra)
 S PCEITC("C70.0")="" ;Cerebral meninges
 S PCEITC("C70.1")="" ;Spinal meninges
 S PCEITC("C70.9")="" ;Meninges, NOS
 S PCEITC("C71.0")="" ;Cerebrum
 S PCEITC("C71.1")="" ;Fontal lobe
 S PCEITC("C71.2")="" ;Temporal lobe
 S PCEITC("C71.3")="" ;Parietal lobe
 S PCEITC("C71.4")="" ;Occipital lobe
 S PCEITC("C71.5")="" ;Ventricle, NOS
 S PCEITC("C71.6")="" ;Cerebellum, NOS
 S PCEITC("C71.7")="" ;Brain stem
 S PCEITC("C71.8")="" ;Overlapping lesion on brain
 S PCEITC("C71.9")="" ;Brain, NOS
 S PCEITC("C72.0")="" ;Spinal cord
 S PCEITC("C72.1")="" ;Cauda equina
 S PCEITC("C72.2")="" ;Olfactory nerve
 S PCEITC("C72.3")="" ;Optic nerve
 S PCEITC("C72.4")="" ;Acoustic nerve
 S PCEITC("C72.5")="" ;Cranial nerve
 S PCEITC("C72.8")="" ;Overlapping lesion of brain and cns
 S PCEITC("C72.9")="" ;Nervous system, NOS
 S PCEITC("C73.9")="" ;Thyroid gland
 S PCEITC("C75.1")="" ;Pituitary gland
 S PCEITC("C75.2")="" ;Craniopharyngeal duct
 S PCEITC("C75.3")="" ;Pineal gland
 S ICDO=0,NODE2=$G(^ONCO(165.5,ONCONUM,2)),ICDOTOP=$P(NODE2,U,1)
 S HIST=$$HIST^ONCFUNC(ONCONUM)
 ;
 ;Check if HISTOLOGY is relevant to NON-HODGKIN'S LYMPHOMA and if 
 ;ACCESSION YEAR = 1997
 S HIST1234=$E(HIST,1,4),BEH=$E(HIST,5)
 I ((HIST1234>9589)&(HIST1234<9596))!((HIST1234>9669)&(HIST1234<9718)),$P(^ONCO(165.5,ONCONUM,0),U,7)=1997 D ^ONCNPC0 G EXIT
 ;
 ;Check if HISTOLOGY is relevant to MELANOMA and if ACCESSION YEAR = 1999
 S HIST123=$E(HIST,1,3),BEH=$E(HIST,5)
 I ((HIST123>871)&(HIST123<880))!((HIST=90443)&($E(ICDOTOP,1,4)=6749)),$P(^ONCO(165.5,ONCONUM,0),U,7)=1999 D ^ONCMPC0 G EXIT
 ;
 ;Check for pediatric cases of rhabdomyosarcoma (Soft Tissue Sarcoma)
 S D0=ONCOPA D DOB1^ONCOES S X1=DT,X2=X D ^%DTC S AGE=X\365.25,D0=ONCONUM
 I AGE<21,((HIST=89003)!(HIST=89013)!(HIST=89023)!(HIST=89103)!(HIST=89203)) D ^ONCSPC0 G EXIT
 ;
 ;Check Primary Site
 I ICDOTOP'="" S ICDO=$P(^ONCO(164,ICDOTOP,0),U,2)
 I ICDO=0 G:ONCOANS'=5 EXIT W !!,?10,"There is no ICDO-TOPOGRAPHY for this primary." R Z:10 G EXIT
 I '$D(PCEITC(ICDO)) G:ONCOANS'=5 EXIT W !!,?10,"There is currently no PCE for this primary site",!,?10,"nor is it a 1997 Non-Hodgkin's Lymphoma or 1999",!,?10,"Melanoma." R Z:10 G EXIT
 I ($E(ICDO,2,3)=67)!($E(ICDO,2,3)=68) D ^ONCBPC0 G EXIT
 I ($E(ICDO,2,3)=38)!($E(ICDO,2,3)=47)!($E(ICDO,2,3)=48)!($E(ICDO,2,3)=49)!($E(ICDO,2,3)=44) D ^ONCSPC0 G EXIT
 I ICDO="C73.9" D ^ONCTPC0 G EXIT
 I ICDO="C61.9" D ^ONCP2P0 G EXIT
 I ($E(ICDO,2,3)=18)!($E(ICDO,2,3)=19)!($E(ICDO,2,3)=20) D ^ONCCPC0 G EXIT
 I $E(ICDO,2,3)=50 D ^ONCBRP0 G EXIT
 I ICDO="C22.0" D ^ONCHPC0 G EXIT
 I ($E(ICDO,2,3)=70)!($E(ICDO,2,3)=71)!($E(ICDO,2,3)=72)!(ICDO="C75.1")!(ICDO="C75.2")!(ICDO="C75.3") D ^ONCIPC0 G EXIT
 I $E(ICDO,2,3)=16 D ^ONCGPC0 G EXIT
 I $E(ICDO,2,3)=34 D ^ONCLPC0 G EXIT
 Q
EXIT K PCEITC,NODE2,ICDOTOP,ICDO,Z,X1,X2,AGE,HIST,HIST1234,HIST123,BEH
 Q
DATEIT ;Date input transform
 I X="00/00/00" W *7,!!?5,"'00/00/00' is ambiguous, enter a 4 digit year.",!! S ITFLAG="YES" K X Q
 I X="00/00/0000" S X="0000000" S ITFLAG="YES" Q
 I X="00000000" S X="0000000" S ITFLAG="YES" W "  00/00/0000" Q
 I X="88/88/88" W *7,!!?5,"'88/88/88' is ambiguous, enter a 4 digit year.",!! S ITFLAG="YES" K X Q
 I X="88/88/8888" S X=8888888 S ITFLAG="YES" Q
 I X="88888888" S X=8888888 S ITFLAG="YES" W "  88/88/8888" Q
 I X="99/99/99" W *7,!!?5,"'99/99/99' is ambiguous, enter a 4 digit year.",!! S ITFLAG="YES" K X Q
 I X="99/99/9999" S X=9999999 S ITFLAG="YES" Q
 I X="99999999" S X=9999999 S ITFLAG="YES" W "  99/99/9999" Q
 Q
DATEOT ;Date output transform in format MM/DD/YYYY
 Q:Y=""
 S Y=$S(Y="0000000":"00/00/0000",Y=9999999:"99/99/9999",Y=8888888:"88/88/8888",1:$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_($E(Y,1,3)+1700))
 Q
CHDTIT ;Date input transform for fields #1103 and #1105
 I X="00/00/00" W *7,!!?5,"'00/00/00' is ambiguous, enter a 4 digit year.",!! S ITFLAG="YES" K X Q
 I X="00/0000" S X="0000000" S ITFLAG="YES" Q
 I (X="00000000")!(X="00/00/0000") S X="0000000" S ITFLAG="YES" W "  00/0000" Q
 I X="99/99/99" W *7,!!?5,"'99/99/99' is ambiguous, enter a 4 digit year.",!! S ITFLAG="YES" K X Q
 I X="99/9999" S X=9999999 S ITFLAG="YES" Q
 I (X="99999999")!(X="99/99/9999") S X=9999999 S ITFLAG="YES" W "  99/9999" Q
 I X="88/88/88" W *7,!!?5,"'88/88/88' is ambiguous, enter a 4 digit year.",!! S ITFLAG="YES" K X Q
 I X="88/8888" S X="8888888" S ITFLAG="YES" Q
 I (X="88888888")!(X="88/88/8888") S X="8888888" S ITFLAG="YES" W "  88/8888" Q
 S %DT="EP",%DT(0)="-NOW" D ^%DT S X=Y I Y<1 K X W !!?5,"Future dates are not allowed.",! K %DT(0) Q
 Q
CHDTOT ;Date output transform for fields #1103 and #1105
 Q:Y=""
 I Y="0000000" S Y="00/0000" Q
 I Y=9999999 S Y="99/9999" Q
 I Y=8888888 S Y="88/8888" Q
 S Y=$E(Y,4,5)_"/"_($E(Y,1,3)+1700)
 Q
