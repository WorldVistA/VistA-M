SROQ0A ;BIR/ADM - QUARTERLY REPORT (CONTINUED) ;08/23/2011
 ;;3.0;Surgery;**37,38,62,70,88,103,129,142,176**;24 Jun 93;Build 8
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ;
RS ; surgical residents used?
 N SRK,SRDIV,SRSITE S SRK=0,SRDIV=$P($G(^SRF(SRTN,8)),"^") I SRDIV S SRSITE=$O(^SRO(133,"B",SRDIV,0)),Y=$P(^SRO(133,SRSITE,0),"^",19) I Y=0 D  Q
 .I $P(^SRF(SRTN,0),"^",9)<3040401 S SRATT=1 Q
 .S SRATT=9 Q
 S SRATT=99
 Q
ADM ; check for admission within 14 days of surgery
 S (SRSDATE,X1)=$P($G(^SRF(SRTN,.2)),"^",12),X2=14 D C^%DTC S SR14=X
 S SRSDATE=$O(^DGPM("APTT1",DFN,SRSDATE)) I SRSDATE,SRSDATE'>SR14 S SRADMT=SRADMT+1
 Q
