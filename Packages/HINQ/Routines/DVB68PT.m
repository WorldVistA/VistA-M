DVB68PT ;ALB/JDG - UPDATE DISABILITY CONDITION (#31) FILE;1/3/19
 ;;4.0;HINQ;**68**;03/25/92;Build 6
 ;
 Q
 ;
 ;
EN ;Initialize variables and validate user.
 N DVBI,DVBJ,DVBREF,DIC,DO,X,Y
 I '$D(DUZ) D BMES^XPDUTL("*** PROGRAMMER NOT DEFINED ***") Q
DVBNEW ;Add new codes.
 D BMES^XPDUTL("** Updating DISABILITY CONDITION (#31) file **")
 F DVBI=1:1 S DVBJ=$P($T(NEWCODE+DVBI),";;",2) Q:DVBJ="QUIT"  D
 .S DVBREF=+DVBJ
 .I $D(^DIC(31,"C",DVBREF)) D DVBERR1 Q
 .K DO
 .S DIC="^DIC(31,",DIC(0)="L",DIC("DR")="2///"_DVBREF,X=$P(DVBJ,"^",2)
 .D FILE^DICN
 .I Y=-1 D DVBERR2 Q
 .D BMES^XPDUTL("** "_DVBREF_"    "_X_" has been added **")
 D BMES^XPDUTL("** Done **")
 Q
DVBERR1 ;Message to the user that the file entry already exists.
 D BMES^XPDUTL("*** A FILE ENTRY FOR DISABILITY CODE "_DVBREF_" HAS ALREADY BEEN CREATED ***")
 Q
DVBERR2 ;Message to the user that an error occurred.
 D BMES^XPDUTL("*** AN ERROR OCCURRED WHEN ATTEMPTING TO ADD NEW FILE ENTRIES. PLEASE CONTACT PRODUCT SUPPORT ***")
 Q
NEWCODE ;Code to be added.
 ;;6040^DIABETIC RETINOPATHY
 ;;6042^RETINAL DYSTROPHY (INCLUDING RETINITIS PIGMENTOSA)
 ;;6046^POST-CHIASMAL DISORDERS
 ;;7630^MALIGNANT NEOPLASMS OF THE BREAST
 ;;7631^BENIGN NEOPLASMS OF THE BREAST AND OTHER INJURIES OF THE BREAST
 ;;7632^FEMALE SEXUAL AROUSAL DISORDER (FSAD)
 ;;7718^ESSENTIAL THROMBOCYTHEMIA/PRIMARY MYELOFIBROSIS
 ;;7719^CHRONIC MYELOGENOUS LEUKEMIA
 ;;7720^IRON DEFICIENCY ANEMIA
 ;;7721^FOLIC ACID DEFICIENCY
 ;;7722^PERNICIOUS ANEMIA AND VITAMIN B12 DEFICIENCY ANEMIA
 ;;7723^ACQUIRED HEMOLYTIC ANEMIA
 ;;7724^SOLITARY PLASMACYTOMA
 ;;7725^MYELODYSPLASTIC SYNDROMES
 ;;7906^THYROIDITIS
 ;;9917^NEOPLASM, HARD AND SOFT TISSUE, BENIGN
 ;;9918^NEOPLASM, HARD AND SOFT TISSUE, MALIGNANT
 ;;QUIT
 Q
