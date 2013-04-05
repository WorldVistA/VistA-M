ONCOCFL1 ;Hines OIFO/GWB - [CF Automatic Casefinding-Lab Search] ;10/21/11
 ;;2.11;ONCOLOGY;**25,26,27,28,29,32,33,43,44,46,49,51,53,54,56**;Mar 07, 1995;Build 10
 ;
EN ;Start Date default
 S SDDEF=$P(^ONCO(160.1,OSP,0),U,5)
 I SDDEF="" S SDDEF=DT
 S SDDEF=$E(SDDEF,4,5)_"-"_$E(SDDEF,6,7)_"-"_($E(SDDEF,1,3)+1700)
 ;
SD ;Start Date
 W !
 K DIR
 S DIR(0)="D"
 S DIR("A")="          Start Date"
 S DIR("B")=SDDEF
 D ^DIR
 G EX:(Y="")!(Y[U)
 I (Y>DT) W "  Future dates not allowed" G SD
 S (LRSDT,X)=Y D DD^%DT W "  ",Y
 ;
ED ;End Date
 K DIR
 S DIR(0)="D"
 S DIR("A")="            End Date"
 D ^DIR
 G EX:(Y="")!(Y[U)
 I (Y<LRSDT) W "  Invalid date sequence" G SD
 I (Y>DT) W "  Future dates not allowed" G ED
 S $P(^ONCO(160.1,OSP,0),U,5)=Y
 S (LRLDT,X)=Y D DD^%DT W "  ",Y
 S Y=LRSDT D D^ONCOLRU S LRSTR=Y
 S Y=LRLDT D D^ONCOLRU S LRLST=Y
 W !
 K DIR
 S DIR(0)="Y"
 S DIR("A")="          Dates OK"
 S DIR("B")="Y"
 D ^DIR
 G EX:(Y="")!(Y[U)
 G EN:'Y
 ;Include Squamous and Basal cell neoplasms (Y/N?)
 W !
 S SBCIND="NO"
 K DIR
 S DIR(0)="Y"
 S DIR("A")="          Include Squamous and Basal cell neoplasms"
 S DIR("B")="Yes"
 S DIR("?")=" "
 S DIR("?",1)=" Answer 'YES' if you want to include squamous and basal cell neoplasms."
 S DIR("?",2)=" Answer  'NO' if you want to exclude these neoplasms."
 D ^DIR
 G EX:(Y="")!(Y[U)
 S:Y=1 SBCIND="YES"
 K DIR
 ;
 S ONCO("SD")=LRSDT,ONCO("ED")=LRLDT
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 F X=8,9 F Y=1,2,3,6,9 S Z=X_"***"_Y,LRM(Z)=5,LRN(Z)=Z
 S LRM(69760)=5,LRN(69760)=69760
 S LRM(74000)=5,LRN(74000)=74000
 S LRM(74006)=5,LRN(74006)=74006
 S LRM(74007)=5,LRN(74007)=74007
 S LRM(74008)=5,LRN(74008)=74008
 W !!?10,"This option will search for ICD-O morphology codes 800-998.",!
 W !?10,"It will also search for High Grade Dysplasia of Stomach, Colon"
 W !?10,"and Esophagus cases.",!
 W !?10,"Exceptions to the above search criteria:",!
 W !?10,"Behavior Code /0 (Benign) codes will be excluded."
 W:SBCIND="NO" !?10,"Squamous cell neoplasms (805-808) of the skin will be excluded."
 W:SBCIND="NO" !?10,"Basal cell neoplasms (809) will be excluded."
 W !?10,"Benign tumors of the central nervous system will be included."
 W !
 S %ZIS="Q" D ^%ZIS I POP G EX
 I '$D(IO("Q")) D SER^ONCOCFL1 G EX
 S ZTRTN="SER^ONCOCFL1",ZTSAVE("LR*")="",ZTSAVE("ONCO*")="",ZTSAVE("SBCIND")=""
 S ZTDESC="ONCOLOGY LAB SEARCH"
 D ^%ZTLOAD
 K ZTDESC,ZTRTN,ZTSAVE
 G EX
 ;
SER ;Search LAB DATA (63) file
 ;Supported by IA #525
 S AFFDIV=$G(DUZ(2)),ONCDIVSP=$O(^ONCO(160.1,"C",AFFDIV,""))
 I ONCDIVSP="" W !!,"User does not have an associated DIVISION.",!! G EX
 F Z=0:0 S Z=$O(^ONCO(160.1,ONCDIVSP,6,Z)) Q:Z'>0  S AFFDIV=AFFDIV_U_$G(^ONCO(160.1,ONCDIVSP,6,Z,0))
 K ^TMP($J),^TMP("ONCO",$J)
 D SNOMED
 S ONSDT=LRSDT,ONLDT=LRLDT
 S ^TMP("ONCO",$J,0)=0
 F LRSS="SP","CY","EM","AU" S LRXR="A"_LRSS,LRSDT=ONSDT,LRLDT=ONLDT D LOOP
 S LRDFN=0
 F  S LRDFN=$O(^TMP($J,LRDFN)) G RPT:LRDFN="" S LRSDT=0 F  S LRSDT=$O(^TMP($J,LRDFN,LRSDT)) Q:LRSDT'>0  S LD=^(LRSDT),LRSS=$P(LD,U),LRI=$P(LD,U,6),XDT=$S(LRSS="AU":$P(^LR(LRDFN,LRSS),U),1:$P(^LR(LRDFN,LRSS,LRI,0),U,1)) S XDT=$P(XDT,".",1) D CK
 ;
CK ;Check ONCOLOGY PATIENT (160) file
 D DIV Q:DVMTCH=0
 S XD1=^LR(LRDFN,0) Q:$P(XD1,U,2)'=2  S X=$P(XD1,U,3) Q:'$D(^DPT(X))
 S X=X_";DPT(",XD0=$O(^ONCO(160,"B",X,0)),ONCIEN=XD0
 I XD0="" K DO S D="B",DIC="^ONCO(160,",DIC(0)="Z" D FILE^DICN K DO S ONCIEN=+Y D SET Q
 I XD0'="" S ONCDIVS="",ONCS="" F  S ONCS=$O(^ONCO(160,XD0,"SUS","C",ONCS)) Q:ONCS'>0  S ONCDIVS=ONCDIVS_U_ONCS
 I ONCDIVS[DUZ(2) Q
 G SET:'$D(^ONCO(165.5,"C",ONCIEN)) S XD2=0 F  S XD2=$O(^ONCO(165.5,"C",ONCIEN,XD2)) Q:XD2=""  I $$DIV^ONCFUNC(XD2)=DUZ(2) S XDX=$P($G(^ONCO(165.5,+XD2,0)),U,16) Q:XDT=XDX  I $P($G(^ONCO(165.5,+XD2,1)),U,10)=XDT Q
 Q:XD2'=""  D SET Q
 ;
SET ;Create SUSPENSE (160.075) record
 K DD,DO
 S DA(1)=ONCIEN,DIC="^ONCO(160,"_DA(1)_",""SUS"","
 S DIC(0)="L",DIC("P")=$P(^DD(160,75,0),U,2),X=XDT
 D FILE^DICN K DO
 S ^TMP("ONCO",$J,0)=^TMP("ONCO",$J,0)+1
 K DIE S DA(1)=ONCIEN,DIE="^ONCO(160,"_DA(1)_",""SUS"","
 S (ONCSUB,DA)=+Y,SR="L"_$E(LRSS),$P(^ONCO(160,ONCIEN,0),U,2)=LRDFN
 S ONCMRPH=$E($P(LD,U,4),1,5) S:$E(ONCMRPH,5)=6 $E(ONCMRPH,5)=3 I '$D(^ONCO(164.1,ONCMRPH)) S ONCMRPH=""
 S DR="1///^S X=DT;2///^S X=SR;3////^S X=DUZ(2);4////^S X=$P(LD,U,2);5////^S X=$P(LD,U,3);10////^S X=ONCMRPH;11///^S X=LRI;13////^S X=$P(LD,U,7)"
 D ^DIE
 Q
 ;
LOOP F  S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
 Q
 ;
LRDFN S LRDFN=0 F  S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D @$S(LRSS'="AU":"LRI",1:"AU")
 Q
 ;
LRI S LRI=0 F  S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  D T
 Q
 ;
T S T=0 F  S T=$O(^LR(LRDFN,LRSS,LRI,2,T)) Q:'T  S LRT=+^(T,0),TIS=$P($G(^LAB(61,LRT,0)),U,1),SNOMED=$P($G(^LAB(61,LRT,0)),U,2) D M
 Q
 ;
M S M=0 F  S M=$O(^LR(LRDFN,LRSS,LRI,2,T,2,M)) Q:'M  S X=^(M,0),LRD=+X,LRM=$P(X,U,2) D MX I I Q
 S DZX=0 F  S DZX=$O(^LR(LRDFN,LRSS,LRI,2,T,1,DZX)) Q:'DZX  D
 .S DZPTR=$G(^LR(LRDFN,LRSS,LRI,2,T,1,DZX,0)) I DZPTR="" Q
 .S DZCODE=$P($G(^LAB(61.4,+DZPTR,0)),U,2) I DZCODE="" Q
 .I (DZCODE=4006)!((DZCODE>4078)&(DZCODE<4085)) D
 ..S DZMORP=$S(DZCODE=4006:99833,DZCODE=4079:99803,1:99823)
 ..S ^TMP($J,LRDFN,LRSDT)=LRSS_U_U_LRT_U_DZMORP_U_TIS_U_LRI_U_DZPTR
 Q
 ;
MX Q:'$D(^LAB(61.1,LRD,0))
 S W=^LAB(61.1,LRD,0),X=$P(W,U,2),Y=0 F Z=1:1 S Y=$O(LRN(Y)) Q:Y=""  S Y(1)=LRM(Y),Y(2)=LRN(Y) D Y I I S ^TMP($J,LRDFN,LRSDT)=LRSS_U_LRD_U_LRT_U_X_U_TIS_U_LRI
 Q
 ;
AU ;AUTOPSY
 S LRI=9999999,T=0 F  S T=$O(^LR(LRDFN,"AY",T)) Q:'T  S LRT=+^(T,0),TIS=$P($G(^LAB(61,LRT,0)),U),SNOMED=$P($G(^LAB(61,LRT,0)),U,2) D AUM
 Q
 ;
AUM S M=0 F  S M=$O(^LR(LRDFN,"AY",T,2,M)) Q:'M  S X=^(M,0),LRD=+X,LRM=$P(X,U,2) D MX
 Q
 ;
Y ;Check for eligible cases
 ;Basal cell carcinomas
 I SBCIND="NO",$E(X,1,3)=809 S I=0 Q
 ;Benign brain tumors
 I SNOMED'="",($E(SNOMED,1,2)?1"X"1N)!($D(BBT(SNOMED))),$E(X,1)>7 S I=1 Q
 ;Squamous cell neoplasms of the skin
 I SBCIND="NO",($E(X,1,3)=805)!($E(X,1,3)=806)!($E(X,1,3)=807)!($E(X,1,3)=808),($E(SNOMED,1,2)="01")!($E(SNOMED,1,2)="02") S I=0 Q
 I $E(X,1,5)=Y(2) D  Q 
 .S I=1
 .I (X=74000)!(X=74006)!(X=74007)!(X=74008),($E(SNOMED,1,2)'=62)&($E(SNOMED,1,2)'=63)&($E(SNOMED,1,2)'=67) S I=0
 S I=1 F I(1)=1:1:Y(1) S I(2)=$E(Y(2),I(1)) I I(2)'="*",I(2)'=$E(X,I(1)) S I=0 Q
 Q
 ;
RPT ;Report
 N ONCOST,ONCOEN
 S ONCOST="L",ONCOEN="LS" G RPT^ONCOCFL
 ;
DIV ;Check division
 ;Supported by IA #5343
 S DVMTCH=1,INST=""
 I LRSS="AU" D
 .S LBACC=$P($G(^LR(LRDFN,LRSS)),U,6)
 .S LBYEAR=$P($G(^LR(LRDFN,LRSS)),U,1)
 I LRSS'="AU" D
 .S LBACC=$P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)
 .S LBYEAR=$P($G(^LR(LRDFN,LRSS,LRI,0)),U,1)
 I (LBACC="")!(LBYEAR="") Q
 I LBACC["LEGACY" S DVMTCH=0 Q
 S LBAREA=$P(LBACC," ",1) I LBAREA="" Q
 S LBNUM=$P(LBACC," ",3) I LBNUM="" Q
 S ACCIEN=$O(^LRO(68,"B",LBAREA,"")) I ACCIEN="" Q
 S LBYEAR=$E(LBYEAR,1,3)_"0000"
 S INST=$G(^LRO(68,ACCIEN,1,LBYEAR,1,LBNUM,.4)) I INST="" Q
 I AFFDIV'[INST S DVMTCH=0
 Q
 ;
SNOMED ;Build SNOMED array for benign brain tumors
 S BBT(45000)=""
 S BBT(45010)=""
 S BBT(45020)=""
 S BBT(45030)=""
 S BBT(45100)=""
 S BBT(45110)=""
 S BBT(45120)=""
 S BBT(45300)=""
 S BBT(45300)=""
 S BBT(45301)=""
 S BBT(45302)=""
 S BBT(45303)=""
 S BBT(45304)=""
 S BBT(45305)=""
 S BBT(45520)=""
 S BBT(45521)=""
 S BBT(45522)=""
 S BBT(45523)=""
 S BBT(45524)=""
 S BBT(45525)=""
 Q
 ;
EX ;KILL variables
 D ^%ZISC
 K %ZIS
 K ACCIEN,AFFDIV,BBT,D,DA,DIC,DIE,DIR,DR,DVMTCH,DZCODE,DZMORP,DZPTR,DZX
 K I,INST,LBACC,LBAREA,LBNUM,LBYEAR,LD,LRD,LRDFN,LRI,LRLDT,LRLST,LRM,LRN
 K LRSDT,LRSS,LRSTR,LRT,LRXR,M,ONCDIVS,ONCDIVSP,ONCIEN,ONCMRPH,ONCO,ONCS
 K ONCSUB,ONLDT,ONSDT,OSP,POP,SDDEF,SNOMED,SR,T,TIS,W,X,XD0,XD1,XD2,XDT
 K XDX,Y,Z,SBCIND
 Q
