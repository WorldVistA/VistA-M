SPNPSR25 ;HIRMFO/DAD,WAA-HUNT: TRAUMATIC/DISABILITY ;8/1/95  14:16
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN1(D0,INJURY) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"EXTENT OF INJURY",INJURY) = 1/2/3 ^ Paraplegia/Quadriplegia/Both
 ;   INJURY = 1/2/3
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N SPNL1,SPNL,MEETSRCH
 S MEETSRCH=0
 S SPNL1=$G(^SPNL(154,D0,2))
 I SPNL1="" Q MEETSRCH
 S SPNL=$P(SPNL1,U,6)
 I SPNL'<1 D
 .I INJURY=3 S MEETSRCH=1 Q
 .I INJURY=1,SPNL=1!(SPNL=3) S MEETSRCH=1 Q
 .I INJURY=2,SPNL=2!(SPNL=4) S MEETSRCH=1 Q
 .Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"EXTENT OF INJURY") = 1/2/3 ^ Text
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR25(D0,INJURY)
 ;
 ; Select the state
 N SPNLREG,Y
 S SPNLEXIT=0 D
 .N DIR
 .S DIR(0)="SAO^p:Paraplegia;Q:Quadriplegia;B:Both"
 .S DIR("A")="  Select Injury: "
 .S DIR("A",1)="    Extent of Injury: "
 .S DIR("A",2)="      P) Paraplegia"
 .S DIR("A",3)="      Q) Quadriplegia"
 .S DIR("A",4)="      B) Both"
 .D ^DIR
 .I $D(DTOUT)!($D(DUOUT)) S SPNLEXIT=1
 .I Y'="" S Y=$$UP^XLFSTR(Y)
 .I "PQB"'[Y S SPNLEXIT=1
 .Q
 I 'SPNLEXIT,Y'="" D
 .S SPNLREG=$S(Y="P":"1^Paraplegia",Y="Q":"2^Quadriplegia",Y="B":"3^Both",1:"0")
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"EXTENT OF INJURY",$P(SPNLREG,U))=SPNLREG
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR25(D0,"_$P(SPNLREG,U)_")"
 .Q
 Q
