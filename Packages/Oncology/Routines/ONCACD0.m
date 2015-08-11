ONCACD0 ;Hines OIFO/GWB - NAACCR extract driver ;09/22/11
 ;;2.2;ONCOLOGY;**1,4**;Jul 31, 2013;Build 5
 ;
EN1(DEVICE,STEXT) ;Entry point
EN2 N ACO,BDT,DATE,DIAGYR,EDT,EXTRACT,NCDB,ONCSPIEN,QUEUE,SDT,STAT,STAT1,STAT2,YESNO,DATE1,ONCDATE,ONCDT,ONCLDT
 N ACCN,ONCDT11,ONCDATE1,SCREEN,CYR,ONC91AS,PTR,CLASSOFCASE,ONCPHI
 K ^TMP($J),RQRS
 S DEVICE=$G(DEVICE,0),STEXT=$G(STEXT,0),EXT=""
 S (EDT,EXTRACT,DATE,OUT,QUEUE,SDT,STAT,ONCDT)=0
 ;P2.2*4
 W !
 S DIR("A")=" Exclude PHI COMORBIDITY codes: "
 S DIR("B")="YES",DIR(0)="Y"
 S DIR("?")=" "
 S DIR("?",1)=" Answer 'YES' if you want to exclude PHI COMORBIDITY codes."
 S DIR("?",2)=" Answer 'NO' if you want to include PHI COMORBIDITY codes."
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 S ONCPHI=Y
 ;
 I (STEXT=0)!(STEXT=2)!(STEXT=3) S EXTRACT=$O(^ONCO(160.16,"B","NCDB EXTRACT V15.0",0))
 I STEXT=1 D GETREC(.EXTRACT,.OUT)
 I 'OUT S STAT=$$GETHOSP
 I 'STAT S OUT=1
 I 'OUT S STAT1=$P(STAT,U,1),STAT2=$P(STAT,U,2)
 I 'OUT D GETDATE(.DATE,.DATE1,.OUT)
 I 'OUT,STEXT=1 D GETDT(.SDT,.EDT,DATE,.OUT)
 I 'OUT,STEXT=3 D RQRS(.SDT,.EDT,DATE,.OUT) S RQRS=1
 I 'OUT D VERIFY(STAT,DATE,SDT,EDT,STEXT,.YESNO,.OUT)
 I 'OUT G:'YESNO EN2
 I 'OUT D DEVICE(DEVICE,.OUT)
 I 'OUT D:'QUEUE PRINT(DEVICE,.OUT)
 D EXIT
 Q
 ;
GETREC(EXTRACT,OUT) ;Select VACCR or STATE record layout
 W !!," Available record layouts:",!
 W !,"  1) VACCR Record Layout v15.0 (VA Registry)"
 W !,"  2) NAACCR State Record Layout v15.0"
 W !
 N DIR,X,Y
 S DIR(0)="SAO^1:VACCR Record Layout v15.0;2:NAACCR State Record Layout v15.0"
 S DIR("A")=" Select record layout: "
 S DIR("?")="Select the record layout to use"
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 I +Y<1 S OUT=1 Q
 I Y=1 S EXT="VACCR",EXTRACT=$O(^ONCO(160.16,"B","VACCR EXTRACT V15.0",0))
 I Y=2 S EXT="STATE",EXTRACT=$O(^ONCO(160.16,"B","STATE EXTRACT V15.0",0))
 Q
 ;
GETHOSP() ;Facility Identification Number (FIN)
 N STAT,STATI,ALLOK
 S STAT=0,ALLOK=$$GETDXH(.STAT)
 I STAT S STATI=6_STAT_0,STAT=STAT_"^"_STATI
 Q STAT
 ;
GETDXH(DXH) ;INSTITUTION ID NUMBER (160.1,27)
 N OKHERE,DIE,DA,DR,ONCOL
 W !
 S DIE=160.1
 S DA=$O(^ONCO(160.1,"C",DUZ(2),0))
 I DA="" S DA=$O(^ONCO(160.1,0))
 S ONCSPIEN=DA
 S DR=27_$J("",1)_"Facility Identification Number (FIN)"
 S ONCOL=0
 L +^ONCO(160.1,DA):0 I $T D ^DIE L -^ONCO(160.1,DA) S ONCOL=1
 I 'ONCOL W !,"This ONCOLOGY SITE PARAMETERS record is being edited by another user."
 K ONCOL,DIE
 I $D(Y)=0 S DXH=$$GET1^DIQ(160.19,X,.01,"I")
 I X'="" S ACDSTATE=$P($G(^ONCO(160.19,X,0)),U,4)
 S OKHERE=($D(Y)=0)
 Q OKHERE
 ;
