PSSDEE ;BIR/WRT - MASTER DRUG ENTER/EDIT ROUTINE ;Nov 27, 2018@10:03
 ;;1.0;PHARMACY DATA MANAGEMENT;**3,5,15,16,20,22,28,32,34,33,38,57,47,68,61,82,90,110,155,156,180,193,200,207,195,227,220,214**;9/30/97;Build 43
 ;
 ;Reference to ^PS(59 supported by DBIA #1976
 ;Reference to REACT1^PSNOUT supported by DBIA #2080
 ;Reference to $$UP^XLFSTR(X) supported by DBIA #10104
 ;Reference to $$PSJDF^PSNAPIS(P1,P3) supported by DBIA #2531
 ;Reference to PSNAPIS supported by DBIA #2531
 ;Reference to ^XMB("NETNAME" supported by DBIA #1131
 ;Reference to ^XUSEC supported by DIBA #10076
 ;Reference to FDR & FDT^PSNACT supported by DBIA #6754
 ;
BEGIN N PSSUPRAF,PSSTDRUG
 S PSSFLAG=0 D ^PSSDEE2 S PSSZ=1 F PSSXX=1:1 K DA D ASK Q:PSSFLAG
DONE D ^PSSDEE2 K PSSFLAGK,PSSXX,DIE,DIR,CLFLAG,CLFALG,DISPDRG,DLAYGO,DR,ENTRY,FLAG,FLG1,FLG2,FLG4,FLG5,FLG6,FLG7,FLGKY,FLGMTH,FLGNDF,FLGOI,K,NEWDF
 K NFLAG,NWND,NWPC1,NWPC2,NWPC3OLDDF,PSIUDA,PSIUX,PSNP,PSSANS,PSSASK,PSSDA,PSSDD,PSSFLAG,PSSOR,PSSZ,PSXBT,PSXF,PSXFL,PSXUM,PSXGOOD,PSXLOC,ZAPFLG
 Q
ASK ;
 W ! S DIC="^PSDRUG(",DIC(0)="QEALMNTV",DLAYGO=50,DIC("T")="",DIC("W")="S PSSTDRUG=Y D GETTIER^PSSDEE(PSSTDRUG)" D ^DIC K DIC I Y<0 S PSSFLAG=1 Q
 N PSINACT S (FLG1,FLG2,FLG3,FLG4,FLG5,FLG6,FLG7,FLAG,FLGKY,FLGOI,PSINACT)=0 K ^TMP($J,"ADD"),^TMP($J,"SOL")
 S DA=+Y,DISPDRG=DA L +^PSDRUG(DISPDRG):0 I '$T W !,$C(7),"Another person is editing this one." Q
 D BEFORE^PSSDEEA($T(+0))  ; drug enter/edit auditing
 I $G(^PSDRUG(DA,"I")) S PSINACT=$G(^PSDRUG(DA,"I")) I PSINACT,PSINACT<DT S PSINACT=1  ;;<<*180 - RJS
 S PSSHUIDG=1,PSSNEW=$P(Y,"^",3) D USE,NOPE,COMMON,DEA,MF K PSSHUIDG,PSSUPRAF
 ; if any outpatient site has a dispense machine running HL7 V.2.4, then
 ; run the new routine and create message
 N XX,DNSNAM,DNSPORT,DVER,DMFU,PSSUPRA S XX=""
 F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D
 .S DVER=$$GET1^DIQ(59,XX_",",105,"I"),DMFU=$$GET1^DIQ(59,XX_",",105.2)
 .S DNSNAM=$$GET1^DIQ(59,XX_",",2006),DNSPORT=$$GET1^DIQ(59,XX_",",2007)
 .D:DVER="2.4"&(DNSNAM'="")&(DMFU="YES") DRG^PSSDGUPD(DISPDRG,PSSNEW,DNSNAM,DNSPORT)
 D DRG^PSSHUIDG(DISPDRG,PSSNEW) L -^PSDRUG(DISPDRG)
 D AFTER^PSSDEEA($T(+0))  ; drug enter/edit auditing
 S XX=$P($G(^PSDRUG(DISPDRG,2)),"^",3) I XX["U"!(XX["I") D  S XX=""
 .S XX=$$SNDHL7^PSSMSTR() D:XX
 ..Q:PSSNEW&'((XX=2)!(XX=3))  ;U=1,N=2,B=3
 ..Q:'PSSNEW&(XX=2)  ;U=1,N=2,B=3
 ..N VAR
 ..I PSSNEW&((XX=2)!(XX=3)) S VAR="Would you like to send this new drug to PADE"
 ..E  S VAR="Would you like to send a drug file update to PADE"
 ..W !!,"This drug is marked for either UD or IV use, and you have at least"
 ..W !,"one active Pharmacy Automated Dispensing Equipment (PADE)."
 ..K DIR,DIRUT,DUOUT,DTOUT
 ..S DIR(0)="Y",DIR("A")=VAR
 ..S DIR("?")="Enter Y for Yes or N for No." D ^DIR K DIR
 ..Q:'Y
 ..N PSSPADE S PSSPADE=1 S XX=""
 ..D ENP^PSSHLDFS(DISPDRG,$S(PSSNEW:"MAD",1:"MUP"))
 D EPHARM^PSSBPSUT(DISPDRG)
 K FLG3,PSSNEW
 Q
 ;
COMMON ;
 S DIE="^PSDRUG(",DR="[PSSCOMMON]"
 D ^DIE
 I $D(Y)!($D(DTOUT)) Q
 I '$D(^PSDRUG(DA,660)) S $P(^PSDRUG(DA,660),"^",6)=""
 I '$D(Y) W !,"PRICE PER DISPENSE UNIT: ",$P(^PSDRUG(DA,660),"^",6)
 D DEA,CK,ASKND,OIKILL^PSSDEE1,COMMON1
 Q
 ;
COMMON1 W !,"Just a reminder...you are editing ",$P(^PSDRUG(DISPDRG,0),"^"),"."
 S (PSSVVDA,DA)=DISPDRG D DOSN^PSSDOS S DA=PSSVVDA K PSSVVDA D USE,APP,ORDITM^PSSDEE1
 Q
CK D DSPY^PSSDEE1 S FLGNDF=0
 Q
ASKND S %=-1 I $D(^XUSEC("PSNMGR",DUZ)) D MESSAGE^PSSDEE1 W !!,"Do you wish to match/rematch to NATIONAL DRUG file" S %=1 S:FLGMTH=1 %=2 D YN^DICN
 I %=0 W !,"If you answer ""yes"", you will attempt to match to NDF." G ASKND
 S PSSUPRAF=%
 I %=2 K X,Y Q
 I %<0 K X,Y Q
 I %=1 D  ;;<<*180 - RJS
 .D RSET^PSSDEE1
 .I 'PSINACT D EN1^PSSUTIL(DISPDRG,1)
 .S X="PSNOUT" X ^%ZOSF("TEST") I  D REACT1^PSNOUT S DA=DISPDRG I $D(^PSDRUG(DA,"ND")),$P(^PSDRUG(DA,"ND"),"^",2)]"" D ONE
 Q  ;;<< *180 - RJS
ONE S PSNP=$G(^PSDRUG(DA,"I")) I PSNP,PSNP<DT Q
 W !,"You have just VERIFIED this match and MERGED the entry." D CKDF D EN2^PSSUTIL(DISPDRG,1) S:'$D(OLDDF) OLDDF="" I OLDDF'=NEWDF S FLGNDF=1 D WR
 Q
CKDF S NWND=^PSDRUG(DA,"ND"),NWPC1=$P(NWND,"^",1),NWPC3=$P(NWND,"^",3),DA=NWPC1,K=NWPC3 S X=$$PSJDF^PSNAPIS(DA,K) S NEWDF=$P(X,"^",2),DA=DISPDRG
 N PSSK D PKIND^PSSDDUT2
 Q
NOPE S ZAPFLG=0 I '$D(^PSDRUG(DA,"ND")),$D(^PSDRUG(DA,2)),$P(^PSDRUG(DA,2),"^",1)']"" D DFNULL
 I '$D(^PSDRUG(DA,"ND")),'$D(^PSDRUG(DA,2)) D DFNULL
 I $D(^PSDRUG(DA,"ND")),$P(^PSDRUG(DA,"ND"),"^",2)']"",$D(^PSDRUG(DA,2)),$P(^PSDRUG(DA,2),"^",1)']"" D DFNULL
 Q
DFNULL S OLDDF="",ZAPFLG=1
 Q
ZAPIT I $D(ZAPFLG),ZAPFLG=1,FLGNDF=1,OLDDF'=NEWDF D CKIV^PSSDEE1
 Q
APP W !!,"MARK THIS DRUG AND EDIT IT FOR: " D CHOOSE
 Q
CHOOSE I $D(^XUSEC("PSORPH",DUZ))!($D(^XUSEC("PSXCMOPMGR",DUZ))) W !,"O  - Outpatient" S FLG1=1
 I $D(^XUSEC("PSJU MGR",DUZ)) W !,"U  - Unit Dose" S FLG2=1
 I $D(^XUSEC("PSJI MGR",DUZ)) W !,"I  - IV" S FLG3=1
 I $D(^XUSEC("PSGWMGR",DUZ)) W !,"W  - Ward Stock" S FLG4=1
 I $D(^XUSEC("PSAMGR",DUZ))!($D(^XUSEC("PSA ORDERS",DUZ))) W !,"D  - Drug Accountability" S FLG5=1
 I $D(^XUSEC("PSDMGR",DUZ)) W !,"C  - Controlled Substances" S FLG6=1
 I $D(^XUSEC("PSORPH",DUZ)) W !,"X  - Non-VA Med" S FLG7=1
 I FLG1,FLG2,FLG3,FLG4,FLG5,FLG6 S FLAG=1
 I FLAG W !,"A  - ALL"
 W !
 I 'FLG1,'FLG2,'FLG3,'FLG4,'FLG5,'FLG6,'FLG7 W !,"You do not have the proper keys to continue. Sorry, this concludes your editing session.",! S FLGKY=1 K DIRUT,X Q
 I FLGKY'=1 D
 . K DIR S DIR(0)="FO^1:30"
 . S DIR("A")="Enter your choice(s) separated by commas "
 . F  D ^DIR Q:$$CHECK($$UP^XLFSTR(X))
 . S PSSANS=X,PSSANS=$$UP^XLFSTR(PSSANS) D BRANCH,BRANCH1
 Q
 ;
CHECK(X) ; Validates Application Use response
 N CHECK,I,C
 S CHECK=1 I X=""!(Y["^")!($D(DIRUT)) Q CHECK
 F I=1:1:$L(X,",") D
 . S C=$P(X,",",I) W !?43,C," - "
 . I C="O",FLG1 W "Outpatient" Q
 . I C="U",FLG2 W "Unit Dose" Q
 . I C="I",FLG3 W "IV" Q
 . I C="W",FLG4 W "Ward Stock" Q
 . I C="D",FLG5 W "Drug Accountability" Q
 . I C="C",FLG6 W "Controlled Substances" Q
 . I C="X",FLG7 W "Non-VA Med" Q
 . W "Invalid Entry",$C(7) S CHECK=0
 Q CHECK
BRANCH D:PSSANS["O" OP D:PSSANS["U" UD D:PSSANS["I" IV D:PSSANS["W" WS
 D:PSSANS["D" DACCT D:PSSANS["C" CS D:PSSANS["X" NVM
 Q
BRANCH1 I FLAG,PSSANS["A" D OP,UD,IV,WS,DACCT,CS,NVM
 Q
OP I FLG1 D
 . W !,"** You are NOW editing OUTPATIENT fields. **"
 . S PSIUDA=DA,PSIUX="O^Outpatient Pharmacy" D ^PSSGIU
 . I %=1 D
 . . S DIE="^PSDRUG(",DR="[PSSOP]" D ^DIE K DIR D OPEI,ASKCMOP
 . . S X="PSOCLO1" X ^%ZOSF("TEST") I  D ASKCLOZ S FLGOI=1
 I FLG1 D CKCMOP
 Q
CKCMOP I $P($G(^PSDRUG(DISPDRG,2)),"^",3)'["O" S:$D(^PSDRUG(DISPDRG,3)) $P(^PSDRUG(DISPDRG,3),"^",1)=0 K:$D(^PSDRUG("AQ",DISPDRG)) ^PSDRUG("AQ",DISPDRG) S DA=DISPDRG D ^PSSREF
 Q
UD I FLG2 W !,"** You are NOW editing UNIT DOSE fields. **" S PSIUDA=DA,PSIUX="U^Unit Dose" D ^PSSGIU I %=1 S DIE="^PSDRUG(",DR="62.05;212.2" D ^DIE S DIE="^PSDRUG(",DR="212",DR(2,50.0212)=".01;1" D ^DIE S FLGOI=1
 Q
IV I FLG3 W !,"** You are NOW editing IV fields. **" S (PSIUDA,PSSDA)=DA,PSIUX="I^IV" D ^PSSGIU I %=1 D IV1 S FLGOI=1
 Q
IV1 K PSSIVOUT ;This variable controls the selection process loop.
 W !,"Edit Additives or Solutions: " K DIR S DIR(0)="SO^A:ADDITIVES;S:SOLUTIONS;" D ^DIR Q:$D(DIRUT)  S PSSASK=Y(0) D:PSSASK="ADDITIVES" ENA^PSSVIDRG D:PSSASK="SOLUTIONS" ENS^PSSVIDRG I '$D(PSSIVOUT) G IV1
 K PSSIVOUT
 Q
WS I FLG4 W !,"** You are NOW editing WARD STOCK fields. **" S DIE="^PSDRUG(",DR="300;301;302" D ^DIE
 Q
DACCT I FLG5 W !,"** You are NOW editing DRUG ACCOUNTABILITY fields. **" S DIE="^PSDRUG(",DR="441" D ^DIE S DIE="^PSDRUG(",DR="9",DR(2,50.1)="1;2;400;401;402;403;404;405" D ^DIE
 Q
CS I FLG6 W !,"** You are NOW Marking/Unmarking for CONTROLLED SUBS. **" S PSIUDA=DA,PSIUX="N^Controlled Substances" D ^PSSGIU
 Q
NVM I FLG7 W !,"** You are NOW Marking/Unmarking for NON-VA MEDS. **" S PSIUDA=DA,PSIUX="X^Non-VA Med" D ^PSSGIU
 Q
ASKCMOP I $D(^XUSEC("PSXCMOPMGR",DUZ)) W !!,"Do you wish to mark to transmit to CMOP? " K DIR S DIR(0)="Y",DIR("?")="If you answer ""yes"", you will attempt to mark this drug to transmit to CMOP."
 D ^DIR I "Nn"[$E(X) K X,Y,DIRUT Q
 I "Yy"[$E(X) S PSXFL=0 D TEXT^PSSMARK H 7 N PSXUDA S (PSXUM,PSXUDA)=DA,PSXLOC=$P(^PSDRUG(DA,0),"^"),PSXGOOD=0,PSXF=0,PSXBT=0 D BLD^PSSMARK,PICK2^PSSMARK S DA=PSXUDA
 Q
ASKCLOZ W !!,"Do you wish to mark/unmark as a LAB MONITOR or CLOZAPINE DRUG? " K DIR S DIR(0)="Y",DIR("?")="If you answer ""yes"", you will have the opportunity to edit LAB MONITOR or CLOZAPINE fields."
 D ^DIR I "Nn"[$E(X) K X,Y,DIRUT Q
 I "Yy"[$E(X) S NFLAG=0 D MONCLOZ
 Q
MONCLOZ K PSSAST D FLASH W !,"Mark/Unmark for Lab Monitor or Clozapine: " K DIR S DIR(0)="S^L:LAB MONITOR;C:CLOZAPINE;" D ^DIR Q:$D(DIRUT)  S PSSAST=Y(0) D:PSSAST="LAB MONITOR" ^PSSLAB D:$G(PSSAST)="CLOZAPINE" CLOZ
 Q
FLASH K LMFLAG,CLFALG,WHICH S WHICH=$P($G(^PSDRUG(DISPDRG,"CLOZ1")),"^"),LMFLAG=0,CLFLAG=0
 I WHICH="PSOCLO1" S CLFLAG=1
 I WHICH'="PSOCLO1" S:WHICH'="" LMFLAG=1
 Q
CLOZ Q:NFLAG  Q:$D(DTOUT)  Q:$D(DIRUT)  Q:$D(DUOUT)  W !,"** You are NOW editing CLOZAPINE fields. **" D ^PSSCLDRG
 Q
USE K PACK S PACK="" S:$P($G(^PSDRUG(DISPDRG,"PSG")),"^",2)]"" PACK="W" I $D(^PSDRUG(DISPDRG,2)) S PACK=PACK_$P(^PSDRUG(DISPDRG,2),"^",3)
 I PACK'="" D
 .W $C(7) N XX W !! F XX=1:1:79 W "*"
 .W !,"This entry is marked for the following PHARMACY packages: "
 .D USE1
 Q
USE1 W:PACK["O" !," Outpatient" W:PACK["U" !," Unit Dose" W:PACK["I" !," IV"
 W:PACK["W" !," Ward Stock" W:PACK["D" !," Drug Accountability"
 W:PACK["N" !," Controlled Substances" W:PACK["X" !," Non-VA Med"
 W:'$D(PACK) !," NONE"
 I PACK'["O",PACK'["U",PACK'["I",PACK'["W",PACK'["D",PACK'["N",PACK'["X" W !," NONE"
 Q
WR I ^XMB("NETNAME")'["CMOP-" W:OLDDF'="" !,"The dosage form has changed from "_OLDDF_" to "_NEWDF_" due to",!,"matching/rematching to NDF.",!,"You will need to rematch to Orderable Item.",!
 Q
PRIMDRG I $D(^PS(59.7,1,20)),$P(^PS(59.7,1,20),"^",1)=4!($P(^PS(59.7,1,20),"^",1)=4.5) I $D(^PSDRUG(DISPDRG,2)) S VAR=$P(^PSDRUG(DISPDRG,2),"^",3) I VAR["U"!(VAR["I") D PRIM1
 Q
PRIM1 W !!,"You need to match this drug to ""PRIMARY DRUG"" file as well.",! S DIE="^PSDRUG(",DR="64",DA=DISPDRG D ^DIE K VAR
 Q
MF I $P($G(^PS(59.7,1,80)),"^",2)>1 I $D(^PSDRUG(DISPDRG,2)) S PSSOR=$P(^PSDRUG(DISPDRG,2),"^",1) I PSSOR]"" D EN^PSSPOIDT(PSSOR),EN2^PSSHL1(PSSOR,"MUP")
 Q
MFA I $P($G(^PS(59.7,1,80)),"^",2)>1 S PSSOR=$P(^PS(52.6,ENTRY,0),"^",11),PSSDD=$P(^PS(52.6,ENTRY,0),"^",2) I PSSOR]"" D EN^PSSPOIDT(PSSOR),EN2^PSSHL1(PSSOR,"MUP") D MFDD
 Q
MFS I $P($G(^PS(59.7,1,80)),"^",2)>1 S PSSOR=$P(^PS(52.7,ENTRY,0),"^",11),PSSDD=$P(^PS(52.7,ENTRY,0),"^",2) I PSSOR]"" D EN^PSSPOIDT(PSSOR),EN2^PSSHL1(PSSOR,"MUP") D MFDD
 Q
MFDD I $D(^PSDRUG(PSSDD,2)) S PSSOR=$P(^PSDRUG(PSSDD,2),"^",1) I PSSOR]"" D EN^PSSPOIDT(PSSOR),EN2^PSSHL1(PSSOR,"MUP")
 Q
OPEI ;
 S DIE="^PSDRUG(",DR="28",DA=DISPDRG
 D ^DIE
 Q:'+$P($G(^PSDRUG(DA,6)),"^")
OPEI2 ; get external dispensing devices associated with the drug
 W !!,"Defining a dispensing device at the drug level for a division will override"
 W !,"the dispensing device settings in the OUTPATIENT SITE File (#59). If populated,",!,"the drug will be sent to the dispensing device for that division.",!
 S DR="906"
 D ^DIE
 Q
DEA ;
 I $P($G(^PSDRUG(DISPDRG,3)),"^")=1,($P(^PSDRUG(DISPDRG,0),"^",3)[1!($P(^(0),"^",3)[2)) D DSH
 Q
DSH W !!,"****************************************************************************"
 W !,"This entry contains a ""1"" or a ""2"" in the ""DEA, SPECIAL HDLG""",!,"field, therefore this item has been UNMARKED for CMOP transmission."
 W !,"****************************************************************************",! S $P(^PSDRUG(DISPDRG,3),"^")=0 K ^PSDRUG("AQ",DISPDRG) S DA=DISPDRG N % D ^PSSREF
 Q
CPTIER(VAPID) ;Called from PSSCOMMON Input Template
 ; VAPID = IEN OF DRUG FILE #50
 N CPDATE,X,PSSCP D NOW^%DTC S CPDATE=X S PSSCP=$$CPTIER^PSNAPIS("",CPDATE,VAPID,1) K CPDATE,X
 ;  PSSCP = Copay Tier^Effective Date^End Date
 W !,"Copay Tier: ",$P(PSSCP,"^",1)
 W !,"Copay Effective Date: " S Y=$P(PSSCP,"^",2) D DD^%DT W Y K Y,PSSCP
 Q
 ;
GETTIER(PSSTDRUG) ;called by DIC to get copay tier for today's date 
 N VAPID,CPDATE,X,PSSCP,VAPROD,PSSDRGCL,PSSCONVD,PSSINACT,PSSFSN,PSSNFORM,PSSMSG,PSSRESTR,PSSDRDAT,PSSFD D NOW^%DTC S CPDATE=X
 D GETS^DIQ(50,PSSTDRUG,"2;22;51;6;100;101;102","IE","PSSDRDAT")
 S (PSSDRGCL,PSSFSN,PSSNFORM,PSSINACT,PSSMSG,PSSRESTR,VAPROD)=""
 S:$G(PSSDRDAT(50,PSSTDRUG_",",2,"E"))'="" PSSDRGCL=PSSDRDAT(50,PSSTDRUG_",",2,"E")
 S:$G(PSSDRDAT(50,PSSTDRUG_",",6,"E"))'="" PSSFSN=PSSDRDAT(50,PSSTDRUG_",",6,"E")
 S:$G(PSSDRDAT(50,PSSTDRUG_",",51,"E"))'="" PSSNFORM=PSSDRDAT(50,PSSTDRUG_",",51,"E")
 S:$G(PSSDRDAT(50,PSSTDRUG_",",100,"I")) PSSINACT=PSSDRDAT(50,PSSTDRUG_",",100,"I")
 S:$G(PSSDRDAT(50,PSSTDRUG_",",101,"E"))'="" PSSMSG=PSSDRDAT(50,PSSTDRUG_",",101,"E")
 S:$G(PSSDRDAT(50,PSSTDRUG_",",102,"E"))'="" PSSRESTR=PSSDRDAT(50,PSSTDRUG_",",102,"E")
 S:$G(PSSDRDAT(50,PSSTDRUG_",",22,"I")) VAPROD=PSSDRDAT(50,PSSTDRUG_",",22,"I")
 W " "_$$GET1^DIQ(50,PSSTDRUG,2)
 S PSSCP=$$CPTIER^PSNAPIS(VAPROD,CPDATE,"",1) K CPDATE,X
 W:$G(PSSFSN)["" "  "_PSSFSN W:$G(PSSNFORM)["" "  ",PSSNFORM ;FSN; local non-formulary
 S PSSFD=$$FDR^PSNACT(VAPROD) ;ppsn
 W:PSSFD'="" "  "_PSSFD
 I $G(VAPROD),$P(PSSCP,"^")'="" W "  Tier ",$P(PSSCP,"^")
 S:$G(PSSINACT) PSSCONVD=$$DATE(PSSINACT)  ;inactive date
 W:$G(PSSCONVD)'="" "  "_PSSCONVD
 W:$G(PSSMSG)'="" "  "_PSSMSG
 W:$G(PSSRESTR)'="" "  "_PSSRESTR
 Q
 ;
DATE(PSSCONVD) ;convert fileman date to mm/dd/yyyy
 N DATE
 S DATE="",DATE=$E(PSSCONVD,4,5)_"/"_$E(PSSCONVD,6,7)_"/"_(1700+$E(PSSCONVD,1,3))
 Q DATE
 ;
FD(PSSTDRUG) ;
 N VAPROD,PSSDRDAT
 D GETS^DIQ(50,PSSTDRUG,22,"I","PSSDRDAT")
 S VAPROD=PSSDRDAT(50,PSSTDRUG_",",22,"I")
 Q:VAPROD=""
 S PSSFD="",PSSFD=$$GET1^DIQ(50.68,VAPROD,109)  ;ppsn
 W:PSSFD'="" !,"Formulary Designator: "_PSSFD
 I $D(^PSNDF(50.68,VAPROD,5.1,1,0)) D FDT^PSNACT(VAPROD) ;ppsn
 Q
