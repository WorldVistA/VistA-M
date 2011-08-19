DIPS94 ;SFOIFO/MKO-Recompile forms affected changed by XU*8*214 ;10:33 AM  19 Nov 2001
 ;;22.0;VA FileMan;**94**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RECOMP ;
 N DIPSFORM
 S DIPSFORM=$O(^DIST(.403,"B","XUEXISTING USER",0)) Q:'DIPSFORM
 D ENGRP^DDSZ(DIPSFORM)
 Q
