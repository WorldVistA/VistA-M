SDCO22 ;ALB/RMO/MRY - Classification Cont. - Screen - Check Out;9 MAY 2005  11:15 PM ; 8/30/01 11:19am
 ;;5.3;Scheduling;**150,222,244,325,394,441,544**;Aug 13, 1993;Build 11
 ;
AO(DFN,SDOE) ;Ask Agent Orange Exposure Classification
 ; Input  -- DFN      Patient file IEN  
 ;           SDOE     Outpatient Encounter file IEN  [Optional]
 ; Output -- 1=Yes and 0=No
 N SDELG0,Y
 I $P($G(^DPT(DFN,.321)),"^",2)="Y",$P($G(^DPT(DFN,.321)),"^",13)="V" D  ;SD/441
 . S SDELG0=$$EL(DFN,$G(SDOE))
 . I $P(SDELG0,"^",5)="Y","^1^2^3^4^5^"[("^"_$P(SDELG0,"^",4)_"^") S Y=1
 . I $G(Y),$G(SDOE) D
 . . I '$$AP(SDOE,1) S Y=0 Q
 . . I $P(SDELG0,"^",4)=3!($P(SDELG0,"^",4)=1),$P($G(^SDD(409.42,+$O(^SDD(409.42,"AO",+SDOE,3,0)),0)),"^",3) S Y=0
AOQ Q +$G(Y)
 ;
IR(DFN,SDOE) ;Ask Ionizing Radiation Exposure Classification
 ; Input  -- DFN      Patient file IEN  
 ;           SDOE     Outpatient Encounter file IEN  [Optional]
 ; Output -- 1=Yes and 0=No
 N SDELG0,Y
 I $P($G(^DPT(DFN,.321)),"^",3)'="Y" G IRQ
 S SDELG0=$$EL(DFN,$G(SDOE))
 I $P(SDELG0,"^",5)="Y","^1^2^3^4^5^"[("^"_$P(SDELG0,"^",4)_"^") S Y=1
 I $G(Y),$G(SDOE) D
 .I '$$AP(SDOE,2) S Y=0 Q
 .I $P(SDELG0,"^",4)=3!($P(SDELG0,"^",4)=1),$P($G(^SDD(409.42,+$O(^SDD(409.42,"AO",+SDOE,3,0)),0)),"^",3) S Y=0
IRQ Q +$G(Y)
 ;
SC(DFN,SDOE) ;Ask Service Connected Condition Classification
 ; Input  -- DFN      Patient file IEN  
 ;           SDOE     Outpatient Encounter file IEN  [Optional]
 ; Output -- 1=Yes and 0=No
 N SDELG0,Y
 S SDELG0=$$EL(DFN,$G(SDOE))
 I $P(SDELG0,"^",5)="Y","^1^3^"[("^"_$P(SDELG0,"^",4)_"^") S Y=1
 I $G(Y),$G(SDOE) D
 .I '$$AP(SDOE,3) S Y=0 Q
SCQ Q +$G(Y)
 ;
EC(DFN,SDOE) ;Ask Environmental Contaminant Exposure Classification
 ;sd/441 - renamed 'SW Asia Coditions'
 ; Input  -- DFN      Patient file IEN  
 ;           SDOE     Outpatient Encounter file IEN  [Optional]
 ; Output -- 1=Yes and 0=No
 N SDELG0,Y
 S SDELG0=$$EL(DFN,$G(SDOE))
 I $P($G(^DPT(DFN,.322)),"^",13)'="Y" D  G ECQ
 .I $P(SDELG0,"^",5)="N","^4^"[("^"_$P(SDELG0,"^",4)_"^"),"^A^B^C^D^6^"[("^"_($P($G(^DIC(21,+$P($G(^DPT(DFN,.32)),"^",3),0)),"^",3))_"^") S Y=1
 I $P(SDELG0,"^",5)="Y","^1^2^3^4^5^"[("^"_$P(SDELG0,"^",4)_"^") S Y=1
 I $G(Y),$G(SDOE) D
 .I '$$AP(SDOE,4) S Y=0 Q
 .I $P(SDELG0,"^",4)=3!($P(SDELG0,"^",4)=1),$P($G(^SDD(409.42,+$O(^SDD(409.42,"AO",+SDOE,3,0)),0)),"^",3) S Y=0
ECQ Q +$G(Y)
 ;
EL(DFN,SDOE) ;Eligibility
 Q $G(^DIC(8.1,+$P($G(^DIC(8,+$S($P($G(^SCE(+$G(SDOE),0)),"^",13):+$P(^(0),"^",13),1:+$G(^DPT(DFN,.36))),0)),"^",9),0))
 ;
AP(SDOE,SDCTI) ;Classification Appointment Type Screen
 N SDAPTY,Y,SDVSTIEN
 S SDAPTY=+$P($G(^SCE(+SDOE,0)),"^",10)
 I SDAPTY=9 S Y=1
 I SDAPTY=11 S Y=1
 I SDAPTY=2,SDCTI=3 S Y=1
 S SDVSTIEN=$P($G(^SCE(+SDOE,0)),U,5)
 I $P($G(^AUPNVSIT(+SDVSTIEN,812)),U,3) D
 .I $D(^PX(839.7,"B","QUASAR",$P($G(^AUPNVSIT(+SDVSTIEN,812)),U,3))) D
 ..I $P($G(^AUPNVSIT(+SDVSTIEN,800)),U)'="" S Y=1
APQ Q +$G(Y)
 ;
MST(DFN,SDOE) ;Ask Military Sexual Trauma Classification
 ;Input - DFN  Patient file IEN
 ;        SDOE  Outpatient Encounter file IEN
 ;Output - 1=Yes, 0=No
 N DGMST
 S DGMST=$$GETSTAT^DGMSTAPI(DFN)
 Q +($P(DGMST,U,2)="Y")
 ;
HNC(DFN,SDOE) ;Ask Head & Neck Classification
 ;Input - DFN  Patient file IEN
 ;        SDOE  Outpatient Encounter file IEN
 ;Output - 1=Yes, 0=No
 N DGARR,SDELG0,Y
 S SDELG0=$$GETCUR^DGNTAPI(DFN,"DGARR")
 S SDELG0=+$G(DGARR("STAT"))
 ;Only a status of 3, 4 or 5 is accepted for the question to be asked
 S Y=$S((".3.4.5."[("."_SDELG0_".")):1,1:0)
HNCQ Q +$G(Y)
 ;
CV(DFN,SDOE,SDDT) ;Ask Combat Veteran Classification
 ;Input : DFN - Pointer to PATIENT file (#2)
 ;        SDOE - Pointer to OUTPATIENT ENCOUNTER file (#409.68)
 ;        SDDT - Date (FileMan format) (optional - SDOE overrides)
 ;Output: 1 = Yes / 0 = No
 N SDCV
 S SDDT=$G(SDDT)
 S:$G(SDOE) SDDT=+$G(^SCE(+$G(SDOE),0))
 S:'SDDT SDDT=$$DT^XLFDT()
 S SDCV=$$CVEDT^DGCV(DFN,SDDT)
 Q $P(SDCV,"^",3)
 ;
SHAD(DFN) ;Ask Project 112/SHAD Classification
 ;Input : DFN - Pointer to PATIENT file (#2)
 ;Output: 1 = Yes / 0 = No / "" = unanswered
 Q $$GETSHAD^DGUTL3(DFN)
