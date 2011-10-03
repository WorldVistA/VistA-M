SPNPSR02 ;HIRMFO/DAD,WAA-HUNT: SEX ;8/9/95  12:18
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN1(D0,SPNSEX) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"SEX") = M^MALE ! F^FEMALE
 ;  SPNSEX = M ! F
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DFN,MEETSRCH,SEX,VA,VADM,VAERR
 S MEETSRCH=0
 S DFN=+$P($G(^SPNL(154,+D0,0)),U)
 D DEM^VADPT
 I 'VAERR D
 . S SEX=$P($G(VADM(5)),U)
 . I SEX]"",SEX=SPNSEX S MEETSRCH=1
 . Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)=$$EN1^SPNPSR02(D0,SEX)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"SEX") = M^MALE ! F^FEMALE
 ;
 N DIR,DIRUT,DTOUT,DUOUT,SEX
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="SOAM^M:MALE;F:FEMALE;"
 S DIR("A")="Patient sex: "
 S DIR("?")="Enter M(ale) or F(emale)"
 D ^DIR S:Y'="" SEX=Y_U_$G(Y(0))
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"SEX")=SEX
 .S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR02(D0,"""_$P(SEX,U)_""")"
 .Q
 Q
