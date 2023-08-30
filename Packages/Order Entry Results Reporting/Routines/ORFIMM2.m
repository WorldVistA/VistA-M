ORFIMM2 ;SLC/AGP - GENERIC EDIT IMMUNIZATION CONT ;Jan 18, 2023@15:04:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405,597**;Dec 17, 1997;Build 3
 ;
 ; Reference to IMMRPC^PXVRPC4 in ICR #7288
 ;
 Q
 ;
 ;
GETDETLS(RESULT,CNT,DEFAULTS,ID,DATETIME,ENCTYPE,LOC,SERREQ,SERMAX) ;
 ;
 ;Default Array passed in data from CPRS, defaults is only set when editing a record in CPRS.
 ;Editing from Coversheet and Reminders defaults can have the associated CPT/DX codes for the immunization record
 ;Editing from Encounter Form will not have associated CPT/DX codes for the immunization record
 ;
 N CODECNT,CODEDCNT,CODETEMP,CPTTEMP,DXTEMP,DATALST,HASDEF,MATCH,NODE,X
 N LOTCNT,LOTTEMP,LANG,LSTTYPE
 N PIECE,SVIS,TYPE,TEMPTYPE,VIS,VISD,VISI,VIST
 I ENCTYPE="H"!(ENCTYPE="D") S DATETIME=$$NOW^XLFDT()
 S LSTTYPE="",HASDEF=$S($D(DEFAULTS):1,1:0)
 S CODECNT=0,LANG="ENGLISH",SVIS=0,VISD=0,VISI=0,VIST="",CODEDCNT=0
 S LOTCNT=0,LOTTEMP=""
 S CPTTEMP="",DXTEMP=""
 ;get value associated to the immunization in VistA and set default values in the Immunization
 ;form in the FOR loop
 D IMMRPC^PXVRPC4(.DATALST,ID,DATETIME,"L:"_$G(LOC))
 S X=0 F  S X=$O(^TMP("PXVIMMRPC",$J,X)) Q:X'>0  D
 .S TEMPTYPE=""
 .S NODE=^TMP("PXVIMMRPC",$J,X)
 .S TYPE=$P(NODE,U)
 .I TYPE="IMM" D
 ..I $P(NODE,U,12)=1 S SERREQ=1
 ..I +$P(NODE,U,9)>0 S SERMAX=+$P(NODE,U,9)
 .I TYPE="CONTRA" Q
 .I TYPE="CS" S TEMPTYPE=$S($P(NODE,U,2)="10D":"CODES DX",$P(NODE,U,2)="CPT":"CODES CPT",1:TEMPTYPE)
 .S TEMPTYPE=$S(TYPE="VIS":"VIS OFFERED",TYPE="LOT":"LOT NUMBER",1:TEMPTYPE)
 .;
 .I TYPE="DEF" D
 ..I $P(NODE,U,2)'="",HASDEF=0 S DEFAULTS("ADMIN ROUTE")=$P(NODE,U,2)_U
 ..I $P(NODE,U,3)'="",HASDEF=0 S DEFAULTS("ADMIN SITE")=$P(NODE,U,3)_U
 ..I $P(NODE,U,4)'="",HASDEF=0 S DEFAULTS("DOSE")=$P(NODE,U,4)_U
 ..I $P(NODE,U,6)'="" S DEFAULTS("DOSE UNIT")=$P(NODE,U,6)_U
 ..I $P(NODE,U,7)'="" S DEFAULTS("DOSE UNIT")=$P(NODE,U,7)_U
 .I TYPE="DEFC",HASDEF=0 D
 ..I $P(NODE,U,2)'="" S DEFAULTS("COMMENTS")=$P(NODE,U,2)_U
 .;
 .I $G(TEMPTYPE)="" Q
 .;find most recent VIS statement reformat output
 .I TEMPTYPE="VIS OFFERED" D
 ..S VIS=$P(NODE,U,3)_" "_$$FMTE^XLFDT($P(NODE,U,4))_" ("_$P(NODE,U,6)_")"
 ..S $P(NODE,U,3)=VIS
 ..I +$P(NODE,U,4)>VISD,$P(NODE,U,6)=LANG,$P(NODE,U,3)'["PEDIATRIC" D
 ...S VISD=$P(NODE,U,4),VISI=+$P(NODE,U,2),VIST=$P(NODE,U,3)
 .;format expiration date to external date
 .I TEMPTYPE="LOT NUMBER" D
 ..S $P(NODE,U,5)=$$FMTE^XLFDT($P(NODE,U,5))
 ..S LOTCNT=LOTCNT+1,LOTTEMP=$P(NODE,U,2,3)
 .;format procedures codes display and determine the number of codes
 .I TEMPTYPE["CODES" D  Q
 ..S CODETEMP=""
 ..S CODETEMP=$P(NODE,U,4)_U_$P(NODE,U,3)_" ("_$P(NODE,U,5)_")"_U_$P(NODE,U,3)_U_$P(NODE,U,5)
 ..S CNT=CNT+1,RESULT(CNT)="DATA"_U_TEMPTYPE_U_CODETEMP
 ..I TEMPTYPE="CODES CPT" S CODECNT=CODECNT+1,CPTTEMP=CODETEMP Q
 ..I TEMPTYPE="CODES DX" S CODEDCNT=CODEDCNT+1,DXTEMP=CODETEMP
 .;add data to result global
 .S CNT=CNT+1,RESULT(CNT)="DATA"_U_TEMPTYPE_U_$P(NODE,U,2,$L(NODE,U))
 ;
 I HASDEF=1 D  Q
 .;Only step into if an edit
 .I $$REMONLY^ORFIMM(ID)'="" D  Q
 ..;based off settings in OR IMM REMINDER DIALOG parameter
 ..;immunizations defined in this parameters will only show CPT/DX codes prompt will be disabled
 ..;no matter how many CPT/DX codes is defined for the immunization.
 ..I $D(DEFAULTS("CODES CPT")) S DEFAULTS("CODES CPT")="0^1^"_DEFAULTS("CODES CPT")
 ..I $D(DEFAULTS("CODES DX")) S DEFAULTS("CODES DX")="0^1^"_DEFAULTS("CODES DX")
 ..I '$D(DEFAULTS("CODES CPT")) S DEFAULTS("CODES CPT")="0^0^^"
 ..I '$D(DEFAULTS("CODES DX")) S DEFAULTS("CODES DX")="0^0^^"
 .;if not defined in the OR IMM REMINDER DIALOG parameter
 .;determine if the CPT/DX prompts are disable/enabled based off the number of CPT/DX codes associated with
 .;the immunization. If none set to disable
 .I $D(DEFAULTS("CODES CPT")) S DEFAULTS("CODES CPT")=$S(CODECNT>1:"1^1^",1:"0^1^")_DEFAULTS("CODES CPT")
 .I $D(DEFAULTS("CODES DX")) S DEFAULTS("CODES DX")=$S(CODEDCNT>1:"1^1^",1:"0^1^")_DEFAULTS("CODES DX")
 .I '$D(DEFAULTS("CODES CPT")) S DEFAULTS("CODES CPT")="0^0^"
 .I '$D(DEFAULTS("CODES DX")) S DEFAULTS("CODES DX")="0^0^"
 ;
 ;adding new record only section
 I "AID"[ENCTYPE D
 .I '$D(DEFAULTS("VISIT DATE TIME")) S DEFAULTS("VISIT DATE TIME")=DATETIME
 .I DATETIME>$$GETMAXDT^ORFIMM1() S DEFAULTS("VISIT DATE TIME")=$$NOW^XLFDT()
 I "AID"'[ENCTYPE,'$D(DEFAULTS("VISIT DATE TIME")) S DEFAULTS("VISIT DATE TIME")=$$NOW^XLFDT()
 I HASDEF=0,VISI>0 S DEFAULTS("VIS OFFERED")=VISI_U_VIST
 ;if only one CPT code associated with the immunization set the value and disable the prompt
 I CODECNT=1 S DEFAULTS("CODES CPT")=0_U_1_U_$P(CPTTEMP,U)_U_$P(CPTTEMP,U,2)
 ;if more than one CPT code associated with the immunization enable the prompt for user lookup
 I CODECNT>1 D
 .I $$REMONLY^ORFIMM(ID)'="" S DEFAULTS("CODES CPT")="0^1^^" Q
 .S DEFAULTS("CODES CPT")="1^1^"
 ;if only one DX code associated with the immunization set the value and disable the prompt
 I CODEDCNT=1 S DEFAULTS("CODES DX")=0_U_1_U_$P(DXTEMP,U)_U_$P(DXTEMP,U,2)
 ;if more than one DX code associated with the immunization enable the prompt for user lookup
 I CODEDCNT>1 D
 .I $$REMONLY^ORFIMM(ID)'="" S DEFAULTS("CODES DX")="0^1^^" Q
 .S DEFAULTS("CODES DX")="1^1^"
 I LOTCNT=1 S DEFAULTS("LOT NUMBER")=LOTTEMP Q
 Q
