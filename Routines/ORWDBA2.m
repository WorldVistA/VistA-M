ORWDBA2 ; SLC/GDU - Billing Awareness - Phase I [11/26/04 15:43]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 ;Clinician's Personal Diagnoses List
 ;The personal diagnoses list is stored in the NEW PERSON file # 200.
 ;In file # 200 it is stored in the multi-valued field PERSONAL DIAGNOSIS
 ;LIST, field # 351, sub-file 200.0351. This is unique to the individual
 ;clinician. It is designed to aid the clinician with the CIDC process
 ;by providing a list of diagnoses codes most frequently used by that
 ;clinician.
 ;
 ;External References:
 ;  NOW^%DTC             DBIA 10000
 ;  FILE^DIE             DBIA 2053
 ;  UPDATE^DIE           DBIA 2053
 ;  DT^DILF              DBIA 2054
 ;  FDA^FILF             DBIA 2054
 ;  $$GET1^DIQ           DBIA 2056
 ;  GETS^DIQ             DBIA 2056
 ;  $$STATCHK^ICDAPIU    DBIA 3991
 ;  $$ICDDX^ICDCODE      DBIA 3990
 ;  $$NOW^XLFDT          DBIA 10103
 ;
ADDPDL(Y,ORCIEN,ORDXA) ;Add to Personal Diagnosis List
 ;Add a new personal diagnosis list or new ICD9 code to an existing
 ;personal diagnosis list for a clinician. It will filter out duplicate
 ;entries before updating an existing PDL.
 ;Input Variables:
 ;  ORCIEN       Clinician Internal Entry Number
 ;  ORDXA        Array of dx codes to be added to personal dx list
 ;               format: ORDXA(#)=ICD9_Code^Lexicon_Expression_IEN
 ;Output Variable:
 ;  Y            Return value, 1 successful, 0 unsuccessful
 ;Local Variables:
 ;  DXI          Diagnosis Array Index
 ;  DXIEN        Diagnosis Code Internal Entry Number
 ;  EM           Error Message
 ;  FDXR         Found Diagnoses Records Array
 ;  FDXRI        Found Diagnoses Records Array Index
 ;  IEN          Internal Entry Number
 ;  PDL          Personal Diagnoses List Array
 ;  PDLI         Personal Diagnoses List Array Index
 N DXI,DXIEN,EM,FDXR,FDXRI,IEN,PDL,PDLI
 ;Gets clinician's Personal Diagnosis List and removes duplicates from
 ;dx input array. Quits if all are duplicates.
 D GETS^DIQ(200,ORCIEN,"351*,","","PDL","EM")
 I $D(PDL) D
 . S DXI="" F  S DXI=$O(ORDXA(DXI)) Q:DXI=""  D
 .. S PDLI="" F  S PDLI=$O(PDL(200.0351,PDLI)) Q:PDLI=""  D
 ... I PDL(200.0351,PDLI,.01)=$P($G(ORDXA(DXI)),U) K ORDXA(DXI)
 I $D(ORDXA)=0 S Y=0 Q
 ;Process dx input array
 S DXI="" F  S DXI=$O(ORDXA(DXI)) Q:DXI=""!($D(EM))  D
 . K FDXR,EM
 . ;Get the IEN for the current diagnosis code
 . D FIND^DIC(80,"","","CM",$P(ORDXA(DXI),U),"*","","","","FDXR","EM")
 . I $P(FDXR("DILIST",0),U)=0 Q
 . I $P(FDXR("DILIST",0),U)=1 S DXIEN=FDXR("DILIST",2,1)
 . I $P(FDXR("DILIST",0),U)>1 D
 .. F FDXRI=1:1:FDXR("DILIST",0) D
 ... I FDXR("DILIST",1,FDXRI)=$P($G(ORDXA(DXI)),U) S DXIEN=FDXR("DILIST",2,FDXRI)
 . ;Add IDC9 code to personal diagnoses list
 . K IEN
 . S IEN="1,"_ORCIEN_",",IEN="+"_IEN
 . D FDA^DILF(200.0351,IEN,.01,"",DXIEN,"FDA","EM")
 . D UPDATE^DIE("","FDA","IEN","EM")
 . ;Add Lexicon Expression list
 . I $P(ORDXA(DXI),U,2)'="" D
 .. S IEN=IEN(1)_","_ORCIEN_","
 .. D FDA^DILF(200.0351,IEN,1,"",$P(ORDXA(DXI),U,2),"FDA","EM")
 .. D FILE^DIE("","FDA","EM")
 I $D(EM) S Y=0 Q
 S Y=1
 Q
 ;
DELPDL(Y,ORCIEN,ORDXA) ;Delete from Personal Diagnosis List
 ;Delete a selected diagnosis code or group of diagnoses codes from a
 ;Clinician's Personal DX List.
 ;Input Variables:
 ;  ORCIEN    Clinician Internal ID number
 ;  ORDXA     Array of dx codes to be deleted from personal dx list
 ;Output Variable:
 ;  Y         Return value, 1 successful, 0 unsuccessful
 ;Local Variables:
 ;  DXI       Diagnosis code array index
 ;  EM        Error Message
 ;  FDA       FileMan Data Array
 ;  IEN       Interanl Entry Number
 ;  RF        Record Found
 N DXI,EM,FDA,IEN,RF
 D GETS^DIQ(200,ORCIEN,"351*,","","RF","EM")
 I $D(RF)=0 S Y=0 Q
 S IEN="" F  S IEN=$O(RF(200.0351,IEN)) Q:IEN=""  D
 .S DXI="" F  S DXI=$O(ORDXA(DXI)) Q:DXI=""  D
 .. I RF(200.0351,IEN,.01)=ORDXA(DXI) D
 ... D FDA^DILF(200.0351,IEN,.01,"","@","FDA","EM")
 ... D FILE^DIE("","FDA","EM")
 S Y=1
 Q
 ;
GETPDL(Y,ORCIEN) ;Get Personal Diagnosis List
 ;This gets the clinician's personal diagnosis list. Using the personal
 ;diagnosis list, builds and returns an array variable with the ICD9
 ;codes and descriptions stored in the ICD DIAGNOSIS file, # 80.
 ;Flagging any inactive ICD9 code with a "#".
 ;Input Variable:
 ;  ORCIEN    Clinician Internal ID number
 ;Output Variable:
 ;  Y         Array of ICD9 codes and descriptions
 ;            Y(#)=ICD9_code^DX_description^DX_Inactive
 ;                 If inactive # in third piece
 ;                 If active null in third piece
 ;Local Variables:
 ;  DXC       Diagnosis Code (for sorting)
 ;  DXD       Diagnosis Description
 ;  DXDT      Diagnosis Date
 ;  DXI       Diagnosis Inactive Flag
 ;  EM        Error Message
 ;  ICD9      ICD9 code (for GUI)
 ;  IEN       Internal Entry Number
 ;  RF        Record Found
 N DXC,DXD,DXDT,DXI,EM,ICD9,IEN,RF
 S DXDT=$$NOW^XLFDT
 D GETS^DIQ(200,ORCIEN,"351*,","EI","RF","EM")
 I $D(RF) D
 . S (DXC,DXD,DXI,ICD9,IEN)=""
 . F  S IEN=$O(RF(200.0351,IEN)) Q:IEN=""  D
 .. S ICD9=RF(200.0351,IEN,.01,"E")
 .. S DXC=$$SETDXC(ICD9)
 .. I $G(RF(200.0351,IEN,1,"I"))="" S DXD=$$SETDXD($P($$ICDDX^ICDCODE(ICD9,DXDT),U,4))
 .. I $G(RF(200.0351,IEN,1,"I"))=1 S DXD=$$SETDXD($P($$ICDDX^ICDCODE(ICD9,DXDT),U,4))
 .. I $G(RF(200.0351,IEN,1,"I"))>1 S DXD=RF(200.0351,IEN,1,"E")
 .. S DXI=$$SETDXI($$STATCHK^ICDAPIU(ICD9,DXDT))
 .. S Y(DXC)=ICD9_U_DXD_U_DXI
 E  S Y=0
 Q
 ;  
GETDUDC(Y,ORCIEN,ORPTIEN) ;Get Day's Unique Diagnoses Codes
 ;Gets all the unique ICD9 codes for the orders placed today by the
 ;clinician for this patient. Using the ICD9 codes it builds an array
 ;variable with the ICD9 code, its description from the ICD DIAGNOSIS
 ;file, #80. Flagging any inactive ICD9 codes with a "#".
 ;Input Variables:
 ;  ORCIEN    Clinician's internal ID number
 ;  ORPTIEN   Patient's internal ID number
 ;Output Variable:
 ;  Y         Array of ICD9 codes and descriptions
 ;            Y(#)=ICD9_code^DX_Description^DX_Inactive
 ;                 If inactive # in third piece
 ;                 If active null in third piece
 ;Local Variables:
 ;  CKDATE    Check Date (stops loop)
 ;  DXC       Diagnosis Code (for sorting)
 ;  DXD       Diagnosis Description
 ;  DXI       Diagnosis Inactive Flag
 ;  DXIEN     Diagnosis Internal Entry Number
 ;  ICD9      ICD9 code (for GUI display)
 ;  IEN       Internal Entry Number
 ;  OBJORD    Object of Order
 ;  ORDATE    Order Date
 ;  ORDG      Order Group (ACT index variable)
 ;  OREM      Order Error Message
 ;  ORIEN     Order Internal Entry Number
 ;  ORRF      Order Record Found
 ;  RCODI     Reverse Cronological Order Date Index
 ;  SUBFILE   Subfile Number
 N CKDATE,DXC,DXD,DXEM,DXI,DXIEN,DXRF,ICD9,IEN,OBJORD,ORDATE,ORDG,OREM
 N ORIEN,ORRF,RCODI,SUBFILE
 S OBJORD=ORPTIEN_";DPT("
 S (DXIEN,ORDATE,ORDG,ORIEN,RCODI)="",CKDATE=$$F24HA
 F  S RCODI=$O(^OR(100,"ACT",OBJORD,RCODI)) S ORDATE=9999999-RCODI Q:ORDATE<CKDATE!(RCODI="")  D
 . F  S ORDG=$O(^OR(100,"ACT",OBJORD,RCODI,ORDG)) Q:ORDG=""  D
 .. S ORIEN=$QS($Q(^OR(100,"ACT",OBJORD,RCODI,ORDG)),6)
 .. K ORRF,OREM
 .. D GETS^DIQ(100,ORIEN,"1;5.1*","I","ORRF","OREM")
 .. S IEN=$QS($Q(ORRF(100)),2)
 .. Q:ORRF(100,IEN,1,"I")'=ORCIEN
 .. Q:$D(ORRF(100.051))=0
 .. S (DXC,DXD,DXI,DXIEN,ICD9,IEN)=""
 .. F  S IEN=$O(ORRF(100.051,IEN)) Q:IEN=""  D
 ... Q:ORRF(100.051,IEN,.01,"I")=""
 ... S DXIEN=ORRF(100.051,IEN,.01,"I")
 ... S ICD9=$$GET1^DIQ(80,DXIEN,.01,"")
 ... S DXC=$$SETDXC(ICD9)
 ... S DXD=$$SETDXD($P($$ICDDX^ICDCODE(ICD9,ORDATE),U,4))
 ... S DXI=$$SETDXI($$STATCHK^ICDAPIU(ICD9,ORDATE))
 ... S Y(DXC)=ICD9_U_DXD_U_DXI
 Q
 ;
SETDXC(X) ;Set diagnosis code variable for sorting 
 S X=$S($E(X)?1A:X,1:+X) Q X
 ;
SETDXD(X) ;Set upper case diagnosis discription to mixed case
 N X1,X2
 F X1=2:1:$L(X) D
 . I $E(X,X1)?1U,$E(X,X1-1)?1A D
 .. S X2=$E(X,X1)
 .. S X2=$C($A(X2)+32)
 .. S $E(X,X1)=X2
 Q X
 ;
SETDXI(X) ;Set the diagnosis inactive indicator
 S X=$S($P(X,U)=0:"#",1:"") Q X
 ;
CI(CNT) ;Counter Incrementer
 ; CNT - Counter
 S CNT=CNT+1 Q CNT
 ;
F24HA() ;Returns date and time from exactly 24 hours ago
 N %,%H,%I,X
 D NOW^%DTC
 Q %-1
 ;
ERRMSG(MT) ;Display Error Message
 ; to be determined
 Q
