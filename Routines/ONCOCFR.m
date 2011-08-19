ONCOCFR ;Hines OIFO/GWB - RADIOLOGY CASEFINDING; 7/21/93
 ;;2.11;ONCOLOGY;**13,24,25,26,27,34,37,39,46,50**;Mar 07, 1995;Build 29
 ;
ST ;Start RAD/NUC MED PATIENT (70) file search
 W @IOF
 W !!!?10,"******** RADIOLOGY: SUSPICIOUS MALIGNANCY SEARCH ********",!!
 W ?10,"This option searches the RAD/NUC MED PATIENT file and will",!
 W ?10,"add to your 'suspense list' in the ONCOLOGY PATIENT file.",!
MG S MG=0,D0=0 F  S D0=$O(^RA(78.3,"B",D0)) Q:D0=""  S XX=$TR(D0,"malig","MALIG") I XX["MALIG" S MG=$O(^(D0,0)) Q
 G T:MG W !!?15,"MALIGNACY diagnostic code is not defined in the"
 W !?15,"Radiology Diagnostic Codes File (#78.3). Please"
 W !?15,"REQUEST Radiology to code suspicious MALIGNANCIES"
 W !!!?10,"MUST terminate Radiology Search - no meaningful search code" G EX
 ;
T ;Start Date/End Date
 S OSP=$O(^ONCO(160.1,"C",DUZ(2),0))
 K DIR
 S Y=$P(^ONCO(160.1,OSP,0),U,6)
 I Y="" S Y=DT
 S Y=$E(Y,4,5)_"-"_$E(Y,6,7)_"-"_($E(Y,1,3)+1700)
 S DIR("B")=Y
 W !
 S DIR("A")="          Start Date",DIR(0)="D" D ^DIR
 G EX:Y<1!(Y[U)
 S (SD,X)=Y D DD^%DT W "  ",Y S WSD=Y
 K DIR
 S DIR("A")="            End Date",DIR(0)="D" D ^DIR
 G EX:Y=""!(Y[U)
 I Y<SD!(Y>DT) W *7,?40,"Invalid date sequence!!",! G T
 S $P(^ONCO(160.1,OSP,0),U,6)=Y
 S (ED,X)=Y D DD^%DT W "  ",Y,!
 S WED=Y
 S DIR("A")="          Dates OK",DIR("B")="Y",DIR(0)="Y" D ^DIR
 G T:'Y,EX:Y[U!(Y="")
 W !!?15,"We will find suspicious malignancies"
 W !?15,"From: ",WSD_" To: "_WED,!
 W ! S ONCO("SD")=SD,ONCO("ED")=ED,ONCO("MG")=MG
 ;
TSK ;Create task
 K IO("Q") S %ZIS="Q" D ^%ZIS I POP S ONCOUT="" G EX
 I '$D(IO("Q")) D SER^ONCOCFR G EX
 S ZTRTN="SER^ONCOCFR",ZTSAVE("ONCO*")="",ZTDESC="ONCOLOGY RADIOLOGY SEARCH" D ^%ZTLOAD G EX
 ;
SER ;Search RAD/NUC MED PATIENT (70) file/Set multidivisional variables
 S AFFDIV=$G(DUZ(2)),ONCDIVSP=$O(^ONCO(160.1,"C",AFFDIV,""))
 I ONCDIVSP="" W !!,"User does not have an associated DIVISION!",!! G EX
 F Z=0:0 S Z=$O(^ONCO(160.1,ONCDIVSP,6,Z)) Q:Z'>0  S AFFDIV=AFFDIV_U_$G(^ONCO(160.1,ONCDIVSP,6,Z,0))
 K ^TMP("ONCO",$J) S (XSD,XDT)=ONCO("SD")-.1111111,XED=ONCO("ED")+.9999999,MG=ONCO("MG") F J=0,1,2 S ^TMP("ONCO",$J,J)=0
 F  S XDT=$O(^RADPT("AR",XDT)) Q:XDT=""!(XDT>XED)  S D0=0 F  S D0=$O(^RADPT("AR",XDT,D0)) Q:D0'>0  S D1=$O(^RADPT("AR",XDT,D0,0)) D
 .S D2=0 F  S D2=$O(^RADPT(D0,"DT",D1,"P",D2)) Q:D2'>0  D
 ..S RA0=$G(^(D2,0)) I RA0="" Q
 ..S PC13=$P(RA0,U,13) I PC13="" Q
 ..S EXP=$$GET1^DIQ(78.3,PC13,6),EXP=$TR(EXP,"malig","MALIG"),EXP=$TR(EXP,"Suspicious","SUSPICIOUS")
 ..S MG=$P($G(^RA(78.3,PC13,0)),U,1),MG=$TR(MG,"malig","MALIG")
 ..I (MG["MALIG")!(EXP["MALIG")!(EXP["SUSPICIOUS") S RA($P(^RADPT(D0,0),U))=$P(XDT,".")_U_$P(RA0,U,2)_U_D1
 ..S D3=0 F  S D3=$O(^RADPT(D0,"DT",D1,"P",D2,"DX",D3)) Q:D3'>0  D
 ...S RASDC0=$G(^(D3,0)) I RASDC0="" Q
 ...S PC1=$P(RASDC0,U,1) I PC1="" Q
 ...S EXP=$$GET1^DIQ(78.3,PC1,6),EXP=$TR(EXP,"malig","MALIG"),EXP=$TR(EXP,"Suspicious","SUSPICIOUS")
 ...S MG=$P($G(^RA(78.3,PC1,0)),U,1),MG=$TR(MG,"malig","MALIG")
 ...I (MG["MALIG")!(EXP["MALIG")!(EXP["SUSPICIOUS") S RA($P(^RADPT(D0,0),U))=$P(XDT,".")_U_$P(RA0,U,2)_U_D1
 ;
CK ;Check ONCOLOGY PATIENT (160) file
GT S XX=0 F  S XX=$O(RA(XX)) Q:XX=""  D
 .D DIV Q:DVMTCH=0
 .S ^TMP("ONCO",$J,0)=^TMP("ONCO",$J,0)+1
 .S HT=0,X=XX_";DPT("
 .S XDT=$P(RA(XX),U),XD0=$O(^ONCO(160,"B",X,0)),ONCIEN=XD0
 .I XD0="" D MR Q
 .I XD0'="" S ONCDIVS="",ONCS="" F  S ONCS=$O(^ONCO(160,XD0,"SUS","C",ONCS)) Q:ONCS'>0  S ONCDIVS=ONCDIVS_U_ONCS
 .I ONCDIVS'[DUZ(2) D
 ..S (D0,DA)=XD0 I '$D(^ONCO(165.5,"C",XD0)) D N2 Q
 ..I $D(^ONCO(165.5,"C",XD0)) D CKP I 'HT D N2 Q
 .Q
 ;
RPT ; Generate report
 I $G(^TMP("ONCO",$J,2))=0 S DIC="^ONCO(160.1,",BY="[ONCO NEG-REPORT]"
 E  D
 .S DIC="^ONCO(160,"
 .S BY="@75,INTERNAL(#3),75,.01"
 .S FR=DUZ(2)_","_ONCO("SD"),TO=DUZ(2)_","_ONCO("ED")
 .S FLDS="[ONCO RAD-CASEFINDING RPT]"
 .Q
 ;
PRT ; Call print routine
 S L=0,IOP=ION,DIOEND="D WP^ONCOCFR"
 D EN1^DIP G EX
 ;
WP ; Wrap-up report
 W !!!?30,"RADIOLOGY CASEFINDING RESULTS"
 W !!?30,^TMP("ONCO",$J,0)_" Cases found",!?30,^TMP("ONCO",$J,1)_" New Patients added",!?30,^TMP("ONCO",$J,2)_" New cases added",!!
 Q
 ;
CKP ;CHECK Primary File
 S XD1=0 F  S XD1=$O(^ONCO(165.5,"C",XD0,XD1)) Q:XD1'>0  I $$DIV^ONCFUNC(XD1)=DUZ(2) D
 .S XDX=$P($G(^ONCO(165.5,XD1,0)),U,16) I XDX=XDT S HT=1 Q
 .S XDX=$P($G(^ONCO(165.5,XD1,1)),U,10) I XDX=XDT S HT=1 Q
 .Q
 Q
 ;
MR ;Create new ONCOLOGY PATIENT (160) record
 S DIC="^ONCO(160,",DIC(0)="Z" D FILE^DICN S (ONCIEN,D0,DA)=+Y,^TMP("ONCO",$J,1)=^TMP("ONCO",$J,1)+1
N2 ;Create new SUSPENSE (160,75) record
 K DD,DO
 S DA(1)=ONCIEN,DIC="^ONCO(160,"_DA(1)_",""SUS"","
 S DIC(0)="L",DIC("P")=$P(^DD(160,75,0),U,2),X=XDT
 D FILE^DICN
 K DIE S DA(1)=ONCIEN,DIE="^ONCO(160,"_DA(1)_",""SUS"","
 S (ONCSUB,DA)=+Y,RDP=$P(RA(XX),U,2)
 S DR="1///^S X=DT;2///^S X=""RA"";3////^S X=DUZ(2);6////^S X=RDP" D ^DIE
 S ^TMP("ONCO",$J,2)=^TMP("ONCO",$J,2)+1
 Q
 ;
DIV ;Division match
 S DVMTCH=1,INST="",RE1=$P(RA(XX),U,3) I RE1="" Q
 S INST=$P($G(^RADPT(XX,"DT",RE1,0)),U,3) I INST="" Q
 I AFFDIV'[INST S DVMTCH=0 Q
 Q
 ;
EX ;EXIT
 K %ZIS,AFFDIV,BY,D0,D1,D2,D3,DA,DIC,DIOEND,DR,DVMTCH,ED,EXP,FLDS,FR,HT
 K INST,IOP,J,L,MG,ONCDIVS,ONCDIVSP,ONCIEN,ONCO,ONCOUT,ONCS,ONCSUB,OSP
 K PC1,PC13,POP,RA,RA0,RASDC0,RDP,RE1,SD,TO,WED,WSD,X,XD0,XD1,XDT,XDX
 K XED,XSD,XX,Y,Z,ZTDESC,ZTRTN,ZTSAVE,ONCDIVSP
 K ^TMP("ONCO",$J)
 D ^%ZISC
 Q
