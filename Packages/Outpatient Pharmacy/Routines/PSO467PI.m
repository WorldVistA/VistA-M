PSO467PI ;ALB/BWF - patch 467 pre-install ; 10/09/2016 10:43am
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
PRE ;
 I '$D(^XUSEC("XUMGR",DUZ)) D
 .D EN^DDIOL("The user installing this patch must hold the 'XUMGR' security key.")
 .D EN^DDIOL("Install Aborted. Please have someone who holds the 'XUMGR' security")
 .D EN^DDIOL("install this patch.") S XPDABORT=1
 Q
