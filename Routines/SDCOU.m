SDCOU ;ALB/RMO - Utilities - Check Out;28 DEC 1992 10:00 am
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
CODT(DFN,SDT,SDCL) ; -- does appt have co date
 Q $P($G(^SC(SDCL,"S",SDT,1,+$$FIND^SDAM2(.DFN,.SDT,.SDCL),"C")),U,3)
 ;
CHK(SDSEL) ;Check if Appt can be Checked Out
 ; Input  -- SDSEL    Appt Selected in Appt Mgr
 ; Output -- 1=Yes and 0=No
 N SDAT,Y
 S SDAT=$G(^TMP("SDAMIDX",$J,SDSEL)) G CHKQ:SDAT']""
 S Y=1
 I '$D(^SD(409.63,"ACO",1,$$STATUS(SDAT))) W !!,*7,">>> You can not check out this appointment." D PAUSE^VALM1 S Y=0 G CHKQ
 I $P(+$P(SDAT,"^",3),".")>DT W !!,*7,">>> It is too soon to check out this appointment." D PAUSE^VALM1 S Y=0 G CHKQ
CHKQ Q +$G(Y)
 ;
STATUS(SDAT) ;Selected Appointment Status IEN
 Q +$$STATUS^SDAM1(+$P(SDAT,"^",2),+$P(SDAT,"^",3),+$P(SDAT,"^",4),$G(^DPT(+$P(SDAT,"^",2),"S",+$P(SDAT,"^",3),0)),+$P(SDAT,"^",5))
 ;
ORG(SDORG) ;Originating Process Type Name for Outpatient Encounter
 ; Input  -- SDORG    Originating Process Type
 ; Output -- Originating Process Type Name
 N Y
 S Y=$$LOWER^VALM1($P($P(^DD(409.68,.08,0),SDORG_":",2),";"))
 Q $G(Y)
 ;
COMDT(SDOE) ;Check Out Process Completion Date/Time
 Q $P($G(^SCE(+SDOE,0)),"^",7)
 ;
SET(SDOE,SDNEW) ; -- set x-ref logic for co completion date to updates children
 I '$D(^SCE("APAR",SDOE)) G SETQ
 N SDOEP,SDOEC,X,DA,SDIX
 S SDOEP=SDOE,SDOEC=0
 F  S SDOEC=$O(^SCE("APAR",SDOEP,SDOEC)) Q:'SDOEC  D
 .I $D(^SCE(SDOEC,0)) D
 ..S $P(^SCE(SDOEC,0),U,7)=SDNEW,X=SDNEW,DA=SDOEC,SDIX=0
 ..F  S SDIX=$O(^DD(409.68,.07,1,SDIX)) Q:'SDIX  X ^(SDIX,1) S X=SDNEW
SETQ Q
 ;
KILL(SDOE,SDOLD) ; -- set x-ref logic for co completion date to updates children
 I '$D(^SCE("APAR",SDOE)) G KILLQ
 N SDOEP,SDOEC,X,DA,SDIX
 S SDOEP=SDOE,SDOEC=0
 F  S SDOEC=$O(^SCE("APAR",SDOEP,SDOEC)) Q:'SDOEC  D
 .I $D(^SCE(SDOEC,0)) D
 ..S $P(^SCE(SDOEC,0),U,7)="",X=SDOLD,DA=SDOEC,SDIX=0
 ..F  S SDIX=$O(^DD(409.68,.07,1,SDIX)) Q:'SDIX  X ^(SDIX,2) S X=SDOLD
KILLQ Q
 ;
