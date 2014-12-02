PXRMPDS ; SLC/PKR - Routines for patient data source. ;03/13/2013
 ;;2.0;CLINICAL REMINDERS;**12,26**;Feb 04, 2005;Build 404
 ;
 ;====================================
HTEXT ;Taxonomy field Patient Data Source executable help text.
 ;;Taxonomy matching looks for all codes in the taxonomy. It searches for
 ;;ICD diagnosis codes in Problem List, PTF, and V POV. It searches for ICD
 ;;procedure codes in PTF. It searches for CPT-4 procedure codes in V CPT and
 ;;Radiology. It searches for SNOMED CT codes in Problem List.
 ;;
 ;;This comma separated list of patient data sources is used to refine the
 ;;taxonomy search by specifying exactly which patient data sources are searched.
 ;;You may use any combination of valid entries. The valid entries are:
 ;;
 ;;  ALL - all sources
 ;;  EN - All PCE encounter data (CPT-4 & ICD diagnosis)
 ;;  ENPP - PCE encounter data, principal procedure (CPT-4) only
 ;;  ENPD - PCE encounter data primary diagnosis (ICD) only
 ;;  IN - All PTF inpatient data (ICD diagnosis and procedures)
 ;;  INDXLS - PTF inpatient DXLS diagnosis (ICD) only
 ;;  INM - PTF inpatient diagnosis (ICD) movement only
 ;;  INPD - PTF inpatient principal diagnosis (ICD) only
 ;;  INPR - PTF inpatient procedure (ICD) only
 ;;  PL - Problem List (ICD diagnosis and SNOMED CT)
 ;;  RA - Radiology (CPT-4 procedures) only
 ;;
 ;;You may also use a minus sign to remove a particular source from the list.
 ;;For example: IN,-INM would search for all inpatient diagnoses, except those
 ;;associated with a movement, and all inpatient procedures.
 ;;
 ;;The default is ALL, search all sources for all codes in the taxonomy.
 ;;
 ;;**End Text**
 Q
 ;
 ;====================================
PDSXHELP ;Taxonomy field Patient Data Source executable help.
 N DONE,DIR0,IND,TEXT
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(HTEXT+IND),";",3)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","Patient Data Source Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;====================================
SPDS(DA,X2) ;Build the patient data source list.
 ;Called from cross-reference on Patient Data Source.
 ;X2 is the new value for PDS.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 N IND,NNODES,NODE,NSOURCE,PDS,PDSL,PDSTMP
 N ALL,EN,ENPP,ENPD,IN,INDXLS,INM,INPDX,INPR,PL,RA
 ;Build the list of patient data sources.
 S NSOURCE=$L(X2,",")
 F IND=1:1:NSOURCE D
 . S PDS=$P(X2,",",IND)
 . I PDS'="" S PDSL(PDS)=""
 S ALL=$S($D(PDSL("ALL")):1,X2="":1,1:0)
 S EN=$S($D(PDSL("-EN")):0,$D(PDSL("EN")):1,ALL:1,1:0)
 S ENPD=$S($D(PDSL("-ENPD")):0,$D(PDSL("ENPD")):1,EN:1,1:0)
 S ENPP=$S($D(PDSL("-ENPP")):0,$D(PDSL("ENPP")):1,EN:1,1:0)
 S IN=$S($D(PDSL("-IN")):0,$D(PDSL("IN")):1,ALL:1,1:0)
 S INDXLS=$S($D(PDSL("-INDXLS")):0,$D(PDSL("INDXLS")):1,IN:1,1:0)
 S INM=$S($D(PDSL("-INM")):0,$D(PDSL("INM")):1,IN:1,1:0)
 S INPDX=$S($D(PDSL("-INPDX")):0,$D(PDSL("INPDX")):1,IN:1,1:0)
 S INPR=$S($D(PDSL("-INPR")):0,$D(PDSL("INPR")):1,IN:1,1:0)
 S PL=$S($D(PDSL("-PL")):0,$D(PDSL("PL")):1,ALL:1,1:0)
 S RA=$S($D(PDSL("-RA")):0,$D(PDSL("RA")):1,ALL:1,1:0)
 ;PROBLEM LIST
 I PL S PDSTMP(9000011,1)=.01,PDSTMP(9000011,"NNODES")=1
 E  S PDSTMP(9000011,"NNODES")=0
 ;PTF
 S NNODES=0
 I IN F NODE=1:1:13 D
 . S NNODES=NNODES+1,PDSTMP(45,NNODES)="D SD"_NODE
 I INDXLS S NNODES=NNODES+1,PDSTMP(45,NNODES)="DXLS"
 I INM F NODE=1:1:10 D
 . S NNODES=NNODES+1,PDSTMP(45,NNODES)="M ICD"_NODE
 I INPDX S NNODES=NNODES+1,PDSTMP(45,NNODES)="PDX"
 I INPR D
 . F NODE=1:1:5 S NNODES=NNODES+1,PDSTMP(45,NNODES)="P"_NODE
 . F NODE=1:1:5 S NNODES=NNODES+1,PDSTMP(45,NNODES)="S"_NODE
 S PDSTMP(45,"NNODES")=NNODES
 ;V CPT
 S NNODES=0
 I EN S NNODES=NNODES+1,PDSTMP(9000010.18,NNODES)="U"
 I ENPP S NNODES=NNODES+1,PDSTMP(9000010.18,NNODES)="Y"
 S PDSTMP(9000010.18,"NNODES")=NNODES
 ;V POV
 S NNODES=0
 I EN D
 . S NNODES=NNODES+1,PDSTMP(9000010.07,NNODES)="S"
 . S NNODES=NNODES+1,PDSTMP(9000010.07,NNODES)="U"
 I ENPD S NNODES=NNODES+1,PDSTMP(9000010.07,NNODES)="P"
 S PDSTMP(9000010.07,"NNODES")=NNODES
 ;Radiology procedures
 S PDSTMP(71,"NNODES")=$S(RA:1,1:0)
 K ^PXD(811.2,DA,"APDS")
 M ^PXD(811.2,DA,"APDS")=PDSTMP
 Q
 ;
 ;====================================
