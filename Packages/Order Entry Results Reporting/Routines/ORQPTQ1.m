ORQPTQ1 ; SLC/CLA - Functs which return OR patient lists and sources pt 1 ; 8/20/07 5:43am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,74,63,91,85,139,243**;Dec 17, 1997;Build 242
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
DEFTM(ORY) ; return current user's default team list
 Q:'$D(DUZ)
 N ORSRV S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S ORY=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT TEAM",1,"B")
 Q
TEAMS(ORY) ; return list of teams for a system
 ; Also called under DBIA # 2692.
 N ORTM,I,ORTMN
 S ORTMN="",I=1
 F  S ORTMN=$O(^OR(100.21,"B",ORTMN)) Q:ORTMN=""  D
 .S ORTM="",ORTM=$O(^OR(100.21,"B",ORTMN,ORTM)) Q:ORTM=""
 .I $P($G(^OR(100.21,ORTM,11)),U)'=0!($D(^OR(100.21,ORTM,1,$G(DUZ,0)))) S ORY(I)=ORTM_U_ORTMN,I=I+1
 S:+$G(ORY(1))<1 ORY(1)="^No teams found."
 Q
TEAMPTS(ORY,TEAM,TMPFLAG) ; RETURN LIST OF PATIENTS IN A TEAM
 ; Also called under DBIA # 2692.
 ; If TMPFLAG passed and = TRUE, code expects a "^TMP(xxx"
 ;    global root string passed in ORY, and builds the returned 
 ;    list in that global instead of to a memory array.
 N DOTMP,NEWTMP
 S DOTMP=0
 I $G(TMPFLAG) D             ; Was value passed?
 .I TMPFLAG S DOTMP=1        ; Is value TRUE?
 I +$G(TEAM)<1 D
 .I DOTMP S NEWTMP=ORY_1_")",@NEWTMP="^No team identified" Q
 .I 'DOTMP S ORY(1)="^No team identified" Q
 N ORI,ORPT,I
 S I=0
 S ORI=0 F  S ORI=$O(^OR(100.21,+TEAM,10,ORI)) Q:ORI<1  D
 .S ORPT=^OR(100.21,+TEAM,10,ORI,0)
 .I DOTMP D
 ..S I=I+1,NEWTMP=ORY_+I_")"
 ..S @NEWTMP=+ORPT_U_$P(^DPT(+ORPT,0),U)
 .I 'DOTMP S I=I+1,ORY(I)=+ORPT_U_$P(^DPT(+ORPT,0),U)
 I DOTMP S:I<1 NEWTMP=ORY_1_")",@NEWTMP="^No patients found."
 I 'DOTMP S:I<1 ORY(1)="^No patients found."
 Q
TEAMPR(ORY,PROV) ; return list of teams linked to a provider
 I +$G(PROV)<1 S ORY(1)="^No provider identified" Q 
 N ORTM,I,ORTMN
 S ORTM="",I=1
 F  S ORTM=$O(^OR(100.21,"C",+PROV,ORTM)) Q:+$G(ORTM)<1  D
 .S ORTMN=$P(^OR(100.21,ORTM,0),U)
 .S ORY(I)=ORTM_U_ORTMN,I=I+1
 S:+$G(ORY(1))<1 ORY(1)="^No teams found."
 Q
TEAMPR2(ORY,PROV) ; return list of teams linked to a provider
 ; This tag added by PKS/slc - 8/1999.
 I +$G(PROV)<1 S ORY(1)="^No provider identified" Q
 N ORTM,ORDATA,ORTMN,ORTYPE,I
 S ORTM="",I=1
 F  S ORTM=$O(^OR(100.21,"C",+PROV,ORTM)) Q:+$G(ORTM)<1  D
 .S ORDATA=^OR(100.21,ORTM,0) ; Get value.
 .S ORTMN=$P(ORDATA,U)        ; Team List name.
 .S ORTYPE=$P(ORDATA,U,2)     ; Team List type.
 .S ORY(I)=ORTM_U_ORTMN_U_ORTYPE,I=I+1
 S:+$G(ORY(1))<1 ORY(1)="^No teams found."
 Q
TEAMPROV(ORY,TEAM) ; return list of providers linked to a team
 I +$G(TEAM)<1 S ORY(1)="^No team identified"
 N PROV,I,SEQ
 S I=1
 S SEQ=0 F  S SEQ=$O(^OR(100.21,+TEAM,1,SEQ)) Q:SEQ<1  D
 .S PROV=^OR(100.21,+TEAM,1,SEQ,0) I $L(PROV) D
 ..S ORY(I)=+PROV_U_$P(^VA(200,+PROV,0),U),I=I+1
 S:+$G(ORY(1))<1 ORY(1)="^No providers found."
 Q
