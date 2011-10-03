SROMOD0 ;BIR/ADM - CPT MODIFIER INPUT ;08/01/05
 ;;3.0; Surgery ;**142,165**;24 Jun 93;Build 6
 Q
DISPLAY ; display name with modifier
 N SRY,SRDA,SRDATE S SRDATE=DT
 S SRDA=$S($G(SRTN):SRTN,$D(DA(1)):DA(1),$D(DA):DA,1:"")
 I $G(SRDA) S SRDATE=$P($G(^SRF(SRDA,0)),"^",9)
 S SRY=$$MOD^ICPTMOD(Y,"I",SRDATE) Q:$P(SRY,"^")=-1
 S Y=$P(SRY,"^",2)_"  "_$P(SRY,"^",3)
 Q
SCR27() ; screen for acceptable CPT code/modifier pair for principal procedure
 N SRCODE,SRDA,SRCMOD,SROK,SRSDATE,SRZ D PCHK K SRM
 Q SROK
PCHK ; return value of modifier if acceptable for principal procedure
 N SRSDATE S SRSDATE=DT
 S SROK=0,SRCODE="",SRDA=$S($G(SRTN):SRTN,$D(DA(1)):DA(1),$D(DA):DA,1:""),SRM=$S($D(SRM):SRM,1:+Y)
 I SRDA S SRSDATE=$P(^SRF(SRDA,0),"^",9),SRCODE=$P($G(^SRO(136,SRDA,0)),"^",2)
 ;; Begin *165 - RJS
 I 'SRCODE!(X=51) Q
 ;;End *165 - RJS
 S SRZ=$P($$MODP^ICPTMOD(SRCODE,SRM,"I",SRSDATE),"^") I SRZ>0 S SROK=SRZ
 Q
OTH() ; screen for acceptable CPT code/modifier pair for other procedure
 N SRCODE,SRDA,SRCMOD,SROK,SROTH,SRSDATE,SRZ D OCHK K SRM
 Q SROK
OCHK ; return value of modifier if acceptable for other procedure
 N SRSDATE S SRSDATE=DT
 S SROK=0,SRCODE="",SRDA=$S($G(SRTN):SRTN,$D(DA(2)):DA(2),$D(DA(1)):DA(1),$D(D0):D0,1:""),SROTH=$S($D(DA):DA,$D(D1):D1,1:""),SRM=$S($D(SRM):SRM,1:+Y)
 I SRDA&SROTH S SRSDATE=$P(^SRF(SRDA,0),"^",9),SRCODE=$P($G(^SRO(136,SRDA,3,SROTH,0)),"^")
 I 'SRCODE Q
 S SRZ=$P($$MODP^ICPTMOD(SRCODE,SRM,"I",SRSDATE),"^") I SRZ>0 S SROK=SRZ
 Q
