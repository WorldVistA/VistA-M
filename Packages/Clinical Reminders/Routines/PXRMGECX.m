PXRMGECX ;SLC/JVS - GEC Debug Utilities ;08/21/2003  08:54
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 Q
PROMPT ; Prompt for Correct Report
 N Y,X
 K DIR
 S DIR("A")="Select Option or ^ to Exit"
 S DIR("A",1)="These Reports are to Help with Degugging of Problems"
 S DIR("A",2)="**It could take 5 minutes !! or more to Complete Reports"
 I $D(^DISV(DUZ,"PXRMGEC","BG")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","BG"))
 S DIR(0)="S^B:Brief Health Factor Review;D:Detailed Health Factor Review"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 I Y="B" D PR1
 I Y="D" D PR
 Q:$D(DIRUT)!($D(DIROUT))
 S ^DISV(DUZ,"PXRMGEC","BG")=Y
 Q
 ;
DAS ;GET IENS OF TOP LEVEL DIALOGS WITH GEC IN THE IDENTITY FIELD
 F GECI="GEC1","GEC2","GEC3","GECF" D
 .S GECX=0 F  S GECX=$O(^PXRMD(801.41,"AC",GECI,GECX)) Q:GECX=""  S GECDA(GECX,GECI)=""
 Q
 ;
 ;
SCREEN(IEN) ;Screen for use in GEC Dialog Group
 N REFB,REF10,TREE,DGIEN,IENN,GECX,GECI,DGDA,DGNA
 N DIASYN
 S DGNA="",DGDA=0,OK=0
 S REFB="^PXRMD(801.41,""B"")"
 S REF10="^PXRMD(801.41)"
 S DGNA="VA-" F  S DGNA=$O(@REFB@(DGNA)) Q:DGNA'["VA-"  D
 .S DGDA=$O(@REFB@(DGNA,0))
 .I $P($P($G(^PXRMD(801.41,DGDA,1)),"^",5),";",1)=IEN!($$MUL(IEN,DGDA)) D
 ..I $P($G(^PXRMD(801.41,DGDA,0)),"^",1)["HF GEC "!($P($G(^PXRMD(801.41,DGDA,0)),"^",1)["DG GEC ") S DGIEN=DGDA
 ..I $D(DGIEN) S TREE(DGIEN)=""
 Q:'$D(DGIEN) OK
ST I $D(^PXRMD(801.41,"AD",DGIEN)) D
 .S IENN=0 F  S IENN=$O(^PXRMD(801.41,"AD",DGIEN,IENN)) Q:IENN=""!(OK=1)  D
 ..I $D(GECDA(IENN)) S OK=1,HFDIA(IEN,$O(GECDA(IENN,"")))="" S ^TMP("PXRMGECX",$J,"TEXT",IENN,DGIEN,IEN)=""
 ..I OK=1 K TREE
 ..I OK=0 S TREE(IENN)=""
REDO I $D(TREE) D
 .S TIEN=0 F  S TIEN=$O(TREE(TIEN)) Q:TIEN=""!(OK=1)  D  S TIEN=0
 ..S IENN=0 F  S IENN=$O(^PXRMD(801.41,"AD",TIEN,IENN)) Q:IENN=""  D
 ...I $D(GECDA(IENN)) S OK=1,HFDIA(IEN,$O(GECDA(IENN,"")))="" S ^TMP("PXRMGECX",$J,"TEXT",IENN,DGIEN,IEN)=""
 ...I OK=0,'$D(DONE(IENN)) S TREE(IENN)=""
 ..K TREE(TIEN) S DONE(TIEN)=""
 I OK=0&($D(TREE)) G REDO
 K TREE,IENN,DONE
 Q OK
 ;
MUL(IEN,DGDA) ;SEARCH ADDITONAL FINDINGS
 N YES
 S YES=0
 I $D(^PXRMD(801.41,DGDA,3,"B",IEN_";AUTTHF(")) S YES=1
 Q YES
 ;
HF ;Gather Health Factors 
 K ^TMP("PXRMGEC",$J,"MAN"),^TMP("PXRMGEC",$J,"MAN1")
 N IEN,CAT,DIA,CATDA,CATNA,FNA,REF,ANS,STOP
 S IEN=0
 F  S IEN=$O(^AUTTHF(IEN)) Q:IEN<1  D
 .Q:$P($G(^AUTTHF(IEN,0)),"^",11)=1
 .S FNA=$P($G(^AUTTHF(IEN,0)),"^",1)
 .S CAT=$P($G(^AUTTHF(IEN,0)),"^",10)
 .I CAT="F" D
 ..Q:$P($G(^AUTTHF(IEN,0)),"^",11)=1
 ..S CATDA=$P($G(^AUTTHF(IEN,0)),"^",3)
 ..Q:CATDA=""
 ..Q:$P($G(^AUTTHF(CATDA,0)),"^",11)=1
 ..S CATNA=$P($G(^AUTTHF(CATDA,0)),"^",1)
 ..I CATNA["GEC" D
 ...I $P($G(^AUTTHF(CATDA,0)),"^",9)'="" D
 ....Q:$P($G(^AUTTHF(CATDA,0)),"^",11)=1
 ....S DIASYN=$P($G(^AUTTHF(CATDA,0)),"^",9)
 ....S ANS=$P($G(^AUTTHF(IEN,0)),"^",9),VAL=$S(ANS'="":$P(ANS," ",$L(ANS," ")),1:0)
 ....S ^TMP("PXRMGEC",$J,"MAN",DIASYN,CATNA,FNA,VAL,IEN,$$SCREEN(IEN))=""
 ....I $D(HFDIA(IEN)) S ^TMP("PXRMGEC",$J,"MAN1",$O(HFDIA(IEN,"")),CATNA,FNA,VAL,IEN,$$SCREEN(IEN))=""
 Q
 ;
PR ;
 N REFM,STOPNA,TIEN,VO
 S REF="^TMP(""PXRMGEC"",$J,""MAN"")"
 S REFM="^TMP(""PXRMGEC"",$J,""MATCH"")"
 S X="IOINHI;IOINLOW;IORVON;IORVOFF"
 D ENDR^%ZISS
 D DAS,MATCHB^PXRMGECY,MATCHB^PXRMGECZ
 N DIACNT,CATCNT,FACCNT,IEN,VAL,STOPCNT,NEWFNA,SYN,TERM
 S (DIACNT,CATCNT,FACCNT,STOPCNT)=0
 D HF
 ;
 ;
 S DIASYN="" F  S DIASYN=$O(@REF@(DIASYN)) Q:DIASYN=""  D
 .S DIACNT=DIACNT+1
 .W !!!,DIACNT_". Dialog- GEC REFERRAL "_$P(DIASYN," ",2,4)
 .S CATNA="" F  S CATNA=$O(@REF@(DIASYN,CATNA)) Q:CATNA=""  D
 ..K @REFM@(CATNA)
 ..S CATCNT=CATCNT+1
 ..W !!,DIACNT_". Dialog- GEC REFERRAL "_$P(DIASYN," ",2,4)
 ..W !!,CATCNT_".   Category- ",CATNA
 ..W !,"      Synonum- "_DIASYN
 ..W !!,"  Health Factors---"
 ..S FNA="" F  S FNA=$O(@REF@(DIASYN,CATNA,FNA)) Q:FNA=""  D
 ...S FACCNT=FACCNT+1
 ...S VAL=$O(@REF@(DIASYN,CATNA,FNA,-1))
 ...S IEN=$O(@REF@(DIASYN,CATNA,FNA,VAL,0))
 ...S STOP=$O(@REF@(DIASYN,CATNA,FNA,VAL,IEN,-1))
 ...I STOP=0 S STOPCNT=STOPCNT+1
 ...S STOPNA=$S(STOP=0:"(((NOT IN USE)))",1:"")
 ...S VO=0
 ...I STOPNA'="" S VO=1
 ...W !,FACCNT_".     " I VO W IORVON
 ...W FNA,"  ",STOPNA,IORVOFF I $L(FNA)>40 W " ",IORVON,$L(FNA),IORVOFF
 ...W !,?19,$S('$D(@REFM@(FNA,IEN)):IORVON,1:""),"ien- "_IEN," (",$O(@REFM@(FNA,0))_")",IORVOFF I '$D(@REFM@(FNA)) W !
 ...W ?17,IORVON,$S($D(@REFM@(FNA)):"",1:"**NOT Originally Released Name") W IORVOFF K @REFM@(FNA)
 ...S SYN=$P($G(^AUTTHF($O(^AUTTHF("B",FNA,0)),0)),"^",9)
 ...S TERM=$O(^PXRMD(811.5,"AF",IEN_";AUTTHF(",0))
 ...W !,?18,$S(TERM="":IORVON,1:""),"Term- ",$S(TERM="":"NO TERM",1:$P($G(^PXRMD(811.5,TERM,0)),"^",1)),IORVOFF
 ...I SYN="" W !,?17,IORVON,$S(SYN="":"**Synonum Missing",1:"syn- "_SYN),IORVOFF
 ...E  W !,?19,$S(SYN="":"**Synonum Missing",1:"syn- "_SYN)
 ...W !,?19,"val- "_VAL,!
 ...W IORVOFF
 I $D(@REFM) W !!,?7,"**Missing Original GEC Health Factors**"
 I $D(@REFM) S FNA="" F  S FNA=$O(@REFM@(FNA)) Q:FNA=""  D
 .W !,?10,FNA
 W !
 W !,"Categories    - "_$J(CATCNT,3)
 W !,"Health Factors- "_$J(FACCNT,3)
 W !,"Not in Use    - "_$J(STOPCNT,3)
 W !,"Used Factors  - ",$J(((FACCNT+CATCNT)-STOPCNT),3)
 W !
 W !,"-----------------------------END OF REPORT ----------------------"
 K ^TMP("PXRMGEC",$J,"MAN"),^TMP("PXRMGEC",$J,"MAN1"),HFDIA
 K ^TMP("PXRMGEC",$J,"MATCH")
 D KILL^%ZISS
 Q
 ;
 ;
 ;
PR1 S REF="^TMP(""PXRMGEC"",$J,""MAN1"")"
 S X="IOINHI;IOINLOW;IORVON;IORVOFF"
 D ENDR^%ZISS
 D DAS,MATCHB^PXRMGECY,MATCHB^PXRMGECZ
 N DIACNT,CATCNT,FACCNT,IEN,VAL,STOPCNT,XCNT
 S (DIACNT,CATCNT,FACCNT,STOPCNT)=0
 D HF
 ;
DISPLAY ;REPORT DISPLAY
 ;
 S DIASYN="" F  S DIASYN=$O(@REF@(DIASYN)) Q:DIASYN=""  D
 .S DIACNT=DIACNT+1,CATCNT=0
 .W !!,DIACNT," Dialog- "_$P($G(^PXRMD(801.41,$O(^PXRMD(801.41,"AC",DIASYN,"")),0)),"^",1)
 .S CATNA="" F  S CATNA=$O(@REF@(DIASYN,CATNA)) Q:CATNA=""  D
 ..S CATCNT=CATCNT+1
 ..W !!,?2,CATCNT_". Category- ",CATNA
 ..W !,?7,"    Ref#   (score)  Health Factors---"
 ..N FNACNT S FNACNT=0
 ..S FNA="" F  S FNA=$O(@REF@(DIASYN,CATNA,FNA)) Q:FNA=""  D
 ...S XCNT=FACCNT,FACCNT=FACCNT+1,FNACNT=FNACNT+1
 ...S VAL=$O(@REF@(DIASYN,CATNA,FNA,-1))
 ...S IEN=$O(@REF@(DIASYN,CATNA,FNA,VAL,0))
 ...S STOP=$O(@REF@(DIASYN,CATNA,FNA,VAL,IEN,-1))
 ...I STOP=0 S FACCNT=XCNT
 ...I STOP=0 S STOPCNT=STOPCNT+1 Q
 ...S STOPNA=$S(STOP=0:"(((NOT IN USE)))",1:"")
 ...N COMB S COMB=DIACNT_"."_CATCNT_"."_FNACNT_"  ("_VAL_")"
 ...S VO=0
 ...I STOPNA'="" S VO=1
 ...W !,"   " I VO W IORVON
 ...W ?11,COMB,"     "_FNA,"  ",STOPNA,IORVOFF W " "
 ...;==================================================
 ...W IORVOFF
 W !!,"Health Factors- "_$J(FACCNT,3)
 W !
 W !,"-----------------------------END OF REPORT ----------------------"
 K ^TMP("PXRMGEC",$J,"MAN"),^TMP("PXRMGEC",$J,"MAN1"),HFDIA
 K ^TMP("PXRMGEC",$J,"MATCH")
 D KILL^%ZISS
 Q
 ;
