MAGDRA3 ;WOIFO Routine to lookup patient by casenumber of name  [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;;Mar 01, 2002
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
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
 I ANS?1.5N!(ANS?6N1"-".N) D CASE(ANS,.RESULT) I +RESULT Q RESULT
 I ANS?1.8N Q RESULT  ;Incomplete ssn sent. Couldn't be a case number?
 D:ANS'?.N1"-".E PAT(ANS,.RESULT)
 Q RESULT
CASE(CASE,RESULT) ;
 N MAGXR,MAGDFN,MAGDTI,MAGCNI
 S MAGXR=$S(CASE["-":"ADC",1:"AE")
 I $D(^RADPT(MAGXR,CASE)) D
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
