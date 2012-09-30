ONCOPA1 ;Hines OIFO/GWB - [PA Print Complete Abstract (132c)] ;09/22/11
 ;;2.11;ONCOLOGY;**13,15,16,18,28,33,34,36,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54**;Mar 07, 1995;Build 10
 ;
 ;Replaces print templates ONCOX1-X11.
 ;
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP EXIT
 I $D(IO("Q")) S ONCOLST="ONCOIEN^PTIEN^STARS^LENGTH^TITLE^PRTPCE^ONCODA^ESPD" D TASK G EXIT
 U IO D PRINT D ^%ZISC K %ZIS,IOP G EXIT
 ;
PRINT ;Print
 Q:$G(ONCOIEN)=""
 W @IOF
 S (IEN,D0)=ONCOIEN,PTIEN=$P($G(^ONCO(165.5,IEN,0)),U,2)
 S PG=0,EX="",LINE=$S($E(IOST,1,2)="C-":IOSL-2,1:IOSL-6)
 S STARS="******************************************************************************"
 S DATEDX=$P($G(^ONCO(165.5,IEN,0)),U,16)
 D NOW^%DTC S Y=% K % D DD^%DT S PRTDATE=Y
 K DIQ S DIC="^ONCO(160,",DIQ(0)="C"
 S DR=".111:.131;2;7:10;13;18.9:21;22.9:29;38:44;48;50;51;52;61;55;56;62;63;64;65;66;67;68;1006"
 S DA=PTIEN,DIQ="ONCAB" D EN^DIQ1
 K DIQ S DIC="^ONCO(165.5,",DIQ(0)="C"
 S DR=".01:.07;1.2;2:2.4;3;3.5:19;20.1;22:35.1;37:40.2;41;49:59;62:67;70:71.3;74:79;83;85:92;95;100;101;108;117:130;132;133;137:146;200;346;363;363.1;442;443;560;787;50.2;361;623;684;1010;153;153.1;435;149;151;154:156;170;171:192;711:713;809"
 S DA=ONCOIEN,DIQ="ONCAB" D EN^DIQ1
 K DIQ S DIC="^ONCO(165.5,",DIQ(0)="IE"
 S DR="29.2;30.2;29.1;31.1;32.1;32;33;34.3;34.4;44.1:44.9;160:168;148:148.4;15;21;25;44;46;47;96;102;159;193;194;195;196;2.2;227:235;1423:1423.4;157.1;24.1;24.2;237;34.31:34.4;241;242;245;250;279:281"
 S DA=ONCOIEN,DIQ="ONCAB" D EN^DIQ1
 K DIQ S DIC="^ONCO(165.5,",DIQ(0)="C"
 S DR="72",DA=ONCOIEN,DR(165.572)=".01;.02;.03;.031;.032",DIQ="ONCAB"
 F SR=0:0 S SR=$O(^ONCO(165.5,IEN,23,SR)) Q:SR'>0  D
 .S DA(165.572)=SR D EN^DIQ1 Q
 K DIQ S DIC="^ONCO(165.5,",DIQ(0)="C"
 S DR="60",DA=ONCOIEN,DR(165.51)=".01:2;33:37",DIQ="ONCAB"
 F SCT=0:0 S SCT=$O(^ONCO(165.5,IEN,4,SCT)) Q:SCT'>0  D
 .S DA(165.51)=SCT D EN^DIQ1 Q
 K DIQ S DIC="^ONCO(160,",DIQ(0)="C"
 S DR="44",DA=PTIEN,DR(160.044)=".01:1",DIQ="ONCAB"
 F CHST=0:0 S CHST=$O(^ONCO(160,PTIEN,9,CHST)) Q:CHST'>0  D
 .S DA(160.044)=CHST D EN^DIQ1 Q
 I $G(ESPD)=1 D
 .S ONCAB(165.5,IEN,.02)="XXXXX,XXXXX"
 .S ONCAB(160,PTIEN,2)="XXX-XX-XXXX"
 .S ONCAB(160,PTIEN,.119)="XXXXXXXXXX"
 .S $P(ONCAB(160,PTIEN,.116),",",1)="XXXXX"
 .S ONCAB(160,PTIEN,.131)="XXX-XXX-XXXX"
 .S ONCAB(165.5,IEN,8)="XXXXXXXXXX"
 .S ONCAB(165.5,IEN,8.2)="XXXXXXXXXX"
 .S ONCAB(165.5,IEN,8.1)="XXXXX"
 S PATNAME=$G(ONCAB(165.5,IEN,.02)),SSAN=$G(ONCAB(160,PTIEN,2))
 S NAME="CANCER REGISTRY ABSTRACT" D FORMAT
 S CRA=TITLE W !!,TITLE
 W !!?21,$E(ONCAB(165.5,IEN,.03),1,26)
 W "    ACOS #:  ",ONCAB(165.5,IEN,67)
 W ?76,"Print Date:  ",PRTDATE D P Q:EX=U
 W !,"      Patient Name:  ",ONCAB(165.5,IEN,.02),?76,"SSN:  ",ONCAB(160,PTIEN,2) D P Q:EX=U
 S DOB="",VRBLPTR=$P($G(^ONCO(160,PTIEN,0)),U,1) I VRBLPTR'="" D
 .S FILE=U_$P(VRBLPTR,";",2)_$P(VRBLPTR,";",1)_",0)"
 .S Y=$S($D(@FILE):$P(@FILE,U,3),1:"") I Y'="" D DD^%DT S DOB=Y Q
 W !,"      Home Address:  ",ONCAB(160,PTIEN,.119) D P Q:EX=U
 W !,"                     ",ONCAB(160,PTIEN,.118) D P Q:EX=U
 W !,"            County:  ",ONCAB(160,PTIEN,.12) D P Q:EX=U
 W !,"               Sex:  ",$E(ONCAB(160,PTIEN,10),1,14),?44,"Race:  ",$E(ONCAB(160,PTIEN,8),1,21),?76,"Ethnicity:  ",ONCAB(160,PTIEN,9) D P Q:EX=U
 W !,"     Date of Birth:  ",DOB
 W ?38," Age at DX:  ",ONCAB(165.5,IEN,4) D P Q:EX=U
 ;
