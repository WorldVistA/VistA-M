DGPMGLG4 ;ALB/ABR - G&L GENERATION CONT.;  17 MAY 94
 ;;5.3;Registration;**34**;Aug.13, 1993
 ;
 ;This routine finds the division associated with a given
 ;Treating Specialty transaction.
 ;
 ;It finds the division of the ward where the patient is
 ;located at the time of the TS transaction.
 ;
 ;Variables:
 ;        LTSDV - last treating specialty division.
 ;              this is the division for the current treating specialty transaction.
 ;        PTSDV - previous treating specialty division.
 ;
TSDIV ;entry point for division search
 S LTSDV=$$TSDV(+MV("LWD"))
 ;
TSDIVP ;  entry point for Previous TS division only
 ;
 ;If transaction is a TS/Provider change, without an associated
 ;physical movement, then the previous TS division will be the same as
 ;the current division.
 I MV("TT")=6,'$P(MD,"^",24) S PTSDV=LTSDV Q
 S PTSDV=$$TSDV(+MV("PWD"))
 Q
 ;
TSDV(X) ; This function returns the TS division
 N DV
 S DV=$P($G(^DIC(42,+X,0)),"^",11)
 I '$D(^DG(40.8,+DV,0)) S DV=DIV
 Q +DV
 Q
ASIHR ;to find PTS, PTSDV for returns from ASIH
 N J1,J2,T,PMT
 S J1=J
 F  S J1=$O(^DGPM("APMV",DFN,MV("CA"),J1)) Q:'J1  S J2=$O(^(J1,0)) D  Q:$D(T)
 .S PMT=$P(^DGPM(J2,0),"^",18),PMT="^"_PMT_"^"
 .I '$F("^13^43^44^45^",PMT) S T=1
 I '$D(T) Q
 S MV("PWD")=$P($G(^DGPM(J2,0)),"^",6),PTSDV=$$TSDV(MV("PWD")) ; find division for previous TS
 S J1=$O(^DGPM("ATS",DFN,MV("CA"),9999999.9999999-MD)),J2=$O(^(J1,0)),MV("PTS")=J2 ; find previous TS
 Q
