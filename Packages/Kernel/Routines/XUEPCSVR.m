XUEPCSVR ;BIRMINGHAM/VRN - ePCS VERSION CHECK ;7/8/21  14:57
 ;;8.0;KERNEL;**689**;Jul 10, 1995;Build 113
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
GUICHK(RESULTS,EPCSARY)   ; Return server version and minimum GUI client version
 ;
 ; RPC : ePCS VERSION CHECK
 ;
 K RESULTS
 I $G(EPCSARY)="" Q
 N EPCSLST,EPCSMINV
 S EPCSMINV="2.2.0.0"
 D FIND^DIC(19,"",1,"X",EPCSARY,1,,,,"EPCSLST")
 I 'EPCSLST("DILIST",0) Q
 S RESULTS=EPCSLST("DILIST","ID",1,1)
 S RESULTS=$P(RESULTS,"version ",2)_U_EPCSMINV
 Q
