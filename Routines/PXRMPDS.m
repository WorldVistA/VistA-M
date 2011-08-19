PXRMPDS ; SLC/PKR - Routines for patient data source. ;07/10/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;====================================================
KPDS(X,X1,X2,DAS) ;Kill the patient data source fields in the expanded
 ;taxonomy. Called from cross-reference on patient data source.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 I '$D(^PXD(811.3,DAS)) Q
 N DA,DIK,XS
 ;Protect X because DIK uses it without newing it.
 M XS=X
 S DIK="^PXD(811.3,"_DAS_",""PDS"","
 S DA(1)=DAS,DA=0
 F  S DA=+$O(^PXD(811.3,DAS,"PDS",DA)) Q:DA=0  D ^DIK
 ;If the Patient Data Source is being deleted then rebuild the
 ;list. The null value for PDS means search all nodes.
 I X2="" D SPDS(.X,.X1,.X2,DAS)
 M X=XS
 Q
 ;
 ;====================================================
PDSXHELP ;Taxonomy field Patient Data Source executable help.
 N DONE,IND,TEXT
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(TEXT+IND),";",3)
 . I TEXT="**End Text**" S DONE=1 Q
 . W !,TEXT
 Q
 ;
 ;====================================================
SPDS(X,X1,X2,DA) ;Set the patient data source fields in the expanded
 ;taxonomy. Called from cross-reference on patient data source.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 I '$D(^PXD(811.3,DA)) Q
 N FDA,IEN,IENS,IENT,IND,NNODE,NSOURCE,PDS,PDSL
 N ALL,EN,ENPP,ENPD,IN,INDXLS,INM,INPD,INPR,PL,RA
 ;If this is an edit and the current Patient Data Source is null
 ;delete the existing entries.
 I X1="" D KPDS(.X,.X1,.X2,DA)
 ;Build the list of patient data sources.
 S NSOURCE=$L(X,",")
 F IND=1:1:NSOURCE D
 . S PDS=$P(X,",",IND)
 . I PDS'="" S PDSL(PDS)=""
 S ALL=$S($D(PDSL("ALL")):1,X="":1,1:0)
 S EN=$S($D(PDSL("-EN")):0,$D(PDSL("EN")):1,ALL:1,1:0)
 S ENPD=$S($D(PDSL("-ENPD")):0,$D(PDSL("ENPD")):1,1:0)
 S ENPP=$S($D(PDSL("-ENPP")):0,$D(PDSL("ENPP")):1,1:0)
 S IN=$S($D(PDSL("-IN")):0,$D(PDSL("IN")):1,ALL:1,1:0)
 S INDXLS=$S($D(PDSL("-INDXLS")):0,$D(PDSL("INDXLS")):1,IN:1,1:0)
 S INM=$S($D(PDSL("-INM")):0,$D(PDSL("INM")):1,IN:1,1:0)
 S INPD=$S($D(PDSL("-INPD")):0,$D(PDSL("INPD")):1,IN:1,1:0)
 S INPR=$S($D(PDSL("-INPR")):0,$D(PDSL("INPR")):1,IN:1,1:0)
 S PL=$S($D(PDSL("-PL")):0,$D(PDSL("PL")):1,ALL:1,1:0)
 S RA=$S($D(PDSL("-RA")):0,$D(PDSL("RA")):1,ALL:1,1:0)
 ;Setup the nodes for each source file.
 S IEN=DA
 I (IN)!(INDXLS)!(INM)!(INPD)!(INPR) D
 . S NNODE=0
 . S IEN=IEN+1,IENS="+"_IEN_","_+DA_","
 . S FDA(811.33,IENS,.01)=45
 .;PTF ICD0 codes.
 . I (IN)!(INPR) D
 ..;PTF ICD0 codes.
 .. S IEN=IEN+1,IENS="+"_IEN_","_IENS,IENT=IENS
 .. S FDA(811.335,IENS,.01)=80.1
 .. F IND=1:1:5 D
 ... S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 ... S FDA(811.3355,IENS,.01)="P"_IND
 .. F IND=1:1:5 D
 ... S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 ... S FDA(811.3355,IENS,.01)="S"_IND
 .. S FDA(811.335,IENT,1)=NNODE
 . S IENT=IEN
 .;PTF ICD9 codes.
 . I (IN)!(INDXLS)!(INM)!(INPD) D
 .. S NNODE=0
 .. S IEN=DA+1,IENS="+"_IEN_","_+DA_","
 .. S IEN=IENT
 .. S IEN=IEN+1,IENS="+"_IEN_","_IENS
 .. S FDA(811.335,IENS,.01)=80
 .. S IENT=IENS
 .. I IN D
 ... F IND=1:1:13 D
 .... S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 .... S FDA(811.3355,IENS,.01)="D SD"_IND
 .. I INDXLS D
 ... S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 ... S FDA(811.3355,IENS,.01)="DXLS"
 .. I INM D
 ... F IND=1:1:10 D
 .... S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 .... S FDA(811.3355,IENS,.01)="M ICD"_IND
 .. I INPD D
 ... S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 ... S FDA(811.3355,IENS,.01)="PDX"
 .. S FDA(811.335,IENT,1)=NNODE
 ;RAD/NUC MED PATIENT
  I RA D
 . S IEN=IEN+1,IENS="+"_IEN_","_+DA_","
 . S FDA(811.33,IENS,.01)=70
 . S IEN=IEN+1,IENS="+"_IEN_","_IENS
 . S FDA(811.335,IENS,.01)=81
 ;PROBLEM LIST
 I PL D
 . S IEN=IEN+1,IENS="+"_IEN_","_+DA_","
 . S FDA(811.33,IENS,.01)=9000011
 . S IEN=IEN+1,IENS="+"_IEN_","_IENS
 . S FDA(811.335,IENS,.01)=80
 ;V POV
 I (EN)!(ENPD) D 
 . S NNODE=0
 . S IEN=IEN+1,IENS="+"_IEN_","_+DA_","
 . S FDA(811.33,IENS,.01)=9000010.07
 . S IEN=IEN+1,IENS="+"_IEN_","_IENS
 . S FDA(811.335,IENS,.01)=80
 . S IENT=IENS
 . S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 . S FDA(811.3355,IENS,.01)="P"
 . I 'ENPD D
 .. S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 .. S FDA(811.3355,IENS,.01)="S"
 .. S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 .. S FDA(811.3355,IENS,.01)="U"
 . S FDA(811.335,IENT,1)=NNODE
 ;V CPT
 I (EN)!(ENPP) D 
 . S NNODE=0
 . S IEN=IEN+1,IENS="+"_IEN_","_+DA_","
 . S FDA(811.33,IENS,.01)=9000010.18
 . S IEN=IEN+1,IENS="+"_IEN_","_IENS
 . S FDA(811.335,IENS,.01)=81
 . S IENT=IENS
 . S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 . S FDA(811.3355,IENS,.01)="Y"
 . I 'ENPP D
 .. S IEN=IEN+1,IENS="+"_IEN_","_IENT,NNODE=NNODE+1
 .. S FDA(811.3355,IENS,.01)="U"
 . S FDA(811.335,IENT,1)=NNODE
 D UPDATE(.FDA)
 Q
 ;
 ;====================================================
