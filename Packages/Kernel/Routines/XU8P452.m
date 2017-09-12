XU8P452 ;OAK_BP/CMW - NPI EXTRACT REPORT ;21-feb-07
 ;;8.0;KERNEL;**452**; Jul 10, 1995;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; NPI Extract Report
 ; 
 Q
PRE ; run pre-routine
 ; Remove ^XTMP for full rerun
 K ^XTMP("XUSNPIX1")
 K ^XTMP("XUSNPIX2")
 K ^XTMP("XUSNPIX1NV")
 K ^XTMP("XUSNPIX2NV")
 ;
 Q
POST ; run post-routine
 ; To add the codes to person class
 DO POST^XUMF416
 ; To reload the NPI and taxonomy
 DO EN^XUMF416
 ;
 Q
