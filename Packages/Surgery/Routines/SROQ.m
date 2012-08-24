SROQ ;BIR/ADM - QUARTERLY REPORT ;08/23/2011
 ;;3.0;Surgery;**62,70,95,176**;24 Jun 93;Build 8
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 W @IOF,!,"This report is no longer available."
 W !! K DIR S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC W @IOF
 Q
