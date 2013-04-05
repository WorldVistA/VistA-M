KMPDU6 ;OAK/RAK - CM Tools Utilities ;10/12/12  15:15
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
 ;
RUMENV(KMPDRES) ;-rpc run environment
 ;--------------------------------------------------------
 ; KMPDRES... result return data in format:
 ;              KMPDRES(0)=ErrorNumber^ErrorText
 ;              (see ENV^KMPRUTL1 for specifics)
 ;--------------------------------------------------------
 K KMPDRES
 N ERROR
 D ENVCHECK^KMPRUTL1(.ERROR,1)
 S KMPDRES(0)=ERROR
 ;
 Q
 ;
RUMSS(KMPDRES,KMPDSS) ;-rpc rum start/stop
 ;--------------------------------------------------------
 ; KMPDRES... result return data
 ; KMPDSS.... 0 - stop
 ;            1 - start
 ;--------------------------------------------------------
 K KMPDRES
 S KMPDSS=+$G(KMPDSS)
 N DA,DIE,ERR,ERROR,DR,FDA,I,LINE,X,Y
 ; if start
 I KMPDSS=1 D 
 .S FDA($J,8989.3,"1,",300)="Y"
 .D FILE^DIE("","FDA($J)","ERROR")
 .; if error process and quit
 .I $D(ERROR) D  Q
 ..; put error message into local array
 ..D MSG^DIALOG("AEHW",.ERR,60,10,"ERROR")
 ..; put error message into kmpdres array
 ..S (LINE,I)=0
 ..F  S I=$O(ERR(I)) Q:'I  D 
 ...I LINE=0 S KMPDRES(LINE)="["_ERR(I) S LINE=LINE+1 Q
 ...S KMPDRES(LINE)=ERR(I),LINE=LINE+1
 ..; put close bracket at end of text
 ..S KMPDRES(LINE-1)=KMPDRES(LINE-1)_"]"
 .;
 .S KMPDRES(0)="Resource Usage Monitor (RUM) has been started."
 ;
 ; if stop
 I 'KMPDSS D 
 .S FDA($J,8989.3,"1,",300)="N"
 .D FILE^DIE("","FDA($J)","ERROR")
 .; if error process and quit
 .I $D(ERROR) D  Q
 ..; put error message into local array
 ..D MSG^DIALOG("AEHW",.ERR,60,10,"ERROR")
 ..; put error message into kmpdres array
 ..S (LINE,I)=0
 ..F  S I=$O(ERR(I)) Q:'I  D 
 ...I LINE=0 S KMPDRES(LINE)="["_ERR(I) S LINE=LINE+1 Q
 ...S KMPDRES(LINE)=ERR(I),LINE=LINE+1
 ..; put close bracket at end of text
 ..S KMPDRES(LINE-1)=KMPDRES(LINE-1)_"]"
 .;
 .S KMPDRES(0)="Resource Usage Monitor (RUM) has been stopped."
 ;
 I '$D(KMPDRES(0)) S KMPDRES(0)="[Unable to "_$S(KMPDSS:"start",1:"stop")_" RUM]"
 ;
 Q
 ;
STATUS(KMPDRES,KMPDAPP,KMPDGBL) ;-rpc cp package status
 ;--------------------------------------------------------
 ; KMPDRES... result return data
 ; KMPDAPP... cm application
 ;            H - hl7
 ;            R - rum
 ;            S - sagg
 ;            T - timing
 ; KMPDGLO... global reference containing data
 ;--------------------------------------------------------
 ;
 ;
 K KMPDRES
 I $G(KMPDAPP)="" S @KMPDGBL@(0)="[Type of Application not defined]" Q
 I $L(KMPDAPP)>1 S @KMPDGBL@(0)="[Incorrect Application identifier format]" Q
 I "HRST"'[KMPDAPP S @KMPDGBL@(0)="[Incorrect Application identifier]" Q
 ;I KMPDGBL="" S @KMPDGBL@(0)="[Global for storage is not defined]" Q
 I $G(KMPDGBL)="" S @KMPDGBL@(0)="[Global for storage is not defined]" Q
 ;
 N DATA,I,KMPDNMSP,ROUTINE,VALMAR,X,Z
 ;
 ; kill global with check for ^tmp or ^utility.
 D KILL^KMPDU(.DATA,KMPDGBL)
 ; if error.
 I $E(DATA)="[" S @KMPDGBL@(0)=DATA Q
 ;
 S KMPDNMSP=KMPDAPP
 S ROUTINE="KMPDSS"_$S(KMPDAPP="H"!(KMPDAPP="T"):"D",1:KMPDAPP)
 S X=ROUTINE X ^%ZOSF("TEST") I '$T D  Q
 .S @KMPDGBL@(0)="[Routine "_X_" could not be found]"
 ;
 S ROUTINE="FORMAT^"_X_"(.Z)"
 S VALMAR=$NA(^TMP("KMPDU6",$J))
 ;
 D @ROUTINE
 ;
 I '$D(@VALMAR) S KMPDRES(0)="[No data to report]" K @VALMAR Q
 ;
 ; zero node is application status: started/stopped
 I KMPDAPP="H" S @KMPDGBL@(0)="0"
 I KMPDAPP="R" S @KMPDGBL@(0)=$G(^%ZTSCH("LOGRSRC"))
 I KMPDAPP="S" S @KMPDGBL@(0)=$S($D(^XTMP("KMPS","START")):1,1:0)
 I KMPDAPP="T" S @KMPDGBL@(0)=$G(^KMPTMP("KMPD-CPRS"))
 F I=0:0 S I=$O(@VALMAR@(I)) Q:'I  S @KMPDGBL@(I)=@VALMAR@(I,0)
 ;
 K @VALMAR
 ;
 S KMPDRES=$NA(@KMPDGBL)
 S:'$D(@KMPDGBL) KMPDRES="<No Data To Report>"
 ;
 Q
 ;
