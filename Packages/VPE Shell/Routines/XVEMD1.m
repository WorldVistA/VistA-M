XVEMD1 ;DJB/VEDD**Main Menu, Headings [09/25/94];2017-08-15  11:47 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
HD ;
 W @XVV("IOF"),!?65,"David Bolduc"
 W !!!!?34,"V E D D",!?34,"~~~~~~~",!?35,"~~~~~",!?36,"~~~",!?37,"~"
 W !!!?25,"VElectronic Data Dictionary"
 W !!!?22,"*",?25,"Everything you ever wanted",?53,"*",!?22,"*",?25,"to know about a file but",?53,"*",!?22,"*",?25,"were afraid to ask.",?53,"*"
 W !!
 Q
HD1 ;Heading for Top of Main Menu
 W @XVV("IOF"),!?2,"A.) FILE NAME:------------- ",ZNAM
 W !?48,"F.) FILE ACCESS:"
 W !?2,"B.) FILE NUMBER:----------- ",ZNUM
 W ?53,"DD______ ",$S($D(^DIC(ZNUM,0,"DD")):^("DD"),1:"")
 W !?53,"Read____ ",$S($D(^DIC(ZNUM,0,"RD")):^("RD"),1:"")
 W !?2,"C.) NUM OF FLDS:----------- ",^TMP("XVV","VEDD",$J,"TOT")
 W ?53,"Write___ ",$S($D(^DIC(ZNUM,0,"WR")):^("WR"),1:"")
 W !?53,"Delete__ ",$S($D(^DIC(ZNUM,0,"DEL")):^("DEL"),1:"")
 W !?2,"D.) DATA GLOBAL:----------- ",ZGL
 W ?53,"Laygo___ ",$S($D(^DIC(ZNUM,0,"LAYGO")):^("LAYGO"),1:"")
 W !!?2,"E.) TOTAL GLOBAL ENTRIES:-- "
 S ZZGL=ZGL_"0)",ZZGL=@ZZGL W $S($P(ZZGL,U,4)]"":$P(ZZGL,U,4),1:"Blank")
 I PRINTING="YES" W ?48,"G.) PRINTING STATUS:-- ",$S(FLAGP:"On",1:"Off")
 W !,$E(XVVLINE1,1,XVV("IOM"))
 Q
MENU ;Main Menu
 S (FLAGE,FLAGG,FLAGM,FLAGQ,FLAGP1)=0
 I $G(FLAGPRM)="VEDD",$G(%2)]"" G MENU1
 D HD1
MENU1 ;Parameter passing
 D ^XVEMDM G:FLAGP1 MENU I FLAGP S:$E(XVVIOST,1,2)="P-" FLAGQ=1 D PRINT^XVEMDPR ;Turn off printing
 I $G(FLAGPRM)="VEDD",$G(%2)]"" S FLAGE=1 Q
 Q:FLAGM!FLAGE  G:FLAGQ MENU
 I $Y'>XVVSIZE F I=$Y:1:XVVSIZE W !
 W !!?2 S Z1=$$CHOICE^XVEMKC("MAIN_MENU^EXIT",1) I Z1'=1 S FLAGE=1 Q
 G MENU
