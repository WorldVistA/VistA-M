XUTMTR4 ;SEA/RDS - TaskMan: ToolKit, Report 4 (Print List) ;5/12/94  12:08
 ;;8.0;KERNEL;;Jul 10, 1995
MAIN ;
 ;print the list of tasks stored at @XUTMT("NODE")
 N ZTCLEAR,ZTEOL,ZTHEADER,ZTNODE,ZTNONE
 S ZTCLEAR=$G(XUTMT("CLEAR"))
 S ZTEOL=$G(XUTMT("EOL"))
 S ZTHEADER=$G(XUTMT("HEADER"))
 S ZTNODE=XUTMT("NODE")
 S ZTNONE=XUTMT("NONE")
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,ZTCOUNT,ZTFIRST,ZTNEWPG,XUTMT,ZTOUT,ZTS,ZTSK
 S ($Y,ZTOUT,ZTCOUNT)=0,(ZTFIRST,ZTNEWPG)=1
M1 ;
 S ZTS=0 F  S ZTS=$O(@(ZTNODE_ZTS_")")) Q:'ZTS  D  I ZTOUT Q
 .I 'ZTNEWPG W !,"-------------------------------------------------------------------------------"
 .E  D
 ..I ZTCLEAR!'ZTFIRST W @IOF
 ..I ZTHEADER]"" W !,ZTHEADER,!
 ..S (ZTFIRST,ZTNEWPG)=0
 ..Q
 . D EN^XUTMTP(ZTS)
 .S ZTCOUNT=ZTCOUNT+1
 .I $Y'>18 Q
 .S ZTNEWPG=1
 .W ! S DIR(0)="E" D ^DIR
 .S ZTOUT=$D(DIRUT)
 .I ZTOUT Q
 .W @IOF
 .Q
 I ZTOUT Q
M2 ;
 I 'ZTCOUNT W !!,ZTNONE
 I 'ZTEOL Q
 W !
 S DIR(0)="E"
 S DIR("A")="Press RETURN to continue" D
 .I ZTCOUNT S DIR("A")="End of listing.  "_DIR("A")
 D ^DIR
 Q
 ;
