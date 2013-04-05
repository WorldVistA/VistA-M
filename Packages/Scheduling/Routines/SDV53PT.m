SDV53PT ;alb/mjk - SD Post-Init Driver for v5.3 ; 3/26/93
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
EN ; -- main entry point
 D DEL
ENQ Q
 ;
DEL ; -- delete namespace ^TMP nodes
 K ^TMP("SDAMRPT"),^TMP("SDAMTOT")
 Q
