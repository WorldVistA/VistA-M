SPNPSR24 ;HIRMFO/DAD,WAA-HUNT,CM: TRAUMATIC/DISABILITY ;8/1/95  14:16
 ;;2.0;Spinal Cord Dysfunction;**12**;01/02/1997
 ;
EN1(D0,TRAMA) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"TRAMDIS",TRAMA) = TC/NTC/B/U^Text
 ;   TRAMA = TRAUMATIC
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N SPNLNET,I,MEETSRCH,VA,VADM,VAERR
 S MEETSRCH=0
 I $$EN4^SPNLUTL1(D0,TRAMA) S MEETSRCH=1
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"TRAUMATIC CAUSE") = TC/NTC/B/U^Text
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR24(D0,TC/NTC/B/U)
 ;
 ; Select the state
 N SPNLREG,Y
 S SPNLEXIT=0 D
 .N DIR
 .S DIR(0)="SAO^T:Traumatic;N:Non-traumatic;B:Both Traumatic and Non-traumatic;U:Unknown"
 .S DIR("A")="  Select Cause: "
 .S DIR("A",1)="    Cause of Injury: "
 .S DIR("A",2)="      T) Traumatic"
 .S DIR("A",3)="      N) Non-traumatic"
 .S DIR("A",4)="      B) Both Traumatic and Non-traumatic"
 .S DIR("A",5)="      U) Unknown"
 .D ^DIR
 .I $D(DTOUT)!($D(DUOUT)) S SPNLEXIT=1
 .I Y'="" S Y=$$UP^XLFSTR(Y)
 .I "TNBU"'[Y S SPNLEXIT=1
 .Q
 I 'SPNLEXIT,Y'="" D
 .S SPNLREG=$S(Y="T":"TC^Traumatic",Y="N":"NTC^Non-traumatic ",Y="B":"B^Both",Y="U":"U^Unknown",1:"0")
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"TRAUMATIC CAUSE",$P(SPNLREG,U))=SPNLREG
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR24(D0,"""_$P(SPNLREG,U)_""")"
 .Q
 Q
