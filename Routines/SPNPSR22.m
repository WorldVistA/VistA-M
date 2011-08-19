SPNPSR22 ;HIRMFO/DAD,WAA-HUNT: SCI NETWORK ;8/1/95  14:16
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN1(D0,SCI) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"SCI NETWORK",X) = 1/0 ^ SCI NETWORK
 ;   SCI = 1/0
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N SPNLNET,I,MEETSRCH,VA,VADM,VAERR
 S MEETSRCH=0
 S SPNLNET=+$P($G(^SPNL(154,+D0,1)),U)
 I SCI[SPNLNET S MEETSRCH=1
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"SCI NETWORK",X) = 1/0 ^ SCI NETWORK
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR22(D0,SCI)
 ;
 ; Select the state
 N SPNLNET
 S SPNLEXIT=0 D
 .N DIR
 .S DIR(0)="SAO^A:SCI Network;B:Non-SCI Network;C:Both A and B"
 .S DIR("A")="Select SCI Network: "
 .S DIR("A",1)="SCI Network Status"
 .S DIR("A",2)="      A) SCI Network"
 .S DIR("A",3)="      B) Non-SCI Network"
 .S DIR("A",4)="      C) Both A and B"
 .D ^DIR
 .I $D(DTOUT)!($D(DUOUT)) S SPNLEXIT=1
 .I Y="" Q
 .Q
 I 'SPNLEXIT,Y'="" D
 .S SPNLNET=$S(Y="A":"1^SCI Network",Y="B":"0^Non-SCI Network",1:"10^SCI & Non-SCI Networks")
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"SCI NETWORK",+SPNLNET)=SPNLNET
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR22(D0,"_$P(SPNLNET,U)_")"
 .Q
 Q
