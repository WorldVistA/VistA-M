SPNJRPCS ;BP/JAS - Returns VA SCI Status ;Dec 15, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,57 supported by IA #4946
 ;
 ; Parm values:
 ;     RETURN is the VA SCI Status for patient
 ;
 ; Returns: RETURN($J)
 ;
COL(RETURN,ICN) ;
 ;***************************
 K RETURN
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 S VAS=$$GET1^DIQ(2,DFN_",",57.4,"I")
 S VASN=$$GET1^DIQ(2,DFN_",",57.4)
 I VAS=1!(VAS=2)!(VAS=3)!(VAS=4)!(VAS="X") S VASN=VAS_" = "_VASN
 I VAS'=1&(VAS'=2)&(VAS'=3)&(VAS'=4)&(VAS'="X") S VASN="X = NOT APPLICABLE"
 S RETURN($J)=VASN_"^EOL999"
 K DFN,VAS,VASN
 Q
