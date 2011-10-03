SROMOD ;BIR/ADM - CPT Modifier Input ; [ 02/27/01  6:32 AM ]
 ;;3.0; Surgery ;**88,100,127,165**;24 Jun 93;Build 6
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
 N SRSDATE S SRSDATE=DT K ICPTVDT
 S SROK=0,SRCODE="",SRDA=$S($G(SRTN):SRTN,$D(DA(1)):DA(1),$D(DA):DA,1:""),SRM=$S($D(SRM):SRM,1:+Y)
 I SRDA S SRSDATE=$P(^SRF(SRDA,0),"^",9),SRCODE=$P($G(^SRF(SRDA,"OP")),"^",2)
 ;;Begin *165 - RJS
 I 'SRCODE!(X=51) Q
 ;; End *165 - RJS
 S SRZ=$P($$MODP^ICPTMOD(SRCODE,SRM,"I",SRSDATE),"^") I SRZ>0 S SROK=SRZ
 S ICPTVDT=SRSDATE
 Q
OTH() ; screen for acceptable CPT code/modifier pair for other procedure
 N SRCODE,SRDA,SRCMOD,SROK,SROTH,SRSDATE,SRZ D OCHK K SRM
 Q SROK
OCHK ; return value of modifier if acceptable for other procedure
 N SRSDATE S SRSDATE=DT K ICPTVDT
 S SROK=0,SRCODE="",SRDA=$S($G(SRTN):SRTN,$D(DA(2)):DA(2),$D(DA(1)):DA(1),$D(D0):D0,1:""),SROTH=$S($D(DA):DA,$D(D1):D1,1:""),SRM=$S($D(SRM):SRM,1:+Y)
 I SRDA&SROTH S SRSDATE=$P(^SRF(SRDA,0),"^",9),SRCODE=$P($G(^SRF(SRDA,13,SROTH,2)),"^")
 I 'SRCODE Q
 S SRZ=$P($$MODP^ICPTMOD(SRCODE,SRM,"I",SRSDATE),"^") I SRZ>0 S SROK=SRZ
 S ICPTVDT=SRSDATE
 Q
SPRIN ; set logic for ACPT x-ref
 Q:$E($G(IOST))'="C"!($G(DIK)'="")
 N SRCODE,SRDA,SRDEF,SRIEN,SRJ,SRQ,SRSDATE,SRSEL,SRSOUT,SRX,SRY,Z S (SRQ,SRSOUT)=0,SRCODE=X N X I $D(SRCMOD) D HYPH27
 S SRDA=DA,SRIEN=$O(^SRF(SRDA,"OPMOD","AAA"),-1) I SRIEN S SRX=$P(^SRF(SRDA,"OPMOD",SRIEN,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRX,"I"),"^",2)
 K DIR F  D  K SRM,SRCMOD Q:SRSOUT  S SRQ=0
 .S DIR("A")=" Modifier: ",DIR(0)="130.028,.01AO" S:$G(SRCMOD)'="" DIR("B")=SRCMOD D:$O(^SRF(SRDA,"OPMOD",0)) QUES
 .D ^DIR K DIR S DA=SRDA I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 .I +Y S SRJ=0 F  S SRJ=$O(^SRF(SRDA,"OPMOD",SRJ)) Q:'SRJ  I $P(^SRF(SRDA,"OPMOD",SRJ,0),"^")=+Y N DIR D  Q
 ..S SRSEL=Y(0),DIR(0)="130.028,.01AO",DIR("A")="   Modifier: ",DIR("B")=$P(Y(0),"^")
 ..D ^DIR S DA=SRDA I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 ..I +Y S SRK=0 F  S SRK=$O(^SRF(SRDA,"OPMOD",SRK)) Q:'SRK  I $P(^SRF(SRDA,"OPMOD",SRK,0),"^")=+Y S SRQ=1 Q
 ..Q:SRQ  I +Y S $P(^SRF(SRDA,"OPMOD",SRJ,0),"^")=+Y,SRQ=1 Q
 ..I X="@" S SRY(130.028,SRJ_","_SRDA_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20") S SRQ=1
 .Q:SRQ!SRSOUT
 .I +Y S SRY(130.028,"+1,"_DA_",",.01)=+Y D UPDATE^DIE("","SRY") Q
 .I X="@",$D(SRCMOD) S SRY(130.028,SRIEN_","_SRDA_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20")
 Q
KPRIN ; kill logic for ACPT x-ref
 Q:$E($G(IOST))'="C"!($G(DIK)'="")  K ^SRF(DA,"OPMOD")
 Q
SOTH ; set logic for ACPT1 x-ref
 Q:$E($G(IOST))'="C"!($G(DIK)'="")
 N SRCODE,SRDA,SRDEF,SRIEN,SRJ,SRQ,SRSDATE,SRSEL,SRSOUT,SRX,SRY,Z S (SRQ,SRSOUT)=0,SRCODE=X N X I $D(SRCMOD) D HYPHOTH
 S SRDA=DA,SRDA(1)=DA(1),SRIEN=$O(^SRF(SRDA(1),13,SRDA,"MOD","A"),-1) I SRIEN S SRX=$P(^SRF(SRDA(1),13,SRDA,"MOD",SRIEN,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRX,"I"),"^",2)
 K DIR F  D  K SRM,SRCMOD Q:SRSOUT  S SRQ=0
 .S DIR("A")=" Modifier: ",DIR(0)="130.164,.01AO" S:$G(SRCMOD)'="" DIR("B")=SRCMOD D:$O(^SRF(SRDA(1),13,SRDA,"MOD",0)) QUES1
 .D ^DIR K DIR S DA=SRDA,DA(1)=SRDA(1) I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 .I +Y S SRJ=0 F  S SRJ=$O(^SRF(SRDA(1),13,SRDA,"MOD",SRJ)) Q:'SRJ  I $P(^SRF(SRDA(1),13,SRDA,"MOD",SRJ,0),"^")=+Y N DIR D  Q
 ..S SRSEL=Y(0),DIR(0)="130.164,.01AO",DIR("A")="   Modifier: ",DIR("B")=$P(Y(0),"^")
 ..D ^DIR S DA=SRDA I $D(DTOUT)!$D(DUOUT)!(X="") S SRSOUT=1 Q
 ..I +Y S SRK=0 F  S SRK=$O(^SRF(SRDA(1),13,SRDA,"MOD",SRK)) Q:'SRK  I $P(^SRF(SRDA(1),13,SRDA,"MOD",SRK,0),"^")=+Y S Y="" Q
 ..I X="@" S SRY(130.164,SRJ_","_SRDA_","_SRDA(1)_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20") S SRQ=1
 .Q:SRQ!SRSOUT
 .I +Y S SRY(130.164,"+1,"_DA_","_DA(1)_",",.01)=+Y D UPDATE^DIE("","SRY") Q
 .I X="@",$D(SRCMOD) S SRY(130.164,SRIEN_","_SRDA_",",SRDA(1)_",",.01)="@" D FILE^DIE("","SRY"),EN^DDIOL(" ... Modifier deleted","","?20")
 Q
KOTH ; kill logic for ACPT1 x-ref
 Q:$E($G(IOST))'="C"!($G(DIK)'="")  K ^SRF(DA(1),13,DA,"MOD")
 Q
