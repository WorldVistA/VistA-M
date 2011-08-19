SPNAHOCV ;HISC/DAD-AD HOC REPORTS: MACRO EXPORT COMPILER ; [ 06/15/95  8:23 PM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
BUILD ; *** Move macro data into routine
 W !!,"Building the Ad Hoc macro export routine(s)...",!
 S SPNMACRO="",SPNLN=1000,(SPNDONE,SPNLEN,SPNRTNNO,SPNTAB)=0
 K ^TMP($J,"SPNROU") D SAVE("PROG1")
 F  S SPNMACRO=$O(^TMP($J,"SPNMACRO",SPNMACRO)) Q:SPNMACRO=""  D
 . S SPND0=0
 . F  S SPND0=$O(^TMP($J,"SPNMACRO",SPNMACRO,SPND0)) Q:SPND0'>0  D
 .. S X=$G(^SPNL(154.8,SPND0,0)),SPNTYPE=$P(X,U,2) Q:X=""  D BLD(X)
 .. S SPND1=0
 .. F  S SPND1=$O(^SPNL(154.8,SPND0,"FLD",SPND1)) Q:SPND1'>0  D
 ... S X=$G(^SPNL(154.8,SPND0,"FLD",SPND1,0)) Q:X=""  D BLD(X)
 ... I SPNTYPE="s" D
 .... S X=$G(^SPNL(154.8,SPND0,"FLD",SPND1,"FRTO")) S:X="" X=U D BLD(X)
 .... Q
 ... Q
 .. D BLD("")
 .. S SPNDONE=$O(^TMP($J,"SPNMACRO",SPNMACRO))=""
 .. S SPNDONE=$O(^TMP($J,"SPNMACRO",SPNMACRO,SPND0))'>0&SPNDONE
 .. I SPNLEN'<4000!SPNDONE D SAVE("PROG2")
 .. Q
 . Q
 W !!,"Enter 'DO ^",SPNPROG,"' to install the exported Ad Hoc macros."
 Q
SAVE(PROG) ; *** Save routine
 S SPNRTN=$S(SPNRTNNO=0:SPNPROG,1:$E(SPNPROG,1,8-$L(SPNRTNNO))_SPNRTNNO)
 S SPNRTNXT=$S(SPNDONE:"",1:$E(SPNPROG,1,8-$L(SPNRTNNO+1))_(SPNRTNNO+1))
 F SP=1:1 S X=$P($T(@PROG+SP),";;",2,99) Q:X=""  D
 . X "S Y="_X S ^TMP($J,"SPNROU",SP,0)=Y
 . Q
 S DIE="^TMP($J,""SPNROU"",",XCN=0,X=SPNRTN X ^%ZOSF("SAVE")
 K ^TMP($J,"SPNROU") S SPNLEN=0,SPNRTNNO=SPNRTNNO+1
 W:SPNTAB=0 ! W ?SPNTAB,SPNRTN S SPNTAB=SPNTAB+$S(SPNTAB=70:-70,1:10)
 Q
BLD(X) ; *** Build data line
 S X=" ;;"_X,SPNLEN=SPNLEN+$L(X)+2
 S ^TMP($J,"SPNROU",SPNLN,0)=X,SPNLN=SPNLN+1
 Q
ID(D0) ; *** Macro identifiers
 W "    ",$$GET1^DIQ(154.8,D0_",",.02)
 W "    ",$$GET1^DIQ(154.8,D0_",",.03)
 Q
PROG1 ;; *** Routine that processes the Ad Hoc macros
 ;;SPNRTN_" ;HISC/DAD-AD HOC REPORTS: EXPORTED MACROS ;"_SPNTODAY
 ;;" ;;0.0;Package Name;;Mmm DD, YYYY"
 ;;" ;;"_$P($T(SPNAHOCV+1),";",3,4)_";;"_$P($T(SPNAHOCV+1),";",6)
 ;;" W !,""=== Ad Hoc Macro Installer ==="""
 ;;" I $$VFILE^DILFD(154.8)=0 D  G EXIT"
 ;;" . W $C(7),!!?3,""The Ad Hoc Macro file does not exist !!"""
 ;;" . Q"
 ;;" K DIR S DIR(0)=""YOAM"",DIR(""A"")=""Install macros? "",DIR(""B"")=""No"""
 ;;" W ! D ^DIR W ! I Y D ^"_SPNRTNXT
 ;;"EXIT ; *** Clean-up and quit"
 ;;" K DA,DD,DIC,DIE,DIK,DINUM,DIR,DIRUT,DLAYGO,DO,DR,DTOUT,DUOUT,SPND0"
 ;;" K SPNDATA,SPNDHD,SPNDIPCR,SPNCHKSM,SPNFIELD,SPNFOUND,SPNINCR,SPNMACRO"
 ;;" K SPNMD0,SPNMD1,SPNNAME,SPNPFILE,SPNTYPE,X,Y"
 ;;" Q"
 ;;"PROCESS ; *** Process a macro"
 ;;" S SPNNAME=$P(SPNDATA(0),U),SPNTYPE=$P(SPNDATA(0),U,2)"
 ;;" S SPNPFILE=$P(SPNDATA(0),U,3),SPNCHKSM=$P(SPNDATA(0),U,4)"
 ;;" S SPNDIPCR=$P(SPNDATA(0),U,5),SPNDHD=$P(SPNDATA(0),U,6)"
 ;;" S (SPND0,SPNFOUND)=0"
 ;;" F  S SPND0=$O(^SPNL(154.8,""B"",SPNNAME,SPND0)) Q:SPND0'>0!SPNFOUND  D"
 ;;" . S SPNDATA=$G(^SPNL(154.8,SPND0,0))"
 ;;" . I $P(SPNDATA,U,1,3)=$P(SPNDATA(0),U,1,3) S SPNFOUND=1"
 ;;" . I SPNCHKSM=$P(SPNDATA,U,4)!'SPNFOUND Q"
 ;;" . S SPNFOUND=0,DA=SPND0,DIK=""^SPNL(154.8,"" D ^DIK"
 ;;" . Q"
 ;;" I SPNFOUND W !,""Skipping Ad Hoc macro '"",SPNNAME,""', already exists."" Q"
 ;;" W !,""Adding Ad Hoc macro '"",SPNNAME,""'."""
 ;;" K DD,DIC,DINUM,DO S DIC=""^SPNL(154.8,"",DIC(0)=""LM"""
 ;;" S DLAYGO=154.8,X=SPNNAME D FILE^DICN S SPNMD0=+Y"
 ;;" I SPNMD0'>0 W !?5,""Could not add Ad Hoc macro '"",SPNNAME,""'?!"" Q"
 ;;" S DR="".02////""_SPNTYPE_"";.03////""_SPNPFILE"
 ;;" S DR=DR_"";.04////""_SPNCHKSM_"";.05////""_SPNDIPCR"
 ;;" S DIE=""^SPNL(154.8,"",DA=SPNMD0 D ^DIE"
 ;;" S $P(^SPNL(154.8,SPNMD0,0),U,6)=SPNDHD"
 ;;" S SPNMD1=0,SPNINCR=$S(SPNTYPE=""s"":2,1:1)"
 ;;" F SPNFIELD=1:SPNINCR S SPNDATA=$G(SPNDATA(SPNFIELD)) Q:SPNDATA=""""  D"
 ;;" . S SPNMD1=SPNMD1+1"
 ;;" . S ^SPNL(154.8,SPNMD0,""FLD"",SPNMD1,0)=SPNDATA"
 ;;" . I SPNTYPE=""p"" Q"
 ;;" . S SPNDATA=$G(SPNDATA(SPNFIELD+1))"
 ;;" . S ^SPNL(154.8,SPNMD0,""FLD"",SPNMD1,""FRTO"")=SPNDATA"
 ;;" . Q"
 ;;" S SPNDATA=$$GET1^DID(154.8,1,"""",""SPECIFIER"")_U_SPNMD1_U_SPNMD1"
 ;;" S ^SPNL(154.8,SPNMD0,""FLD"",0)=SPNDATA"
 ;;" S DIK=""^SPNL(154.8,"",DA=SPNMD0 D IX1^DIK"
 ;;" Q"
 ;;
PROG2 ;; *** Routine that contains the Ad Hoc macros
 ;;SPNRTN_" ;HISC/DAD-AD HOC REPORTS: EXPORTED MACROS ;"_SPNTODAY
 ;;" ;;0.0;Package Name;;Mmm DD, YYYY"
 ;;" ;;"_$P($T(SPNAHOCV+1),";",3,4)_";;"_$P($T(SPNAHOCV+1),";",6)
 ;;" K SPNDATA S SPNFIELD=0"
 ;;" F SPNMACRO=1:1 S SPNDATA=$T(MACRO+SPNMACRO) Q:SPNDATA=""""  D"
 ;;" . S SPNDATA=$P(SPNDATA,"";"",3,99)"
 ;;" . I SPNDATA="""" D PROCESS^"_SPNPROG_" K SPNDATA S SPNFIELD=0 Q"
 ;;" . S SPNDATA(SPNFIELD)=SPNDATA,SPNFIELD=SPNFIELD+1"
 ;;" . Q"
 ;;$S(SPNRTNXT]"":" G ^"_SPNRTNXT,1:" Q")
 ;;"MACRO ;;Macro data"
 ;;
