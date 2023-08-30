ONCOAIP2 ;HINES OIFO/GWB,RTK - ONCO ABSTRACT-I SUB-ROUTINES ;04/12/01
 ;;2.2;ONCOLOGY;**1,4,5,6,10,12,13,17**;Jul 31, 2013;Build 6
 ;
LEUKEMIA(REC) ;Systemic diseases
 N H,HISTNAM,HSTFLD,ICDFILE,ICDNUM
 S L=0
 S H=$E($$HIST^ONCFUNC(REC,.HSTFLD,.HISTNAM,.ICDFILE,.ICDNUM),1,4)
 I ICDNUM=2 I ((H'<9720)&(H'>9732))!((H'<9760)&(H'>9989)) S L=1
 I ICDNUM=3 I ((H'<9731)&(H'>9734))!((H'<9750)&(H'>9989)) S L=1
 Q L
 ;
MO ;ASSOCIATED WITH HIV (165.5,41)
 S M=$$HIST^ONCFUNC(D0)
 S AWHFLG=0
 I $$LYMPHOMA^ONCFUNC(D0) S Y=41,AWHFLG=1 Q
 S M=$E(M,1,4)
 I M=9140 S Y=41
 E  S Y=227
 Q:Y=227  S $P(^ONCO(165.5,D0,2),U,9)=999
 K M
 Q
 ;
BLOOD ;PERIPHERAL BLOOD INVOLVEMENT (165.5,30.5)
 ; called from input transform -- only for Pre 2018 cases 
 ; Mycosis fungoides and Sezary's Disease (9700-9701)
 N CHK,TMP
 S TMP=$$HIST^ONCFUNC(DA),Y="@301"
 I '$D(DATEDX) Q
 I DATEDX>3171231 Q
 F CHK="97002","97003","97012","97013" I CHK=TMP S Y=30.5 Q
 Q
 ;
PGPE ;PATHOLOGIC EXTENSION (165.5,30.1)
 ;Prostate C61.9
 S Y="@231"
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3180000 D
 .N TMP S TMP=$P($G(^ONCO(165.5,DA,2)),U,1)
 .I TMP=67619 S Y=30.1 Q
 .S $P(^ONCO(165.5,DA,2.2),U,2)=""
 .Q
 Q
PGPE18 ;PROSTATE PATH EXT (165.5,3919)
 S Y="@3919"
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3171231 D
 .N TMP S TMP=$P($G(^ONCO(165.5,DA,2)),U,1)
 .I TMP=67619 D
 ..N DI,DIC,DR,DA,DIQ,ONC
 ..S DIC="^ONCO(165.5,",DR="30.1",DA=D0,DIQ="ONC" D EN^DIQ1
 ..W !,"*** Display of retired Pathologic Exension value for reference ***"
 ..W !," Pathologic Extension......: ",ONC(165.5,D0,30.1),!
 ..S Y=3919 Q
 .Q
 Q
 ;
LN ;BRAIN AND CEREBRAL MENINGES (SEER EOD)
 ;OTHER PARTS OF CENTRAL NERVOUS SYSTEM (SEER EOD)
 N T
 S T=$P($G(^ONCO(165.5,D0,2)),U,1)
 I (T=67700)!($E(T,3,4)=71)!($E(T,3,4)=72) D
 .I $P($G(^ONCO(165.5,D0,0)),U,16)<3160101 S $P(^ONCO(165.5,D0,2),U,11)=9
 .S $P(^ONCO(165.5,D0,2),U,12)=99 ;Regional Nodes Positive
 .S $P(^ONCO(165.5,D0,2),U,13)=99 ;Regional Nodes Examined
 .I $P($G(^ONCO(165.5,D0,0)),U,16)<3160101 W !,"LYMPH NODES............: Not Applicable"
 .W !,"REGIONAL NODES EXAMINED: Unk; not stated; death cert only"
 .W !,"REGIONAL NODES POSITIVE: Unk if nodes + or -, NA"
 .I $P($G(^ONCO(165.5,D0,0)),U,16)<3180000 S Y="@26" Q
 .I $P($G(^ONCO(165.5,D0,0)),U,16)>3171231 S Y=1772 Q
 .Q
 ;else just exit back to code where called [in ABS edit template]
 Q
 ;
