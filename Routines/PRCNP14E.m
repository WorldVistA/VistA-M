PRCNP14E ;ALB/RLC - PATCH PRCN*1.0*14 ENVIRONMENTAL CHECK ;[2/10/2004 11:50]
 ;;1.0;Equipment/Turn-In Request;**14,15**;Sep 13, 1996
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CHECK ; Check for Equipment/Turn-In Request Shutdown
 N X S X="PRCLOP4" X ^%ZOSF("TEST") I $T,$$SYS^PRCLOP4>0 D  S XPDQUIT=1 Q
 . N PRCT S PRCT(1)="Equipment/Turn-In Request (PRCN) has been shut down, so no"
 . S PRCT(2)="further PRCN patches should be installed." D MES^XPDUTL(.PRCT)
 Q