TEXT ;Taxonomy field Patient Data Source executable help text.
 ;;Taxonomy matching looks for all codes in the taxonomy. It searches for
 ;;ICD9 codes in Problem List, PTF, and V POV. It searches for ICD0 codes
 ;;in PTF and CPT codes in V CPT and Radiology.
 ;;
 ;;This comma separated list of patient data sources is used to refine the
 ;;taxonomy search by specifying exactly which patient data sources are searched.
 ;;You may use any combination of valid entries. The valid entries are:
 ;;
 ;;  ALL - all sources
 ;;  EN - All PCE encounter data (CPT & ICD9)
 ;;  ENPP - PCE encounter data, principal procedure (CPT) only
 ;;  ENPD - PCE encounter data primary diagnosis (ICD9) only
 ;;  IN - All PTF inpatient data (ICD9 & ICD0)
 ;;  INDXLS - PTF inpatient DXLS diagnosis (ICD9) only
 ;;  INM - PTF inpatient diagnosis (ICD9) movement only
 ;;  INPD - PTF inpatient principal diagnosis (ICD9) only
 ;;  INPR - PTF inpatient procedure (ICD0) only
 ;;  PL - Problem List (ICD9)
 ;;  RA - Radiology (CPT) only
 ;;
 ;;You may also use a minus sign to remove a particular source from the list.
 ;;For example: IN,-INM would search for all inpatient diagnoses, except those
 ;;associated with a movement, and all inpatient procedures.
 ;;
 ;;The default is to search all sources for all codes in the taxonomy.
 ;;
 ;;Note: ICD0 = ICD Operation/Procedure, used for inpatient coding of procedures.
 ;;
 ;;**End Text**
 Q
 ;
 ;====================================================
UPDATE(FDA) ;
 N MSG,TEXT
 D UPDATE^DIE("E","FDA","","MSG")
 I $D(MSG) D
 . S TEXT(1)="The expanded taxonomy search node update failed."
 . S TEXT(2)="UPDATE^DIE returned the following error message:"
 . D MES^XPDUTL(.TEXT)
 . D AWRITE^PXRMUTIL("MSG")
 . H 2
 Q
 ;
 ;====================================================
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
