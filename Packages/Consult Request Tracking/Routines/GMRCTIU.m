GMRCTIU ;SLC/DCM - Consults - TIU utilities ;2/26/02 11:46
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,12,18,15,17,22,27**;DEC 27, 1997
 ;
 ; This routine invokes IA #2427,#2638,#2832,#3161
 ;
GET(GMRCO,GMRCTUFN,GMRCTUST,GMRCAUTH) ;update Consult from TIU 
 ;GMRCO=IFN from file 123
 ;GMRCTUFN=TIU IFN
 ;GMRCTUST=TIU status of report
 ;GMRCAUTH=Author of Document
 N GMRCA,GMRCSTS,GMRCDFN,GMRCAD
 S GMRCA=$S($G(GMRCTUST)["INCOMPLETE":9,1:10),GMRCSTS=$S(GMRCA=10:2,1:9)
 I '+$G(GMRCA) S GMRCA=99,GMRCSTS=99
 D:+$G(GMRCA) STATUS^GMRCTIU1
 K GMRCOM,GMRCND,GMRCORNP,GMRCORTX,GMRCSA,GMRCSTS
 Q
 ;
DSPLAY(GMRCTUFN,LINECT) ;Get TIU results narrative and get it ready for display
 ;GMRCTUFN=TIU IEN of results record
 ;LINECT=line count for list manager
 N ND,GMRCARR
 D RPC^TIUSRV(.GMRCARR,GMRCTUFN)
 S ND=0
 F  S ND=$O(@GMRCARR@(ND)) Q:ND=""  S ^TMP("GMRCR",$J,"DT",LINECT,0)=@GMRCARR@(ND,0),LINECT=LINECT+1
 ;D CLEAN^VALM10
 K @GMRCARR,RESFL,GMRCTIUY
 S:LINECT>1 LINECT=LINECT-1
 Q
ENTER(GMRCO) ; Complete a consult with TIU note
 N XQADATA,XQA,XQAID,XQAROU,XQFLG,XQAKILL
 D ENTER^GMRCTIUE(GMRCO)
 Q
 ;
ADDEND(GMRCO) ; Make an addendum to a consult result
 N XQADATA,XQA,XQAID,XQAROU,XQFLG,XQAKILL
 D ADDEND^GMRCTIUE(GMRCO)
 Q
 ;
SEND(DFN,OVRRIDE,CP) ;Get consult list and return in ^TMP for TIU
 ;DFN=Patient's Internal file number from file 2
 ;OVRRIDE=BOOLEAN flag to override user validation
 ;CP=2 if only return entries that may have CP docs attached
 ;
 N GMRCI,TAB
 Q:DFN=""!(DFN<1)
 S TAB="",$P(TAB," ",30)=""
 K ^TMP("GMRCR",$J,"TIU")
 D GETCONSL(DFN,2,$G(OVRRIDE),$G(CP)) ;2=returns TIU format in ^TMP
 Q
 ;
RPCLIST(GMRCY,DFN) ;Get consult list and return in GMRCY for GUI
 N GMRCI
 I '+$G(DFN) S GMRCY(0)=0
 D GETCONSL(DFN,1) ;1=returns GUI format in GMRCY array
 ; The consults will be returned from GETCONSL in the GMRCY array.
 S GMRCY(0)=+$G(GMRCI)
 Q
GETCONSL(DFN,ORIGIN,OVRRIDE,GMRCCP) ;Get the patients consults
 ;ORIGIN is whether the request is for GUI=1 or LM=2.
 ;The logic loops through the "AD" cross-reference to find consults
 ;The output will be formatted in GMRCY for the GUI if ORIGIN is 1.
 ;The output will be formatted in ^TMP("GMRCR",$J,"TIU" if ORIGIN is 2.
 ;GMRCCP = 1 = return only CP entries that can have CP doc attached
 ;
 N GMRCQIT,GMRC,GMRCDA,GMRCDT,GMRCEDT,GMRCYR,GMRCSP,GMRCST,GMRCSTS
 N GMRCTIU,GMRCTIUC,GMRCSS,GMRCSVC,GMRCPROC,GMRCNOTE,Y,GMRCDAT,GMRCAU
 ;
 ; Aug 2000 - MA changed routine to use Parameter global to set the
 ; number of days to look backward when getting a list of consults.
 S GMRCYR=$$FMADD^XLFDT(DT,-$$GET^XPAR("ALL","GMRC CONSULT LIST DAYS"))
 S GMRCYR=9999999-GMRCYR,GMRCDAT=0
 F  S GMRCDAT=$O(^GMR(123,"AD",DFN,GMRCDAT)) Q:'GMRCDAT!(GMRCDAT>GMRCYR)  D
 . S GMRCDA=0
 . F  S GMRCDA=$O(^GMR(123,"AD",DFN,GMRCDAT,GMRCDA)) Q:'GMRCDA  D
 .. S GMRC(0)=$G(^GMR(123,GMRCDA,0))
 .. S GMRCST=$P(GMRC(0),U,12)
 .. I $P($G(^GMR(123,GMRCDA,12)),U,5)="P" Q  ;can't attach to IFC placer
 .. I "25689"'[GMRCST Q  ;only return statuses c,p,a,s,pr
 .. S GMRCDT=+GMRC(0)
 .. S GMRCSS=$P(GMRC(0),U,5)
 .. I '+$G(OVRRIDE) D  Q:'GMRCAU
 ... S GMRCAU=$$VALID^GMRCAU(GMRCSS,GMRCDA)
 ... I GMRCAU=3 S GMRCAU=0 ;exclude admin users
 .. I '$G(GMRCCP),+$G(^GMR(123,GMRCDA,1)) Q  ;no CP requests for CPRS
 .. I $G(GMRCCP),'+$G(^GMR(123,GMRCDA,1)) Q  ;only return CP requests 
 .. S GMRCTIUC=0
 .. D GETLIST^GMRCTIUL(GMRCDA,0,1,.GMRCTIUC)
 .. I ORIGIN=1 D BLDGMRCY Q
 .. I ORIGIN=2 D BLDTMP Q
 .. Q
 . Q
 Q
 ;
BLDGMRCY ;Build the GMRCY array of existing consults
 S GMRCSTS=$P($G(^ORD(100.01,+GMRCST,0)),"^",1)
 S GMRCSS=$P(GMRC(0),U,5),GMRCSVC=$P($G(^GMR(123.5,GMRCSS,0)),U)
 S GMRCPROC=$P($G(^GMR(123.3,+$P(GMRC(0),U,8),0)),U)
 S GMRCI=+$G(GMRCI)+1
 S GMRCY(GMRCI)=GMRCDA_U_GMRCDT_U_GMRCSVC_U_GMRCPROC_U_GMRCSTS_U_+GMRCTIUC(0)
 Q
BLDTMP ;Build TMP global for TIU
 S GMRCSTS=$G(^ORD(100.01,+GMRCST,.1))
 S GMRCSP=$$ORTX^GMRCAU(GMRCDA)
 S GMRCNOTE=$S(GMRCTIUC(0)=1:" note",1:" notes")
 S GMRCEDT=$$FMTE^XLFDT(GMRCDT,"D")
 S GMRCI=+$G(GMRCI)+1
 S ^TMP("GMRCR",$J,"TIU",GMRCI,0)=$J(GMRCI,3)_"> "_$E(GMRCEDT_TAB,1,12)_" C#"_$E(GMRCDA_TAB,1,9)_$E(GMRCSP_TAB,1,21)_$E(GMRCSTS_TAB,1,4)_$E(+GMRCTIUC(0)_GMRCNOTE_TAB,1,10)
 S ^TMP("GMRCR",$J,"TIU","B",GMRCI,GMRCDA)=""
 Q
ANYPENDG(DFN,USER) ; Determine if user can update any unresolved CSLTs
 ; Input:
 ;   DFN  = patient being worked on or the one to check from file 2
 ;   USER = the person to check on from file 200
 ;
 ; Output:
 ;   1 = yes there are unresolved consult that could be completed
 ;   0 = no unresolved consults that USER can update
 ;
 N GMRCYR,GMRCDAT,GMRCDONE,GMRCDA,GMRCST,GMRC,GMRCSS,GMRCDT,GMRCAU
 S GMRCYR=$$FMADD^XLFDT(DT,-$$GET^XPAR("ALL","GMRC CONSULT LIST DAYS"))
 S GMRCYR=9999999-GMRCYR,GMRCDAT=0,GMRCDONE=0
 F  S GMRCDAT=$O(^GMR(123,"AD",DFN,GMRCDAT)) Q:'GMRCDAT!(GMRCDAT>GMRCYR)!(GMRCDONE)  D
 . S GMRCDA=0
 . F  S GMRCDA=$O(^GMR(123,"AD",DFN,GMRCDAT,GMRCDA)) Q:'GMRCDA  D
 .. S GMRC(0)=$G(^GMR(123,GMRCDA,0))
 .. S GMRCST=$P(GMRC(0),U,12)
 .. I $P($G(^GMR(123,GMRCDA,12)),U,5)="P" Q  ;can't attach to IFC placer
 .. I +$G(^GMR(123,GMRCDA,1)) Q  ;can't complete CP's from NOTES tab
 .. I "568"'[GMRCST Q  ;only return statuses p,a,s
 .. S GMRCDT=+GMRC(0)
 .. S GMRCSS=$P(GMRC(0),U,5)
 .. D  Q:'GMRCAU
 ... S GMRCAU=$$VALID^GMRCAU(GMRCSS,GMRCDA)
 ... I GMRCAU=3 S GMRCAU=0 ;exclude admin users
 ... I GMRCAU S GMRCDONE=1
 Q GMRCDONE
 ;
