SDSTAT ;MJK/ALB - Appt Status Update Protocol for ADT ; 7/14/92
 ;;5.3;Scheduling;**31,132,396**;Aug 13, 1993
 ;
EN ; -- main entry point called by ADT event driver
 ; -- process adm and d/c only
 I '$D(^UTILITY("DGPM",$J,1)),'$D(^(3)) G ENQ
 I '$O(^DPT(DFN,"S",0)) G ENQ
 N SDBEG,SDEND,PREV,AFTER,SDP,SDA,SDTYPE,SDCA K ^TMP("SDSTAT",$J),^TMP("SDOE STAT",$J)
 W:'$G(DGQUIET) !!,"Updating appointment status..."
 S ^TMP("SDSTAT",$J,0)=0,^TMP("SDOE STAT",$J,0)=0
 F SDTYPE=1,3 S SDMVT="" F  S SDMVT=$O(^UTILITY("DGPM",$J,SDTYPE,SDMVT)) Q:'SDMVT  S SDP=$G(^(SDMVT,"P")),SDA=$G(^("A")) D
 .S PREV=$S(+SDP:+SDP,1:9999999),AFTER=$S(+SDA:+SDA,1:9999999)
 .I SDTYPE=3,+SDP=+SDA Q  ; d/c & same d/t then quit
 .I SDTYPE=3,$P($G(^DIC(42,+$P($G(^DGPM(+$P($S(SDP]"":SDP,1:SDA),U,14),0)),U,6),0)),U,3)="D" Q  ; d/c & admitted to dom ward then quit
 .I SDTYPE=1,+SDP=+SDA,$P(SDP,U,6)=$P(SDA,U,6) Q  ; adm -> same d/t & same ward then quit
 .I SDTYPE=1,+SDP=+SDA S PREV=+SDP,AFTER=$S(+$G(^DGPM(+$P(SDP,U,17),0)):+^(0),1:9999999) ; adm & same d/t then reset date range
 .S SDBEG=$S(PREV>AFTER:AFTER,1:PREV),SDEND=$S(PREV>AFTER:PREV,1:AFTER)
 .D SCAN(DFN,SDBEG,SDEND) Q
 W:'$G(DGQUIET) "completed."
ENQ K ^TMP("SDSTAT",$J),^TMP("SDOE STAT",$J) Q
 ;
SCAN(SDFN,SDBEG,SDEND) ; -- scan range of appts to update
 ;  input:           SDFN := ien of patient
 ;                  SDBEG := begin date
 ;                  SDEND := end date
 ;      ^TMP("SDSTAT",$J) := array of apts processed
 ;   ^TMP("SDOE STAT",$J) := array of encounters processed
 ;
 N SDT,SDOE,SDOEP,SDORG,SDSTB,SDSTA
 ; -- process appts
 S SDT=SDBEG
 F  S SDT=$O(^DPT(SDFN,"S",SDT)) Q:'SDT!(SDT>SDEND)  D
 .I $D(^TMP("SDSTAT",$J,SDT)) Q  ; appt already processed
 .S ^TMP("SDSTAT",$J,0)=^TMP("SDSTAT",$J,0)+1,^(SDT)=""
 .D UPDATE(SDFN,SDT)
 ;
 ; -- process encounters
 S SDT=SDBEG
 F  S SDT=$O(^SCE("ADFN",SDFN,SDT)) Q:'SDT!(SDT>SDEND)  D
 .S SDOE=0 F  S SDOE=$O(^SCE("ADFN",SDFN,SDT,SDOE)) Q:'SDOE  D
 ..I $D(^TMP("SDOE STAT",$J,SDOE)) Q  ; emcounter already processed
 ..S ^TMP("SDOE STAT",$J,0)=^TMP("SDOE STAT",$J,0)+1,^(SDOE)=""
 ..S SDOE0=$G(^SCE(SDOE,0)),SDORG=$P(SDOE0,U,8),SDOEP=$P(SDOE0,U,6)
 ..I SDOEP!(SDORG=1) Q
 ..S SDSTB=$S($P(SDOE0,U,12)=8:"I",1:""),SDSTA=$$INP^SDAM2(SDFN,SDT)
 ..N SDATA,SDADTHDL,DFN S SDADTHDL=$$HANDLE^SDAMEVT(SDORG),DFN=SDFN
 ..I SDORG=2 D BEFORE^SDAMEVT2(SDOE,SDADTHDL)
 ..I SDORG=3 D BEFORE^SDAMEVT3(SDFN,SDT,9,SDADTHDL)
 ..D OE(SDOE,SDSTB,SDSTA,SDADTHDL)
 ..I SDORG=2 D EVT^SDAMEVT2(SDOE,7,SDADTHDL)
 ..I SDORG=3 D EVT^SDAMEVT3(SDFN,SDT,9,SDADTHDL)
 Q
 ;
