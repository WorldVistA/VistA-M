GMVUTL8 ;HIOFO/DS,FT-RPC API TO RETURN ALL VITALS/CATEGORIES/QUALIFIERS ;3/31/05  13:34
 ;;5.0;GEN. MED. REC. - VITALS;**1,3**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;  #2263 - ^XPAR calls            (Supported)
 ;  #3227 - ^NURAPI calls          (private)
 ;
 ; This routine supports the following IAs:
 ; #4653 - QUALIFRS & SUPO2 entry points     (private)
 ; #4420 - GMV DLL VERSION is called at DLL  (private)
 ; #4354 - GMV GET CATEGORY IEN is called at CATEGORY  (private)
 ; #4357 - GMV GET VITAL TYPE IEN is called at TYPE  (private)
 ;
APTLIST(ARRAY,LOC) ; Returns a list of active patients for a nursing
 ; location in the array specified. [RPC entry point]
 ;  input:   LOC - (Required) NURS LOCATION file (#211.4) ien
 ;  input: ARRAY - (Required) Name of the array to return entries in
 ; output: ARRAY - Subscripted by sequential number with DFN in first
 ;                 piece and patient name in second piece.
 ;         example: ARRAY(#)=DFN^patient name^SSN^DOB^SEX AND AGE
 ;                  ^ATTENDING^VETERAN^INTERNAL DATE/TIME DECEASED
 ;                  ^EXTERNAL DATE/TIME DECEASED
 ;
 I $G(LOC)="" S ARRAY(1)=-1
 N DFN,GMVARRAY,GMVCNT,GMVPAT,PATNAME
 D APTLIST^NURAPI(LOC,.GMVARRAY)
 I $G(GMVARRAY(1))'>0 S ARRAY(1)=-1 Q
 S GMVCNT=0
 F  S GMVCNT=$O(GMVARRAY(GMVCNT)) Q:'GMVCNT  D
 .S DFN=$P(GMVARRAY(GMVCNT),U,1)
 .Q:'DFN
 .S PATNAME=$P(GMVARRAY(GMVCNT),U,2)
 .D PTINFO^GMVUTL3(.GMVPAT,DFN)
 .S ARRAY(GMVCNT)=DFN_U_PATNAME_U_GMVPAT
 .Q
 Q
TYPE(RESULT,GMVTYPE) ;GMV GET VITAL TYPE IEN [RPC entry point]
 ; Input:
 ;   RESULT = variable name to hold result
 ;  GMVTYPE = Name of Vital Type (from FILE 120.51) (e.g., WEIGHT)
 ; Output: Returns the IEN if GMVTYPE exists in FILE 120.51
 ;         else returns -1
 ;
 I GMVTYPE="" S RESULT=-1 Q
 S RESULT=+$O(^GMRD(120.51,"B",GMVTYPE,0))
 Q
CATEGORY(RESULT,GMVCAT) ;GMV GET CATEGORY IEN [RPC entry point]
 ; Input
 ;  RESULT = variable name to hold result
 ;  GMVCAT = Name of Category (from FILE 120.53) (e.g., METHOD)
 ; Output: Returns the IEN if GMVTYPE exists in FILE 120.53
 ;         else returns -1
 I GMVCAT="" S RESULT=-1 Q
 S RESULT=+$O(^GMRD(120.53,"B",GMVCAT,0))
 Q
QUALIFER(RESULT,GMVQUAL) ;Return IEN of Qualifier name
 ; Input:
 ;   RESULT = variable name to hold result
 ;  GMVQUAL = Name of Qualifier (from FILE 120.52) (e.g., ORAL)
 ; Output: Returns the IEN if GMVQUAL exists in FILE 120.52
 ;         else returns -1
 ;
 I GMVQUAL="" S RESULT=-1 Q
 S RESULT=+$O(^GMRD(120.52,"B",GMVQUAL,0))
 Q
VITALIEN() ;Returns the Vital Type IENS in a list separated by commas.
 ; ex: ",8,9,21,20,5,3,22,1,2,19,"
 ;
 N GMVABB,GMVIEN,GMVLIST
 S GMVLIST=""
 F GMVABB="BP","T","R","P","HT","WT","CVP","CG","PO2","PN" D
 .S GMVIEN=$O(^GMRD(120.51,"C",GMVABB,0))
 .Q:'GMVIEN
 .S GMVLIST=GMVLIST_","_GMVIEN
 .Q
 I $L(GMVLIST)'="," S GMVLIST=GMVLIST_","
 Q GMVLIST
 ;
QUALIFRS(VIEN) ;Function to return vitals qualifiers text
 ; VIEN is the FILE 120.5 IEN
 ; Returns the qualifiers in a string of text
 ; e.g., Actual,Standing
 ;
 N QUALS,VQIEN,QNAME
 S QUALS=""
 I 'VIEN Q QUALS
 S VQIEN=0
 F  S VQIEN=$O(^GMR(120.5,VIEN,5,"B",VQIEN)) Q:'VQIEN  D
 .S QNAME=$P($G(^GMRD(120.52,+VQIEN,0)),U,1)
 .I QNAME]"" S QUALS=QUALS_QNAME_","
 .Q
 I $L(QUALS)>0 S QUALS=$E(QUALS,1,$L(QUALS)-1)
 Q QUALS
SUPO2(VIEN) ;Function to return the Supplemental O2 value
 ; VIEN is the FILE 120.5 IEN
 ; Returns the Supplemental O2 value (#1.4)
 ; e.g., 2.0 l/min 90%
 ;
 S VIEN=+$G(VIEN)
 Q $P($G(^GMR(120.5,VIEN,0)),U,10)
 ;
DLL(RESULT,GMVX) ; Entry for [GMV DLL VERSION] RPC. Returns DLL version check
 ; RESULT = variable name to return check
 ;   GMVX = dll name and version date/time
 ; Returns yes or no  
 S RESULT=$$GET^XPAR("SYS","GMV DLL VERSION",GMVX,"E")
 S:RESULT="" RESULT="NO"
 Q
 ;
