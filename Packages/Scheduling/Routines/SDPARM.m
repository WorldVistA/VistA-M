SDPARM ;ALB/CAW - Build Display for MAS Parameters ; 3/10/92
 ;;5.3;Scheduling;**27,132**;08/13/93
 ;
START ;
 K XQORS,VALMLEVL D EN^VALM("SD PARM PARAMETERS")
 G QUIT
EN ;Entry point for list manager
 ;
 D INIT
 ;
HDR ;
 ;
1 D SET("                          *** Site Demographics ***")
 D CNTRL^VALM10(SDLN,26,26,IOINHI,IOINORM,0)
 ;
2 S X=""
 S X=$$SETSTR^VALM1("Site: ",X,12,6)
 S X=$$SETSTR^VALM1(SDSITE,X,18,20)
 S X=$$SETSTR^VALM1("Scheduling Version:",X,41,20)
 S X=$$SETSTR^VALM1(SDPARM(43,1,205,"E"),X,SDSCOL,4)
 D SET(X)
 ;
3 D SET("")
 ;
4 D SET("                        *** Editable Site Parameters ***")
 D CNTRL^VALM10(SDLN,25,32,IOINHI,IOINORM,0)
 ;
5 S X=""
 S X=$$SETSTR^VALM1("      Appt. Search Threshold:",X,1,SDWID)
 S X=$$SETSTR^VALM1(SDPARM(43,1,212,"E"),X,SDFCOL,4)
 S X=$$SETSTR^VALM1("Appt. Update Mail Group:",X,36,24)
 S X=$$SETSTR^VALM1(SDPARM(43,1,215,"E"),X,SDSCOL,19)
 D SET(X)
 ;
6 D SET("")
 S X=""
 S X=$$SETSTR^VALM1(">>> Dispositioning <<<",X,4,SDWID)
 S X=$$SETSTR^VALM1("       NPCDB Mail Group:",X,36,24)
 S X=$$SETSTR^VALM1(SDPARM(43,1,216,"E"),X,SDSCOL,19)
 D SET(X)
 D CNTRL^VALM10(SDLN,4,22,IOINHI,IOINORM,0)
 ;
7 S X=""
 S X=$$SETSTR^VALM1("  Default for View Check Out:",X,1,SDWID)
 S X=$$SETSTR^VALM1(SDPARM(43,1,32,"E"),X,SDFCOL,4)
 D SET(X)
 ;
8 S X=""
 S X=$$SETSTR^VALM1("Late Activity Mail Group:",X,35,25)
 S X=$$SETSTR^VALM1(SDPARM(43,1,217,"E"),X,SDSCOL,19)
 D SET(X)
 D CNTRL^VALM10(SDLN,4,22,IOINHI,IOINORM,0)
 ;
9 D SET("")
 ;
10 S X=""
 S X=$$SETSTR^VALM1(" API Messages Mail Group:",X,35,25)
 S X=$$SETSTR^VALM1(SDPARM(43,1,226,"E"),X,SDSCOL,19)
 D SET(X)
 ;
11 D SET("")
 ;
12 S X=""
 S X=$$SETSTR^VALM1(" API Messages to Process:",X,35,25)
 S X=$$SETSTR^VALM1(SDPARM(43,1,227,"E"),X,SDSCOL,19)
 D SET(X)
 ;
13 D SET("")
 ;
14 S X=""
 S X=$$SETSTR^VALM1(" Allow '^' out of Class.:",X,35,25)
 S X=$$SETSTR^VALM1(SDPARM(43,1,224,"E"),X,SDSCOL,19)
 D SET(X)
 ;
15 D SET("")
 ;
16 D SET("                      *** Editable Division Parameters ***")
 D CNTRL^VALM10(SDLN,23,36,IOINHI,IOINORM,0)
 ;
 D ^SDPARM1 ; Call to build display for division
 ;
 S VALMCNT=SDLN
 Q
 ;
QUIT ;
 K DIC,DIQ,DR,SD,SDJ,SDDIV,SDDLN,SDFCOL,SDSCOL,SDL,SDLN,SDPARM,SDSITE,SDVLAR,SDWID,^TMP("SDPARM",$J)
 Q
INIT ;Init variables
 ;
 K ^TMP("SDPARM",$J)
 S SDVLAR="^TMP(""SDPARM"",$J)"
 S SDFCOL=31,SDSCOL=61,SDWID=29,SDLN=0
 S SDSITE=$P($$SITE^VASITE,U,2) D WAIT^DICD
 F DA=0:0 S DA=$O(^DG(40.8,DA)) Q:'DA  S DIC="^DG(40.8,",DR=".01;9;30.01:30.04",DIQ="SDPARM",DIQ(0)="E" D EN^DIQ1 W "."
 S DIC="^DG(43,",DA=1,DR="32;205;212;215;216;217;224;226;227",DIQ="SDPARM",DIQ(0)="E" D EN^DIQ1
 Q
SET(X) ; Set in ^TMP global for display
 ;
 S SDLN=SDLN+1,^TMP("SDPARM",$J,SDLN,0)=X
 Q
 ;