TPROVPT(PROV) ;return list of patients linked to a provider via teams
 ; Modified by PKS: 8/1999.
 I +$G(PROV)<1 S ^TMP("ORLPUPT",$J,"^No provider identified")=""
 N ORTM,ORTMN,ORI,ORPT
 S ORTM=""
 F  S ORTM=$O(^OR(100.21,"C",+PROV,ORTM)) Q:+$G(ORTM)<1  D  ; Teams.
 .S ORTMN=$P(^OR(100.21,+ORTM,0),U,1) ; Get name of Team List.
 .S ORI=0 F  S ORI=$O(^OR(100.21,+ORTM,10,ORI)) Q:ORI<1  D
 ..S ORPT=^OR(100.21,+ORTM,10,ORI,0)
 ..S ^TMP("ORLPUPT",$J,+ORPT_U_$P(^DPT(+ORPT,0),U))=""
 ..; Next line added by PKS:
 ..S ^TMP("ORLPUPT",$J,"B",ORTMN,$P(^DPT(+ORPT,0),U)_U_+ORPT)=""
 I '$D(^TMP("ORLPUPT",$J)) S ^TMP("ORLPUPT",$J,"^No patients found.")=""
 Q
TMSPT(ORY,PT) ;return list of teams linked to a patient (patient is active)
 I +$G(PT)<1 S ORY(1)="^No patient identified" Q
 N ORTM,I,ORTMN,ORTMTYP
 S ORTM="",I=1
 F  S ORTM=$O(^OR(100.21,"AB",+PT_";DPT(",ORTM)) Q:+$G(ORTM)<1  D
 .S ORTMN=$P(^OR(100.21,ORTM,0),U)
 .S ORTMTYP=$P(^OR(100.21,ORTM,0),U,2) I $L(ORTMTYP) D
 ..S ORTMTYP=$$EXTERNAL^DILFD(100.21,1,"",ORTMTYP,"")
 .S ORY(I)=ORTM_U_ORTMN_U_$S($L(ORTMTYP):ORTMTYP,1:"no type"),I=I+1
 S:+$G(ORY(1))<1 ORY(1)="^No teams found."
 Q
TPTPR(ORY,PT) ;return list of providers linked to a patient via teams
 I +$G(PT)<1 S ORY(1)="^No patient identified" Q
 N ORTM,PROV,SEQ
 S ORTM=""
 F  S ORTM=$O(^OR(100.21,"AB",+PT_";DPT(",ORTM)) Q:+$G(ORTM)<1  D
 .S SEQ=0 F  S SEQ=$O(^OR(100.21,+ORTM,1,SEQ)) Q:SEQ<1  D
 ..S PROV=^OR(100.21,+ORTM,1,SEQ,0) I $L(PROV) D
 ...S ORY(+PROV)=+PROV_U_$P(^VA(200,+PROV,0),U)
 S:'$D(ORY) ORY(1)="^No providers found."
 Q
PERSPR(ORY) ; return list of personal lists linked to current user
 N ORTM,I,ORTMN
 S ORTM="",I=1
 F  S ORTM=$O(^OR(100.21,"C",DUZ,ORTM)) Q:+$G(ORTM)<1  D
 .Q:$P(^OR(100.21,ORTM,0),U,2)'="P"  ;quit if not a personal list
 .S ORTMN=$P(^OR(100.21,ORTM,0),U)
 .S ORY(I)=ORTM_U_ORTMN,I=I+1
 S:+$G(ORY(1))<1 ORY(1)="^No personal lists found."
 Q
