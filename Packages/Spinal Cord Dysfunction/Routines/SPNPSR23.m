SPNPSR23 ;HIRMFO/DAD,WAA-HUNT: SCD REGISTRATION ;8/1/95  14:16
 ;;2.0;Spinal Cord Dysfunction;**9**;1/02/1997
 ;
EN1(D0,REG) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"REGISTRATION",REG) = Registration ^ Status
 ;   REG = REGISTRATION
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N SPNLREG,SPNLNET,I,MEETSRCH,VA,VADM,VAERR
 S MEETSRCH=0
 S SPNLREG=$P($G(^SPNL(154,+D0,0)),U,3)
 I REG=4 S REG="X"
 I REG=$P(SPNLREG,U) S MEETSRCH=1
 E  D
 .I REG=3,((SPNLREG=1)!(SPNLREG=2)) S MEETSRCH=1
 .Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"REGISTRATION",REG) = Registration ^ Status
 ;
 ; Select the state
 N SPNLREG,Y
 S SPNLEXIT=0 D
 .N DIR
 .S DIR(0)="SAO^A:SCD-Currently served;B:SCD-Not Currently served;C:Both A&B;D:Not SCD;E:Expired"
 .S DIR("A")="Select Registration Status: "
 .S DIR("A",1)="    Registration Status"
 .S DIR("A",2)="      A) SCD-Currently served"
 .S DIR("A",3)="      B) SCD-Not Currently served"
 .S DIR("A",4)="      C) Both A&B"
 .S DIR("A",5)="      D) Not SCD"
 .S DIR("A",6)="      E) Expired"
 .D ^DIR
 .I $D(DTOUT)!($D(DUOUT)) S SPNLEXIT=1
 .I Y'="" S Y=$$UP^XLFSTR(Y)
 .I "ABCDE"'[Y S SPNLEXIT=1
 .Q
 I 'SPNLEXIT,Y'="" D
 .S SPNLREG=$S(Y="A":"1^SCD-Currently served",Y="B":"2^SCD-Not Currently served",Y="C":"3^Both A&B",Y="D":"0^Not SCD",1:"X^Expired")
 .I $P(SPNLREG,U)="X" S SPNLREG=4
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"REGISTRATION",+SPNLREG)=SPNLREG
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR23(D0,"_$P(SPNLREG,U)_")"
 .Q
 Q
