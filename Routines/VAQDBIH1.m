VAQDBIH1 ;JRP/ALB - GET INFO ABOUT HEALTH SUMMARY COMPONENT;09-SEP-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
HLTHSEG(PDXABB,NOLIMITS) ;DETERMINE IF PDX SEGMENT IS A H.S. COMPONENT
 ;INPUT  : PDXABB - Abbreviation of segment in VAQ - DATA SEGMENT file
 ;         NOLIMITS - Flag indicating if time & occurrence indicators
 ;                    should be returned
 ;                    0 = Return indicators (default)
 ;                    1 = Don't return indicators
 ;OUTPUT : A^B^C where
 ;           A - Pointer to entry in HEALTH SUMMARY COMPONENT file
 ;               (will be '0' if not a Health Summary Component)
 ;           B - Time indicator
 ;               1 = Time limits applicable
 ;               0 = Time limits not applicable
 ;           C - Occurrence indicator
 ;               1 = Occurrence limits applicable
 ;               0 = Occurrence limits not applicable
 ;NOTES  : If NOLIMITS is set to 1, output will be A (not A^^)
 ;       : If PDXABB is not passed or is not a valid abbreviation,
 ;         output will be 0
 ;
 ;CHECK INPUT & SET DEFAULTS
 Q:($G(PDXABB)="") 0
 Q:('$D(^VAT(394.71,"C",PDXABB))) 0
 S NOLIMITS=+$G(NOLIMITS)
 ;DECLARE VARIABLES
 N PDXSEG,ANS,TMP
 ;GET POINTER TO SEGMENT
 S PDXSEG=+$O(^VAT(394.71,"C",PDXABB,""))
 Q:('PDXSEG) 0
 ;GET INFO
 S ANS=$$SEGHLTH(PDXSEG,NOLIMITS)
 ;NOT A HEALTH SUMMARY COMPONENT OR NO LIMIT INDICATORS REQUIRED
 Q:(('ANS)!(NOLIMITS)) (+ANS)
 ;CHECK FOR TIME LIMIT
 S TMP=$P(ANS,"^",2)
 S:(TMP="@") TMP=1
 S:(TMP="") TMP=0
 S:(TMP) TMP=1
 S $P(ANS,"^",2)=TMP
 ;CHECK FOR OCCURRENCE LIMIT
 S TMP=$P(ANS,"^",3)
 S:(TMP="@") TMP=1
 S:(TMP="") TMP=0
 S:(TMP) TMP=1
 S $P(ANS,"^",3)=TMP
 ;DONE
 Q ANS
 ;
SEGHLTH(SEGPTR,NOMAX) ;DETERMINE IF PDX SEGMENT IS A H.S. COMPONENT
 ;INPUT  : SEGPTR - Pointer to segment in VAQ - DATA SEGMENT file
 ;         NOMAX - Flag indicating if maximium time & occurrence limits
 ;                 allowed by facility should be returned
 ;                 0 = Return maximum limits (default)
 ;                 1 = Don't maximium limits
 ;OUTPUT : A^B^C where
 ;           A - Pointer to entry in HEALTH SUMMARY COMPONENT file
 ;               (will be '0' if not a Health Summary Component)
 ;           B - Maximum time limit allowed
 ;           C - Maximum occurrence limit allowed
 ;NOTES  : If NOMAX is set to 1, output will be A (not A^^)
 ;       : If SEGPTR is not passed or is not a valid abbreviation,
 ;         output will be 0
 ;       : '@' denotes that a limit is applicable but a maximum
 ;         limit has not been set
 ;       : NULL denotes that a limit is not applicable
 ;
 ;CHECK INPUT & SET DEFAULTS
 Q:('(+$G(SEGPTR))) 0
 Q:('$D(^VAT(394.71,SEGPTR))) 0
 S NOMAX=+$G(NOMAX)
 ;DECLARE VARIABLES
 N HLTHPTR,TIME,OCCUR,MAXTIM,MAXOCC,TMP,NODE
 ;DETERMINE IF SEGMENT IS PAIRED WITH HEALTH SUMMARY COMPONENT
 S NODE=$G(^VAT(394.71,SEGPTR,0))
 S HLTHPTR=+$P(NODE,"^",4)
 Q:('HLTHPTR) 0
 ;GET TIME & OCCURRENCE FLAGS
 S TIME=$$LIMITS(HLTHPTR)
 S OCCUR=+$P(TIME,"^",2)
 S TIME=+TIME
 ;GET MAXIMUM LIMITS
 S MAXTIM=$P(NODE,"^",5)
 S MAXOCC=+$P(NODE,"^",6)
 ;MAXIMUM TIME NOT APPLIED
 S:((MAXTIM="")&(TIME)) MAXTIM="@"
 ;MAXIMUM TIME NOT APPLICABLE
 S:('TIME) MAXTIM=""
 ;MAXIMUM OCCURRENCE NOT APPLIED
 S:(('MAXOCC)&(OCCUR)) MAXOCC="@"
 ;MAXIMUM OCCURRENCE NOT APPLICABLE
 S:('OCCUR) MAXOCC=""
 ;DONE
 Q:(NOMAX) HLTHPTR
 Q (HLTHPTR_"^"_MAXTIM_"^"_MAXOCC)
 ;
LIMITS(HSPTR) ;DETERMINE IF HEALTH SUMMARY COMPONENT HAS LIMITS
 ;INPUT  : HSPTR - Pointer to entry in HEALTH SUMMARY COMPONENT file
 ;OUTPUT : B^C where
 ;           B - Time indicator
 ;               1 = Time limits applicable
 ;               0 = Time limits not applicable
 ;           C - Occurrence indicator
 ;               1 = Occurrence limits applicable
 ;               0 = Occurrence limits not applicable
 ;NOTES  : It is assumed that input is valid (not checked)
 ;
 ;DECLARE VARIABLES
 N DIC,DR,DA,DIQ,TMPARR,TMP,TLIM,OLIM,TMPARR,X
 ;GET TIME & OCCURRENCE FLAGS
 S DIC="^GMT(142.1,"
 S DR="2;4"
 S DA=HSPTR
 S DIQ="TMPARR"
 S DIQ(0)="E"
 D EN^DIQ1
 ;CHECK IF TIME LIMIT APPLICABLE
 S (TLIM,OLIM)=0
 S TMP=$G(TMPARR(142.1,HSPTR,2,"E"))
 S:((TMP="Y")!(TMP="YES")!(TMP="yes")!(TMP="Yes")) TLIM=1
 ;CHECK IF OCCURRENCE LIMIT APPLICABLE
 S TMP=$G(TMPARR(142.1,HSPTR,4,"E"))
 S:((TMP="Y")!(TMP="YES")!(TMP="yes")!(TMP="Yes")) OLIM=1
 Q (TLIM_"^"_OLIM)
