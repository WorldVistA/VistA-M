PXCECPT ;ISL/dee,ISA/Zoltan,esw - Used to edit and display V CPT ;6/22/04 3:27pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**14,27,73,89,112,121,136,124,170,164,182**;Aug 12, 1996;Build 3
 ;; ;
 Q
 ;
 ;+Structure of Line with the line label "FORMAT"
 ;+;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;+      1         2             3                   4                                   5
 ;+
 ;+Structure of Following lines:
 ;+;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;+   1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~         10
 ;+The Display & Edit routines are for special cases.
 ;+  (The .01 fields cannot have a special edit.)
 ;
FORMAT ;;CPT~9000010.18~0,1,12,802,811,812~1~^AUPNVCPT
 ;;0~1~.01~CPT Code:  ~CPT Code:  ~$$DISPLY01^PXCECPT~ECPTCODE^PXCECPT~^D HELP^PXCEHELP~~B
 ;;0~19~.19~Department Code:  ~Department Code:  ~~DEPART^PXCECPT1~~~D
 ;;0~17~.17~Order Reference:  ~Order Reference:  ~~SKIP^PXCECPT~~~D
 ;;1~0~1~CPT Modifier:  ~CPT Modifier:  ~$$DISPMOD^PXCECPT~ECPTMOD^PXCECPT~Select a Modifier that is valid for the CPT code.~~B
 ;;0~4~.04~Provider Narrative:  ~Provider Narrative:  ~$$DNARRAT^PXCECPT~ENARRAT^PXCEPOV1(1,1,1,81,2)~~~B
 ;;0~16~.16~Quantity:  ~Quantity:  ~~EQUAN^PXCECPT~~~D
 ;;0~7~.07~Principal Procedure:  ~Principal Procedure:  ~~~~~D
 ;;12~2~1202~Ordering Provider:  ~Ordering Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;802~1~80201~Provider Narrative Category:  ~Provider Narrative Category:  ~$$DNARRAT^PXCECPT~ENARRAT^PXCEPOV1(0,2,0,81,3)~~C~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;0~5~.05~Primary Diagnosis:  ~Primary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;0~9~.09~1st Secondary Diagnosis:  ~1st Secondary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;0~10~.1~2nd Secondary Diagnosis:  ~2nd Secondary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;0~11~.11~3rd Secondary Diagnosis:  ~3rd Secondary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;0~12~.12~4th Secondary Diagnosis:  ~4th Secondary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;0~13~.13~5th Secondary Diagnosis:  ~5th Secondary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;0~14~.14~6th Secondary Diagnosis:  ~6th Secondary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;0~15~.15~7th Secondary Diagnosis:  ~7th Secondary Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCECPT~~~
 ;;
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;DG SELECT CPT PROCEDURE CODES
 ;+
 ;+********************************
 ;+Special cases for display.
 ;
DISPMOD(PXCECPT) ;
 ;+Display the modifiers associated with this V CPT entry.
 ;+PXCECPT = IEN in V CPT file.
 N MODS,SIEN,MODIEN,SCRATCH,MODSTR,MODNAME,OUTSTR
 I $G(PXCECPT)="" S PXCECPT=IEN
 S OUTSTR=""
 I PXCECPT="" Q OUTSTR
 S SIEN=0
 F MODS=1:1 S SIEN=$O(^AUPNVCPT(PXCECPT,1,SIEN)) Q:'SIEN  D
 . S MODIEN=$P($G(^AUPNVCPT(PXCECPT,1,SIEN,0)),"^")
 . S $P(OUTSTR,U,MODS)=$$MODTEXT(MODIEN)
 Q OUTSTR
