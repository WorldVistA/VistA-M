PXCEVIMM ;ISL/dee,SLC/ajb - Used to edit and display V IMMUNIZATION ;Oct 29, 2021@10:23:33
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,124,199,201,210,215,211,217**;Aug 12, 1996;Build 134
 ;;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;     1         2             3                   4                                   5
 ;
 ;Following lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special cases.
 ;  (The .01 field cannot have a special edit.)
 ;
FORMAT ;;Immunization~9000010.11~0,2,3,11,12,13,14,15,16,811,812~0~^AUPNVIMM
 ;;0~1~.01~Immunization:  ~Immunization:  ~~~~~B
 ;;13~1~1301~Information Source:  ~Information Source:  ~~~~~D
 ;;12~7~1207~Lot Number:  ~Lot Number:  ~$$DISPLN^PXCEVIMM~~~~D
 ;;12~22~1222~Ordered By Policy:  ~Ordered By Policy:  ~~~~~D
 ;;12~2~1202~Ordering Provider:  ~Ordering Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;0~4~.04~Series:  ~Series:  ~~~~~D
 ;;0~6~.06~Reaction:  ~Reaction:  ~~~~~D
 ;;0~7~.07~Repeat Contraindicated:  ~Repeat Contraindicated:  ~~ECONTRAI^PXCEVIMM~~~D
 ;;12~1~1201~Administered Date and Time:  ~Administered Date and Time:  ~~EVENTDT^PXCEVIMM(.PXCEAFTR)~~~D
 ;;12~20~1220~Warning Acknowledged:  ~Warning Acknowledged:  ~~~~~D
 ;;16~1~1601~Warning Override Reason:  ~Warning Override Reason:  ~~~~~D
 ;;13~12~1312~Dose:  ~Dose:  ~~~~~D
 ;;13~13~1313~Dose Units:  ~Dose Units:  ~~~~~D
 ;;13~2~1302~Route of Administration:  ~Route of Administration:  ~~~~~D
 ;;13~3~1303~Site of Administration (Body):  ~Site of Administration (Body):  ~~~~~D
 ;;2~0~2~VIS Offered/Given:  ~VIS:  ~$$DISPVIS^PXCEVIS~EVIS^PXCEVIS~~~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;812~2~81202~Package:  ~Package: ~~SKIP^PXCEVIMM~~~D
 ;;812~3~81203~Data Source:  ~Data Source: ~~SKIP^PXCEVIMM~~~D
 ;;13~4~1304~Primary Diagnosis:  ~Primary Diagnosis:  ~$$DISPLY01^PXCEPOV~SKIP^PXCEVIMM~~S~
 ;;3~2~.01~Other Diagnosis:  ~Other Diagnosis:  ~$$DISPLY01^PXCEPOV~SKIP^PXCEVIMM~~S~
 ;;14~3~1403~Date and Time Read:  ~Date/Time Read:  ~~EREADDT^PXCEVIMM(PXCEFIEN,.PXCEAFTR,PXCETEXT)~~~D
 ;;14~2~1402~Reading in Millimeters (mm):  ~Reading in Millimeters (mm):  ~~EREAD^PXCEVIMM(PXCEFIEN,.PXCEAFTR,PXCETEXT)~~~D
 ;;14~1~1401~Results:  ~Results:  ~~EREADDATA^PXCEVIMM(PXCEFIEN,.PXCEAFTR,PXCETEXT)~~~D
 ;;14~4~1404~Reader:  ~Reader:  ~~EPROV12^PXCEPRV~~~D
 ;;14~5~1405~Date and Time Reading Recorded:  ~Reading Recorded:  ~~SKIP^PXCEVIMM~~~D
 ;;14~6~1406~Hours Read Post-Inoculation:  ~Hours Read Post-Inoculation:  ~~SKIP^PXCEVIMM~~~D
 ;;15~1~1501~Reading Comments:  ~Reading Comments:  ~~EREADDATA^PXCEVIMM(PXCEFIEN,.PXCEAFTR,PXCETEXT)~~~D
 ;;
 ;
 ;Cannot ask word processing
 ;;12~2~1202~Ordering Provider:  ~Ordering Provider:  ~~EPROV12^PXCEPRV~~~D
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;PX SELECT IMMUNIZATIONS
 ;
 ;********************************
 ;Special cases for display.
 ;
 ;********************************
 ;Special cases for edit.
 ;
