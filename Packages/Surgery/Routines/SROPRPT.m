SROPRPT ;BIR/MAM,ADM - OPERATION REPORT ;09/02/04
 ;;3.0; Surgery ;**63,66,96,100,136,140**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ;I '$D(SRSITE) D ^SROVAR G:'$D(SRSITE) END S SRSITE("KILL")=1
 ;checks if multi-divisional exists
 I '$D(SRTN) D ^SROPS G:'$D(SRTN) END S SRTN("KILL")=1
 ;Variable MAGTMPR2 is being set by routine MAGGTRPT (IMAGING Package).
 I '$D(MAGTMPR2) D HOME^%ZIS
IM N SRSINED,SRSTAT,SRDTITL,SRTIU
 S SRDTITL="Operation Report"
 S SRSINED=0,SRSTAT="",SRTIU=$P($G(^SRF(SRTN,"TIU")),"^")
 I SRTIU S SRSTAT=$$STATUS^SROESUTL(SRTIU) S:SRSTAT=7 SRSINED=1
 ;Code for Imaging ; SRR 5/22/94
 I IOST["C-IMPC",$D(^SRF(SRTN,2005)) S SRIMAGE=1
 I IOST["P-" D DISPLY,END Q  ; WISC/GEK - DELPHI APP
 ;End Code for Imaging.
 D DISPLY,END
 Q
DISPLY I SRSINED S SRTIU=$P($G(^SRF(SRTN,"TIU")),"^") I SRTIU D PRNT^SROESPR(SRTN,SRTIU,SRDTITL) Q
 I 'SRSINED W !!," * * The Operation Report for this case is not yet available. * *" D LAST
 Q
END K ^TMP("SROP",$J)
 W @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^SRSKILL K VAIN,VAINDT I $D(SRSITE("KILL")) K SRSITE
 I $D(SRTN("KILL")) K SRTN
 Q
LAST I IOST'["P-" W ! K DIR S DIR(0)="E" D ^DIR K DIR
 Q
CODE ; entry point from coding menu
 N SRSINED,SRSTAT,SRDTITL,SRTIU
 S SRDTITL="Operation Report"
 S SRSINED=0,SRSTAT="",SRTIU=$P($G(^SRF(SRTN,"TIU")),"^")
 I SRTIU S SRSTAT=$$STATUS^SROESUTL(SRTIU) S:SRSTAT=7 SRSINED=1
 D DISPLY,END
 Q
