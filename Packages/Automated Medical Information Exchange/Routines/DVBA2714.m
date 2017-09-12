DVBA2714 ;ALB/ABR - ENVIRONMENT CHECK ROUTINE;16-JAN-1998
 ;;2.7;AMIE;**14**;Apr 10, 1995
 ;
EN ;Main entry point for patch DVBA*2.7*14 environment check routine
 ;
 ;Input  : All variables set by KIDS
 ;Output : Variables required by KIDS to denote success or failure
 ;         of environment check (XPDQUIT and XPDABORT)
 ;
 N PATCHED
 ;
 ;Check for installation of DVBA*2.7*15 - required for install
 I $T(+2^DVBADSCK)'["15" D
 .W !!,"      *** Required element missing ***"
 .W !,"      Installation of this patch requires patch DVBA*2.7*15"
 .W !
 .S XPDABORT=2
 Q
UPDATE ;  update package file for patch DVBA*2.7*15
 N PATCH,PKG,UPD
 S PATCH="15 SEQ #14^"_DT_"^.05"
 S PKG=$O(^DIC(9.4,"B","AUTOMATED MED INFO EXCHANGE",0)) Q:'PKG
 S UPD=$$PKGPAT^XPDIP(PKG,2.7,.PATCH)
 Q
