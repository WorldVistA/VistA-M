ONCOAIP ;Hines OIFO/GWB - [EE Abstract Edit Primary] ;09/26/11
 ;;2.2;ONCOLOGY;**1,4,5**;Jul 31, 2013;Build 6
 ;
ED ;[EE Abstract Edit Primary]
 W @IOF,!
 S DIC="^ONCO(165.5,",DIC(0)="AEQZM"
 S DIC("A")=" Select primary or patient name: "
 D ^DIC K DIC G EX:Y<0
 S ONCOD0P=+Y
 S ONCOD0=$P(^ONCO(165.5,+Y,0),U,2)
 S ONCONM=$$GET1^DIQ(160,ONCOD0,.01,"E")
 S ONCOEDIT=1
 ;
EN N CHECKVER
 S ONCOYR=($$TNMED^ONCOU55(ONCOD0P)>3)
 S ABSTAT=$P($G(^ONCO(165.5,ONCOD0P,7)),U,2)
 S CHECKSUM=$P($G(^ONCO(165.5,ONCOD0P,"EDITS")),U,1)
 S CHECKVER=$P($G(^ONCO(165.5,ONCOD0P,"EDITS")),U,2)
 I ABSTAT=3,((CHECKSUM="")!(CHECKVER<12)) D
 .W !,"Recalculating checksum..."
 .S EDITS="NO" S D0=ONCOD0P D NAACCR^ONCGENED K EDITS
 .S CHECKSUM=$$CRC32^ONCSNACR(.ONCDST)
 .S $P(^ONCO(165.5,ONCOD0P,"EDITS"),U,1)=CHECKSUM
 .S $P(^ONCO(165.5,ONCOD0P,"EDITS"),U,2)=EXTVER
 S DIE="^ONCO(165.5,",DA=ONCOD0P,DR="[ONCO ABSTRACT-I]",ONCOL1=0
 L +^ONCO(165.5,DA):0 I $T D ^DIE L -^ONCO(165.5,DA) S ONCOL1=1
 I 'ONCOL1 W !!,"This primary is being edited by another user" H 3 Q:'$D(ONCOEDIT)  K ONCOL1 G ED
 ;I $D(Y) G EN
 S ABSTAT=$P($G(^ONCO(165.5,ONCOD0P,7)),U,2)
 I ABSTAT'=3 D
 .S DIE="^ONCO(165.5,"
 .S DA=ONCOD0P
 .S DR="197///@"
 .D ^DIE
 I ABSTAT=3 D CHANGE^ONCGENED I $G(Y)="@0" G EN
 D FOL^ONCOAI
 I CHECKSUM'=$P($G(^ONCO(165.5,ONCOD0P,"EDITS")),U,1) D
 .N ONCDTTIM
 .D NOW^%DTC S ONCDTTIM=%
 .S DIE="^ONCO(165.5,",DA=ONCOD0P,DR="198///^S X=ONCDTTIM" D ^DIE
 K ONCOL1,LYMPHOMA,RFDEF,TFDEF,DFDEF
 I $D(ONCOOUT) Q
 I $D(Y) Q:'$D(ONCOEDIT)  G ED
 Q
 ;
PAIR ;LATERALITY (165.5,28)
 D TOPNAM
 S DATEDX=$P($G(^ONCO(165.5,D0,0)),U,16)
 Q:TOP=""
 I TOP=67342,$P(^ONCO(165.5,D0,2),U,8)="" S $P(^ONCO(165.5,D0,2),U,8)=1 Q
 S PO=$P($G(^ONCO(164,TOP,0)),U,7)
 I PO="",$P(^ONCO(165.5,D0,2),U,8)="" S $P(^ONCO(165.5,D0,2),U,8)=0
 I DATEDX<3040000,(TOP=67700)!(TOP=67710)!(TOP=67711)!(TOP=67712)!(TOP=67713)!(TOP=67714)!(TOP=67722)!(TOP=67723)!(TOP=67724)!(TOP=67725),$P(^ONCO(165.5,D0,2),U,8)="" S $P(^ONCO(165.5,D0,2),U,8)=0
 K PO
 ;
 ;Stuff TEXT-PRIMARY SITE TITLE (165.5,100)
 S TEXT=$P($G(^ONCO(164,TOP,0)),U,1)
 S:$P($G(^ONCO(165.5,D0,8)),U,1)="" $P(^ONCO(165.5,D0,8),U,1)=TEXT
 K TEXT
 Q
 ;