EDTMOD ;EXTRACT EDITS THAT NEED TO BE MANUALLY FIXED TO PASS
 S SECTION="EDITS Modifications" D SECTION^ONCOAIP
 N DI,DIC,DR,DA,DIQ,ONC
 S DIC="^ONCO(165.5,"
 S DR="999.1:999.99;7014;7018"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 ;S X=ONC(165.5,D0,91) D UCASE^ONCPCI S ONC(165.5,D0,91)=X
 W !," Address at DX--State........: ",ONC(165.5,D0,999.26),?40,"Address at DX--Country......: ",ONC(165.5,D0,999.27)
 W !," Address Current--State......: ",ONC(165.5,D0,999.28),?40,"Address Current--Country....: ",ONC(165.5,D0,999.29)
 W !," Address Current--Postal Code: ",ONC(165.5,D0,999.289)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3221231 D
 .W !?4,"*** THE DATE FLAG FIELDS ARE OBSOLETE FOR 2023+ CASES AND ***"
 .W !?4,"*** ARE NO LONGER ACCESSIBLE                              ***"
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3230000 D
 .W !!," Date of Diagnosis Flag......: ",ONC(165.5,D0,999.1),?40,"RX Date-Systemic Flag.......: ",ONC(165.5,D0,999.14)
 .W !," Date Conclusive DX Flag.....: ",ONC(165.5,D0,999.2),?40,"RX Date-Chemo Flag..........: ",ONC(165.5,D0,999.15)
 .W !," Date of Mult Tumors Flag....: ",ONC(165.5,D0,999.3),?40,"RX Date-Hormone Flag........: ",ONC(165.5,D0,999.16)
 .W !," Date of First Contact Flag..: ",ONC(165.5,D0,999.4),?40,"RX Date-BRM Flag............: ",ONC(165.5,D0,999.17)
 .W !," Date of Inpt Adm Flag.......: ",ONC(165.5,D0,999.5),?40,"RX Date-Other Flag..........: ",ONC(165.5,D0,999.18)
 .W !," Date of Inpt Disch Flag.....: ",ONC(165.5,D0,999.6),?40,"RX Date-DX/Stg Proc Flag....: ",ONC(165.5,D0,999.19)
 .W !," Date 1st CRS RX Flag........: ",ONC(165.5,D0,999.7),?40,"Recurrence Date-1st Flag....: ",ONC(165.5,D0,999.21)
 .W !," RX Date-Surgery Flag........: ",ONC(165.5,D0,999.8),?40,"Date of Last Contact Flag...: ",ONC(165.5,D0,999.22)
 .W !," RX Date-Mst Defn Srg Flag...: ",ONC(165.5,D0,999.9),?40,"Subsq RX 2nd Crs Date Flag..: ",ONC(165.5,D0,999.23)
 .W !," RX Date-Surg Disch Flag.....: ",ONC(165.5,D0,999.11),?40,"Subsq RX 3rd Crs Date Flag..: ",ONC(165.5,D0,999.24)
 .W !," RX Date-Radiation Flag......: ",ONC(165.5,D0,999.12),?40,"Subsq RX 4th Crs Date Flag..: ",ONC(165.5,D0,999.25)
 .W !," RX Date-Rad Ended Flag......: ",ONC(165.5,D0,999.13)
 .W !!," Date Regional LN Disx Flag..: ",ONC(165.5,D0,7014),?40,"Date Sentinel LN Biopsy Flag: ",ONC(165.5,D0,7018)
 W !,DASHES
 W !,"* * * These fields should ONLY be used to correct an EDIT that cannot * * *",!,"* * * be cleared.  Otherwise these fields should NOT be modified.     * * *"
 Q
 ;
