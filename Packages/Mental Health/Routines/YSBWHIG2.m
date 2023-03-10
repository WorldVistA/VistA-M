YSBWHIG2 ;SLC/DJE - MHA DASHBOARD ; Apr 01, 2021@16:33
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
 ;
 ; Routine retrieves high risk widget data
 ;
 ; Reference to SDAMA301 in ICR #4433
 ; Reference to ^PXRMINDX in ICR #4229
 ; Reference to ^DIC(42) in ICR #3790
 ; Reference to ^DIC(42,D0,.03) in ICR #31
 ; Reference to ^DGPM("ATID1") in ICR #1378
 ; Reference to ^DGPM in ICR #2090
 ; Reference to ^SC in ICR #1004
 ; Reference to ^SC("AST") in ICR #4482
 Q
 ;
BLDINST(INSTDATA,DFN,INST,YSDT,INSTNM) ;
 ;Build a list of instrument results for single score instruments
 N ADMDT,CUTOFF,COUNT,RESULTS
 S CUTOFF=$$FMADD^XLFDT(YSDT,-90),COUNT=0
 ;Get the latest ten results from the last 90 days
 ;Need to loop from latest to last
 ;S ADMDT="" F  S ADMDT=$O(^PXRMINDX(601.84,"PI",DFN,INST,ADMDT),-1) Q:'ADMDT  Q:(ADMDT<CUTOFF)  Q:COUNT=10  D
 S ADMDT="" F  S ADMDT=$O(^PXRMINDX(601.84,"PI",DFN,INST,ADMDT),-1) Q:'ADMDT  Q:COUNT=10  D  ;Remove 90 day cutoff
 .N ADMIN
 .S ADMIN=0 F  S ADMIN=$O(^PXRMINDX(601.84,"PI",DFN,INST,ADMDT,ADMIN)) Q:'ADMIN  D
 ..N RESULT
 ..S RESULT=$O(^YTT(601.92,"AC",ADMIN,0)) ;assuming we only have one scale!
 ..Q:'RESULT
 ..S COUNT=COUNT+1
 ..S RESULTS(ADMDT,ADMIN)=$P(^YTT(601.92,RESULT,0),U,4)
 I COUNT=0 D  Q
 .S INSTDATA(INSTNM,1,"count")=1
 .S INSTDATA(INSTNM,1,"date")="N/A"
 .S INSTDATA(INSTNM,1,"score")="N/A"
 ;Now need to loop from last to latest
 S COUNT=0 ;reuse count to index the JSON global
 S ADMDT="" F  S ADMDT=$O(RESULTS(ADMDT)) Q:'ADMDT  D
 .S ADMIN=0 F  S ADMIN=$O(RESULTS(ADMDT,ADMIN)) Q:'ADMIN  D
 ..S COUNT=COUNT+1
 ..S INSTDATA(INSTNM,COUNT,"count")=COUNT
 ..S INSTDATA(INSTNM,COUNT,"date")=$$FMTE^XLFDT(ADMDT,5)
 ..S INSTDATA(INSTNM,COUNT,"score")=+RESULTS(ADMDT,ADMIN) ;values need to be numeric so we can graph
 Q
