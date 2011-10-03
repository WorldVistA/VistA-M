VAQDBIH2 ;JRP/ALB - GET INFO ABOUT HEALTH SUMMARY COMPONENT;09-SEP-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
VALOCC(LIMIT,TYPEOCC) ;VALIDATE TIME LIMIT
 ;INPUT  : LIMIT - Limit value to check for validity
 ;         TYPEOCC - Flag indicating which limit to validate against
 ;                   0 = Time limit (default)
 ;                   1 = Occurrence limit
 ;OUTPUT : 0 - Limit is valid
 ;        -1 - Limit is not valid or error
 ;NOTES  : Time limits are 1-5 numerics followed be 'D' or 'M' or 'Y'
 ;       : Occurrence limits are 1-5 numerics
 ;
 ;CHECK INPUT
 Q:($G(LIMIT)="") -1
 S TYPEOCC=+$G(TYPEOCC)
 ;DECLARE VARIABLES
 N ANS,TMP
 ;VALIDATE TIME LIMIT
 I ('TYPEOCC) D  Q ANS
 .S ANS=-1
 .S TMP=$E(LIMIT,1,($L(LIMIT)-1))
 .Q:(TMP'?1.5N)
 .S TMP=$E(LIMIT,$L(LIMIT))
 .I ((TMP="D")!(TMP="M")!(TMP="Y")) S ANS=0 Q
 ;VALIDATE OCCURRENCE LIMIT
 Q:(LIMIT?1.5N) 0
 Q -1
