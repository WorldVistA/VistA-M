SCRPW78 ;BP-CIOFO/ESW - Clinic appointment availability extract ; 5/29/03 11:40am
 ;;5.3;Scheduling;**291**;AUG 13, 1993
 ;
 Q  ; Must not call this routine directly
 ;
SELECT(SDJN,SDPAT) N SDPT,DIC,Y S SDPT=0 N % S %=0 F  Q:(%=1&'SDPT)  S DIC=2,DIC(0)="QEAMIZ",DIC("A")="Select PATIENT NAME:" D ^DIC D
 .S SDPT=+Y
 .I SDPT>0 W !,"Correct Patient? " S %=1 D YN^DICN D:(%=1)  Q
 ..N SS S SS=$O(^TMP("SDPAT",SDJN,""),-1)
 ..S ^TMP("SDPAT",SDJN,SS+1)=SDPT_U_$P(^DPT(SDPT,0),U),SDPAT=SDPAT+1
 .I SDPT<0,SDPAT S %=1,SDPT=0 W !,SDPAT_" patient(s) selected",! Q
 .I SDPT<0 W !,"No Patient Selected, OK to proceed? " S %=1 D YN^DICN S SDPT=0
 Q
PRT5 ;print SDREPORT=5
 I $G(SDREPORT)'=5 Q
 N SC,DFN,SDIV,SDCP,SDDV,SDIVC,SDPNAME S DFN=""
 S SDPNAME="" F  S SDPNAME=$O(^TMP("SDORD",$J,SDPNAME)) Q:SDPNAME=""!SDOUT  D
 .S DFN="" F  S DFN=$O(^TMP("SDORD",$J,SDPNAME,DFN)) Q:DFN=""  D
 ..S SDIV="" F  S SDIV=$O(^TMP("SDIP",$J,SDIV)) Q:SDIV=""!SDOUT  D
 ...S SC=""
 ...F  S SC=$O(^TMP("SDIP",$J,SDIV,SC)) Q:SC=""  I $D(^TMP("SDIPLST",$J,DFN,SC)) D
 ....S SDCP=$P(^TMP("SDIP",$J,SDIV,SC),U),SDDV=$P(^(SC),U,2)
 ....S SDIVC=SDDV_U_SDIV
 ....D HDR^SCRPW76(1,SDREPORT,SDIVC,SDCP,SC) Q:SDOUT
 ....D OUT5^SCRPW77(DFN,SC) Q
 Q
GEN5A(SDAP0,DFN,SDADT,SDCL,SDWAIT,SDT,SDSFU,SDSDEV,SDSDDT,SDFLAG) ;generate ^TMP("SDIPLST" for a selected patient
 ;SDAP0 - zero node of appointment multiple
 ;        ^DPT(DFN,"S",SDADT,0)
 ;
 N SDPNAME,SDATA,SDSSN,SDREB,SDCMPL,SDSCHED,SDAST,SDASTO
 ;Get appointment status, rebook date, completion date and scheduler
 S SDAST=$P(SDAP0,U,2) S SDASTO=$S(SDAST="C":"CC",SDAST="CA":"CCA",SDAST="PC":"CP",SDAST="PCA":"CPA",1:SDAST)
 I SDASTO="" D
 .N SDATC S SDATC=$$STATUS^SDAM1(DFN,SDADT,SDCL,SDAP0)
 .I +SDATC=2 D  Q
 ..S SDASTO="CO"
 ..I $P(SDATC,";",3)["ACT REQ" S SDASTO="COA"
 .I +SDATC=11 S SDASTO="F" Q
 .I +SDATC=3 S SDASTO="NT" Q
 .I +SDATC=1 S SDASTO="CI"
 S SDREB=$P(SDAP0,U,10),SDCMPL=$P(SDAP0,U,14) S SDSCHED=$P($G(^SC(SDCL,"S",SDADT,1,1,0)),U,6) I SDSCHED="" S SDSCHED=$P(SDAP0,U,18)
 I SDASTO="CO" D
 .N SDE S SDE=$P(SDAP0,U,20),SDCMPL=$P(^SCE(SDE,0),U,7)
 S SDATA=$G(^DPT(DFN,0))
 S SDSSN=$P(SDATA,U,9),SDPNAME=$P(SDATA,U) Q:'$L(SDPNAME)
 S SDATA=SDSSN_U_$P(SDAP0,U,25)_U_SDFLAG_U_SDSDDT_U_SDSFU_U_SDWAIT_U_SDSDEV_U_SDREB_U_SDASTO_U_SDCMPL_U_SDSCHED
 S ^TMP("SDIPLST",$J,DFN,SDCL,SDT,SDPNAME,SDADT)=SDATA
 Q
FOOT(SDTX,SDLINE) ;
 I $G(SDREPORT(5)) D
 .S SDTX(5,1)=SDLINE
 .S SDTX(5,2)="NOTE: 'APPT TYPE' Values--'0' = user indicated 'Not next available' and calculation indicated 'Not next available' used"
 .S SDTX(5,3)="                          '1' = user indicated 'Next available' but calculation indicated next available appt not used"
 .S SDTX(5,4)="                          '2' = user indicated 'Not next available' but calculation indicated next available appointment used"
 .S SDTX(5,5)="                          '3' = user indicated 'Next available' and calculation indicated 'Next available' apppointment used"
 .S SDTX(5,6)="WAIT TIME: -------------- the difference between the 'DATE DESIRED' and 'APPT DATE/TIME'"
 .S SDTX(5,7)="TIME TO APPT.: ----------- days from 'DATE SCHEDULED' to 'APPT DATE/TIME'"
 .S SDTX(5,8)="APPT STATUS: N - No-show,   CC - Canceled by Clinic,  NA - No Show & Auto Rebook,   CCA -Canceled by  Clinic & Auto Rebook,"
 .S SDTX(5,9)="             I - Inpatient, CP - Canceled by Patient, CPA - Canceled by Patient & Auto Rebook, NT - No Action Taken,"
 .S SDTX(5,10)="             F - Future,    CI - Checked In,          COA - Checked Out/Action Required,       CO - Checked Out"
 .S SDTX(5,11)=SDLINE Q
 Q
