SCRPO2 ;BP-CIOFO/KEITH - Historical Patient Position Assignment Listing (cont.) ;7/31/99  22:36
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
BPTPA(SCPASS,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT) ;Evaluate patient team position assignment information
 ;Input: SCPASS=patient team position assignment information
 ;              string from $$PTTP^SCAPMC
 ;Input: SCDIV=division^ifn 
 ;Input: SCTEAM=team^ifn 
 ;Input: SCPOS=team position^ifn 
 ;Input: SCLINIC=associated clinic^ifn (if one exists)
 ;Input: SCFMT=report format (detail or summary)
 ;
 ;evaluate assignment/gather data
 N SCPTPA,SCPTPA0,SCPC,DFN,SCPT0,SCACT,SCINACT,SCDT,SCPROV,SCX,SDOE0
 N SCS,SCI,SCY,SCATY,SCAGE,SCARR,SCENRP,SCGEND,SCLAPP,SCMTST,SCNAPP
 N SCPAT,SCPELIG,SCPTYP,SCSSN,ERR
 S SCPTPA=$P(SCPASS,U,3) Q:SCPTPA<1  ;patient team position assignment
 S SCPTPA0=$G(^SCPT(404.43,+SCPTPA,0)) Q:'$L(SCPTPA0)
 S SCACT=$P(SCPTPA0,U,3),SCINACT=$P(SCPTPA0,U,4)  ;activation dates
 ;adjust dates if necessary
 S:SCACT<^TMP("SC",$J,"DTR","BEGIN") SCACT=$P(^TMP("SC",$J,"DTR","BEGIN"),U)
 I 'SCINACT!(SCINACT>^TMP("SC",$J,"DTR","END")) S SCINACT=$P(^TMP("SC",$J,"DTR","END"),U)
 S SCPC=$P(SCPTPA0,U,5) Q:'$$PCROLE(.SCPC)  ;pc role?
 I $O(^TMP("SC",$J,"PCP",0)),SCPC="NO" Q  ;no pc providers here
 S DFN=$P(SCPASS,U),SCPT0=$G(^DPT(+DFN,0)) Q:'$L(SCPT0)  ;patient node
 Q:'$$PTCL(DFN,.SCLINIC,SCACT,SCINACT)  ;enrolled clinic
 S SCDT("BEGIN")=SCACT,SCDT("END")=SCINACT,SCDT("INCL")=0,SCDT="SCDT"
 S SCARR="^TMP(""SCARR"",$J,2)" K @SCARR
 S SCI=$$PRTPC^SCAPMC($P(SCPOS,U,2),.SCDT,SCARR,"ERR",1,1)
 Q:'$$PROV(.SCPROV,SCPC)  ;providers
 S SCPAT=$P(SCPT0,U)_U_DFN  ;patient name^dfn
 S SCSSN=$P(SCPT0,U,9)  ;patient ssn
 S SCGEND=$S($P(SCPT0,U,2)="M":"MALE",1:"FEMALE")  ;patient gender
 S SCAGE=$$AGEGR($P(SCPT0,U,3))  ;patient age group
 S SCPELIG=$$ELIG^SCRPO(DFN)  ;primary eligibility
 S SCMTST=$P($$LST^DGMTU(DFN,SCINACT),U,3,4)  ;mt status
 S:'$L(SCMTST) SCMTST="(not applicable)^"
 K SCX S SDOE0=$P(^TMP("SC",$J,"DTR","END"),U)_U_DFN
 D ENEP^SCRPW24(.SCX,"H") S SCENRP=$P(SCX(1),U,2)  ;enrollment priority
 ;
 ;Set data string
 S SCX=$E($P(SCPAT,U),1,18)_U_$E(SCSSN,6,10)
 S SCX=SCX_U_$P(SCPELIG,U,2)_U_$P(SCMTST,U,2)
 S SCX=SCX_U_$E($P(SCTEAM,U),1,13)_U_U_$E($P(SCPOS,U),1,14)_U
 S SCX=SCX_U_$E($P(SCLINIC,U),1,14)
 ;
 ;Set line for each provider
 S SCN=0 F  S SCN=$O(SCPROV(SCN)) Q:'SCN  D
 .S SCPROV=$P(SCPROV(SCN),U,1,2),SCPTYP=$P(SCPROV(SCN),U,3)
 .S SCATY=$S($P(SCPROV(SCN),U,4)="P":"PRECEPTOR PROVIDER",1:"ASSIGNED PROVIDER")
 .S $P(SCX,U,6)=$E($P(SCPROV,U),1,14),$P(SCX,U,8)=SCPTYP
 .S $P(SCX,U,10)=$P(SCPROV(SCN),U,5,6)
 .;
 .;Set sort values
 .I SCFMT="D" F SCI=1:1:6 S SCS=$P($G(^TMP("SC",$J,"SORT",SCI)),U,3) D
 ..I $L(SCS) S SCY=@SCS S:'$L(SCY) SCY="~~~"
 ..S:'$L(SCS) SCY="~~~" S SCS(SCI)=SCY
 ..Q
 .;Set report detail global
 .I SCFMT="D" D LSET(.SCS,SCX)
 .;
 .;Set report statistics nodes
 .S ^TMP("SCRPT",$J,0,SCATY,SCPROV)=$G(^TMP("SCRPT",$J,0,SCATY,SCPROV))+1
 I $L(SCPELIG) S ^TMP("SCRPT",$J,0,"PRIMARY ELIGIBILITY",SCPELIG)=$G(^TMP("SCRPT",$J,0,"PRIMARY ELIGIBILITY",SCPELIG))+1
 I $L(SCMTST) S ^TMP("SCRPT",$J,0,"MEANS TEST CATEGORY",SCMTST)=$G(^TMP("SCRPT",$J,0,"MEANS TEST CATEGORY",SCMTST))+1
 S ^TMP("SCRPT",$J,0,"GENDER",SCGEND)=$G(^TMP("SCRPT",$J,0,"GENDER",SCGEND))+1
 S ^TMP("SCRPT",$J,0,"AGE GROUP",SCAGE)=$G(^TMP("SCRPT",$J,0,"AGE GROUP",SCAGE))+1
 S ^TMP("SCRPT",$J,0,"NATIONAL ENROLLMENT PRIORITY",SCENRP)=$G(^TMP("SCRPT",$J,0,"NATIONAL ENROLLMENT PRIORITY",SCENRP))+1
 S ^TMP("SCRPT",$J,0,"TEAM",SCTEAM)=$G(^TMP("SCRPT",$J,0,"TEAM",SCTEAM))+1
 S ^TMP("SCRPT",$J,0,"PRIMARY CARE",SCPC)=$G(^TMP("SCRPT",$J,0,"PRIMARY CARE",SCPC))+1
 S ^TMP("SCRPT",$J,0,"DIVISION",SCDIV)=$G(^TMP("SCRPT",$J,0,"DIVISION",SCDIV))+1
 S ^TMP("SCRPT",$J,0,"ASSIGNMENTS")=$G(^TMP("SCRPT",$J,0,"ASSIGNMENTS"))+1
 S ^TMP("SCRPT",$J,0,"UNIQUES",DFN)=""
 Q
 ;
