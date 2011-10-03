PXRRPCE1 ;HIN/MjK - Clinic Specfic Workload Reports ;9/23/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3**;Aug 12, 1996
EN ;_._._._._._._._._._._._.Total Appt By Type_._._._._._._._._._._._._.
 ;THIS ROUTINE EXECUTES THE SCHEDULING PACKAGE ROUTINES @ (SET^SDCWL3)
 ;FOR CLINIC APPT DATA WHICH IS RETURNED IN THE FOLLOWING TMP GLOBALS
 ;^TMP($J,"CL",CLINIC TEXT NAME  ;TOTAL ENCOUNTERS
 ;^TMP($J,1,CLINIC TEXT NAME,APPT DATE,"SD" ;# SCHEDULED APPTS
 ;^TMP($J,1,CLINIC TEXT NAME,APPT DATE,"OB" ;# OVERBOOKED APPTS
 ;^TMP($J,1,CLINIC TEXT NAME,APPT DATE,"IN" ;# INPATIENT APPTS  
 ;^TMP($J,1,CLINIC TEXT NAME,APPT DATE,"UN" ;# UNSCHEDULED APPTS
 ;^TMP($J,1,CLINIC TEXT NAME,APPT DATE,"NS" ;# NO SHOWED APPTS
 ;^TMP($J,1,CLINIC TEXT NAME,APPT DATE,"CA" ;# CANCELLED APPTS
 ;THE PCE DATA FILES ARE SEPARATELY CHECKED, 
 ;BY DATE RANGE                             ; ^AUPNVSIT("B",
 ;AND THEN HOSPITAL LOCATION                ; $P(^AUPNVSIT(D0,0),U,22)
 ;THE ASSOCIATED V CPT RECORDS ARE REVIEWED ; ^AUPNVCPT("AD",
 ;AGAINST THE IBE TYPE OF VISIT FILE        ; ^IBE(357.60,
 ;TO DISTINGUISH E&M CODES FROM OTHER NON-E&M CPT CODES
ALL S (PXRR,PXRRCN)=0 F  S PXRR=$O(PXRRCLIN(PXRR)) Q:'PXRR  S PXRRCL=$P(PXRRCLIN(PXRR),U) D SETUP I $D(^TMP($J,1,PXRRCL)) S PXRRCN=PXRRCN+1,PXRRCLIN=$P(PXRRCLIN(PXRR),U,2) D
SDDATA .   ;_._._._._._.Initialize Appt Types from Scheduling data_._._._._.
 .   F X="UN","CA","NS" S Y=0 F  S Y=$O(^TMP($J,1,PXRRCL,Y)) Q:'Y  S ^TMP($J,PXRRCL,X)=^TMP($J,PXRRCL,X)+$G(^TMP($J,1,PXRRCL,Y,X))
SDTOTAL .   ;_._._._._._._.Total Visits per Clinic & All Clinics_._._._._._._.
 .   S ^TMP($J,PXRRCL,"TOT")=$S($P(^TMP($J,"CL",1,PXRRCL),U,2)="":0,1:$P(^TMP($J,"CL",1,PXRRCL),U,2))
PCEDATA ;_._._._._._._._._._._._Patient Encounters_._._._._._._._._._._
 ;F= visit ifn  ;C= enctr counter
 N F
 F  S PXRR=$O(PXRRCLIN(PXRR)) Q:'PXRR  S PXRRCL=$P(PXRRCLIN(PXRR),U),PXRRCLIN=$P(PXRRCLIN(PXRR),U,2) S PXRRVDT=PXRRBDT,(C,PXRRNVCP)=0 F  S PXRRVDT=$O(^AUPNVSIT("B",PXRRVDT)) Q:'PXRRVDT!(PXRRVDT>PXRREDT)  D
 .   S F=0 F  S F=$O(^AUPNVSIT("B",PXRRVDT,F)) Q:'F  I $P(^AUPNVSIT(F,0),U,22)=PXRRCLIN S X=$P($G(^AUPNVSIT(F,0)),U,7) I (X="A")!(X="I")!(X="S")  S C=C+1,^TMP($J,PXRRCL,"ENT")=C D
 ..  ;_.If no x-ref exists, there are no associated CPTs for the enctr_.
 ..  I '$D(^AUPNVCPT("AD",F)) S PXRRNVCP=PXRRNVCP+1,^TMP($J,PXRRCL,"NVCPT")=PXRRNVCP Q
PCEPROC ..  ;_._._._._._._._._._.Encounter Visit Codes_._._._._._._._._._.
 ..  S G=0 F  S G=$O(^AUPNVCPT("AD",F,G)) Q:'G  S PXRRVCPT=$P(^AUPNVCPT(G,0),U) I $D(^IBE(357.69,PXRRVCPT)) S PXRVST=1
 ..  ;_.If none of the associated procedures is a Type of Visit code_.
 ..  I '$D(PXRVST) S ^TMP($J,PXRRCL,"OTHER CPT")=^TMP($J,PXRRCL,"OTHER CPT")+1 Q
 ..  K PXRVST
PCEENM .. ;_._._._._._._._.All Procedures Which Are Visit Codes_._._._._._.
 ..  S G=0 F  S G=$O(^AUPNVCPT("AD",F,G)) Q:'G  S PXRRVCPT=$P(^AUPNVCPT(G,0),U) D:$D(^IBE(357.69,PXRRVCPT))&('$D(PXRVST))
 ... ;_._._.Category of Type of Visit (i.e. NEW,EST,CONSULT,OTHER)_._._.
 ... ;_._._.Use the First Type of Visit Code Found for Encounter_._._._.
 ... S X=$P(^IBE(357.69,PXRRVCPT,0),U,5),X=$S(X=1:"NEW",X=2:"ESTABLISHED",X=3:"CONSULT",1:"OTHER"),^TMP($J,PXRRCL,X)=^TMP($J,PXRRCL,X)+1,PXRVST=1
 ..  K PXRVST
PCETOT ;_._._._._._._.Total PCE Enctrs for All Selected Clinics_._._._._._.
 S (^TMP($J,"TVCO"),X)=0 F  S X=$O(PXRRCLIN(X)) Q:'X  S ^TMP($J,"TVCO")=^TMP($J,"TVCO")+$G(^TMP($J,$P(PXRRCLIN(X),U),"ENT"))
EXIT Q
SETUP ;_._._.TMP Array_._._.
 F I="UN","CA","NS","NEW","ESTABLISHED","CONSULT","OTHER","OTHER CPT","ENT","NVCPT","TOT" S ^TMP($J,PXRRCL,I)=0
 Q
   