RQRS(SDT,EDT,DATE,OUT) ;Process RQRS data
 K DIR
 S DIR(0)="SAO^1:Date DX;2:Date Case Last Changed;3:Accession Number"
 S DIR("A")=" Select date field to be used for Start/End range: "
 S DIR("?")="Select the date field you wish to use for this download's Start/End range prompts."
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 I Y<1 S OUT=1 Q
 S (NCDB,ONCLDT)=Y
 K DIR
 S ONCDT11=3080101
 I $G(ONCLDT)=3 D ACCN Q
 ;S CYR=1700+($E(DT,1,3)),SCREEN="K:X>CYR X"
 S DIR(0)="DO^3080101:"_DT_":EP"
 ;S DIR("B")=$E(ONCDT11,4,5)_"/"_$E(ONCDT11,6,7)_"/"_$E(ONCDT11,2,3)
 I $G(ONCLDT)=1 D
 .S DIR("A")=" Start, Date DX: "
 .S DIR("?",1)="   Enter the DATE of Diagnosis of the"
 .S DIR("?",2)="   FIRST abstract you would like to report."
 I $G(ONCLDT)=2 D
 .S DIR("A")=" Start, Date Case Last Changed: "
 .S DIR("?",1)="   Enter the DATE CASE LAST CHANGED of the"
 .S DIR("?",2)="   FIRST abstract you would like to report."
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S SDT=Y
 I $E(SDT,4,7)="0000" S SDT=$E(SDT,1,3)_"0101"
 K DIR
 S CYR=1700+($E(DT,1,3)),SCREEN="K:(X>CYR)!(X<SDT) X"
 S DIR(0)="DO^"_SDT_":"_DT_":EP"
 S DIR("?")="   End Date must be greater than the Start Date."
 I $G(ONCLDT)=1 D
 .S DIR("A")="   End, Date DX: "
 .S DIR("?",1)="   Enter the DATE of Diagnosis of the"
 .S DIR("?",2)="   LAST abstract you would like to report."
 I $G(ONCLDT)=2 D
 .S DIR("A")="   End, Date Case Last Changed: "
 .S DIR("?",1)="   Enter the DATE CASE LAST CHANGED  of the"
 .S DIR("?",2)="   LAST abstract you would like to report."
 S DIR("B")="TODAY"
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S EDT=Y I $E(EDT,4,7)="0000" S EDT=$E(EDT,1,3)_1231
 ;
 Q
 ;
GETDT(SDT,EDT,DATE,OUT) ; Select a date range
 K DIR
 S DIR(0)="SAO^1:Date Case Completed;2:Date Case Last Changed;3:Accession Number"
 S DIR("A")=" Select date field to be used for Start/End range: "
 S DIR("?")="Select the date field you wish to use for this download's Start/End range prompts."
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 I Y<1 S OUT=1 Q
 S ONCLDT=Y
 S ONCDT11=3000101
