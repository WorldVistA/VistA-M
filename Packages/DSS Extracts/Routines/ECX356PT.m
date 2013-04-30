ECX356PT ;ALB/JAM - PATCH ECX*3.0*48 Post-Init Rtn ; 03/24/03
 ;;3.0;DSS EXTRACTS;**56**;Sept 19, 2003
 ;
 ;Post-init routine to add new entries to:
 ;           NATIONAL CLINIC file (#728.441)
EN ;
 ;- Add new entry to file 728.441
 ;      ECXREC is in format: code^short description
 N ECXFDA,ECXERR,ECXCODE,ECXREC,I,CNT0,CNT1
 D BMES^XPDUTL(">>> Adding entry to the NATIONAL CLINIC (#728.441) file...")
 D MES^XPDUTL(" ")
 S (CNT0,CNT1,CNT2)=0 K ^UTILITY("NATLCODE",$J)
 ;
 D LOADDATA   ;B/C of the large number of new codes, they are stored in numerous routines. Load all codes into
 ;             a utility global before adding to database
 D PROCESS
 D END
 Q  ;End of loading process
LOADDATA        ;Load all new codes into utility global
 ;
 S CNT=1
 F ECX=1:1 S ECXX=$P($T(NATCLIN+ECX),";;",2) Q:ECXX="QUIT"  D
 . S ^UTILITY("NATLCODE",$J,CNT)=ECXX,CNT=CNT+1
 F ECX=1:1 S ECXX=$P($T(NATCLIN+ECX^ECX356D1),";;",2) Q:ECXX="QUIT"  D
 . S ^UTILITY("NATLCODE",$J,CNT)=ECXX,CNT=CNT+1
 F ECX=1:1 S ECXX=$P($T(NATCLIN+ECX^ECX356D2),";;",2) Q:ECXX="QUIT"  D
 . S ^UTILITY("NATLCODE",$J,CNT)=ECXX,CNT=CNT+1
 Q  ;LOADDATA
 ;
PROCESS ; Get NAT'L CLINIC records from UTL global
 S SEQ=""
 F  S SEQ=$O(^UTILITY("NATLCODE",$J,SEQ)) Q:SEQ=""  D
 . S ECXREC=^UTILITY("NATLCODE",$J,SEQ)
 . S ECXCODE=$P(ECXREC,"^")
 .; Quit w/error message if entry already exists
 . I $$FIND1^DIC(728.441,"","X",ECXCODE) D  Q
 . . D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  not added, entry already exists.")
 . . S CNT1=CNT1+1
 .; Setup field values of new entry
 . S ECXFDA(728.441,"+1,",.01)=ECXCODE
 . S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .; Add new entry
 . D UPDATE^DIE("E","ECXFDA","","ECXERR")
 . I '$D(ECXERR) D  Q
 . . D BMES^XPDUTL(">>>..."_ECXCODE_"  "_$P(ECXREC,U,2)_"  added to file.")
 . . S CNT0=CNT0+1
 . D BMES^XPDUTL(">>>...Unable to add "_ECXCODE_"  "_$P(ECXREC,U,2)_" to file.")
 . S CNT2=CNT2+1
 . K ECXERR  ;clean out error array b4 processing next code
 ;
 Q  ;FILEONE
END D MES^XPDUTL(" ")
 D MES^XPDUTL(" Done... Update to NATIONAL CLINIC File (#728.441).")
 D MES^XPDUTL("            "_$J(CNT0,3)_" new entries added.")
 D MES^XPDUTL("            "_$J(CNT1,3)_" were not added, already exist.")
 D MES^XPDUTL("            "_$J(CNT2,3)_" were not added, unable to add.")
 D MES^XPDUTL(" ")
 K ^UTILITY("NATLCODE",$J)
 Q
 ;
NATCLIN ;NAT'L CLINIC entry to add:
 ;;ICBC^CBC I
 ;;INUR^RN I
 ;;IRED^RED TEAM I
 ;;IBLU^BLUE TEAM I
 ;;IYEL^YELLOW TEAM I
 ;;ICPX^C&P CLINIC PROFILE I
 ;;IOTH^OTHER I
 ;;IPRI^PRIMARY CARE I
 ;;ISAT^SATELLITE I
 ;;ITEM^TEAM I
 ;;JCBC^CBC J
 ;;JNUR^RN J
 ;;JRED^RED TEAM J
 ;;JBLU^BLUE TEAM J
 ;;JYEL^YELLOW TEAM J
 ;;JCPX^C&P CLINIC PROFILE J
 ;;JOTH^OTHER J
 ;;JPRI^PRIMARY CARE J
 ;;JSAT^SATELLITE J
 ;;JTEM^TEAM J
 ;;KCBC^CBC K
 ;;KNUR^RN K
 ;;KRED^RED TEAM K
 ;;KBLU^BLUE TEAM K
 ;;KYEL^YELLOW TEAM K
 ;;KCPX^C&P CLINIC PROFILE K
 ;;KOTH^OTHER K
 ;;KPRI^PRIMARY CARE K
 ;;KSAT^SATELLITE K
 ;;KTEM^TEAM K
 ;;LCBC^CBC L
 ;;LNUR^RN L
 ;;LRED^RED TEAM L
 ;;LBLU^BLUE TEAM L
 ;;LYEL^YELLOW TEAM L
 ;;LCPX^C&P CLINIC PROFILE L
 ;;LOTH^OTHER L
 ;;LPRI^PRIMARY CARE L
 ;;LSAT^SATELLITE L
 ;;LTEM^TEAM L
 ;;MCBC^CBC M
 ;;MNUR^RN M
 ;;MRED^RED TEAM M
 ;;MBLU^BLUE TEAM M
 ;;MYEL^YELLOW TEAM M
 ;;MCPX^C&P CLINIC PROFILE M
 ;;MOTH^OTHER M
 ;;MPRI^PRIMARY CARE M
 ;;MSAT^SATELLITE M
 ;;MTEM^TEAM M
 ;;NCBC^CBC N
 ;;NNUR^RN N
 ;;NRED^RED TEAM N
 ;;NBLU^BLUE TEAM N
 ;;NYEL^YELLOW TEAM N
 ;;NCPX^C&P CLINIC PROFILE N
 ;;NOTH^OTHER N
 ;;NPRI^PRIMARY CARE N
 ;;NSAT^SATELLITE N
 ;;NTEM^TEAM N
 ;;OCBC^CBC O
 ;;ONUR^RN O
 ;;ORED^RED TEAM O
 ;;OBLU^BLUE TEAM O
 ;;OYEL^YELLOW TEAM O
 ;;OCPX^C&P CLINIC PROFILE O
 ;;OOTH^OTHER O
 ;;OPRI^PRIMARY CARE O
 ;;OSAT^SATELLITE O
 ;;OTEM^TEAM O
 ;;PCBC^CBC P
 ;;PNUR^RN P
 ;;PRED^RED TEAM P
 ;;PBLU^BLUE TEAM P
 ;;PYEL^YELLOW TEAM P
 ;;PCPX^C&P CLINIC PROFILE P
 ;;POTH^OTHER P
 ;;PPRI^PRIMARY CARE P
 ;;PSAT^SATELLITE P
 ;;PTEM^TEAM P
 ;;QCBC^CBC Q
 ;;QNUR^RN Q
 ;;QRED^RED TEAM Q
 ;;QBLU^BLUE TEAM Q
 ;;QYEL^YELLOW TEAM Q
 ;;QCPX^C&P CLINIC PROFILE Q
 ;;QOTH^OTHER Q
 ;;QPRI^PRIMARY CARE Q
 ;;QSAT^SATELLITE Q
 ;;QTEM^TEAM Q
 ;;RCBC^CBC R
 ;;RNUR^RN R
 ;;RRED^RED TEAM R
 ;;RBLU^BLUE TEAM R
 ;;RYEL^YELLOW TEAM R
 ;;RCPX^C&P CLINIC PROFILE R
 ;;ROTH^OTHER R
 ;;RPRI^PRIMARY CARE R
 ;;RSAT^SATELLITE R
 ;;RTEM^TEAM R
 ;;SCBC^CBC S
 ;;SNUR^RN S
 ;;SRED^RED TEAM S
 ;;SBLU^BLUE TEAM S
 ;;SYEL^YELLOW TEAM S
 ;;SCPX^C&P CLINIC PROFILE S
 ;;SOTH^OTHER S
 ;;SPRI^PRIMARY CARE S
 ;;SSAT^SATELLITE S
 ;;STEM^TEAM S
 ;;TCBC^CBC T
 ;;TNUR^RN T
 ;;TRED^RED TEAM T
 ;;TBLU^BLUE TEAM T
 ;;TYEL^YELLOW TEAM T
 ;;TCPX^C&P CLINIC PROFILE T
 ;;TOTH^OTHER T
 ;;TPRI^PRIMARY CARE T
 ;;TSAT^SATELLITE T
 ;;TTEM^TEAM T
 ;;UCBC^CBC U
 ;;UNUR^RN U
 ;;URED^RED TEAM U
 ;;UBLU^BLUE TEAM U
 ;;UYEL^YELLOW TEAM U
 ;;UCPX^C&P CLINIC PROFILE U
 ;;UOTH^OTHER U
 ;;UPRI^PRIMARY CARE U
 ;;USAT^SATELLITE U
 ;;UTEM^TEAM U
 ;;VCBC^CBC V
 ;;VNUR^RN V
 ;;VRED^RED TEAM V
 ;;VBLU^BLUE TEAM V
 ;;VYEL^YELLOW TEAM V
 ;;VCPX^C&P CLINIC PROFILE V
 ;;VOTH^OTHER V
 ;;VPRI^PRIMARY CARE V
 ;;VSAT^SATELLITE V
 ;;VTEM^TEAM V
 ;;WCBC^CBC W
 ;;WNUR^RN W
 ;;WRED^RED TEAM W
 ;;WBLU^BLUE TEAM W
 ;;WYEL^YELLOW TEAM W
 ;;WCPX^C&P CLINIC PROFILE W
 ;;WOTH^OTHER W
 ;;WPRI^PRIMARY CARE W
 ;;WSAT^SATELLITE W
 ;;WTEM^TEAM W
 ;;XCBC^CBC X
 ;;XNUR^RN X
 ;;XRED^RED TEAM X
 ;;XBLU^BLUE TEAM X
 ;;XYEL^YELLOW TEAM X
 ;;XCPX^C&P CLINIC PROFILE X
 ;;XOTH^OTHER X
 ;;XPRI^PRIMARY CARE X
 ;;XSAT^SATELLITE X
 ;;XTEM^TEAM X
 ;;YCBC^CBC Y
 ;;YNUR^RN Y
 ;;YRED^RED TEAM Y
 ;;YBLU^BLUE TEAM Y
 ;;YYEL^YELLOW TEAM Y
 ;;YCPX^C&P CLINIC PROFILE Y
 ;;YOTH^OTHER Y
 ;;YPRI^PRIMARY CARE Y
 ;;YSAT^SATELLITE Y
 ;;YTEM^TEAM Y
 ;;ZCBC^CBC Z
 ;;ZNUR^RN Z
 ;;ZRED^RED TEAM Z
 ;;ZBLU^BLUE TEAM Z
 ;;ZYEL^YELLOW TEAM Z
 ;;ZCPX^C&P CLINIC PROFILE Z
 ;;ZOTH^OTHER Z
 ;;ZPRI^PRIMARY CARE Z
 ;;ZSAT^SATELLITE Z
 ;;ZTEM^TEAM Z
 ;;CDSW^Cardiac Disease Social Worker
 ;;CDRN^Cardiac Disease Registered Nurse
 ;;CDNP^Cardiac Disease Nurse Practitioner
 ;;CDRD^Cardiac Disease Registered Dietician
 ;;CDPT^Cardiac Disease Physical Therapist
 ;;CDPA^Cardiac Disease Physician Assistant
 ;;CDPH^Cardiac Disease Pharmacist
 ;;CDCC^Cardiac Disease CC Team
 ;;CGSW^Coag Management Social Worker
 ;;CGRN^Coag Management Registered Nurse
 ;;CGNP^Coag Management Nurse Practitioner
 ;;CGRD^Coag Management Registered Dietician
 ;;CGPT^Coag Management Physical Therapist
 ;;CGPA^Coag Management Physician Assistant
 ;;CGPH^Coag Management Pharmacist
 ;;CGCC^Coag Management CC Team
 ;;DESW^Dementia Social Worker
 ;;DERN^Dementia Registered Nurse
 ;;DENP^Dementia Nurse Practitioner
 ;;DERD^Dementia Registered Dietician
 ;;DEPT^Dementia Physical Therapist
 ;;DEPA^Dementia Physician Assistant
 ;;DEPH^Dementia Pharmacist
 ;;DECC^Dementia CC Team
 ;;DMSW^Diabetes Mellitus Social Worker
 ;;DMRN^Diabetes Mellitus Registered Nurse
 ;;DMNP^Diabetes Mellitus Nurse Practitioner
 ;;DMRD^Diabetes Mellitus Registered Dietician
 ;;DMPT^Diabetes Mellitus Physical Therapist
 ;;DMPA^Diabetes Mellitus Physician Assistant
 ;;DMPH^Diabetes Mellitus Pharmacist
 ;;DMCC^Diabetes Mellitus CC Team
 ;;HTSW^Hypertension Social Worker
 ;;HTRN^Hypertension Registered Nurse
 ;;HTNP^Hypertension Nurse Practitioner
 ;;HTRD^Hypertension Registered Dietician
 ;;HTPT^Hypertension Physical Therapist
 ;;HTPA^Hypertension Physician Assistant
 ;;HTPH^Hypertension Pharmacist
 ;;HTCC^Hypertension CC Team
 ;;IDSW^Infectious Disease Social Worker
 ;;IDRN^Infectious Disease Registered Nurse
 ;;IDNP^Infectious Disease Nurse Practitioner
 ;;IDRD^Infectious Disease Registered Dietician
 ;;IDPT^Infectious Disease Physical Therapist
 ;;IDPA^Infectious Disease Physician Assistant
 ;;IDPH^Infectious Disease Pharmacist
 ;;IDCC^Infectious Disease CC Team
 ;;MHSW^Mental Health Social Worker
 ;;MHRN^Mental Health Registered Nurse
 ;;MHNP^Mental Health Nurse Practitioner
 ;;MHRD^Mental Health Registered Dietician
 ;;MHPT^Mental Health Physical Therapist
 ;;MHPA^Mental Health Physician Assistant
 ;;MHPH^Mental Health Pharmacist
 ;;MHCC^Mental Health CC Team
 ;;MMSW^Multiple Co-Morbidities Social Worker
 ;;MMRN^Multiple Co-Morbidities Registered Nurse
 ;;MMNP^Multiple Co-Morbidities Nurse Practitioner
 ;;MMRD^Multiple Co-Morbidities Registered Dietician
 ;;MMPT^Multiple Co-Morbidities Physical Therapist
 ;;MMPA^Multiple Co-Morbidities Physician Assistant
 ;;MMPH^Multiple Co-Morbidities Pharmacist
 ;;MMCC^Multiple Co-Morbidities CC Team
 ;;PLSW^Palliative Social Worker
 ;;PLRN^Palliative Registered Nurse
 ;;PLNP^Palliative Nurse Practitioner
 ;;PLRD^Palliative Registered Dietician
 ;;PLPT^Palliative Physical Therapist
 ;;PLPA^Palliative Physician Assistant
 ;;PLPH^Palliative Pharmacist
 ;;PLCC^Palliative CC Team
 ;;PNSW^Pain Management Social Worker
 ;;PNRN^Pain Management Registered Nurse
 ;;PNNP^Pain Management Nurse Practitioner
 ;;PNRD^Pain Management Registered Dietician
 ;;PNPT^Pain Management Physical Therapist
 ;;QUIT
