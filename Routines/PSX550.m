PSX550 ;BIR/DB - API for file 550 ;24 Feb 2006
 ;;2.0;CMOP;**61**;11 Apr 97;Build 1
PSX(PSXIEN,PSXTXT,LIST) ;
 ;PSXIEN -CMOP system internal entry number (optional)
 ;PSXTXT - Free Text CMOP system name (optional)
 ;LIST: Subscript name used in ^TMP global [REQUIRED]
 I $G(PSXIEN)="",$G(PSXTXT)="" Q
 I $G(LIST)="" Q
 K ^TMP($J,LIST),DA,^UTILITY("DIQ1",$J),DIQ
 I $G(PSXIEN)]"" S DA=PSXIEN I '$D(^PSX(550,DA,0)) G RET0
 I $G(PSXTXT)'="",$G(PSXIEN)'>0,'$D(^PSX(550,"B",PSXTXT)) G RET0
 I $G(PSXTXT)'="",$G(DA)'>0 S DA=$O(^PSX(550,"B",PSXTXT,0))
 K ^UTILITY("DIQ1",$J),DIC S DIC=550,DR=".01;1",DIQ(0)="IE" D EN^DIQ1
 I '$D(^UTILITY("DIQ1",$J)) G RET0
 S:$G(PSXTXT)="" PSXTXT=^UTILITY("DIQ1",$J,550,DA,.01,"E")
 S ^TMP($J,LIST,1)=$G(^UTILITY("DIQ1",$J,550,DA,1,"I"))
 S ^TMP($J,LIST,1)=$S($G(^UTILITY("DIQ1",$J,550,DA,1,"E"))'="":^TMP($J,LIST,1)_"^"_$G(^UTILITY("DIQ1",$J,550,DA,1,"E")),1:"")
 S ^TMP($J,LIST,"B",PSXTXT,DA)=""
 Q
 K PSXIEN,DA,X,PSXTXT,DR,DIC Q
RET0 ;return no data
 S ^TMP($J,LIST,0)="-1^NO DATA FOUND" Q
 Q