HISTXT ;Stuff TEXT-HISTOLOGY TITLE (165.5,101)
 S HSTI=$$HIST^ONCFUNC(D0,.HSTFLD,.HISTNAM)
 S TEXT=HISTNAM
 S:$P($G(^ONCO(165.5,D0,8)),U,2)="" $P(^ONCO(165.5,D0,8),U,2)=$E(TEXT,1,100)
 K HSTI,TEXT
 D:$P($G(^ONCO(165.5,D0,0)),U,16)>3031231 ^ONCCS2
 Q
 ;
MEN ;Primary Menu Options
 K DXS,ONCOOUT,DASHES,PATNAM,SITEGP,SSN
 S $P(DASHES,"-",80)="-"
 S NODE0=^ONCO(165.5,D0,0)
 S S=$P(NODE0,U,1),SITEGP=$P(^ONCO(164.2,S,0),U,1)
 S Y=$P(NODE0,U,2),C=$P(^DD(165.5,.02,0),U,2) D Y^DIQ S PATNAM=Y
 S SAVED0=D0 S D0=$P(NODE0,U,2) D SSN^ONCOES S SSN=X,D0=SAVED0
 S DATEDX=$P(NODE0,U,16)
 D ^ONCPHC
 S COC=$E($$GET1^DIQ(165.5,D0,.04),1,2)
 S OSP=$O(^ONCO(160.1,"C",DUZ(2),0))
 I OSP="" S OSP=$O(^ONCO(160.1,0))
 S IIN=$P($G(^ONCO(160.1,OSP,1)),U,4)
 S RH=$P($G(^ONCO(160.19,IIN,0)),U,2)
 K OSP
 D TOPNAM
 W @IOF
 W !,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 W !,?25,"Primary Menu Options",!,DASHES
 W !?22,"1. Patient Identification"
 W !?22,"2. Cancer Identification"
 W !?22,"3. Stage of Disease at Diagnosis"
 W !?22,"   Collaborative Staging (2004+ cases)"
 W !?22,"4. First Course of Treatment"
 W !?22,"5. Performance Measures"
 W !?22,"6. Over-ride Flags"
 W !?22,"7. Case Administration"
 W !?22,"8. EDIT Modifiers"
 W !?22,"9. User-Defined Fields"
 W !!?22,"A  All - Complete Abstract"
 ;
