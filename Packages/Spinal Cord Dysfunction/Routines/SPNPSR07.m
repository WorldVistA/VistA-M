SPNPSR07 ;HIRMFO/DAD,WAA-HUNT: SERVICE CONNECTION ;8/1/95  14:23
 ;;2.0;Spinal Cord Dysfunction;**10**;01/02/1997
 ;
EN1(D0,SPNCVN,BPRC,EPRC) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING SVC CONNECTED %") = 0 ! 1 ^ %
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING SVC CONNECTED %") = 0 ! 1 ^ %
 ;    SPNCVN = Service Connected
 ;    BPRC, BPRC = Percent age of service connection
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DFN,I,MEETSRCH,SERVCONN,VA,VAEL,VAERR
 S MEETSRCH=0
 S DFN=+$P($G(^SPNL(154,+D0,0)),U)
 D ELIG^VADPT
 I 'VAERR D
 . S SERVCONN=$P($G(VAEL(3)),U,2)
 . S SPNCON=$P($G(VAEL(3)),U)
 . I SPNCON=SPNCVN D
 .. I SPNCON,SERVCONN'<BPRC,SERVCONN'>EPRC S MEETSRCH=1
 .. I 'SPNCON S MEETSRCH=1
 .. Q
 . Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING SVC CONNECTED %") = 0 ! 1 ^ %
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING SVC CONNECTED %") = 0 ! 1 ^ %
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR07(D0,SPNCVN,BPRC,EPRC)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,I
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="NOA^0:100"
 S DIR("A")="Service connected percentage start value: "
 S DIR("?")="Enter a service connected percentage: 0-100%."
 D ^DIR S (SERVCONN("BEGINNING SVC CONNECTED %"),BPRC)=Y
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . K DIR S DIR(0)="NOA^"_SERVCONN("BEGINNING SVC CONNECTED %")_":100"
 . S DIR("A")="Service connected percentage end value:   "
 . S DIR("?")="Enter a service connected percentage: "_SERVCONN("BEGINNING SVC CONNECTED %")_"-100%."
 . D ^DIR S (SERVCONN("ENDING SVC CONNECTED %"),EPRC)=Y
 . Q
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . F I="BEGINNING SVC CONNECTED %","ENDING SVC CONNECTED %" D
 .. S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,I)=$S(SERVCONN(I):1,1:0)_U_$G(SERVCONN(I))
 ..Q
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR07(D0,"_"1,"_$P(BPRC,U,1)_","_$P(EPRC,U,1)_")"
 . Q
 Q
