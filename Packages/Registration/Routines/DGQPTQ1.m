DGQPTQ1 ; SLC/CLA - Functs which return DG patient lists and sources pt 1 ;12/15/97
 ;;5.3;Registration;**447**;Aug 13, 1993
VAMCPTS(Y) ; RETURN LIST OF PATIENTS IN VAMC: DFN^NAME
 N I,J,V
 S I=1
 S J=0 F  S J=$O(^DPT("B",J)) Q:J=""  S V=0,V=$O(^DPT("B",J,V))  S Y(I)=V_"^"_J,I=I+1
 Q
VAMCLONG(Y,DIR,FROM) ; return a bolus of patients in VAMC: DFN^NAME
 N I,IEN,CNT S CNT=44
 I DIR=0 D  ; Forward direction
 . F I=1:1:CNT S FROM=$O(^DPT("B",FROM)) Q:FROM=""  D
 . . S Y(I)=$O(^DPT("B",FROM,0))_"^"_FROM
 . I +$G(Y(CNT))="" S Y(I)=""
 I DIR=1 D  ; Reverse direction
 . F I=1:1:CNT S FROM=$O(^DPT("B",FROM),-1) Q:FROM=""  D
 . . S Y(I)=$O(^DPT("B",FROM,0))_"^"_FROM
 Q 
DEFTM(DGY) ; return current user's default team list
 Q:'$D(DUZ)
 N DGSRV S DGSRV=$G(^VA(200,DUZ,5)) I +DGSRV>0 S DGSRV=$P(DGSRV,U)
 S DGY=$$GET^XPAR("USR^SRV.`"_+$G(DGSRV),"DGLP DEFAULT TEAM",1,"B")
 Q
TEAMS(DGY) ; return list of teams for a system
 ; Also called under DBIA # 2692.
 N DGTM,I,DGTMN
 S DGTMN="",I=1
 F  S DGTMN=$O(^OR(100.21,"B",DGTMN)) Q:DGTMN=""  D
 .S DGTM="",DGTM=$O(^OR(100.21,"B",DGTMN,DGTM)) Q:DGTM=""
 .S DGY(I)=DGTM_U_DGTMN,I=I+1
 S:+$G(DGY(1))<1 DGY(1)="^No teams found."
 Q
TEAMPTS(DGY,TEAM,TMPFLAG) ; RETURN LIST OF PATIENTS IN A TEAM
 ; Also called under DBIA # 2692.
 ; If TMPFLAG passed and = TRUE, code expects a "^TMP(xxx"
 ;    global root string passed in DGY, and builds the returned 
 ;    list in that global instead of to a memory array.
 N DOTMP,NEWTMP
 S DOTMP=0
 I $G(TMPFLAG) D             ; Was value passed?
 .I TMPFLAG S DOTMP=1        ; Is value TRUE?
 I +$G(TEAM)<1 D
 .I DOTMP S NEWTMP=DGY_1_")",@NEWTMP="^No team identified" Q
 .I 'DOTMP S DGY(1)="^No team identified" Q
 N DGI,DGPT,I
 S I=0
 S DGI=0 F  S DGI=$O(^OR(100.21,+TEAM,10,DGI)) Q:DGI<1  D
 .S DGPT=^OR(100.21,+TEAM,10,DGI,0)
 .I DOTMP D
 ..S I=I+1,NEWTMP=DGY_+I_")"
 ..S @NEWTMP=+DGPT_U_$P(^DPT(+DGPT,0),U)
 .I 'DOTMP S I=I+1,DGY(I)=+DGPT_U_$P(^DPT(+DGPT,0),U)
 I DOTMP S:I<1 NEWTMP=ORY_1_")",@NEWTMP="^No patients found."
 I 'DOTMP S:I<1 DGY(1)="^No patients found."
 Q
TEAMPR(DGY,PROV) ; return list of teams linked to a provider
 I +$G(PROV)<1 S DGY(1)="^No provider identified" Q 
 N DGTM,I,DGTMN
 S DGTM="",I=1
 F  S DGTM=$O(^OR(100.21,"C",+PROV,DGTM)) Q:+$G(DGTM)<1  D
 .S DGTMN=$P(^OR(100.21,DGTM,0),U)
 .S DGY(I)=DGTM_U_DGTMN,I=I+1
 S:+$G(DGY(1))<1 DGY(1)="^No teams found."
 Q
