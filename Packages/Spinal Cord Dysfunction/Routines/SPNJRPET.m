SPNJRPET ;BP/JAS - Returns VA Ethnicity info ;Dec 06, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to API DEM^VADPT supported by IA #10061
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN is the ethnicity info for a given ICN
 ;     ICN is the indentifier for the spinal cord patient
 ;     
 ;Returns: ^TMP($J)
 ;
COL(RETURN,ICN) ;
 ;***************************
 K ^TMP($J)
 S RETURN=$NA(^TMP($J)),RETCNT=1
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 D DEM^VADPT
 S ENUM=VADM(11)
 I ENUM=0 S ^TMP($J,RETCNT)="NO ETHNICITY INFO AVAILABLE^EOL999" Q
 F I=1:1:ENUM S EREC=VADM(11,I),^TMP($J,RETCNT)=$P(EREC,"^",2)_"^EOL999",RETCNT=RETCNT+1
 K DFN,I,ENUM,EREC,RETCNT
 K VADM  ;WDE
 Q
