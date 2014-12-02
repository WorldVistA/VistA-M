ONC2PS01 ;Hines OIFO/RVD - Pre&Post-Install Routine for Patch ONC*2.2*1 ;07/1/13
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 ;
 N RC
 ;DC production server.
 S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1757/cgi_bin/oncsrv.exe")
 ;DC test server, comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1755/cgi_bin/oncsrv.exe")
 ;
 D C3E,CS,COC,LYM,METS,PR6,PR3,EXTCODE,CHEM,OSG,AJSGHLP,HIST,CONN,USS
 Q
 ;
CS ;check if the server is up. If down, instruct IRM to re-run CS conversion.
 S RC=$$CHKVER^ONCSAPIV() I RC'=0 D  Q  ;quit if server is down.
 .D BMES^XPDUTL("OncoTrax server is down...re-run the conversion in programmer mode, type D CS^ONC2PS01")
 ;
 W !!," Converting CS 0204 cases to 0205..."
 S IEN=0 F CNT=1:1 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  W:CNT#100=0 "." D
 .S DATEDX=$P($G(^ONCO(165.5,IEN,0)),U,16)
 .S CSDERIVED=$P($G(^ONCO(165.5,IEN,"CS1")),U,11)
 .I DATEDX>3031231 D
 ..I CSDERIVED="" S $P(^ONCO(165.5,IEN,"CS3"),U,2)="" Q
 ..I $P($G(^ONCO(165.5,IEN,"CS3")),U,2)=0 Q
 ..I $E(CSDERIVED,4)<5 D ^ONC2PS1A S $P(^ONCO(165.5,IEN,"EDITS"),U,2)=14
 K CNT,CSDERIVED,DATEDX,HIST,HIST14,IEN,SITE
 Q
