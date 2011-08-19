IBACVA ;ALB/CPM - PROCESS CHAMPVA PATIENT MOVEMENTS ; 27-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**27**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PROC ; Process patient movements for CHAMPVA inpatients.
 ;
 ; - quit if the software is not fully installed
 I '$$ON^IBACVA2() G PROCQ
 ;
 ; - send bulletin for CHAMPVA admissions
 I DGPMP="",$P(DGPMA,"^",2)=1 D ADM^IBACVA2 G PROCQ
 ;
 ; - determine if admission has been billed
 S IBCVAPM=$P($S(DGPMA:DGPMA,1:DGPMP),"^",14)
 S IBCVA=$P(+$G(^DGPM(IBCVAPM,0)),".")
 S:'IBCVA IBCVA=+DGPMP\1
 S IBBILLED=$$PREV^IBACVA1(DFN,IBCVA,IBCVAPM)
 ;
 ; - if admission was deleted, cancel the charge (if billed)
 I DGPMA="",$P(DGPMP,"^",2)=1 G:'IBBILLED PROCQ D  G PROCQ
 .S IBCRES=$O(^IBE(350.3,"B","CHAMPVA ADMISSION DELETED",0))
 .S:'IBCRES IBCRES=24
 .D UPSTAT^IBECEAU4(IBBILLED),DEL^IBACVA2(DFN,IBBILLED,+DGPMP)
 ;
 ; - if delete a discharge -> bulletin
 I DGPMA="",$P(DGPMP,"^",2)=3 D WARN^IBACVA2(+DGPMP,0) G PROCQ
 ;
 ; - if edit a discharge, change date -> bulletin
 I DGPMA,DGPMP,$P(DGPMA,"^",2)=3,$P(+DGPMA,".")'=$P(+DGPMP,".") D WARN^IBACVA2(+DGPMP,+DGPMA) G PROCQ
 ;
 ; - if discharged, bill the subsistence charge
 I DGPMP="",$P(DGPMA,"^",2)=3,'IBBILLED D
 .S IBSL=IBCVAPM,IBBDT=$$FMTH^XLFDT(IBCVA,1),IBEDT=$$FMTH^XLFDT(+DGPMA\1,1)
 .D BILL^IBACVA1
 ;
PROCQ K IBY,IBFAC,IBSITE,IBSERV,IBSL,IBCHGT,IBBILLED,IBBDT,IBEDT,IBD,IBDT
 K IBCHG,IBFR,IBTO,IBATYP,IBLIM,IBN,IBUNIT,IBCVA,IBBILLED,IBCVAPM
 K %H,VA,VAIP,VAERR,X
 Q
