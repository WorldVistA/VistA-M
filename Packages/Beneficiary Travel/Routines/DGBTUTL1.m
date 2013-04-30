DGBTUTL1 ;PAV - BENEFICIARY/TRAVEL UTILITY ROUTINES; 1/6/93@1130 ;11/14/11  09:58
 ;;1.0;Beneficiary Travel;**20**;September 25, 2001;Build 185
ELIG(DFN) ;***PAVEL
 ;IBARXEU1 = DBIA1046
 ;DFN - Patient IEN
 ;The BT System must correctly determine if a veteran is eligible for BT reimbursement.  
 ;There are several checks that the BT System must be modified to automatically make 
 ;when determin;ing a veteran's eligibility, as well as several checks that require input from the user.
 ;When the BT user starts a claim, the BT System must be modified to perform the following checks automatically:
 D SETC     ;Setting entries in file 492.41
 N VAEL,DGBTX D ELIG^VADPT
 S DGBTX=0
 ;a)    If the veteran is Service Connected 30% or greater they are eligible for BT reimbursement.
 I $G(VAEL(3)),$P(VAEL(3),U,2)>29 D QUALQUES Q $S($G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:$P($T(BTC+1),";;",2)) ;"1^SC 30% or greater"
 I $P(DGBTINC,U,2)="H" D QUALQUES Q $S($G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:$P($T(BTC+18),";;",2))
 I $P(DGBTINC,U,2)="P" D QUALQUES Q $S($G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:$P($T(BTC+19),";;",2))
 ;b)    If the veteran receives a VA pension they are eligible for BT reimbursement.
 I $$WVELG^DGBT1 D QUALQUES Q $S($G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:$P($T(BTC+2),";;",2)) ;"2^Recipient of VA Pension"
 I '$G(DGBTREF)&(DGBTNSC)&($P(DGBTINC,"^",1)'="")&(+$TR($P(DGBTINC,U),"$,","")<DGBTRXTH)&(DGBTDYFL) D QUALQUES Q $S($G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:$P($T(BTC+16),";;",2))
 I '$G(DGBTREF)&(+$P($G(VAEL(3)),U)&(+$P($G(VAEL(3)),U,2)<30)) D  I $G(DGBTX) Q $S($G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:$P($T(BTC+17),";;",2))
 .I ($P(DGBTINC,"^",1)'="")&(+$TR($P(DGBTINC,U),"$,","")<DGBTRXTH)&('DGBTNSC)&(DGBTDYFL) S DGBTX=$T D QUALQUES
 N VAMB D MB^VADPT
 I VAMB(4) D QUALQUES Q $S($G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:$P($T(BTC+2),";;",2)) ;"2^Recipient of VA Pension"
 ;c)    If the veteran is below the Low Income Eligibility thresholds based upon his current Means Test or Rx Co-pay test 
 ;      they are eligible for BT reimbursement.
 N XX,LI
 S LI="0^"
 I 'DGBTREF&($P(DGBTINC,"^",1)'="") S LI=$$LI^DGBTUTL(DFN,DGBTDTI,DGBTDEP,,DGBTINCA)
 I LI D QUALQUES S XX=$S(+LI:$P($T(BTC+(LI+2)),";;",2),$G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:0) Q:XX XX
 ;$G(DGBTELL)=14:$P($T(BTC+14),";;",2),$G(DGBTELL)=15:$P($T(BTC+15),";;",2),1:
 ;
 ;d)    The.  Service Connected (SC) appointment. If it can be determined that the veteran is travelling for a SC appointment 
 ;      then they are eligible for BT reimbursement.  NOTE: the data in PCE may not always be complete.  If BT is unable 
 ;      to automatically determine if the travel is SC related then BT may need to ask the user to perform this step manually (see step f).
 ;e)    The BT System must check the PCE System in VistA to see if the patient is travelling for a Comp and Pension (C&P) appointment. 
 ;      If it can be determined that the veteran is travelling for a C&P appointment then they are eligible for BT reimbursement.  
 ;      NOTE: the data in PCE may not always be complete.  If BT is unable to automatically determine if the travel is C&P 
 ;      related then BT may need to ask the user to perform this step manually (see step g).
 ;