USRPARAM(KMPDY,KMPDUZ,KMPDTY,KMPDOP) ;-- rpc - user parameters
 ;-------------------------------------------------------------------
 ; KMPDY... return results
 ; KMPDUZ.. user duz
 ; KMPDTY.. type: 1 - get user parameter info
 ;                2 - set user parameter info
 ; KMPDOP.. option array in format:
 ;           Piece 1: option name
 ;           Piece 2: 1 - do not display option
 ;                    2 - display option
 ;           example: KMPDOP(1)="ErrorLog1^1"
 ;-------------------------------------------------------------------
 ;
 K KMPDY
 ;
 I '$G(KMPDUZ) S KMPDY(0)="[User 'DUZ' not defined]" Q
 S KMPDTY=+$G(KMPDTY)
 I KMPDTY<1!(KMPDTY>2) S KMPDY(0)="[Type parameter out of bounds]" Q
 ;
 ; get parameter data
 I KMPDTY=1 D 
 .S KMPDY(0)="ErrorLog1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ERROR LIST",,"Q")
 .S KMPDY(1)="GlobalList1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION GLOBAL LIST",,"Q")
 .S KMPDY(2)="RoutineSearch1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ROUTINE SEARCH",,"Q")
 .S KMPDY(3)="Lookups1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION LOOKUPS",,"Q")
 .S KMPDY(4)="CodeStats1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION CODE STATS",,"Q")
 .S KMPDY(5)="CodeEvaluator2^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION CODE EVALUATOR",,"Q")
 .S KMPDY(6)="TimingMonitor1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION TIMING MONITOR",,"E")
 .S KMPDY(7)="EnvironmentCheck1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ENVIRON CHECK",,"Q")
 .S KMPDY(8)="CMToolsParameters1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION TOOLS PARAMS",,"Q")
 .S KMPDY(9)="EnvironmentSelect^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ENVIRON SELECT",,"Q")
 .S KMPDY(10)="TimingReports1^"_$$GET^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION RPT",,"Q")
 ;
 ; set parameter data
 I KMPDTY=2 D 
 .Q:'$D(KMPDOP)
 .N I,OPT S I="",KMPDY(0)="complete"
 .F  S I=$O(KMPDOP(I)) Q:I=""  S OPT=KMPDOP(I) I OPT]"" D 
 ..I $P(OPT,U)="ErrorLog1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ERROR LIST",1,$P(OPT,U,2))
 ..I $P(OPT,U)="GlobalList1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION GLOBAL LIST",1,$P(OPT,U,2))
 ..I $P(OPT,U)="RoutineSearch1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ROUTINE SEARCH",1,$P(OPT,U,2))
 ..I $P(OPT,U)="Lookups1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION LOOKUPS",1,$P(OPT,U,2))
 ..I $P(OPT,U)="CodeStats1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION CODE STATS",1,$P(OPT,U,2))
 ..I $P(OPT,U)="CodeEvaluator2" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION CODE EVALUATOR",1,$P(OPT,U,2))
 ..I $P(OPT,U)="TimingMonitor1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION TIMING MONITOR",1,$P(OPT,U,2))
 ..I $P(OPT,U)="EnvironmentCheck1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ENVIRON CHECK",1,$P(OPT,U,2))
 ..I $P(OPT,U)="CMToolsParameters1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION TOOLS PARAMS",1,$P(OPT,U,2))
 ..I $P(OPT,U)="EnvironmentSelect" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION ENVIRON SELECT",1,$P(OPT,U,2))
 ..I $P(OPT,U)="TimingReports1" D EN^XPAR("USR.`"_KMPDUZ,"KMPD GUI OPTION RPT",1,$P(OPT,U,2))
 ;
 Q