DNARRAT(PNAR) ;+Display Provider Narrative for procedure in V CPT file.
 I PNAR="" Q ""
 N PXCEPNAR
 S PXCEPNAR=$P(^AUTNPOV(PNAR,0),"^")
 I $G(VIEW)="B",$D(ENTRY)>0 D
 . ;N DIC,DR,DA,DIQ,PXCEDIQ1
 . ;S DIC=81
 . ;S DR="2"
 . ;S DA=$P(ENTRY(0),"^",1)
 . ;S DIQ="PXCEDIQ1("
 . ;S DIQ(0)="E"
 . ;D EN^DIQ1
 . ;S:PXCEDIQ1(81,DA,2,"E")=PXCEPNAR PXCEPNAR=""
 . N CPTSTR
 . S CPTSTR=$$CPT^ICPTCOD($P(ENTRY(0),U),$P(^AUPNVSIT(PXCEVIEN,0),U))
 . S:$P(CPTSTR,U,3)=PXCEPNAR PXCEPNAR=""
 Q PXCEPNAR
 ;+
 ;+********************************
 ;+Special cases for edit.
 ;+
ECPTCODE ;+Code to edit CPT Code in V CPT file.
 K DIRUT
 N DIC,DA,PXCPTDT,PXDFLT
 S PXCPTDT=+^TMP("PXK",$J,"VST",1,0,"AFTER")
 S (X,PXDFLT)=""
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S PXDFLT=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S Y=$$GETCODE^PXCPTAPI(PXDFLT,PXCPTDT)
 I Y="@" S X="@" Q
 I Y<0 S DIRUT=1 Q
 S PXCEMOD=$P(Y,"-",2)
 S Y=$P(Y,"-"),X=+Y
 I PXCEDIRB="" Q
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=X Q
 Q:$$CHGCPT()
 G ECPTCODE
 ;
ECPTMOD ;+Prompt for CPT Modifier in V CPT file.
 ;
 ;--If there are no modifiers for CPT code do not prompt
 Q:PXMDCNT'>0
 N DTOUT,DUOUT,DIROUT,DIR,PXSUB,PXSEQ,PXSTR,PXARR
 N DA,DIC,PXLINE,SUBIEN,PXFILE,PXMOD,PXI
 S PXSUB=1,PXSTR=""
 S DA=^TMP("PXK",$J,PXCECATS,1,"IEN")
 S DR=1
 S DIE="^AUPNVCPT("
 S DIC(0)="AELMQ"
 L +@(DIE_"DA)"):10
 I $G(PXCEMOD)]"" D
 . I $L(PXCEMOD,",")=1 S DR="1//"_PXCEMOD Q
 . S PXMOD=""
 . F PXI=1:1 S PXMOD=$P(PXCEMOD,",",PXI) Q:PXMOD=""  D
 .. K PXERR
 .. D VAL^DIE(9000010.181,DA,.01,"",PXMOD,.PXERR)
 .. Q:PXERR="^"
 .. S DR="1///^S X=PXMOD"
 .. D ^DIE
 . S DR=1
 D ^DIE
 L -@(DIE_"DA)")
 ; SET NEWLY FILED CPT MODIFIERS INTO LOCAL ARRAY
 K PXCEAFTR(1)
 D GETS^DIQ(9000010.18,^TMP("PXK",$J,PXCECATS,1,"IEN"),"1*","I","PXARR")
 S PXFILE=9000010.181
 S PXSUB=""
 F  S PXSUB=$O(PXARR(PXFILE,PXSUB)) Q:PXSUB=""  D
 . S PXCEAFTR(1,$P(PXSUB,","))=PXARR(PXFILE,PXSUB,.01,"I")
 I $D(DTOUT)!$D(Y) S (PXCEEND,PXCEQUIT)=1 Q
 Q
 ;