TEAMPR2(DGY,PROV) ; return list of teams linked to a provider
 ; This tag added by PKS/slc - 8/1999.
 I +$G(PROV)<1 S DGY(1)="^No provider identified" Q
 N DGTM,DGDATA,DGTMN,DGTYPE,I
 S DGTM="",I=1
 F  S DGTM=$O(^OR(100.21,"C",+PROV,DGTM)) Q:+$G(DGTM)<1  D
 .S DGDATA=^OR(100.21,ORTM,0) ; Get value.
 .S DGTMN=$P(ORDATA,U)        ; Team List name.
 .S DGTYPE=$P(ORDATA,U,2)     ; Team List type.
 .S DGY(I)=DGTM_U_DGTMN_U_DGTYPE,I=I+1
 S:+$G(DGY(1))<1 DGY(1)="^No teams found."
 Q
TEAMPROV(DGY,TEAM) ; return list of providers linked to a team
 I +$G(TEAM)<1 S DGY(1)="^No team identified"
 N PROV,I,SEQ
 S I=1
 S SEQ=0 F  S SEQ=$O(^OR(100.21,+TEAM,1,SEQ)) Q:SEQ<1  D
 .S PROV=^OR(100.21,+TEAM,1,SEQ,0) I $L(PROV) D
 ..S DGY(I)=+PROV_U_$P(^VA(200,+PROV,0),U),I=I+1
 S:+$G(DGY(1))<1 DGY(1)="^No providers found."
 Q
TPROVPT(PROV) ;return list of patients linked to a provider via teams
 ; Modified by PKS: 8/1999.
 I +$G(PROV)<1 S ^TMP("DGLPUPT",$J,"^No provider identified")=""
 N DGTM,DGTMN,DGI,DGPT
 S DGTM=""
 F  S DGTM=$O(^OR(100.21,"C",+PROV,DGTM)) Q:+$G(DGTM)<1  D  ; Teams.
 .S DGTMN=$P(^OR(100.21,+DGTM,0),U,1) ; Get name of Team List.
 .S DGI=0 F  S DGI=$O(^OR(100.21,+DGTM,10,DGI)) Q:DGI<1  D
 ..S DGPT=^OR(100.21,+DGTM,10,DGI,0)
 ..S ^TMP("DGLPUPT",$J,+DGPT_U_$P(^DPT(+DGPT,0),U))=""
 ..; Next line added by PKS:
 ..S ^TMP("DGLPUPT",$J,"B",DGTMN,$P(^DPT(+DGPT,0),U)_U_+DGPT)=""
 I '$D(^TMP("DGLPUPT",$J)) S ^TMP("DGLPUPT",$J,"^No patients found.")=""
 Q
TMSPT(DGY,PT) ;return list of teams linked to a patient (patient is active)
 I +$G(PT)<1 S DGY(1)="^No patient identified" Q
 N DGTM,I,DGTMN,DGTMTYP
 S DGTM="",I=1
 F  S DGTM=$O(^OR(100.21,"AB",+PT_";DPT(",DGTM)) Q:+$G(DGTM)<1  D
 .S DGTMN=$P(^OR(100.21,DGTM,0),U)
 .S DGTMTYP=$P(^OR(100.21,DGTM,0),U,2) I $L(DGTMTYP) D
 ..S DGTMTYP=$$EXTERNAL^DILFD(100.21,1,"",DGTMTYP,"")
 .S DGY(I)=DGTM_U_DGTMN_U_$S($L(DGTMTYP):DGTMTYP,1:"no type"),I=I+1
 S:+$G(DGY(1))<1 DGY(1)="^No teams found."
 Q
TPTPR(DGY,PT) ;return list of providers linked to a patient via teams
 I +$G(PT)<1 S DGY(1)="^No patient identified" Q
 N DGTM,PROV,SEQ
 S DGTM=""
 F  S DGTM=$O(^OR(100.21,"AB",+PT_";DPT(",DGTM)) Q:+$G(DGTM)<1  D
 .S SEQ=0 F  S SEQ=$O(^OR(100.21,+DGTM,1,SEQ)) Q:SEQ<1  D
 ..S PROV=^OR(100.21,+DGTM,1,SEQ,0) I $L(PROV) D
 ...S DGY(+PROV)=+PROV_U_$P(^VA(200,+PROV,0),U)
 S:'$D(DGY) DGY(1)="^No providers found."
 Q
PERSPR(DGY) ; return list of personal lists linked to current user
 N DGTM,I,DGTMN
 S DGTM="",I=1
 F  S DGTM=$O(^OR(100.21,"C",DUZ,DGTM)) Q:+$G(DGTM)<1  D
 .Q:$P(^OR(100.21,DGTM,0),U,2)'="P"  ;quit if not a personal list
 .S DGTMN=$P(^OR(100.21,DGTM,0),U)
 .S DGY(I)=DGTM_U_DGTMN,I=I+1
 S:+$G(DGY(1))<1 DGY(1)="^No personal lists found."
 Q
