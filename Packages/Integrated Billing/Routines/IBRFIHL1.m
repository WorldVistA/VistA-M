IBRFIHL1 ;TDM/DAL - HL7 Process Incoming EHC_E12 Messages ; 2/22/16 1:46pm
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This routine will process incoming EHC_E12 HL7 messages.  It will
 ;  parse and file the message into the HEALTH CARE CLAIM RFAI (277)
 ;  (#368) file.
 ;
EN ; Entry Point
 N AUTO,EBDA,ERFLG,ERROR,HCT,HLCMP,HLREP,HLSCMP,RIEN,SEG,DATA,IBSEG,MSH10
 N DFNPTR,DFNSSN
 S ERFLG=0
 ;
 S HLCMP=$E(HL("ECH"))        ; HL7 component separator
 S HLSCMP=$E(HL("ECH"),4)     ; HL7 subcomponent separator
 S HLREP=$E(HL("ECH"),2)      ; HL7 repetition separator
 ;
 ;  Loop through the message and find each segment for processing
 S HCT="" F  S HCT=$O(^TMP($J,"IBRFIHLI",HCT)) Q:HCT=""  D  Q:ERFLG
 .D SPAR^IBRFIHLU
 .S SEG=$G(IBSEG(1))
 .I SEG="MSH" D MSH^IBRFIHL2(.IBSEG) Q  ;Message Header Seg
 .I SEG="RFI" D RFI^IBRFIHL2(.IBSEG) Q  ;Request for Info Seg
 .I SEG="CTD" D CTD^IBRFIHL2(.IBSEG) Q  ;Contact Segment
 .I SEG="IVC" D IVC^IBRFIHL2(.IBSEG,.DFNPTR,.DFNSSN) Q  ;Invoice Segment
 .I SEG="PID" D PID^IBRFIHL2(.IBSEG,$G(DFNPTR),$G(DFNSSN)) Q  ;Patient Segment
 .I SEG="PSL" D PSL^IBRFIHL2(.IBSEG) Q  ;Product/Service Ln Item
 .I SEG="PYE" D PYE^IBRFIHL2(.IBSEG) Q  ;Payee Info Segment
 .I SEG="OBX" D OBX^IBRFIHL2(.IBSEG)  ;Observation/Result
 D FILE
 Q
 ;
FILE ;  File all data.
 N DO,DIC,X,FLD,IEN368,DIK,DA,DIE,DR,Y,DTOUT,DUOUT,LVL0,LVL1,SID,SID1
 ;
 ;Determine Primary LOINC
 S:$G(OBX013(1,1.02))'="" DATA(368,22.03)=$G(OBX013(1,1.02))
 S:$G(OBX013(1,1.02))="" DATA(368,22.03)=$G(PSL2199(1,1,1.02))
 ;*******************************************************************
 ;The following code has been commented out to avoid performing a
 ;lookup into the LAB LOINC file (#95.3) because an Integration
 ;Agreement could not be obtained.
 ;S VAL=DATA(368,22.03) S VAL=$S(VAL["-":$P(VAL,"-"),1:$E(VAL,1,$L(VAL)-1))
 ;S IEN=$$FIND1^DIC(95.3,,,VAL) S:IEN>0 DATA(368,122.03)=IEN
 ;*******************************************************************
 S VAL=DATA(368,22.03) I VAL'["-" S VAL=$E(VAL,1,$L(VAL)-1)_"-"_$E(VAL,$L(VAL)) S DATA(368,22.03)=VAL
 ;
 ;Initialize Deletion Flag
 S DATA(368,200.01)=0
 ;
 ;File 368 data
 S LSTFLD=$O(DATA(368,""),-1),DIC("DR")=""
 S FLD=0 F  S FLD=$O(DATA(368,FLD)) Q:FLD=""  D
 .S DIC("DR")=DIC("DR")_FLD_"////^S X=DATA(368,"_FLD_")"
 .I FLD'=LSTFLD S DIC("DR")=DIC("DR")_";"
 K DO
 S DIC="^IBA(368,",DIC(0)="",X=DATA(368,.01)
 D FILE^DICN
 S IEN368=Y
 K DIC,X,Y,DTOUT,DUOUT
 ;
 ;File 368.013 data
 I $D(OBX013) D
 .S SID="" F  S SID=$O(OBX013(SID)) Q:SID=""  D
 ..S LSTFLD=$O(OBX013(SID,""),-1),DIC("DR")=""
 ..S FLD=0 F  S FLD=$O(OBX013(SID,FLD)) Q:FLD=""  D
 ...S DIC("DR")=DIC("DR")_FLD_"////^S X=OBX013(SID,"_FLD_")"
 ...I FLD'=LSTFLD S DIC("DR")=DIC("DR")_";"
 ..K DO
 ..S X=SID,DIC="^IBA(368,"_+IEN368_",13,",DIC(0)="L",DA(1)=+IEN368
 ..D FILE^DICN
 ..K DIC,DA,X,Y,DTOUT,DUOUT
 ;
 ;File 368.0113 data
 I $D(OBX0113) D
 .S SID="" F  S SID=$O(OBX0113(SID)) Q:SID=""  D
 ..S LSTFLD=$O(OBX0113(SID,""),-1),DIC("DR")=""
 ..S FLD=0 F  S FLD=$O(OBX0113(SID,FLD)) Q:FLD=""  D
 ...S DIC("DR")=DIC("DR")_FLD_"////^S X=OBX0113(SID,"_FLD_")"
 ...I FLD'=LSTFLD S DIC("DR")=DIC("DR")_";"
 ..K DO
 ..S X=SID,DIC="^IBA(368,"_+IEN368_",113,",DIC(0)="L",DA(1)=+IEN368
 ..D FILE^DICN
 ..K DIC,DA,X,Y,DTOUT,DUOUT
 ;
 ;File 368.021 entries
 I $D(PSL021) D
 .S SID="" F  S SID=$O(PSL021(SID)) Q:SID=""  D
 ..S LSTFLD=$O(PSL021(SID,""),-1),DIC("DR")=""
 ..S FLD="" F  S FLD=$O(PSL021(SID,FLD)) Q:FLD=""  D
 ...S DIC("DR")=DIC("DR")_FLD_"////^S X=PSL021(SID,"_FLD_")"
 ...I FLD'=LSTFLD S DIC("DR")=DIC("DR")_";"
 ..K DO
 ..S X=SID,DIC="^IBA(368,"_+IEN368_",21,",DIC(0)="L",DA(1)=+IEN368
 ..D FILE^DICN
 ..S IEN021=Y
 ..K DIC,DA,X,Y,DTOUT,DUOUT
 ..;
 ..;File 368.2199 entries
 ..I $D(PSL2199) D
 ...S SID1="" F  S SID1=$O(PSL2199(SID,SID1)) Q:SID1=""  D
 ....S LSTFLD=$O(PSL2199(SID,SID1,""),-1),DIC("DR")=""
 ....S FLD="" F  S FLD=$O(PSL2199(SID,SID1,FLD)) Q:FLD=""  D
 .....S DIC("DR")=DIC("DR")_FLD_"////^S X=PSL2199(SID,SID1,"_FLD_")"
 .....I FLD'=LSTFLD S DIC("DR")=DIC("DR")_";"
 ....K DO
 ....S X=SID1,DIC="^IBA(368,"_+IEN368_",21,"_+IEN021_",99,",DIC(0)="L"
 ....S DA(1)=+IEN021,DA(2)=+IEN368
 ....D FILE^DICN
 ....K DIC,DA,X,Y,DTOUT,DUOUT
 ;
 ;File 368.0121 entries
 I $D(PSL0121) D
 .S SID="" F  S SID=$O(PSL0121(SID)) Q:SID=""  D
 ..S LSTFLD=$O(PSL0121(SID,""),-1),DIC("DR")=""
 ..S FLD="" F  S FLD=$O(PSL0121(SID,FLD)) Q:FLD=""  D
 ...S DIC("DR")=DIC("DR")_FLD_"////^S X=PSL0121(SID,"_FLD_")"
 ...I FLD'=LSTFLD S DIC("DR")=DIC("DR")_";"
 ..K DO
 ..S X=SID,DIC="^IBA(368,"_+IEN368_",121,",DIC(0)="L",DA(1)=+IEN368
 ..D FILE^DICN
 ..S IEN0121=Y
 ..K DIC,DA,X,Y,DTOUT,DUOUT
 ..;
 ..;File 368.12199 entries
 ..I $D(PSL12199) D
 ...S SID1="" F  S SID1=$O(PSL12199(SID,SID1)) Q:SID1=""  D
 ....S LSTFLD=$O(PSL12199(SID,SID1,""),-1),DIC("DR")=""
 ....S FLD="" F  S FLD=$O(PSL12199(SID,SID1,FLD)) Q:FLD=""  D
 .....S DIC("DR")=DIC("DR")_FLD_"////^S X=PSL12199(SID,SID1,"_FLD_")"
 .....I FLD'=LSTFLD S DIC("DR")=DIC("DR")_";"
 ....K DO
 ....S DIC="^IBA(368,"_+IEN368_",121,"_+IEN0121_",99,",DIC(0)="L"
 ....S X=SID1,DA(1)=+IEN0121,DA(2)=+IEN368
 ....D FILE^DICN
 ....K DIC,DA,X,Y,DTOUT,DUOUT
 ;
 K DATA,OBX013,OBX0113,PSL021,IEN021,PSL2199,PSL0121,IEN0121,PSL12199,IEN368,SID,SID1,FLD,LSTFLD
 Q
 ;
PURG ; purge file 368 entries based on # of days in PURGE DAYS 277 RFAI  in IB SITE PARAMETERS
 ; (field #52.01 in file #350.9).  Called from IBAMTC (tasked option IB MT NIGHT COMP) NIGHTLY^IBTRKR
 ; null entry (the default) indicates the transactions will be stored forever. 
 ;
 N IBPURG,IBEND,IBSTR,IBRFI,DA,DIK
 S IBPURG=$$GET1^DIQ(350.9,1,52.01) Q:IBPURG=""
 S IBEND=$$FMTHL7^XLFDT($$FMADD^XLFDT(DT,-IBPURG))
 S IBSTR="" F  S IBSTR=$O(^IBA(368,"C",IBSTR)) Q:IBSTR=""!($E(IBSTR,1,8)>IBEND)  D
 .S IBRFI="" F  S IBRFI=$O(^IBA(368,"C",IBSTR,IBRFI)) Q:IBRFI=""  D
 ..; DELETE
 ..S DA=IBRFI,DIK="^IBA(368," D ^DIK
 K IBPURG,IBEND,IBSTR,IBRFI,DA,DIK
 Q
 ;
