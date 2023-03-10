PXRMP65I ;ISP/AGP - PATCH 65 INSTALLATION ;Jul 12, 2022@14:37:25
 ;;2.0;CLINICAL REMINDERS;**65**;Feb 04, 2005;Build 438
 Q
 ;
 ;===============
 ;I '$$PATCH^XPDUTL("PXRM*2.0*65") D
 N ENTRY,ENTRIES
 S ENTRIES("UPDATE_2_0_14 VA-HPV IMMUNIZATION")="12/20/2016@11:11:30"
 S ENTRIES("UPDATE_2_0_47 VA-HEPATITIS B IMMUNIZATIONS")="08/15/2018@13:48:11"
 S ENTRIES("UPDATE_2_0_28 VA-MENINGOCOCCAL IMMUNIZATIONS")="06/26/2017@05:56:48"
 S ENTRY="" F  S ENTRY=$O(ENTRIES(ENTRY)) Q:ENTRY=""  I +$$EXCHINCK^PXRMEXU5(ENTRY,ENTRIES(ENTRY))<1 D
 .W !,ENTRY,!,"is not installed.",!
 .S XPDABORT=2
 Q
 ;
 ;===============
CFINC(IEN) ;List of REMINDER COMPUTED FINDING entries to include in the build.
 ;These are the IENs in CPRS32 where the build is made.
 ;VA-REMINDER DEFINITION (IEN=35)
 ;VA-IMMUNIZATION AND LOCATION LOT INFO" (IEN=77)
 N RESULT
 S RESULT=0
 I IEN=35!(IEN=77) D
 .S RESULT=1
 .D RMEHIST^PXRMUTIL(811.4,IEN)
 Q RESULT
 ;
 ;===============
CFEDITHISTORY ;Establish the edit history of the computed findings
 ;installed by this build.
 N CFLIST,CFNAME,FDA,IEN,IENSS,MSG
 S CFLIST("VA-IMMUNIZATION AND LOCATION LOT INFO")=""
 S CFLIST("VA-REMINDER DEFINITION")=""
 S CFNAME=""
 F  S CFNAME=$O(CFLIST(CFNAME)) Q:CFNAME=""  D
 . I CFNAME="VA-IMMUNIZATION AND LOCATION LOT INFO" S TEXT(1)="Added by PXRM*2.0*65 installation"
 . I CFNAME="VA-REMINDER DEFINITION" S TEXT(1)="Updated by PXRM*2.0*65 installation"
 . S IEN=$O(^PXRMD(811.4,"B",CFNAME,""))
 . I IEN="" Q
 . S IENSS="+1,"_IEN_","
 . S FDA(811.42,IENSS,.01)=$$NOW^XLFDT
 . S FDA(811.42,IENSS,1)=DUZ
 . S FDA(811.42,IENSS,2)="TEXT"
 . D UPDATE^DIE("","FDA","","MSG")
 . I $D(MSG) D
 .. D BMES^XPDUTL("CFEDITHISTORY UPDATE^DIE FAILED FOR "_CFNAME)
 .. D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;===============
INCGUI(NAME) ;Include REMINDER GUI PROCESS (801.42) file entry?
 I NAME="PDMP" Q 1
 Q 0
 ;
 ;===============
PRE ;Pre-init
 ;Disable options and protocols
 ;D SMEXINS^PXRMEXSI("EXARRAY","PXRMP65E")
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*65")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*65")
 D RMOLDDDS
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP65E")
 Q
 ;
 ;===============
POST ;Post-init
 ;Install Exchange File entries.
 ;D SMEXINS^PXRMEXSI("EXARRAY","PXRMP45E")
 ;Delete temporary REMINDER DIALOG file entry
 ;Enable options and protocols
 D DIALCONV^PXRMP65D
 ;W $G(IOCUON)
 ;do not automatically install reminder exchange packed.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP65E")
 D CFEDITHISTORY^PXRMP65I
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*65")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*65")
 D SETPVER^PXRMUTIL("2.0P65")
 Q
 ;===============
RMOLDDDS ;Remove old data dictionaries.
 N DIU,TEXT
 D BMES^XPDUTL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=801.41,811.2,811.9 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D MES^XPDUTL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;===============
