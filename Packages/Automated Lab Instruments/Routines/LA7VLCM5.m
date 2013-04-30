LA7VLCM5 ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;07/07/09  14:22
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
LOOKUP(GBL,FIND,OUT,ACTN,SCRN,IDARR) ;
 ; DIC clone for use with "special" cross reference.
 ; Allows programmer to display user choices from the xref of
 ; their choosing.
 ; Useful when trying to work with sub-file entries as top-level
 ; "pick-list" entries and the sub-file has a "Whole File" xref
 ; defined.
 ;
 ; Inputs
 ;     GBL Open global reference of the xref to use (up to xref)
 ;         Should be a "standard B" xref type structure (ie #
 ;         of subscripts in node doesnt change between nodes)
 ;         xref: ^XYZ(123,"AF",1,2)="" then GBL = ^XYZ(123,"AF",
 ;    FIND The target text to find in the xref
 ;     OUT <byref> See Outputs below
 ;    ACTN See Outputs below
 ;    SCRN <opt> Data Screen
 ;   IDARR <opt><byref>
 ;         IDARR("NODE0") = full global reference to data zero node
 ;          ie: IDENT("NODE0")="^XYZ(123.2,DA(1),1,DA,0)"
 ;         IDARR("DA",n)= DA location in GBL node
 ;          ie: IDENT("DA",0)=3 ;DA is subscr #3 in GBL var
 ;         IDARR("W") = additional Identifier to display
 ;          ie: IDENT("W")="W "Another Identifier"""
 ;         IDARR("NOIDENT") : if set FM IDENTIFIER wont display
 ;         IDARR("POINTER") : defines File# if NODE is a POINTER
 ;                            ie IDARR("POINTER")=61.2
 ;                            If VPointer specify as FM var pointer:
 ;                            ie "LAB(61.2;LAB(62.49;" etc..
 ;         IDARR("UNIQUE") : If set only displays the matches that
 ;                           havent been displayed already.
 ;
 ; Outputs
 ;  Returns 0 if FIND not found, 1 if FIND was found.
 ;   If return = 0 should check ACTN for return status
 ;
 ;     OUT <byref> If FIND was found OUT will contain:
 ;           OUT = Text value of selected entry
 ;           OUT(1) = GBL's full node of the selected entry
 ;    ACTN "^" = abort listing, >-1 = # records displayed
 ;          -1 = FIND was not found in xref
 ;
 N NODE,NODETOP,NODE0,STOP,FOUND,X,X2,I,SUBSCR
 N SHOWALL,CNT,CNTLST,CNT2,ISPTR,ISVPTR,UNIQUE
 N VAL,LASTVAL,STATUS,TMPNM,IN,DA,IDENT,DIC,DO,IOCUU,%ZIS
 N DIR,DUOUT,DIRUT
 S TMPNM="LA7VLCM5-LOOKUP"
 K ^TMP(TMPNM,$J)
 S GBL=$G(GBL)
 S SCRN=$G(SCRN)
 K OUT,ACTN
 S ACTN=0
 S (FOUND,STOP,SHOWALL,CNT,CNTLST,CNT2,STATUS)=0
 S NODE0=$G(IDARR("NODE0"))
 S NODE=GBL
 S NODETOP=""
 ; setup screen control variables
 I FIND="??" I $G(IOST(0))'="" D  ;
 . S X="IOCUU" ;cursor up
 . D ENDR^%ZISS
 . K %ZIS
 I FIND'="??" D  ;
 . S NODE=NODE_""""_FIND_""")"
 . S SUBSCR=$QL(NODE)
 I FIND="??" D  ;
 . S NODE=$$TRIM^XLFSTR(NODE,"R",",")
 . I $E(NODE,1,$L(NODE))'=")" S NODE=NODE_")"
 . S SUBSCR=$QL(NODE)+1
 ;
 S (ISPTR,ISVPTR,UNIQUE)=0
 I $G(IDARR("POINTER"))'="" D  ;
 . S ISPTR=1
 . I IDARR("POINTER")[";" S ISVPTR=1
 I $D(IDARR("UNIQUE")) S UNIQUE=1
 ;
 I FIND="??" S SHOWALL=1
 S LASTVAL=""
 F  S NODE=$Q(@NODE) S X=$TR($E(NODE,1,$L(GBL)),"""","") S X2=$TR(GBL,"""","") Q:X'[X2  D  Q:STOP  Q:FOUND  ;
 . I CNT2=0 I SHOWALL W !,"Choose from:"
 . ; dont process NODE if # of subscripts doesnt match
 . I NODETOP="" S NODETOP=NODE
 . I NODETOP'="" I $QL(NODE)'=$QL(NODETOP) Q
 . S CNT2=CNT2+1 ;number of nodes checked
 . I $D(IDARR) D  ;
 . . ;setup DA array
 . . K DA
 . . S I=""
 . . F  S I=$O(IDARR("DA",I)) Q:I=""  S X=IDARR("DA",I) S:I>0 DA(I)=$QS(NODE,X) S:I=0 DA=$QS(NODE,X)
 . . ; setup FileMan IDENTIFIER
 . . I '$D(IDENT) I '$D(IDARR("NOIDENT")) D  ;
 . . . S IDENT=""
 . . . K DIC,DO
 . . . S X=$G(IDARR("NODE0"))
 . . . Q:X=""
 . . . S X=$P(X,",DA,",1)
 . . . S X=X_")"
 . . . S X=$NA(@X)
 . . . S X=$$TRIM^XLFSTR(X,"R",")")
 . . . S X=$$TRIM^XLFSTR(X,"R",",")
 . . . S DIC=X_","
 . . . S DIC(0)=""
 . . . D DO^DIC1
 . . . S IDENT=$G(DIC("W"))
 . . ;
 . ;
 . S VAL=$QS(NODE,SUBSCR)
 . I SCRN'="" D  Q:'$T  ;
 . . I NODE0'="" S X=@NODE0 ; set naked gbl reference
 . . X SCRN
 . . S LASTVAL=VAL
 . ;
 . I 'SHOWALL I $E(VAL,1,$L(FIND))'=FIND S LASTVAL=VAL Q  ; SHOWALL for "??" entry
 . I 'SHOWALL I VAL=FIND D  Q:FOUND  ;
 . . I $G(IDENT)'="" D  ;
 . . . I NODE0'="" S X=@NODE0 ; set naked gbl reference
 . . . X IDENT
 . . I $G(IDARR("W"))'="" D  ;
 . . . I NODE0'="" S X=@NODE0 ; set naked gbl reference
 . . . X IDARR("W")
 . . ; If a direct match ask "...OK  //Yes?"
 . . K DIR
 . . S DIR(0)="YAO"
 . . S DIR("A")="        ... OK "
 . . S DIR("B")="Yes"
 . . D ^DIR
 . . I Y D  ;
 . . . S FOUND=1
 . . . S ^TMP(TMPNM,$J,1,1)=VAL
 . . . S ^TMP(TMPNM,$J,1,2)=NODE
 . . ;
 . ;
 . S CNT=CNT+1
 . S ^TMP(TMPNM,$J,CNT,1)=VAL
 . S ^TMP(TMPNM,$J,CNT,2)=NODE
 . I 'SHOWALL W !,?5,CNT,?10,VAL
 . ;
 . I SHOWALL I 'ISPTR D  ;
 . . I 'UNIQUE W !,"   ",VAL Q
 . . I VAL'=LASTVAL W !,"   ",VAL
 . ;
 . I SHOWALL I ISPTR D  ;
 . . N MSG,DIERR
 . . S X=IDARR("POINTER")
 . . S X=$$GET1^DIQ(X,VAL_",",.01,"","","MSG")
 . . I 'UNIQUE D  ;
 . . . I X'="" W !,"   ",X
 . . . I X="" W !,"   ",VAL
 . . ;
 . . I UNIQUE D  ;
 . . . I VAL'=LASTVAL I X'="" W !,"   ",X
 . . . I VAL'=LASTVAL I X="" W !,"   ",VAL
 . . ;
 . ;
 . I $G(IDENT)'="" D  ;
 . . I NODE0'="" S X=@NODE0 ; set naked gbl reference
 . . X IDENT
 . I $G(IDARR("W"))'="" D  ;
 . . I NODE0'="" S X=@NODE0 ; set naked gbl reference
 . . X IDARR("W")
 . S LASTVAL=VAL
 . ;
 . I (SHOWALL&((CNT#($G(IOSL,24)-2)=0)))!('SHOWALL&(CNT#5=0)) D  ;
 . . S CNTLST=CNT
 . . K DIR
 . . S DIR(0)="FAOUr^^"
 . . S DIR("?")=" "
 . . I 'SHOWALL D  ;
 . . . S DIR("?",1)="Press <RETURN> to see more, '^' to exit this list,"
 . . I SHOWALL D  ;
 . . . S DIR("?",1)=""
 . . ;
 . . I 'SHOWALL D  ;
 . . . W !,"Press <RETURN> to see more, '^' to exit this list"
 . . ;
 . . I 'SHOWALL S DIR("A")="OR CHOOSE 1-"_CNT_": "
 . . I SHOWALL S DIR("A")="  '^' TO STOP "
 . . D ^DIR
 . . ;erase "'^' TO STOP" displayed
 . . I SHOWALL I $G(IOCUU)'="" W $C(13)_$J("",15)_$C(13)_IOCUU
 . . I +Y=Y I Y>0 I Y'>CNT S FOUND=Y Q
 . . I $E(Y,1,1)="^" S STOP=1
 . . I $D(DUOUT) S STOP=1
 . . I Y'="" S:$D(DIRUT) STOP=1
 . ;
 ;
 I 'SHOWALL I 'FOUND I CNT I CNT>CNTLST I 'STOP D  ;
 . ; last "CHOOSE 1-X" prompt
 . K DIR
 . S DIR(0)="FAOUr^^"
 . S DIR("?")=" "
 . S DIR("A")="CHOOSE 1-"_CNT_": "
 . D ^DIR
 . I +Y=Y I Y>0 I Y'>CNT S FOUND=Y Q
 . I $E(Y,1,1)="^" S STOP=1
 . S:$D(DUOUT) STOP=1
 . I Y'="" S:$D(DIRUT) STOP=1 Q
 ;
 I FOUND D  ;
 . S OUT=^TMP(TMPNM,$J,FOUND,1)
 . S OUT(1)=^TMP(TMPNM,$J,FOUND,2)
 . S STATUS=1
 . W "  ",OUT
 . ; print selected record's IDENTIFIER
 . I $D(IDARR) D  ;
 . . S NODE=OUT(1)
 . . ;setup DA array
 . . K DA
 . . S I=""
 . . F  S I=$O(IDARR("DA",I)) Q:I=""  S X=IDARR("DA",I) S:I>0 DA(I)=$QS(NODE,X) S:I=0 DA=$QS(NODE,X)
 . . I NODE0'="" S X=@NODE0 ; set naked gbl reference
 . . I IDENT'=""  I '$D(IDARR("NOIDENT")) X IDENT
 . . I $G(IDARR("W"))'="" X IDARR("W")
 . ;
 ;
 I STOP D  ;
 . S STATUS="0^1"
 . S ACTN="^"
 ;
 I 'FOUND I 'STOP D  ;
 . S STATUS=0
 . S ACTN=-1
 ;
 I CNT S ACTN=CNT
 K ^TMP(TMPNM,$J)
 Q STATUS
 ;