ECONTRAI ;
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 E  S DIR("B")="NO"
 S DIR(0)=PXCEFILE_","_$P(PXCETEXT,"~",3)_"A"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 Q
 ;
EREAD(DA,PXCEAFTR,PXCETEXT) ;Enter/edit reading.
 N DONE,READING
 ;If there is no reading date/time quit.
 I $P(PXCEAFTR(14),U,3)="" Q
 S DONE=0
 F  Q:DONE  D
 . D EREADDATA(DA,.PXCEAFTR,PXCETEXT)
 . I PXCEEND=1 S DONE=1 Q
 . S READING=$P(PXCEAFTR(14),U,2)
 . I READING'="" S DONE=1 Q
 Q
 ;
EREADDATA(DA,PXCEAFTR,PXCETEXT) ;Enter/edit reading data.
 N DIR,FLDNUM,MSG,NODE,PIECE,PROMPT,X,Y
 S NODE=$P(PXCETEXT,"~",1)
 S PIECE=$P(PXCETEXT,"~",2)
 S FLDNUM=$P(PXCETEXT,"~",3)
 S PROMPT=$P(PXCETEXT,"~",4)
 S DIR(0)=9000010.11_","_FLDNUM_"A"
 S DIR("A")=PROMPT
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 ;If any of the reading data is deleted, delete all of it.
 I X="@" D  Q
  . S PXCEEND=1
  . S PXCEAFTR(14)="",^AUPNVIMM(DA,14)=""
  . S PXCEAFTR(15)="",^AUPNVIMM(DA,15)=""
 I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 S $P(PXCEAFTR(NODE),U,PIECE)=$P(Y,U,1)
 Q
 ;
EREADDT(DA,PXCEAFTR,PXCETEXT) ;Enter/edit reading date and time.
 N ADMDT,DONE,HOURS,READDT
 S ADMDT=$P(PXCEAFTR(12),U,1)
 S DONE=0
 F  Q:DONE  D
 . D EREADDATA(DA,.PXCEAFTR,PXCETEXT)
 . S READDT=$P(PXCEAFTR(14),U,3)
 . I READDT="" S DONE=1 Q
 . I READDT>ADMDT S DONE=1 Q
 . D EN^DDIOL("Date/Time Read must be after the Administered Date/Time: "_$$FMTE^XLFDT(ADMDT))
 I +READDT>0 D
 . S HOURS=$$FMDIFF^XLFDT(READDT,ADMDT,2)\3600
 . D EN^DDIOL("Hours Read Post-Inoculation:  "_HOURS)
 Q
 ;
ELOT ;
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)="PAO^9999999.41:EM^K:$P(^(0),U,3)'=0!($P(^(0),U,4)'=$P(PXCEAFTR(0),U,1)) X"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 S:Y'<0 $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 Q
 ;
