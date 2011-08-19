PXCEVIMM ;ISL/dee - Used to edit and display V IMMUNIZATION ;3/11/04 3:00pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,124**;Aug 12, 1996
 ;; ;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;     1         2             3                   4                                   5
 ;
 ;Followning lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special caces.
 ;  (The .01 field cannot have a special edit.)
 ;
FORMAT ;;Immunization~9000010.11~0,11,12,811,812~0~^AUPNVIMM
 ;;0~1~.01~Immunization:  ~Immunization:  ~~~~~B
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;0~4~.04~Series:  ~Series:  ~~~~~D
 ;;0~6~.06~Reaction:  ~Reaction:  ~~~~~D
 ;;0~7~.07~Repeat Contraindicated:  ~Repeat Contraindicated:  ~~ECONTRAI^PXCEVIMM~~~D
 ;;12~1~1201~Administered Date and (optional) Time~Administered Date and Time:  ~~E1201^PXCEPOV1(0,30,30)~~~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;0~8~.08~Diagnosis:  ~Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~9~.09~Diagnosis 2:  ~Diagnosis 2:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~10~.1~Diagnosis 3:  ~Diagnosis 3:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~11~.11~Diagnosis 4:  ~Diagnosis 4:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~12~.12~Diagnosis 5:  ~Diagnosis 5:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~13~.13~Diagnosis 6:  ~Diagnosis 6:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~14~.14~Diagnosis 7:  ~Diagnosis 7:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~15~.15~Diagnosis 8:  ~Diagnosis 8:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
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
 ;
EPOV ;Edit the Associated DX
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 .N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 .S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 .S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 .S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)=PXCEFILE_","_$P(PXCETEXT,"~",3)_"A"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@" S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^") Q
 I $D(DTOUT)!$D(DUOUT) S PXCEEND=1,PXCEQUIT=1 Q
 I '+Y S PXCEEND=1 Q  ;S:$P(PXCETEXT,"~",3)=".08" PXCEQUIT=1 Q
 ;See if this diagnosis is in the PXCEAFTR(0)
 I $P(PXCETEXT,"~",2)'=8,(+Y=$P($G(PXCEAFTR(0)),"^",8)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=9,(+Y=$P($G(PXCEAFTR(0)),"^",9)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=10,(+Y=$P($G(PXCEAFTR(0)),"^",10)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=11,(+Y=$P($G(PXCEAFTR(0)),"^",11)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=12,(+Y=$P($G(PXCEAFTR(0)),"^",12)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=13,(+Y=$P($G(PXCEAFTR(0)),"^",13)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=14,(+Y=$P($G(PXCEAFTR(0)),"^",14)) S PXCEEND=1
 I $P(PXCETEXT,"~",2)'=15,(+Y=$P($G(PXCEAFTR(0)),"^",15)) S PXCEEND=1
 I PXCEEND=1 W !,$C(7),"Duplicate Diagnosis on this CPT code is not allowed." D WAIT^PXCEHELP Q
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 D:+Y>0 DIAGNOS^PXCEVFI4(+Y)
 Q
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