CI ;Cancer Identification
 S NAME="CANCER IDENTIFICATION" D FORMAT
 W !!,TITLE
 S NODE2=$G(^ONCO(165.5,IEN,2))
 S COC=$E($$GET1^DIQ(165.5,IEN,.04),1,2)
 W !!,"       Accession Number: ",ONCAB(165.5,IEN,.05),?38,"Accession Year:  ",ONCAB(165.5,IEN,.07),?76,"Sequence Number:  ",ONCAB(165.5,IEN,.06) D P Q:EX=U
 W !,"                    Date Dx: ",ONCAB(165.5,IEN,3) D P Q:EX=U
 I DATEDX>3061231 D
 .W !,"   Ambiguous Terminology Dx: ",ONCAB(165.5,IEN,159,"E") D P Q:EX=U
 .W !,"      Date of Conclusive Dx: ",ONCAB(165.5,IEN,193,"E") D P Q:EX=U
 W !,"                Dx Facility: ",ONCAB(165.5,IEN,5) D P Q:EX=U
 W !,"      Date of First Contact: ",ONCAB(165.5,IEN,155) D P Q:EX=U
 I DATEDX>3091231 D
 .W !,"           Inpatient Status: ",ONCAB(165.5,IEN,233,"E") D P Q:EX=U
 W !,"              Class of Case: ",ONCAB(165.5,IEN,.04) D P Q:EX=U
 W !,"     Date of First Symptoms: ",ONCAB(165.5,IEN,171) D P Q:EX=U
 W !,"  Date Start Workup Ordered: ",ONCAB(165.5,IEN,172) D P Q:EX=U
 W !,"        Date Workup Started: ",ONCAB(165.5,IEN,173) D P Q:EX=U
 W !,"   Type of Reporting Source: ",ONCAB(165.5,IEN,1.2) D P Q:EX=U
 W !,"                    Site/Gp: ",ONCAB(165.5,IEN,.01) D P Q:EX=U
 W !,"          Primary Site Code: ",ONCAB(165.5,IEN,20.1),"  "
 S TOP=$P(NODE2,U,1) I TOP'="" W $P(^ONCO(164,TOP,0),U,1) D P Q:EX=U
 W !,"    Text-Primary Site Title: ",ONCAB(165.5,IEN,100) D P Q:EX=U
 I DATEDX>3061231 D
 .W !,"   Mult Tum Rpt as One Prim: ",ONCAB(165.5,IEN,194,"E") D P Q:EX=U
 .W !,"    Date of Multiple Tumors: ",ONCAB(165.5,IEN,195,"E") D P Q:EX=U
 .W !,"       Multiplicity Counter: ",ONCAB(165.5,IEN,196,"E") D P Q:EX=U
 W !,"                 Laterality: ",ONCAB(165.5,IEN,28) D P Q:EX=U
 S HIST=$$HIST^ONCFUNC(IEN,.HSTFLD)
 W !,"                  Histology: ",ONCAB(165.5,IEN,HSTFLD) D P Q:EX=U
 W !,"       Text-Histology Title: ",ONCAB(165.5,IEN,101) D P Q:EX=U
 W:TOP=67619 !,"       Gleason Score (Clin): ",ONCAB(165.5,IEN,623)
 W:TOP=67619 !,"       Gleason Score (Path): ",ONCAB(165.5,IEN,250,"E")
 W:TOP=67619 !,"                        PSA: ",ONCAB(165.5,IEN,684)
 W:TOP=67619 !,"                   PSA Date: ",ONCAB(165.5,IEN,96,"E")
 W:TOP=67619 !,"                    DRE +/-: ",ONCAB(165.5,IEN,102,"E")
 W:TOP=67619 !,"                   DRE Date: ",ONCAB(165.5,IEN,156)
 W !,"      Grade/Differentiation: ",ONCAB(165.5,IEN,24),"  "
 S GR=$P(NODE2,U,5) I GR'="" W $P(^ONCO(164.43,GR,0),U,2) D P Q:EX=U
 I DATEDX>3091231 D
 .W !,"          Grade Path System: ",ONCAB(165.5,IEN,24.1,"E") D P Q:EX=U
 .W !,"           Grade Path Value: ",ONCAB(165.5,IEN,24.2,"E") D P Q:EX=U
 W !,"         AFIP/JPC Submission: ",ONCAB(165.5,IEN,83) D P Q:EX=U
 W !,"    Diagnostic Confirmation: ",ONCAB(165.5,IEN,26) D P Q:EX=U
 W:TOP=67220 !,"                Hepatitis C: ",ONCAB(165.5,IEN,1010)
 S TM1=$$PRINT^ONCOTM(IEN,1)
 I TM1["UMOR" S $E(TM1,2,5)="umor" I TM1["ARKER" S $E(TM1,8,12)="arker"
 S TM2=$$PRINT^ONCOTM(IEN,2)
 I TM2["UMOR" S $E(TM2,2,5)="umor" I TM2["ARKER" S $E(TM2,8,12)="arker"
 S TM3=$$PRINT^ONCOTM(IEN,3)
 I TM3["UMOR" S $E(TM3,2,5)="umor" I TM3["ARKER" S $E(TM3,8,12)="arker"
 S LEN=$L(TM1) W !?(27-LEN),TM1,": ",ONCAB(165.5,IEN,25.1) D P Q:EX=U
 S LEN=$L(TM2) W !?(27-LEN),TM2,": ",ONCAB(165.5,IEN,25.2) D P Q:EX=U
 S LEN=$L(TM3) W !?(27-LEN),TM3,": ",ONCAB(165.5,IEN,25.3) D P Q:EX=U
 W !,"     Facility Referred From: ",ONCAB(165.5,IEN,6) D P Q:EX=U
 W !,"       Facility Referred To: ",ONCAB(165.5,IEN,7) D P Q:EX=U
 W !,"                  Fee Basis: ",ONCAB(165.5,IEN,237,"E") D P Q:EX=U
 W !,"Presentation at Cancer Conf: ",ONCAB(165.5,IEN,120) D P Q:EX=U
 W !,"  Date of Cancer Conference: ",ONCAB(165.5,IEN,121) D P Q:EX=U
 W !,"         Casefinding Source: ",ONCAB(165.5,IEN,21,"E")
 ;
 I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR Q:'Y  D HDR G PA1A
 D P Q:EX=U
PA1A D ^ONCOPA1A
 ;
EXIT ;KILL variables
 K CHST,CMIEN,CNTR,COC,CRA,D0,DA,DATEDX,DIC,DIQ,DIR,DOB,DR,DTE,DXDT,EX
 K FHDT,FHIEN,FHZN,FILE,FLG,FM,FOLH,FR,GR,HIST,HSTFLD,IC,ICDCD,IEN,LEN
 K LENGTH,LINE,NAME,NF,NODE2,NOK,NUM,ONCAB,ONCOIEN,ONCOLST,OTHPRI,PATH
 K PATNAME,PG,POP,PRI,PRTDATE,PRTPCE,PRZN,PTIEN,QS,RCDT,REG,REG1,RK,RK1
 K SCT,SITE,SR,SSAN,ST,STARS,TITLE,TM1,TM2,TM3,TOP,TPX,TSIEN,TSTAT,UF
 K VRBLPTR,VS,Y,ZN
 Q
 ;
P ;Enter RETURN to continue
 I $Y>(IOSL-10) D  Q:EX=U  W !
 .I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
 ;
FORMAT ;
 S LENGTH=$L(NAME),NUM=(((132-LENGTH)/2)\1)-10
 S TITLE="     "_$E(STARS,1,NUM)_"     "_NAME_"     "_$E(STARS,1,NUM)
 Q
 ;
TASK ;Report Queued
 K ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRINT^ONCOPA1",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Complete Abstract"
 F RK=1:1 S RK1=$P(ONCOLST,U,RK) Q:RK1=""  S ZTSAVE(RK1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Report Queued",!
 K ZTDESC,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
HDR ;Header
 W @IOF S PG=PG+1
 W CRA,!
 W ?5," Patient Name:  ",PATNAME,?84,"SSN:  ",SSAN,!
 Q
 ;
MULT ;Entry point for option ABS...MA...3).
 ;Also called from PCEPRT2^ONCOGEN.
 I $D(IO("Q")) S ONCOLST="ONCOIEN^PTIEN^STARS^LENGTH^TITLE^PRTPCE^ONCODA^ESPD" D TASK G EXIT
 U IO D PRINT K %ZIS,IOP G EXIT
 Q
 ;
CLEANUP ;Cleanup
 K ESPD
