LA7VHLU5 ;DALOI/JMC - HL7 segment builder utility ;10/09/09  10:25
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68,74**;Sep 27, 1994;Build 229
 ;
 ;
DEFCODE(LRSS,LRSB,LA7CODE,LA761) ; Determine default codes when data is not mapped
 ;
 ; Call with  LRSS = file #63 subscript
 ;            LRSB = file #63 dataname/location
 ;         LA7CODE = current codes stored with data (order nlt!result nlt!loinc code!method suffix)
 ;           LA761 = specimen, pointer to file #61
 ;
 N I,LA760,LA7DFCDE,LA7MISS,LA7NLT,LA7X,LA7Y
 ;
 I LA7CODE="" S LA7CODE="!!!"
 ;
 ; Replace any missing codes with defaults
 ; If no missing codes then return codes passed in.
 S LA7MISS=""
 F I=1:1:3 I $P(LA7CODE,"!",I)="" S $P(LA7MISS,"^",I)=I
 ;
 I LA7MISS'="" D
 . I LRSS="CH" D CHSUB Q
 . I LRSS="MI" D MISUB Q
 . I LRSS="SP" D SPSUB Q
 . I LRSS="CY" D CYSUB Q
 . I LRSS="EM" D EMSUB Q
 ;
 Q LA7CODE
 ;
 ;
CHSUB ; Determine codes for CH subscript.
 ;
 ; Find a file #60 test which uses this dataname. Since there can be
 ; multiple tests check each until an order and result NLT code is found.
 S LA760=0
 F  S LA760=$O(^LAB(60,"C",LRSS_";"_LRSB_";1",LA760)) Q:'LA760  D
 . ; Default order NLT
 . I $P(LA7MISS,"^") D
 . . S LA7X=$$NLT^LRVER1(LA760)
 . . I LA7X'="" S $P(LA7CODE,"!")=LA7X,$P(LA7MISS,"^")=""
 . ; Default result NLT
 . I $P(LA7MISS,"^",2) D
 . . S LA7X=+$P($G(^LAB(60,LA760,64)),"^",2),LA7Y=""
 . . I LA7X S LA7Y=$$GET1^DIQ(64,LA7X_",",1)
 . . I LA7Y'="" S $P(LA7CODE,"!",2)=LA7Y,$P(LA7MISS,"^",2)=""
 ;
 ; If no result NLT code then use order NLT as default
 I $P(LA7CODE,"!",2)="" S $P(LA7CODE,"!",2)=$P(LA7CODE,"!")
 ;
 ; If no order NLT code found on file #60 entries then use this default
 I $P(LA7CODE,"!")="" S $P(LA7CODE,"!")="81323.0000"
 ;
 ; Default result LOINC code based on result NLT code
 ; If none on NLT result code then try order NLT code
 I $P(LA7MISS,"^",3) D
 . S LA7NLT=$P(LA7CODE,"!",2),LA7X=""
 . I LA7NLT'="" S LA7X=$$LNC^LRVER1(LA7NLT,$P(LA7CODE,"!",4),LA761)
 . I LA7X S $P(LA7CODE,"!",3)=LA7X Q
 . S LA7NLT=$P(LA7CODE,"!"),LA7X=""
 . I LA7NLT'="" S LA7X=$$LNC^LRVER1(LA7NLT,$P(LA7CODE,"!",4),LA761)
 . I LA7X S $P(LA7CODE,"!",3)=LA7X
 ;
 Q
 ;
 ;
