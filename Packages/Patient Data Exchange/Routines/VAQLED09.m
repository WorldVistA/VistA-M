VAQLED09 ;ALB/JFP - PDX, LOAD/EDIT, HELP MESSAGES;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
HLPTRN1 ;  -- Displays the patients by result for selection
 N X
 D STATPTR^VAQUTL95 ; -- set PDX status pointers
 W !!,"(1) - All PDX transaction patients",!,"(2) - All PDX transaction patients (results)",!,"(3) - All PDX transaction patients (unsolicited)",!
 R "Select Display Option: ",X:DTIME  Q:X=""
 I X="^"  QUIT
 I X=1 D HLPT1  QUIT
 I X=2 D HLPT2  QUIT
 I X=3 D HLPT3  QUIT
 W "        ...invalid entry"
 QUIT
 ;
HLPT1 ; -- All PDX transaction patients
 N DIC,D,DZ,VAQXRF3,TRNFLAG,SCR
 S DIC="^VAT(394.61,"
 S DIC(0)="C"
 S DIC("W")="D IDENT^VAQLED09"
 S DIC("S")="I $$FLT1^VAQLED09()"
 S D="B",DZ="??"
 D DQ^DICQ
 K NM,SSN,BS5,^TMP("BS5",$J)
 S %T="F" ; -- dic kills this variable required for dir (free text)
 QUIT
 ;
HLPT2 ; -- All PDX transactions (vaq-rslt)
 N DIC,D,DZ,VAQXRF3,TRNFLAG,SCR
 S DIC="^VAT(394.61,"
 S DIC("W")="D IDENT^VAQLED09"
 S DIC("S")="I $$FLT2^VAQLED09()"
 S DIC(0)="CM"
 S D="B",DZ="??"
 D DQ^DICQ
 S %T="F" ; -- dic kills this variable required for dir (free text)
 QUIT
 ;
HLPT3 ; -- All PDX transactions (vaq-unsol)
 N DIC,D,DZ,VAQXRF3,TRNFLAG,SCR
 S DIC="^VAT(394.61,"
 S DIC("W")="D IDENT^VAQLED09"
 S DIC("S")="I $$FLT3^VAQLED09()"
 S DIC(0)="CM"
 S D="B",DZ="??"
 D DQ^DICQ
 S %T="F" ; -- dic kills this variable required for dir (free text)
 QUIT
IDENT ;  -- Resets identifier
 S VAQXRF0=$G(^VAT(394.61,Y,"QRY"))
 S VAQXRF1=$P(VAQXRF0,U,1) ; -- name
 S VAQXRF2=$P(VAQXRF0,U,4) ; -- pid
 S:VAQXRF1="" VAQXRF1="NOT ON FILE"
 S:VAQXRF2="" VAQXRF2="NOT ON FILE"
 W ?15,"Name: ",VAQXRF1,?50,"Pid: ",VAQXRF2
 K VAQXRF0,VAQXRF1,VAQXRF2
 QUIT
 ;
FLT1() ; -- Filters out multiple names
 ; -- filters out transactions flagged as purged or exceeded life days
 I $$EXPTRN^VAQUTL97(Y) Q 0
 N NODE
 S NODE=$G(^VAT(394.61,Y,"QRY"))
 S NM=$P(NODE,U,1) ; -- name
 Q:NM="" 0
 S SSN=$P(NODE,U,4)
 Q:SSN="" 0
 S BS5=$E(NM,1,1)_$E(SSN,6,10)
 ;
 I $D(^TMP("BS5",$J,BS5)) Q 0
 S ^TMP("BS5",$J,BS5)=1
 QUIT 1
 ;
FLT2() ; -- Filter out all but results
 I $$EXPTRN^VAQUTL97(Y) Q 0
 I $P($G(^VAT(394.61,Y,0)),U,2)=VAQRSLT Q 1
 QUIT 0
 ;
FLT3() ; -- Filter out all but unsolicited
 I $$EXPTRN^VAQUTL97(Y) Q 0
 I $P($G(^VAT(394.61,Y,0)),U,2)=VAQUNSOL Q 1
 QUIT 0
 ;
END ; -- End of code
 QUIT