UDFMOD ;ALLOW USERS TO ENTER/EDIT USER-DEFINED FIELDS
 S SECTION="User Defined Fields" D SECTION^ONCOAIP
 N DI,DIC,DR,DA,DIQ,ONC,OSPIEN
 S DIC="^ONCO(165.5,"
 S DR="284:285"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 W !," User Defined Field #1........: ",ONC(165.5,D0,284),?40," User Defined Field #2........: ",ONC(165.5,D0,284.1)
 W !," User Defined Field #3........: ",ONC(165.5,D0,284.2),?40," User Defined Field #4........: ",ONC(165.5,D0,284.3)
 W !," User Defined Field #5........: ",ONC(165.5,D0,284.4),?40," User Defined Field #6........: ",ONC(165.5,D0,284.5)
 W !," User Defined Field #7........: ",ONC(165.5,D0,284.6),?40," User Defined Field #8........: ",ONC(165.5,D0,284.7)
 W !," User Defined Field #9........: ",ONC(165.5,D0,284.8),?40," User Defined Field #10.......: ",ONC(165.5,D0,284.9)
 W !,DASHES
 Q
 ;
EXTLN ;Display retired <2018 EOD Extension & LN fields (removed this in P13) 
 Q
CLINTNM ;Display retired <2018 Clin TNM fields (removed this in P13)
 Q
PATHTNM ;Display retired <2018 Path TNM fields (removed this in P13)
 Q
RADRET ;Display retired <2018 Rad fields (removed this in P13)
 Q
RADSKP ;
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",1)'="" Q
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",2)'="" Q
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",3)'="" Q
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",4)'="" Q
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",5)'="" Q
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",6)'="" Q
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",7)'="" Q
 W ! S Y="@49"  ;if all 7 above = "" then skip PHASE II & III fields
 Q
RADSTF ;
 ;PART 1 IF = 00
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",4)=1 D  ;IF PHASE 1 RAD = 00
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",5)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",6)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",2)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",1)="00000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",3)="000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",7)="000000"
 .W !,"PHASE 1 RADIATION TREATMENT VOLUME...: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 1 RAD TO DRAINING LYMPH NODE...: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 1 RADIATION TREATMENT MODALITY.: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 1 RAD EXTERNAL BEAM PLAN TECH..: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 1 DOSE PER FRACTION............: 00000"
 .W !,"PHASE 1 NUMBER OF FRACTIONS..........: 000"
 .W !,"PHASE 1 TOTAL DOSE...................: 000000"
 .S $P(^ONCO(165.5,DA,"NCR18B"),U,1)="00"
 .S $P(^ONCO(165.5,DA,"NCR18B"),U,2)="00"
 .S $P(^ONCO(165.5,DA,"NCR18B"),U,3)="000000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",11)=1
 .D RADSTF2  ;If no PHASE I Rad then stuff/skip PHASE II & III fields
 ;
 ;PART 2 IF = 99
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",4)=70 D  ;IF PHASE 1 RAD = 99
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",5)=11
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",6)=18
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",2)=14
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",1)="99999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",3)="999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",7)="999999"
 .W !,"PHASE 1 RADIATION TREATMENT VOLUME...: 99  UNKNOWN"
 .W !,"PHASE 1 RAD TO DRAINING LYMPH NODE...: 99  UNKNOWN"
 .W !,"PHASE 1 RADIATION TREATMENT MODALITY.: 99  UNKNOWN"
 .W !,"PHASE 1 RAD EXTERNAL BEAM PLAN TECH..: 99  UNKNOWN"
 .W !,"PHASE 1 DOSE PER FRACTION............: 99999"
 .W !,"PHASE 1 NUMBER OF FRACTIONS..........: 999"
 .W !,"PHASE 1 TOTAL DOSE...................: 999999"
 .S $P(^ONCO(165.5,DA,"NCR18B"),U,1)="99"
 .S $P(^ONCO(165.5,DA,"NCR18B"),U,2)="99"
 .S $P(^ONCO(165.5,DA,"NCR18B"),U,3)="999999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",11)=70
 .D RADSTF2  ;If no PHASE I Rad then stuff/skip PHASE II & III fields
 Q
