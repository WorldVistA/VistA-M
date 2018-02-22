XVEMDLE ;DJB/VEDD**Data: Type,Access [07/31/94];2017-08-15  12:14 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
GETTYPE ;Select data type for DATA Option
 W !?1,"Select DISPLAY TYPE: EN//"
 R ZDIQ:XVV("TIME") S:'$T ZDIQ="^" S:ZDIQ="" ZDIQ="EN"
 I ZDIQ["^" S FLAGQ=1 Q
 I ZDIQ["?" D HELP G GETTYPE
 S ZDIQ=$$ALLCAPS^XVEMKU(ZDIQ)
 I ",E,I,EN,IN,"'[(","_ZDIQ_",") W $C(7),"  ??" G GETTYPE
 S TYPE=$S(",E,EN,"[(","_ZDIQ_","):"E",1:"I")
 Q
HELP ;
 W !?10,"'E' Display external value of fields",!?10,"'I' Display internal value of fields",!?9,"'EN' Display external value of fields and ignore null fields",!?9,"'IN' Display internal value of fields and ignore null fields"
 Q
ACCESS ;Check users READ access
 NEW DIFILE,DIAC
 Q:DUZ(0)["@"!('$D(^DIC(ZNUM,0,"RD")))
 I ^DD("VERSION")<18 D:DUZ(0)'=^DIC(ZNUM,0,"RD") MSG Q
 S DIFILE=ZNUM,DIAC="RD" D ^DIAC I DIAC<1 D MSG
 Q
MSG ;Access message
 S FLAGQ=1 W $C(7),!!?2,"You do not have READ access to the ",ZNAM," file." D PAUSE^XVEMKC(2)
 Q
PRINT ;Print Field(s)
 W @XVV("IOF") D HD S FILE=""
 F  S FILE=$O(^UTILITY("DIQ1",$J,FILE)) Q:FILE=""!FLAGQ  S DA="" F  S DA=$O(^UTILITY("DIQ1",$J,FILE,DA)) Q:DA=""!FLAGQ  S FLD="" F  S FLD=$O(^UTILITY("DIQ1",$J,FILE,DA,FLD)) Q:FLD=""!FLAGQ  D  I $Y>XVVSIZE D PAGE
 .I $D(^UTILITY("DIQ1",$J,FILE,DA,FLD,TYPE)) W !,$J($P(^DD(FILE,FLD,0),U),20),":  ",^UTILITY("DIQ1",$J,FILE,DA,FLD,TYPE) Q
 .W !!,$J($P(^DD(FILE,FLD,0),U),20),":   Word Processing" I $Y>XVVSIZE D PAGE Q:FLAGQ
 .S WP="" F  S WP=$O(^UTILITY("DIQ1",$J,FILE,DA,FLD,WP)) Q:WP=""  W !,^UTILITY("DIQ1",$J,FILE,DA,FLD,WP) I $Y>XVVSIZE D PAGE Q:FLAGQ
 .W !
 Q:FLAGE
 W:'$D(^UTILITY("DIQ1",$J)) !?2,"No data in requested fields." W !,$E(XVVLINE,1,XVV("IOM"))
 Q
PAGE ;Page
 D PAUSEQE^XVEMKC(2) Q:FLAGQ  W @XVV("IOF")
 Q
HD ;Heading
 I FLAGLONG W $C(7),!?2,"NOTE: You asked for too many fields. I will display as many as I can.",!
 W !?29,"D A T A   D I S P L A Y",!?2,"File: ",ZNAM,!,$E(XVVLINE,1,XVV("IOM"))
 Q
