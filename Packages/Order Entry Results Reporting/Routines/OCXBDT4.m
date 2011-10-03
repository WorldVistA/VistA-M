OCXBDT4 ;SLC/RJS,CLA - BUILD OCX PACKAGE DIAGNOSTIC ROUTINES (Build Runtime Library Routine OCXDI0) ;8/04/98  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN() ;
 ;
 N R,LINE,TEXT,NOW,RUCI,XCM
 S NOW=$$NOW^OCXBDT3,RUCI=$$CUCI^OCXBDT
 F LINE=1:1:999 S TEXT=$P($T(TEXT+LINE),";",2,999) Q:TEXT  S TEXT=$P(TEXT,";",2,999) S R(LINE,0)=$$CONV^OCXBDT3(TEXT)
 ;
 M ^TMP("OCXBDT",$J,"RTN")=R
 ;
 S DIE="^TMP(""OCXBDT"","_$J_",""RTN"",",XCN=0,X="OCXDI0"
 W !,X X ^%ZOSF("SAVE") W "  ... ",XCM," Lines filed" K ^TMP("OCXBDT",$J,"RTN")
 ;
 Q XCM
 ;
TEXT ;
 ;;OCXDI0 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC UTILITY ROUTINE ;|NOW|
 ;;|OCXLIN2|
 ;;|OCXLIN3|
 ;; ;
 ;;S ;
 ;; ;
 ;; Q
 ;; ;
 ;;RTN(RSUM) ;
 ;; ;
 ;; D DOT^OCXDIAG
 ;; ;
 ;; N CHAR,CSUM,DASH,LINE,MSG,RNDX,RPC,RTN,TEXT,X,RCSM,RDIFF
 ;; ;
 ;; S RCSM(3)="",RTN=$P(RSUM(0),U,1)
 ;; F RNDX=1:1 Q:'$D(RSUM(RNDX))  F RPC=1:1:$L(RSUM(RNDX),U) S RCSM($O(RCSM(""),-1)+1)=$P(RSUM(RNDX),U,RPC)
 ;; K RCSM(3)
 ;; ;
 ;; S X=RTN X ^%ZOSF("TEST") E  D WARN(RTN,"Routine not in local system") Q 0
 ;; ;
 ;; F LINE=4:1 S TEXT=$$TEXT(RTN,LINE) Q:'$L(TEXT)  I '$D(RCSM(LINE)) S RDIFF(LINE)=""
 ;; S LINE=0 F  S LINE=$O(RCSM(LINE)) Q:'LINE  S TEXT=$$TEXT(RTN,LINE) D
 ;; .S CSUM=0 F CHAR=1:1:$L(TEXT) S CSUM=CSUM+($A(TEXT,CHAR)*CHAR)
 ;; .I '(RCSM(LINE)=(+(CSUM_"."_$L(TEXT)_"1"))) S RDIFF(LINE)=""
 ;; ;
 ;; Q:'$O(RDIFF(0)) 0
 ;; ;
 ;; D WARN(RTN,"Checksums do not match",.RDIFF)
 ;; ;
 ;; Q 0
 ;; ;
 ;;WARN(RTN,MSG,LINES) ;
 ;; ;
 ;; Q:$G(OCXAUTO)
 ;; ;
 ;; N DASH,LINE,NLINE,PLINE
 ;; ;
 ;; S DASH="",$P(DASH,"-",(55-$L(MSG)-2))="-"
 ;; W !!,"----WARNING-","--",MSG,DASH
 ;; ;
 ;; W !,RTN,?10,"[|RUCI|] -> [",$$CUCI^OCXBDT,"] Line"
 ;; ;
 ;; I $O(LINES($O(LINES(0)))) W "s: "
 ;; E  W ": "
 ;; ;
 ;; S LINE=0 F  S LINE=$O(LINES(LINE)) Q:'LINE  D
 ;; .W:($X>60) !,?40
 ;; .S NLINE=LINE F  S PLINE=NLINE,NLINE=$O(LINES(NLINE)) Q:(NLINE-PLINE-1)
 ;; .I (PLINE=LINE) W " ",LINE
 ;; .E  W " ",LINE,"-",PLINE S LINE=PLINE
 ;; ;
 ;; W ! Q
 ;; ;
 ;;TEXT(RTN,LINE) ;
 ;; ;
 ;; N TEXT X "S TEXT=$T(+"_(+LINE)_"^"_RTN_")" Q TEXT
 ;; ;
 ;;HEADER ;
 ;; ;
 ;; W !," Created: |NOW|  in UCI: |RUCI|"
 ;; W !," Current Date: ",$$NOW," Current UCI: ",$$CUCI^OCXBDT,!!
 ;; S LASTFILE=0
 ;; K ^TMP("OCXDIAG",$J)
 ;; S ^TMP("OCXDIAG",$J)=($P($H,",",2)+($H*86400)+(1*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 ;; Q
 ;; ;
 ;;LISTFILE(GLREF,SCANDUP) ;
 ;; ;
 ;; Q:($L(GLREF)<2) 0
 ;; N D0,NAME,FILE,QUIT,CNT,FILENUM
 ;; S QUIT=0,FILE=$P($G(@GLREF@(0)),U,1),FILENUM=+$P($G(@GLREF@(0)),U,2)
 ;; I '$L(FILE) W !!,"Cannot find File: ",GLREF Q $$PAUSE
 ;; I SCANDUP S (QUIT,D0)=0 F CNT=0:1 S D0=$O(@GLREF@(D0)) Q:'D0  S NAME=$P($G(@GLREF@(D0,0)),U,1) D  Q:QUIT
 ;; .D DOT^OCXDIAG
 ;; .I '$L(NAME) W !,GLREF,"  ",FILE," -> Record #",D0,"  does not have a name." S QUIT=$$PAUSE Q
 ;; .I OCXFLGR,'$D(^TMP("OCXDIAG",$J,"A",FILENUM,NAME)) D
 ;; ..W !!," Extra Record in (L) ",$$CUCI^OCXBDT," - ",FILE,": ",NAME,"."
 ;; ..S QUIT=$$DELREC^OCXDI2(FILENUM,D0)
 ;; Q QUIT
 ;; ;
 ;;GETFILE(FILE,RECNAME,ARRAY) ;
 ;; ;
 ;; N CHECK,GLNEXT,GLREF,LINES,REC,DD,FLD
 ;; S REC=$$LOOKUP(FILE,RECNAME)
 ;; I 'REC W:OCXFLGR !!,$$FILENAME^OCXBDTD(FILE),": ",RECNAME,"  not found." Q 0
 ;; I (REC=-1) W:OCXFLGR !!,$$FILENAME^OCXBDTD(FILE),": ",RECNAME,"  duplicate local entries.",! S REC=$$DELDUP^OCXDI2(FILE,RECNAME)
 ;; I (REC=-2) W:OCXFLGR !!,$$FILENAME^OCXBDTD(FILE)," (",FILE,") local file not found." W ! Q:$$PAUSE -10 Q REC
 ;; I (REC<0) W:OCXFLGR !!,$$FILENAME^OCXBDTD(FILE),": ",RECNAME,"  unknown error." W ! Q:$$PAUSE -10 Q REC
 ;; I (REC>0) D
 ;; .S CHECK=0,LINES=0
 ;; .D GETREC($$FILE^OCXBDTD(FILE,"GLOBAL NAME"),"ARRAY(",REC,.ARRAY)
 ;; .S GLREF="ARRAY" F  S GLREF=$Q(@GLREF) Q:'$L(GLREF)  Q:'($E(GLREF,1,6)="ARRAY(")  K:'$L(@GLREF) @GLREF
 ;; ;
 ;; Q REC
 ;; ;
 ;;LKUPARRY(DD,KEY,ARRAY) ;
 ;; ;
 ;; N D0 S D0=0 F  S D0=$O(ARRAY(DD,D0)) Q:'D0  Q:($G(ARRAY(DD,D0,.01,"E"))=KEY)
 ;; Q D0
 ;; ;
 ;;LOOKUP(FILE,KEY) ;
 ;; I $O(^TMP("OCXDIAG",$J,"B",FILE,KEY,0)) Q 0
 ;; N RECNAM,REC,D0,CNT,SHORT S (REC,CNT)=0
 ;; S GL=$$FILE^OCXBDTD(FILE,"GLOBAL NAME") Q:'$L(GL) -2 S GL=$E(GL,1,$L(GL)-1)_")"
 ;; S SHORT=$E(KEY,1,30),RECNAM=SHORT D  F  S RECNAM=$O(@GL@("B",RECNAM)) Q:'$L(RECNAM)  Q:'($E(RECNAM,1,$L(SHORT))=SHORT)  D
 ;; .S D0=0 F  S D0=$O(@GL@("B",RECNAM,D0)) Q:'D0  I ($P($G(@GL@(D0,0)),U,1)=KEY) S CNT=CNT+1,REC=D0_U_RECNAME
 ;; Q:(CNT>1) -1
 ;; S:$L($P(REC,U,2)) ^TMP("OCXDIAG",$J,"A",FILE,$P(REC,U,2))=""
 ;; Q +REC
 ;; ;
 ;;GETREC(GL,PATH,D0,REM) ;
 ;; ;
 ;; Q:'($P($G(@(GL_"0)")),U,2))
 ;; N S1,DATA,DD
 ;; S DATA="" D DIQ(GL,D0,.DATA)
 ;; S DD=$O(DATA(0)) Q:'DD
 ;; ;
 ;; I $L($$FILE^OCXBDTD(DD,"NAME")) S PATH=PATH_""""_DD_":"_D0_""""
 ;; I '$L($$FILE^OCXBDTD(DD,"NAME")) S PATH=PATH_","""_DD_":"_D0_""""
 ;; M @(PATH_")")=DATA(DD,D0)
 ;; ;
 ;; S S1="" F  S S1=$O(@(GL_D0_","_$$SUB(S1)_")")) Q:'$L(S1)  I ($D(@(GL_D0_","_$$SUB(S1)_")"))>3) D
 ;; .N D1,GLREF S GLREF=GL_D0_","_$$SUB(S1)_","
 ;; .S D1=0 F  S D1=$O(@(GLREF_D1_")")) Q:'D1  D GETREC(GLREF,PATH,D1,.REM)
 ;; ;
 ;; Q
 ;; ;
 ;;SUB(X) Q:'(X=+X) """"_X_"""" Q X
 ;; ;
 ;;DIQ(DIC,DA,OCXARY) ;
 ;; N DR,DIQ S DR=".01:99999",DIQ="OCXARY(",DIQ(0)="EN" D EN^DIQ1
 ;; Q
 ;; ;
 ;;PAUSE() Q:'OCXFLGC 0 W "  Press Enter " R X:DTIME W ! Q (X[U)
 ;; ;
 ;;NOW() N X,Y,%DT S X="N",%DT="T" D ^%DT S Y=$$DATE^OCXBDTD(Y) S:(Y["@") Y=$P(Y,"@",1)_" at "_$P(Y,"@",2) Q Y
 ;; ;
 ;;$
 ;1;
 ;