MISUB ; Determine codes for MI subscript
 ;
 ; Bacteriology report
 I LRSB=11 S LA7DFCDE="87993.0000^93928.0000^" D DEFAULT Q
 ;
 ; Urine Screen
 I LRSB=11.57 S LA7DFCDE="87993.0000^93948.0000^630" D DEFAULT Q
 ;
 ; Sputum screen
 I LRSB=11.58 S LA7DFCDE="87993.0000^93949.0000^6460" D DEFAULT Q
 ;
 ; Gram stain
 I LRSB=11.6 S LA7DFCDE="87993.0000^87754.0000^664" D DEFAULT Q
 ;
 ; Bacteriology organism
 I LRSB=12 S LA7DFCDE="87993.0000^87570.0000^11475" D DEFAULT Q
 ;
 ; Bacteria colony count
 I +LRSB=12,$P(LRSB,",",2)=1 S LA7DFCDE="^87719.0000^564" D DEFAULT Q
 ;
 ; Bacteriology smear/prep
 I LRSB=11.7 S LA7DFCDE="87993.0000^93967.0000^" D DEFAULT Q
 ;
 ; Bacteriology test
 I LRSB=1.5 S LA7DFCDE="87993.0000^93969.0000^" D DEFAULT Q
 ;
 ; Parasite report
 I LRSB=14 S LA7DFCDE="87925.0000^93929.0000^" D DEFAULT Q
 ;
 ; Parasite organism
 I LRSB=16 S LA7DFCDE="87925.0000^87576.0000^20932" D DEFAULT Q
 ;
 ; Parasite organism stage
 I +LRSB=16,$P(LRSB,",",2)=.01 S LA7DFCDE="87925.0000^92930.0000^" D DEFAULT Q
 ;
 ; Parasite organism stage quantity
 I +LRSB=16,$P(LRSB,",",2)=1 S LA7DFCDE="87925.0000^93997.0000^" D DEFAULT Q
 ;
 ; Parasitology smear/prep
 I LRSB=15.51 S LA7DFCDE="87925.0000^93971.0000^" D DEFAULT Q
 ;
 ; Parasitology test
 I LRSB=16.4 S LA7DFCDE="87925.0000^93972.0000^" D DEFAULT Q
 ;
 ; Mycology report
 I LRSB=18 S LA7DFCDE="87994.0000^93930.0000^" D DEFAULT Q
 ;
 ; Mycology smear/prep
 I LRSB=19.6 S LA7DFCDE="87994.0000^93984.0000^" D DEFAULT Q
 ;
 ; Mycology test
 I LRSB=20.4 S LA7DFCDE="87994.0000^93974.0000^" D DEFAULT Q
 ;
 ; Fungal organism
 I LRSB=20 S LA7DFCDE="87994.0000^87578.0000^580" D DEFAULT Q
 ;
 ; Fungal colony count
 I +LRSB=20,$P(LRSB,",",2)=1 S LA7DFCDE="87994.0000^87723.0000^19101" D DEFAULT Q
 ;
 ; Mycobacterium report
 I LRSB=22 S LA7DFCDE="87995.0000^93931.0000^" D DEFAULT Q
 ;
 ; Acid Fast stain
 I LRSB=24 S LA7DFCDE="87995.0000^87756.0000^11545" D DEFAULT Q
 ;
 ; Acid Fast stain quantity
 I LRSB=25 S LA7DFCDE="87995.0000^87583.0000^" D DEFAULT Q
 ;
 ; Mycobacterium organism
 I +LRSB=26,'$P(LRSB,",",2) S LA7DFCDE="87995.0000^87589.0000^543" D DEFAULT Q
 ;
 ; Mycobacterium colony count
 I +LRSB=26,$P(LRSB,",",2)=1 S LA7DFCDE="87995.0000^87719.0000^564" D DEFAULT Q
 ;
 ; Bact or TB organism's susceptibilities
 I ($P(LRSB,",")=12!($P(LRSB,",")=26)),$P(LRSB,",",2)>2,$P(LRSB,",",2)<2.999 D  Q
 . S LA7X=""
 . I $P(LRSB,",")=12 D
 . . S LA7DFCDE="87565.0000^^"
 . . S LA7X=$O(^LAB(62.06,"AD",$P(LRSB,",",2),0))
 . I $P(LRSB,",")=26 D
 . . S LA7DFCDE="87568.0000^^"
 . . S LA7X=$O(^LAB(62.06,"AD1",$P(LRSB,",",2),0))
 . I LA7X D
 . . S X=$$GET1^DIQ(62.06,LA7X_",","64:1")
 . . I X S $P(LA7DFCDE,"^",2)=X
 . D DEFAULT
 ;
 ; TB test
 I LRSB=26.4 S LA7DFCDE="87995.0000^93977.0000^" D DEFAULT Q
 ;
 ; Virology report
 I LRSB=33 S LA7DFCDE="87996.0000^93932.0000^" D DEFAULT Q
 ;
 ; Viral agent
 I $P(LRSB,",")=36 S LA7DFCDE="87996.0000^87590.0000^6584" D DEFAULT Q
 ;
 ; Virology test
 I LRSB=36.4 S LA7DFCDE="87996.0000^93981.0000^" D DEFAULT Q
 ;
 ; Sterility results
 I LRSB=11.52 S LA7DFCDE="93982.0000^93982.0000^" D DEFAULT Q
 ;
 Q
 ;
 ;
