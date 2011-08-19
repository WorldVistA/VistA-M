LEXSET5 ; ISL Setup Appl/User Defaults for Look-up ; 05/25/1998
 ;;2.0;LEXICON UTILITY;**6,11**;Sep 23, 1996
 ;
EN ; Set variables
 D:+($G(LEXQ))=0 MTLU
 D:+($G(LEXQ))=1 QUIET
 K LEXD
 Q
QUIET ;
 N LEXMP S LEXMP="" D DIC0
 I $L($G(LEXD("DF","LEXAP"))) S ^TMP("LEXSCH",$J,"APP",0)=LEXD("DF","LEXAP"),^TMP("LEXSCH",$J,"APP",1)=$$APPN^LEXDFN(LEXD("DF","LEXAP"))
 I $L($G(LEXD("DF","DIS"))) S ^TMP("LEXSCH",$J,"DIS",0)=LEXD("DF","DIS"),^TMP("LEXSCH",$J,"DIS",1)=$$DISN^LEXDFN(LEXD("DF","DIS"))
 I $L($G(LEXD("DF","FIL"))) S ^TMP("LEXSCH",$J,"FIL",0)=LEXD("DF","FIL"),^TMP("LEXSCH",$J,"FIL",1)=$$FILN^LEXDFN(LEXD("DF","FIL"))
 I $L($G(LEXD("DF","GBL"))) S (DIC,^TMP("LEXSCH",$J,"GBL",0))=LEXD("DF","GBL"),^TMP("LEXSCH",$J,"GBL",1)=$$GBLN^LEXDFN(LEXD("DF","GBL"))
 I $L($G(LEXD("DF","IDX"))) S ^TMP("LEXSCH",$J,"IDX",0)=LEXD("DF","IDX"),^TMP("LEXSCH",$J,"IDX",1)=$$IDXN^LEXDFN(LEXD("DF","IDX"))
 I $L($G(LEXD("DF","OVR"))) S ^TMP("LEXSCH",$J,"OVR",0)=LEXD("DF","OVR"),^TMP("LEXSCH",$J,"OVR",1)=$$OVRN^LEXDFN(LEXD("DF","OVR"))
 I $L($G(LEXD("DF","SCT"))) S ^TMP("LEXSCH",$J,"SCT",0)=LEXD("DF","SCT"),^TMP("LEXSCH",$J,"SCT",1)=$$SCTN^LEXDFN(LEXD("DF","SCT"))
 I $L($G(LEXD("DF","UNR"))) S ^TMP("LEXSCH",$J,"UNR",0)=LEXD("DF","UNR"),^TMP("LEXSCH",$J,"UNR",1)=$$UNRN^LEXDFN(LEXD("DF","UNR"))
 ; Modifiers       PCH 6
 I $L($G(LEXD("DF","MOD"))) S ^TMP("LEXSCH",$J,"MOD",0)=LEXD("DF","MOD"),^TMP("LEXSCH",$J,"MOD",1)=$$MODI^LEXDFN(LEXD("DF","MOD"))
 I $L($G(LEXD("DF","VOC"))) S ^TMP("LEXSCH",$J,"VOC",0)=LEXD("DF","VOC"),^TMP("LEXSCH",$J,"VOC",1)=$$VOCN^LEXDFN(LEXD("DF","VOC"))
 I '$L($G(LEXD("DF","VOC"))),$L($G(LEXD("DF","SUB"))) S ^TMP("LEXSCH",$J,"VOC",0)=LEXD("DF","SUB"),^TMP("LEXSCH",$J,"VOC",1)=$$VOCN^LEXDFN(LEXD("DF","SUB"))
 I $L($G(LEXD("DF","FLN"))) S ^TMP("LEXSCH",$J,"FLN",0)=LEXD("DF","FLN"),^TMP("LEXSCH",$J,"FLN",1)="File Number"
 I +($G(LEXLL))>0 S ^TMP("LEXSCH",$J,"LEN",0)=+LEXLL
 I +($G(LEXLL))'>0 S ^TMP("LEXSCH",$J,"LEN",0)=5
 S ^TMP("LEXSCH",$J,"LEN",1)="List Length"
 N LEXLOC,LEXSVC S (LEXLOC,LEXSVC)=""
 S DUZ=+($G(DUZ)) I DUZ>0,$D(^VA(200,DUZ)) D
 . S LEXLOC=$P($G(^VA(200,DUZ,100.1)),U,7) S:+($G(LEXLOC))=0 LEXLOC=""
 . S:$L($G(LEXLOC))&(+($G(LEXLOC))>0) LEXLOC=$P($G(^SC(LEXLOC,0)),U,1)
 . S LEXSVC=$P($G(^VA(200,DUZ,5)),U,1) S:+($G(LEXSVC))=0 LEXSVC=""
 . S:$L($G(LEXSVC))&(+($G(LEXSVC))>0) LEXSVC=$P($G(^DIC(49,LEXSVC,0)),U,1)
 S ^TMP("LEXSCH",$J,"LOC",0)=$E(LEXLOC,1,40),^TMP("LEXSCH",$J,"LOC",1)="User Hospital Location"
 S ^TMP("LEXSCH",$J,"SVC",0)=$E(LEXSVC,1,40),^TMP("LEXSCH",$J,"SVC",1)="User Service"
 S ^TMP("LEXSCH",$J,"USR",0)=+($G(DUZ)),^TMP("LEXSCH",$J,"USR",1)="User"
 Q
 Q
