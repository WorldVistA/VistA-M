SROCDX ;BIR/ADM - CASE CODING INPUT/EDIT ;08/29/05
 ;;3.0; Surgery ;**142**;24 Jun 93
PCPT ; edit principal procedure code
 N SRPPY,SRPRIN S (SRPRIN,X)=$P(^SRO(136,SRTN,0),"^",2) I 'X D PPROC Q
 W !,"Principal Procedure:",! D CPTDISP,ASDX^SROCDX1
 K DIR S DIR(0)="SO^1:Update Principal Procedure CPT Code;2:Update Associated Diagnoses"
 S DIR("A")="Enter selection (1 or 2)",DIR("B")=1 D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 S SRPPY=Y D  Q
 .I SRPPY=1 D PPROC Q
 .I SRPPY=2 D CASDX
 Q
PPROC N SRCPT S SRCPT=$P(^SRO(136,SRTN,0),"^",2),SRDIE=1 W !
 K DR,DIE,DA S DIE=136,DA=SRTN,DR=".02T" D ^DIE K DIE,DR,SRDIE I $D(Y) S SRSOUT=1
 D PRIN^SROMOD0 I SRCPT'=$P(^SRO(136,SRTN,0),"^",2) D SADXP^SROCDX2 K DA
 S X=$P(^SRO(136,SRTN,0),"^",2) I $G(SRPRIN)=X Q
