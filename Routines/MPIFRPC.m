MPIFRPC ;SFCIO/CMC-MPIF RPC APIS ;26 JUN 01
 ;;1.0; MASTER PATIENT INDEX VISTA ;**20**;30 Apr 99
 ;
 ;Integration Agreements Utilized:
 ;  ^DPT( - #2070
 ;  AVAFC^VAFCDD01 - #3493
 ;  GETEX^RGEX03 - #3554
 ;  NOTICE^DGSEC4 - #3027
 ;  PTSEC^DGSEC4 - #3027
 ;
ICNSTAT(RETURN,ICN,SSN,RPC) ;
 ;RPC to return status of ICN passed or if SSN is passed find ICN and return status including ICN, ICN History, CMOR History, Exceptions pending
 ; RETURN - array to return ICN data
 ; ICN - ICN for the patient in the Patient (#2) file data is to be returned on
 ; SSN - social security number for the patient in the Patient (#2) file data is to be returned on
 ; RPC - 0 or 1 to denote if the call is being made from a RPC or called locally. 1=RPC remote call 0=locally called - 1 is default
 ;
 N PICN,CNTD,DFN,TICN,LOCAL,XX,RETS,TEXT,CMOR,ICNH,CMORH
 I $G(RPC)="" S RPC=1
 I $G(ICN)=""&($G(SSN)="") S RETURN="-1^NO ICN OR SSN PASSED" Q
 I $G(SSN)'="" S ICN=$$GETICNS^MPIF002(SSN),RETURN(1,"SSN USED")="MPI(""SSN USED"")="_""""_SSN_"""" ; possible to have multiple entries with same SSN
 S PICN=ICN,CNTD=0,TEXT=""
 F XX=1:1 S ICN=$P(PICN,"^",XX) Q:ICN=""  D
 .S DFN=$$GETDFN^MPIF001(+ICN),CNTD=CNTD+1
 .I +DFN=-1 S RETURN(XX)="-1^NO SUCH ICN "_ICN Q
 .I '$D(^DPT(DFN)) S RETURN(DFN)="-1^BAD AICN X-REF, PT FILE ENTRY DOESN'T EXIST DFN= "_DFN_" ICN= "_ICN Q
 .; check if this data can be returned and if sensative pt bulletin needed
 .N SENS D PTSEC^DGSEC4(.SENS,DFN,1,"Remote Procedure from MPI^RPC from MPI for ICN Information")
 .N NOT D NOTICE^DGSEC4(.NOT,DFN,"Remote Procedure from MPI^RPC from MPI for ICN Information")
 .I SENS(1)=3!(SENS(1)=4)!(SENS(1)=-1) S RETURN(XX)="-1^SENSATIVE PT ISSUE "_SENS(2)_" DFN= "_DFN_" ICN= "_ICN Q
 .I RPC=1 S TEXT="MPI("_DFN_",""DFN"")="
 .S RETURN(DFN,"DFN")=TEXT_""""_DFN_""""
 .S TICN=$$GETICN^MPIF001(DFN)
 .I +TICN<0 D
 ..I RPC=1 S RETURN(DFN,1)="MPI("_DFN_",1)="_""""_"No current ICN"
 ..I RPC=0 S RETURN(DFN,1)="""No Current ICN"
 .I +TICN>0 D
 ..I RPC=1 S RETURN(DFN,"ICN")="MPI("_DFN_",""ICN"")="_""""_TICN_""""
 ..I RPC=0 S RETURN(DFN,"ICN")=""""_TICN_""""
 .S LOCAL=""
 .I $E($G(RETURN(DFN,"ICN")),1,3)=$P($$SITE^VASITE(),"^",3) S LOCAL="Y"
 .I LOCAL=""&(+TICN>0) D
 ..I RPC=1 S RETURN(DFN,1)="MPI("_DFN_",1)="_""""_"NATIONAL ICN"
 ..I RPC=0 S RETURN(DFN,1)=""""_"NATIONAL ICN"
 .I LOCAL="Y"&(+TICN>0) D
 ..I RPC=1 S RETURN(DFN,1)="MPI("_DFN_",1)="_""""_"LOCAL ICN"
 ..I RPC=0 S RETURN(DFN,1)=""""_"LOCAL ICN"_""""
 .S CMOR=$$GETVCCI^MPIF001(DFN)
 .I +CMOR=-1 S CMOR=$P(CMOR,"^",2)
 .I RPC=1 S RETURN(DFN,"CMOR")="MPI("_DFN_",""CMOR"")="""_CMOR_""""
 .I RPC=0 S RETURN(DFN,"CMOR")=""""_CMOR_""""
 .D GETICNH^MPIF002(DFN,.ICNH)
 .I +ICNH=-1 D
 ..I RPC=1 S RETURN(DFN,"ICN HISTORY")="MPI("_DFN_",""ICN HISTORY"")="""_$P(ICNH,"^",2)_""""
 ..I RPC=0 S RETURN(DFN,"ICN HISTORY")=""""_$P(ICNH,"^",2)_""""
 .I +ICNH'=-1 D
 ..M RETURN(DFN,"ICN HISTORY")=ICNH
 ..I RPC=1 D
 ...N IEN
 ...S IEN="" F  S IEN=$O(RETURN(DFN,"ICN HISTORY",IEN)) Q:IEN=""  S RETURN(DFN,"ICN HISTORY",IEN)="MPI("_DFN_",""ICN HISTORY"","_IEN_")="_$G(RETURN(DFN,"ICN HISTORY",IEN))
 ...S RETURN(DFN,"ICN HISTORY")="MPI("_DFN_",""ICN HISTORY"")="_$G(RETURN(DFN,"ICN HISTORY"))
 .;
 .D GETCMORH^MPIF002(DFN,.CMORH)
 .I +CMORH=-1 D
 ..I RPC=1 S RETURN(DFN,"CMOR HISTORY")="MPI("_DFN_",""CMOR HISTORY"")="""_$P(CMORH,"^",2)_""""
 ..I RPC=0 S RETURN(DFN,"CMOR HISTORY")=""""_$P(CMORH,"^",2)_""""
 .I +CMORH'=-1 D
 ..M RETURN(DFN,"CMOR HISTORY")=CMORH
 ..I RPC=1 D
 ...N IEN
 ...S IEN="" F  S IEN=$O(RETURN(DFN,"CMOR HISTORY",IEN)) Q:IEN=""  S RETURN(DFN,"CMOR HISTORY",IEN)="MPI("_DFN_",""CMOR HISTORY"","_IEN_")="_$G(RETURN(DFN,"CMOR HISTORY",IEN))
 ...S RETURN(DFN,"CMOR HISTORY")="MPI("_DFN_",""CMOR HISTORY"")="_$G(RETURN(DFN,"CMOR HISTORY"))
 .;
 .D EXC(DFN,.RETS,XX)
 .I RETS(XX,"EXCEPTIONS")="No Exceptions" D
 ..I RPC=1 S RETURN(DFN,"EXCEPTIONS")="MPI("_DFN_",""EXCEPTIONS"")=""NO EXCEPTIONS""",RETURN(DFN,1)=$G(RETURN(DFN,1))_" with No Exceptions"_""""
 ..I RPC=0 S RETURN(DFN,"EXCEPTIONS")="""NO EXCEPTIONS""",RETURN(DFN,1)=$G(RETURN(DFN,1))_" with No Exceptions"_""""
 .I RETS(XX,"EXCEPTIONS")'="No Exceptions" D
 ..I RPC=1 S RETURN(DFN,1)=$G(RETURN(DFN,1))_" with Exceptions"_"""",RETURN(DFN,"EXCEPTIONS")="MPI("_DFN_",""EXCEPTIONS"")="_""""_$G(RETS(XX,"EXCEPTIONS"))_""""
 ..I RPC=0 S RETURN(DFN,1)=$G(RETURN(DFN,1))_" with Exceptions"_"""",RETURN(DFN,"EXCEPTIONS")=$G(RETS(XX,"EXCEPTIONS"))
 I CNTD>1 D
 .I RPC=1 S RETURN(1,"ICNS PROCESSED")="MPI(""ICNS PROCESSED"")="_""""_CNTD_""""
 .I RPC=0 S RETURN(1,"ICNS PROCESSED")="MPI(""ICNS PROCESSED"")="_CNTD
 Q
EXC(DFN,RET,YY) ;
 ; process exceptions into single value
 N TVAL,IEN
 D GETEX^RGEX03(.VAL,DFN)
 I +VAL(0)=0 S RET(YY,"EXCEPTIONS")="No Exceptions"
 I +VAL(0)'=0 D
 .S IEN=0,TVAL=""
 .F IEN=$O(VAL(IEN)) Q:IEN=""  S TVAL=TVAL_$P($G(VAL(IEN)),"^")_"^"
 .S RET(YY,"EXCEPTIONS")=""""_TVAL_""""
 K VAL
 Q
 ;
INACT(RETURN,ICN) ;
 ;RPC to inactivate the ICN passed.
 ; RETURN - 1 for successful inactivation or -1^error msg
 ; ICN = is the ICN for the patient that is to be inactivated
 ;
 I $G(ICN)="" S RETURN="-1^No ICN Passed" Q
 I +ICN<1 S RETURN="-1^Invalid ICN" Q
 N DFN,TICN,ER
 S DFN=$$GETDFN^MPIF001(ICN)
 I +DFN<0 S RETURN="-1^No such ICN" Q
 S TICN=$$GETICN^MPIF001(DFN)
 I +TICN'=+ICN S RETURN="-1^ICN is not active" Q
 D PAT^MPIFDEL(DFN,.ER)
 I ER'="" S RETURN="-1^"_ER Q
 S RETURN=1
 Q
 ;
RCCMOR(RETURN,ICN,CMOR,SSN,A08) ;
 ;RPC to change the CMOR value to CMOR for patient with ICN value ICN
 ; RETURN - array to return 1 for successful update or -1^ERROR MSG
 ; ICN = ICN for the patient that the CMOR is to be changed for
 ; CMOR = Station Number of the site that should become the CMOR
 ; SSN = Social Security Number of the patient involved, to be used if 
 ;      ICN is not found due to bad AICN x-ref
 ; A08 = 1 means trigger A08 message, 0 means don't send A08 msg
 ;
 I $G(ICN)=""!($G(CMOR)="") S RETURN="-1^Missing Required fields" Q
 N DFN,CIEN,DFNS
 S DFN=$$GETDFN^MPIF001(ICN)
 I DFN'>0&($G(SSN)="") S RETURN(1)="-1^Unknown ICN" Q
 I DFN'>0 D
 .Q:'$D(^DPT("SSN",SSN))
 .S DFNS=$$GETDFNS^MPIF002(SSN)
 .S DFN=$$CHK(DFNS,ICN)
 I DFN'>0!(+ICN=-1) S RETURN(1)="-1^Unknown ICN" Q
 S CIEN=$$IEN^XUAF4(CMOR)
 I CIEN'>0 S RETURN(1)="-1^Unknown Institution" Q
 S RETURN(1)=$$CHANGE^MPIF001(DFN,CIEN)
 I A08=1 D AVAFC^VAFCDD01(DFN) ; trigger A08 msg
 I A08=1 S RETURN(1)=RETURN(1)_"^and A08 triggered"
 ;trigger a08
 Q
 ;
CHK(DFNS,ICN) ; see if had broken AICN x-ref, if so, fix it and return 
 ; correct DFN for patient that's CMOR is to be changed.
 ;
 N IEN,NODE,NXT,FOUND,DFN
 S FOUND=0
 F NXT=1:1 S IEN=$P(DFNS,"^",NXT) Q:IEN=""!(FOUND=1)  D
 .S NODE=$$MPINODE^MPIFAPI(NXT)
 .I $P(NODE,"^")=ICN S FOUND=1,^DPT("AICN",ICN,IEN)="",DFN=IEN
 I FOUND=0 Q "-1^No such ICN"
 Q DFN
