SPNRPCIC ;SD/WDE -FLIPS ICN TO DFN;Mar 07, 2007
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;DBIA REFERENCE (#4938)
 ;
 ;  Input:
 ;  DFN=DFN
 ;  
 ;
FLIP(ICN) ;flips icn to dfn for
 K DFN
 S DFN="",DFN=$O(^DPT("AICN",ICN,DFN))
 Q DFN
 Q