LSET(SCS,SCX) ;Set report line
 ;Input: SCS=array of sort values
 ;Input: SCX=data string
 N SCI,SCN,SCL
 S SCN=$G(^TMP("SCRPT",$J,1,SCS(1),SCS(2),SCS(3))) I 'SCN D
 .S ^TMP("SCRPT",$J,1)=$G(^TMP("SCRPT",$J,1))+1
 .S SCN=^TMP("SCRPT",$J,1)
 .S ^TMP("SCRPT",$J,1,SCS(1),SCS(2),SCS(3))=SCN
 .Q
 S ^TMP("SCRPT",$J,2)=$G(^TMP("SCRPT",$J,2))+1
 S SCL=^TMP("SCRPT",$J,2)
 S ^TMP("SCRPT",$J,2,SCN,SCS(4),SCS(5),SCS(6),SCL)=SCX
 Q
 ;
PROV(SCPROV,SCPC) ;evaluate providers
 ;Input: SCPROV=variable to return array of provider^ifn^type
 ;Input: SCPC=pc? yes/no
 ;Output: '1' if successful, '0' otherwise
 ;
 N SCI,SCPCF,SCFOUND,SCFPC,SCFAS,SCPRD,SCN,SCSUB,SCLEV,SCR,SCPP
 S SCFPC=$O(^TMP("SC",$J,"PCP",0))>0  ;find pc provider flag
 S SCFAS=$O(^TMP("SC",$J,"ASPR",0))>0  ;find assigned provider flag
 S SCPCF=$S(SCPC="NO":0,$D(^TMP("SCARR",$J,2,"PPROV")):2,1:1),SCN=0
 S SCFOUND=$S(SCFPC!SCFAS:0,1:1)  ;success indicator
 S SCPP=0,SCR="" F  S SCR=$O(^TMP("SCARR",$J,2,SCR)) Q:'SCR!SCPP  D
 .S:$D(^TMP("SCARR",$J,2,SCR,"PREC")) SCPP=1
 .Q  ;Preceptor position flag
 I SCFAS D  ;Find selected assigned providers
 .S SCR=""
 .F  S SCI=$O(^TMP("SCARR",$J,2,SCR)) Q:SCR=""  D
 ..S SCI=""
 ..F  S SCI=$O(^TMP("SCARR",$J,2,SCR,"PROV-P",SCI)) Q:SCI=""  D
 ...S SCPRD=^TMP("SCARR",$J,2,SCR,"PROV-P",SCI)
 ...I $D(^TMP("SC",$J,"ASPR",+SCPRD)) D PSET(SCPRD,SCPC,1,.SCN,"A",SCPP) S SCFOUND=1
 ...Q
 ..Q
 .S SCR=""
 .F  S SCI=$O(^TMP("SCARR",$J,2,SCR)) Q:SCR=""  D
 ..S SCI=""
 ..F  S SCI=$O(^TMP("SCARR",$J,2,SCR,"PROV-U",SCI)) Q:SCI=""  D
 ...S SCPRD=^TMP("SCARR",$J,2,SCR,"PROV-U",SCI)
 ...I $D(^TMP("SC",$J,"ASPR",+SCPRD)) D PSET(SCPRD,SCPC,1,.SCN,"A",0) S SCFOUND=1
 ...Q
 ..Q
 .Q
 I SCFPC,'SCPP D  ;Find selected pc providers in top level
 .S SCR=""
 .F  S SCI=$O(^TMP("SCARR",$J,2,SCR)) Q:SCR=""  D
 ..S SCI=""
 ..F  S SCI=$O(^TMP("SCARR",$J,2,SCR,"PROV-U",SCI)) Q:SCI=""  D
 ...S SCPRD=^TMP("SCARR",$J,2,SCR,"PROV-U",SCI)
 ...I $D(^TMP("SC",$J,"PCP",+SCPRD)) D PSET(SCPRD,SCPC,1,.SCN,"A",SCPP) S SCFOUND=1
 ...Q
 ..Q
 .Q
 I SCFPC,SCPP D  ;Find selected pc providers in preceptor level
 .S SCR=""
 .F  S SCI=$O(^TMP("SCARR",$J,2,SCR)) Q:SCR=""  D
 ..S SCI=""
 ..F  S SCI=$O(^TMP("SCARR",$J,2,SCR,"PREC",SCI)) Q:SCI=""  D
 ...S SCPRD=^TMP("SCARR",$J,2,SCR,"PREC",SCI)
 ...I $D(^TMP("SC",$J,"PCP",+SCPRD)) D PSET(SCPRD,SCPC,2,.SCN,"P",SCPP) S SCFOUND=1
 ...Q
 ..Q
 .Q
 I SCFAS!SCFPC Q SCFOUND
 ;Get all providers
 S SCR="" F  S SCR=$O(^TMP("SCARR",$J,2,SCR)) Q:SCR=""  D
 .F SCSUB="PROV-P","PROV-U","PREC" S SCI="" D
 ..Q:SCPC="NO"&(SCSUB="PREC")  ;no preceptors for non-pc
 ..S SCLEV=$S(SCSUB="PREC":2,1:1)
 ..F  S SCI=$O(^TMP("SCARR",$J,2,SCR,SCSUB,SCI)) Q:SCI=""  D
 ...S SCPRD=^TMP("SCARR",$J,2,SCR,SCSUB,SCI)
 ...D PSET(SCPRD,SCPC,SCLEV,.SCN,$S(SCSUB="PREC":"P",1:"A"),$S(SCSUB="PROV-U":0,1:SCPP))
 ...Q
 ..Q
 .Q
 I '$O(SCPROV(0)) S SCPROV(1)="[not assigned]"_U_U_$S(SCPCF=0:"NPC",SCPCF=2:" AP",1:"PCP")
 Q SCFOUND
 ;
