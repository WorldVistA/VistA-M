VIAAMB2 ;ALB/CR - RTLS Ping Test for Cath Lab ;4/22/16 3:08 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;
 ;
 ; This RPC is a simple test to verify that the CATH Lab
 ; patch VIAA*1.0*4 has been installed at the site and that
 ; the system is up and running. No input is required from
 ; the calling application.
 ;
PINGRP(RETSTA) ; - Test that VistA is up with the patch installed
 ; RPC: VIAA GET CATHLAB PATCH STATUS
 ; Output:  string passed via the variable RETSTA, consists of
 ;          the RTLS Pkg version installed in VistA and the VistA
 ;          patch number for Cath Lab support
 ;
 N PATCH,PATCHED,RTLSVER
 S RETSTA=""
 S PATCH="VIAA*1.0*4"
 S RTLSVER=$$VERSION^XPDUTL("VIAA")
 S PATCHED=$$PATCH^XPDUTL(PATCH)
 I +$G(RTLSVER)=1,$G(PATCHED)=1 S RETSTA="RTLS INSTALLED^1^VIAA*1.0*4"
 Q
