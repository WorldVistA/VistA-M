PSGRPNT ;BIR/CML3-REPOINT SITE POINTERS ;16 DEC 97 / 1:37 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ONLY1 ;
 S Q=0 F QQ=-1:1 S Q=$O(^PS(59.4,Q)) Q:'Q
 I 'QQ W $C(7),!!,"THIS IS YOUR ONLY SITE!",!,"(You must create another site before you can delete this one.)" Q