BLDRSL(INSTDATA,DFN,INST,YSDT,INSTNM,QNUM) ;
 ;Build a list of instrument results on a particular question
 N ADMDT,CUTOFF,COUNT,RESULTS
 N YS,YSDATA,YSIEN,YSANS
 S CUTOFF=$$FMADD^XLFDT(YSDT,-90),COUNT=0
 ;Get the latest ten results from the last 90 days
 ;Need to loop from latest to last
 ;S ADMDT="" F  S ADMDT=$O(^PXRMINDX(601.84,"PI",DFN,INST,ADMDT),-1) Q:'ADMDT  Q:(ADMDT<CUTOFF)  Q:COUNT=10  D
 S ADMDT="" F  S ADMDT=$O(^PXRMINDX(601.84,"PI",DFN,INST,ADMDT),-1) Q:'ADMDT  Q:COUNT=10  D  ;Remove 90 day cutoff
 .N ADMIN
 .S ADMIN=0 F  S ADMIN=$O(^PXRMINDX(601.84,"PI",DFN,INST,ADMDT,ADMIN)) Q:'ADMIN  D
 ..S YS("AD")=ADMIN
 ..S YS("QN")=QNUM
 ..D GETANS^YTQAPI1(.YSDATA,.YS)
 ..Q:$G(YSDATA(1))["ERROR"
 ..S YSIEN=$G(YSDATA(2)) Q:+YSIEN=0
 ..S YSANS=$$GET1^DIQ(601.75,YSIEN_",",4)  ;Expects Numerical Legacy Value
 ..I INSTNM="phq9_i9",(+YSANS'=0) S YSANS=YSANS-1  ;PHQ9_I9 display/score offset
 ..S COUNT=COUNT+1
 ..S RESULTS(ADMDT,ADMIN)=YSANS
 I COUNT=0 D  Q
 .S INSTDATA(INSTNM,1,"count")=1
 .S INSTDATA(INSTNM,1,"date")="N/A"
 .S INSTDATA(INSTNM,1,"score")="N/A"
 ;Now need to loop from last to latest
 S COUNT=0 ;reuse count to index the JSON global
 S ADMDT="" F  S ADMDT=$O(RESULTS(ADMDT)) Q:'ADMDT  D
 .S ADMIN=0 F  S ADMIN=$O(RESULTS(ADMDT,ADMIN)) Q:'ADMIN  D
 ..S COUNT=COUNT+1
 ..S INSTDATA(INSTNM,COUNT,"count")=COUNT
 ..S INSTDATA(INSTNM,COUNT,"date")=$$FMTE^XLFDT(ADMDT,5)
 ..S INSTDATA(INSTNM,COUNT,"score")=+RESULTS(ADMDT,ADMIN) ;values need to be numeric so we can graph
 Q
 ;
MHLSTVST(DFN,YSDT,FROM) ;Get last MH Visit Date up to one year back.
 N YSDARRAY,APPTLIST
 N SDCOUNT,PIDX,FIDX,SDTIME,OUTPXENC,NODE,LSTMHDT,STATUS,PSTAT,FLIM,NOW
 S NOW=$$NOW^XLFDT()
 S FLIM=$G(FROM) S:FLIM="" FLIM=365
 S YSDARRAY(1)=$$FMADD^XLFDT(YSDT,-FLIM)_";"_NOW
 S YSDARRAY(3)="R;I;NS;NSR;CC;CCR;CP;CPR;NT;"
 S YSDARRAY(4)=DFN
 S YSDARRAY("FLDS")="1;2;12;13;18;22"
 S YSDARRAY("SORT")="P"
 S SDCOUNT=$$SDAPI^SDAMA301(.YSDARRAY)
 M APPTLIST=^TMP($J,"SDAMA301",DFN) K ^TMP($J,"SDAMA301")
 ;add ^SCE("ADFN" loop to detect Outpatient Encounters with no visit. These will be marked as unscheduled
 S (PIDX,FIDX)=0
 S SDTIME=$$FMADD^XLFDT(YSDT,-FLIM)  ;Start from 1 year back to current
 F  S SDTIME=$O(^SCE("ADFN",DFN,SDTIME)) Q:'SDTIME  D
 .I $D(APPTLIST(SDTIME)) Q  ;already got this visit, must be scheduled
 .S OUTPXENC=$O(^SCE("ADFN",DFN,SDTIME,0))
 .S NODE=^SCE(OUTPXENC,0)
 .S APPTLIST(SDTIME)=SDTIME_U_$P(NODE,U,4)_";"_$$GET1^DIQ(44,$P(NODE,U,4),.01)_"^^^^^^^^^^"_OUTPXENC_U_$P(NODE,U,3)_";"_$$GET1^DIQ(40.7,$P(NODE,U,3),1)_"^^^^^4;UV^^^^;;WALK-IN"
 ; split appointments into past and previous
 ;sort previous appointments by reverse date
 S LSTMHDT=""
 S SDTIME=$$FMADD^XLFDT(YSDT,1) F  S SDTIME=$O(APPTLIST(SDTIME),-1) Q:'SDTIME!LSTMHDT  D
 .I '$$CHKCLIN^YSBDD1(APPTLIST(SDTIME)) K APPTLIST(SDTIME) Q  ;not ED or MH clinic - delete
 .S NODE=APPTLIST(SDTIME)
 .S STATUS=$P(NODE,U,22),PSTAT=$P(STATUS,";",3)
 .S STATUS=$P($P($P(NODE,U,22),";",3)," &")  ; also removes " & AUTO-REBOOK"
 .I STATUS="11;FUTURE;FUTURE" Q  ;in the future, possible for an appt later today
 .I STATUS["NO ACTION TAKEN",(PSTAT'["CHECKED") Q  ;No positive state of this encounter.
 .I STATUS["NO ACT TAKN",(PSTAT'["CHECKED") Q  ;Inpatient No action taken
 .I STATUS["CANCELLED" Q  ;Cancelled by Clinic or Cancelled by Patient
 .I STATUS["NO-SHOW" Q  ;No show
 .S LSTMHDT=SDTIME
 I 'LSTMHDT Q "N/A"
 Q $$FMTE^XLFDT($P(LSTMHDT,"."),5)
 ;
MHDCDT(DFN) ;Find last mental health discharge date or if mental health inpatient
 N CURLOCNM,INVDT,RETURN,DONE,DSCHGDT,TRNSFRDT,TRNSCTN,XMVMT
 S RETURN="N/A",DSCHGDT=""
 ;check current inpatient ward if it exists
 S CURLOCNM=$G(^DPT(DFN,.1)) ;DBIA #10035 (Supported)
 I CURLOCNM]"" D
 .N LOC,DIC,X,Y
 .S DIC="^DIC(42,",DIC(0)="BX",X=CURLOCNM ;DBIA #1848
 .D ^DIC
 .S LOC=+Y
 .Q:'LOC
 .I $$GET1^DIQ(42,LOC,.03)="PSYCHIATRY" S RETURN="INPT" ;DBIA #31
 I RETURN="INPT" Q RETURN
 ;Get last MH admission
 S (DONE,INVDT)=0 F  S INVDT=$O(^DGPM("ATID1",DFN,INVDT)) Q:(INVDT="")  D  Q:(DONE=1)  ;DBIA #1378
 .N MVMT
 .S MVMT="" F  S MVMT=$O(^DGPM("ATID1",DFN,INVDT,MVMT)) Q:(MVMT="")  D  Q:(DONE=1)  ;DBIA #1378
 ..N LOC,DCMVMT
 ..S LOC=$$GET1^DIQ(405,MVMT,.06,"I") ;DBIA #1378
 ..I LOC="" Q
 ..I $$GET1^DIQ(42,LOC,.03)'="PSYCHIATRY" Q  ;not a psychiatry service ward ;DBIA #31
 ..S DCMVMT=$$GET1^DIQ(405,MVMT,.17,"I")  ;DBIA #2090
 ..S DSCHGDT=$$GET1^DIQ(405,DCMVMT,.01,"I"),DONE=1 Q  ;DBIA #1378
 ;Check transfers also but only if later than last MH discharge date
 S (DONE,INVDT)=0 S:$G(DSCHGDT) INVDT=(9999999-($G(DSCHGDT)-.01))
 F  S INVDT=$O(^DGPM("ATID2",DFN,INVDT)) Q:(INVDT="")  D  Q:(DONE=1)  ;DBIA #1378
 .N MVMT
 .S MVMT="" F  S MVMT=$O(^DGPM("ATID2",DFN,INVDT,MVMT)) Q:(MVMT="")  D  Q:(DONE=1)  ;DBIA #1378
 ..N LOC,ADMMVMT,DCMVMT
 ..S LOC=$$GET1^DIQ(405,MVMT,.06,"I") ;DBIA #1378
 ..S TRNSCTN=$$GET1^DIQ(405,MVMT,.02,"I")  ;find the transaction type, 2=TRANSFER ;DBIA #1378
 ..I $$GET1^DIQ(42,LOC,.03)'="PSYCHIATRY",TRNSCTN'=2 Q  ;not a psychiatry service ward and not a TRANSFER ;DBIA #31
 ..S ADMMVMT=$$GET1^DIQ(405,MVMT,.14,"I")  ;find admission to find discharge ;DBIA #1378
 ..S DCMVMT=$$GET1^DIQ(405,ADMMVMT,.17,"I")  ;DBIA #2090
 .. S XMVMT=DCMVMT
 .. Q:DCMVMT=""&(TRNSCTN'=2)  ;Don't let a null DCMVMT set the TRNSFRDT
 .. S:TRNSCTN=2 XMVMT=MVMT  ;If this is a TRANFER, set the Transfer date 
 ..S TRNSFRDT=$$GET1^DIQ(405,XMVMT,.01,"I"),DONE=1 Q  ;DBIA #1378
 I $G(TRNSFRDT)>$G(DSCHGDT) S DSCHGDT=TRNSFRDT
 I DSCHGDT'="" S DSCHGDT=$P(DSCHGDT,".",1),RETURN=DSCHGDT
 Q RETURN
 ;
GETLOCS(DATAOUT,ID) ;
 ; C=Clinics, Z=Other, screened by $$ACTLOC
 ; Mental Health Locations Only
 ; Similar to MHLOCS but returns an array for JSON
 N XPREF,I,CNT,SCIEN,SCNAM
 S CNT=0
 D GETMHLOC(.XPREF)
 F I=1:1:$L(XPREF("MHLOCS"),";") D
 . S SCIEN=$P(XPREF("MHLOCS"),";",I)
 . S SCNAM=$P(^SC(SCIEN,0),U)  ;DBIA 10040
 . Q:$E(SCNAM,1,2)="ZZ"  ;ZZ* are inactivated
 . S CNT=CNT+1
 . S DATAOUT("widgets",ID,"locationList",CNT,"id")=SCIEN
 . S DATAOUT("widgets",ID,"locationList",CNT,"name")=SCNAM
 Q
GETMHLOC(PREFS)  ;Get all Hospital Locations that are Mental Health
 ; STOP CODE=Mental Health OR Emergency Department
 ; TYPE=CLINIC
 ; ACTIVE=TRUE
 N STP,STOPCODE,LOCSTR,HL,SCNAM
 S LOCSTR=""
 S STP="" F  S STP=$O(^SC("AST",STP)) Q:STP=""  D  ;DBIA #4482
 .;Get the stop code.
 .S STOPCODE=$$GET1^DIQ(40.7,STP,1)  ;DBIA #557
 .I ((STOPCODE>=500)&(STOPCODE<600))!(STOPCODE=130) D
 ..S HL=0 F  S HL=$O(^SC("AST",STP,HL)) Q:+HL=0  D
 ...Q:("C"'[$P($G(^SC(HL,0)),U,3)!('$$ACTLOC(HL)))
 ...S SCNAM=$P(^SC(HL,0),U)  ;DBIA 10040
 ...I $E(SCNAM,1,2)="ZZ" Q  ;ZZ* are inactivated locations
 ...S LOCSTR=LOCSTR_HL_";"
 I LOCSTR]"" S LOCSTR=$E(LOCSTR,1,$L(LOCSTR)-1)
 S PREFS("MHLOCS")=LOCSTR
 Q
ACTLOC(LOC) ; Function: returns TRUE if active hospital location
 ; IA# 10040.
 N NOW,YSDT
 S NOW=$$NOW^XLFDT()
 S YSDT=$P(NOW,".",1)
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I YSDT>$P(X,U)&($P(X,U,2)=""!(YSDT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
IDFLT(INSTS,SHOWALL) ;Use default instrument list
 ; INSTS = return array of Instruments
 ; SHOWALL = flag to control whether all instruments are returned or not
 N LOWER,UPPER,INSTSEQ,MBCID,INSTC,INSTID,INSTNAM
 N MNGRP,MNSCL
 N DFLST,DISP,INAM,TMPI
 N YFN,YSIEN,YSARR,INSTYP
 S SHOWALL=$G(SHOWALL)
 S DFLST=";PHQ9;BAM-R;PCL-5;GAD-7;"
 S INSTC=0,LOWER="abcdefghijklmnopqrstuvwxyz",UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S MBCID=$O(^YSD(605.1,"B","MBC","")) Q:MBCID=""
 S INSTSEQ=0 F  S INSTSEQ=$O(^YSD(605.1,MBCID,3,INSTSEQ)) Q:'INSTSEQ  D
 .S INSTID=^YSD(605.1,MBCID,3,INSTSEQ,0)
 .Q:INSTID=""  ;Should not occur.
 .Q:'$D(^YTT(601.71,INSTID))  ;If Instrument not installed yet.
 .S INSTNAM=$TR($P(^YTT(601.71,INSTID,0),U),LOWER,UPPER)
 .S TMPI(INSTNAM)=INSTSEQ_U_INSTID
 S YFN=605.13
 S INSTNAM="" F  S INSTNAM=$O(TMPI(INSTNAM)) Q:INSTNAM=""  D
 .S INSTSEQ=TMPI(INSTNAM),INSTID=$P(INSTSEQ,U,2),INSTSEQ=$P(INSTSEQ,U)
 .S YSIEN=INSTSEQ_","_MBCID_"," K YSARR
 .D GETS^DIQ(YFN,YSIEN,"**","","YSARR")
 .S INSTYP=$G(YSARR(YFN,YSIEN,3))
 .S MNGRP=$G(YSARR(YFN,YSIEN,1))
 .S MNSCL=$G(YSARR(YFN,YSIEN,2))
 .;Check INSTNAM against list of default instruments here Q if not in list
 .I SHOWALL="",(DFLST'[(";"_INSTNAM_";")) Q
 .S DISP=(DFLST[(";"_INSTNAM_";"))
 .S INSTC=INSTC+1,INSTS(INSTC)=INSTID_U_INSTNAM
 .;S WIN1=$G(^YSD(605.1,MBCID,3,INSTSEQ,1)),MNGRP=$P(WIN1,U),MNSCL=$P(WIN1,U,2)  ;Main widget display Group and Scale if subscale inst
 .S INSTS(INSTC,"MNGRP")=MNGRP
 .S INSTS(INSTC,"MNSCL")=MNSCL
 .S INSTS(INSTC,"DISPLAY")=$S(DISP:"true",1:"false")
 .S INSTS(INSTC,"TYPE")=INSTYP
 Q
