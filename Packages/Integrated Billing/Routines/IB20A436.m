IB20A436 ;BP-OIFO/RBN - PRE-INSTALL FOR IB*2.0*436; 11/25/2008 ; 7/21/2010
 ;;2.0;INTEGRATED BILLING;**436**;21-MAR-94;Build 31
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; DESCRIPTION: This routine is the preinstall routine for IB*2.0*436.  It deletes
 ;              two triggers, one on filed #.01 and the other on field #.02 of
 ;              file #355.93
 ; 
 ; INPUTS     : None
 ; 
 ; OUTPUTS    : None
 ; 
 ; VARIABLES  : None
 ;              
 ; 
 ; GLOBALS      : ^IBA(355.93  - The VistA IB NON/OTHER VA BILLING PROVIDER file
 ;                       
 ; 
 ; FUNCTIONS    : None
 ; 
 ; SUBROUTINES  : None
 ; 
 ; 
 ; HISTORY      : Original version - 9 September 2010
 ; 
 ;
 ; 
EN ;
 D DELXRF
 Q
 ;
DELXRF ; Delete triggers 3 and 8 from file 355.9 fields .01 and .02 respectively.
 D DELIX^DDMOD(355.93,.01,3)
 D DELIX^DDMOD(355.93,.02,8)
 Q
 ;
