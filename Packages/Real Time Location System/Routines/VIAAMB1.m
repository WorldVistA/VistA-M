VIAAMB1 ;ALB/CR - RTLS Ping Test Utility ;5/4/16 10:54am
 ;;1.0;RTLS;**3**;April 22, 2013;Build 20
 ;
 ; Access to file #6910 covered by IA #5920
 ; This RPC is a simple test to verify that the VistA system is up
 ; and running along with the VIAA patch installed. No input is
 ; required from the calling application.
 ;
PINGRP(RETSTA) ; - Test that VistA is up with VIAA patch installed
 ; RPC: VIAA ENG GET PRIMARY STATION
 ; Output:  passed via the variable RETSTA consists of the primary
 ;          station number for the site
 N PSTATION
 ; the Engineering package must have one entry that reflects 
 ; the primary station for the site
 S PSTATION=+$P($G(^DIC(6910,1,0)),U,2)
 S RETSTA=PSTATION ; primary station # for the site
 Q
