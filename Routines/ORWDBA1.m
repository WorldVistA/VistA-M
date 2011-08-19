ORWDBA1 ;; SLC OIFO/DKK/GSS - Order Dialogs Billing Awareness;[10/21/03 3:16pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**190,195,229,215,243**;Dec 17, 1997;Build 242
 ;
 ; External References
 ;   DBIA    406  CL^SDCO21 - call to determine Treatment Factors
 ;
 ;Ref to ^DIC(9.4 - DBIA ___
 ;BA refers to Billing Awareness Project
 ;CIDC refers to Clinical Indicator Data Capture (same project 3/10/2004)
 ;Treatment Factors (TxF) refer to SC,AO,IR,EC,MST,HNC,CV,SHD
 ;
GETORDX(Y,ORIEN) ; Retrieve Diagnoses for an order - RPC
 ; Input:
 ;   ORIEN    Order Internal ID#
 ; Output:
 ;   Y        Array of Diagnoses (Dx) - Y(#)=#^DxInt#^ICD9^DxDesc^TxF
 ; Variables used:
 ;   CT       Counter for # of Dx related to order
 ;   DXIEN    Dx internal ID
 ;   DXN      Internal (to ^OR(100)) sequence # for Dx storage
 ;   DXREC    Dx record from Order file
 ;   DXV      Dx description
 ;   ICD9     External ICD9 #
 ;   TXFACTRS Treatment Factors (TxF)
 ;
 N CT,DXIEN,DXN,DXREC,DXV,ICD9,ICDR,ORFMDAT,TXFACTRS
 S (CT,DXN)=0
 I '$G(^OR(100,ORIEN,0)) S Y=-1
 I '$D(^OR(100,ORIEN,5.1,1,0)) S Y=0
 E  D  S Y=CT
 . ; Get order date for CSV/CTD/HIPAA usage
 . S ORFMDAT=$$ORFMDAT^ORWDBA3(ORIEN)
 . ; Go through all Dx's for an order
 . F  S DXN=$O(^OR(100,ORIEN,5.1,DXN)) Q:DXN'?1N.N  D
 .. ; Get diagnosis record and IEN
 .. S DXREC=$G(^OR(100,ORIEN,5.1,DXN,0)),DXIEN=$P(DXREC,U)
 .. S ICDR=$$ICDDX^ICDCODE($G(DXIEN),ORFMDAT)
 .. S DXV=$P(ICDR,U,4),ICD9=$P(ICDR,U,2)
 .. ; Convert internal to external Treatment Factors
 .. S TXFACTRS=$$TFGBLGUI(^OR(100,ORIEN,5.2))
 .. S CT=CT+1,Y(CT)=DXN_U_$G(DXIEN)_U_ICD9_U_DXV_U_TXFACTRS
 Q
 ;
SCLST(Y,DFN,ORLST) ; RPC for compiling appropriate TxF's
 ; RPC titled ORWDBA1 SCLST
 ;
 ;  Y       =    Returned value
 ;  DFN     =    Patient IEN
 ;  ORLST   =    List of orders
 ;
 ; call for BA/TF
 N GMRCPROS,ORD,ORI,ORPKG
 D CPLSTBA(.Y,DFN,.ORLST)
 Q
 ;
CPLSTBA(TEST,PTIFN,ORIFNS) ; set-up SC/TFs for BA
 ;
 ;  TEST    =  Returned value
 ;  PTIFN   =  Patient IEN
 ;  ORIFNS  =  List of orders
 ;
 S ORI=""
 ;
 ; define array of packages for which BA data collected (SC/CIs)
 ;  GMRC    =  Consult/Request Tracking (#128) - Prosthetics
 ;  LR      =  Lab Services (#26) - Lab
 ;  PSO     =  Outpt Pharmacy (#112) - Outpt Pharmacy (orig. Co-Pay)
 ;  RA      =  Radiology/Nuclear Medicine (#31) - Radiology
 ;
 S ORPKG(+$O(^DIC(9.4,"C","PSO",0)))=1
 ; See ISWITCH^ORWDBA7 for insurance/Ed switch, i.e., $$CIDC^IBBAPI
 ; Also check provider switch via 'OR BILLING AWARENESS BY USER'
 I $$BASTAT&$$CIDC^IBBAPI(DFN)&$$GET^XPAR(DUZ_";VA(200,","OR BILLING AWARENESS BY USER",1,"Q") F I=1:1 S ORPKG=$P("GMRC;LR;RA",";",I) Q:ORPKG=""  D
 . S ORPKG(+$O(^DIC(9.4,"C",ORPKG,0)))=1  ; ^DIC(9.4) is package file
 ;
 ; get Treatment Factors (TxF) for patient
 D SCPRE(.DR,DFN)
 ;
 ; set TxF's if order is for a package for which BA data is collected
 F  S ORI=$O(ORLST(ORI)) Q:'ORI  S ORD=+ORLST(ORI) D
 . I $G(^OR(100,ORD,0))="" Q
 . I $P($G(^OR(100,ORD,0)),U,14)="" Q
 . I $D(TEST(ORD))!'$D(ORPKG($P($G(^OR(100,ORD,0)),U,14))) Q
 . I $E($P(ORIFNS(ORI),";",2))>1 Q  ;canceled order (2) & ? (3)
 . S TEST(ORD)=ORLST(ORI)_DR
 Q
 ;
SCPRE(DR,DFN) ; Dialog validation, to ask BA questions
 ;
 ;  DR    =  return value
 ;  DFN   =  input patient IEN
 ;
 Q:$G(DFN)=""
 N CPNODE,CT,I,ORX,ORSDCARY,TF,X
 K ORSDCARY
 S (CPNODE,DR,ORX,TF)="",CT=0,X="T"
 ; Call API to acquire Treatment Factors in force
 D NOW^%DTC,CL^SDCO21(DFN,%,"",.ORSDCARY)  ;DBIA 406
 ; Retrved array order: AO,IR,SC,EC,MST,HNC,CV,SHD e.g., ORSDCARY(3) for SC
 ; Convert to ^OR/CPRS GUI order: SC,MST,AO,IR,EC,HNC,CV,SHD
 F I=3,5,1,2,4,6,7,8 S TF=0,CT=CT+1 S:$D(ORSDCARY(I)) TF=1 S $P(CPNODE,U,CT)=TF
 ;
 S X=$S($P(CPNODE,U)=1:"SC",1:""),DR=$S($L(X):DR_U_X,1:DR)
 S X=$S($P(CPNODE,U,2)=1:"MST",1:""),DR=$S($L(X):DR_U_X,1:DR)
 S X=$S($P(CPNODE,U,3)=1:"AO",1:""),DR=$S($L(X):DR_U_X,1:DR)
 S X=$S($P(CPNODE,U,4)=1:"IR",1:""),DR=$S($L(X):DR_U_X,1:DR)
 S X=$S($P(CPNODE,U,5)=1:"EC",1:""),DR=$S($L(X):DR_U_X,1:DR)
 S X=$S($P(CPNODE,U,6)=1:"HNC",1:""),DR=$S($L(X):DR_U_X,1:DR)
 S X=$S($P(CPNODE,U,7)=1:"CV",1:""),DR=$S($L(X):DR_U_X,1:DR)
 S X=$S($P(CPNODE,U,8)=1:"SHD",1:""),DR=$S($L(X):DR_U_X,1:DR)
 ;
 ; TxF's for patient (TxF's include SC,AO,IR,EC,MST,HNC,CV,SHD) where
 ;  SC      =  Service Connected
 ;  AO      =  Agent Orange
 ;  IR      =  Ionizing Radiation
 ;  EC      =  Environmental Contaminants
 ;  MST     =  Military Sexual Trauma
 ;  HNC     =  Head and Neck Cancer
 ;  CV      =  Combat Veteran
 ;  SHD     =  Shipboard Disability
 F I="SC","AO","IR","EC","MST","HNC","CV","SHD" D
 . I $D(ORX(I)) S DR=DR_U_I_$S($L(ORX(I)):";"_ORX(I),1:"")
 Q
 ;
ORPKGTYP(Y,ORLST) ; Build BA supported packages array
 ; GMRC=Prosthetics, LR=Lab, PSO=Pharmacy, RA=Radiology
 N OIREC,OIV,OIVN
 ;
 F I=1:1 S ORPKG=$P("GMRC;LR;PSO;RA",";",I) Q:ORPKG=""  D
 . S ORPKG(+$O(^DIC(9.4,"C",ORPKG,0)))=ORPKG  ; ^DIC(9.4) is package file
 ;
 S GMRCPROS=+$O(^DIC(9.4,"C","GMRC",0))
 ; see if order is for a package which BA supports
 D ORPKG1(.Y,.ORLST)
 Q
 ;
ORPKG1(TEST,ORIFNS) ; Order for package BA supports?  TEST(ORI)=1 is YES
 S U="^",ORI=""
 F I=1:1:5 S OIV(I)=$P("PROSTHETICS REQUEST^EYEGLASS REQUEST^CONTACT LENS REQUEST^HOME OXYGEN REQUEST^AMPUTEE/PROSTHETICS CLINIC",U,I)
 F  S ORI=$O(ORIFNS(ORI)) Q:'ORI  S ORD=+ORIFNS(ORI),TEST(ORI)=0 D
 . I ORD=0 Q  ;document/note not an order
 . ;I ORD="CONSULT_DX" S TEST(ORI)=1 Q  ;consult dx prev entered
 . I '$D(^OR(100,ORD,0)) Q  ;invalid order #
 . I $P(^OR(100,ORD,0),U,14)'?1N.N Q  ;invalid order # or entry
 . I $E($P(ORIFNS(ORI),";",2))>1 Q  ;canceled order (2) & ? (3)
 . I $D(^OR(100,ORD,5.1,1,0)) S TEST(ORI)=1 Q  ;
 . I '$D(ORPKG($P(^OR(100,ORD,0),U,14))) Q  ;pkg not supported
 . ;      IPt OPt (ask BA questions?)
 . ; Pros  Y   Y   GMRC
 . ; Rad   Y   Y   RA
 . ; Lab   N   Y   LR
 . ; Phrm  Y   Y   PSO
 . ; Pt Class = 'I' or 'O' in ^OR
 . I $P(^OR(100,ORD,0),U,12)="I"&(ORPKG($P(^OR(100,ORD,0),U,14))="LR") Q
 . I $P(^OR(100,ORD,0),U,14)=GMRCPROS D  Q  ;check for Pros consult order
 .. S OIREC=$G(^ORD(101.43,$G(^OR(100,ORD,4.5,1,1)),0)),OIVN=""
 .. F  S OIVN=$O(OIV(OIVN)) Q:OIVN=""  I OIV(OIVN)=$E($P(OIREC,U),1,$L(OIV(OIVN))) S TEST(ORI)=1 Q
 . S TEST(ORI)=1  ;order is for a supported pkg (also note Pros ck above)
 Q
 ;
BASTATUS(Y) ;RPC to retrieve the status of the Billing Awareness software
 ;   Y  =  Returned Value (1=BA usable, 0=BA not-usable)
 ; Check for installation of CIDC ancillary build
 S Y=$D(^XPD(9.7,"B","PX CLINICAL INDICATOR DATA CAPTURE 1.0"))
 Q:'Y
 ; Check if system parameter switch set
 S Y=$$CHKPS1^ORWDBA5
 Q
 ;
BASTAT() ; Internal version of BASTATUS
 ; Returns 0 if disabled or 1 if enabled
 Q $$CHKPS1^ORWDBA5
 ;
RCVORCI(Y,DIAG) ;Receive order related Clinical Indicators & Diagnoses from GUI
 ; Store data in ^OR(100,ODN,5.1) & ^OR(100,0DN,5.2)
 ;
 N DXIEN,ODN,ORIEN,SCI,OCDXCT,OCT
 S ODN="",OCDXCT=0,Y=""
 F  S ODN=$O(DIAG(ODN)) Q:ODN=""  D
 . S ORIEN=$P(DIAG(ODN),";",1)  ;Order IEN
 . I ORIEN'?1N.N S Y=0 Q
 . K ^OR(100,ORIEN,5.1) ;Clear currently stored diagnosis for rewrite
 . ; Data from Delphi format: ORIEN;11CNNNCNN^exDx1^exDx2^exDx3^exDx4
 . ; Convert 8 Tx Factors
 . S SCI=$$TFGUIGBL($RE($E($RE($P(DIAG(ODN),U)),1,8)))
 . S ^OR(100,ORIEN,5.2)=SCI  ;Store TFs (SC,MST,AO,IR,EC,HNC,CV,SHD)
 . ; Get order date for CSV/CTD/HIPAA
 . S ORFMDAT=$$ORFMDAT^ORWDBA3(ORIEN)
 . ; Go through the diagnoses entered
 . F OCT=2:1 Q:$P(DIAG(ODN),U,OCT)=""  D
 .. S DXIEN=$P($$ICDDX^ICDCODE($P(DIAG(ODN),U,OCT),ORFMDAT),U,1)  ;Dx IEN
 .. I DXIEN=-1!(DXIEN="") Q  ;No or invalid code passed in
 .. S OCDXCT=OCDXCT+1
 .. S ^OR(100,ORIEN,5.1,0)="^100.051PA^"_OCDXCT_U_OCDXCT ;Set 5.1 zero node
 .. S ^OR(100,ORIEN,5.1,OCDXCT,0)=DXIEN  ;Store a diagnosis for order
 .. S ^OR(100,ORIEN,5.1,"B",DXIEN,OCDXCT)="" ;Index diagnosis for order
 S:Y="" Y=1
 Q
 ;
TFSTGS ; Set Treatment Factor strings sequence order
 ; TFGBL is order of TxFs in ^OR(100,ORIEN,5) & ^OR(100,ORIEN,5.2)
 ; TFGUI is order of TxFs to/from GUI
 ; TFTBL is order of TxFs for table SD008 (used in ZCL segment)
 ; NOTE: change examples in TFGUIGBL and TFGBLGUI if order changed
 S TFGBL="SC^MST^AO^IR^EC^HNC^CV^SHD"
 S TFGUI="SC^AO^IR^EC^MST^HNC^CV^SHD"
 S TFTBL="AO^IR^SC^EC^MST^HNC^CV^SHD"
 Q
 ;
TFGUIGBL(GUI) ;Convert Treatment Factors from GUI to Global order & format
 ;
 ; Input:  GUI in CNU?NCU: C=checked, N=not checked, U=unchecked
 ; Output: GBL in 1^^^0^?^1^0^ (global) format (reordered for storage)
 ;
 N GBL,J,NTF,TF,TFGBL,TFGUI,TFTBL
 S GBL="",NTF=8  ;NTF=# of Treatment Factors (TxF)
 ;I $L(GUI)'=NTF Q -1  ;invalid # of TxF
 ; Get Treatment Factor sequence order strings
 D TFSTGS
 ; Convert from GBL to GUI format and sequence
 F J=1:1:NTF S TF=$E(GUI,J) D
 . S TF($P(TFGUI,U,J))=$S(TF="C":1,TF="U":0,TF="?":"?",1:"")
 F J=1:1:NTF S GBL=GBL_U_TF($P(TFGBL,U,J))
 Q $P(GBL,U,2,NTF+1)
 ;
TFGBLGUI(GBL) ;Convert Treatment Factors from Global to GUI order & format
 ;
 ; Input:  GBL in 1^0^1^1^^0^?^ (global) format
 ; Output: GUI in CCCNUU? (GUI) format (also reordered)
 ;
 N GUI,J,NTF,TF,TFGBL,TFGUI,TFTBL
 S GUI="",NTF=8  ;NCI=# of TxF
 ; Get Treatment Factor sequence order strings
 D TFSTGS
 ; Convert from GUI to GBL format and sequence
 F J=1:1:NTF S TF=$P(GBL,U,J) D
 . S TF($P(TFGBL,U,J))=$S(TF=1:"C",TF=0:"U",TF="?":"?",1:"N")
 F J=1:1:NTF S GUI=GUI_TF($P(TFGUI,U,J))
 Q GUI
 ;
PRVKEY(X) ;Check for active & provider key - to be deleted in CPRS v26
 N PTD
 Q:'+$G(X) 0
 Q:$G(^VA(200,X,0))="" 0
 S PTD=+$P(^VA(200,X,0),"^",11)
 I $$DT^XLFDT'<PTD,PTD>0 Q 0
 Q:$D(^XUSEC("PROVIDER",X)) 1
 Q 0
 ;
ORESKEY(X) ;Does 'X' hold ORES key, returns: 1=true, 0=false
 Q:'+$G(X) 0
 Q:$D(^XUSEC("ORES",X)) 1
 Q 0