DCLC K DIR
 I $G(ONCLDT)=3 D ACCN Q:OUT=1  G ACJ
 S CYR=DT,SCREEN="K:(X>CYR)!(X<ONCDT11) X"
 S DIR(0)="DO^"_ONCDT11_":"_DT_":EP"
 ;S DIR("B")=$E(ONCDT11,4,5)_"/"_$E(ONCDT11,6,7)_"/"_$E(ONCDT11,2,3)
 I $G(ONCLDT)=1 D
 .S DIR("A")=" Start, Date Case Completed: "
 .S DIR("?",1)="   Enter the DATE CASE COMPLETED of the"
 .S DIR("?",2)="   FIRST abstract you would like to report."
 I ($G(ONCLDT)=2)!($G(NCDB)=2) D
 .S DIR("A")=" Start, Date Case Last Changed: "
 .S DIR("?",1)="   Enter the DATE CASE LAST CHANGED of the"
 .S DIR("?",2)="   FIRST abstract you would like to report."
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S (SDT,BDT)=Y
 K DIR
 S CYR=DT,SCREEN="K:(X>CYR)!(X<SDT) X"
 S DIR(0)="DO^"_SDT_":"_DT_":EP"
 S DIR("B")="TODAY"
 S DIR("?")="   End Date must be greater than the Start Date."
 I $G(ONCLDT)=1 D
 .S DIR("A")="   End, Date Case Completed: "
 .I EXT="VACCR",$P($G(^ONCO(160.1,ONCSPIEN,0)),U,8)'="" S ONCED89=$$GET1^DIQ(160.1,ONCSPIEN,61)
 .I EXT="STATE",$P($G(^ONCO(160.1,ONCSPIEN,0)),U,9)'="" S ONCED89=$$GET1^DIQ(160.1,ONCSPIEN,62)
 .S DIR("?",1)="   Enter the DATE CASE COMPLETED of the"
 .S DIR("?",2)="   LAST abstract you would like to report."
 I ($G(ONCLDT)=2)!($G(NCDB)=2) D
 .S DIR("A")="   End, Date Case Last Changed: "
 .I EXT="VACCR",$P($G(^ONCO(160.1,ONCSPIEN,0)),U,10)'="" S ONCED89=$$GET1^DIQ(160.1,ONCSPIEN,63)
 .I EXT="STATE",$P($G(^ONCO(160.1,ONCSPIEN,0)),U,11)'="" S ONCED89=$$GET1^DIQ(160.1,ONCSPIEN,64)
 .S DIR("?",1)="   Enter the DATE CASE LAST CHANGED  of the"
 .S DIR("?",2)="   LAST abstract you would like to report."
 ;S:$G(ONCED89) DIR("B")=$E(ONCED89,4,5)_"/"_$E(ONCED89,6,7)_"/"_$E(ONCED89,2,3)
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S EDT=Y
ACJ I EXT="" Q
 I $G(NCDB)=2 Q
 I EXT="VACCR" Q
 K DIR
 S DIR("A")=" Analytic cases only"
 S DIR("B")="YES"
 S DIR(0)="Y"
 S DIR("?")=" "
 S DIR("?",1)=" Answer 'YES' if you want only analytic cases (CLASS OF CASE 0-2) extracted."
 S DIR("?",2)=" Answer  'NO' if you want all cases (analytic and non-analytic) extracted."
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 S ACO=Y
 Q
 ;
DATEDX(SDT,EDT,DATE,OUT) ;Select DATE DX range
 K DIR
 S CYR=1700+($E(DT,1,3)),SCREEN="K:X>CYR X"
 ;S DIR(0)="DO^3000101:"_DT_":EP"
 ;S DIR(0)="D^::X"
 S DIR("A")=" Start, Date Dx: "
 S DIR("?",1)="   Enter the DATE DX of the FIRST"
 S DIR("?",2)="   abstract you would like to report."
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S (SDT,BDT)=Y
 K DIR
 S CYR=1700+($E(DT,1,3)),SCREEN="K:(X>CYR)!(X<SDT) X"
 S DIR(0)="DO^"_SDT_":"_DT_":EP"
 ;S DIR(0)="D^::X"
 S DIR("A")="   End, Date Dx:"
 S DIR("?",1)="   Enter the DATE DX of the LAST abstract you would"
 S DIR("?",2)="   like to report and must be greater than Start, Date Dx."
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S EDT=Y
 Q
 ;
PRINT(DEVICE,OUT) ;Capture output data
 I 'DEVICE D  Q:OUT
 .N X
 .W !!
 .W !,?6,"--------------------------------------------------------------"
 .W !,?6,"|Please activate your PC capture program.  The data will be  |"
 .W !,?6,"|sent in 2 minutes or when you press the return key.         |"
 .W !,?6,"--------------------------------------------------------------"
 .W !!!
 .R X:120
 .I X="^" S OUT=1
 U IO D EN1^ONCACD1
 Q
 ;
