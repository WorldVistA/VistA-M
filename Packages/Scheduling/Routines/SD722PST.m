SD722PST ; ALB/ZEB - SD*5.3*722 POST-INSTALL ROUTINE ;1/10/19  13:44
 ;;5.3;Scheduling;**722**;Aug 13, 1993;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;  Post-install routine for patch 722. Builds the APTDT cross-reference
 ;
 D APTDT
 Q  ;call at tags
 ;
APTDT ;build APTDT cross-reference for patient appointments
 I '$D(^SDEC("APTDT")) N DIK S DIK="^SDEC(409.84,",DIK(1)=".05^APTDT" D ENALL^DIK
 Q
