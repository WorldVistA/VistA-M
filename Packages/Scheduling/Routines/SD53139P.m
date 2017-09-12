SD53139P ;ALB/JLU;Post init to update 409.76;1/31/98 ; 27 Feb 98  10:22AM
 ;;5.3;Scheduling;**139**;AUG 13, 1993
 ;
EN ;this entry point is used to update various error code descriptions
 ;
 N LP,STR
 W !!,"Beginning error code description update."
 F LP=1:1 S STR=$T(CODE+LP) Q:STR']""  DO
 .N COD,DES,DA
 .S COD=$P(STR,";",3)
 .S DES=$P(STR,";",4)
 .S DA=$O(^SD(409.76,"B",COD,""))
 .I DA="" D ERR(COD) Q
 .I '$D(^SD(409.76,DA,1)) D ERR(COD) Q
 .N DIE,DR
 .S DIE="^SD(409.76,",DR="11////"_DES
 .D ^DIE
 .Q
 W !!,"Finished error code description update."
 Q
 ;
ERR(COD) ;
 W !!,*7,"Error code ",COD," could not be found."
 W !,"This code should be in the Transmitted Outpatient Encounter Error Code file."
 W !,"Contact your CIO Field Office representative via the National Help Desk"
 W !,"for assistance."
 Q
 ;
CODE ;The following are the codes that need changing and the new data
 ;;100;Event type in EVN segment is invalid.
 ;;200;Patient name missing or invalid.
 ;;210;Sex code missing or invalid.
 ;;215;Race code missing or invalid.
 ;;220;Address line 1 is invalid.
 ;;221;Address line 2 is invalid.
 ;;222;City is missing or invalid.
 ;;223;State code is missing or invalid.
 ;;224;Zip code is missing or invalid.
 ;;225;County code is invalid.
 ;;230;Marital status is invalid.
 ;;233;Religion code is invalid.
 ;;236;SSN is missing or invalid.
 ;;237;Date of Death is before the encounter date.
 ;;300;Date of Death is invalid.
 ;;310;Homeless indicator is invalid.
 ;;315;POW status is invalid.
 ;;320;Type of Insurance code is invalid.
 ;;400;Patient class is missing or invalid.
 ;;405;Purpose of Visit or Appointment Type is missing or invalid
 ;;407;Location of visit is missing or invalid.
 ;;410;Unique Visit ID in PCE is missing or Invalid
 ;;415;Facility station number is missing or invalid.
 ;;500;Diagnosis code (ICD-9) is missing or invalid
 ;;503;Diagnosis coding method is missing or invalid
 ;;510;Diagnosis Priority is invalid
 ;;515;Sequential number (Set ID) in DG1 segment is invalid
 ;;600;Procedure coding method is missing or invalid.
 ;;605;CPT procedure code is missing or invalid.
 ;;620;Provider/Practitioner Type code is missing or invalid
 ;;625;Sequential number (set ID) in PR1 segment is invalid.
 ;;700;Encounter Eligibility code missing or invalid
 ;;702;Encounter Eligibility code inconsistent with veteran status.
 ;;705;Veteran Status is missing or invalid
 ;;805;Number of dependents is missing
 ;;807;Number of dependents inconsistent with means test indicator
 ;;815;Patient income is invalid
 ;;901;Vietnam Service indicated inconsistent with classification type question
 ;;902;Veteran status inconsistent with classification type question
 ;;905;Answers to classification type quesitons missing.
 ;;915;Sequential number (Set ID) in ZCL is invalid
 ;;005;EVN Segment missing in HL7 transmission message.
 ;;006;PID Segment missing in HL7 tranmission message.
 ;;007;ZPD segment  missing in HL7 transmission message
 ;;008;PV1 segment missing in HL7 transmission message
 ;;009;PR1 segment missing in HL7 transmission message
 ;;010;ZEL segment missing in HL7 transmission message
 ;;011;ZIR segment missing in HL7 transmission message
 ;;012;ZCL segment missing in HL7 transmission message
 ;;013;ZSC segment missing in HL7 transmission message
 ;;014;ZSP segment missing in HL7 transmission message
 ;;A05;Sequential number (set ID) in ZSC segment is invalid
 ;;B00;Missing or invalid Service Connected.
 ;;B05;Invalid Service Connected Percentage.
 ;;B10;Missing or invalid Period of Service
 ;;B15;Invalid Vietnam Service indicated.
