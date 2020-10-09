DGRPCM ;ALB/CMC - API FOR GETTING PV FROM MVI USING ICN ;7/28/2020
 ;;5.3;Registration;**1026**;Aug 13, 1993;Build 3
 ;
GETPV(RET,ICN) ;
 ;RETURN contains the Primary View Data
 ;ICN is the Integration Control Number being used to get the Primary View data
 ;utilizes RPC: MPI RETURN PRIMARY VIEW DATA
 ;
 N CHKSUM,HCNT,RETURN,RESULT S HCNT=0
 I ICN="" S RETURN(1)="-1^MISSING ICN" Q
 I ICN'["V" S CHKSUM=$$CHECKDG^MPIFSPC(ICN),ICN=ICN_"V"_CHKSUM
 ;
TR D EN1^XWB2HL7(.RETURN,"200M","MPI RETURN PRIMARY VIEW DATA",1,ICN,1) ;call rpc - return(0)=handle
 I RETURN(0)="" S HCNT=HCNT+1 H 2 I HCNT<15 G TR
 I RETURN(0)="" S RETURN(1)="-1^COMMUNICATION Failure. "_RETURN_" No handle after sending RPC to MVI" Q
 ;GOT HANDLE
 S HCNT=0 F  S HCNT=HCNT+1 D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) Q:RESULT(0)  H 2 I HCNT>60 Q  ;result(0)=status of message
 ;DONE RETURNED, GET DATA
 I +RESULT(0)=1 D RTNDATA^XWBDRPC(.RET,RETURN(0)) ;ret(0)=data for handle
 ;RPC is done and we have a negative result
 Q