RADSTF2 ;
 ;PART 1 IF = 00
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",11)=1 D
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",12)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",13)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",9)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",8)="00000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",10)="000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",14)="000000"
 .W !,"PHASE 2 RADIATION TREATMENT VOLUME...: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 2 RAD TO DRAINING LYMPH NODE...: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 2 RADIATION TREATMENT MODALITY.: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 2 RAD EXTERNAL BEAM PLAN TECH..: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 2 DOSE PER FRACTION............: 00000"
 .W !,"PHASE 2 NUMBER OF FRACTIONS..........: 000"
 .W !,"PHASE 2 TOTAL DOSE...................: 000000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",18)=1
 .D RADSTF3  ;If no PHASE II Rad then stuff/skip PHASE III fields
 ;
 ;PART 2 IF = 99
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",11)=70 D
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",12)=11
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",13)=18
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",9)=14
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",8)="99999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",10)="999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",14)="999999"
 .W !,"PHASE 2 RADIATION TREATMENT VOLUME...: 99  UNKNOWN"
 .W !,"PHASE 2 RAD TO DRAINING LYMPH NODE...: 99  UNKNOWN"
 .W !,"PHASE 2 RADIATION TREATMENT MODALITY.: 99  UNKNOWN"
 .W !,"PHASE 2 RAD EXTERNAL BEAM PLAN TECH..: 99  UNKNOWN"
 .W !,"PHASE 2 DOSE PER FRACTION............: 99999"
 .W !,"PHASE 2 NUMBER OF FRACTIONS..........: 999"
 .W !,"PHASE 2 TOTAL DOSE...................: 999999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",18)=70
 .D RADSTF3  ;If no PHASE II Rad then stuff/skip PHASE III fields
 Q
RADSTF3 ;
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",18)=1 D
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",19)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",20)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",16)=1
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",15)="00000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",17)="000"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",21)="000000"
 .W !,"PHASE 3 RADIATION TREATMENT VOLUME...: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 3 RAD TO DRAINING LYMPH NODE...: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 3 RADIATION TREATMENT MODALITY.: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 3 RAD EXTERNAL BEAM PLAN TECH..: 00  NO RADIATION TREATMENT"
 .W !,"PHASE 3 DOSE PER FRACTION............: 00000"
 .W !,"PHASE 3 NUMBER OF FRACTIONS..........: 000"
 .W !,"PHASE 3 TOTAL DOSE...................: 000000"
 .S Y=7024  ;If no PHASE III Rad then stuff and jump over
 I $P($G(^ONCO(165.5,D0,"RAD18")),"^",18)=70 D
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",19)=11
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",20)=18
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",16)=14
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",15)="99999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",17)="999"
 .S $P(^ONCO(165.5,D0,"RAD18"),"^",21)="999999"
 .W !,"PHASE 3 RADIATION TREATMENT VOLUME...: 99   UNKNOWN"
 .W !,"PHASE 3 RAD TO DRAINING LYMPH NODE...: 99   UNKNOWN"
 .W !,"PHASE 3 RADIATION TREATMENT MODALITY.: 99   UNKNOWN"
 .W !,"PHASE 3 RAD EXTERNAL BEAM PLAN TECH..: 99   UNKNOWN"
 .W !,"PHASE 3 DOSE PER FRACTION............: 99999"
 .W !,"PHASE 3 NUMBER OF FRACTIONS..........: 999"
 .W !,"PHASE 3 TOTAL DOSE...................: 999999"
 .S Y=7024  ;If no PHASE III Rad then stuff and jump over
 Q
