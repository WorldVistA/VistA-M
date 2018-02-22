XVEMG ;DJB/VGL**VGlobal Lister ;2017-08-15  12:39 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in EN+2,IMPORT+1 (c) 2016 Sam Habiel
 ;
EN ;Entry point
 I $G(DUZ)'>0 D ID^XVEMKU Q:$G(DUZ)=""
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMGY,UNWIND^XVEMSY"
START ;
 NEW DX,DY,XVVS,XVVT ;IMPORT (For scrolling)
 NEW ZGL,CHK,CNTX,CNTY,CODE,COL,DATA,I,II,KEY,NEWSUB,NODE,FLAGSKIP,SKIPHLD,SUBCHK,SUBNAM,SUBNUM,TABHLD,TEMP,TEMP1,TOTAL,TOTAL1,VGLREV,Z1,Z2,ZDSUB,ZREF
 NEW GL,GLNAM,GLSUB,GLVAL,GLVAL1,GLX
 NEW ZDELIM,ZDELIM1,ZDELIM2
 NEW FLAGC,FLAGC1,FLAGE,FLAGOPEN,FLAGPAR,FLAGQ
 ;FLAGVPE="VEDD^VGL^VRR^EDIT"
 I '$D(FLAGVPE) NEW FLAGVPE
 I $G(FLAGVPE)'["VGL" NEW GLS
 I $G(XVVIOF)="" NEW XVVIOST,XVVLINE,XVVLINE1,XVVLINE2,XVVSIZE,XVVX,XVVY
 I $D(XVV("OS"))#2=0 NEW XVV
 S VGLREV=0 I $G(REVERSE)="YES" S VGLREV=1 KILL REVERSE
 ;
 S FLAGQ=0 D INIT^XVEMGY G:FLAGQ EX D IMPORT
 ;
 S $P(FLAGVPE,"^",2)="VGL" ;Marks that VGL is running.
TOP ;Start of Loop
 ;  XVVT("STATUS")="START^FINISH^HEADING^SEARCH^PROT"
 ;  START marks if STARTSCR^XVEMKT2 has been called.
 ;  FINISH marks if FINISH^XVEMGI has been called.
 ;  HEADING controls whether heading is displayed
 ;  SEARCH marks if code search is currently active
 ;  PROT marks <PROT> error so "No data" is displayed.
 S XVVT("STATUS")=$S($G(XVVT("STATUS"))["HEADING":"^^HEADING",1:0)
 KILL ^TMP("XVV","IG"_GLS,$J),^TMP("XVV","VGL"_GLS,$J),^TMP("XVV",$J)
 S (CODE,FLAGC,FLAGC1,FLAGE,FLAGOPEN,FLAGQ)=0,ZREF=1
 D GETGL^XVEMG1 G:FLAGQ=1 EX G:FLAGQ=2 TOP
 I $G(XVVSHL)="RUN" D  ;Cmnd Line History
 . S:$G(FLAGPAR)=1 ZGL=$E(ZGL,1,$L(ZGL)-1)
 . D CLHSET^XVEMSCL("VGL",ZGL)
 D ^XVEMGR,FINISH^XVEMGI
 G TOP
IMPORT ;Set up for scroller
 I $D(XVSIMERR) S $EC=",U-SIM-ERROR,"
 NEW LINE,MAR
 S MAR=$G(XVV("IOM")) S:'MAR MAR=80
 S $P(LINE,"=",MAR)=""
 S XVVT("S2")=(XVV("IOSL")-3)
 S XVVT("GET")="D SETARRAY^XVEMGI"
 S XVVT("HD")=1,XVVT("FT")=3
 S XVVT("HD",1)=$E(LINE,1,(MAR-12)\2)_"[Session "_GLS_"]"_$E(LINE,1,(MAR-12)\2)
 S XVVT("FT",1)=LINE
 S XVVT("FT",2)="<>  'n'=Pieces  A=Alt  G=Goto  S'n'=Skip  C=CdSrch  ?=Help  M=More..."
 S XVVT("FT",3)=" Select: "
 Q
EX ;
 KILL ^TMP("XVV","IG"_GLS,$J)
 KILL ^TMP("XVV","VGL"_GLS,$J)
 KILL ^TMP("XVV",$J)
 S GLS=GLS-1 ;Make sure this line FOLLOWS previous line
 S ^XVEMS("%",$J_$G(^XVEMS("SY")),"GLS")=GLS
 I GLS=0 KILL ^XVEMS("%",$J_$G(^XVEMS("SY")),"GLS")
 Q
 ;====================================================================
R ;Reverse video
 I '$D(^DD)!('$D(^DIC)) D  Q  ;Needs Fileman
 . W $C(7),!?1,"Fileman must be present to use this calling point.",!
 I $G(DUZ)'>0 D ID^XVEMKU I $G(DUZ)="" KILL ^TMP("XVV",$J) Q
 NEW REVERSE S REVERSE="YES"
 G EN
PARAM(X) ;Parameter Passing....X=^Global -or- X=File Name
 S ^TMP("XVV",$J)=$G(X)
 I $G(DUZ)'>0 D ID^XVEMKU I $G(DUZ)="" KILL ^TMP("XVV",$J) Q
 I ^TMP("XVV",$J)]"" NEW FLAGPRM,%1 S FLAGPRM=1,%1=^($J)
 KILL ^TMP("XVV",$J)
 G EN
