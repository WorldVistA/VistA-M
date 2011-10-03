LA7HLP ;DALISC/JRR - HELP TEXT FOR MESSAGING FIELDS
 ;;5.2;LAB MESSAGING;**17**;Feb 29, 1996
 QUIT
 ;;HL7 TABLE 0070 source of specimen, used for help and input xform
 ;;in field .08 of file 61 and field .08 of file 62
TBL70 ;;
 ;;Enter the two to four character code from the left column:
 ;; 
 ;;ABS^Abcess
 ;;AMN^Amniotic fluid
 ;;ASP^Aspirate
 ;;BPH^Basophils
 ;;ABLD^Blood arterial
 ;;BBL^Blood bag
 ;;BON^Bone
 ;;BRTH^Breath
 ;;BRO^Bronchial
 ;;BRN^Burn
 ;;CALC^Calculus
 ;;CDM^Cardiac muscle
 ;;CNL^Cannula
 ;;CTP^Catheter tip
 ;;CSF^Cerebral spinal fluid
 ;;CVM^Cervical mucus
 ;;CVX^Cervix
 ;;COL^Colostrum
 ;;CBLD^Cord blood
 ;;CNJT^Conjunctiva
 ;;CUR^Curettageputum
 ;;CYST^Cyst
 ;;DRN^Drain
 ;;EAR^Ear
 ;;ELT^Electrode
 ;;ENDC^Endocardium
 ;;ENDM^Endometrium
 ;;EOS^Eosinophils
 ;;RBC^Erythrocytes
 ;;FIB^Fibrolasts
 ;;FLT^Filter
 ;;FIST^Fistula
 ;;FLU^Body fluid, unsp
 ;;GAST^Gastric fluid
 ;;GEN^Genital
 ;;GENC^Genital, cervix
 ;;GENL^Genital lochia
 ;;GENV^Genital vaginal
 ;;HAR^Hair
 ;;IT^Intubation tube
 ;;LAM^Lamella
 ;;WBC^Leucocytes
 ;;LN^Line
 ;;LNA^Line arterial
 ;;LNV^Line venous
 ;;LYM^Lymphocytes
 ;;MAC^Macrophages
 ;;MAR^Marrow
 ;;MEC^Meconium
 ;;MBLD^Menstrual blood
 ;;MLK^Milk
 ;;MILK^Breast Milk
 ;;NAIL^Nail
 ;;NOS^Nose (nasal passage)
 ;;ORH^Other
 ;;PRT^Peritoneal fluid ascites
 ;;PER^Peritoneum
 ;;PLC^Placenta
 ;;PLAS^Plasma
 ;;PLB^Plasma bag
 ;;PLR^Pleural fluid (thoracentesis fld)
 ;;PMN^Polymorphonuclear neutrophils
 ;;PUS^Pus
 ;;SAL^Saliva
 ;;SEM^Seminal fluid
 ;;SER^Serum
 ;;SKN^Skin
 ;;SKM^Skeletal muscle
 ;;SPRM^Spermatozoa
 ;;SPT^Sputum
 ;;SPTC^Sputum coughed
 ;;SPTT^Sputum tracheal aspirate
 ;;STON^Stone
 ;;STL^Stool = Fecal
 ;;SWT^Sweat
 ;;SNV^Synovial fluid = Joint fluid
 ;;TEAR^Tears
 ;;THRT^Throat
 ;;THRB^Thrombocyte (platelet)
 ;;TISS^Tissue
 ;;TISB^Tissue bone marrow
 ;;TISG^Tissue gall bladder
 ;;TISL^Tissue lung
 ;;TISP^Tissue peritoneum
 ;;TISU^Tissue ulcer
 ;;TISC^Tissue curettage
 ;;TISPL^Tissue placenta
 ;;ULC^Ulcer
 ;;UMB^Umbilical blood
 ;;UR^Urine
 ;;URTH^Urethra
 ;;URC^Urine clean catch
 ;;URT^Urine catheter
 ;;VOM^Vomitus
 ;;BLD^Whole blood
 ;;BDY^Whole body
 ;;WICK^Wick
 ;;WND^Wound
 ;;WNDA^Wound abcess
 ;;WNDE^Wound exudate
 ;;WNDD^Wound drainage
 ;;
 QUIT
SHOW N LA7,LA71
 D HOME^%ZIS
 W @IOF
 F LA7=1:1 S LA71=$P($T(TBL70+LA7),";;",2) Q:LA71=""  D  Q:LA71=-1
 . K DIRUT
 . I (IOSL-$Y)<3 K DIR S DIR(0)="E" D ^DIR K DIR W @IOF
 . I $D(DIRUT) S LA71=-1 QUIT  ;>>>
 . W !,$P(LA71,"^"),?10,$P(LA71,"^",2)
 QUIT
XFORM(X) ;Input transform for field .08 file 61, and field .08 file 62
 ;X is the value entered by the user, this subroutine checks to make
 ;sure that the value matches a valid code.  This function evaluates
 ;to true if X is okay, false if X is not valid. 
 N LA7,LA71
 F LA7=1:1 S LA71=$P($T(TBL70+LA7),";;",2) Q:LA71=""  D
 . S LA71=$P(LA71,"^") ;get the 2 to 4 char abbreviation
 . Q:LA71=""
 . S LA71(LA71)=""
 QUIT $D(LA71(X))
