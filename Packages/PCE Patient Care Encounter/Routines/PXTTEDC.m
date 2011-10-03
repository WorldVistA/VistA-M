PXTTEDC ;ISL/PKR,DLT,ISA/KWP/ESW - Code to copy an education topic entry making sure it is unique. ;5/20/96  12:06
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**106**;Aug 12, 1996
 ;
 ;=======================================================================
COPYED ;Copy an education topic into the site's range of IENS.
 N PROMPT,ROOT,WHAT
 S WHAT="education topic"
 S ROOT="^AUTTEDT("
 S PROMPT="Select the EDUCATION TOPIC to copy: "
 D COPY(PROMPT,ROOT)
 Q
 ;
 ;=======================================================================
COPY(PROMPT,ROOT) ;Copy an entry of ROOT into a new entry.
 N DIC,DUOUT,DTOUT,DIROUT,DIRUT,SIEN,IENN,IENO,PXTTSNUM,X,Y
 S PXTTSNUM=+$P($$SITE^VASITE,U,3)
 I $L(PXTTSNUM)'=3 W !,"You must have a 3-digit primary station number in order to use this option, See IRM!" Q
 ;
 F  D GETORGR Q:$D(DIROUT)  Q:$D(DTOUT)
 Q
 ;
GETORGR ;Look-up logic to get and copy source entry in education topic file.
 ;PXNAT - a variable to be setup to 1 in ACTION ENTRY field of OPTION
 ;        file:
 ;             PXTT COPY EDUCATION TOPICS
 ;        while copying a topic in a national package
 ;
 S DIC=ROOT,DIC(0)="AMEQ",DIC("A")=PROMPT
 W !
 D ^DIC I $D(DUOUT)!$D(DTOUT) S DIROUT="" Q
 S IENO=$P(Y,U,1)
 I IENO=-1 S DIROUT="" Q
 ;
 S IENN=$S(+$G(PXNAT):1,1:+PXTTSNUM_"001")
 S IENN=$$GETFOIEN(ROOT,IENN)
 ;Lock the file before merging.
 L +^AUTTEDT(IENN):10
 D MERGE(IENN,IENO,ROOT)
 ;
 ;Unlock the file.
 L -^AUTTEDT(IENN)
 ;
 N DA,DIE,DIK,DIR,DR,ENTRY,NAME,ORGNAME
 S ENTRY=ROOT_IENN_","_"0)"
 S NAME=$P($G(@ENTRY),U,1),ORGNAME=NAME
 ; If there is a VA- or VA*- in the copied name get rid of it.
 I $F(NAME,"VA-")>0 S NAME=$$STRREP(NAME,"VA-","")
 I $F(NAME,"VA*-")>0 S NAME=$$STRREP(NAME,"VA*-","")
 ;
UNIQ ;Make sure the name is unique.
 S Y=""
 I $D(^AUTTEDT("B",NAME)) D  Q:$D(DIRUT)
 . S DIR(0)="F"_U_"3:30"_U_"K:(X?.N)!'(X'?1P.E) X"
 . S DIR("A")=NAME_" - IS A DUPLICATE NAME, PLEASE ENTER A UNIQUE NAME"
 . D ^DIR I $D(DIRUT) D DELETE Q
 . S NAME=Y
 I Y'="" G UNIQ
 ;
NOVA ;Sites are not allowed to use VA in their names.
 S Y=""
 I '$G(PXNAT)&($$VADSTN(NAME)) D  Q:$D(DIRUT)
 . S DIR(0)="F"_U_"3:30"_U_"K:(X?.N)!'(X'?1P.E) X"
 . S DIR("A")=NAME_" CANNOT START WITH ""VA-"", INPUT A DIFFERENT ONE"
 . D ^DIR I $D(DIRUT) D DELETE Q
 . S NAME=Y
 I Y'="" G UNIQ
 ;
 ;Store the unique name
 S DR=".01///^S X=NAME",DIE=ROOT,DA=IENN
 D ^DIE
 ;
 ;Reindex the cross-references.
 S DIK=ROOT,DA=IENN
 D IX^DIK
 ;
 ;Tell the user what has happened and allow for editing of the new item.
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to edit it now"
 S DIR("A",1)="The original education topic "_ORGNAME_" has been copied into "_NAME_"."
 D ^DIR Q:$D(DIRUT)
 I Y D
 . N DIE,DR
 . S DIE=ROOT,DR="[PXTT EDIT PAT. EDUCATION]"
 . D ^DIE
 . Q 
 Q
 ;
 ;=======================================================================
GETFOIEN(ROOT,SIEN) ;Given ROOT and a starting IEN (SIEN) return the first
 ;open IEN in ROOT
 N ENTRY,NIEN,OIEN
 S OIEN=SIEN-1
 S ENTRY=ROOT_OIEN_")"
 F  S NIEN=$O(@ENTRY) Q:+(NIEN-OIEN)>1  Q:+NIEN'>0  S OIEN=NIEN,ENTRY=ROOT_NIEN_")"
 Q OIEN+1
 ;
 ;=======================================================================
MERGE(IENN,IENO,ROOT) ;Use MERGE to copy ROOT(IENO into ROOT(IENN.
 N DEST,SOURCE
 ;
 S DEST=ROOT_IENN_")"
 S SOURCE=ROOT_IENO_")"
 M @DEST=@SOURCE
 Q
 ;
 ;=======================================================================
VADSTN(NAME) ;Return TRUE (1) if VA- starts the NAME.
 I $F(NAME,"VA-")=4 Q 1
 I $F(NAME,"VA*-")=5 Q 1
 E  Q 0
 ;
 ;=======================================================================
STRREP(STRING,TS,RS) ;Replace every occurence of the target string (TS)
 ;in STRING with the replacement string (RS).
 ;Example 9.19 (page 220) in "The Complete Mumps" by John Lewkowicz:
 ;
 N FROM,NPCS,STR
 ;
 I STRING'[TS Q STRING
 ;Count the number of pieces using the target string as the delimiter.
 S FROM=1
 F NPCS=1:1 S FROM=$F(STRING,TS,FROM) Q:FROM=0
 ;Extract the pieces and concatenate RS
 S STR=""
 F FROM=1:1:NPCS-1 S STR=STR_$P(STRING,TS,FROM)_RS
 S STR=STR_$P(STRING,TS,NPCS)
 Q STR
 ;
DELETE ;Delete the entry just added. 
 S DIK=ROOT,DA=IENN D ^DIK
 W !!,"New entry not created due to invalid education topic name!",!
 Q
 ;
