SPNPSR06 ;HIRMFO/DAD,WAA-HUNT: GEOGRAPHICAL AREA ;10/31/97  15:21
 ;;2.0;Spinal Cord Dysfunction;**3**;01/02/1997
 ;
EN1(D0,BZIP,EZIP) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING ZIP") = Zip ^ Zip
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING ZIP") = Zip ^ Zip
 ;  BZIP = Beginning ZIP
 ;  EZIP = Ending ZIP
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DFN,I,MEETSRCH,VA,VAPA,VAERR,ZIP
 S MEETSRCH=0
 S DFN=+$P($G(^SPNL(154,+D0,0)),U)
 D ADD^VADPT
 I 'VAERR D
 . S ZIP=$G(VAPA(6))
 . I ZIP'<BZIP,ZIP'>EZIP S MEETSRCH=1
 . Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING ZIP") = Zip ^ Zip
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING ZIP") = Zip ^ Zip
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR(D0,BZIP,EZIP)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,I,ZIP
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="FOA^5:5^K:X'?5N X"
 S DIR("A")="Zip code range start value: "
 S DIR("?")="Enter a 5 digit zip code"
 D ^DIR S (ZIP("BEGINNING ZIP"),BZIP)=Y
 I '$D(DIRUT) D
 . K DIR S DIR(0)="FOA^5:5^K:(X'?5N)!(X<ZIP(""BEGINNING ZIP"")) X"
 . S DIR("A")="Zip code range end value:   "
 . S DIR("?")="Enter a 5 digit zip code"
 . D ^DIR S (ZIP("ENDING ZIP"),EZIP)=Y
 . Q
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . F I="BEGINNING ZIP","ENDING ZIP" S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,I)=$G(ZIP(I))_U_$G(ZIP(I))
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR06(D0,"_BZIP_","_EZIP_")"
 . Q
 Q