PRIN ; enter CPT modifiers for principal CPT code
 Q:$E($G(IOST),1,2)'="C-"!($G(DIK)'="")
 N SRCODE,SRDA,SRDEF,SRIEN,SRJ,SRQ,SRSDATE,SRSEL,SRSOUT,SRX,SRY,Z
 S (SRQ,SRSOUT)=0,SRDA=DA,SRCODE=$P(^SRO(136,SRDA,0),"^",2),SRIEN=$O(^SRO(136,SRDA,1,"AAA"),-1)
 I SRIEN S SRX=$P(^SRO(136,SRDA,1,SRIEN,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRX,"I"),"^",2)
 K DIR F  D  K SRM,SRCMOD Q:SRSOUT  S SRQ=0
 .S DIR("A")=" Modifier: ",DIR(0)="136.01,.01AO" S:$G(SRCMOD)'="" DIR("B")=SRCMOD D:$O(^SRO(136,SRDA,1,0)) QUES
 .D ^DIR K DIR S DA=SRDA I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 .I +Y S SRJ=0 F  S SRJ=$O(^SRO(136,SRDA,1,SRJ)) Q:'SRJ  I $P(^SRO(136,SRDA,1,SRJ,0),"^")=+Y N DIR D  Q
 ..S SRSEL=Y(0),DIR(0)="136.01,.01AO",DIR("A")="   Modifier: ",DIR("B")=$P(Y(0),"^")
 ..D ^DIR S DA=SRDA I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 ..I +Y S SRK=0 F  S SRK=$O(^SRO(136,SRDA,1,SRK)) Q:'SRK  I $P(^SRO(136,SRDA,1,SRK,0),"^")=+Y S SRQ=1 Q
 ..Q:SRQ  I +Y S $P(^SRO(136,SRDA,1,SRJ,0),"^")=+Y,SRQ=1 Q
 ..I X="@" S SRY(136.01,SRJ_","_SRDA_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20") S SRQ=1
 .Q:SRQ!SRSOUT
 .I +Y S SRY(136.01,"+1,"_DA_",",.01)=+Y D UPDATE^DIE("","SRY") Q
 .I X="@",$D(SRCMOD) S SRY(136.01,SRIEN_","_SRDA_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20")
 Q
OPROC ; enter CPT modifiers for other CPT code
 N SRCODE,SRDA,SRDEF,SRIEN,SRJ,SRQ,SRSDATE,SRSEL,SRSOUT,SRX,SRY,Z S (SRQ,SRSOUT)=0,SRCODE=X N X I $D(SRCMOD) D OHYPH
 S SRDA=DA,SRDA(1)=DA(1),SRIEN=$O(^SRO(136,SRDA(1),3,SRDA,1,"A"),-1) I SRIEN S SRX=$P(^SRO(136,SRDA(1),3,SRDA,1,SRIEN,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRX,"I"),"^",2)
 K DIR F  D  K SRM,SRCMOD Q:SRSOUT  S SRQ=0
 .S DIR("A")=" Modifier: ",DIR(0)="136.31,.01AO" S:$G(SRCMOD)'="" DIR("B")=SRCMOD D:$O(^SRO(136,SRDA(1),3,SRDA,1,0)) QUES1
 .D ^DIR K DIR S DA=SRDA,DA(1)=SRDA(1) I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 .I +Y S SRJ=0 F  S SRJ=$O(^SRO(136,SRDA(1),3,SRDA,1,SRJ)) Q:'SRJ  I $P(^SRO(136,SRDA(1),3,SRDA,1,SRJ,0),"^")=+Y N DIR D  Q
 ..S SRSEL=Y(0),DIR(0)="136.31,.01AO",DIR("A")="   Modifier: ",DIR("B")=$P(Y(0),"^")
 ..D ^DIR S DA=SRDA I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 ..I +Y S SRK=0 F  S SRK=$O(^SRO(136,SRDA(1),3,SRDA,1,SRK)) Q:'SRK  I $P(^SRO(136,SRDA(1),3,SRDA,1,SRK,0),"^")=+Y S Y="" Q
 ..I X="@" S SRY(136.31,SRJ_","_SRDA_","_SRDA(1)_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20") S SRQ=1
 .Q:SRQ!SRSOUT
 .I +Y S SRY(136.31,"+1,"_DA_","_DA(1)_",",.01)=+Y D UPDATE^DIE("","SRY") Q
 .I X="@",$D(SRCMOD) S SRY(136.31,SRIEN_","_SRDA_",",SRDA(1)_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20")
 Q
KOMOD ; delete other CPT modifiers when CPT code is edited
 I $D(SRDIRED) S SRDIRED=1 Q:'$D(DA)
 N SRCODE,SRDA,SRJ,SRY S SRDA=$G(DA),SRDA(1)=$G(DA(1)) Q:'SRDA!'SRDA(1)
 S SRCODE=X,SRJ=0 F  S SRJ=$O(^SRO(136,SRDA(1),3,SRDA,1,SRJ)) Q:'SRJ  D
 .S SRY(136.31,SRJ_","_SRDA_","_SRDA(1)_",",.01)="@" D FILE^DIE("","SRY")
 S X=SRCODE
 Q
PHYPH ; called from input transform to process hyphenated modifier list
 Q:$E($G(IOST),1,2)'="C-"!($G(DIK)'="")
 N SRSDATE,SRDA,SRDUP,SRJ,SRLIST,SRM,SRN,SROK,SRY,SRZ S SRCODE=X D KPMOD S X=SRCODE Q:'$D(SRCMOD)
 S SRLIST=SRCMOD,SRSDATE=DT,SRDA=$S($G(SRTN):SRTN,$D(DA(1)):DA(1),$D(DA):DA,1:"")
 S:SRDA SRSDATE=$P(^SRF(SRDA,0),"^",9)
 F SRN=1:1 S SRCMOD=$P(SRLIST,",",SRN) Q:SRCMOD=""  D
 .S (SRDUP,SROK)=0
 .S SRM=$P($$MOD^ICPTMOD(SRCMOD),"^") K:SRM<0 SRM I $D(SRM) D  K SRM
 ..S SROK=0,SRM=$S($D(SRM):SRM,1:+Y)
 ..S SRZ=$P($$MODP^ICPTMOD(SRCODE,SRM,"I",SRSDATE),"^") I SRZ>0 S SROK=SRZ
 .I 'SROK&($E($G(IOST),1,2)="C-") D EN^DDIOL("CPT Modifier '"_SRCMOD_"' is not acceptable with this CPT code.","","!") K SRCMOD Q
 .S SRJ=0 F  S SRJ=$O(^SRO(136,SRDA,1,SRJ)) Q:'SRJ  I $P(^SRO(136,SRDA,1,SRJ,0),"^")=SROK S SRDUP=1 Q
 .I 'SRDUP S SRY(136.01,"+1,"_DA_",",.01)=SROK D UPDATE^DIE("","SRY")
 S X=SRCODE
 Q
KPMOD ; delete principal CPT modifiers when CPT code is edited
 N SRDA,SRJ,SRY
 S SRDA=DA,SRJ=0 F  S SRJ=$O(^SRO(136,SRDA,1,SRJ)) Q:'SRJ  D
 .S SRY(136.01,SRJ_","_SRDA_",",.01)="@" D FILE^DIE("","SRY")
 Q
OHYPH ; input CPT hyphenated modifier for other procedure
 N SRCODE,SRDA,SRDUP,SRLIST,SRN,SROK,SROTH,SRY S SRLIST=SRCMOD
 F SRN=1:1 S SRCMOD=$P(SRLIST,",",SRN) Q:SRCMOD=""  D
 .S (SRDUP,SROK)=0
 .S SRM=$P($$MOD^ICPTMOD(SRCMOD),"^") K:SRM<0 SRM I $D(SRM) D OCHK K SRM
 .I 'SROK D EN^DDIOL("CPT Modifier '"_SRCMOD_"' is not acceptable with this CPT code.","","!") K SRCMOD Q
 .S SRJ=0 F  S SRJ=$O(^SRO(136,SRDA,3,SROTH,1,SRJ)) Q:'SRJ  I $P(^SRO(136,SRDA,3,SROTH,1,SRJ,0),"^")=SROK S SRDUP=1 Q
 .I 'SRDUP S SRY(136.31,"+1,"_DA_","_DA(1)_",",.01)=SROK D UPDATE^DIE("","SRY")
 Q
QUES N SRI,SRMD,SRX,SRY,SRZ S DIR("?",1)=" Answer with PRIN PROCEDURE CPT MODIFIER",DIR("?",2)="Choose from:"
 S SRI=0,SRCT=3 F  S SRI=$O(^SRO(136,SRDA,1,SRI)) Q:'SRI  S SRMD=$P(^SRO(136,SRDA,1,SRI,0),"^") D
 .S SRX=$$MOD^ICPTMOD(SRMD,"I",$P($G(^SRF(SRDA,0)),"^",9)),SRY=$P(SRX,"^",2),SRZ=$P(SRX,"^",3)
 .S DIR("?",SRCT)="   "_SRY_"   "_SRZ,SRCT=SRCT+1
 S DIR("?",SRCT)="",DIR("?")="     You may enter a new PRIN PROCEDURE CPT MODIFIER, if you wish."
 Q
QUES1 N SRI,SRMD,SRX,SRY,SRZ S DIR("?",1)=" Answer with OTHER PROCEDURE CPT MODIFIER",DIR("?",2)="Choose from:"
 S SRI=0,SRCT=3 F  S SRI=$O(^SRO(136,SRDA(1),3,SRDA,1,SRI)) Q:'SRI  S SRMD=$P(^SRO(136,SRDA(1),3,SRDA,1,SRI,0),"^") D
 .S SRX=$$MOD^ICPTMOD(SRMD,"I",$P($G(^SRF(SRDA,0)),"^",9)),SRY=$P(SRX,"^",2),SRZ=$P(SRX,"^",3)
 .S DIR("?",SRCT)="   "_SRY_"   "_SRZ,SRCT=SRCT+1
 S DIR("?",SRCT)="",DIR("?")="     You may enter a new OTHER PROCEDURE CPT MODIFIER, if you wish."
 Q
  
