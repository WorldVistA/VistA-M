SDWLRP3 ;;IOFO BAY PINES/TEH - WAITING LIST - RPC 3 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;  10/30/2002                                          Inserted comment for DBIA174
 ;
 ;
 ;
 ;
 ;
 ;
 ;******************************************************************
 ;
 ;
 ;       Internal ID : Description ; Internal ID : Description 
 ;
 ;
SDPRIOUT() ;PRIORITY SET OF CODES - Internal ID:Description;Internal ID:Description
 K ^TMP("SDWLST",$J)
 D FIELD^DID(409.3,"10",,"POINTER","^TMP(""SDWLPRI"",$J)")
 Q
SDREQOUT() ;REQUEST BY SET OF CODES - Internal ID:Description;Internal ID:Description
 K ^TMP("SDWLST",$J)
 D FIELD^DID(409.3,"11",,"POINTER","^TMP(""SDWLREQ"",$J)")
 Q
SDTYOUT() ;WAIT LIST TYPE - Internal ID:Description;Internal ID:Description 
 K ^TMP("SDWLST",$J)
 D FIELD^DID(409.3,"4",,"POINTER","^TMP(""SDWLTY"",$J)")
 Q
SDDISOUT() ;DISPOSITION 
 K ^TMP("SDWLDIS",$J)
 D FIELD^DID(409.3,"21",,"POINTER","^TMP(""SDWLDIS"",$J)")
 Q
SDSTOUT() ;CURRENT STATUS
 K ^TMP("SDWLST",$J)
 D FIELD^DID(409.3,"23",,"POINTER","^TMP(""SDWLST"",$J)")
 Q
SDPACOUT() ;PACKAGE
 K ^TMP("SDWPAC",$J)
 D FIELD^DID(409.3,"26",,"POINTER","^TMP(""SDWLPAC"",$J)")
 Q
SDNEOUT() ;NEW ENROLLEE
 K ^TMP("SDWLNE",$J)
 D FIELD^DID(409.3,"27",,"POINTER","^TMP(""SDWLNE"",$J)")
 Q
SDSC(SDWLOUT,SDWLDFN) ;-service connected API
 ;
 ;
 ;       Input:
 ;               Patients DFN
 ;               
 ;       Output:
 ;               ^TMP("SDWLRP3",$J,0)=Service Connected Disability %
 ;               ^TMP("SDWLRP3",$J,INTERNAL NUMBER)=DISABILITY^%
 ;               
 ;               
 K ^TMP("SDWLRP3",$J)
 D ELIG^VADPT,SVC^VADPT
 I $D(VAEL(3)),$P(VAEL(3),U,2) S SDWLSC=$P(VAEL(3),U,2),^TMP("SDWLRP3",$J,0)=SDWLSC
 ;
 ;10/30/2002;DBIA174 - Direct global access to Patient file, Field .3721 -- Rated Disabilties-teh
 ;
 I $D(^DPT(SDWLDFN,.372)) S X=0 F  S X=$O(^DPT(SDWLDFN,.372,X)) Q:X<1  D
 .S Y=$G(^DPT(SDWLDFN,.372,X,0)) I $P(Y,U,3) S SDWLX=$P($G(^DIC(31,+Y,0)),U,1),^TMP("SDWLRP3",$J,$P(Y,U,1))=SDWLX_"^"_$P(Y,U,2)
 I '$D(^TMP("SDWLRP3",$J)) S SDWLOUT=-1 Q
 K SDWLOUT S SDWLOUT=$NA(^TMP("SDWLRP3",$J))
 Q
