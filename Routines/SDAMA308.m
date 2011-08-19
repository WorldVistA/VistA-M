SDAMA308 ;BPOIFO/JFW-Filter API Appointment Statuses; 5/10/04 8:13am [5/17/04 10:14am]
 ;;5.3;Scheduling;**301,406**;13 Aug 1993
 ;
 ;**              GET APPOINTMENT STATUS                         **
 ;              - Replaces $$STATUS^SDAM1 -
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;12/04/03  SD*5.3*301    ROUTINE COMPLETED
 ;10/11/06  SD*5.3*406    PRINT STATUS TEXT UPDATED
 ;
 ;*****************************************************************
 ;
STATUS(DFN,SDT,SDCL,SDSTS,SDCHKIN,SDCHKOUT,SDEIFN) ;Retrieve Appointment Status
 ;
 ;  Input:   DFN      := IFN of Patient
 ;           SDT      := Appointment Date/Time   (FM Format)
 ;           SDCL     := IFN of Clinic
 ;           SDSTS    := Current VistA Appointment Status  (Optional)
 ;           SDCHKIN  := Appointment Check-In Date/Time    (Optional)
 ;           SDCHKOUT := Appointment Check-Out Date/Time   (Optional)
 ;           SDEIFN   := Outpatient Encounter IFN for Appointment (Optional)
 ;  Output:  Appoinment Status IFN ; Status Name ; Print Status ;
 ;             Check In Date/Time ; Check Out Date/Time ;
 ;                Admission Movement IFN
 ;           -1 if errors with DFN,SDT or SDCL
 ;  
 ; Initialize Global Variables
 N SDI,SDQUIT,SDCODE,SDSTSD,SDPSTS,SDINDCTR,SDAMVT,VADMVT,VAINDT
 S SDQUIT=0
 ;Validate parameters
 F SDI="VDFN","FMDATE","VCLIN" Q:SDQUIT  D @SDI
 Q:SDQUIT -1
 ; Set initial Status value, if no value set to NULL
 S SDSTSD=$S($G(SDSTS)]"":$P($T(@SDSTS),";;",3),1:"")
 ; No R appt status in original VistA code
 S:$G(SDSTS)="R" SDSTSD=""
 ; If Status is null check for non-count clinic
 I $G(SDSTSD)="" S SDCODE=$$GETSTOP^SDAMA305($G(SDCL)) S:$P($G(SDCODE),"^",3)="Y" SDSTSD="NON-COUNT"
 ;Get admission movement ifn
 S VAINDT=$G(SDT) D ADM^VADPT2
 ;Inpatient? (Check Status, Admission IFN?, Domicillary Ward?, Ward Location = "D"?)
 I SDSTSD["INPATIENT",$S('+VADMVT:1,'$P(^DG(43,1,0),"^",21):0,1:$P($G(^DIC(42,+$P($G(^DGPM(VADMVT,0)),"^",6),0)),"^",3)="D") S SDSTSD=""
 ; Determine Checked In/Out Indicator
 S SDINDCTR=$S(+$G(SDCHKOUT):"CHECKED OUT",+$G(SDCHKIN):"CHECKED IN",SDSTSD]"":"",$G(SDT)>(DT+.2359):"FUTURE",1:"NO ACTION TAKEN") S:SDSTSD="" SDSTSD=SDINDCTR
 I SDSTSD="NO ACTION TAKEN",$P($G(SDT),".")=DT,SDINDCTR'["CHECKED" S SDINDCTR="TODAY"
 I SDSTSD="CHECKED OUT"!(SDSTSD="CHECKED IN"),SDT'<$$REQDT^SDM1A,'$P($G(^SCE(+$G(SDEIFN),0)),"^",7) S SDSTSD="NO ACTION TAKEN"
 ; Determine PRINT STATUS
 S SDPSTS=$S(SDSTSD=SDINDCTR!(SDINDCTR=""):SDSTSD,1:"")
 I SDPSTS="" D
 .I SDSTSD["INPATIENT",$P($G(^SC(SDCL,0)),U,17)'="Y",$P($G(^SCE(+$G(SDEIFN),0)),U,7)="" S SDPSTS=$P(SDSTSD," ")_"/ACT REQ" Q
 .I SDSTSD="NO ACTION TAKEN",SDINDCTR="CHECKED OUT"!(SDINDCTR="CHECKED IN") S SDPSTS="ACT REQ/"_SDINDCTR Q
 .S SDPSTS=$S(SDSTSD="NO ACTION TAKEN":SDSTSD,1:$P(SDSTSD," "))_"/"_SDINDCTR
 I SDSTSD["INPATIENT",SDINDCTR="" D
 .I SDT>(DT+.2359) S SDPSTS=$P(SDSTSD," ")_"/FUTURE" Q
 .S SDPSTS=$P(SDSTSD," ")_"/NO ACT TAKN"
 ;Get Appointment Status IFN
 S SDAMVT=+$O(^SD(409.63,"AC",SDSTSD,0))
 Q SDAMVT_";"_SDSTSD_";"_SDPSTS_";"_$G(SDCHKIN)_";"_$G(SDCHKOUT)_";"_+VADMVT
VDFN ; Verify for valid patient dfn
 I $G(DFN)="" S SDQUIT=1
 E  I '$D(^DPT(DFN)) S SDQUIT=1
 Q
VCLIN ; Verify for valid clinic dfn
 I $G(SDCL)="" S SDQUIT=1
 E  I '$D(^SC(SDCL,0)) S SDQUIT=1
 Q
FMDATE ;
 ; Appointment Date must be a valid internal FileMan Format
 N X,Y,%H,%T,%Y
 S Y=$G(SDT) D DD^%DT I Y=-1 S SDQUIT=1
 ; Appointment Date cannot be imprecise
 I 'SDQUIT S X=$G(SDT) D H^%DTC I %H=0 S SDQUIT=1
 Q
 ;
 ;LIST OF VISTA STATUS CODES /NEW DESCRIPTIONS /OLD DESCRIPTIONS
CC ;;CANCELLED BY CLINIC;;CANCELLED BY CLINIC
CCR ;;CANCELLED BY CLINIC & RESCHEDULED;;CANCELLED BY CLINIC & AUTO RE-BOOK
CP ;;CANCELLED BY PATIENT;;CANCELLED BY PATIENT
CPR ;;CANCELLED BY PATIENT & RESCHEDULED;;CANCELLED BY PATIENT & AUTO-REBOOK
R ;;SCHEDULED/KEPT;;
I ;;INPATIENT;;INPATIENT APPOINTMENT
NS ;;NO-SHOW;;NO-SHOW
NSR ;;NO-SHOW & RESCHEDULED;;NO-SHOW & AUTO RE-BOOK
NT ;;NO ACTION TAKEN;;NO ACTION TAKEN
