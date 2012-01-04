MAGDRA3 ;WOIFO/LB - Routine to lookup patient by casenumber of name ; 05 Apr 2011 8:50 AM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ASK() ;Prompt user
 N DIR,X,Y
 S DIR(0)="F:1:30",DIR("A")="Enter patient or case number"
 S DIR("?")="Enter a patient name or case number to associate this image."
 D ^DIR
 Q Y
READ(RESULT) ;
 N ANS
 S RESULT=0,ANS=$$ASK
 I ANS=""!(ANS="^") S RESULT="^" Q RESULT
 I ANS?1.5N!(ANS?6N1"-".N)!(ANS?3N1"-"6N1"-".N) D CASE(ANS,.RESULT) I +RESULT Q RESULT
 I ANS?1.8N Q RESULT  ;Incomplete ssn sent. Couldn't be a case number?
 D:ANS'?.N1"-".E PAT(ANS,.RESULT)
 Q RESULT
CASE(CASE,RESULT) ;
 N MAGXR,MAGDFN,MAGDTI,MAGCNI,ARESULT
 S MAGXR=$S($L(CASE,"-")>1:"RAAPI",1:"AE")
 I MAGXR="RAAPI",$$ACCFIND^RAAPI(CASE,.ARESULT)>0 S RESULT=$TR(ARESULT(1),"^","~")
 I MAGXR="AE",$D(^RADPT(MAGXR,CASE)) D
 . S MAGDFN=$O(^RADPT(MAGXR,CASE,0))
 . S MAGDTI=$O(^RADPT(MAGXR,CASE,MAGDFN,0))
 . S MAGCNI=$O(^RADPT(MAGXR,CASE,MAGDFN,MAGDTI,0))
 . S RESULT=MAGDFN_"~"_MAGDTI_"~"_MAGCNI
 Q 
PAT(PAT,RESULT) ;
 N DIR,X,Y
 S DIR(0)="P^70:EMZ",DIR("B")=PAT
 D ^DIR
 S RESULT=Y
 Q