EPOV ;Edit the Associated DX
 ;Not used, adding/editing diagnosis removed in PX*1.0*211
 N PXACS,PXACSREC,PXDATE,PXDEF,PXDXASK,PXXX
 S PXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
 S PXACSREC=$$ACTDT^PXDXUTL(PXDATE),PXACS=$P(PXACSREC,"^",3)
 I PXACS["-" S PXACS=$P(PXACS,"-",1,2)
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 .N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 .S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 .S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 .S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 I $P(PXACSREC,U,1)'="ICD" D
 . S PXDXASK=PXACS_" "_$P(PXCETEXT,"~",4)
 . S PXDEF=$G(DIR("B")),PXAGAIN=0 D ^PXDSLK I PXXX=-1 S Y=-1 Q
 . I PXXX="@" S Y="@" Q
 . S Y=$P($$ICDDATA^ICDXCODE("DIAG",$P($P(PXXX,U,1),";",2),PXDATE,"E"),U,1)
 I $P(PXACSREC,U,1)="ICD" D
 . S DIR(0)=PXCEFILE_","_$P(PXCETEXT,"~",3)_"A"
 . S DIR("A")=PXACS_" "_$P(PXCETEXT,"~",4)
 . S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 . D ^DIR
 K DIR,DA
 I X="@" S Y="@" S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^") Q
 I $D(DTOUT)!$D(DUOUT) S PXCEEND=1,PXCEQUIT=1 Q
 I +Y'>0 S PXCEEND=1 Q  ;S:$P(PXCETEXT,"~",3)=".08" PXCEQUIT=1 Q
 ;See if this diagnosis is in the PXCEAFTR(0)
 I $P(PXCETEXT,"~",2)'=1,(+Y=$P($G(PXCEAFTR(80)),"^",1)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=2,(+Y=$P($G(PXCEAFTR(80)),"^",2)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=3,(+Y=$P($G(PXCEAFTR(80)),"^",3)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=4,(+Y=$P($G(PXCEAFTR(80)),"^",4)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=5,(+Y=$P($G(PXCEAFTR(80)),"^",5)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=6,(+Y=$P($G(PXCEAFTR(80)),"^",6)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=7,(+Y=$P($G(PXCEAFTR(80)),"^",7)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=8,(+Y=$P($G(PXCEAFTR8(80)),"^",8)) S PXCEEND=1
 ;
 ; check for duplicate diagnosis in OTHER DIAGNOSIS
 N DX D:+$G(PXCEFIEN)
 . N CNT S CNT=0 F  S CNT=$O(^AUPNVIMM(PXCEFIEN,3,CNT)) Q:'+CNT  D
 . . S DX(^AUPNVIMM(PXCEFIEN,3,CNT,0))=""
 I +$D(DX(+Y)) S PXCEEND=1
 ;
 I $G(PXCEEND)=1 W !,$C(7),"Duplicate Diagnosis is not allowed." D WAIT^PXCEHELP Q
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 D:+Y>0 DIAGNOS^PXCEVFI4(+Y)
 Q
 ;
EPOV2 ; edit OTHER DIAGNOSIS
 ;Not used, adding/editing diagnosis removed in PX*1.0*211
 Q:'+$G(PXCEFIEN)
 N PXACS,PXACSREC,PXDATE,PXDEF,PXDXASK,PXXX
 S PXDATE=$S($D(PXCEVIEN)=1:$$CSDATE^PXDXUTL(PXCEVIEN),$D(PXCEAPDT)=1:PXCEAPDT,1:DT)
 S PXACSREC=$$ACTDT^PXDXUTL(PXDATE),PXACS=$P(PXACSREC,"^",3)
 I PXACS["-" S PXACS=$P(PXACS,"-",1,2)
 ; get multiple diagnosis
 N CNT,DX,DXS S CNT=0 F  S CNT=$O(^AUPNVIMM(PXCEFIEN,3,CNT)) Q:'+CNT  D
 . S DX(CNT)=^AUPNVIMM(PXCEFIEN,3,CNT,0)
 . S DXS(DX(CNT))=""
 I '$D(DX) S DX(1)="" ; if no entries, show empty entry to allow adding
 I $P(PXACSREC,U,1)="ICD" D
 . N DIR S DIR(0)=PXCEFILE_"3,"_$P(PXCETEXT,"~",3)_"A"
 . S DIR("A")=PXACS_" "_$P(PXCETEXT,"~",4)
 . S CNT=0 F  S CNT=$O(DX(CNT)) Q:'+CNT!($D(DTOUT)!($D(DUOUT)))  D
 . . N DA,X,Y
 . . S DIR("B")=$$EXTERNAL^DILFD(PXCEFILE_3,".01","",DX(CNT),"PXCEDILF")
 . . D ^DIR Q:$D(DTOUT)!$D(DUOUT)  Q:X=""
 . . I X="@" W ! I +$$READ("YE","Are you sure you want to remove this entry","NO") D DELDX(CNT) Q
 . . I +$D(DXS(+Y)) W:Y(0)'=DIR("B") !!,$C(7),"Entry matches Other Diagnosis.  Duplicate Diagnosis is not allowed." D:Y(0)'=DIR("B") WAIT^PXCEHELP Q  ; quit if entry already exists
 . . I +Y=$P($G(^AUPNVIMM(PXCEFIEN,13)),U,4) D  Q  ; quit if entry matches primary diagnosis
 . . . W !!,$C(7),"Entry matches Primary Diagnosis.  Duplicate Diagnosis is not allowed." D WAIT^PXCEHELP
 . . I Y(0)'=DIR("B") D  ; ask to overwrite or add new entry
 . . . I DIR("B")'="" N ANS W ! S ANS=$$READ("SA^A:ADD;R:REPLACE","Do you want to ADD a new entry or REPLACE the current entry? ","ADD") W !
 . . . I DIR("B")="" S ANS="A" ; if no current entry, always add
 . . . I $P(ANS,U)="A"!($P(ANS,U)="R") D  Q
 . . . . N FDA,FDAIEN,ERRMSG,IEN
 . . . . S IEN=$S($P(ANS,U)="A":"+1,"_PXCEFIEN_",",1:CNT_","_PXCEFIEN_",")
 . . . . S FDA(PXCEFILE_3,IEN,.01)=+Y
 . . . . D DIAGNOS^PXCEVFI4(+Y,1)
 . . . . I '+$G(PXCEQUIT) D UPDATE^DIE("","FDA","FDAIEN","ERRMSG")
 Q
 ;
 ;********************************
EVENTDT(PXCEAFTR) ;Edit the Event Date and Time.
 N DEFAULT,EVENTDT,HELP,IEN,PROMPT
 S DEFAULT=$P(^TMP("PXK",$J,"IMM",1,12,"BEFORE"),U,1)
 S HELP="D EVDTHELP^PXCEVIMM"
 S PROMPT="Administered Date and Time"
 S EVENTDT=$$GETDT^PXDATE(-1,-1,-1,DEFAULT,PROMPT,HELP)
 S $P(PXCEAFTR(12),U,1)=EVENTDT
 I $D(DUOUT)!$D(DTOUT) S PXCEEND=1 Q
 Q
 ;
 ;********************************
EVDTHELP ;Event Date and Time help.
 N ERR,RESULT,TEXT
 S RESULT=$$GET1^DID(9000010.11,1201,"","DESCRIPTION","TEXT","ERR")
 D BROWSE^DDBR("TEXT(""DESCRIPTION"")","NR","V Immunization Administered Date and Time Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;********************************
DELDX(DA) ; delete OTHER DIAGNOSIS
 K DXS(DX(DA)),DX(DA)
 S DA(1)=PXCEFIEN,DIK="^AUPNVIMM("_DA(1)_",3," D ^DIK W !!,"Entry successfully removed." D WAIT^PXCEHELP
 Q
 ;
READ(TYPE,PROMPT,DEFAULT,HELP,SCREEN) ;
 N DIR,X,Y,DUOUT,DTOUT,DIRUT S DIR(0)=TYPE
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 I $G(X)="@" S Y="@" G READX
 I Y]"",($L($G(Y),U)'=2) S Y=Y_U_$G(Y(0),Y)
READX Q Y
 ;
SKIP ;Used to by-pass roll and scroll editing of a field.
 S (X,Y)=""
 Q
 ;
 ;********************************
 ;Display text for the .01 field which is a pointer to Immunization.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEIMM,PXCEDT) ;
 N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 S PXCEINT=$P(PXCEIMM,"^",1)
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.11,.01,"",PXCEINT,"PXCEDILF")
 Q $S('$D(DIERR):PXCEEXT,1:PXCEINT)
 ;
DISPLN(PXCEINT,PCEDT) ; display lot number with manufacturer
 N PXCEDILF,PXCEEXT,PXV2,PXVMAN
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.11,1207,"",PXCEINT,"PXCEDILF")
 S PXV2=$P(^AUTTIML(PXCEINT,0),"^",2),PXVMAN=$$EXTERNAL^DILFD(9999999.41,.02,"",PXV2,"PXCEDILF")
 Q $S('$D(DIERR):PXCEEXT_"     "_PXVMAN,1:PXCEINT)