PRIMPT(DGY,DGPT) ; return patient's PCMM primary care team
 I +$G(DGPT)<1 S DGY(1)="^No patient identified"
 N DGQPUR,DGQERROR,DGQLST,DGQERR,DGQDT,DGIDT,DGADT,DGX
 S DGQPUR(2)=""  ;"2" is the ien for purpose "primary care" [^SD(403.47]
 D NOW^%DTC S DGQDT("BEGIN")=%-.0001,DGQDT("END")=%+.0001,DGQDT("INCL")=0
 S DGQERROR=$$TMPT^SCAPMC(.DGPT,"DGQDT","DGQPUR","DGQLST","DGQERR")
 I DGQERROR=0 S DGY="^Error in search for primary care team."
 I +$G(DGQLST(1))>0 D
 .S DGX=DGQLST(1),DGADT=$P(DGX,U,4),DGIDT=$P(DGX,U,5)
 .I ($G(DGADT)>$G(DGIDT)) S DGY=$P(DGX,U)_U_$P(DGX,U,2)
 S:+$G(DGY)<1 DGY="^No primary care team found."
 K %
 Q
PROVPT(DGY,DGPT) ; return PCMM primary provider for a patient
 I +$G(DGPT)<1 S DGY(1)="^No patient identified"
 S DGY(1)=$$OUTPTPR^SDUTL3(DGPT,$$NOW^XLFDT,1)
 Q
PPLINK(DGPROV,DGPT) ; returns '1' if patient is linked to provider
 N DGX,DGPP
 S DGX="",DGPP=0
 I (+$G(DGPT)<1)!(+$G(DGPROV)<1) Q 0
 I $D(^DPT("APR",DGPROV,DGPT)) Q "1^PRIM"  ;provider is patient's primary
 I $D(^DPT("AAP",DGPROV,DGPT)) Q "1^ATTD"  ;provider is patient's attending
 ;is provider and patient on the same team:
 D TPROVPT(DGPROV)
 F  S DGX=$O(^TMP("DGLPUPT",$J,DGX)) Q:DGX=""  D
 .I +DGX=DGPT S DGPP="1^OERRTM" Q
 K ^TMP("DGLPUPT",$J)
 ;
 ;If not linked already, see if linked via PCMM:
 I DGPP=0 S DGPP=$$PCMMLINK(DGPROV,DGPT)
 ;
 Q DGPP
PDLINK(DGDEV,DGPT) ; returns '1' if patient is linked to device via team
 ;DGDEV can be either ien or device name
 N DGY,DGX,DGTM,DGDP,DGTMDEV,DGDEVIEN
 S DGDP=0
 I (+$G(DGPT)<1)!($L($G(DGDEV))<1) Q 0
 ; Are device and patient on the same team?:
 I '$D(^%ZIS(1,DGDEV,0)) D  ;DGDEV is not an ien
 .S DGDEVIEN=0,DGDEVIEN=$O(^%ZIS(1,"B",$P(DGDEV,U),ORDEVIEN))
 .S DGDEV=DGDEVIEN
 Q:+$G(DGDEV)<1 0
 D TMSPT(.DGY,DGPT)
 S DGX="" F  S DGX=$O(DGY(DGX)) Q:DGX=""  D
 .S DGTM=DGY(DGX)
 .I $D(^OR(100.21,+DGTM,0)),$P(^(0),U,4)=DGDEV S DGDP=1 Q
 Q DGDP
PCMMLINK(DGPROV,DGPT) ;returns '1' if patient is linked to provider via PCMM
 N DGPP,DGPCMM,DGPCP
 S DGPP=0
 I (+$G(DGPT)<1)!(+$G(DGPROV)<1) Q 0
 ;
 ;provider is patient's PCMM primary care practitioner:
 I DGPROV=+$$OUTPTPR^SDUTL3(DGPT,$$NOW^XLFDT,1) Q "1^PCP"   ;DBIA #1252
 ;
 ;provider is patient's PCMM associate provider:
 I DGPROV=+$$OUTPTAP^SDUTL3(DGPT,$$NOW^XLFDT) Q "1^AP"      ;DBIA #1252
 ;
 ;provider is linked to patient via PCMM team position assignment:
 S DGPCMM=$$PRPT^SCAPMC(DGPT,,,,,,"^TMP(""DGPCMMLK"",$J)",)  ;DBIA #1916
 S DGPCP=0
 F  S DGPCP=$O(^TMP("DGPCMMLK",$J,"SCPR",DGPCP)) Q:'DGPCP!DGPP=1  D
 .I DGPROV=DGPCP S DGPP="1^PCMMTM"
 K ^TMP("DGPCMMLK",$J)
 ;
 Q DGPP