COC ;add 'or persistence'
 N ONCDF
 S ONCDF=$P($G(^ONCO(165.3,12,0)),U,2)
 S:(ONCDF["w recurrence")&($L(ONCDF)<70) $P(^ONCO(165.3,12,0),U,2)=ONCDF_" or persistence"
 Q
 ;
LYM ;convert X to 8 or 9 for Lymphatic vessel invasion
 W !!," Converting Lymphatic Vessel Invasion 'BLANK' or 'X' to 8 or 9..."
 N IEN,ONCH,ONCHIST,ONCX
 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S ONCH=$$HIST^ONCFUNC(IEN),ONCHIST=$E(ONCH,1,4)
 .S ONCX=$P($G(^ONCO(165.5,IEN,2)),U,19)
 .I (ONCX="X")!(ONCX="") D
 ..I (ONCHIST>9589)&(ONCHIST<9993) S $P(^ONCO(165.5,IEN,2),U,19)=8
 ..E  S $P(^ONCO(165.5,IEN,2),U,19)=9
 Q
 ;
METS ;If METS AT DX (CS) (#165.5,34.3) equals "98" then the following
 ;four fields must be set to "8":
 ;   METS AT DX-BONE (#165.5,34.31), METS AT DX-BRAIN (#165.5,34.32)
 ;   METS AT DX-LIVER (#165.5,34.33) METS AT DX-LUNG (#165.5,34.34)
 D BMES^XPDUTL(" Converting METS AT DX-fields...")
 N IEN,ONCMDX
 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S ONCMDX=$P($G(^ONCO(165.5,IEN,"CS")),U,3) I ONCMDX'=98 Q
 .S $P(^ONCO(165.5,IEN,"CS1"),U,20)=8,$P(^ONCO(165.5,IEN,"CS1"),U,21)=8
 .S $P(^ONCO(165.5,IEN,"CS1"),U,22)=8,$P(^ONCO(165.5,IEN,"CS1"),U,23)=8
 Q
 ;
PRE1 ;environment check code, entry point of pre-init
 N ONCVER
 S ONCVER=$$VERSION^XPDUTL("ONC")
 I ONCVER<2.11 D BMES^XPDUTL("Your system must have Oncology v2.11 in order to continue with this installation!!!") S XPDABORT=1 Q
 ;clean-up file 160.16
 N ONCI
 K ^ONCO(160.16) ;delete old entries of file #160.16, to be replaced in p1.
 D BMES^XPDUTL("Done removing old entries in file #160.16")
VER ;update version number to 2.2 from 2.11
 S ONCI=159.999
 F  S ONCI=$O(^DD(ONCI)) Q:(ONCI>160.666)!(ONCI="")  S:$D(^DD(ONCI,0,"VR")) ^DD(ONCI,0,"VR")=2.2
 S ONCI=163.999
 F  S ONCI=$O(^DD(ONCI)) Q:(ONCI>169.999)!(ONCI="")  S:$D(^DD(ONCI,0,"VR")) ^DD(ONCI,0,"VR")=2.2
 S:$D(^DD(5.1,0,"VR")) ^DD(5.1,0,"VR")=2.2
 S:$D(^DD(5.11,0,"VR")) ^DD(5.11,0,"VR")=2.2
VER1 ;update oncology version status and Current Version
 N ONCII,ONCVRNM,ONCVRNO,ONCCVR,DA,DIE,DR
 I '$D(^ONCO(169.99,"B","ONCOLOGY V2.2")) D
 .S ONCII=$O(^ONCO(169.99,999999999),-1)
 .S ONCVRNO=$P($G(^ONCO(169.9,ONCII,0)),U,2)
 .S DIE="^ONCO(169.99,",DA=ONCII+1,ONCVRNM="ONCOLOGY V2.2"
 .S DR=".01///^S X=ONCVRNM;.02///2.2;1///2.11" D ^DIE
 D BMES^XPDUTL("Done setting version # to 2.2 in Oncology files!!!")
 ;update Current Version of the package file
 N ONCPAC,DA
 S DIE="^DIC(9.4,",DA=$O(^DIC(9.4,"B","ONCOLOGY",0)),DR="13///^S X=2.2" D ^DIE
 Q
 ;
PR6 ;process form for FOLLOWUP RATE REPORT
 N ONCIEN,VAL
 S ONCIEN=$O(^ONCO(160.2,"B","FOLLOWUP RATE REPORT",0))
 D BMES^XPDUTL("Updating file #160.2 for followup rate form...")
 I '$G(ONCIEN) D BMES^XPDUTL("No FOLLOWUP RATE REPORT form in your system, please inform your ONCOLOGY Dept...") Q
 F NNN=1:1 S VAL=$P($T(DAT6+NNN),";;",2) Q:VAL=""  S ^ONCO(160.2,ONCIEN,1,NNN,0)=VAL
 D BMES^XPDUTL("Done updating file #160.2 for FOLLOWUP RATE REPORT form!!!")
 Q
PR3 ;process form FOLLOWUP RATE REPORT 1
 N ONCIEN3,VAL
 S ONCIEN3=$O(^ONCO(160.2,"B","FOLLOWUP RATE REPORT 1",0))
 D BMES^XPDUTL("Updating file #160.2 for followup rate report 1 form...")
 I '$G(ONCIEN3) D BMES^XPDUTL("No FOLLOWUP RATE REPORT 1 form in your system, please inform your ONCOLOGY Dept...") Q
 F NNN=1:1 S VAL=$P($T(DAT3+NNN),";;",2) Q:VAL=""  S ^ONCO(160.2,ONCIEN3,1,NNN,0)=VAL
 D BMES^XPDUTL("Done updating file #160.2 for FOLLOWUP RATE REPORT 1 form!!!")
 Q
 ;
EXTCODE ;Correct the extension text for C69.5 in SEER CODE SET (#164.5) file
 ;Code 80 was set to "Adjacent Bone", should be "Further Contiguous Ext"
 S DA=81,DA(1)=173,DIE="^ONCO(164.5,"_DA(1)_",1,"
 S ONCNWTXT="Further contiguous extension",DR=".01///^S X=ONCNWTXT"
 D ^DIE
 K ONCNWTXT
 Q
 ;
CHEM ;Add 4 new & update 2 existing entries for CHEMO DRUGS (#164.18) file
 ;   Add these 4 entries: AXITINIB,PRALATREXATE,RUXOLITINIB,PAZOPANIB
 ;   Modify these 2 entries: RAD001, IMATINIB MESYLATE
 N ONCCMIEN,D0,DA,DD,DIC,X,Y K DD,DO
 D AXIN,PRAL,RUXO,PAZO,AFIN,DESA Q
 K ONCCMIEN Q
AXIN Q:$D(^ONCO(164.18,"B","AXITINIB"))
 S DIC="^ONCO(164.18,",DIC(0)="L",X="AXITINIB",DIC("DR")="1///013736"
 D FILE^DICN I Y=-1 Q
 S ONCCMIEN=+Y,DA(1)=ONCCMIEN,DIC="^ONCO(164.18,"_DA(1)_",1,",DIC(0)="L"
 F X="AG013736","INLYTA" D FILE^DICN
 Q
PRAL Q:$D(^ONCO(164.18,"B","PRALATREXATE"))
 S DIC="^ONCO(164.18,",DIC(0)="L",X="PRALATREXATE",DIC("DR")="1///488180"
 D FILE^DICN I Y=-1 Q
 S ONCCMIEN=+Y,DA(1)=ONCCMIEN,DIC="^ONCO(164.18,"_DA(1)_",1,",DIC(0)="L"
 F X="FOLOTYN" D FILE^DICN
 Q
RUXO Q:$D(^ONCO(164.18,"B","RUXOLITINIB"))
 S DIC="^ONCO(164.18,",DIC(0)="L",X="RUXOLITINIB",DIC("DR")="1///018424"
 D FILE^DICN
 Q
PAZO Q:$D(^ONCO(164.18,"B","PAZOPANIB"))
 S DIC="^ONCO(164.18,",DIC(0)="L",X="PAZOPANIB",DIC("DR")="1///444731"
 D FILE^DICN I Y=-1 Q
 S ONCCMIEN=+Y,DA(1)=ONCCMIEN,DIC="^ONCO(164.18,"_DA(1)_",1,",DIC(0)="L"
 F X="VOTRIENT" D FILE^DICN
 Q
AFIN S ONCCMIEN=$O(^ONCO(164.18,"B","RAD001","")) I ONCCMIEN="" Q
 S DA(1)=ONCCMIEN,DIC="^ONCO(164.18,"_DA(1)_",1,",DIC(0)="L"
 F X="AFINITOR","CERTICAN","EVEROLIMUS" D 
 .Q:$D(^ONCO(164.18,ONCCMIEN,1,"B",X))
 .D FILE^DICN
 Q
DESA S ONCCMIEN=$O(^ONCO(164.18,"B","IMATINIB MESYLATE","")) I ONCCMIEN="" Q
 Q:$D(^ONCO(164.18,ONCCMIEN,1,"B","DESATINIB"))
 S DA(1)=ONCCMIEN,DIC="^ONCO(164.18,"_DA(1)_",1,",DIC(0)="L"
 F X="DESATINIB" D FILE^DICN
 Q
 ;
OSG ;Add 2 new entries for OTHER STAGING GROUPS FOR ONCOLOGY (#164.3) file
 N ONCOSIEN,D0,DA,DD,DIC,X,Y K DD,DO
 D BCLC,MELD
 K ONCOSIEN Q
BCLC Q:$D(^ONCO(164.3,"B","BCLC"))
 S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC" D FILE^DICN I Y=-1 Q
 S ONCOSIEN=+Y,DA(1)=ONCOSIEN,DIC="^ONCO(164.3,"_DA(1)_",1,",DIC(0)="L"
 F X=20 D FILE^DICN
 Q
MELD Q:$D(^ONCO(164.3,"B","MELD"))
 S DIC="^ONCO(164.3,",DIC(0)="L",X="MELD" D FILE^DICN I Y=-1 Q
 S ONCOSIEN=+Y,DA(1)=ONCOSIEN,DIC="^ONCO(164.3,"_DA(1)_",1,",DIC(0)="L"
 F X=20 D FILE^DICN
 Q
 ;
AJSGHLP ;Correct typos in AJCC STAGING GROUPS (#164.33) 6TH EDITION (N) CODE
 ;  HELP (5 node) for BREAST (entry #23): O's should be 0's (zeroes)
 S ^ONCO(164.33,23,5,8,0)="N0(i+)   No regional lymph node metastasis histologically, positive IHC,"
 S ^ONCO(164.33,23,5,12,0)="N0(mol+) No regional lymph node metastasis histologically, positive"
 Q
HIST ;Edit names and synonyms of two Histology entries in Histology ICD-O-3
 ;file (169.3), entries 97511 and 97513
 S DIC="^ONCO(169.3,",X=97511 D ^DIC
 I Y'=-1 S DIE="^ONCO(169.3,",DA=+Y,DR=".01///LANGERHANS CELL HISTIOCYTOSIS, NOS (<2010 CASES)" D ^DIE
 S DIC="^ONCO(169.3,",X=97513 D ^DIC
 I Y'=-1 S ONCH3IEN=+Y,DIE="^ONCO(169.3,",DA=+Y,DR=".01///LANGERHANS CELL HISTIOCYTOSIS, NOS" D ^DIE
 I $D(^ONCO(169.3,ONCH3IEN,1,1,0)) K DA,DIC,DIE,DR,ONCH3IEN,Y Q
 S DA(1)=ONCH3IEN,DIC="^ONCO(169.3,"_DA(1)_",1,",DIC(0)="L"
 F X="LANGERHANS CELL GRANULOMATOSIS","HISTIOCYTOSIS X, NOS"  D FILE^DICN
 K DA,DIC,DIE,DR,ONCH3IEN,Y
 Q
 ;
CONN ;Change West Haven to Connecticut HCS
 ;Change NAME (160.19,.02) for WEST HAVEN VA MEDICAL CENTER to CONNECTICUT HCS
 S DIC="^ONCO(160.19,",X=6160765 D ^DIC
 I Y'=-1 S DIE="^ONCO(160.19,",DA=+Y,DR=".02///CONNECTICUT HCS" D ^DIE
 K DA,DIC,DIE,DR,Y
 Q
 ;
USS ;Add valid user for server updates
 S IEN=0
 N ONCMAIL,ONCJ,DA,DR,DIC,DIE
 S ONCMAIL("DORN")="rayeanne.dorn@domain.ext"
 S ONCMAIL("DAYON")="rufino.dayon@domain.ext"
 S ONCMAIL("KNOEPFLE")="rich.knoepfle@domain.ext"
 S ONCMAIL("WALLER")="kathleen.waller@domain.ext"
 S DIC(0)="L"
 F  S IEN=$O(^ONCO(160.1,IEN))  Q:IEN'>0  F ONCJ="DORN","DAYON","KNOEPFLE","WALLER" D
 .S DA(1)=IEN,(DIE,DIC)="^ONCO(160.1,DA(1),""SEU"","
 .I '$D(^ONCO(160.1,IEN,"SEU","B",ONCJ)) D
 ..S DIC("DR")="2///^S X=ONCMAIL(ONCJ)",X=ONCJ D FILE^DICN
 .I $D(^ONCO(160.1,IEN,"SEU","B",ONCJ)) D
 ..S DA=$O(^ONCO(160.1,IEN,"SEU","B",ONCJ,0))
 ..S DR="2///^S X=ONCMAIL(ONCJ)" D ^DIE
 Q
 ;
C3E ;3e SS1977
 N I55
 F I55=0:0 S I55=$O(^ONCO(165.5,I55)) Q:I55'>0  D
 .I ($P($G(^ONCO(165.5,I55,"CS3")),U,3)["3e SS1977")!($P($G(^ONCO(165.5,I55,"CS3")),U,3)["3d SS1977") D
 ..S $P(^ONCO(165.5,I55,"CS3"),U,2)=""
 ..S $P(^ONCO(165.5,I55,"CS3"),U,3)=""
 Q
 ;
DAT3 ;data for FOLLOWUP RATE REPORT
 ;;|SETTAB(68)|
 ;;|NOW|
 ;; FOLLOW-UP RATE FOR ALL PATIENTS (LIVING AND DEAD)      NUMBER   PERCENT
 ;; 
 ;;        Total patients from registry reference date    |TOTAL#||TAB|100%
 ;; 
 ;;    1.  Less benign/borderline cases                 - |BENIGN|
 ;;    2.  Less Carcinoma in situ cervix cases          - |CERVIX|
 ;;    3.  Less in situ/localized basal and squamous    - |LOCAL BASAL|
 ;;        cell carcinoma of skin cases     "
 ;;    4.  Less foreign residents                       - |FOREIGN|
 ;;    5.  Less non-analytic cases                      - |NONANALYTIC|
 ;;    6.  Less (ALL) Class of Case 00 case             - |CC|
 ;;    7.  Less (ALL) Patient Age 100+ case             - |P100|
 ;; 
 ;;         SUBTOTAL CASES = ANALYTIC CASES           (A) |ANALYTIC||TAB|100%
 ;;         Class of Case 10-22
 ;; 
 ;;    1.  Less number dead                           (B) |DEAD||TAB||%DEAD|%
 ;; 
 ;;         SUBTOTAL CASES (NUMBER LIVING)            (C) |LIVING||TAB||%LIVING|%
 ;; 
 ;;    1.  Less number current (known to be alive
 ;;        in the last 15 months)                     (D) |CURRENT||TAB||%CURRENT-TOTAL|%
 ;; 
 ;;         TOTAL (LOST TO FOLLOW UP OR NOT CURRENT)  (E) |LTF| *|TAB||%LTF-TOTAL|%
 ;;         (* should be less than 20%)
 ;; 
 ;;     Successful follow-up currency (all patients)  (F) |SFC| **|TAB||%SFC|
 ;;         (** should be 80%)
 ;;========================================================================
 ;; 
 ;;     FOLLOW UP RATE FOR LIVING PATIENTS ONLY          NUMBER     PERCENT
 ;; 
 ;;        Enter the total number from Line C          |LIVING||TAB|100%
 ;;        Subtract the total number from Line D     - |CURRENT||TAB||%CURRENT-ALIVE|%
 ;;        Total lost/not current of living patients - |LTF||TAB||%LTF-ALIVE|%
DAT6 ;data for FOLLOWUP RATE REPORT 1
 ;;|SETTAB(68)|
 ;;|NOW|
 ;; FOLLOW-UP RATE FOR ALL PATIENTS (LIVING AND DEAD)      NUMBER   PERCENT 
 ;; 
 ;;        Total patients diagnosed within last 5 years
 ;;        or from registry reference date, whichever is
 ;;        shorter                                        |TOTAL#||TAB|100%
 ;; 
 ;;    1.  Less benign/borderline cases                 - |BENIGN|
 ;;    2.  Less carcinoma in situ cervix cases          - |CERVIX| 
 ;;    3.  Less in situ/localized basal and squamous    - |LOCAL BASAL|
 ;;        cell carcinoma of skin cases              
 ;;    4.  Less foreign residents                       - |FOREIGN| 
 ;;    5.  Less non-analytic                            - |NONANALYTIC|
 ;;    6.  Less (ALL) Class of Case 00 case             - |CC|
 ;;    7.  Less (ALL) Patient Age 100+ case             - |P100|
 ;; 
 ;;         SUBTOTAL CASES = ANALYTIC CASES           (A) |ANALYTIC||TAB|100%
 ;;         Class of Case 10-22 
 ;; 
 ;;    1.  Less number dead                           (B) |DEAD||TAB||%DEAD|%
 ;; 
 ;;         SUBTOTAL CASES (NUMBER LIVING)            (C) |LIVING||TAB||%LIVING|%
 ;; 
 ;;    1.  Less number current (known to be alive 
 ;;        in the last 15 months)                     (D) |CURRENT||TAB||%CURRENT-TOTAL|%
 ;; 
 ;;         TOTAL (LOST TO FOLLOW UP OR NOT CURRENT)  (E) |LTF| *|TAB||%LTF-TOTAL|%
 ;; 
 ;;         (* should be less than 10%) 
 ;; 
 ;;     Successful follow-up currency (all patients)  (F) |SFC| **|TAB||%SFC|%
 ;;         (** should be 90%)
 ;;=========================================================================
 ;; 
 ;;     FOLLOW UP RATE FOR LIVING PATIENTS ONLY          NUMBER     PERCENT
 ;; 
 ;;        Enter the total number from Line C          |LIVING||TAB|100%
 ;;        Subtract the total number from Line D     - |CURRENT||TAB||%CURRENT-ALIVE|%
 ;;        Total lost/not current of living patients - |LTF||TAB||%LTF-ALIVE|%
