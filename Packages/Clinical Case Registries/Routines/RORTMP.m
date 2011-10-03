RORTMP ;HCIOFO/SG - TEMPORARY GLOBAL STORAGE ; 10/14/05 1:41pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; DO NOT use this API to pass the data between tasks!
 ;
 Q
 ;
 ;***** ALLOCATES A TEMPORARY GLOBAL BUFFER
 ;
 ; [.SUBS]       Subscript of the buffer is returned here
 ;
 ; Return Values:
 ;           Closed root of the buffer
 ;
ALLOC(SUBS) ;
 N NDX,NODE
 S NDX=$O(^TMP($J,"RORTMP-0",""),-1)+1
 S SUBS="RORTMP-"_NDX,NODE=$NA(^TMP($J,SUBS))  K @NODE
 S ^TMP($J,"RORTMP-0",NDX)=""
 Q NODE
 ;
 ;***** FREES THE TEMPORARY GLOBAL BUFFER
 ;
 ; NODE          Closed root of the temporary global buffer
 ;
FREE(NODE) ;
 N NDX  S NDX=$$NDX(NODE)
 K:NDX>0 ^TMP($J,"RORTMP-0",NDX),@NODE
 Q
 ;
 ;***** EXTRACTS THE INDEX FROM THE CLOSED ROOT OF THE BUFFER
 ;
 ; NODE          Closed root of the temporary global buffer
 ;
 ; Return Values:
 ;        0  Invalid closed root
 ;       >0  Index of the buffer
 ;
NDX(NODE) ;
 N SUBS
 Q:$E(NODE,1)'="^" 0
 Q:$NA(@NODE,1)'=$NA(^TMP($J)) 0
 S SUBS=$QS(NODE,2)
 Q:$P(SUBS,"-")'="RORTMP" 0
 S NDX=+$P(SUBS,"-",2)
 Q $S(NDX>0:NDX,1:0)
 ;
 ;***** FREES THE LAST ALLOCATED BUFFER(S)
 ;
 ; [NODE]        Closed root of the temporary global buffer.
 ;
 ;               If this parameter is defined and references a
 ;               valid temporary buffer, then this buffer and
 ;               all others allocated after it are freed.
 ;
 ;               Otherwise, only the last buffer is freed.
 ;
POP(NODE) ;
 N NDX  S NDX=$$NDX($G(NODE))
 S:NDX'>0 NDX=+$O(^TMP($J,"RORTMP-0",""),-1)
 F  Q:NDX'>0  D  S NDX=$O(^TMP($J,"RORTMP-0",NDX))
 . D FREE($NA(^TMP($J,"RORTMP-"_NDX)))
 Q
 ;
 ;***** DELETES ALL TEMPORARY BUFFERS
PURGE ;
 N I  S I="RORTMP-"
 F  S I=$O(^TMP($J,I))  Q:$E(I,1,7)'="RORTMP-"  K ^TMP($J,I)
 Q
