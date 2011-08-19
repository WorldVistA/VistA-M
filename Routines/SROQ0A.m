SROQ0A ;BIR/ADM - QUARTERLY REPORT (CONTINUED) ;06/16/04  9:38 AM
 ;;3.0; Surgery ;**37,38,62,70,88,103,129,142**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ;
 S SRFLAG=1 D NDEX
SUP ; look at resident supervision
 S SRATT=$P($G(^SRF(SRTN,.1)),"^",10) I SRATT="" D RS
 S:'$D(SRATT(SRATT)) (SRATT(SRATT),SRATT("J",SRATT),SRATT("N",SRATT))=0
 S SRATT(SRATT)=SRATT(SRATT)+1,SRMATCH=0,SRMM=$S(SRMM="J":"J",1:"N"),SRATT(SRMM,SRATT)=SRATT(SRMM,SRATT)+1
IDP ; invasive diagnostic?
 D IDP^SROQIDP I SRIDP S SRINV(SRIOSTAT)=SRINV(SRIOSTAT)+1
 I SRIOSTAT="O",SRPOC D ADM
 Q
NDEX ; look at procedures performed
 S SROP="",X=$P($G(^SRO(136,SRTN,0)),"^",2) S:X SROP=$P($$CPT^ICPTCOD(X),"^",2)_";"
 S Y=0 F  S Y=$O(^SRO(136,SRTN,3,Y)) Q:'Y  I Y S X=$P($G(^SRO(136,SRTN,3,Y,0)),"^") I X S SROP=SROP_$P($$CPT^ICPTCOD(X),"^",2)_";" I $L(SROP)>239 Q
CHECK Q:SROP=""  F J=1:1:12 S SRMATCH=0,SRCODES=$P($T(PROC+J),";;",3) F K=1:1 Q:SRMATCH  S SRCPT=$P(SRCODES,",",K) Q:'SRCPT  I SROP[SRCPT S SRMATCH=1 D:SRFLAG ADD D:'SRFLAG IXDTH Q
 Q
RS ; surgical residents used?
 N SRK,SRDIV,SRSITE S SRK=0,SRDIV=$P($G(^SRF(SRTN,8)),"^") I SRDIV S SRSITE=$O(^SRO(133,"B",SRDIV,0)),Y=$P(^SRO(133,SRSITE,0),"^",19) I Y=0 D  Q
 .I $P(^SRF(SRTN,0),"^",9)<3040401 S SRATT=1 Q
 .S SRATT=9 Q
 S SRATT=99
 Q
ADM ; check for admission within 14 days of surgery
 S (SRSDATE,X1)=$P($G(^SRF(SRTN,.2)),"^",12),X2=14 D C^%DTC S SR14=X
 S SRSDATE=$O(^DGPM("APTT1",DFN,SRSDATE)) I SRSDATE,SRSDATE'>SR14 S SRADMT=SRADMT+1
 Q
ADD ; increment counters in ^TMP
 F I=1,2 S SRP(I)=$P(^TMP("SRPROC",$J,J),"^",I)
 S SRP(1)=SRP(1)+1 S:SRPOC!($O(^SRF(SRTN,10,0))) SRP(2)=SRP(2)+1
 S ^TMP("SRPROC",$J,J)=SRP(1)_"^"_SRP(2) K SRP
 Q
IXDTH S ^TMP("SRDEATH",$J,DFN)=SRTN_"^"_J I SRREL="R" S ^TMP("SRP",$J,DFN,(9999999-$P(^SRF(SRTN,0),"^",9)))=J
 Q
IXOUT ; get procedure name for output
 S SROP=$P($T(PROC+J),";;",2)
 Q
SHOW ; display list of procedures with CPT codes
 F I=1:1:12 S X=$T(PROC+I),SRPROC=$P(X,";;",2),SRCODES=$P(X,";;",3) D
 .I SRPROC["," W:I=7 !,?4,$P(SRPROC,",") S SRPROC=$P(SRPROC,",",2)
 .W !,?4,SRPROC,?30,$E(SRCODES,1,48) I $L(SRCODES)>48 W !,?30,$E(SRCODES,49,96)
 Q
TMP ; store index procedure names in ^TMP
 F J=1:1:12 S ^TMP("SRIP",$J,J)=$P($T(PROC+J),";;",2)
 Q
DRPT ; from report of deaths within 30 days
 S SROP="",X=$P($G(^SRO(136,SRTN,0)),"^",2) S:X SROP=$P($$CPT^ICPTCOD(X),"^",2)_";"
 S Y=0 F  S Y=$O(^SRO(136,SRTN,3,Y)) Q:'Y  I Y S X=$P($G(^SRO(136,SRTN,3,Y,0)),"^") I X S SROP=SROP_$P($$CPT^ICPTCOD(X),"^",2)_";" I $L(SROP)>239 Q
CK1 Q:SROP=""  F J=1:1:12 S SRMATCH=0,SRCODES=$P($T(PROC+J),";;",3) F K=1:1 Q:SRMATCH  S SRCPT=$P(SRCODES,",",K) Q:'SRCPT  I SROP[SRCPT D  Q
 .S SRMATCH=1,^TMP("SRDEATH",$J,DFN)=J,^TMP("SRNAT",$J,DFN,J)=SRTN
 .S:SRREL="R" ^TMP("SRREL",$J,DFN,(9999999-SRSD),SRTN)=J
 Q
PROC ; index procedures
P1 ;;Inguinal Hernia;;49505,49507,49520,49521,49525;;
P2 ;;Cholecystectomy;;47600,47605,47610,47562,47563,47564;;
P3 ;;Coronary Artery Bypass;;33510,33511,33512,33513,33514,33516,33517,33518,33519,33521,33522,33523,33533,33534,33535,33536;;
P4 ;;Colon Resection (L & R);;44140,44141,44143,44144,44145,44146,44147,44160;;
P5 ;;Fem-Pop Bypass;;35656,35556;;
P6 ;;Pulmonary Lobectomy;;32480,32500,32440;;
P7 ;;Hip Replacement,  - Elective;;27125,27130,27132,27134,27137,27138;;
P8 ;;Hip Replacement,  - Acute Fracture;;27236;;
P9 ;;TURP;;52601;;
P10 ;;Laryngectomy;;31360,31365,31367,31368;;
P11 ;;Craniotomy;;61304,61305,61312,61314,61510,61512,61518,61519,61700,61680;;
P12 ;;Intraoccular Lens;;66983,66984;;