CASDX ; associate principal CPT to diagnosis
 N SRADX,SRDX0,SRDX1,SRDX2,SRDXCT,SRODIR,SRDIRX,OTHCNT,SRASSDS,SROCT
 S CPT=$P(^SRO(136,SRTN,0),"^",2) Q:'CPT  K DIR
 S SRODIR("A",1)="   Select the number(s) of the Diagnosis Code to associate to"
 S SRODIR("A")="   the procedure selected"
 D HDR^SROCD,CPTDISP,ASDX^SROCDX1
 K DIR D SRODIR
 W !
 S DIR(0)=SRDX2,SRASSDS=$$PASSDS^SROCDX1,DIR("B")=SRASSDS
 F I=1:1 D ^DIR Q:(($$VALASC())&('$$DXDUP(Y)))
 Q:(Y["^")!(Y="")
 D PADD1^SROCDX1 Q
 Q:Y="Q"!(Y["")
 G CASDX
 Q
COTHADX D COTHBLD        ;Associate "Other" CPTs to Diagnosis
 N SRDX0,SRDX1,SRDX2,SRDIR,OTHCNT,SRASSDS
 S OTHCNT=SRDA
 S SRODIR("A",1)="   Select the number(s) of the Diagnosis Code to associate to"
 S SRODIR("A")="   the procedure selected"
 K DIR D HDR^SROCD,OTHCPTD,OTHADX^SROCDX1
 K DIR D SRODIR W ! F I=1:1:80 W "-"
 S DIR(0)=SRDX2 I $G(D0)="",$G(SRPOTH) S D0=SRPOTH
 S SRASSDS=$$OASSDS^SROCDX1
 S DIR("B")=SRASSDS I SRASSDS="",$G(SRDIRX(1))'="" S DIR("B")=1
 F I=1:1 D ^DIR Q:(($$VALASC())&('$$DXDUP(Y)))
 Q:(Y["^")!(Y="")
 D OADD1^SROCDX1
 Q:Y="Q"!(Y["")
 G COTHADX
 Q
DXDUP(SRDX) I (Y["^")!($G(DTOUT)) Q 0
 N SRAI,SRDXX,SRDUP,DIR S SRDUP=0
 I SRDX="" Q 0
 F SRAI=1:1:$L(SRDX,",") D
 .Q:$P(SRDX,",",SRAI)<1
 .I $D(SRDXX($P(SRDX,",",SRAI)))!((SRDIRX($P(SRDX,",",SRAI))="ALL")&($L(SRDX,",")>1)) S SRDUP=1,DIR(0)="FO^",DIR("A",1)="     **Duplicates entered",DIR("A")="     Press Return to continue" D ^DIR
 .S SRDXX($P(SRDX,",",SRAI))=""
 Q SRDUP
VALASC() I (Y["^")!('$G(Y(0)))!($G(DTOUT)) Q 1
 N VALA,DIR S VALA=1
 S:Y=""!(Y=U)!('+Y(0))!(Y[",0")!($P(Y,",",1)=0) VALA=0
 I 'VALA S DIR("A",1)="     **Invalid input",DIR(0)="FO^",DIR("A")="     Press Return to continue" D ^DIR
 Q VALA
SRODIR N SRFLG,SRCNT,SRCNTR
 S DIR("A",1)="Only the following ICD Diagnosis Codes can be associated:"
 S DIR("A",2)=""
 S (SRFLG,SRCNT)=1,SRCNTR=3,ADCNT="" F  S ADCNT=$O(SRDIRX(ADCNT)) Q:'ADCNT  D
 .S:'$D(DIR("A",SRCNTR)) DIR("A",SRCNTR)=""
 .S DIR("A",SRCNTR)=DIR("A",SRCNTR)_SRCNT_". "_SRDIRX(ADCNT),SRCNT=SRCNT+1,SRCNTR=SRCNTR+1,SRFLG=1
 S DIR("A",SRCNTR+2)=SRODIR("A",1),DIR("A")=SRODIR("A"),DIR("A",SRCNTR+1)=""
 Q
COTHBLD N SRCNT,OTH,X,CPT,CPT1,SRDA K SRSEL
 S OTH=0,SRCNT=1 F  S OTH=$O(^SRO(136,SRTN,3,OTH)) Q:'OTH  D
 .S X=$P(^SRO(136,SRTN,3,OTH,0),U),CPT1=""
 .I X S CPT1=X,Y=$$CPT^ICPTCOD(X),SRCPT=$P(Y,U,2),SRSHT=$P(Y,U,3),Y=SRCPT,SRDA=OTH D SSOTH^SROCPT0 S SRCPT=Y,CPT=SRCPT_"  "_SRSHT
 .S SRSEL(SRCNT)=OTH_"^CPT Code: "_CPT_U_CPT1_U_$E(SRCPT,1,5)_"  "_SRSHT
 .S SRCNT=SRCNT+1
 Q
OTHCPTD N SRM,SRI,SRFIRST,SRY ;PROCS/Codes/Mods.
 S SRFIRST=0 D COTHBLD
 W !,"Other Procedures:",!!,OTHCNT,"."," CPT Code: "_$P(SRSEL(SRDA),U,4)
 S OTH=$P(SRSEL(SRDA),U) W !,?5,"Modifiers: "
 S SRI=0 F  S SRI=$O(^SRO(136,SRTN,3,OTH,1,SRI)) Q:'SRI  D
 .S SRM=$P(^SRO(136,SRTN,3,OTH,1,SRI,0),U)
 .W:SRFIRST !,?16 W $P($$MOD^ICPTMOD(SRM,"I"),"^",2),"-",$P($$MOD^ICPTMOD(SRM,"I"),"^",3)
 .S SRFIRST=1
 I '$O(^SRO(136,SRTN,3,OTH,1,0)) W "NOT ENTERED"
 Q
CPTDISP N SRFIRST,SRMO
 S X=$P(^SRO(136,SRTN,0),U,2) I X S SRY=$$CPT^ICPTCOD(X),Y=$P(SRY,U,2),(SROCPT2,Z)=$P(SRY,U,3)
 S:'$D(Y) Y="NOT ENTERED",Z="" W !,?3,"CPT Code: "_Y_"  "_Z,!,?3,"Modifiers: "
 I '$O(^SRO(136,SRTN,1,0)) W "NOT ENTERED"
 S SRMOD=0 F  S SRMOD=$O(^SRO(136,SRTN,1,SRMOD)) Q:'SRMOD  D
 .S SRMO=$P(^SRO(136,SRTN,1,SRMOD,0),U)
 .W:$G(SRFIRST) !,?14 W $P($$MOD^ICPTMOD(SRMO,"I"),"^",2),"-",$P($$MOD^ICPTMOD(SRMO,"I"),"^",3)
 .S SRFIRST=1
 Q