PRIMPT(ORY,ORPT) ; return patient's PCMM primary care team
 I +$G(ORPT)<1 S ORY(1)="^No patient identified"
 N ORQPUR,ORQERROR,ORQLST,ORQERR,ORQDT,ORIDT,ORADT,ORX
 S ORQPUR(2)=""  ;"2" is the ien for purpose "primary care" [^SD(403.47]
 D NOW^%DTC S ORQDT("BEGIN")=%-.0001,ORQDT("END")=%+.0001,ORQDT("INCL")=0
 S ORQERROR=$$TMPT^SCAPMC(.ORPT,"ORQDT","ORQPUR","ORQLST","ORQERR")
 I ORQERROR=0 S ORY="^Error in search for primary care team."
 I +$G(ORQLST(1))>0 D
 .S ORX=ORQLST(1),ORADT=$P(ORX,U,4),ORIDT=$P(ORX,U,5)
 .I ($G(ORADT)>$G(ORIDT)) S ORY=$P(ORX,U)_U_$P(ORX,U,2)
 S:+$G(ORY)<1 ORY="^No primary care team found."
 K %
 Q
PROVPT(ORY,ORPT) ; return PCMM primary provider for a patient
 I +$G(ORPT)<1 S ORY(1)="^No patient identified"
 S ORY(1)=$$OUTPTPR^SDUTL3(ORPT,$$NOW^XLFDT,1)
 Q
PPLINK(ORPROV,ORPT) ; returns '1' if patient is linked to provider
 N ORX,ORPP
 S ORX="",ORPP=0
 I (+$G(ORPT)<1)!(+$G(ORPROV)<1) Q 0
 I $D(^DPT("APR",ORPROV,ORPT)) Q "1^PRIM"  ;provider is patient's primary
 I $D(^DPT("AAP",ORPROV,ORPT)) Q "1^ATTD"  ;provider is patient's attending
 ;is provider and patient on the same team:
 D TPROVPT(ORPROV)
 F  S ORX=$O(^TMP("ORLPUPT",$J,ORX)) Q:ORX=""  D
 .I +ORX=ORPT S ORPP="1^OERRTM" Q
 K ^TMP("ORLPUPT",$J)
 ;
 ;If not linked already, see if linked via PCMM:
 I ORPP=0 S ORPP=$$PCMMLINK(ORPROV,ORPT)
 ;
 Q ORPP
PDLINK(ORDEV,ORPT) ; returns '1' if patient is linked to device via team
 ;ORDEV can be either ien or device name
 N ORY,ORX,ORTM,ORDP,ORTMDEV,ORDEVIEN
 S ORDP=0
 I (+$G(ORPT)<1)!($L($G(ORDEV))<1) Q 0
 ; Are device and patient on the same team?:
 I '$D(^%ZIS(1,ORDEV,0)) D  ;ORDEV is not an ien
 .S ORDEVIEN=0,ORDEVIEN=$O(^%ZIS(1,"B",$P(ORDEV,U),ORDEVIEN))
 .S ORDEV=ORDEVIEN
 Q:+$G(ORDEV)<1 0
 D TMSPT(.ORY,ORPT)
 S ORX="" F  S ORX=$O(ORY(ORX)) Q:ORX=""  D
 .S ORTM=ORY(ORX)
 .I $D(^OR(100.21,+ORTM,0)),$P(^(0),U,4)=ORDEV S ORDP=1 Q
 Q ORDP
PCMMLINK(ORPROV,ORPT) ;returns '1' if patient is linked to provider via PCMM
 N ORPP,ORPCMM,ORPCP
 S ORPP=0
 I (+$G(ORPT)<1)!(+$G(ORPROV)<1) Q 0
 ;
 ;provider is patient's PCMM primary care practitioner:
 I ORPROV=+$$OUTPTPR^SDUTL3(ORPT,$$NOW^XLFDT,1) Q "1^PCP"   ;DBIA #1252
 ;
 ;provider is patient's PCMM associate provider:
 I ORPROV=+$$OUTPTAP^SDUTL3(ORPT,$$NOW^XLFDT) Q "1^AP"      ;DBIA #1252
 ;
 ;provider is linked to patient via PCMM team position assignment:
 S ORPCMM=$$PRPT^SCAPMC(ORPT,,,,,,"^TMP(""ORPCMMLK"",$J)",)  ;DBIA #1916
 S ORPCP=0
 F  S ORPCP=$O(^TMP("ORPCMMLK",$J,"SCPR",ORPCP)) Q:'ORPCP!ORPP=1  D
 .I ORPROV=ORPCP S ORPP="1^PCMMTM"
 K ^TMP("ORPCMMLK",$J)
 ;
 Q ORPP
PUNSIGN(ORY,ORBDFN) ;rtns array of providers with unsigned orders for pt
 N ORDG,ORX,ORZ,ORDNUM
 S ORDG=$$DG^ORQOR1("ALL")  ;get Display Group ien
 K ^TMP("ORR",$J)
 ;get unsigned orders:
 D EN^ORQ1(ORBDFN_";DPT(",ORDG,11,"","","",0,0)
 S ORX="",ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""
 I +$G(^TMP("ORR",$J,ORX,"TOT"))>0 D
 .S ORX="" F  S ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""  D
 ..S ORZ="" F  S ORZ=$O(^TMP("ORR",$J,ORX,ORZ)) Q:+$G(ORZ)<1  D
 ...S ORDNUM=^TMP("ORR",$J,ORX,ORZ)
 ...S ORY(+$$UNSIGNOR^ORQOR2(+ORDNUM))=""
 K ^TMP("ORR",$J)
 Q
