PXCEVIMM ;ISL/dee,SLC/ajb - Used to edit and display V IMMUNIZATION ;08/12/2014
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,124,199,201**;Aug 12, 1996;Build 41
 ;; ;
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
FORMAT ;;Immunization~9000010.11~0,3,11,12,13,811,812~0~^AUPNVIMM
 ;;0~1~.01~Immunization:  ~Immunization:  ~~~~~B
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;0~4~.04~Series:  ~Series:  ~~~~~D
 ;;0~6~.06~Reaction:  ~Reaction:  ~~~~~D
 ;;0~7~.07~Repeat Contraindicated:  ~Repeat Contraindicated:  ~~ECONTRAI^PXCEVIMM~~~D
 ;;12~1~1201~Administered Date and (optional) Time~Administered Date and Time:  ~~E1201^PXCEPOV1(0,30,30)~~~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;13~4~1304~Primary Diagnosis:  ~Primary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;3~2~.01~Other Diagnosis:  ~Other Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV2^PXCEVIMM~~~
 ;;
 ;
 ;Cannot ask work processing
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
 I $P(PXCETEXT,"~",2)'=8,(+Y=$P($G(PXCEAFTR(0)),"^",8)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=9,(+Y=$P($G(PXCEAFTR(0)),"^",9)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=10,(+Y=$P($G(PXCEAFTR(0)),"^",10)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=11,(+Y=$P($G(PXCEAFTR(0)),"^",11)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=12,(+Y=$P($G(PXCEAFTR(0)),"^",12)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=13,(+Y=$P($G(PXCEAFTR(0)),"^",13)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=14,(+Y=$P($G(PXCEAFTR(0)),"^",14)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=15,(+Y=$P($G(PXCEAFTR(0)),"^",15)) S PXCEEND=1
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
EPOV2 ; edit OTHER DIAGNOSIS
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
 ;********************************
 ;Display text for the .01 field which is a pointer to Immunization.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEIMM) ;
 N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 S PXCEINT=$P(PXCEIMM,"^",1)
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.11,.01,"",PXCEINT,"PXCEDILF")
 Q $S('$D(DIERR):PXCEEXT,1:PXCEINT)
 ;
