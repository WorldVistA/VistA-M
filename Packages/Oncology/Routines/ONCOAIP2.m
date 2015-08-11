ONCOAIP2 ;Hines OIFO/GWB,RTK - ONCO ABSTRACT-I SUB-ROUTINES ;04/12/01
 ;;2.2;ONCOLOGY;**1,4**;Jul 31, 2013;Build 5
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
 ;Mycosis fungoides and Sezary's Disease (9700-9701)
 N CHK,TMP
 S TMP=$$HIST^ONCFUNC(DA),Y="@301"
 F CHK="97002","97003","97012","97013" I CHK=TMP S Y=30.5 Q
 Q
 ;
PGPE ;PATHOLOGIC EXTENSION (165.5,30.1)
 ;Prostate C61.9
 S Y="@231"
 N TMP S TMP=$P($G(^ONCO(165.5,DA,2)),U,1)
 I TMP=67619 S Y=30.1 Q
 S $P(^ONCO(165.5,DA,2.2),U,2)=""
 Q
 ;
LN ;BRAIN AND CEREBRAL MENINGES (SEER EOD)
 ;OTHER PARTS OF CENTRAL NERVOUS SYSTEM (SEER EOD)
 N T
 S T=$P($G(^ONCO(165.5,D0,2)),U,1)
 I (T=67700)!($E(T,3,4)=71)!($E(T,3,4)=72) D  S Y="@26" Q
 .S $P(^ONCO(165.5,D0,2),U,11)=9  ;Lymph Nodes
 .S $P(^ONCO(165.5,D0,2),U,12)=99 ;Regional Nodes Positive
 .S $P(^ONCO(165.5,D0,2),U,13)=99 ;Regional Nodes Examined
 .W !,"LYMPH NODES............: Not Applicable"
 .W !,"REGIONAL NODES EXAMINED: Unk; not stated; death cert only"
 .W !,"REGIONAL NODES POSITIVE: Unk if nodes + or -, NA"
 S Y=31
 Q
 ;
EDTMOD ;EXTRACT EDITS THAT NEED TO BE MANUALLY FIXED TO PASS
 S SECTION="EDITS Modifications" D SECTION^ONCOAIP
 N DI,DIC,DR,DA,DIQ,ONC
 S DIC="^ONCO(165.5,"
 S DR="999.1:999.99"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 ;S X=ONC(165.5,D0,91) D UCASE^ONCPCI S ONC(165.5,D0,91)=X
 W !," Address at DX--State........: ",ONC(165.5,D0,999.26),?40,"Address at DX--Country......: ",ONC(165.5,D0,999.27)
 W !," Address Current--State .....: ",ONC(165.5,D0,999.28),?40,"Address Current--Country....: ",ONC(165.5,D0,999.29)
 W !!," Date of Diagnosis Flag......: ",ONC(165.5,D0,999.1),?40,"RX Date-Systemic Flag.......: ",ONC(165.5,D0,999.14)
 W !," Date Conclusive DX Flag.....: ",ONC(165.5,D0,999.2),?40,"RX Date-Chemo Flag..........: ",ONC(165.5,D0,999.15)
 W !," Date of Mult Tumors Flag....: ",ONC(165.5,D0,999.3),?40,"RX Date-Hormone Flag........: ",ONC(165.5,D0,999.16)
 W !," Date of First Contact Flag..: ",ONC(165.5,D0,999.4),?40,"RX Date-BRM Flag............: ",ONC(165.5,D0,999.17)
 W !," Date of Inpt Adm Flag.......: ",ONC(165.5,D0,999.5),?40,"RX Date-Other Flag..........: ",ONC(165.5,D0,999.18)
 W !," Date of Inpt Disch Flag.....: ",ONC(165.5,D0,999.6),?40,"RX Date-DX/Stg Proc Flag....: ",ONC(165.5,D0,999.19)
 W !," Date 1st CRS RX Flag........: ",ONC(165.5,D0,999.7),?40,"Recurrence Date-1st Flag....: ",ONC(165.5,D0,999.21)
 W !," RX Date-Surgery Flag........: ",ONC(165.5,D0,999.8),?40,"Date of Last Contact Flag...: ",ONC(165.5,D0,999.22)
 W !," RX Date-Mst Defn Srg Flag...: ",ONC(165.5,D0,999.9),?40,"Subsq RX 2nd Crs Date Flag..: ",ONC(165.5,D0,999.23)
 W !," RX Date-Surg Disch Flag.....: ",ONC(165.5,D0,999.11),?40,"Subsq RX 3rd Crs Date Flag..: ",ONC(165.5,D0,999.24)
 W !," RX Date-Radiation Flag......: ",ONC(165.5,D0,999.12),?40,"Subsq RX 4th Crs Date Flag..: ",ONC(165.5,D0,999.25)
 W !," RX Date-Rad Ended Flag......: ",ONC(165.5,D0,999.13)
 W !,DASHES
 W !,"* * * These fields should ONLY be used to correct an EDIT that can't * * *",!,"* * * be cleared.  Otherwise these fields should NOT be modified.    * * *"
 Q
