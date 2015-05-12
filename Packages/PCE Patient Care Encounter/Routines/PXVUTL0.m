PXVUTL0 ;BIR/ADM - VIMM UTILITY ROUTINE ;01/29/2015
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**208**;Aug 12, 1996;Build 5
 ;
 Q
SERIES() ; called from screen on SERIES field (#.04) in file #9000010.11
 ; returns max # - If no MAX # IN SERIES is defined in IMMUNIZATION file, 
 ;   8 is returned.
 ; PXD is defined by new immunization entry process in PCE and is the 
 ;   value of Y from the DIR call to select an immunization.
 ;
 N PXMAX,PXDA
 S:$G(DA) PXMAX=$P($G(^AUTTIMM($P($G(^AUPNVIMM(DA,0)),"^"),0)),"^",5)
 I '$G(DA),$G(PXD) S PXDA=+PXD S:PXDA PXMAX=$P($G(^AUTTIMM(PXDA,0)),"^",5)
 S:$G(PXMAX)="" PXMAX=8
 Q PXMAX
