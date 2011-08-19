XUSNPIXU ;OAK_BP/DLS - NPI Extract Utilities ; 6/17/09
 ;;8.0;KERNEL;**438,453,528,548**; Jul 10, 1995;Build 24
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
 ; NPI Extract Functions and Utilities
 ; 
BCBSID ; This sub-routine is designed to create a string for each Blue Cross/Blue Shield Insurance Company,
 ; including the Ins Co name and an array of BCBS ID's (the ID's separated by a semi-colon sub-delimiter).
 ;
 ; Input Parameter - N/A
 ; 
 ; System Parameters
 ;       S     ==> ";"  (Semi-Colon Sub-Delimiter)
 ;       U     ==> "^"
 ; 
 ; Variables
 ;       INSCO   - Insurance Company IEN
 ;       INSTYP  - Insurance Company Type
 ;       INSNAM  - Insurance Company Name
 ;       INSHPR  - Hospital Provider Number
 ;       INSPPR  - Professional Provider Number
 ;       IBILP   - IB Insurance Co Level Billing Provider IEN
 ;       IBILF   - IB Insurance Co Level Billing Facility IEN
 ;       IBDFPID - Default BCBS Provider #
 ;       IBILPID - IB Insurance Co Level Billing Provider ID
 ;       IBILFID - IB Insurance Co Level Billing Facility ID
 ;       IDSTR   - Local BCBS ID String, placed into ^TMP when complete.
 ;
 K ^TMP("XUSNPIXU",$J)
 N INSCO,INSTYP,INSNAM,INSHPR,INSPPR,IBILP,IBILF,IBILPID,IBILFID,IDSTR,P,S
 ;
 S S=";"
 ;
 ; Loop through the Insurance Co file.
 S INSCO=0
 F  S INSCO=$O(^DIC(36,INSCO)) Q:'INSCO  D
 . S IDSTR=""
 . S INSTYP=$$GET1^DIQ(36,INSCO_",",.13)
 . ;
 . ; If the Insurance Co type is not Blue Cross or Blue Shield, QUIT and move on to the next one.
 . I '((INSTYP="BLUE CROSS")!(INSTYP="BLUE SHIELD")) Q
 . ;
 . ; Get Insurance Company Name. 
 . S INSNAM=$$GET1^DIQ(36,INSCO_",",.01)
 . ;
 . ; Get the IB Insurance Co Level Billing Prov ID's.
 . S IBILP=0
 . F  S IBILP=$O(^IBA(355.92,"B",INSCO,IBILP)) Q:'IBILP  D
 . . S IBILPID=$$GET1^DIQ(355.92,IBILP_",",.07)
 . . D ADDID(.IDSTR,IBILPID)
 . ;
 . ; Get the IB Insurance Co Level Billing Facility ID's.
 . S IBILF=0
 . F  S IBILF=$O(^IBA(355.91,"B",INSCO,IBILF)) Q:'IBILF  D
 . . S IBILFID=$$GET1^DIQ(355.91,IBILF_",",.07)
 . . D ADDID(.IDSTR,IBILFID)
 . ;
 . ; Remove trailing semi-colon and place local ID string into ^TMP.
 . I $E(IDSTR,$L(IDSTR))=";" S IDSTR=$E(IDSTR,1,$L(IDSTR)-1)
 . I IDSTR'="" S ^TMP("XUSNPIXU",$J,INSCO)=INSNAM_U_IDSTR
 Q
 ;
 ;
