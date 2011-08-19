VAQUTL96 ;ALB/JFP - PDX Transaction Lookup ;01-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;**37**;NOV 17, 1993
 ;
 ;
GETTRN(PATIENT) ;-- Return DFN for PDX transaction
 ; -- Only returns patients patients with results of PDX
 ; -- This will return the same information that DIC returns in Y
 ;
 N DIC,X,Y,RESULT,USRABORT
 N TRNFLAG
 ;
 S USRABORT=-1
 S:'$D(PATIENT) PATIENT=""
 ;
 ; -- User interface
 S DIC(0)="EQMZ"
 S DIC("S")="I $$TRN1^VAQUTL96()"
 S X=PATIENT
 S DIC="^VAT(394.61,"
 K ^TMP("BS5",$J)
 D ^DIC K DIC,NM,SSN,BS5
 K ^TMP("BS5",$J)
 ;
 ; -- User abort process
 ;
 Q:$D(DTOUT) USRABORT
 Q:$D(DUOUT) USRABORT
 Q Y
 ;
TRN1() ; -- filters out transactions flaged as purged OR exceed life days
 S TRNFLAG=$$EXPTRN^VAQUTL97(Y)
 I TRNFLAG Q 0
 ;
 N NODE
 S NODE=$G(^VAT(394.61,Y,"QRY"))
 S NM=$P(NODE,U,1)
 Q:NM="" 0
 S SSN=$P(NODE,U,2)
 Q:SSN="" 0
 ;S BS5=$E(NM,1,1)_$E(SSN,6,10) ; before patch VAQ*1.5*37
 S BS5=$E(NM,1,1)_SSN ; after patch VAQ*1.5*37
 ;
 ; -- filters out duplicate entries from multiple cross references
 I $D(^TMP("BS5",$J,BS5)) Q 0
 S ^TMP("BS5",$J,BS5)=1
 Q 1
 ;
END ; -- End of code
 QUIT
