HMPMONH ;ASMR/BL, Monitor history ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ;for future enhancements, not implemented as of 7 September 2016
UH ;
 N Y S Y="Monitor History" W !,$J(Y,40-($L(Y)\2)) D RTRN2CON^HMPMONL Q
 ;
EH ;
 N Y S Y="Examine History" W !,$J(Y,40-($L(Y)\2)) D RTRN2CON^HMPMONL Q
 ;
MH ;
 N Y S Y="Manage History" W !,$J(Y,40-($L(Y)\2)) D RTRN2CON^HMPMONL Q
 ;
