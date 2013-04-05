ECXFEKEY ;BIR/DMA,CML-Print Feeder Keys; [ 05/15/96  9:44 AM ] ;5/3/12  11:33
 ;;3.0;DSS EXTRACTS;**10,11,8,40,84,92,123,132,136**;Dec 22, 1997;Build 28
EN ;entry point from option
 W !!,"Print list of Feeder Keys:",!
 W !,"Select : 1. CLI",!,?9,"2. ECS",!,?9,"3. LAB",!,?9,"4. NUT",!,?9,"5. PHA",!,?9,"6. RAD",!,?9,"7. SUR",!,?9,"8. PRO",! S DIR(0)="L^1:8" D ^DIR Q:$D(DIRUT)  ;136
 S ECY=Y
 I ECY["2" D
 .W !!,"The Feeder Key List for the Feeder System ECS can be printed by:",!?5,"(O)ld Feeder Key sort by Category-Procedure",!?5,"(N)ew Feeder Key sort by Procedure-CPT Code"
 .S DIR(0)="S^O:OLD;N:NEW",DIR("B")="NEW" D ^DIR K DIR Q:$D(DIRUT)  S ECECS=Y
 S:ECY["3" ECLAB=$$SELLABKE^ECXFEKE1() ;**Prompt to select Lab Feeder key
 G:($G(ECLAB)=-1) QUIT ;**GOTO Exit point
 G:$D(DIRUT) QUIT
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS
 I POP W !,"NO DEVICE SELECTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") D  G QUIT
 .S ZTRTN="START^ECXFEKEY",ZTDESC="Feeder Key List (DSS)"
 .S ZTSAVE("ECY")="",ZTSAVE("ECPHA")="",ZTSAVE("ECPHA2")="",ZTSAVE("ECECS")="",ZTSAVE("ECLAB")=""
 .D ^%ZTLOAD I $D(ZTSK) W !,"Queued Task #: "_ZTSK
 .D HOME^%ZIS K ZTSK
 ;
START ;queued entry point
 I '$D(DT) S DT=$$HTFM^XLFDT(+$H)
 K ^TMP($J)
 F ECLIST=1:1 S EC=$P(ECY,",",ECLIST) Q:EC=""  D:EC=1 CLI D:EC=2 ECS D:EC=3 LAB D:EC=4 NUT D:EC=5 PHA D:EC=6 RAD D:EC=7 SUR^ECXFEKE1 D:EC=8 PRO ;136
 U IO D PRINT^ECXFEKE1
 Q
LAB S EC=0
 ;
 ;** OLD Feeder Key format
 I $G(ECLAB)="O" DO
 .F  S EC=$O(^LAB(60,EC)) Q:'EC  I $D(^(EC,0)) S EC1=$P(^(0),U),^TMP($J,"LAB",EC,EC)=EC1
 ;
 ;** NEW Feeder key format (LMIP Code)
 I $G(ECLAB)="N" DO
 .N EC2
 .F  S EC=$O(^LAM(EC)) Q:'EC  DO
 ..I $D(^LAM(EC,0)) DO
 ...S EC1=$P(^LAM(EC,0),U,1),EC1=$P(EC1,"~",1)
 ...S EC2=$P(^LAM(EC,0),U,2)
 ...I EC2'[".9999",(EC2'[".8") S EC2=EC2\1
 ...S ^TMP($J,"LAB",+EC2,+EC2)=EC1
 Q
ECS ;old ECS feeder key list for pre-FY97 data
 G:$G(ECECS)="N" ECS2
 S EC=0 I $P($G(^EC(720.1,1,0)),U,2) D  G ECQ
 .F  S EC=$O(^ECJ(EC)) Q:'EC  I $D(^(EC,0)) D
 ..S EC1=$P($P(^(0),U),"-",3,4),EC2=$P(EC1,"-"),EC2=$S(+EC2:EC2,1:"***"),EC4=$S($P($G(^EC(726,+EC2,0)),U)]"":$P(^(0),U),1:"***")
 ..S EC3=$P(EC1,"-",2) Q:'+EC3  S EC3=$S(EC3["ICPT":$P($$CPT^ICPTCOD(+EC3),U,2),+EC3<90000:$P($G(^EC(725,+EC3,0)),U,2)_"N",1:$P($G(^EC(725,+EC3,0)),U,2)_"L")
 ..S EC5=$P(EC1,"-",2),EC5=$S(EC5["ICPT":$E($P($$CPT^ICPTCOD(+EC5),U,3),1,25),EC5["EC":$E($P($G(^EC(725,+EC5,0)),U),1,25),1:"UNKNOWN")
 ..S ^TMP($J,"ECS",EC2_" - "_EC3,EC3)=EC4_" - "_EC5
 F  S EC=$O(^ECK(EC)) Q:'EC  I $D(^(EC,0)) S EC1=$P($P(^(0),U),"-",3,4),EC2=$E($P($G(^ECP(+EC1,0)),U),1,25),EC3=$E($P($G(^ECP(+$P(EC1,"-",2),0)),U),1,25),^TMP($J,"ECS",EC1,EC1)=EC2_" - "_EC3
ECQ K EC1,EC2,EC3,EC4,EC5,EC6,EC7,EC8,EC9,EC10 Q
ECS2 ;new ECS feeder key list for FY97 data
 ;feeder key is <Procedure> if PCE CPT code is same or null;
 ;feeder is <Procedure-PCE CPT> otherwise;
 ;the description column of list shows procedure (EC5) in lowercase and CPT code (EC8) in uppercase;
 ;but if procedure (EC3) is itself a CPT Code, convert EC5 to uppercase
 ;concatenation of "A;" and "B;" are for proper sorting - CPT codes 1st, then other procedures
 S EC=0 I $P($G(^EC(720.1,1,0)),U,2) D  G ECQ
 .F  S EC=$O(^ECJ(EC)) Q:'EC  I $D(^ECJ(EC,0)) D
 ..S EC1=$P($P(^ECJ(EC,0),U),"-",3,4)
 ..S EC3=$P(EC1,"-",2) Q:'+EC3  S EC3=$S(EC3["ICPT":$P($$CPT^ICPTCOD(+EC3),U,2),+EC3<90000:$P($G(^EC(725,+EC3,0)),U,2)_"N",1:$P($G(^EC(725,+EC3,0)),U,2)_"L")
 ..S EC5=$P(EC1,"-",2),EC5=$S(EC5["ICPT":$E($P($$CPT^ICPTCOD(+EC5),U,3),1,25),EC5["EC":$E($P($G(^EC(725,+EC5,0)),U),1,25),1:"UNKNOWN")
 ..S EC5=$$LOW(EC5)
 ..I EC1["ICPT" S EC5=$$UPP(EC5),EC3="A;"_EC3
 ..S EC6=$P(EC1,"-",2),EC7="",EC8=""
 ..I EC6["EC(725," D
 ...S EC6=$S(+EC6>0:$P($G(^EC(725,+EC6,0)),U,5),1:"") S EC7=$S(+EC6>0:$P($$CPT^ICPTCOD(+EC6),U,2),1:"")
 ...S EC8=$S(+EC6>0:$E($P($$CPT^ICPTCOD(+EC6),U,3),1,25),1:"")
 ...S EC8=$$UPP(EC8),EC3="B;"_EC3
 ..S EC9=$S(EC7'="":EC3_"-"_EC7,1:EC3),EC10=$S(EC8'="":EC5_" - "_EC8,1:EC5)
 ..S ^TMP($J,"ECS",EC9,EC3)=EC10
 G ECQ
LOW(X) ;convert string to lowercase
 F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)
 Q X
UPP(X) ;convert string to uppercase
 F %=1:1:$L(X) S:$E(X,%)?1L X=$E(X,0,%-1)_$C($A(X,%)-32)_$E(X,%+1,999)
 Q X
 ;
PHA ;NEW PHA Feeder Key List sorted by NDF Match
 N ECPPDU,ECXPHA,ARRAY
 S ARRAY="^TMP($J,""ECXLIST"")"
 K @ARRAY
 ;Call pharmacy drug file (#50) api dbia 4483 and create ^TMP global
 D DATA^PSS50(,"??",DT,,,"ECXLIST")
 S ECXYM=$$ECXYM^ECXUTL(DT)
 ;$order thru "B" cross reference
 S ECD="" F  S ECD=$O(@ARRAY@("B",ECD)) Q:ECD=""  D
 .S EC=0 F  S EC=$O(@ARRAY@("B",ECD,EC)) Q:EC'>0  D
 ..S ECD=$P(@ARRAY@(EC,.01),U),ECNDC=@ARRAY@(EC,31),ECNFC=$$RJ^XLFSTR($P(ECNDC,"-"),6,0)_$$RJ^XLFSTR($P(ECNDC,"-",2),4,0)_$$RJ^XLFSTR($P(ECNDC,"-",3),2,0),ECNFC=$TR(ECNFC,"*",0)
 ..S P1=$P(@ARRAY@(EC,20),U),P3=$P(@ARRAY@(EC,22),U)
 ..;get the 17 character key
 ..S ECNFC=$$DSS^PSNAPIS(P1,P3,ECXYM)_ECNFC
 ..Q:+ECNFC=0
 ..S ECNFC="A"_ECNFC
 ..S ECPPDU=@ARRAY@(EC,16),ECPPDU=$FNUMBER(ECPPDU,"P",4)
 ..S ^TMP($J,"PHA",ECNFC,0)=ECD_U_ECPPDU
 K @ARRAY
 Q
CLI S SC=0 F  S SC=$O(^SC(SC)) Q:'SC  I $D(^(SC,0)) S EC=^(0),ECD=$P(EC,U) I $P(EC,U,3)="C" D  S ^TMP($J,"CLI","A;"_P1_P2_ECLEN_P3_"0",SC)=ECD
 .S ECSC=$P($G(^DIC(40.7,+$P(EC,U,7),0)),U,2),ECCSC=$P($G(^DIC(40.7,+$P(EC,U,18),0)),U,2)
 .S ECLEN="NNN" I $D(^SC(SC,"SL")),$P(^("SL"),U,2)'="V" S ECLEN=$S($P(^("SL"),U):$P(^("SL"),U),1:"NNN"),ECLEN=$E("000"_ECLEN,$L(ECLEN)+1,$L(ECLEN)+3)
 .S (P1,P2)="000",P3="0000" I '$D(^ECX(728.44,SC,0)),ECCSC]"" S ECST=5,P1=$E("000"_ECSC,$L(ECSC)+1,$L(ECSC)+3),P2=$E("000"_ECCSC,$L(ECCSC)+1,$L(ECCSC)+3) Q
 .I '$D(^ECX(728.44,SC,0)) S ECST=1,P1=$E("000"_ECSC,$L(ECSC)+1,$L(ECSC)+3) Q
 .S EC=^ECX(728.44,SC,0),ECST=$P(EC,U,6)
 .I ECST=6 Q
 .;action code 6 means ignore
 .I $P(EC,U,4)]"" S ECSC=$P(EC,U,4)
 .I $P(EC,U,5)]"" S ECCSC=$P(EC,U,5)
 .I ECST="" S ECST=4,P1=$E("000"_ECSC,$L(ECSC)+1,$L(ECSC)+3),P3=$E("0000"_SC,$L(SC)+1,$L(SC)+4) S:ECCSC P2=$E("000"_ECCSC,$L(ECCSC)+1,$L(ECCSC)+3) Q
 .I ECST<2 S P1=ECSC,P1=$E("000"_P1,$L(P1)+1,$L(P1)+3) Q
 .I ECST=2 S P1=ECCSC,P1=$E("000"_P1,$L(P1)+1,$L(P1)+3) Q
 .I ECST=3 S P1=ECSC,P11=ECCSC,P1=$E("000"_P1,$L(P1)+1,$L(P1)+3),P11=$E("000"_P11,$L(P11)+1,$L(P11)+3) Q
 .I ECST>3,ECST<7 S P1=ECSC,P2=ECCSC,P1=$E("000"_P1,$L(P1)+1,$L(P1)+3),P2=$E("000"_P2,$L(P2)+1,$L(P2)+3) S:ECST=4 P3=$P($G(^ECX(728.441,+$P(^ECX(728.44,SC,0),U,8),0)),U) I P3="" S P3=$E("0000"_SC,$L(SC)+1,$L(SC)+4)
 K ECLEN Q
RAD S EC=0 F  S EC=$O(^RAMIS(71,EC)) Q:'EC  I $D(^(EC,0)) S EC1=^(0),ECD=$P(EC1,U),EC2=$P($G(^ICPT(+$P(EC1,U,9),0)),U) S:EC2="" EC2="Unknown" S ^TMP($J,"RAD",EC2,EC)=ECD
 S ^TMP($J,"RAD",88888,88888)="Portable procedure",^TMP($J,"RAD",99999,99999)="OR procedure"
 Q
NUT ;Feeder keys for Nutrition and Food Service extract
 N TYP,TIEN,DIET,IN,PRODUCT,KEY,NUMBER,IENS
 S TYP="" F  S TYP=$O(^ECX(728.45,"B",TYP)) Q:TYP=""  S TIEN=0 F  S TIEN=$O(^ECX(728.45,"B",TYP,TIEN)) Q:'TIEN  S DIET="" F  S DIET=$O(^ECX(728.45,TIEN,1,"B",DIET)) Q:DIET=""  S IN=0 F  S IN=$O(^ECX(728.45,TIEN,1,"B",DIET,IN)) Q:IN'>0  D
 . S IENS=""_IN_","_TIEN_","_""
 . S KEY=$$GET1^DIQ(728.451,IENS,1,"E")
 . S ^TMP($J,"ECX",KEY,DIET)=TYP_"  "_$$GET1^DIQ(728.451,IENS,.01,"E")
 Q
PRO ;Prosthetics Feeder Key section, API added in patch 136
 N H,HCPCS,CODE,CPTNM,DESC,TYPE,SOURCE,LOC,FKEY,KEY
 S H=0
 F  S H=$O(^ECX(727.826,H)) Q:+H<1  D
 .S HCPCS=$P($G(^ECX(727.826,H,0)),U,33),KEY=$E($P($G(^ECX(727.826,H,0)),U,11),6,20)
 .I HCPCS'="" I '$D(FKEY(HCPCS_KEY)) S FKEY(HCPCS_KEY)=HCPCS
 S HCPCS="" F  S HCPCS=$O(FKEY(HCPCS)) Q:HCPCS=""  D
 .S CODE=$$CPT^ICPTCOD(FKEY(HCPCS)) Q:+CODE=-1
 .S CPTNM=HCPCS,DESC=$P(CODE,U,3)
 .I $P(CODE,U,2)=""!(DESC="") Q
 .S TYPE=$E(HCPCS,6),SOURCE=$E(HCPCS,7),LOC=$S(HCPCS["REQ":"REQ",HCPCS["REC":"REC",1:"")
 .S DESC=DESC_$S(TYPE="R":"/Rent",TYPE="N":"/New",TYPE="X":"/Repair",1:"")_$S(SOURCE="V":"/VA",SOURCE="C":"/COM",1:"")_$S(LOC="REQ":"/XXX Site REQ",LOC="REC":"/XXX Site REC",1:"")
 .S ^TMP($J,"PRO",CPTNM,CPTNM)=DESC
 Q
QUIT ;
 K ECY,ECPHA,ECECS,ECLAB,ECPPDU,DIR,DIRUT,DUOUT,X,Y
 Q