VPDS(X) ;Taxonomy field Patient Data Source input transform. Check for valid
 ;patient data sources.
 N IND,NSOURCE,PDS,PDSL,TEXT,VALID
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 S VALID=1
 S NSOURCE=$L(X,",")
 F IND=1:1:NSOURCE D
 . S PDS=$P(X,",",IND),PDSL(PDS)=""
 .;Check for valid source abbreviations.
 . I PDS="ALL" Q
 . I (PDS="EN")!(PDS="-EN") Q
 . I (PDS="ENPD")!(PDS="-ENPD") Q
 . I (PDS="ENPP")!(PDS="-ENPP") Q
 . I (PDS="IN")!(PDS="-IN") Q
 . I (PDS="INDXLS")!(PDS="-INDXLS") Q
 . I (PDS="INM")!(PDS="-INM") Q
 . I (PDS="INPD")!(PDS="-INPD") Q
 . I (PDS="INPR")!(PDS="-INPR") Q
 . I (PDS="PL")!(PDS="-PL") Q
 . I (PDS="RA")!(PDS="-RA") Q
 . S VALID=0
 . S TEXT=PDS_" is not a valid Patient Data Source"
 . D EN^DDIOL(TEXT)
 ;Check for invalid combinations.
 I $D(PDSL("EN")),$D(PDSL("-EN")) S TEXT="EN and -EN is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("ENPD")),$D(PDSL("-ENPD")) S TEXT="ENPD and -ENPD is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("ENPP")),$D(PDSL("-ENPP")) S TEXT="ENPP and -ENPP is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("IN")),$D(PDSL("-IN")) S TEXT="IN and -IN is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("INDXLS")),$D(PDSL("-INDXLS")) S TEXT="INDXLS and -INDXLS is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("INM")),$D(PDSL("-INM")) S TEXT="INM and -INM is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("INPD")),$D(PDSL("-INPD")) S TEXT="INPD and -INPD is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("INPR")),$D(PDSL("-INPR")) S TEXT="INPR and -INPR is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("PL")),$D(PDSL("-PL")) S TEXT="PL and -PL is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 I $D(PDSL("RA")),$D(PDSL("-RA")) S TEXT="RA and -RA is an invalid combination",VALID=0 D EN^DDIOL(TEXT)
 Q VALID
 ;