PSET(SCPRD,SCPC,SCLEV,SCN,SCATY,SCPP) ;Set local provider array
 ;Input: SCRPD=provider data from PRTPC^SCAPMC
 ;Input: SCPC=pc? yes/no
 ;Input: SCLEV='1' for assigned position, '2' for preceptor position
 ;Input: SCN=array incrementing number
 ;Input: SCPTY='A' for assigned provider, 'P' for preceptor provider
 ;Input: SCPP='1' if preceptor position exists, '0' otherwise
 N SCPRTY
 S SCPRTY=$S(SCPC="NO":"NPC",SCLEV=1&SCPP:" AP",1:"PCP")
 I SCATY="P",$P(SCPRD,U,14)>$P(SCPRD,U,9) D
 .S $P(SCPRD,U,9)=$P(SCPRD,U,14),$P(SCPRD,U,10)=$P(SCPRD,U,15)
 .Q
 S SCN=SCN+1
 S SCPROV(SCN)=$S($P(SCPRD,U,2)="":"[not assigned]",1:$P(SCPRD,U,2))
 S SCPROV(SCN)=SCPROV(SCN)_U_+SCPRD_U_SCPRTY_U_SCATY_U
 S SCPROV(SCN)=SCPROV(SCN)_$$DT($P(SCPRD,U,9))_U_$$DT($P(SCPRD,U,10))
 Q 
 ;
