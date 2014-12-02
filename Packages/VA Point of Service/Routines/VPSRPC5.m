VPSRPC5 ;DALOI/KML - Utilities ;4/26/2012
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**2**;Oct 21, 2011;Build 41
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
GETSITES(RETURN,VPSSN) ;  CSW this is the new routine replacing the original
 ; Input:
 ; RETURN - passed in by reference; return value populated with the listof site ids visited by PATIENT (DFN)
 ; VPSSN - patient SSN
 ; Output:
 ; RETURN - array of site IDs obtained from the TREATING FACILITY LIST file (391.91).
 K RETURN,VPSDFN
 I '+$G(VPSSN) S RETURN(1)="99^PATIENT SSN not sent" Q
 D GETDFN(.VPSDFN,VPSSN)
 I $P(VPSDFN,U)=99 S RETURN=VPSDFN Q
 S VPSDFN=$P(VPSDFN,U,2)
 N VPSIEN,VPSCNT,VPSID,VPSNM
 D TFL^VAFCTFU1(.RETURN,VPSDFN)  ;IA2990 (supported)
 I $D(RETURN),$P(RETURN(1),"^")'>0 S RETURN(1)="99^Patient has not been treated at any other site" Q
 Q
 ;
GETDFN(RETURN,VPSSN) ;
 ;Input:
 ; RETURN - passed in by reference; return value populated with associated patient DFN
 ; VPSSN - patient social security number
 ; Output:
 ; RETURN - success - "1^_DFN
 ;          exception - "99^"_exception text
 ;
 ; External Reference IA#
 ; ------------------------
 ;#10035 - ^DPT( reference      (Supported)
 ;
 K RETURN
 N VPSDFN
 I $G(VPSSN)="" S RETURN="99^SSN NOT SENT." Q
 S VPSSN=$TR(VPSSN,"- ")
 I +$G(VPSSN)'>0 S RETURN="99^SSN SHOULD BE NUMERIC: "_VPSSN Q
 S VPSDFN=$O(^DPT("SSN",VPSSN,0))
 I +$G(VPSDFN)'>0 S RETURN="99^NO PATIENT FOUND WITH SSN: "_VPSSN Q
 S RETURN="1^"_VPSDFN
 Q
 ;
LAST5(LST,VPSID) ; Return a list of patients matching A9999 identifiers
 N I,IEN,XREF
 S (I,IEN)=0,XREF=$S($L(VPSID)=5:"BS5",1:"BS")
 F  S IEN=$O(^DPT(XREF,VPSID,IEN)) Q:'IEN  D
 . S I=I+1,LST(I)=IEN_U_$P(^DPT(IEN,0),U)_U_$$DOB^DPTLK1(IEN,2)_U_$$SSN^DPTLK1(IEN)  ; DG249,ICR5839
 Q
FULLSSN(LST,VPSID) ; Return a list of patients matching full SSN entered
 N I,IEN
 S (I,IEN)=0
 F  S IEN=$O(^DPT("SSN",VPSID,IEN)) Q:'IEN  D
 . S I=I+1,LST(I)=IEN_U_$P(^DPT(IEN,0),U)_U_$$DOB^DPTLK1(IEN,2)_U_$$SSN^DPTLK1(IEN)  ; DG249,ICR5839
 Q
 ;
LISTALL(Y,FROM,DIR) ; Return a bolus of patient names. From is either Name or IEN^Name.
 N I,IEN,CNT,FROMIEN,ORIDNAME S CNT=50,I=0,FROMIEN=0
 I $P(FROM,U,2)'="" S FROMIEN=$P(FROM,U,1),FROM=$O(^DPT("B",$P(FROM,U,2)),-DIR)
 F  S FROM=$O(^DPT("B",FROM),DIR) Q:FROM=""  D  Q:I=CNT
 . S IEN=FROMIEN,FROMIEN=0 F  S IEN=$O(^DPT("B",FROM,IEN)) Q:'IEN  D  Q:I=CNT
 . . S ORIDNAME=""
 . . S ORIDNAME=$G(^DPT(IEN,0)) ; Get zero node name.
 . . ; S X1=$G(^DPT(IEN,.1))_" "_$G(^DPT(IEN,.101))
 . . S I=I+1 S Y(I)=IEN_U_FROM_U_U_U_U_$P(ORIDNAME,U) ;_"^"_X ; _"^"_X1 ;" ("_X_")"
 Q
