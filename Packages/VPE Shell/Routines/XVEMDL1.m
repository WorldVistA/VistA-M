XVEMDL1 ;DJB/VEDD**Start at a particular field?,Hd,Error ;2017-08-15  12:12 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
ASK ;Start at a particular field?
 I $G(VEDDS)>1 D  Q  ;Don't ask when branching
 . S DASHES="",(LEV,RCNT)=1,FILE(LEV)=ZNUM,FLD(LEV)=0
 I $G(FLAGPRM)="VEDD",$G(%2)="G" S SFLD="" G ASK1
 W ! I VEDDS'>1 D  Q:FLAGQ
 . S SFLD=$$CHOICE^XVEMKC("ALL_FIELDS^STARTING_FIELD^QUIT^EXIT",1)
 . I "0,3,4"[SFLD S FLAGQ=1 S:SFLD=4 FLAGE=1 Q
 . S SFLD=$S(SFLD=2:"F",1:"")
 I VEDDS>1 D  Q:FLAGQ
 . S SFLD=$$CHOICE^XVEMKC("ALL_FIELDS^STARTING_FIELD^QUIT",1)
 . I "0,3"[SFLD S FLAGQ=1 Q
 . S SFLD=$S(SFLD=2:"F",1:"")
ASK1 ;Parameter passing
 S DASHES="",(LEV,RCNT)=1,FILE(LEV)=ZNUM,FLD(LEV)=0
 I SFLD="F" D  Q:FLAGQ
 . S DIC="^DD("_ZNUM_",",DIC(0)="QEAN"
 . S DIC("W")="I $P(^DD(ZNUM,Y,0),U,2)>0 W ?65,""  -->Mult"""
 . S DIC("A")="  Select FIELD: "
 . W ! D ^DIC KILL DIC("A"),DIC("W") I Y<0 S FLAGQ=1 Q
 . S FLAGSTRT=$P(Y,"^",2)
 I $G(FLAGPRM)="VEDD",$G(%3)]"" D  Q:FLAGQ
 . S X=%3,%3="",DIC="^DD("_ZNUM_",",DIC(0)="QEN"
 . D ^DIC I Y<0 D  S FLAGQ=1 Q
 . . W !!?2,"Third parameter is not a valid field name/number.",!
 . S FLAGFIND=$P(Y,"^",2)
 . Q
 Q
 ;====================================================================
HD ;Heading when printing
 W !?5,"NODE ; PIECE",?19,"FLD NUM",?49,"FIELD NAME"
 W !?5,"------------",?19,"--------",?29,"--------------------------------------------------"
 Q
ERROR ;Error trap
 NEW ZE
 S @("ZE="_XVV("$ZE"))
 S FLAGQ=1 D ENDSCR^XVEMKT2
 I $G(VEDDS)>0 D  S VEDDS=VEDDS-1
 . KILL ^TMP("XVV","VEDD"_VEDDS,$J),^TMP("XVV","ID"_VEDDS,$J)
 I ZE["<INRPT>" W !!?1,"....Interrupted.",!! Q
 D ERRMSG^XVEMKU1("FGL/VEDD"),PAUSE^XVEMKU(2)
 Q