UPDATE(DFN,SDT) ; -- update appt status
 ;  input:            DFN := ien of patient
 ;                    SDT := date of appt
 ;
 N SDATA,SDSTB,SDSTA,SDSTB,SDOE,SDCL
 G UPDATEQ:'$D(^DPT(DFN,"S",SDT,0)) S SDATA=^(0)
 S SDOE=+$P(SDATA,U,20),SDSTB=$P(SDATA,U,2),SDCL=+SDATA
 I SDSTB=""!(SDSTB="NT")!(SDSTB="I") S SDSTA=$$STAT() I SDSTB'=SDSTA D
 .I $$REQ^SDM1A(SDT)="CI"!(SDT'<(DT+.2359)) S $P(^DPT(DFN,"S",SDT,0),U,2)=SDSTA Q
 .I SDT<(DT+.2359) D
 ..N SDATA,SDADTHDL,SDOEC
 ..S SDOE=$S(SDOE:SDOE,1:+$$GETAPT^SDVSIT2(DFN,SDT,SDCL)) Q:'SDOE
 ..S SDADTHDL=$$HANDLE^SDAMEVT(+$P($G(^SCE(SDOE,0)),U,8))
 ..D OEVT^SDAMEVT(SDOE,"BEFORE",SDADTHDL,.SDATA)
 ..S $P(^DPT(DFN,"S",SDT,0),U,2)=SDSTA
 ..D OE(SDOE,SDSTB,SDSTA,SDADTHDL)
 ..D OEVT^SDAMEVT(SDOE,"AFTER",SDADTHDL,.SDATA)
 ..I SDSTA="I",$G(SDOE),$P($G(^SCE(SDOE,0)),U,12)=14 D
 ...S $P(^SCE(SDOE,0),U,12)=8
 ...S SDOEC=$O(^SCE("APAR",SDOE,SDOE)) I SDOEC S $P(^SCE(SDOEC,0),U,12)=8
UPDATEQ Q
 ;
STAT() ; -- determine status of appt
 N C,X
 S C=$G(^SC(+SDATA,"S",SDT,1,+$$FIND^SDAM2(DFN,SDT,+SDATA),"C"))
 I $$INP^SDAM2(DFN,SDT)="I" S X="I" G STATQ        ; inpatient
 I SDT>(DT+.2359) S X="" G STATQ                   ; future
 I $$REQ^SDM1A(.SDT)="CI",C S X="" G STATQ         ; checked in
 I $$COCMP^SDM1A(DFN,SDT),$P(C,U,3) S X="" G STATQ ; checked out
 I '$$CHK^SDM1A(+SDATA,SDT) S X="" G STATQ         ; non-count
 S X="NT"
STATQ Q X
 ;
OE(SDOE,SDSTB,SDSTA,SDHDL) ; -- update outpatient encounter if appropriate
 N Y
 S Y=0
 I 'Y,SDSTB="I",SDSTA="NT" S Y=1
 I 'Y,SDSTB="I",SDSTA="" S Y=1
 I 'Y,SDSTB="NT",SDSTA="I" S Y=1
 I 'Y,SDSTB="",SDSTA="I" S Y=1
 I Y D
 .D COMDT^SDCODEL(SDOE,0)
 .D EN^SDCOM(SDOE,0,SDHDL)
OEQ Q