DT(X) ;Transform date
 S X=$E(X,1,7) Q:X'?7N ""
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_(17+$E(X))_$E(X,2,3)
 ;
PCROLE(SCPC) ;Determine PC? y/n
 ;Input: SCPC=pc role from file #404.43 (output as 'yes' or 'no' if successful)
 ;Output: '1' if successful, '0' otherwise
 ;
 I $E(^TMP("SC",$J,"ATYPE"))="P",SCPC<1 Q 0
 I $E(^TMP("SC",$J,"ATYPE"))="N",SCPC>0 Q 0
 S SCPC=$S(SCPC>0:"YES",1:"NO")
 Q 1
 ;
PTCL(DFN,SCLINIC,SCACT,SCINACT) ;evaluate enrolled clinic
 ;Input: DFN=patient ifn
 ;Input: SCLINIC=team position associated clinic 
 ;       (returned if successful and enrolled, null otherwise)
 ;Output: '1' if successful, '0' otherwise
 ;
 N SCIFN,SCPE,ENR,SCPED,SCPED0
 S SCIFN=$P(SCLINIC,U,2) Q:'SCIFN 1  ;not required, no associated clinic
 I $D(^TMP("SC",$J,"CLINIC",SCIFN)),'$D(^DPT(DFN,"DE","B",SCIFN)) Q 0
 ;required, never enrolled
 S (ENR,SCPE)=0
 F  S SCPE=$O(^DPT(DFN,"DE","B",SCIFN,SCPE)) Q:'SCPE!ENR  D
 .S SCPED=0 F  S SCPED=$O(^DPT(DFN,"DE",SCPE,1,SCPED)) Q:'SCPED!ENR  D
 ..S SCPED0=$G(^DPT(DFN,"DE",SCPE,1,SCPED,0)) Q:'+SCPED0
 ..I $P(SCPED0,U,3),$P(SCPED0,U,3)'<SCACT,+SCPED0'>SCINACT S ENR=1 Q
 ..I '$P(SCPED0,U,3),+SCPED0'>SCINACT S ENR=1
 ..Q
 .Q
 I $D(^TMP("SC",$J,"CLINIC",SCIFN)),'ENR S SCLINIC="" Q 0
 I '$D(^TMP("SC",$J,"CLINIC",SCIFN)),'ENR S SCLINIC="" Q 1
 Q 1
 ;
AGEGR(SCDT) ;Calculate age group
 ;Input: SCDT=patient birth date
 N X,Y,X1,X2
 S X1=DT,X2=SCDT D ^%DTC Q:X<0 "unknown"
 S X=X\365.4 Q:X<5 "0 - 4"
 S Y=X\5 S:'(Y#2) Y=Y-1
 Q (Y*5)_" - "_(Y*5+9)