A K ONCOANS,X,Y
 R !!?25,"Enter option: All//",X:DTIME
 S:X="" (ONCOANS,X)="A"
 G:X["?" HP
 I X=U!'$T S Y="",ONCOOUT=U Q
 I (X="A")!(X="ALL")!(X="all")!(X="All") S ONCOANS="A",Y=1 G Y
 I X="CS",$P($G(^ONCO(165.5,D0,0)),U,16)>3039999 S ONCOANS=3,Y=292 G Y
 S (ONCOANS,Y)=X I X<1!(X>9) W "??" G A
 ;
Y S Y="@"_Y
 Q
 ;
HP W !!,?10,"Select 'A' for the complete abstract"
 W !?10,"Select 1-9 for the desired subsection",!
 G A
 ;
PAT ;Patient Identification
 S SECTION="Patient Identification" D SECTION
 K DXS,DIOT D PI^ONCPCI
 Q
 ;
CAN S SECTION="Cancer Identification" D SECTION
 D PAIR
 K DXS,DIOT S D0=ONCOD0P D CI^ONCPCI
 Q
 ;
EXT S SECTION="Stage of Disease at Diagnosis" D SECTION
 S SY="@31"
 S S=$P(^ONCO(165.5,D0,0),U,1)
 S T=$P($G(^ONCO(165.5,D0,2)),U,1)
 S H=$$HIST^ONCFUNC(D0)
 I (S=35)!($$LEUKEMIA^ONCOAIP2(D0))!((S>64)&(S<71)) D  G PSD
 .I $P($G(^ONCO(165.5,D0,0)),U,16)>3111231,$E(T,3,4)=77,H=98233 Q
 .;I H=97613,S=77 Q
 .S N=$S($E(H,1,4)=9731:"999^10^9",1:"999^80^9") ;Plasmacytoma, NOS
 .S N=$S(S=65:"999^99^9^99^99^9^9^9^9",1:N_"^99^99^9^9^9^7") ;Unk primary
 .I (T=67422)&(L'=1)&(H'=91403) S $P(N,U,2)=99,$P(N,U,9)=9   ;Spleen
 .S $P(^ONCO(165.5,D0,2),U,9,17)=N
 .D NOSTAGE
 .;S SY="@313"  ;skip to Other Staging System (165.5,39)
 .S SY=227,ONCSKP39=1  ;ONC*2.2*5 goto field (165.5,227) then skip to 39
 .I S=65 W !?18,"====> UNKNOWN PRIMARY - No EOD/TNM coding <====" Q
 .W !?18,"====> SYSTEMIC DISEASE - No EOD/TMN coding <===="
 ;
PSD K DXS,DIOT S D0=ONCOD0P D ^ONCPSD K DXS
 S Y=SY
 Q
 ;
NOSTAGE ;No staging
 S $P(^ONCO(165.5,D0,2),U,25)=88   ;37.1 CT
 S $P(^ONCO(165.5,D0,2),U,26)=88   ;37.2 CN
 S $P(^ONCO(165.5,D0,2),U,27)=88   ;37.3 CM
 S $P(^ONCO(165.5,D0,2),U,20)=88   ;38   C Stage Group
 S $P(^ONCO(165.5,D0,3),U,32)=8    ;19   Staged By (C)
 S $P(^ONCO(165.5,D0,7),U,17)="N"  ;69.4 Multimodality Therapy (P)
 S $P(^ONCO(165.5,D0,2.1),U,1)=88  ;85   PT
 S $P(^ONCO(165.5,D0,2.1),U,2)=88  ;86   PN
 S $P(^ONCO(165.5,D0,2.1),U,3)=88  ;87   PM
 S $P(^ONCO(165.5,D0,2.1),U,4)=88  ;88   P Stage Group
 S $P(^ONCO(165.5,D0,2.1),U,5)=8   ;89   Staged By (P)
 S $P(^ONCO(165.5,D0,2),U,28)="NA" ;38.5 Stage Grouping-AJCC
 S:$P($G(^ONCO(165.5,D0,7)),U,7)="" $P(^ONCO(165.5,D0,7),U,7)="0000000"
 S:$P($G(^ONCO(165.5,D0,7)),U,14)="" $P(^ONCO(165.5,D0,7),U,14)="0000000"
 Q
 ;
FST S SECTION="First Course of Treatment" D SECTION
 Q
 ;
ORF S SECTION="Over-ride Flags" D SECTION
 K DXS,DIOT D ^ONCORF
 Q
 ;
NTX ;DATE OF NO TREATMENT (165.5,124)
 I '$D(NTDD) S Y="@425" Q
 K NTDD
 W !!?5,"You have entered a DATE OF NO TREATMENT.  All treatment fields"
 W !?5,"will be stuffed with the appropriate value indicating no"
 W !?5,"treatment.",!
 K DIR S DIR("A")="Are you sure you want to do this",DIR("B")="No"
 S DIR(0)="Y" D ^DIR
 I (Y=0)!(Y="") D  S Y=124 W ! Q
 .S TXDT=$P(^ONCO(165.5,D0,2.1),U,11)_"N"
 .K ^ONCO(165.5,"ATX",D0,TXDT)
 .S $P(^ONCO(165.5,D0,2.1),U,11)=""
 I Y[U S $P(^ONCO(165.5,D0,2.1),U,11)="",Y="@0" Q
 S NTX="" D NTX^ONCNTX K NTX
 Q
 ;
RS ;RADIATION/SURGERY SEQUENCE (165.5,51.3)
 Q:$P($G(^ONCO(165.5,D0,3)),U,7)'=""
 S S=$E($$GET1^DIQ(165.5,D0,58.6,"E"),1,2)
 S SATF=$E($$GET1^DIQ(165.5,D0,58.7,"E"),1,2)
 S SCP=$P($G(^ONCO(165.5,D0,3.1)),U,31)
 S SCPATF=$P($G(^ONCO(165.5,D0,3.1)),U,32)
 S SOTH=$P($G(^ONCO(165.5,D0,3.1)),U,33)
 S SOTHATF=$P($G(^ONCO(165.5,D0,3.1)),U,34)
 S R=$$GET1^DIQ(165.5,D0,51.2,"I")
 S RATF=$$GET1^DIQ(165.5,D0,51.4,"I")
 I ((S="00")!(S=99)!(S=98)!(S=""))&((SATF="00")!(SATF=99)!(SATF=98)!(SATF=""))&((SCP=0)!(SCP="")!(SCP=9))&((SCPATF=0)!(SCPATF="")!(SCPATF=9))&((SOTH=0)!(SOTH=""))&((SOTHATF=0)!(SOTHATF="")) S SR=0
 E  S SR=1
 I ((R=0)!(R=7)!(R=8)!(R=9)!(R=""))&((RATF=0)!(RATF=7)!(RATF=8)!(RATF=9)!(RATF="")) S R=0
 E  S R=1
 I ($G(SR)&$G(R)) D  K S,SATF,SCP,SCPATF,SOTH,SOTHATF,R,RATF,SR,SDT,SATFDT,SCPDT,SCPATFDT,SOTDT,SOTATFDT,RDT,RATFDT,RSSEQ,FSDT,FRDT
 .S SDT=$P($G(^ONCO(165.5,D0,3)),U,1)
 .S:SDT'="" RSSEQ("S",SDT)="S",RSSEQ(SDT)="S"
 .S SATFDT=$P($G(^ONCO(165.5,D0,3.1)),U,8)
 .S:SATFDT'="" RSSEQ("S",SATFDT)="S",RSSEQ(SATFDT)="S"
 .S SCPDT=$P($G(^ONCO(165.5,D0,3.1)),U,22)
 .S:SCPDT'="" RSSEQ("S",SCPDT)="S",RSSEQ(SCPDT)="S"
 .S SCPATFDT=$P($G(^ONCO(165.5,D0,3.1)),U,23)
 .S:SCPATFDT'="" RSSEQ("S",SCPATFDT)="S",RSSEQ(SCPATFDT)="S"
 .S SOTDT=$P($G(^ONCO(165.5,D0,3.1)),U,24)
 .S:SOTDT'="" RSSEQ("S",SOTDT)="S",RSSEQ(SOTDT)="S"
 .S SOTATFDT=$P($G(^ONCO(165.5,D0,3.1)),U,25)
 .S:SOTATFDT'="" RSSEQ("S",SOTATFDT)="S",RSSEQ(SOTATFDT)="S"
 .S RDT=$P($G(^ONCO(165.5,D0,3)),U,4)
 .S:RDT'="" RSSEQ("R",RDT)="R",RSSEQ(RDT)="R"
 .S RATFDT=$P($G(^ONCO(165.5,D0,3.1)),U,13)
 .S:RATFDT'="" RSSEQ("R",RATFDT)="R",RSSEQ(RATFDT)="R"
 .S FSDT=$O(RSSEQ("S",0)),FRDT=$O(RSSEQ("R",0))
 .I FSDT=FRDT Q 
 .S RSSEQ=$O(RSSEQ(0))
 .I RSSEQ(RSSEQ)="R" S $P(^ONCO(165.5,D0,3),U,7)=2
 .I RSSEQ(RSSEQ)="S" S $P(^ONCO(165.5,D0,3),U,7)=3
 E  D
 .S $P(^ONCO(165.5,D0,3),U,7)=0
 Q
 ;
AB ;Abstract Status
 S SECTION="Case Administration" D SECTION
 N DI,DIC,DR,DA,DIQ,ONC,ONCDTEMP
 S DIC="^ONCO(165.5,"
 S DR="90:92;198;199;155;157.1;236;244"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 S X=ONC(165.5,D0,91) D UCASE^ONCPCI S ONC(165.5,D0,91)=X
 S X=ONC(165.5,D0,157.1) D UCASE^ONCPCI S ONC(165.5,D0,157.1)=X
 W !," Abstract Status.............: ",ONC(165.5,D0,91)
 W !," Date Case Initiated.........: ",ONC(165.5,D0,236)
 W !," Initiated By................: ",ONC(165.5,D0,244)
 W !," Date of First Contact.......: ",ONC(165.5,D0,155)
 W !," Date Case Completed.........: " S ONCDTEMP=$P($G(^ONCO(165.5,D0,7)),U,1) W $$FMTE^XLFDT(ONCDTEMP,"5P")
 W !," Elapsed Days to Completion..: ",$$GET1^DIQ(165.5,D0,157,"E")
 ;W !," Elapsed Months to Completion: ",ONC(165.5,D0,157.1)
 W !," Abstracted by...............: ",ONC(165.5,D0,92)
 W !," Date Case Last Changed......: " S ONCDTEMP=$P($G(^ONCO(165.5,D0,7)),U,21) W $$FMTE^XLFDT(ONCDTEMP,"5P")
 W !," Case Last Changed by........: ",ONC(165.5,D0,199)
 W !,DASHES
 Q
 ;
NAN ;NEW ACC #
 K DIR S DIR(0)="N^:"_($E(DT,1,3)+1700),DIR("A")="YEAR of Accession Number: ",DIR("B")=($E(DT,1,3)+1700) W !! D ^DIR Q:(Y=U)!(Y="")
NA S YR=Y,MR=YR_"0001",XR=999999-((YR+1)_"0000"),NR=$O(^ONCO(165.5,"AF",XR))
 I NR<(990002-MR) W !!?5,"SYSTEM appears out of numbers-looking for unassigned ones" G FND
 I NR>(999999-MR) S NR=""
 S AC=$S(NR="":YR_"0001",1:(1000000-NR)),SEQ="00"
 Q
 ;
FND ;SEARCH for unused #s
 S NR=YR_"0000",MR=(YR+1)_"0000"
NR S NR=NR+1 I NR<MR G:$D(^ONCO(165.5,"AA",NR)) NR S AC=NR,SEQ="00" Q
 W !!?10,"OUT of ACCESSION Numbers for 19"_YR S Y=U
 Q
 ;
TOPNAM ;PRIMARY SITE and PRIMARY SITE CODE for header
 K SITTAB
 S TOP=$P($G(^ONCO(165.5,D0,2)),U,1),TOPCOD="",TOPNAM=""
 I TOP'="" S TOPNAM=$P($G(^ONCO(164,TOP,0)),U,1),TOPCOD=$P($G(^ONCO(164,TOP,0)),U,2)
 S SITTAB=79-$L(SITEGP),TOPTAB=79-$L(TOPNAM_" "_TOPCOD)
 S NOS=TOPTAB-$L(PATNAM),NOS=NOS-1 K SPACES S $P(SPACES," ",NOS)=" "
 Q
 ;
SECTION S HDL=$L(SECTION),TAB=(80-HDL)\2,TAB=TAB-1
 W @IOF,DASHES
 W !,?1,PATNAM,?TAB,SECTION,?SITTAB,SITEGP
 W !,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD
 W !,DASHES
 Q
 ;
EX ;Exit
 D KILL^ONCOAI
 K ABSTAT,AC,C,CHECKSUM,D0,DASHES,DATEDX,DIE,H,HDL,HISTNAM,HSTFLD,IIN
 K L,MR,N,NODE0,NOS,NR,ONCDST,ONCOD0,ONCOD0P,ONCOEDIT,ONCONM,ONCOYR
 K PATNAM,RH,SAVED0,SECTION,SEQ,SITEGP,SITTAB,SSN,SY,T,TAB
 K TOP,TOPCOD,TOPNAM,TOPTAB,TXDT,X,XR,YR
 Q
 ;
CLEANUP ;Cleanup
 K COC,EXTVER