EXIT ;Exit
 K ACDSTATE,DIC,EXT,OUT,X,Y
 I '$D(^TMP($J)) W !?3,"No records extracted." G EX
 W !
 S DIC="^ONCO(165.5,",L=0,FLDS="[ONC EXTRACT REPORT]",BY(0)="^TMP($J,",L(0)=1
 S:DEVICE IOP=ION
 I STEXT=0 S DHD=$P(^ONCO(160.16,EXTRACT,0),U,1) W !
 I (STEXT=1)!(STEXT=2) S DHD=$P(^ONCO(160.16,EXTRACT,0),U,1)_" "_$$FMTE^XLFDT(BDT,"2D")_" - "_$$FMTE^XLFDT(EDT,"2D")
 D EN1^DIP
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR Q:'Y
 ;
EX K ^TMP($J)
 K %ZIS
 D ^%ZISC
 K ACDANS,BY,CCEX,DHD,EXT,FLDS,FR,IOP,L,POP,STEXT,TO
 Q
 ;
DEVICE(DEVICE,OUT) ;Select output device
 Q:'DEVICE
 S %ZIS="Q"
 D ^%ZIS
 I POP S OUT=1 Q
 I $D(IO("Q")) D
 .S ZTRTN="PRINT^ONCACD0(DEVICE,.OUT)"
 .S ZTDESC=$S('STEXT:"ONC NCDB Extract",STEXT:"ONC State Extract",1:"")
 .S ZTSAVE("STAT1")=""
 .S ZTSAVE("DATE")=""
 .S ZTSAVE("DATE1")=""
 .S ZTSAVE("ONCDT")=""
 .S ZTSAVE("ONCLDT")=""
 .S ZTSAVE("STEXT")=""
 .S ZTSAVE("DEVICE")=""
 .S ZTSAVE("OUT")=""
 .S ZTSAVE("BDT")=""
 .S ZTSAVE("SDT")=""
 .S ZTSAVE("EDT")=""
 .S ZTSAVE("EXT")=""
 .S ZTSAVE("EXTRACT")=""
 .S ZTSAVE("NCDB")=""
 .D ^%ZTLOAD
 .I $D(ZTSK)[0 S OUT=1 W !!,?20,"Report Canceled!"
 .E  W !!,?20,"Report Queued!" S QUEUE=1
 .D HOME^%ZIS
 K ZTDESC,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
VERIFY(STAT,DATE,SDT,EDT,STEXT,YESNO,OUT) ;Verify settings
 N DIR,Y,RL
 S RL=$P(^ONCO(160.16,EXTRACT,0),U,1)
 I STEXT=3 S RL="RQRS EXTRACT"
 W !!," These are your current settings:"
 W !
 W !," Record layout.......................: ",RL
 W !," Facility Identification Number (FIN): ",STAT1
 I EXT="STATE" D
 .W !," State to be extracted...............: ",ACDSTATE
 I STEXT=0 D
 .W !," Diagnosis Year......................: ",DIAGYR
 .W !," Selection criterion.................: ",$S(NCDB=1:"All cases",NCDB=2:"Date Case Last Changed date range",NCDB=3:"Accession Number",1:"")
 I STEXT=3 D
 .W !," Selection criterion.................: ",$S(NCDB=1:"Date DX",NCDB=2:"Date Case Last Changed date range",NCDB=3:"Accession Number",1:"")
 I (STEXT=1)!(STEXT=2)!(STEXT=3),(($G(NCDB)'=3)&($G(ONCLDT)'=3)) D
 .W !," Start date..........................: ",$$FMTE^XLFDT(SDT,"2D")
 .W !," End date............................: ",$$FMTE^XLFDT(EDT,"2D")
 I ($G(ONCLDT)=3)!($G(NCDB)=3) D
 .W !," Accession Number Start..........: ",SDT
 .W !," Accession Number End............: ",EDT
 I EXT="STATE" D
 .W !," Analytic cases only.................: ",$S(ACO=1:"YES",1:"NO")
 I STEXT=3 D
 .W !," Primary Sites.......................: BREAST, COLON and RECTUM"
 W !
 S DIR("A")=" Are these settings correct"
 S DIR("B")="YES"
 S DIR(0)="Y"
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 S YESNO=Y
 I STEXT=1,EXT="VACCR" S $P(^ONCO(160.1,ONCSPIEN,0),U,8)=EDT
 I STEXT=1,EXT="STATE" S $P(^ONCO(160.1,ONCSPIEN,0),U,9)=EDT
 I STEXT=2,EXT="VACCR" S $P(^ONCO(160.1,ONCSPIEN,0),U,10)=EDT
 I STEXT=2,EXT="STATE" S $P(^ONCO(160.1,ONCSPIEN,0),U,11)=EDT
 Q
 ;
GETDATE(ONCDT,DATE1,OUT) ;Select Diagnosis Year
 Q:STEXT>0
 N CYR,DIR,SCREEN,Y
 S ONCDT=0
 S CYR=1700+($E(DT,1,3)),SCREEN="K:X>CYR X"
 S DIR(0)="NAO^1900:"_CYR_":0^"_SCREEN
 S DIR("A")=" Diagnosis Year Start: "
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 ;S (ONCDT,DIAGYR)=Y
 S (ONCDATE,ONCDT)=Y
 S ONCDT=ONCDT-1700
 S ONCDT11=ONCDT_"0101"
 S ONCDT=ONCDT_"0000"
 S (ONCDT,ONCLDT)=ONCDT-1
 ;Diagnosis Year End
 K DIR
 S DATE1=ONCDATE
 S CYR=1700+($E(DT,1,3)),SCREEN="K:(X>CYR)!(X<ONCDATE) X"
 S DIR(0)="NAO^1900:"_CYR_":0^"_SCREEN
 S DIR("A")=" Diagnosis Year End: "
 S DIR("?")=" Diagnosis Year End must be a number and greater than the Start year."
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 S (ONCDATE1,DATE1)=Y
 S DIAGYR=ONCDATE_"-"_Y
 S DATE1=DATE1+1
 S DATE1=DATE1-1700
 S DATE1=DATE1_"0000"
 S DATE1=DATE1-1
 K DIR
 W !," Diagnosis Years: ",DIAGYR
 W !
 W !,?6,"Select one of the following:"
 W !
 W !,?11,"1 All eligible cases for this year"
 W !,?11,"2 Cases within a 'Date Case Last Changed' date range"
 W !,?11,"3 Accession Number"
 W !
 S DIR(0)="SAO^1:All cases;2:Cases within a date range;3:Accession Number"
 S DIR("A")=" Select extraction criterion: "
 S DIR("B")="All cases"
 S DIR("?")=" "
 S DIR("?",1)=" Select 'All cases' if you want to extract all"
 S DIR("?",2)=" of the eligible cases for this Diagnosis Year."
 S DIR("?",3)=""
 S DIR("?",4)=" Select 'Cases within a date range' if you want"
 S DIR("?",5)=" to specify a 'Date Case Last Changed' date range"
 S DIR("?",6)=" for this Diagnosis Year."
 S DIR("?",7)=" "
 S DIR("?",8)="Select 'Accession Number-Seq' if you want to specify"
 S DIR("?",9)="the extract by Accession Number range."
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT Q
 I Y<1 S OUT=1 Q
 S NCDB=Y
 I NCDB=2 W ! D DCLC
 I NCDB=3 W ! D ACCN
 Q
ACCN ;Accession Number
 N ONCACST,ONCACEN
 S ONCACST=$O(^ONCO(165.5,"AA",0)),ONCACEN=$O(^ONCO(165.5,"AA",""),-1)
 S:$D(ONCDATE) ONCACST=ONCDATE_"00000" S:$D(ONCDATE1) ONCACEN=ONCDATE1_"99999"
 S ONCACST=$O(^ONCO(165.5,"AA",ONCACST)),ONCACEN=$O(^ONCO(165.5,"AA",ONCACEN),-1)
 K DIR
 S DIR("B")=ONCACST
 S DIR(0)="NO^"_ONCACST_":"_ONCACEN
 S DIR("A")="Enter the Accession Number Start "
 S DIR("?")="Enter a number from "_ONCACST_" to "_ONCACEN
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S (BDT,SDT)=Y
 K DIR
 S DIR("B")=ONCACEN
 S DIR(0)="NO^"_BDT_":"_ONCACEN
 S DIR("A")="Enter the Accession Number End "
 S DIR("?")="Enter a number from "_BDT_" to "_ONCACEN
 D ^DIR I $D(DIRUT) S OUT=1 K DIRUT Q
 S EDT=Y
 Q