SPSUB ; Determine codes for SP subscript
 ;
 ; specimens
 I $P(LRSB,",")=.012 S LA7DFCDE="88515.0000^88539.0000^22633" D DEFAULT Q
 I LRSB=10 S LA7DFCDE="88515.0000^88539.0000^22633" D DEFAULT Q
 ;
 ; brief clinical history
 I LRSB=.013 S LA7DFCDE="88515.0000^88542.0000^22636" D DEFAULT Q
 ;
 ; preoperative diagnosis
 I LRSB=.014 S LA7DFCDE="88515.0000^88544.0000^10219" D DEFAULT Q
 ;
 ; operative findings
 I LRSB=.015 S LA7DFCDE="88515.0000^88546.0000^10215" D DEFAULT Q
 ;
 ; postoperative diagnosis
 I LRSB=.016 S LA7DFCDE="88515.0000^88547.0000^10218" D DEFAULT Q
 ;
 ; gross description
 I LRSB=1 S LA7DFCDE="88515.0000^88549.0000^22634" D DEFAULT Q
 ;
 ; microscopic description
 I LRSB=1.1 S LA7DFCDE="88515.0000^88563.0000^22635" D DEFAULT Q
 ;
 ; frozen section
 I LRSB=1.3 S LA7DFCDE="88515.0000^88569.0000^22635" D DEFAULT Q
 ;
 ; surgical path diagnosis
 I LRSB=1.4 S LA7DFCDE="88515.0000^88571.0000^22637" D DEFAULT Q
 ;
 ; supplementary report
 I LRSB=1.2!(LRSB="10,5") S LA7DFCDE="88589.0000^88589.0000^22639" D DEFAULT Q
 ;
 ; specimen weight
 I LRSB="10,2" S LA7DFCDE="88515.0000^81233.0000^3154" D DEFAULT Q
 ;
 Q
 ;
 ;
CYSUB ;  Determine codes for CY subscript
 ;
 ; specimens
 I $P(LRSB,",")=.012 S LA7DFCDE="88593.0000^88539.0000^22633" D DEFAULT Q
 I LRSB=10 S LA7DFCDE="88593.0000^88539.0000^22633" D DEFAULT Q
 ;
 ; brief clinical history
 I LRSB=.013 S LA7DFCDE="88593.0000^88542.0000^22636" D DEFAULT Q
 ;
 ; preoperative diagnosis
 I LRSB=.014 S LA7DFCDE="88593.0000^88544.0000^10219" D DEFAULT Q
 ;
 ; operative findings
 I LRSB=.015 S LA7DFCDE="88593.0000^88542.0000^10215" D DEFAULT Q
 ;
 ; postoperative diagnosis
 I LRSB=.016 S LA7DFCDE="88593.0000^88547.0000^10218" D DEFAULT Q
 ;
 ; gross description
 I LRSB=1!(LRSB=20) S LA7DFCDE="88593.0000^88549.0000^22634" D DEFAULT Q
 ;
 ; microscopic examination
 I LRSB=1.1 S LA7DFCDE="88593.0000^88563.0000^22635" D DEFAULT Q
 ;
 ; supplementary report
 I LRSB=1.2 S LA7DFCDE="88589.0000^88589.0000^22639" D DEFAULT Q
 ;
 ; cytopathology diagnosis
 I LRSB=1.4 S LA7DFCDE="88593.0000^88571.0000^22637" D DEFAULT Q
 ;
 Q
 ;
 ;
EMSUB ;  Determine codes for EM subscript
 ;
 ; specimens
 I $P(LRSB,",")=.012 S LA7DFCDE="88597.0000^88057.0000^22633" D DEFAULT Q
 I LRSB=10 S LA7DFCDE="88597.0000^88057.0000^22633" D DEFAULT Q
 ;
 ; brief clinical history
 I LRSB=.013 S LA7DFCDE="88597.0000^88542.0000^22636" D DEFAULT Q
 ;
 ; preoperative diagnosis
 I LRSB=.014 S LA7DFCDE="88597.0000^88544.0000^10219" D DEFAULT Q
 ;
 ; operative findings
 I LRSB=.015 S LA7DFCDE="88597.0000^88542.0000^10215" D DEFAULT Q
 ;
 ; postoperative diagnosis
 I LRSB=.016 S LA7DFCDE="88597.0000^88547.0000^10218" D DEFAULT Q
 ;
 ; gross description
 I LRSB=1!(LRSB=20) S LA7DFCDE="88597.0000^88549.0000^22634" D DEFAULT Q
 ;
 ; microscopic examination
 I LRSB=1.1 S LA7DFCDE="88597.0000^88563.0000^22635" D DEFAULT Q
 ;
 ; supplementary report
 I LRSB=1.2 S LA7DFCDE="88589.0000^88589.0000^22639" D DEFAULT Q
 ;
 ; em diagnosis
 I LRSB=1.4 S LA7DFCDE="88597.0000^88571.0000^22637" D DEFAULT Q
 ;
 Q
 ;
 ;
DEFAULT ; Resolve codes and set defaults as needed
 ;
 ; Expects LA7DFCDE=default order NLT^default result NLT^default LOINC code
 ;
 I $P(LA7MISS,"^") S $P(LA7CODE,"!")=$P(LA7DFCDE,"^")
 I $P(LA7MISS,"^",2) S $P(LA7CODE,"!",2)=$P(LA7DFCDE,"^",2)
 I $P(LA7MISS,"^",3) D
 . S $P(LA7CODE,"!",3)=$$LNC^LRVER1($P(LA7CODE,"!",2),$P(LA7CODE,"!",4),LA761)
 . I '$P(LA7CODE,"!",3) S $P(LA7CODE,"!",3)=$P(LA7DFCDE,"^",3)
 Q
