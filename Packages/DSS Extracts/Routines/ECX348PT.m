ECX348PT ;ALB/JAM - PATCH ECX*3.0*48 Post-Init Rtn ; 03/24/03
 ;;3.0;DSS EXTRACTS;**48**;Dec 22, 1997
 ;
 ;Post-init routine to add new entries to:
 ;           NATIONAL CLINIC file (#728.441)
 ;
EN ;
 ;- Add new entry to file 728.441
 ;      ECXREC is in format: code^short description
 ;
 ;
 N ECXFDA,ECXERR,ECXCODE,ECXREC,I,CNT0,CNT1
 D BMES^XPDUTL(">>> Adding entry to the NATIONAL CLINIC (#728.441) file...")
 D MES^XPDUTL(" ")
 S (CNT0,CNT1)=0
 ;
 ;- Get NATIONAL CLINIC record
 F I=1:1 S ECXREC=$P($T(NATCLIN+I),";;",2) Q:ECXREC="QUIT"  D
 .;
 .;- National Clinic code
 .S ECXCODE=$P(ECXREC,"^")
 .;
 .;- Quit w/error message if entry already exists in file #728.441
 .I $$FIND1^DIC(728.441,"","X",ECXCODE) D  Q
 ..D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  not added, entry already exists.")
 ..S CNT1=CNT1+1
 .;- Setup field values of new entry
 .S ECXFDA(728.441,"+1,",.01)=ECXCODE
 .S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .;
 .;- Add new entry to file #728.441
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D  Q
 ..D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  added to file.")
 ..S CNT0=CNT0+1
 .D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_"  "_$P(ECXREC,U,2)_" to file.")
 .S CNT1=CNT1+1
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Done... Update to NATIONAL CLINIC File (#728.441).")
 D MES^XPDUTL("            "_$J(CNT0,3)_" new entries added.")
 D MES^XPDUTL("            "_$J(CNT1,3)_" were not added, already exist.")
 D MES^XPDUTL(" ")
 ;
 Q
 ;
NATCLIN ;- Contains the NATIONAL CLINIC entry to be added
 ;;CDAC^Cardiac Disease V1 CCS
 ;;CGAC^Coagulation Management V1 CCS
 ;;DEAC^Dementia V1 CCS
 ;;DMAC^Diabetes Mellitus V1 CCS
 ;;HTAC^Hypertension V1 CCS
 ;;IDAC^Infectious Disease V1 CCS
 ;;MHAC^Mental Health V1 CCS
 ;;PNAC^Pain Management V1 CCS
 ;;PDAC^Pulmonary Disease V1 CCS
 ;;RHAC^Rehabilitation V1 CCS
 ;;SCAC^Spinal Cord Injured V1 CCS
 ;;WCAC^Wound Care V1 CCS
 ;;CDBC^Cardiac Disease V2 CCS
 ;;CGBC^Coagulation Management V2 CCS
 ;;DEBC^Dementia V2 CCS
 ;;DMBC^Diabetes Mellitus V2 CCS
 ;;HTBC^Hypertension V2 CCS
 ;;IDBC^Infectious Disease V2 CCS
 ;;MHBC^Mental Health V2 CCS
 ;;PNBC^Pain Management V2 CCS
 ;;PDBC^Pulmonary Disease V2 CCS
 ;;RHBC^Rehabilitation V2 CCS
 ;;SCBC^Spinal Cord Injured V2 CCS
 ;;WCBC^Wound Care V2 CCS
 ;;CDCC^Cardiac Disease V3 CCS
 ;;CGCC^Coagulation Management V3 CCS
 ;;DECC^Dementia V3 CCS
 ;;DMCC^Diabetes Mellitus V3 CCS
 ;;HTCC^Hypertension V3 CCS
 ;;IDCC^Infectious Disease V3 CCS
 ;;MHCC^Mental Health V3 CCS
 ;;PNCC^Pain Management V3 CCS
 ;;PDCC^Pulmonary Disease V3 CCS
 ;;RHCC^Rehabilitation V3 CCS
 ;;SCCC^Spinal Cord Injured V3 CCS
 ;;WCCC^Wound Care V3 CCS
 ;;CDDC^Cardiac Disease V4 CCS
 ;;CGDC^Coagulation Management V4 CCS
 ;;DEDC^Dementia V4 CCS
 ;;DMDC^Diabetes Mellitus V4 CCS
 ;;HDDC^Hypertension V4 CCS
 ;;IDDC^Infectious Disease V4 CCS
 ;;MHDC^Mental Health V4 CCS
 ;;PNDC^Pain Management V4 CCS
 ;;PDDC^Pulmonary Disease V4 CCS
 ;;RHDC^Rehabilitation V4 CCS
 ;;SCDC^Spinal Cord Injured V4 CCS
 ;;WCDC^Wound Care V4 CCS
 ;;CDEC^Cardiac Disease V5 CCS
 ;;CGEC^Coagulation Management V5 CCS
 ;;DEEC^Dementia V5 CCS
 ;;DMEC^Diabetes Mellitus V5 CCS
 ;;HDEC^Hypertension V5 CCS
 ;;IDEC^Infectious Disease V5 CCS
 ;;MHEC^Mental Health V5 CCS
 ;;PNEC^Pain Management V5 CCS
 ;;PDEC^Pulmonary Disease V5 CCS
 ;;RHEC^Rehabilitation V5 CCS
 ;;SCEC^Spinal Cord Injured V5 CCS
 ;;WCEC^Wound Care V5 CCS
 ;;CDFC^Cardiac Disease V6 CCS
 ;;CGFC^Coagulation Management V6 CCCS
 ;;DEFC^Dementia V6 CCS
 ;;DMFC^Diabetes Mellitus V6 CCS
 ;;HTFC^Hypertension V6 CCS
 ;;IDFC^Infectious Disease V6 CCS
 ;;MHFC^Mental Health V6 CCS
 ;;PNFC^Pain Management V6 CCS
 ;;PDFC^Pulmonary Disease V6 CCS
 ;;RHFC^Rehabilitation V6 CCS
 ;;SCFC^Spinal Cord Injured V6 CCS
 ;;WCFC^Wound Care V6 CCS
 ;;CDGC^Cardiac Disease V7 CCS
 ;;CGGC^Coagulation Management V7 CCS
 ;;DEGC^Dementia V7 CCS
 ;;DMGC^Diabetes Mellitus V7 CCS
 ;;HDGC^Hypertension V7 CCS
 ;;IDGC^Infectious Disease V7 CCS
 ;;MHGC^Mental Health V7 CCS
 ;;PNGC^Pain Management V7 CCS
 ;;PDGC^Pulmonary Disease V7 CCS
 ;;RHGC^Rehabilitation V7 CCS
 ;;SCGC^Spinal Cord Injured V7 CCS
 ;;WCGC^Wound Care V7 CCS
 ;;CDHC^Cardiac Disease V8 CCS
 ;;CGHC^Coagulation Management V8 CCS
 ;;DEHC^Dementia V8 CCS
 ;;DMHC^Diabetes Mellitus V8 CCS
 ;;HDHC^Hypertension V8 CCS
 ;;IDHC^Infectious Disease V8 CCS
 ;;MHHC^Mental Health V8 CCS
 ;;PNHC^Pain Management V8 CCS
 ;;PDHC^Pulmonary Disease V8 CCS
 ;;RHHC^Rehabilitation V8 CCS
 ;;SCHC^Spinal Cord Injured V8 CCS
 ;;WCHC^Wound Care V8 CCS
 ;;CDJC^Cardiac Disease V9 CCS
 ;;CGJC^Coagulation Management V9 CCS
 ;;DEJC^Dementia V9 CCS
 ;;DMJC^Diabetes Mellitus V9 CCS
 ;;HDJC^Hypertension V9 CCS
 ;;IDJC^Infectious Disease V9 CCS
 ;;MHJC^Mental Health V9 CCS
 ;;PNJC^Pain Management V9 CCS
 ;;PDJC^Pulmonary Disease V9 CCS
 ;;RHJC^Rehabilitation V9 CCS
 ;;SCJC^Spinal Cord Injured V9 CCS
 ;;WCJC^Wound Care V9 CCS
 ;;CDKC^Cardiac Disease V10 CCS
 ;;CGKC^Coagulation Management V10 CCS
 ;;DEKC^Dementia V10 CCS
 ;;DMKC^Diabetes Mellitus V10 CCS
 ;;HDKC^Hypertension V10 CCS
 ;;IDKC^Infectious Disease V10 CCS
 ;;MHKC^Mental Health V10 CCS
 ;;PNKC^Pain Management V10 CCS
 ;;PDKC^Pulmonary Disease V10 CCS
 ;;RHKC^Rehabilitation V10 CCS
 ;;SCKC^Spinal Cord Injured V10 CCS
 ;;WCKC^Wound Care V10 CCS
 ;;CDLC^Cardiac Disease V11 CCS
 ;;CGLC^Coagulation Management V11 CCS
 ;;DELC^Dementia V11 CCS
 ;;DMLC^Diabetes Mellitus V11 CCS
 ;;HDLC^Hypertension V11 CCS
 ;;IDLC^Infectious Disease V11 CCS
 ;;MHLC^Mental Health V11 CCS
 ;;PNLC^Pain Management V11 CCS
 ;;PDLC^Pulmonary Disease V11 CCS
 ;;RHLC^Rehabilitation V11 CCS
 ;;SCLC^Spinal Cord Injured V11 CCS
 ;;WCLC^Wound Care V11 CCS
 ;;CDMC^Cardiac Disease V12 CCS
 ;;CGMC^Coagulation Management V12 CCS
 ;;DEMC^Dementia V12 CCS
 ;;DMMC^Diabetes Mellitus V12 CCS
 ;;HDMC^Hypertension V12 CCS
 ;;IDMC^Infectious Disease V12 CCS
 ;;MHMC^Mental Health V12 CCS
 ;;PNMC^Pain Management V12 CCS
 ;;PDMC^Pulmonary Disease V12 CCS
 ;;RHMC^Rehabilitation V12 CCS
 ;;SCMC^Spinal Cord Injured V12 CCS
 ;;WCMC^Wound Care V12 CCS
 ;;CDNC^Cardiac Disease V23 CCS
 ;;CGNC^Coagulation Management V23 CCS
 ;;DENC^Dementia V23 CCS
 ;;DMNC^Diabetes Mellitus V23 CCS
 ;;HDNC^Hypertension V23 CCS
 ;;IDNC^Infectious Disease V23 CCS
 ;;MHNC^Mental Health V23 CCS
 ;;PNNC^Pain Management V23 CCS
 ;;PDNC^Pulmonary Disease V23 CCS
 ;;RHNC^Rehabilitation V23 CCS
 ;;SCNC^Spinal Cord Injured V23 CCS
 ;;WCNC^Wound Care V23 CCS
 ;;CDPC^Cardiac Disease V15 CCS
 ;;CGPC^Coagulation Management V15 CCS
 ;;DEPC^Dementia V15 CCS
 ;;DMPC^Diabetes Mellitus V15 CCS
 ;;HDPC^Hypertension V15 CCS
 ;;IDPC^Infectious Disease V15 CCS
 ;;MHPC^Mental Health V15 CCS
 ;;PNPC^Pain Management V15 CCS
 ;;PDPC^Pulmonary Disease V15 CCS
 ;;RHPC^Rehabilitation V15 CCS
 ;;SCPC^Spinal Cord Injured V15 CCS
 ;;WCPC^Wound Care V15 CCS
 ;;CDQC^Cardiac Disease V16 CCS
 ;;CGQC^Coagulation Management V16 CCS
 ;;DEQC^Dementia V16 CCS
 ;;DMQC^Diabetes Mellitus V16 CCS
 ;;HDQC^Hypertension V16 CCS
 ;;IDQC^Infectious Disease V16 CCS
 ;;MHQC^Mental Health V16 CCS
 ;;PNQC^Pain Management V16 CCS
 ;;PDQC^Pulmonary Disease V16 CCS
 ;;RHQC^Rehabilitation V16 CCS
 ;;SCQC^Spinal Cord Injured V16 CCS
 ;;WCQC^Wound Care V16 CCS
 ;;CDRC^Cardiac Disease V17 CCS
 ;;CGRC^Coagulation Management V17 CCS
 ;;DERC^Dementia V17 CCS
 ;;DMRC^Diabetes Mellitus V17 CCS
 ;;HDRC^Hypertension V17 CCS
 ;;IDRC^Infectious Disease V17 CCS
 ;;MHRC^Mental Health V17 CCS
 ;;PNRC^Pain Management V17 CCS
 ;;PDRC^Pulmonary Disease V17 CCS
 ;;RHRC^Rehabilitation V17 CCS
 ;;SNRC^Spinal Cord Injured V17 CCS
 ;;WCRC^Wound Care V17 CCS
 ;;CDSC^Cardiac Disease V18 CCS
 ;;CGSC^Coagulation Management V18 CCS
 ;;DESC^Dementia V18 CCS
 ;;DMSC^Diabetes Mellitus V18 CCS
 ;;HTSC^Hypertension V18 CCS
 ;;IDSC^Infectious Disease V18 CCS
 ;;MHSC^Mental Health V18 CCS
 ;;PNSC^Pain Management V18 CCS
 ;;PDSC^Pulmonary Disease V18 CCS
 ;;RHSC^Rehabilitation V18 CCS
 ;;SCSC^Spinal Cord Injured V18 CCS
 ;;WCSC^Wound Care V18 CCS
 ;;CDTC^Cardiac Disease V19 CCS
 ;;CGTC^Coagulation Management V19 CCS
 ;;DETC^Dementia V19 CCS
 ;;DMTC^Diabetes Mellitus V19 CCS
 ;;HTTC^Hypertension V19 CCS
 ;;IDTC^Infectious Disease V19 CCS
 ;;MHTC^Mental Health V19 CCS
 ;;PNTC^Pain Management V19 CCS
 ;;PDTC^Pulmonary Disease V19 CCS
 ;;RHTC^Rehabilitation V19 CCS
 ;;SCTC^Spinal Cord Injured V19 CCS
 ;;WCTC^Wound Care V19 CCS
 ;;CDUC^Cardiac Disease V20 CCS
 ;;CGUC^Coagulation Management V20 CCS
 ;;DEUC^Dementia V20 CCS
 ;;DMUC^Diabetes Mellitus V20 CCS
 ;;HTUC^Hypertension V20 CCS
 ;;IDUC^Infectious Disease V20 CCS
 ;;MHUC^Mental Health V20 CCS
 ;;PNUC^Pain Management V20 CCS
 ;;PDUC^Pulmonary Disease V20 CCS
 ;;RHUC^Rehabilitation V20 CCS
 ;;SCUC^Spinal Cord Injured V20 CCS
 ;;WCUC^Wound Care V20 CCS
 ;;CDVC^Cardiac Disease V21 CCS
 ;;CGVC^Coagulation Management V21 CCS
 ;;DEVC^Dementia V21 CCS
 ;;DMVC^Diabetes Mellitus V21 CCS
 ;;HTVC^Hypertension V21 CCS
 ;;IDVC^Infectious Disease V21 CCS
 ;;MHVC^Mental Health V21 CCS
 ;;PNVC^Pain Management V21 CCS
 ;;PDVC^Pulmonary Disease V21 CCS
 ;;RHVC^Rehabilitation V21 CCS
 ;;SNVC^Spinal Cord Injured V21 CCS
 ;;WCVC^Wound Care V21 CCS
 ;;CDWC^Cardiac Disease V22 CCS
 ;;CGWC^Coagulation Management V22 CCS
 ;;DEWC^Dementia V22 CCS
 ;;DMWC^Diabetes Mellitus V22 CCS
 ;;HTWC^Hypertension V22 CCS
 ;;IDWC^Infectious Disease V22 CCS
 ;;MHWC^Mental Health V22 CCS
 ;;PNWC^Pain Management V22 CCS
 ;;PDWC^Pulmonary Disease V22 CCS
 ;;RHWC^Rehabilitation V22 CCS
 ;;SCWC^Spinal Cord Injured V22 CCS
 ;;WCWC^Wound Care V22 CCS
 ;;QUIT
