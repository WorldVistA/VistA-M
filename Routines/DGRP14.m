DGRP14 ;ALB/MRL/EG/GAH - REGISTRATION SCREEN 14/APPOINTMENT INFORMATION ; 10/18/06
 ;;5.3;Registration;**568,585,725,770**;Aug 13, 1993;Build 4
 S DGRPS=14 D H^DGRPU S (Z,DGRPW)=1 D WW^DGRPV W " Enrollment Clinics: "
 S I1=""
 F I=0:0 S I=$O(^DPT(DFN,"DE",I)) Q:'I  D:$P(^(I,0),U,2)'="I"
 . S I1=1,X=$S($D(^SC(+^(0),0)):$P(^(0),U,1)_", ",1:"")
 . W:(79-$X)<$L(X) !?24 W X
 W:'I1 "NOT ACTIVELY ENROLLED IN ANY CLINICS AT THIS TIME"
 W ! S Z=2 D WW^DGRPV W "     Pending Appt's",?18,": " S I1="",I2=DT_".9999"
 N DGARRAY,APTDT,CLIFN,CLNAM
 S DGARRAY("FLDS")="1;2;3",DGARRAY(3)="R;I;NT",DGARRAY(4)=DFN,DGARRAY(1)=DT,DGARRAY("SORT")="P"
 S I1=$$SDAPI^SDAMA301(.DGARRAY)
 ;Check for appointment retrieval error.
 I I1<0 W $$FAPCHK^DGENRPD2 G Q
 S APTDT=0
 F  S APTDT=$O(^TMP($J,"SDAMA301",DFN,APTDT)) Q:'APTDT  D
 .;check to see if appointment is cancelled, if so
 .;ignore this appointment eg 01/25/2005
 .;I $$CANCEL(DFN,APTDT)="Y" Q TAKEN OUT IN PATCH 770.
 .S CLNAM=$P($P(^TMP($J,"SDAMA301",DFN,APTDT),U,2),";",2)
 .S X=$S(CLNAM]"":CLNAM,1:"UNKNOWN CLINIC")_" ("_$$FMTE^DILIBF(APTDT,"5U")_"), " W:(79-$X)<$L(X) !?24 W X
 .Q
 I 'I1 W "NO PENDING APPOINTMENTS ON FILE"
Q K I,I1,I2,X,Y,DGARRAY,APTDT,CLNAM,^TMP($J,"SDAMA301") G ^DGRPP
 ;
 ;input DFN - patient id
 ;      APPDATE - appointment date
 ;return Y - Yes
 ;       N - No
CANCEL(DFN,APPDATE) ;
 N X,STATUS,U
 S U="^"
 S X=$G(^DPT(DFN,"S",APPDATE,0))
 I X="" Q "Y"  ;probably bad data
 S STATUS=$P(X,U,2)
 I STATUS="" Q "N"
 I STATUS="I" Q "N"
 Q "Y"