MTLU ; MTLU Defaults
 K LEXSHOW,LEXSUB,XTLKGBL,XTLKKSCH S DIC=""
 S:$L($G(LEXD("DF","GBL"))) (DIC,XTLKGBL,XTLKKSCH("GBL"))=LEXD("DF","GBL")
 S:$L($G(LEXD("DF","DSP"))) XTLKKSCH("DSPLY")=LEXD("DF","DSP")
 S:$L($G(LEXD("DF","IDX"))) XTLKKSCH("INDEX")=LEXD("DF","IDX")
 S:$L($G(LEXD("DF","HLP"))) XTLKHLP=LEXD("DF","HLP")
 S:$L($G(LEXD("DF","LEXAP"))) LEXAP=LEXD("DF","LEXAP")
 S:$L($G(LEXD("DF","UNR"))) LEXUN=LEXD("DF","UNR")
 S:$L($G(LEXD("DF","DIS"))) LEXSHOW=LEXD("DF","DIS")
 S:$L($G(LEXD("DF","SUB"))) LEXSUB=LEXD("DF","SUB")
 S:$L($G(LEXD("DF","FIL"))) DIC("S")=LEXD("DF","FIL")
 I DIC=""!('$D(LEXSUB)) D
 . S (DIC,XTLKGBL,XTLKKSCH("GBL"))="^LEX(757.01,"
 . S XTLKKSCH("INDEX")="AWRD",XTLKKSCH("DSPLY")="XTLK^LEXPRNT"
 . S XTLKHLP="D XTLK^LEXHLP",LEXAP=1,LEXLL=5,LEXUN=0
 . S:$L($G(^LEXT(757.2,1,200,+($G(DUZ)),1))) DIC("S")=$G(^LEXT(757.2,1,200,+($G(DUZ)),1))
 . S LEXSUB="WRD",LEXSHOW="ICD/CPT"
 . S:$L($G(^LEXT(757.2,1,200,+($G(DUZ)),2))) LEXSHOW=$G(^LEXT(757.2,1,200,+($G(DUZ)),2))
 S XTLKSAY=0 D DIC0 S:$L($G(X)) XTLKX=X
 Q
DIC0 S:'$L($G(DIC(0))) DIC(0)="EQM"
 S:'$L($G(X))&(DIC(0)'["A") DIC(0)="A"_DIC(0)
 S:DIC(0)["L" DIC(0)=$P(DIC(0),"L",1)_$P(DIC(0),"L",2)
 S:DIC(0)["I" DIC(0)=$P(DIC(0),"I",1)_$P(DIC(0),"L",2)
 Q
XTLK ; MTLU
 N LEXQ S LEXQ=0 D MTLU
 I '$D(X)!($G(X)[U)!($G(X)="")!($G(X)=" ") S X=$$TERM
 Q:X=""!(X["^")  S XTLKX=X D ^XTLKKWL
 K DIC,LEXAP,LEXLL,LEXSHOW,LEXSUB,LEXUN
 K XTLKKSCH,XTLKSAY,XTLKWD2,XTLKX,XTLKHLP S:+Y'>0 X=""
 Q
TERM(X) ; Expression
 N DIR,Y S DIR("A")="Enter an expression:  "
 S DIR("?")="    "_$$SQ^LEXHLP  ; PCH 11
 S DIR("??")="^D TERMHLP^LEXSET5" N Y S DIR(0)="FAO^2:245" D ^DIR
 S DIC="^LEX(757.01," S:X[U&(X'["^^") X=U S:X["^^" X="^^" Q:X[U "^"
 I X=" ",+($G(^DISV(DUZ,DIC)))>0 S X=@(DIC_+($G(^DISV(DUZ,DIC)))_",0)") W " ",X
 F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 W:$D(DTOUT) !,"Try later.",! S:$D(DTOUT) X=""
 S:X[U DUOUT=1 K DIR,DIRUT,DIROUT Q X
TERMHLP ; Help  PCH 11
 N X S X="" S:$L($G(DIR("?"))) X=$G(DIR("?")) S:'$L(X) X="    "_$$SQ^LEXHLP
 W:$L(X) !!,X,!
 W !,"    Best results occur using one to three full or partial words without"
 W !,"    a suffix (i.e., ""DIABETES"",""DIAB MELL"",""DIAB MELL INSUL"") or"
 W !,"    a classification code (ICD, CPT, HCPCS, etc)"
 Q
