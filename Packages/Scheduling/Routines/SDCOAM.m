SDCOAM ;ALB/RMO - Appt Mgmt Actions - Check Out; 11 FEB 1993 10:00 am
 ;;5.3;Scheduling;**1,20,27,66,132**;08/13/93
 ;
CO(SDCOACT,SDCOACTD) ;Check Out Classification, Provider and Diagnosis
 ;                Actions on Appt Mgmt
 N DFN,SDCL,SDCOAP,SDDA,SDOE,SDT,VALMY
 S VALMBCK=""
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 S SDCOAP=0
 F  S SDCOAP=$O(VALMY(SDCOAP)) Q:'SDCOAP  D
 .I $D(^TMP("SDAMIDX",$J,SDCOAP)) K SDAT S SDAT=^(SDCOAP) D
 ..W !!,^TMP("SDAM",$J,+SDAT,0)
 ..S DFN=+$P(SDAT,"^",2),SDT=+$P(SDAT,"^",3),SDCL=+$P(SDAT,"^",4),SDDA=$$FIND^SDAM2(DFN,SDT,SDCL)
 ..S SDOE=+$P($G(^DPT(DFN,"S",SDT,0)),"^",20)
 ..I 'SDOE!('$$CODT^SDCOU(DFN,SDT,SDCL)) W !!,*7,">>> The appointment must have a check out date/time to update ",SDCOACTD,"." D PAUSE^VALM1 Q
 ..D ACT(SDCOACT,SDOE,DFN,SDT,SDCL,SDDA,+SDAT)
 S VALMBCK="R"
 K SDAT
COQ Q
 ;
ACT(SDCOACT,SDOE,DFN,SDT,SDCL,SDDA,SDLNE) ; -- Check Out Actions
 N SDCOMF,SDCOQUIT,SDHL,SDVISIT,SDATA,SDHDL
 ;
 S SDVISIT=+$P($G(^SCE(+SDOE,0)),U,5)
 ;
 ; -- quit if not ok to edit
 IF '$$EDITOK^SDCO3($G(SDOE),1) G ACTQ
 ;
 ; -- set pce action parameter
 S SDPXACT=""
 I $G(SDCOACT)="CL" S SDPXACT="SCC"
 I $G(SDCOACT)="PR" S SDPXACT="PRV"
 I $G(SDCOACT)="DX" S SDPXACT="POV"
 I $G(SDCOACT)="CPT" S SDPXACT="CPT"
 ;
 ; -- quit if no action set
 IF SDPXACT="" G ACTQ
 ;
 ; -- do pce interview then rebuild appt list
 S X=$$INTV^PXAPI(SDPXACT,"SD","PIMS",.SDVISIT,.SDHL,DFN)
 D BLD^SDAM
ACTQ Q
 ;
PD ;Entry point for SDAM PATIENT DEMOGRAPHICS protocol
 N SDCOAP,VALMY
 S VALMBCK=""
 D FULL^VALM1
 I SDAMTYP="P" W !!,VALMHDR(1),! D DEM(SDFN)
 I SDAMTYP="C" D
 .D EN^VALM2(XQORNOD(0))
 .S SDCOAP=0 F  S SDCOAP=$O(VALMY(SDCOAP)) Q:'SDCOAP  D
 ..I $D(^TMP("SDAMIDX",$J,SDCOAP)) K SDAT S SDAT=^(SDCOAP) D
 ...W !!,^TMP("SDAM",$J,+SDAT,0),!
 ...D DEM(+$P(SDAT,"^",2))
 S VALMBCK="R"
PDQ Q
 ;
DEM(DFN) ;Demographics
 D QUES^DGRPU1(DFN,"ADD")
 Q
 ;
DC ;Entry point for SDAM DISCHARGE CLINIC protocol
 N SDCOAP,VALMY
 S VALMBCK=""
 D FULL^VALM1
 I SDAMTYP="P" W !!,VALMHDR(1),! D DIS(SDFN)
 I SDAMTYP="C" D
 .D EN^VALM2(XQORNOD(0))
 .S SDCOAP=0 F  S SDCOAP=$O(VALMY(SDCOAP)) Q:'SDCOAP  D
 ..I $D(^TMP("SDAMIDX",$J,SDCOAP)) K SDAT S SDAT=^(SDCOAP) D
 ...W !!,^TMP("SDAM",$J,+SDAT,0),!
 ...D DIS(+$P(SDAT,"^",2),$P(SDAT,"^",4))
 S VALMBCK="R"
DCQ Q
 ;
DIS(SDFN,SDCLN) ;Discharge from Clinic
 N SDAMERR
 D ^SDCD
 I $D(SDAMERR) D PAUSE^VALM1
 Q
 ;
DEL ;Entry point for SDAM DELETE CHECK OUT protocol
 I '$D(^XUSEC("SD SUPERVISOR",DUZ)) W !!,*7,">>> You must have the 'SD SUPERVISOR' key to delete an appointment check out." D PAUSE^VALM1 S VALMBCK="R" G DELQ
 N DFN,SDCL,SDCOAP,SDDA,SDOE,SDT,VALMY,VALSTP
 S VALMBCK="",VALSTP="" ;VALSTP is used in scdxhldr to identify deletes
 D EN^VALM2(XQORNOD(0))
 D FULL^VALM1
 S SDCOAP=0
 F  S SDCOAP=$O(VALMY(SDCOAP)) Q:'SDCOAP  D
 .I $D(^TMP("SDAMIDX",$J,SDCOAP)) K SDAT S SDAT=^(SDCOAP) D
 ..W !!,^TMP("SDAM",$J,+SDAT,0)
 ..S DFN=+$P(SDAT,"^",2),SDT=+$P(SDAT,"^",3),SDCL=+$P(SDAT,"^",4),SDDA=$$FIND^SDAM2(DFN,SDT,SDCL)
 ..S SDOE=+$P($G(^DPT(DFN,"S",SDT,0)),"^",20)
 ..I 'SDOE!('$$CODT^SDCOU(DFN,SDT,SDCL)) W !!,*7,">>> The appointment must have a check out date/time to delete." D PAUSE^VALM1 Q
 ..I '$$ASK Q
 ..N SDATA,SDELHDL
 ..IF '$$EDITOK^SDCO3(SDOE,1) Q
 ..S SDELHDL=$$HANDLE^SDAMEVT(1)
 ..D EN^SDCODEL(SDOE,1,SDELHDL),PAUSE^VALM1
 ..D BLD^SDAM
 ..S SDOE=$$GETAPT^SDVSIT2(DFN,SDT,SDCL)
 S VALMBCK="R"
 K SDAT
DELQ Q
 ;
ASK() ;Ask if user is sure they want to delete the check out
 N DIR,DTOUT,DUOUT,Y
 W !!,*7,">>> Deleting the appointment check out will also delete any check out related",!?4,"information.  This information may include classifications, procedures,",!?4,"providers and diagnoses."
 S DIR("A")="Are you sure you want to delete the appointment check out"
 S DIR("B")="NO",DIR(0)="Y" W ! D ^DIR
 Q +$G(Y)