TAXPNAME ;Generate taxononmy Print Names from the .01.
 N CHAR,CF,CP,FDA,IEN,IENS,NAME,MSG,PNAME,REPA
 D TAXREPA(.REPA)
 D BMES^XPDUTL("Generating Print Names for taxonomies")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . S PNAME=$P(^PXD(811.2,IEN,0),U,3)
 . I PNAME'="" Q
 . D BMES^XPDUTL("Working on taxonomy "_NAME)
 . S PNAME=$$REPLACE^XLFSTR(NAME,.REPA)
 . S PNAME=$$TITLE^XLFSTR(PNAME)
 . S PNAME=$$REPLACE^XLFSTR(PNAME,.REPA)
 .;Make sure characters following those below are uppercase.
 . F CHAR="-","/","\" D
 .. S CP=0
 .. F  S CP=$F(PNAME,CHAR,CP) Q:CP=0  D
 ... S CF=$E(PNAME,CP)
 ... S $E(PNAME,CP)=$$UP^XLFSTR(CF)
 . D MES^XPDUTL("Print Name: "_PNAME)
 . K FDA,MSG
 . S IENS=IEN_","
 . S FDA(811.2,IENS,1.2)=PNAME
 . D FILE^DIE("ET","FDA","MSG")
 Q
 ;
 ;===============
TAXREPA(REPA) ;Establish the replacements for taxonomy Print Names.
 S REPA("A1c")="A1C"
 S REPA("Aaa")="AAA"
 S REPA("Abd")="ABD"
 S REPA("ACL")="ABD"
 S REPA("Afi")="AFI"
 S REPA("And")="and"
 S REPA("Asvd")="ASVD"
 S REPA("bmi")="BMI"
 S REPA("Bmi")="BMI"
 S REPA(" Ca ")=" CA"
 S REPA("Ccht")="CCHT"
 S REPA("Chf")="CHF"
 S REPA("Copd")="COPD"
 S REPA("copd")="COPD"
 S REPA("Cpt")="CPT"
 S REPA("Dg")="DG"
 S REPA("Dgpt")="DGPT"
 S REPA("Dx")="DX"
 S REPA("Dz")="DZ"
 S REPA("Ecoe")="ECOE"
 S REPA("Fobt")="FOBT"
 S REPA(" Gi ")=" GI "
 S REPA("Gp")="GP"
 S REPA("Grp")="GRP"
 S REPA("H1n1")="H1N1"
 S REPA("Hcv")="HCV"
 S REPA("Hedis")="HEDIS"
 S REPA("Hep ")="HEP "
 S REPA("hep")="HEP"
 S REPA("Hf")="HF"
 S REPA("Hgba1c")="HGBA1C"
 S REPA("Hib")="HIB"
 S REPA("Hiv")="HIV"
 S REPA("Hpv")="HPV"
 S REPA("Ht")="HT"
 S REPA("Icd")="ICD"
 S REPA("Icd0")="ICD0"
 S REPA("Icd9")="ICD9"
 S REPA("Icd10")="ICD10"
 S REPA("Icd-10")="ICD-10"
 S REPA("icd10")="ICD10"
 S REPA("Ihd")="IHD"
 S REPA("Im ")="IM "
 S REPA("Iud")="IUD"
 S REPA("Ldl")="LDL"
 S REPA("Mri")="MRI"
 S REPA("Mmr")="MMR"
 S REPA("Mhv")="MHV"
 S REPA("Nqf")="NQF"
 S REPA("Pcv13")="PCV13"
 S REPA("Pov")="POV"
 S REPA(" Pl")=" PL"
 S REPA("Ppd")="PPD"
 S REPA("Ppsv23")="PPSV23"
 S REPA("Psa")="PSA"
 S REPA("Ptf")="PTF"
 S REPA("Ptsd")="PTSD"
 S REPA("(Rd)")="(RD)"
 S REPA("Snomed")="SNOMED"
 S REPA("Snomed Ct")="SNOMED CT"
 S REPA("Tb")="TB"
 S REPA("Td")="TD"
 S REPA("Tdap")="TDAP"
 S REPA("Tt")="TT"
 S REPA("Tx")="TX"
 S REPA("Wh")="WH"
 S REPA("VA-")=""
 S REPA("Vimm-")="VIMM-"
 S REPA("Vcpt")="VCPT"
 S REPA("Vpov")="VPOV"
 S REPA("ZZ")=""
 Q
 ;