HYPH27 ; input CPT hyphenated modifier for principal procedure
 N SRCODE,SRDA,SRDUP,SRLIST,SRN,SROK,SRY S SRLIST=SRCMOD
 F SRN=1:1 S SRCMOD=$P(SRLIST,",",SRN) Q:SRCMOD=""  D
 .S (SRDUP,SROK)=0
 .S SRM=$P($$MOD^ICPTMOD(SRCMOD),"^") K:SRM<0 SRM I $D(SRM) D PCHK K SRM
 .I 'SROK D EN^DDIOL("CPT Modifier '"_SRCMOD_"' is not acceptable with this CPT code.","","!") K SRCMOD Q
 .S SRJ=0 F  S SRJ=$O(^SRF(SRDA,"OPMOD",SRJ)) Q:'SRJ  I $P(^SRF(SRDA,"OPMOD",SRJ,0),"^")=SROK S SRDUP=1 Q
 .I 'SRDUP S SRY(130.028,"+1,"_DA_",",.01)=SROK D UPDATE^DIE("","SRY")
 Q
HYPHOTH ; input CPT hyphenated modifier for other procedure
 N SRCODE,SRDA,SRDUP,SRLIST,SRN,SROK,SROTH,SRY S SRLIST=SRCMOD
 F SRN=1:1 S SRCMOD=$P(SRLIST,",",SRN) Q:SRCMOD=""  D
 .S (SRDUP,SROK)=0
 .S SRM=$P($$MOD^ICPTMOD(SRCMOD),"^") K:SRM<0 SRM I $D(SRM) D OCHK K SRM
 .I 'SROK D EN^DDIOL("CPT Modifier '"_SRCMOD_"' is not acceptable with this CPT code.","","!") K SRCMOD Q
 .S SRJ=0 F  S SRJ=$O(^SRF(SRDA,13,SROTH,"MOD",SRJ)) Q:'SRJ  I $P(^SRF(SRDA,13,SROTH,"MOD",SRJ,0),"^")=SROK S SRDUP=1 Q
 .I 'SRDUP S SRY(130.164,"+1,"_DA_","_DA(1)_",",.01)=SROK D UPDATE^DIE("","SRY")
 Q
QUES N SRI,SRMD,SRX,SRY,SRZ S DIR("?",1)=" Answer with PRIN. PROCEDURE CPT MODIFIER",DIR("?",2)="Choose from:"
 S SRI=0,SRCT=3 F  S SRI=$O(^SRF(SRDA,"OPMOD",SRI)) Q:'SRI  S SRMD=$P(^SRF(SRDA,"OPMOD",SRI,0),"^") D
 .S SRX=$$MOD^ICPTMOD(SRMD,"I",$P($G(^SRF(SRDA,0)),"^",9)),SRY=$P(SRX,"^",2),SRZ=$P(SRX,"^",3)
 .S DIR("?",SRCT)="   "_SRY_"   "_SRZ,SRCT=SRCT+1
 S DIR("?",SRCT)="",DIR("?")="     You may enter a new PRIN. PROCEDURE CPT MODIFIER, if you wish."
 Q
QUES1 N SRI,SRMD,SRX,SRY,SRZ S DIR("?",1)=" Answer with OTHER PROCEDURE CPT MODIFIER",DIR("?",2)="Choose from:"
 S SRI=0,SRCT=3 F  S SRI=$O(^SRF(SRDA(1),13,SRDA,"MOD",SRI)) Q:'SRI  S SRMD=$P(^SRF(SRDA(1),13,SRDA,"MOD",SRI,0),"^") D
 .S SRX=$$MOD^ICPTMOD(SRMD,"I",$P($G(^SRF(SRDA,0)),"^",9)),SRY=$P(SRX,"^",2),SRZ=$P(SRX,"^",3)
 .S DIR("?",SRCT)="   "_SRY_"   "_SRZ,SRCT=SRCT+1
 S DIR("?",SRCT)="",DIR("?")="     You may enter a new OTHER PROCEDURE CPT MODIFIER, if you wish."
 Q
  
