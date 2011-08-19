XQH2 ;LL/THM,SEA/AMF,JLI - HELP PROCESSOR ;9/29/92  15:10 ;
 ;;8.0;KERNEL;;Jul 10, 1995
EDIT ;
 N Y S DIE="^DIC(9.2,",DA=XQHY
 S XQW=$P(X,"^E",2) S DR=$S('$L(XQW):".01;1;2;4///N;3.5",XQW="N":".01",XQW="R":"3.5",XQW="T":"2;4///N;3.5",1:"1") D ^DIE I "NH"[XQW G OUT
 K DR S DR="3" D ^DIE
OUT K XQW Q
LOADKW ;
 I "Nn"[$E(X,1) S X="" Q
 I "Yy"'[$E(X,1) K X Q
 K XQKW S %XQK=0 F %XQJ=1:1 S %XQK=$O(^DIC(9.2,DA,1,%XQK)) Q:%XQK=""  S %XQJ=^(%XQK,0) F XQL=1:1 S XQKW=$P($P(%XQJ,"]",XQL),"[",2) Q:'$L(XQKW)  D UPPER S XQKW(XQKW)=""
 S XQKW=-1,%XQJ=0 F  S XQKW=$O(XQKW(XQKW)) Q:XQKW=""  I '$D(^DIC(9.2,DA,2,"B",XQKW)) W:'%XQJ !!,"Please assign related frames to these new keywords: " W !?5,XQKW S %XQJ=%XQJ+1
 G:'%XQJ NONEW S:'$D(^DIC(9.2,DA,2,0)) ^(0)="^9.22^0^0" S %XQI=^(0),%XQK=$P(%XQI,U,4),%XQI=$P(%XQI,U,3)+1
 S XQKW=0 F  S XQKW=$O(XQKW(XQKW)) Q:XQKW=""  I '$D(^DIC(9.2,DA,2,"B",XQKW)) D ADD
 S ^DIC(9.2,DA,2,0)="^9.22^"_%XQI_U_%XQK
NONEW S XQKW=-1,%XQJ=0 F  S XQKW=$O(^DIC(9.2,DA,2,"B",XQKW)) Q:XQKW=""  I '$D(XQKW(XQKW)) W:'%XQJ !!,"The following keywords do not appear in text. You may wish to delete." S %XQJ=%XQJ+1 W !?5,XQKW
 S X="" W ! K XQKW
 Q
UPPER S %XQHI=XQKW,XQKW="" F %XQHJ=1:1:$L(%XQHI) S XQKWC=$E(%XQHI,%XQHJ),XQKW=XQKW_$S(XQKWC?1L:$C($A(XQKWC)-32),1:XQKWC)
 K %XQHI,%XQHJ,XQKWC
 Q
ADD I $D(^DIC(9.2,DA,2,%XQI)) S %XQI=%XQI+1 G ADD
 S ^DIC(9.2,DA,2,%XQI,0)=XQKW,^DIC(9.2,DA,2,"B",$E(XQKW,1,30),%XQI)="",%XQK=%XQK+1
 Q
HELP ;
 W !!,"Select one of the following responses: ",!?5,"<return> - to back up a level"
 I 'XQBL W !?5,$S((IORV="["):"Bracketed ",1:"Highlighted "),"keyword " W:'%XQI "or number" W " to indicate a related help frame"
 W !?5,"'^Q' - to quit the help system",!?5,"'^R' - to refresh this frame"
 I 'XQBL W !?5,"'^T' - ",$S(%XQI:"table of related frames",1:"text")
 W !?5,"'^O' - ","on/off switch for bracketing/reverse video of keywords"
 W !?5,"'^H' - to see how you got here"
 I XQAU W !?5,"'^E' - to edit the content of this frame.",!?10,"'EN' - to edit the name",!?10,"'EH' - to edit the header",!?10,"'ET' - to edit the text",!?10,"'ER' to edit the related frame list"
 Q
HOW ;
 W !!,"HOW DID I GET HERE?"
 F %XQJ=0:1:(XQHL-1) W !?(%XQJ+1*4),"|",!?(%XQJ+1*4),"|-------> ",XQHR(%XQJ,1)
 W !?(XQHL+1*4),"|",!?(XQHL+1*4),"|-------> ",XQHF
 Q
HILITE ;
 I IORV'="""[""" S IORV="""[""",IORVX="""]""" W !,"Brackets will now be used for keywords." Q
 I '$D(IOST(0)) W !,"Terminal type is not defined." Q
 I $D(^%ZIS(2,IOST(0),5)) S I=^(5) I $L($P(I,U,4)),$L($P(I,U,5)) S IORV=$P(I,U,4),IORVX=$P(I,U,5) W !,@IORV,"REVERSE VIDEO",@IORVX," will now be used for keywords." Q
 W !,"Reverse video not available for this terminal type."
 Q
