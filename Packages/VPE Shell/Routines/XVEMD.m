XVEMD ;DJB/VEDD**Electronic Data Dictionary ;2017-08-15  12:18 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in EN,EX (c) 2016 Sam Habiel
 ;
EN ;Entry point
 I '$D(^DD(0)) D  Q
 . W $C(7),!!?2,"You don't have Filemanager in this UCI.",!
 . D:$G(FLAGVPE)["VGL"!($G(FLAGVPE)["VRR") PAUSE^XVEMKC(2)
 I $G(DUZ)'>0 D ID^XVEMKU Q:$G(DUZ)=""
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMDY,UNWIND^XVEMSY"
START ;
 NEW FLAGE,FLAGG,FLAGGL,FLAGGL1,FLAGH,FLAGM,FLAGP,FLAGP1,FLAGQ
 NEW DIC,VEDDATE,I,PRINTING,X,Y,Z1,ZGL,ZNAM,ZNUM,ZZGL
 I $G(XVVX)]"" D  KILL XVVX
 . S:XVVX="TAG-DIR"!(XVVX="TAG-PARAM") FLAGH=1 Q
 I $D(XVV("OS"))#2=0 NEW XVV
 I $G(XVVLINE)']"" NEW XVVIOST,XVVLINE,XVVLINE1,XVVLINE2,XVVSIZE,XVVX,XVVY
 ;FLAGVPE="VEDD^VGL^VRR^EDIT"
 I '$D(FLAGVPE) NEW FLAGVPE
 S $P(FLAGVPE,"^",1)="VEDD" ;Marks that VEDD is running
 ;
 S FLAGQ=0 D INIT^XVEMDY G:FLAGQ EX
 ;
TOP ;
 S (FLAGP,FLAGQ)=0 KILL ^TMP("XVV","VEDD",$J)
 D:'FLAGH HD^XVEMD1 D GETFILE G:FLAGQ EX
 I $G(XVVSHL)="RUN" D CLHSET^XVEMSCL("VEDD",ZNAM) ;Cmnd Line History
 D MULT^XVEMDPR,MENU^XVEMD1 G:FLAGE EX
 S FLAGH=1 G TOP ;Set FLAGH to bypass opening screen
EX ;Exit
 I $G(XVSIMERR)=1 S $EC=",U-SIM-ERROR,"
 KILL ^TMP("XVV","VEDD",$J)
 Q
 ;==================================================================
GETFILE ;File lookup
 NEW DIC
 I $G(FLAGPRM)="VEDD" S FLAGQ=1 Q  ;Onetime pass when parameter passing.
 I $G(FLAGPRM)=1 S FLAGPRM="VEDD",X=%1 G GETFILE1
 I $G(XVVSHL)="RUN" D  G:X?1"<".E1">" GETFILE G GETFILE1
 . S X=$$CLHEDIT^XVEMSCL("VEDD"," Select FILE: ")
 W !?2,"Select FILE: "
 R X:XVV("TIME") S:'$T X="^"
GETFILE1 ;Parameter passing
 I "^"[X S FLAGQ=1 Q
 S DIC="^DIC(",DIC(0)="QEM" D ^DIC I Y<0 D  Q:FLAGQ  G GETFILE
 . Q:$G(FLAGPRM)'="VEDD"  S FLAGQ=1
 . W !!?2,"First parameter is not a valid file name/number.",!
 S ZNUM=+Y,ZNAM=$P(Y,U,2)
 I '$D(^DIC(ZNUM,0,"GL")) D  S FLAGQ=1 Q
 . W $C(7),!!?2,"WARNING...This file is missing node ^DIC(",ZNUM,",0,""GL"")",!
 I ^DIC(ZNUM,0,"GL")']"" D  S FLAGQ=1 Q
 . W $C(7),!!?2,"WARNING...Node ^DIC(",ZNUM,",0,""GL"") is null.",!
 S XVVX=^DIC(ZNUM,0,"GL")_"0)" I '$D(@XVVX) D  S FLAGQ=1 Q
 . W $C(7),!!?2,"WARNING...This file is missing its data global - ",^DIC(ZNUM,0,"GL"),!
 I '$D(^DD(ZNUM,0)) D  S FLAGQ=1 Q
 . W $C(7),!!?2,"WARNING...This file is missing the zero node of the data dictionary.",!?12,"--> ^DD(",ZNUM,",0)",!
 S ZGL=^DIC(ZNUM,0,"GL")
 Q
DIR ;Supress heading
 I $G(DUZ)'>0 D ID^XVEMKU I $G(DUZ)="" Q
 S XVVX="TAG-DIR" G EN
PARAM(X,Y,Z) ;Parameter Passing
 ;   X = ^Global -or- File name
 ;   Y = EDD Main Menu option
 ;   Z = Fields
 S ^TMP("XVV",$J)=$G(X)_"]]"_$G(Y)_"]]"_$G(Z)
 I $G(DUZ)'>0 D ID^XVEMKU I $G(DUZ)="" KILL ^TMP("XVV",$J) Q
 I $P(^TMP("XVV",$J),"]]",1)]"" S X=^($J) NEW FLAGPRM,%1,%2,%3 S FLAGPRM=1 D
 . S %1=$P(X,"]]",1),%2=$P(X,"]]",2),%3=$P(X,"]]",3)
 . I %2]"" D CHECK^XVEMDM I %2']"" S FLAGPRM="QUIT"
 KILL X,^TMP("XVV",$J) S XVVX="TAG-PARAM"
 I $G(FLAGPRM)="QUIT" KILL XVVX Q
 G EN