ADDID(IDSTRING,ID) ; Append BCBS ID to local ID string, using ";" as the sub-delimiter. Called from BCBSID
 ;
 ; Input Parameters
 ;       IDSTRING - Local variable ID string, passed from BCBSID
 ;       ID       - ID to be appended to IDSTRING, passed from BCBSID
 ;               
 I '$D(ID)!('$D(IDSTRING)) Q
 I ID'="",IDSTRING'[ID S IDSTRING=IDSTRING_ID_S
 Q
 ;
PRACID(NPIEN,INS) ; Get Practitioner IDs
 ;
 ; Output Parameter
 ;               INS - Array-Passed by Reference
 N BIEN,PRAC,A,A1,A2
 K INS
 S BIEN=NPIEN_";VA(200,"
 S PRAC=""
 F  S PRAC=$O(^IBA(355.9,"B",BIEN,PRAC)) Q:'PRAC  D
 . S A=$$BCBSTR(PRAC) I A="" Q  ;P 528
 . S A1=$P(A,"^"),A2=$P(A,"^",2) I A1="" Q  ;add p 528
 . I $D(INS(A1)) S INS(A1_" ")=A2 Q  ;add p 528
 . S INS(A1)=A2  ;add p 528
 Q
 ;
NNVAID(NPIEN,INS) ; Get Non-VA Provider IDS
 ;
 ; Output Parameter
 ;               INS - Array-Passed by Reference             
 N BIEN,PRAC,A,A1,A2
 K INS
 S BIEN=NPIEN_";IBA(355.93,"
 S PRAC=""
 F  S PRAC=$O(^IBA(355.9,"B",BIEN,PRAC)) Q:'PRAC  D
 . S A=$$BCBSTR(PRAC) I A="" Q  ;p 528
 . S A1=$P(A,"^"),A2=$P(A,"^",2) I A1="" Q  ;add p 528
 . I $D(INS(A1)) S INS(A1_" ")=A2 Q  ;add p 528
 . S INS(A1)=A2  ;add p 528
 Q
 ;
INSTID(INSARRAY) ; Get Institution IDs
 ;
 ; Output Parameter
 ;               INSARRAY - Array-Passed by Reference          
 N INS,A
 K INSARRAY
 S INS=0
 ; 12/13/2007 DLS - Change array structure from INSARRAY(A)="" to INSARRAY($P(A,U,1))=$P(A,U,2)
 F  S INS=$O(^TMP("XUSNPIXU",$J,INS)) Q:INS=""  D
 . S A=$G(^TMP("XUSNPIXU",$J,INS))
 . I A'="" S INSARRAY($P(A,U,1))=$P(A,U,2)
 Q
 ;
 ;
BCBSTR(PRACIEN) ; Receive an IB Billing Practitioner Provider IEN and return the string of ID's already created.
 ;
 ; Input Parameters
 ;       PRACIEN - Practitioner Ins. Co. file IEN - Linked to Provider and passed from NPI Extract.
 ;       
 ; System Parameters
 ;               S ==> ";"  (Semi-Colon Sub-Delimiter)
 ; Variables
 ;       INSCO  - Insurance Company IEN
 ;       PRVID  - Provider ID for the specific Insurance Company. This is added on to the ID string stored in TMP. 
 ;
 ; Get the Ins Co IEN
 N INSCO,PRVID,P,S
 S S=";"
 S INSCO=$$GET1^DIQ(355.9,PRACIEN_",",.02,"I")
 ;
 ; Quit if this is NOT a Blue Cross/Blue Shield Insurance Company.
 I $G(^TMP("XUSNPIXU",$J,+INSCO))="" Q ""
 ;
 ; Get the Practitioner ID for this specific Insurance Company. (commented out for now)
 S PRVID=$$GET1^DIQ(355.9,PRACIEN_",",.07)
 ;
 ;  If PRVID is NOT null AND the ID is NOT already in the string AND
 ; (If the string DOES NOT end with a "^", return the ID string with the sub-delimiter and PRVID appended) OR
 ; (If the string DOES     end with a "^", return the ID string with only PRVID appended.)
 I PRVID'="",((^TMP("XUSNPIXU",$J,INSCO)'["^PRVID;")!(^TMP("XUSNPIXU",$J,INSCO)'[";PRVID;")) D  Q ^TMP("XUSNPIXU",$J,INSCO)_PRVID
 . I $E($L(^TMP("XUSNPIXU",$J,INSCO)))'=U S PRVID=S_PRVID
 . Q
 ;
 ; If nothing needs changing, return the string unchanged.
 Q ^TMP("XUSNPIXU",$J,INSCO)
 ;
INIT ;Initialize ^XTMP
 K ^XTMP("XUSNPIX1")
 K ^XTMP("XUSNPIX2")
 K ^XTMP("XUSNPIX1NV")
 K ^XTMP("XUSNPIX2NV")
 K ^XTMP("XUSNPIXT")
 Q
 ;
P2PBASE(XUSTMP) ;
 N XUSNP2P,IBSIEN,ZN19,P2PVAL,XUSDEF
 S XUSNP2P=0
 F  S XUSNP2P=$O(^IBE(350.9,1,19,"B",XUSNP2P)) Q:XUSNP2P=""  D
 . S IBSIEN=$O(^IBE(350.9,1,19,"B",XUSNP2P,""))
 . S ZN19=^IBE(350.9,1,19,IBSIEN,0),P2PVAL=$P(ZN19,U,5)
 . I P2PVAL S XUSTMP("P2P",XUSNP2P)=P2PVAL
 . E  S XUSTMP("P2P",XUSNP2P)=IBSIEN
 S XUSDEF=$P($G(^IBE(350.9,1,11)),U,3)
 I XUSDEF="" G P2PBASEX
 I '$D(^IBE(350.9,1,19,XUSDEF)) S XUSDEF=""
P2PBASEX ;
 I XUSDEF'="" S XUSTMP("P2P","DEFAULT")=XUSDEF
 Q
 ;
P2PEXP(IEN,XUSPT) ;
 N IBE35090,IBE35091,P2PVAL,I
 S IBE35090=$G(^IBE(350.9,1,19,IEN,0))
 F I=1:1:6 S XUSPT(I)=""
 I IBE35090]"" S XUSPT(1)=$P(IBE35090,U,2)
 S IBE35091=$G(^IBE(350.9,1,19,IEN,1))
 I IBE35091]"" D
 . S XUSPT(2)=$P(IBE35091,U,1)
 . S XUSPT(3)=$P(IBE35091,U,2)
 . S XUSPT(4)=$P(IBE35091,U,3)
 . S XUSPT(5)=$P(IBE35091,U,4)
 . I XUSPT(5)?1N.N S XUSPT(5)=$P($G(^DIC(5,XUSPT(5),0)),U,2)
 . S XUSPT(6)=$P(IBE35091,U,5)
 Q XUSPT(1)_U_XUSPT(2)_U_XUSPT(3)_U_XUSPT(4)_U_XUSPT(5)_U_XUSPT(6)
