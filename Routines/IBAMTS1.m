IBAMTS1 ;ALB/CPM - PROCESS NEW OUTPATIENT ENCOUNTERS ; 22-JUL-93
 ;;2.0;INTEGRATED BILLING;**20,52,132,153,166,156,167,247,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NEW ; Appointment fully processed - prepare a new charge.
 ;
 ;  ibbilled is set to 1 if the patient has already been billed on this
 ;  date.  if the date is after 12/5/01, check the type of bill to see
 ;  if it is an upgrade from primary (1st bill) to specialty (new bill)
 I IBBILLED D:IBDAT'<3011206 CHKPRIM I IBBILLED G NEWQ
 ;
 ; - for registrations, get disposition, and use log-out date/time
 I IBORG=3 D  G:'IBDISP NEWQ
 .S IBDISP=+$P($G(^TMP("SDEVT",$J,SDHDL,IBORG,"DIS",0,"AFTER")),"^",7)
 .Q:'IBDISP
 .S IBTEMP=+$P($G(^TMP("SDEVT",$J,SDHDL,IBORG,"DIS",0,"AFTER")),"^",6)
 .S:IBTEMP IBDT=IBTEMP,IBDAT=$P(IBDT,".")
 ;
 I '$$BIL^DGMTUB(DFN,IBDT) G NEWQ ; patient is not Means Test billable
 ;
 ; - perform batch of edits
 I '$$CHKS G NEWQ
 ;
 ; - quit if AO/IR/SWA/MST/HNC/CV/SHAD exposure is indicated, or SC related
 D CLSF(0,.IBCLSF)
 I IBCLSF[1 G NEWQ
 ;
 S IBSL="409.68:"_IBOE
 ;
BLD ; - build the charge. May also enter from IBAMTS2 (requires IBSL)
 ;
 ;  find the clinic stop code in 409.68 (dbia402) and find the matching
 ;  entry in file 352.5.  the 352.5 entry is populated in the 350 field
 ;  for reference using the ibstopda variable
 N %,IBSTOPDA,IBTYPE
 S %=$$GETSC^IBEMTSCU(IBSL,IBDAT) I % S IBSTOPDA=%
 ;
 ;  get the rate, ibtype = primary or specialty
 S IBTYPE=$P($G(^IBE(352.5,+$G(IBSTOPDA),0)),"^",3) I IBTYPE=0 Q
 ;  if the type is not defined, must be a local created sc, set it to primary
 I 'IBTYPE S IBTYPE=1
 S IBX="O" D TYPE^IBAUTL2 G:IBY<0 NEWQ
 S IBUNIT=1,(IBFR,IBTO)=IBDAT,IBEVDA="*"
 D ADD^IBECEAU3 G:IBY<0 NEWQ
 ;
 ; - if enctr is exempt from classification, but patient isn't, send msg
 I $$EXOE^SDCOU2($S($G(IBOEN):IBOEN,1:IBOE)),$$CLPT(DFN,IBDAT) D BULL^IBAMTS
 ;
 ; - if the opt billing rate is over a year old, place the charge on hold
 ;I $$OLDRATE(IBRTED,IBFR) D  G CLOCK
 ;.S DIE="^IB(",DA=IBN,DR=".05////20" D ^DIE K DIE,DA,DR
 ;
 ; - drop the charge into the background filer
 D IBFLR G:IBY<0 NEWQ
 ;
 ; - if there is no active billing clock, add one
CLOCK I '$D(^IBE(351,"ACT",DFN)) S IBCLDT=IBDAT D CLADD^IBAUTL3
 ;
NEWQ I IBY<0 D ^IBAERR1
 K IBDISP,IBCLSF,IBCLDA,IBMED,IBCLDT,IBN,IBBS,IBTEMP
 K IBUNIT,IBFR,IBTO,IBSL,IBEVDA,IBX,IBDESC,IBATYP,IBCHG
 Q
 ;
CHKS() ; Perform a batch of edits to determine whether to bill.
 ;  Input variables required:   IBEVT  --  encounter
 ;                             IBAPTY  --  appt type
 ;                              IBDAT  --  appt date
 ;                               IBDT  --  appt date/time
 ;                              IBORG  --  originating process
 ;                             IBDISP  --  disposition (if registration)
 N IBRESULT
 ;
 ;  default is fail the checks
 S IBRESULT=0
 ;
 ;  for appts prior to 12/6/2001
 I IBDAT<3011206 D  Q IBRESULT
 .   ; - non-count clinic
 .   I $P($G(^SC(+$P(IBEVT,"^",4),0)),"^",17)="Y" Q
 .   ;
 .   ; - non-billable appointment type
 .   I $$IGN^IBEFUNC(IBAPTY,IBDAT) Q
 .   ;
 .   ; - non-billable disposition/stop code/clinic
 .   I IBORG=1!(IBORG=2),$$NBCL^IBEFUNC(+$P(IBEVT,"^",4),IBDT) Q
 .   I IBORG=1!(IBORG=2),$$NBCSC^IBEFUNC(+$P(IBEVT,"^",3),IBDT) Q
 .   I IBORG=3,$$NBDIS^IBEFUNC(IBDISP,IBDT) Q
 .   ;
 .   ; - ignore if checked out late and pt was an inpatient at midnight
 .   I DT>IBDAT,$$INPT(DFN,IBDAT_".2359") Q
 .   ;
 .   ;  pass the checks
 .   S IBRESULT=1
 ;
 ;  for appts on or after 12/6/2001
 ;
 ; - non-billable appointment type
 I $$IGN^IBEFUNC(IBAPTY,IBDAT) Q 0
 ;
 ; - non-count clinic
 I $P($G(^SC(+$P(IBEVT,"^",4),0)),"^",17)="Y" Q 0
 ;
 ; - ignore if checked out late and pt was an inpatient at midnight
 I DT>IBDAT,$$INPT(DFN,IBDAT_".2359") Q 0
 ;
 ;  pass the checks
 Q 1
 ;
 ;
IBFLR ; Drop the charge into the IB Background filer.
 N IBSEQNO,IBNOS,IBNOW,IBTOTL,IBSERV,IBWHER,IBFAC,IBSITE,IBAFY,IBARTYP,IBIL,IBTRAN
 D NOW^%DTC S IBNOW=%,IBNOS=IBN
 S IBSEQNO=$P($G(^IBE(350.1,+IBATYP,0)),"^",5) I 'IBSEQNO S IBY="-1^IB023"
 I IBY>0 D ^IBAFIL
 Q
 ;
CLPT(DFN,VDATE) ; Should the patient be asked the classification questions?
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;           VDATE  --  Visit date
 N IBARR D CL^SDCO21(DFN,VDATE,"",.IBARR)
 Q $D(IBARR)>0
 ;
INPT(DFN,VAINDT) ; Was the patient an inpatient at VAINDT?
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;          VAINDT  --  Date/time to check for inpatient status
 ; Output:       1 - inpatient | 0 - not an inpatient
 N VADMVT D ADM^VADPT2
 Q VADMVT>0
 ;
CLSF(IBUPD,Y) ; Examine classification questions.
 ;  Input:   IBUPD  --  0 if event just checked out
 ;                      1 if event is being updated
 ;               Y  --  array to place output
 ;  Output:  indicators returned as  ao^ir^sc^swa^mst^hnc^cv^shad [1|yes, 0|no]
 ;             if IBUPD=0, Y is returned as a single string
 ;             if IBUPD=1, Y("BEFORE"),Y("AFTER") are defined.
 N X,ZA,ZB S:'$G(IBUPD) Y="" S:$G(IBUPD) (Y("BEFORE"),Y("AFTER"))=""
 S X=0 F  S X=$O(^TMP("SDEVT",$J,SDHDL,IBORG,"SDOE",IBOE,"CL",X)) Q:'X  S ZB=$G(^(X,0,"BEFORE")),ZA=$G(^("AFTER")) D
 .I '$G(IBUPD) S:ZA $P(Y,"^",+ZA)=+$P(ZA,"^",3) Q
 .S $P(Y("BEFORE"),"^",+ZB)=+$P(ZB,"^",3),$P(Y("AFTER"),"^",+ZA)=+$P(ZA,"^",3)
 Q
 ;
OLDRATE(IBRTED,IBFR) ; See if the copay rate effective date is too old.
 ;  Input:   IBRTED  --  Charge Effective Date
 ;             IBFR  --  Visit Date
 ;  Output:       1  --  Effective Date is too old
 ;                0  --  Not
 ;
 N IBNUM,IBYR
 S IBNUM=$$FMDIFF^XLFDT(IBFR,IBRTED),IBYR=$E(IBFR,1,3)
 Q IBYR#4&(IBNUM>364)!(IBYR#4=0&(IBNUM>365))
 ;
 ;
CHKPRIM ;  check to see if patient has been billed for primary
 ;  and this is a specialty stop.  if so, cancel the primary
 ;  bill and let the software create the new specialty charge
 ;  input ibbilled  = last parent bill to check (ien 350)
 ;                    used to check the rate
 ;  output ibbilled = last parent bill number to prevent
 ;                    adding specialty charge
 N %,IBSTOPDA,IBTYPE,IBCRES,IBI,IBS
 ;
 ;  get the stop code for the 2nd visit on the same day
 S IBSTOPDA=$$GETSC^IBEMTSCU("409.68:"_IBOE,IBDAT) I 'IBSTOPDA Q
 ;
 ;  get the rate, ibtype = primary or specialty
 S IBTYPE=$P(^IBE(352.5,IBSTOPDA,0),"^",3)
 ;  if the new appt is not specialty, quit ... no need to create
 ;  a new charge
 I IBTYPE'=2 Q
 ;
 ;  if the last charge was billed at specialty, quit
 I $P($G(^IBE(352.5,+$P($G(^IB(+IBBILLED,0)),"^",20),0)),"^",3)=2 Q
 ;
 ;  cancel the charge
 ;  cancellation reason = billed at higher tier rate
 S IBCRES=6,IBS=$P($G(^IB(+IBBILLED,0)),"^",5)
 ;
 ; if not billed, on hold, or cacelled wait
 I IBS'=3!(IBS'=8)!(IBS'=10) F IBI=1:1:10 H 1 S IBS=$P($G(^IB(+IBBILLED,0)),"^",5) I IBS=3!(IBS=8)!(IBS=10) Q
 ;
 D CANC^IBAMTS2
 ;
 ;  set ibbilled = 0 to create the specialty charge
 S IBBILLED=0
 Q