PCE ; Patient Encounter
 N DGVAL,DGCBK,DGDT1,DGQUERY,SDOE0,SDSTOP
 ;
 ;S DGVAL("DFN")=DFN,DGVAL("BDT")=DGBTDTI\1,DGVAL("EDT")=DGVAL("BDT")_".9999"
 ;S DGCBK="I $P(SDOE0,U,8)=2 D VIS^DGBTUTL1(SDOE0) S DGDT1=+SDOE0",DGDT1=""
 ;S XX=0 ;D SCAN^DGSDU("PATIENT/DATE",.DGVAL,"",DGCBK,1,.DGQUERY)
 ;Q:XX XX    ;XX="7^Service connected appointment on the file"
 ;XX="8^Compensation & Pension appointment on the file"
 ;
 ;If any of the above automatic checks (a, b, c, d or e) indicate that the veteran is eligible for BT reimbursement 
 ;then the processing for this enhancement is complete.  If, however, the veteran does not pass any of the tests 
 ;outlined above, the BT System must ask the user for additional information in order to determine if the veteran 
 ;is eligible for BT reimbursement:
 ;
 ;f)    The BT System must ask the user if the veteran is travelling for a SC appointment.
 ;      If the user responds with YES then the veteran is eligible for BT reimbursement.  Otherwise, go to step g.
 ;g)    The BT System must ask the user if the veteran is travelling for a C&P appointment.
 ;      If the user responds with YES then the veteran is eligible for BT reimbursement.
 ;
 ;DGBTSCAP - Contains answer to SC appointment question
 ;DGBTCPAP = Contains answer to C&P appointment question
 S DGBTSCAP=$$GET1^DIQ(392,DGBTDTI,43.4,"I")
 S DGBTCPAP=$$GET1^DIQ(392,DGBTDTI,43,"I")
 I '$G(DGBTNSC) W !,"IS THIS A CLAIM FOR A SERVICE CONNECTED APPOINTMENT" S %=$S('DGBTSCAP:2,1:1) D YN^DICN S DGBTSCAP=$S(%=2:"NO",1:"YES") I %'=2 D CLRLTR^DGBTDLT(0)
 I '$G(DGBTNSC) Q:%=1 $P($T(BTC+9),";;",2) ;"9^Patient stated SERVICE CONNECTED APPOINTMENT^43.1"
 I '$G(DGBTNSC) Q:%=-1 $P($T(BTC+14),";;",2) ;"14^Patient Exits Claim"
 W !,"IS THIS A CLAIM FOR A COMP AND PENSION APPOINTMENT" S %=$S('DGBTCPAP:2,1:1) D YN^DICN S DGBTCPAP=$S(%=2:"NO",1:"YES") I %'=2 D CLRLTR^DGBTDLT(0)
 Q:%=1 $P($T(BTC+10),";;",2) ;"10^Patient stated COMP AND PENSION APPOINTMENT"
 Q:%=-1 $P($T(BTC+14),";;",2) ;"14^Patient Exits Claim"
 W !!,"PATIENT IS NOT ELIGIBLE FOR BT REIMBURSEMENT"
 W !!,"CONTINUE WITH CLAIM" S %=2 D YN^DICN
 I %=2!('%)  S DGBTAPPTYP=1 Q $P($T(BTC+15),";;",2) ;"15^PATIENT AGREES WITH DENIAL OF CLAIM" ;<==  Here we should plug E11 Patient stated that he doesn' want to continue with claim
 D CLRLTR^DGBTDLT(0)
 Q:%=-1 $P($T(BTC+14),";;",2) ;"14^Patient Exits Claim"
 K DIR S DIR("A")="SELECT REASON FOR ELIGIBILITY: ",DIR(0)="SA^1:Caregiver;2:Transplant;3:Other" D ^DIR
 Q:Y=U $P($T(BTC+14),";;",2) ;"14^Patient Exits Claim"
 Q:Y=1 $P($T(BTC+11),";;",2) ;"11^PATIENT STATED ELIGIBILITY REASON Caregiver "
 Q:Y=2 $P($T(BTC+12),";;",2) ;"12^PATIENT STATED ELIGIBILITY REASON Transplant"
 ; Here assuming that Y=3
 K DIR S DIR("A")="SPECIFY OTHER REASON FOR ELIGIBILITY",DIR(0)="F" D ^DIR
 Q:Y=U $P($T(BTC+14),";;",2) ;"14^Patient Exits Claim"
 Q $P($T(BTC+13),";;",2)_": "_Y ;"13^PATIENT STATED OTHER REASON FOR ELIGIBILITY: "_Y
 ;
 ;If any of the above manual checks (f or g) indicate that the veteran is eligible for BT reimbursement then 
 ;the processing for this enhancement is complete.  If, however, the veteran does not pass any of the manual tests outlined above, 
 ;the BT System must inform the user that the veteran does not qualify for BT reimbursement.  
 ;The BT System must then ask the user if they want to continue with the claim anyway.  
 ;If the user responds with NO then the claim is denied and the enhancement is complete. 
 ;NOTE: at this point in the processing the BT application must Auto-generate BT Denial-of-Benefits Statement and 
 ;Appellate Rights (see section 2.6.11)
EXIT ;
 Q
VIS(DGBTCSN) ;
 Q
 S:$S('DGDT1:0,1:+SDOE0'=DGDT1) SDSTOP=1
 I 'SDSTOP D
 .N DGBTCS,YY
 .S:$P(DGBTCSN,U,3) DGBTCS=$P(DGBTCSN,U,3)
 .S YY=$$GET1^DIQ(409.1,$P(DGBTCSN,"^",10)_",",4)
 .S:YY="SC" XX=$P($T(BTC+7),";;",2) ;"7^Service connected appointment on the file"
 .S:YY="CP" XX=$P($T(BTC+8),";;",2) ;"8^Compensation & Pension appointment on the file"
 Q
BTC ; List of entries in 392.41 file
 ;;1^SC 30% or greater
 ;;2^Recipient of VA Pension
 ;;3^Low Income Copay
 ;;4^Low Income M Test
 ;;5^Alt. Income POW
 ;;6^Alt.Income Hardship
 ;;7^Service connected appointment on the file
 ;;8^Compensation & Pension appointment on the file
 ;;9^Patient stated SERVICE CONNECTED APPOINTMENT
 ;;10^Patient stated COMP AND PENSION APPOINTMENT
 ;;11^PATIENT STATED ELIGIBILITY REASON Caregiver
 ;;12^PATIENT STATED ELIGIBILITY REASON Transplant
 ;;13^PATIENT STATED OTHER REASON FOR ELIGIBILITY 
 ;;14^""
 ;;15^CLAIM DENIED
 ;;16^NSC Low Income
 ;;17^SC Under 30% and Low Income
 ;;18^Alternate Income Hardship
 ;;19^Alternate Income POW
 ;;20^Patient stated QUALIFIED SC APPOINTMENT
 ;;21^Patient refuse to provide financial information
 ;;END
 Q
SETC ;Set entries into 392.41 if these are not there
 N II,FDA,IENC
 F II=1:1 S IENC(1)=+$P($T(BTC+II),";;",2) Q:'IENC(1)  S FDA(392.41,"+1,",.01)=IENC(1),FDA(392.41,"+1,",1)=$P($T(BTC+II),"^",2) D UPDATE^DIE(,"FDA","IENC")
 Q
KILLC ;Remove all entries from 392.41
 N DA,DIK S DA=0,DIK="^DGBT(392.41," F  S DA=$O(^DGBT(392.41,DA)) Q:'DA  D ^DIK
 Q
 ;
QUALQUES ;this will ask if the appointment was a qualified appointment if the patient is SC 30% or greater
 ;
 ;DGBTQAP - Contains answer for Qualified Appointment question
 S DGBTQAP=$$GET1^DIQ(392,DGBTDTI,43.5,"I")
 W !!,"Answer NO if you want to deny claim for any reason. Want to continue" S %=$S('$G(DGBTQAP):1,1:$G(DGBTQAP)) D YN^DICN S DGBTQAP=$S(%=2:"NO",1:"YES") I %'=2 D CLRLTR^DGBTDLT(0)
 I %=2 S DGBTELL=15,LI="" ;$P($T(BTC+9),";;",2) ;"20^Patient stated QUALIFIED SC APPOINTMENT^43.1"
 I %'=2 D CLRLTR^DGBTDLT(0)
 I %=-1 S DGBTELL=14
 ;
 Q
