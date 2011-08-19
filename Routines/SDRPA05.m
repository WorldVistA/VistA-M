SDRPA05 ;BP-OIFO/ESW - Evaluate appointment status for HL7  ; 9/10/04 9:34am
 ;;5.3;Scheduling;**290,333,349,376,491**;AUG 13, 2003;Build 53
 ;Evaluation of the appointment status is done from the computed field to match the displayed/printed status in the appointment management
 ;SD/491 - MODIFIED $$SCHEDULE to cut off appointments considered as rescheduled by with the scheduled date<2250000
 Q
 ;
STATUS(DFN,SDADT,SDCL,TODAY,SFD) ;
 ;Input:
 ;      SDADT - Appt date/time
 ;      SDCL  - Clinic IEN
 ;      SFD:   - 0 - if called from scanning previous runs - update
 ;             - 1 - if called from scanning 2.98
 ;Output: 
 ;       SDSTAT=SDMSH_U_SD25_U_SD6_U_SD8_U_SDCO_U_SDCLL_U_SD8RD
 ;        where:
 ;              SDMSH -HL7 segment
 ;              SD25  - Filler Status:
 ;                                    P - Pending
 ;                                    F - Final
 ;              SD6   - Event Reason
 ;              SD8   - Appt Type
 ;              SD8RD - rescheduled date/time if SD8="RS"
 ;              SDCO  - check out date
 ;              SDCLL - clinic IEN from matching encounter
 ;
 N SD0,SDST,SD6,SD8,SD25,SDMSH,SDCO,SDSTAT,SD8S,SD8RD
 S SDST=$$GET1^DIQ(2.98,SDADT_","_DFN_",",3,"I")
 I SDST'="" I SDST'="NT"&(SDST'="I") D  Q SDSTAT
 .S SD25="F",SDCO="",SD8RD=""
 .I SDST="C" S SD6="CC",SD8="",SDMSH="S15" D  ;cancel by clinic
 ..S SD8S=$$SCHEDULE(DFN,SDCL,SDADT),SD8=$P(SD8S,U),SD8RD=$P(SD8S,U,2)
 .I SDST="CA" S SD6="CC",SD8="ABK",SDMSH="S15" ;cancel bt clinic and auto rebook
 .I SDST="PC" S SD6="CP",SD8="",SDMSH="S15" D  ; cancel by patient
 ..S SD8S=$$SCHEDULE(DFN,SDCL,SDADT),SD8=$P(SD8S,U),SD8RD=$P(SD8S,U,2)
 .I SDST="PCA" S SD6="CP",SD8="ABK",SDMSH="S15" ;cancel by patient and auto rebook
 .I SDST="NA" S SD6="NS",SD8="ABK",SDMSH="S26" ;no show and auto rebook
 .I SDST="N" S SD6="NS",SD8="",SDMSH="S26" ;no show
 .;evaluate 'non-count'
 .I $P($G(^SC(SDCL,0)),U,17)="Y" D
 ..I SD8="" S SD8="NC" Q
 ..I SD8="RS" S SD8="RSN"
 .;
 .S SDSTAT=SDMSH_U_SD25_U_SD6_U_SD8_U_SDCO_U_U_SD8RD
 ;process all others
 S SD0=^DPT(DFN,"S",SDADT,0)
 ; check out from OUTPAT ENCOUNTER
 ;N SCE S SCE=$P(SD0,"^",20) S SDCO="" I SCE>0 S SDCO=$P(^SCE(SCE,0),"^",7)
 N SCE S SCE=$P(SD0,"^",20) S SDCO="" I SCE>0,$D(^SCE(SCE,0)) S SDCO=$P(^SCE(SCE,0),"^",7)
 N SDSTATX,SDX3
 S SDSTATX=$$STATUS^SDAM1(DFN,SDADT,SDCL,SD0) ;call to compute the status (VistA)
 ;SDSTATX=Appt status IFN in 409.63 ; status name ; print status ; check in ; check out 
 I SDCO="" S SDCO=$P(SDSTATX,";",5) ; check out from clinic if NULL
 I SDCO'=""&(+SDSTATX'=12) D  Q SDSTAT
 .S SD6="CO",SD25="F",SD8="",SD8RD="",SDMSH=$S(SFD=0:"S14",1:"S12")
 .I +SDSTATX=3 S SD8="AR" ; action required
 .I +SDSTATX=8 S SD8="I" ;inpatient
 .;I +SDSTATX=12 S SD8="NC" ;non-count excluded to be compared to possible encounter does not matter if check out
 .I +SDSTATX=2 S SD8="O" ;outpatient
 .S SDSTAT=SDMSH_U_SD25_U_SD6_U_SD8_U_SDCO_U_U_SD8RD
 I +SDSTATX=3 D  Q SDSTAT
 .S SD25="P",SDMSH="S12",SDCO="",SD8RD=""
 .I $P(SDSTATX,";",4)'="" S SD6="CI",SD8="AR" ;check in/action required
 .E  S SD6="",SD8="NAT",SD8RD="" ;no action taken
 .S SDSTAT=SDMSH_U_SD25_U_SD6_U_SD8_U_SDCO_U_U_SD8RD
 I +SDSTATX=8!(+SDSTATX=11) S SD25="P",SD8RD="" D  Q SDSTAT
 .I +SDSTATX=8 S SD6="",SD8="I",SDCO="",SDMSH="S12" ;inpatient
 .I +SDSTATX=11 S SD6="",SD8="F",SDCO="",SDMSH="S12" ;future
 .S SDSTAT=SDMSH_U_SD25_U_SD6_U_SD8_U_SDCO_U_U_SD8RD
 ;
 ;process non-count (not checked out)
 I +SDSTATX=12 N SDCLL S SDCLL="" D  S:SD6'="COE" SDCLL=SDCL S SDSTAT=SDMSH_U_SD25_U_SD6_U_SD8_U_SDCO_U_SDCLL Q SDSTAT
 .S SD6="",SD8="NC",SDCO="",SDMSH="S12",SD25="P"
 .I (SDADT\1)-(TODAY\1)>0 S SD6="",SD8="NCF",SD25="P" Q
 .N SDADTC,SDSCE,SDADTCK S SDADTC=(SDADT\1)-1+.99,SDADTCK=SDADTC+1 F  D  Q:'SDSCE!(SD6="COE")
 ..S SDSCE=$$EXAE^SDOE(DFN,SDADTC,SDADTCK)
 ..I SDSCE>1 N SDDATA D GETGEN^SDOE(SDSCE,"SDDATA") D
 ...N SDCL0,SDCL1,SDCL2
 ...S SDCLL=$P(SDDATA(0),"^",4) I $P(^SC(SDCLL,0),"^",17)="Y" D  Q
 ....S SDADTC=$P(^SCE(SDSCE,0),"^")+.000001 ;
 ...S SDCL0=$P(^SC(SDCL,0),"^",7)_$P(^SC(SDCL,0),"^",18)
 ...S SDCL2=$P(^SC(SDCLL,0),"^",7)_$P(^SC(SDCLL,0),"^",18)
 ...I SDCL0'=SDCL2 S SDADTC=$P(^SCE(SDSCE,0),"^")+.000001 Q
 ...; proceed if the same DSS IDs pairs
 ...S SDCO=$P(SDDATA(0),"^",7)
 ...I SDCO'="" S SD6="COE",SD25="F",SDMSH=$S(SFD=0:"S14",1:"S12") Q
 ...;encounter exists but not in final (chek out) status
 ...S SDADTC=$P(^SCE(SDSCE,0),"^")+.000001
 .I SD6="COE" Q
 .;check out by matching encounter
 .E  I ((TODAY\1)-(SDADT\1))>2 D   ;give 2 days to update
 ..S SD6="NM",SD25="F",SDMSH=$S(SFD=0:"S14",1:0) ;no match, to be skipped
 Q 0
 ;
