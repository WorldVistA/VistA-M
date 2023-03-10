ONCPTX ;HINES OIFO/GWB - First Course of Treatment ;10/05/11
 ;;2.2;ONCOLOGY;**1,5,6,10,15**;Jul 31, 2013;Build 5
 ;
 N DATEDX
 S DATEDX=$P($G(^ONCO(165.5,D0,0)),U,16)
 ;
NCDS ;Surgical Diagnostic and Staging Procedure
 N COC,TXDT
 S COC=$E($$GET1^DIQ(165.5,D0,.04,"E"),1,2)
 I COC=38 D
 .S $P(^ONCO(165.5,D0,3),U,27)="00"
 .S $P(^ONCO(165.5,D0,3.1),U,5)="00"
 .S $P(^ONCO(165.5,D0,3),U,31)="0000000"
 .S $P(^ONCO(165.5,D0,3.1),U,6)="0000000"
 .S:$P($G(^ONCO(165.5,D0,0)),U,16)>3091239 $P(^ONCO(165.5,D0,2.3),U,5)=0
 .I $P(^ONCO(165.5,D0,2.1),U,11)'="" D
 ..S TXDT=$P(^ONCO(165.5,D0,2.1),U,11)_"N"
 ..S $P(^ONCO(165.5,D0,2.1),U,11)=""
 ..K ^ONCO(165.5,"ATX",D0,TXDT)
 N DASHES S $P(DASHES,"-",80)="-"
 N DA,DI,DIC,DIQ,DR K ONC
 S DIC="^ONCO(165.5,"
 S DR="58.1;58.3;58.4;58.5;235;281;228;229;230;231;232;124"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 F I=58.1,58.4,235,281 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 D FST^ONCOAIP
 W !," SURGICAL DIAGNOSTIC AND STAGING PROCEDURE"
 W !," -----------------------------------------"
 S TXT=ONC(165.5,D0,58.1),LEN=38 D TXT
 W !," Surgical Dx/Staging Proc.....: ",$E(ONC(165.5,D0,58.3),1,6)_$E(ONC(165.5,D0,58.3),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 S TXT=ONC(165.5,D0,58.4),LEN=38 D TXT
 W !," Surg Dx/Staging Proc @fac....: ",$E(ONC(165.5,D0,58.5),1,6)_$E(ONC(165.5,D0,58.5),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 W !!," Tx Guidelines Discussion.....: ",ONC(165.5,D0,281)
 S TXGL=""
 I ONC(165.5,D0,228)'="" S TXGL=ONC(165.5,D0,228)
 I ONC(165.5,D0,229)'="" S TXGL=TXGL_"/"_ONC(165.5,D0,229)
 I ONC(165.5,D0,230)'="" S TXGL=TXGL_"/"_ONC(165.5,D0,230)
 W !," Treatment Guideline(s).......: ",TXGL
 W:TXGL'="" !," Treatment Guideline Location.: ",ONC(165.5,D0,231)
 W:TXGL'="" !," Treatment Guideline Doc Date.: ",ONC(165.5,D0,232)
 W:DATEDX>3091231 !!," Treatment Status.............: ",ONC(165.5,D0,235)
 W:ONC(165.5,D0,124)'="" !," Date of No Treatment.........: ",ONC(165.5,D0,124)
 W !,DASHES
 I COC=38 D ^ONCOCC
 D EXIT
 Q
 ;
ROADS ;Surgical Procedures (ROADS)
 N DASHES S $P(DASHES,"-",80)="-"
 N DI,DIC,DR,DA,DIQ K ONC
 S DIC="^ONCO(165.5,"
 S DR="50;58.6;50.3;58.7;59;138:138.5;139:139.5;435;14;58;23;74;58.2;50.2;140;140.1"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 F I=58.6,58.7,59,138,138.1,138.4,138.5,139,139.1,139.4,139.5,435,14,58,23,74,58.2,50.2,140,140.1 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 D FST^ONCOAIP
 ;W !," SURGICAL PROCEDURES (ROADS)"
 W !," Pre-2003 cases require the following ROADS surgery items to be coded:"
 W !,DASHES
 S TXT=ONC(165.5,D0,58.2),LEN=48 D TXT
 W !," Surgery of primary........(R): ",TXT1 W:TXT2'="" !?32,TXT2
 W !," Surgical Approach.........(R): ",ONC(165.5,DA,74)
 S TXT=ONC(165.5,D0,50.2),LEN=48 D TXT
 W !," Surgery of primary @fac...(R): ",TXT1 W:TXT2'="" !?32,TXT2
 S TXT=ONC(165.5,D0,138),LEN=48 D TXT
 W !," Scope of ln surgery.......(R): ",TXT1 W:TXT2'="" !?32,TXT2
 W !," Number of LN removed..... (R): ",ONC(165.5,D0,140)
 S TXT=ONC(165.5,D0,138.1),LEN=48 D TXT
 W !," Scope of ln surgery @fac..(R): ",TXT1 W:TXT2'="" !?32,TXT2
 W !," Number of LN removed @fac.(R): ",ONC(165.5,D0,140.1)
 S TXT=ONC(165.5,D0,139),LEN=48 D TXT
 W !," Surg proc/other site......(R): ",TXT1 W:TXT2'="" !?32,TXT2
 S TXT=ONC(165.5,D0,139.1),LEN=48 D TXT
 W !," Surg proc/other site @fac.(R): ",TXT1 W:TXT2'="" !?32,TXT2
 W !,DASHES
 D EXIT
 Q
 ;
FORDS ;Surgical Procedures (FORDS)
 N DASHES S $P(DASHES,"-",80)="-"
 S TOPX=$P($G(^ONCO(165.5,D0,2)),U,1)
 I (TOPX=67420)!(TOPX=67421)!(TOPX=67423)!(TOPX=67424)!($E(TOPX,3,4)=76)!(TOPX=67809) D
 .S $P(^ONCO(165.5,D0,3.1),U,29)=1
 .S $P(^ONCO(165.5,D0,3),U,1)="0000000"
 N DI,DIC,DR,DA,DIQ K ONC
 S DIC="^ONCO(165.5,"
 S DR="50;58.6;50.3;58.7;59;138:138.5;139:139.7;435;14;58;23;74;58.2;50.2;140;140.1;170;46;47;234"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 F I=58.6,58.7,59,138,138.1,138.4,138.5,139,139.1,139.4,139.5,139.6,435,14,58,23,74,58.2,50.2,140,140.1,234,46,47 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 D FST^ONCOAIP
 ;W !," SURGICAL PROCEDURES (FORDS)"
 ;W !," ---------------------------"
 S TXT=ONC(165.5,D0,58.6),LEN=38 D TXT
 W !," Surgery of primary........(F): ",$E(ONC(165.5,D0,50),1,6)_$E(ONC(165.5,D0,50),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 S TXT=ONC(165.5,D0,58.7),LEN=38 D TXT
 W !," Surgery of primary @fac...(F): ",$E(ONC(165.5,D0,50.3),1,6)_$E(ONC(165.5,D0,50.3),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 W !," Surgical margins.............: ",ONC(165.5,DA,59)
 W:DATEDX>3091231 !," RX Hosp--Surg App 2010.......: ",ONC(165.5,DA,234)
 S TXT=ONC(165.5,D0,138.4),LEN=38 D TXT
 W !," Scope of ln surgery.......(F): ",$E(ONC(165.5,D0,138.2),1,6)_$E(ONC(165.5,D0,138.2),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 S TXT=ONC(165.5,D0,138.5),LEN=38 D TXT
 W !," Scope of ln surgery @fac..(F): ",$E(ONC(165.5,D0,138.3),1,6)_$E(ONC(165.5,D0,138.3),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 S TXT=ONC(165.5,D0,139.4),LEN=38 D TXT
 W !," Surg proc/other site......(F): ",$E(ONC(165.5,D0,139.2),1,6)_$E(ONC(165.5,D0,139.2),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 S TXT=ONC(165.5,D0,139.6),LEN=38 D TXT
 W !," METS site resected...........: ",$E(ONC(165.5,D0,139.7),1,6)_$E(ONC(165.5,D0,139.7),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 S TXT=ONC(165.5,D0,139.5),LEN=38 D TXT
 W !," Surg proc/other site @fac.(F): ",$E(ONC(165.5,D0,139.3),1,6)_$E(ONC(165.5,D0,139.3),9,10),?41,TXT1
 W:TXT2'="" !?41,TXT2
 W !," Date First Surgical Procedure: ",$E(ONC(165.5,D0,170),1,6)_$E(ONC(165.5,D0,170),9,10)
 S TXT=ONC(165.5,D0,23),LEN=38 D TXT
 W:DATEDX<3030000 !," Reconstruction/restoration...: ",TXT1
 W:TXT2'="" !?41,TXT2
 W !," Date of surgical discharge...: ",$E(ONC(165.5,D0,435),1,6)_$E(ONC(165.5,D0,435),9,10)
 W !," Readmission w/i 30 days/surg.: ",ONC(165.5,D0,14)
 W !," Reason no surgery of primary.: ",ONC(165.5,D0,58)
 W !," CAP Protocol Review..........: ",ONC(165.5,D0,46)
 W:ONC(165.5,D0,46)="FAILED" !," CAP Text.....................: ",ONC(165.5,D0,47)
 W !,DASHES
 D EXIT
 Q
 ;
RAD ;Radiation
 D FST^ONCOAIP
 N DASHES S $P(DASHES,"-",80)="-"
 N DI,DIC,DR,DA,DIQ K ONC
 S DIC="^ONCO(165.5,"
 S DR="51;51.2;51.3;51.4;51.5;56;75;125;126;363;442;363.1;443;361;5501:5527;7024:7026"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 F I=51.2,126,125,363,363.1,56,51.3,51.4,75,442,443 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 F I=5501,5502,5503,5504,5505,5506,5507,5511,5512,5513,5514,5515,5516,5517,5521,5522,5523,5524,5525,5526,5527,7024,7025,7026 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 I $P($G(^ONCO(165.5,D0,0)),"^",16)<3180101 W !," Radiation....................: ",ONC(165.5,DA,51.2)
 W !," Date radiation started.......: ",ONC(165.5,DA,51)
 I $P($G(^ONCO(165.5,D0,0)),"^",16)<3180101 W !," Radiation @fac...............: ",ONC(165.5,DA,51.5)," ",ONC(165.5,DA,51.4)
 W !," Location of radiation tx.....: ",ONC(165.5,DA,126)
 I $P($G(^ONCO(165.5,D0,0)),"^",16)<3180101 D
 .W !," Radiation treatment volume...: ",ONC(165.5,DA,125)
 .W !," Regional treatment modality..: ",ONC(165.5,DA,363)
 .W !," Regional dose:cGy............: ",ONC(165.5,DA,442)
 .W !," Boost treatment modality.....: ",ONC(165.5,DA,363.1)
 .W !," Boost dose:cGy...............: ",ONC(165.5,DA,443)
 .W !," Number of txs to this volume.: ",ONC(165.5,DA,56)
 I $P($G(^ONCO(165.5,D0,0)),"^",16)>3171231 D
 .W !," Phase I rad treatment volume...........: ",ONC(165.5,DA,5504)
 .W !," Phase I rad to draining lymph nodes....: ",ONC(165.5,DA,5505)
 .W !," Phase I treatment modality.............: ",ONC(165.5,DA,5506)
 .W !," Phase I rad external beam planning.....: ",ONC(165.5,DA,5502)
 .W !," Phase I dose per fraction..............: ",ONC(165.5,DA,5501)
 .W !," Phase I number of fractions............: ",ONC(165.5,DA,5503)
 .W !," Phase I total dose.....................: ",ONC(165.5,DA,5507)
 .I ONC(165.5,DA,5514)'="" W !," Phase II rad treatment volume..........: ",ONC(165.5,DA,5514)
 .I ONC(165.5,DA,5515)'="" W !," Phase II rad to draining lymph nodes...: ",ONC(165.5,DA,5515)
 .I ONC(165.5,DA,5516)'="" W !," Phase II treatment modality............: ",ONC(165.5,DA,5516)
 .I ONC(165.5,DA,5512)'="" W !," Phase II rad external beam planning....: ",ONC(165.5,DA,5512)
 .I ONC(165.5,DA,5511)'="" W !," Phase II dose per fraction.............: ",ONC(165.5,DA,5511)
 .I ONC(165.5,DA,5513)'="" W !," Phase II number of fractions...........: ",ONC(165.5,DA,5513)
 .I ONC(165.5,DA,5517)'="" W !," Phase II total dose....................: ",ONC(165.5,DA,5517)
 .I ONC(165.5,DA,5524)'="" W !," Phase III rad treatment volume.........: ",ONC(165.5,DA,5524)
 .I ONC(165.5,DA,5525)'="" W !," Phase III rad to draining lymph nodes..: ",ONC(165.5,DA,5525)
 .I ONC(165.5,DA,5526)'="" W !," Phase III treatment modality...........: ",ONC(165.5,DA,5526)
 .I ONC(165.5,DA,5522)'="" W !," Phase III rad external beam planning...: ",ONC(165.5,DA,5522)
 .I ONC(165.5,DA,5521)'="" W !," Phase III dose per fraction............: ",ONC(165.5,DA,5521)
 .I ONC(165.5,DA,5523)'="" W !," Phase III number of fractions..........: ",ONC(165.5,DA,5523)
 .I ONC(165.5,DA,5527)'="" W !," Phase III total dose...................: ",ONC(165.5,DA,5527)
 .W !," Number of Phases Rad TX to this Volume.: ",ONC(165.5,DA,7024)
 .W !," Radiation Treatment Disc Early.........: ",ONC(165.5,DA,7025)
 .W !," Total Dose.............................: ",ONC(165.5,DA,7026)
 W !," Radiation/surgery sequence...: ",ONC(165.5,DA,51.3)
 W !," Date radiation ended.........: ",ONC(165.5,DA,361)
 W !," Reason for no radiation......: ",ONC(165.5,DA,75)
 W !,DASHES
 D EXIT
 Q
 ;
ST ;Systemic Therapy
 D FST^ONCOAIP
 N DASHES S $P(DASHES,"-",80)="-"
 ;W !," SYSTEMIC THERAPY"
 ;W !," ----------------"
 N DI,DIC,DR,DA,DIQ K ONC
 S DIC="^ONCO(165.5,"
 S DR="152;53;53.2;53.3;53.4;54;54.2;54.3;54.4;55;55.2;55.3;55.4;153:153.3;15;1423:1423.4"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 F I=53.2,53.3,54.2,54.3,55.2,55.3,153,153.2,15 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 W !," Date systemic therapy started.: ",ONC(165.5,DA,152)
 W !," Chemotherapy..................: ",ONC(165.5,DA,53)," ",$E(ONC(165.5,DA,53.2),1,34)
 W !," Chemotherapy @fac.............: ",ONC(165.5,DA,53.4)," ",$E(ONC(165.5,DA,53.3),1,34)
 W:ONC(165.5,DA,1423)'="" !," Chemotherapeutic agent #1.....: ",ONC(165.5,DA,1423)
 W:ONC(165.5,DA,1423.1)'="" !," Chemotherapeutic agent #2.....: ",ONC(165.5,DA,1423.1)
 W:ONC(165.5,DA,1423.2)'="" !," Chemotherapeutic agent #3.....: ",ONC(165.5,DA,1423.2)
 W:ONC(165.5,DA,1423.3)'="" !," Chemotherapeutic agent #4.....: ",ONC(165.5,DA,1423.3)
 W:ONC(165.5,DA,1423.4)'="" !," Chemotherapeutic agent #5.....: ",ONC(165.5,DA,1423.4)
 W !," Hormone therapy...............: ",ONC(165.5,DA,54)," ",$E(ONC(165.5,DA,54.2),1,34)
 W !," Hormone therapy @fac..........: ",ONC(165.5,DA,54.4)," ",$E(ONC(165.5,DA,54.3),1,34)
 W !," Immunotherapy.................: ",ONC(165.5,DA,55)," ",$E(ONC(165.5,DA,55.2),1,34)
 W !," Immunotherapy @fac............: ",ONC(165.5,DA,55.4)," ",$E(ONC(165.5,DA,55.3),1,34)
 W !," Hema Trans/Endocrine Proc.....: ",ONC(165.5,DA,153.1)," ",$E(ONC(165.5,DA,153),1,34)
 W !," Hema Trans/Endocrine Proc @fac: ",ONC(165.5,DA,153.3)," ",$E(ONC(165.5,DA,153.2),1,34)
 W:DATEDX>3051231 !," Systemic/Surgery Sequence.....: ",ONC(165.5,DA,15)
 W !,DASHES
 D EXIT
 Q
 ;
OTH ;Other Treatment
 D FST^ONCOAIP
 N DASHES S $P(DASHES,"-",80)="-"
 ;W !," OTHER TREATMENT"
 ;W !," ---------------"
 N DI,DIC,DR,DA,DIQ K ONC
 S DIC="^ONCO(165.5,"
 S DR="57;57.2;57.3;57.4"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 F I=57,57.2,57.3,57.4 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 W !," Other treatment...............: ",ONC(165.5,DA,57)," ",ONC(165.5,DA,57.2)
 W !," Other treatment @fac..........: ",ONC(165.5,DA,57.4)," ",ONC(165.5,DA,57.3)
 W !,DASHES
 D EXIT
 Q
 ;
PRO ;Palliative Care/Protocol Participation
 D FST^ONCOAIP
 N DASHES S $P(DASHES,"-",80)="-"
 ;W !," PALLIATIVE CARE/PROTOCOL PARTICIPATION"
 ;W !," -------------------------------------------"
 N DI,DIC,DR,DA,DIQ K ONC
 S DIC="^ONCO(165.5,"
 S DR="133;560;154;12;13;346;279"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 F I=560,154,12,13,346,279 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 W !," Palliative care...............: ",ONC(165.5,DA,12)
 W !," Palliative care @fac..........: ",ONC(165.5,DA,13)
 W !
 W !," Clinical Trials Discussion....: "_ONC(165.5,DA,279)
 W !
 W !," Protocol eligibility status...: "_ONC(165.5,DA,346)
 W !," Protocol participation........: "_ONC(165.5,DA,560)
 W !," Year put on protocol..........: "_ONC(165.5,DA,133)
 W !,DASHES
 D EXIT
 Q
 ;
TXT ;Text formatting
 N LOS,NOP
 S (TXT1,TXT2)="",LOS=$L(TXT) I LOS<LEN S TXT1=TXT Q
 S NOP=$L($E(TXT,1,LEN)," ")
 S TXT1=$P(TXT," ",1,NOP-1),TXT2=$P(TXT," ",NOP,999)
 Q
 ;
UCASE ;Mixed case to upper case conversion
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
 ;
EXIT ;KILL local varibles
 K I,LEN,ONC,TOPX,TXGL,TXT,TXT1,TXT2,X
 Q
 ;
CLEANUP ;Cleanup
 K D0
