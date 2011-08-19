SCRPW302 ;BPFO/JRC - Performance Monitor Report Utils; 30 Jul 2003
 ;;5.3;SCHEDULING;**292**;AUG 13, 2003
 ;
TLMT(SCRNARR) ; Set Time Limit into screen array
 ;Input  : SCRNARR - Screen array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("TLMT") = Time Limit (days)
 ;Note   : @SCRNARR@("TLMT") is initialized (KILLed) on input
 ;
 ; Declare variables
 N DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT
 K @SCRNARR@("TLMT")
 ; Prompt user for number of days
 S DIR(0)="N^2:100:0"
 S DIR("A")="Enter number of days for Elapsed Time: "
 S DIR("B")=10
 D ^DIR
 I $D(DIRUT) Q 0
 S @SCRNARR@("TLMT")=X
 Q 1
 ;
DATE(MIN,MAX,SCRNARR) ; Set Date Range into screen array
 ;Input  : SCRNARR - Screen array full global reference
 ;         MIN - Minimum date (FileMan) (default to MAX - time limit)
 ;         MAX - Maximum date (FileMan) (default to T - time limit)
 ;         @SCRNARR@("TLMT") - Time limit (optional - default to 10)
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("RANGE") = StartDate^EndDate
 ;Note   : @SCRNARR@("RANGE") is initialized (KILLed) on input
 ;
 ;Declare variables
 N STDATE,ENDDATE,DATE,DIR,X,Y,TLMT,DIRUT,DIROUT,DTOUT,DUOUT
 K @SCRNARR@("RANGE")
 S MIN=$P($G(MIN),".",1)
 S MAX=$P($G(MAX),".",1)
 ;Get time limit out of screen array (default to 10)
 S TLMT=+$G(@SCRNARR@("TLMT")) S:'TLMT TLMT=10
 ;Maximum date can't be more then Today minus time limit
 S DATE=$$FMADD^XLFDT($$DT^XLFDT(),-TLMT)
 I ('MAX)!(MAX>DATE) S MAX=DATE
 ;Minimum date can't be after maximum date
 I (MAX'>MIN) S MIN=$$FMADD^XLFDT(MAX,-TLMT)
 ;Prompt user for start date
 S DIR(0)="D^"_MIN_":"_MAX_":PEX"
 S DIR("A")="Enter Report Start Date"
 S DATE=$S('MIN:$$FMADD^XLFDT(MAX,-TLMT),1:MIN)
 S DIR("B")=$$FMTE^XLFDT(DATE,"5D")
 D ^DIR
 I $D(DIRUT) Q 0
 S STDATE=Y
 ;Prompt user for end date
 K DIR,X,Y
 S MIN=STDATE
 S DIR(0)="D^"_MIN_":"_MAX_":PEX"
 S DIR("A")="Enter Report Stop Date"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(STDATE,TLMT),"5D")
 D ^DIR
 I $D(DIRUT) K @SCRNARR@("RANGE") Q 0
 S ENDDATE=Y
 S @SCRNARR@("RANGE")=STDATE_"^"_ENDDATE
 Q 1
DIV(SCRNARR) ; Set Divisions into screen array (prompt is one/many/all)
 ;Input  : SCRNARR - Screen array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("DIVISION") = User pick all divisions ?
 ;           1 = Yes (all)     0 = No
 ;         @SCRNARR@("DIVISION",PtrDiv) = Division name
 ;Note   : @SCRNARR@("DIVISION") is initialized (KILLed) on input
 ;       : @SCRNARR@("DIVISION",PtrDiv) is only set when the user
 ;         picked individual divisions (i.e. didn't pick all)
 ;
 ;Declare variables
 N VAUTD,Y
 K @SCRNARR@("DIVISION")
 ;Get division selection
 D DIVISION^VAUTOMA
 I Y<0 Q 0
 M @SCRNARR@("DIVISION")=VAUTD
 Q 1
 ;
PROV(SCRNARR) ; Set Providers into screen array (prompt is one/many/all)
 ;Input  : SCRNARR - Screen array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("PROVIDERS") = User pick all providers ?
 ;           1 = Yes (all)     0 = No
 ;         @SCRNARR@("PROVIDERS",PtrProvider) = Provider name
 ;Note   : @SCRNARR@("PROVIDERS") is initialized (KILLed) on input
 ;       : @SCRNARR@("PROVIDERS",PtrProvider) is only set when the user
 ;         picked individual providers (i.e. didn't pick all)
 ;
 ;Declare variables
 N DIC,VAUTSTR,VAUTVB,VAUTNI,SCANARR,Y
 K @SCRNARR@("PROVIDERS")
 ;Get provider selection
 S DIC="^VA(200,"
 S VAUTSTR="PROVIDER"
 S VAUTVB="SCANARR"
 S VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 Q 0
 M @SCRNARR@("PROVIDERS")=SCANARR
 Q 1
 ;
SCAN(SCRNARR) ; Set Scanned Notes into screen array
 ;Input  : SCRNARR - Screen array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("SCANNED") = Include count of encounters with
 ;                                scanned notes    1 = Yes  0 = No
 ;Note   : @SCRNARR@("SCANNED") is initialized (KILLed) on input
 ;
 ;Declare variables
 N DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT
 K @SCRNARR@("SCANNED")
 ;Prompt user
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("A")="Would you like to include SCANNED notes "
 D ^DIR
 I $D(DIRUT) Q 0
 S @SCRNARR@("SCANNED")=Y
 Q 1