EQUAN ;+Code to edit Quantity in V CPT file.
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 E  S DIR("B")=1
 S DIR(0)=PXCEFILE_","_$P(PXCETEXT,"~",3)_"A"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q
 I +Y<1 W !,$C(7),"Quantity is required.",! G EQUAN
 N PXTMPCPT S PXTMPCPT=$P(PXCEAFTR($P(PXCETEXT,"~")),"^")
 I +Y>1,$$GET1^DIQ(357.69,$G(PXCEIN01),.01)>0,$$GET1^DIQ(357.69,$G(PXCEIN01),.06,"I")'="Y" D
 .W !,"E&M code, quantity changed to 1."
 .S $P(Y,"^")=1
 S:$P(Y,"^")="" Y=1
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 Q
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
 ;I '+Y S PXCEEND=1 Q  ;S:$P(PXCETEXT,"~",3)=".05" PXCEQUIT=1 Q
 I +Y'>0 S PXCEEND=1 Q  ;PX*1.0*182 for "^" or null entry from list
 ;See if this diagnosis is in the PXCEAFTR(0)
 I $P(PXCETEXT,"~",2)'=5,(+Y=$P($G(PXCEAFTR(0)),"^",5)) S PXCEEND=1
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
 ;+
 ;+********************************
 ;+Special Reusable Functionality
DISPLY01(PXCECPT) ;
 ;Display text for the .01 field which is a pointer to ^ICPT.
 ;Also called with the Evaluation and Management Code from the visit
 ;  in the parameter.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
 ;N DIC,DR,DA,DIQ,PXCEFNUM,PXCEDIQ1
 ;S (DIC,PXCEFNUM)=81
 ;S DR=".01;2"
 ;S DA=+$P(PXCECPT,"^",1)
 ;S DIQ="PXCEDIQ1("
 ;S DIQ(0)="E"
 ;D EN^DIQ1
 ;Q PXCEDIQ1(PXCEFNUM,DA,.01,"E")_"     "_PXCEDIQ1(PXCEFNUM,DA,2,"E")
 N CPTSTR
 S CPTSTR=$$CPT^ICPTCOD($P(PXCECPT,U),$P(^AUPNVSIT(PXCEVIEN,0),U))
 Q $P(CPTSTR,U,2)_"     "_$P(CPTSTR,U,3)
EDMOD(MODS,CPT) ;+Edit the Modifiers for a CPT code entry.
 N MNUM S MNUM=0 ; Modifier number.
 N MIEN,MTEXT
 Q
MODNAME(MODIEN) ;+Return #.02 NAME for this CPT MODIFIER (#81.3)
 Q
MODTEXT(MODIEN) ;+Return string of text describing modifier.
 ;+MODIEN = IEN in CPT MODIFIER file (#81.3).
 ;+Returns:  MODIFIER (#.01) followed by NAME(#.02).
 N MOD,DESC,TEXT,RVAL
 S RVAL=$$MOD^ICPTMOD(MODIEN,"I",$P(^AUPNVSIT(PXCEVIEN,0),U))
 S MOD=$P(RVAL,"^",2)
 S DESC=$P(RVAL,"^",3)
 S TEXT=MOD_"  "_DESC
 Q TEXT
CHGCPT() ;Verify CPT code should be modified
 ;If response is yes remove modifiers on file for CPT code
 N DIR,DA,X,Y,PXIEN
 W !!,$C(7),"WARNING!  THIS WILL ALSO DELETE ANY MODIFIERS ASSOCIATED WITH CPT CODE "_PXCEDIRB
 S DIR(0)="Y"
 S DIR("A")="SURE YOU WANT TO CHANGE THE CPT CODE?"
 S DIR("B")="YES"
 D ^DIR
 ;Delete CPT Modifiers from V CPT file for current IEN
 I 'Y Q +Y
 S DA(1)=PXCEFIEN
 S DIK="^AUPNVCPT("_DA(1)_","_1_","
 S PXIEN=""
 F  S PXIEN=$O(PXCEAFTR(1,PXIEN)) Q:PXIEN=""  D
 . S DA=PXIEN
 . D ^DIK
 Q 1
 ;
NEWCODE ;
 K DD,DO
 N DIC,X,Y
 S DIC="^AUPNVCPT("
 S DIC(0)=""
 S DIC("DR")=".02////^S X=$P(PXCEAFTR(0),""^"",2);"
 S DIC("DR")=DIC("DR")_".03////^S X=$P(PXCEAFTR(0),""^"",3);"
 S X=PXCEIN01
 D FILE^DICN
 S PXCEFIEN=+Y
 Q
 ;
SKIP ;
 Q
