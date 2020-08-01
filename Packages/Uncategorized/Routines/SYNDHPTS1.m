SYNDHPTS1 ;AFHIL DHP/fjf/art - HealthConcourse - DHP REST handlers ;16/25/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;
 ;
CTRL ;
 ;
 D GTCALLS
 S DHPFRDAT=18401231
 S DHPTODAT=20501231
 S DHPJSON=""
 S DHPICN="" F  S DHPICN=$O(^DPT("AFICN",DHPICN)) Q:DHPICN=""  D
 .;W !,DHPICN Q
 .;D PATLABI
 .;I RETSTA["2000-8" W !!!!!! W $$ZW^SYNDHPUTL("RETSTA")
 .;Q
 .S CALL=""
 .F  S CALL=$O(CALLS(CALL)) Q:CALL=""  D
 ..;W !,"Before ",$G(CALL),! ;R *R
 ..;ZW  ;R !,ZZXC
 ..;W !!,"Still before",! ;R *R
 ..K RETSTA
 ..D @CALL
 ..W !!!! W $$ZW^SYNDHPUTL("RETSTA")
 Q
GTCALLS ; set up call list
 F I=1:1 Q:$T(+I)=""  D
 .S LOC=$T(+I)
 .I $P(LOC," ")'="",$E(LOC,1,3)="PAT" S CALLS($P(LOC," "))=""
 Q
 ;
PATDEMI ; get patient demographics for one patient
 ;
 D PATDEMI^SYNDHP47(.RETSTA,DHPICN,DHPJSON)
 Q
 ;
PATCONI ; get patient conditions for one patient by ICN
 ;
 D PATCONI^SYNDHP03(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;
PATENCI ; get patient encounters for one patient by ICN
 ;
 D PATENCI^SYNDHP40(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
 ; --------------------------------------------------
 ;
PATMEDS ; get patient medication statement for one patient by ICN
 ;
 D PATMEDS^SYNDHP48(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
PATMEDA ; get patient medication administration for one patient by ICN
 ;
 D PATMEDA^SYNDHP48(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
PATMEDD ; get patient medication dispense for one patient by ICN
 ;
 D PATMEDD^SYNDHP48(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
PATVITI ; get patient vitals for one patient by ICN
 ;
 D PATVITI^SYNDHP01(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATHLFI ; get patient health factors for one patient
 ;
 D PATHLFI^SYNDHP09(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATPRCI ; get patient procedures for one patient
 ;
 D PATPRCI^SYNDHP04(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
PATALLI ; get patient allergies for one patient by ICN
 ;
 D PATALLI^SYNDHP57(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;
PATDXREP ; get patient diagnostic report for one patient by ICN
 ;
 D PATDXRI^SYNDHP05(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATLABI ; get patient labs for one patient
 ;
 D PATLABI^SYNDHP53(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
PATPRVI ; get patient encounter providers for one patient
 ;
 D PATPRVI^SYNDHP54(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATAPTI ; get patient appointments for one patient
 ;
 D PATAPTI^SYNDHP41(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
PATFLGI ; get patient flags for one patient
 ;
 D PATFLGI^SYNDHP08(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATIMMI ; get patient immunizations for one patient
 ;
 D PATIMMI^SYNDHP02(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATGOLI ; get patient goals for one patient
 ;
 D PATGOLI^SYNDHP07(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATOBSI ; get patient observations for one patient
 ;
 D PATOBSI^SYNDHP56(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
PATCPALLI ; get all care plans for a patient
 ;
 D PATCPALLI^SYNDHP59(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
PATCPI ; get one care plan for a patient
 ;
 ; need DHPVRESID for this call
 ;D PATCPI^SYNDHP59(.RETSTA,DHPICN,DHPVRESID,DHPJSON)
 Q
PATTIUI ; get patient notes for one patient by ICN
 ;
 D PATTIUI^SYNDHP67(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