SCHEDULE(DFN,SDCL,SDADT) ; Scheduling flag
 ; If the patient has another appointment created on the same day as the cancellation date of the canceled appt, and that
 ; appointment is created for a clinic with the same stop code then return "RS".
 ; If there is not another appointment made on the same day, return "".
 N SDCDT,SDCLN S SDCDT=$$GET1^DIQ(2.98,SDADT_","_DFN_",",15,"I") ;cancellation date
 Q:'SDCDT ""
 N SDCDTI S SDCDTI=SDCDT\1
 N SDRESCH S SDRESCH=""
 ;exclude the same appointments
 N SDAPDT S SDAPDT="" F  S SDAPDT=$O(^DPT("ASADM",SDCDTI,DFN,SDAPDT)) Q:SDAPDT=""  I SDAPDT>3030000 I SDAPDT'=SDADT I $D(^DPT(DFN,"S",SDAPDT)) D  Q:SDRESCH'=""
 .S SDCLN=+$P(^DPT(DFN,"S",SDAPDT,0),U) I $P(^SC(SDCLN,0),"^",7)=$P(^SC(SDCL,0),"^",7) S SDRESCH="RS"_"^"_SDAPDT ;compare stop code pointers
 S:SDRESCH="" SDRESCH="^" Q SDRESCH
