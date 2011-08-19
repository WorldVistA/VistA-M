HLDIEDBG ;CIOFO-O/LJA - Direct 772 & 773 Sets DEBUG CODE ;12/29/03 10:39
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
 ; D MENU^HLDIE to invoke debug menu.  Debugger documentation included.
 ;
MENU ; Additional documentation available in INIT^HLDIEDB1...
 D INIT^HLDIEDB1
 Q
 ;
SETDEBUG ; Set or "unset" the DEBUG string...
 N IOBOFF,IOBON,IOINHI,IOINORM,NEWSTR,STRING,X
 W @IOF,$$CJ^XLFSTR("HLDIE Debug String Set/Unset Utility",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 ; Ask for a new string...
 W !!,"When asked for a new debug string, you may take one of the following actions:"
 W !!," * Enter RETURN or '^' to exit."
 W !," * Enter a debug string.  (E.g., '1' or '1^2' or '1^1^1'.)"
 W !," * Enter '@' to delete the debug string, (If a debug string exists)."
 ;
SET1 ;
 ; Get current DEBUG value...
 S STRING=$G(^XTMP("HLDIE-DEBUG","STATUS"))
 ;
 ; Show user current value...
 W !!!!,"Current DEBUG string = ",IOINHI,STRING,IOINORM
 ;
 ; Get new debug string...
 W !!,"Enter DEBUG string, ",$S(STRING]"":"'@', ",1:""),"or RETURN to exit: "
 R NEWSTR:999 QUIT:'$T  ;->
 ;
 ; Exit conditions...
 I NEWSTR=U!(NEWSTR']"") D  QUIT  ;->
 .  I STRING']"" D  QUIT  ;->
 .  .  W "   no changes made.  Exiting... "
 .  .  H 2
 .  W !!,"No changes made.  (If you want to stop debugging, enter '"
 .  W IOINHI,"@",IOINORM,"'.)  Exiting..."
 ;
 ; Reset to null if @...
 I NEWSTR="@" S NEWSTR=""
 ;
 ; User didn't change anything!!!
 I NEWSTR=STRING W "  no changes made... " G SET1 ;->
 ;
 ; If debug string to be set to null...
 I NEWSTR']"" D  G SET1 ;->
 .  KILL ^XTMP("HLDIE-DEBUG","STATUS")
 .  W "  stopped all debugging!"
 ;
 ; Debug string has text, so just set it...
 S ^XTMP("HLDIE-DEBUG",0)=$$FMADD^XLFDT(DT,7)_U_$$NOW^XLFDT_U_"Control string for HLDIE debugging"
 S ^XTMP("HLDIE-DEBUG","STATUS")=NEWSTR
 W "  debugging set..."
 ;
 Q
 ;
 ;
 ; ================================================================
 ;
 ;
DEBUG(RTN,LOC,STORE,XEC) ; Store debug data... (Don't call unless all
 ; checks have been made and debug data IS to be stored!)
 ;
 ; ROOT() -- req
 ;
 ; RTN -- Where (subrtn~rtn, usually) call to FILE^HLDIE made from.
 ;
 ; LOC -- Location... BEFORE FILE^HLDIE call = 1
 ;                    AFTER FILE^HLDIE call = 2
 ;
 ; STORE -- "" = Don't collect
 ;           1 = Collect "select" (see above) data.
 ;           2 = Collect "all" data.
 ;
 ; XEC -- If XEC=1 then S STORE=$$STORE^HLDIEDB0(RTN,LOC,STORE) is
 ;        called to optionally change the value of STORE (and thus
 ;        control whether data is stored.)
 ;
 N CT,DEBUGNO,DEBUGNOW,HLFILE,HLIEN,INCRNO,NO,X,XTMP
 ;
 S DEBUGNOW=$$NOW^XLFDT,DT=DEBUGNOW\1
 ;
 ; Get file and ien for storing in XTMP...
 S FILE=$G(FILE),IEN=$G(IEN)
 I FILE,IEN S HLFILE=FILE,HLIEN=IEN
 I 'FILE!('IEN) D
 .  S (HLFILE,HLIEN)=0
 .  I $G(ROOT)]"" S HLFILE=$O(@ROOT@(0)),HLIEN=+$O(@ROOT@(+HLFILE,""))
 ;
 ; Get storage number...
 S DEBUGNO=$O(^XTMP("HLDIE-DEBUG-"_DT,$J,RTN,":"),-1)+1
 ;
 ; How many stored?  Can't store more than 20...
 S CT=0,NO=0
 F  S NO=$O(^XTMP("HLDIE-DEBUG-"_DT,$J,RTN,NO)) Q:'NO  D
 .  S CT=CT+1
 ;
 ; If M code passed, check w/^DIM, then execute.
 I XEC=1 S STORE=$$STORESCR^HLDIEDB2(RTN,LOC,STORE) QUIT:'STORE  ;->
 ;
ERRESUME ; If $$STORESCR code errors, there has to be a place for
 ; error trapping to GOTO.  This is that place...
 ;
 ; Quit if 20 occurences stored...
 QUIT:CT'<20  ;->
 ;
 ; Zero node & XTMP...
 ;
 ; Debug data retained for 7 days...
 S XTMP="HLDIE-DEBUG-"_DT
 S:$G(^XTMP(XTMP,0))']"" ^XTMP(XTMP,0)=$$FMADD^XLFDT(DT,7)_U_DEBUGNOW_U_"Debug data created by HLDIEDBG routine"
 ;
 ; Xref data retain for 7 days from last time any DEBUG data created...
 S XTMP="HLDIE-DEBUGX"
 S:$G(^XTMP(XTMP,0))']"" ^XTMP(XTMP,0)=$$FMADD^XLFDT(DT,7)_U_$$NOW^XLFDT_U_"Debug data created by HLDIEDBG routine"
 I $P(^XTMP(XTMP,0),U)'=$$FMADD^XLFDT(DT,7) S $P(^XTMP(XTMP,0),U)=$$FMADD^XLFDT(DT,7)
 ;
 ; Get incremental number...
 S INCRNO=$I(^XTMP("HLDIE-DEBUGN","N"),1)
 ;
 ; Do following for STORE=1 and STORE=2...
 S ^XTMP("HLDIE-DEBUG-"_DT,$J,RTN,+DEBUGNO)=LOC_U_DEBUGNOW_U_$G(HLFILE)_U_$G(HLIEN)_U_$TR($P($G(XQY0),U,1,2),U,"~")_U_$TR($G(HLEDITOR),U,"~")
 D STOREMSG(+$G(HLFILE),+$G(HLIEN),RTN,DEBUGNO,LOC,INCRNO)
 ;
 ; Store "select" data...
 I STORE=1,LOC'=2,$G(ROOT)]"" D  QUIT  ;->
 .  MERGE ^XTMP("HLDIE-DEBUG-"_DT,$J,RTN,+DEBUGNO)=@ROOT
 ;
 QUIT:STORE'=2  ;->
 ;
 ; Store "all" local variable data...
 S X="^XTMP(""HLDIE-DEBUG-"_DT_""","_$J_","""_RTN_""","_DEBUGNO_","
 D DOLRO^%ZOSV
 ;
 D ONLYASC(X)
 ;
 Q
 ;
ONLYASC(REF) ; Convert control characters to {ASCII}...
 N DATA,LP
 ;
 S LP=$E(REF,1,$L(REF)-1)_")"
 F  S LP=$Q(@LP) Q:LP'[REF  D
 .  S DATA=$$ONLYASC^HLDIEDB0(@LP)
 .  I $L(DATA),$TR(DATA," ","")']"" S DATA="{#"_$L(DATA)_" spaces}"
 .  S @LP=DATA
 ;
 Q
 ;
STOREMSG(FILE,IEN,RTN,DEBUGNO,LOC,INCRNO) ; Store message data in ^XTMP...
 ; DEBUGNOW -- req
 N GBL,NODE
 ;
 ; Set XREF XTMP...
 S ^XTMP("HLDIE-DEBUGX",FILE,IEN,DEBUGNOW,$J,RTN,DEBUGNO)=LOC_U_$TR($G(HLEDITOR),U,"~")
 S ^XTMP("HLDIE-DEBUGN","N",INCRNO)=FILE_U_IEN_U_DEBUGNOW_U_$J_U_RTN_U_DEBUGNO_U_LOC_U_$TR($G(HLEDITOR),U,"~")
 ;
 ; Get GBL...
 S GBL=$S(FILE=772:"^HL(772,"_IEN_")",1:"^HLMA("_IEN_")")
 ;
 ; Collect message data...
 F NODE=0,1,2,"P","S",$S(FILE=772:"IN",1:"MSH") D NODE(GBL,NODE)
 ;
 Q
 ;
NODE(GBL,NODE) ; Collect message data...
 ; RTN,DEBUGNO -- req
 N LAST,LNO,TXT,X
 ;
 I NODE="MSH" D  QUIT  ;->
 .  N LNO,TXT
 .  S LNO=0
 .  F  S LNO=$O(@GBL@("MSH",LNO)) Q:'LNO  D
 .  .  S TXT=$G(@GBL@("MSH",+LNO,0)) QUIT:TXT']""  ;->
 .  .  S ^XTMP("HLDIE-DEBUG-"_DT,$J,RTN,DEBUGNO,"D","MSH",LNO,0)=TXT
 ;
 I NODE="IN" D  QUIT  ;->
 .  N LAST,TXT
 .  S LAST=$O(@GBL@("IN",":"),-1)
 .  S TXT=$G(@GBL@("IN",1,0)) QUIT:TXT']""  ;->
 .  S ^XTMP("HLDIE-DEBUG-"_DT,$J,RTN,DEBUGNO,"D","IN",1,0)=1_":"_LAST_"~"_TXT
 ;
 ; Store node...
 S X=$G(@GBL@(NODE)) I X]"" S ^XTMP("HLDIE-DEBUG-"_DT,$J,RTN,DEBUGNO,"D",NODE)=X
 ;
 Q
 ;
KILLALL ; Don't call here unless it's OK to remove ALL-ALL debug data...
 N KILL,OFF,XTMP
 ;
 I $O(^XTMP("HLDIE-DEBUG"))']"HLDIE-DEBUG" D  QUIT  ;->
 .  W !!,"No debug data exists..."
 ;
 W !
 S KILL=$$YN^HLCSRPT4("Kill **ALL** debug data","No")
 I 'KILL W "  no data will be killed..." QUIT  ;->
 ;
 W !!,"KILLing all debug data..."
 S XTMP="HLDIE-DEBUG"
 F  S XTMP=$O(^XTMP(XTMP)) Q:XTMP'["HLDIE-DEBUG"  D
 .  KILL ^XTMP(XTMP)
 ;
 Q
 ;
LOG(SUBSV,KEEP,STOP) ; Log local vars into ^XTMP("HLDIE "_DT)...
 ;
 ; Documentation in MENU^HLDIE...
 ;
 N NO,NOW,NOXTMP,X,XTMP
 ;
 ; Presets...
 S SUBSV=$G(SUBSV),KEEP=$G(KEEP),STOP=$G(STOP),NOXTMP=0,NOW=$$NOW^XLFDT
 S SUBSV=$TR($S(SUBSV]"":SUBSV,1:"UNKNOWN"),"""","")
 ;
 ; # to keep setup...
 S KEEP=$S(KEEP&(KEEP<100):KEEP,1:20)
 ;
 ; XTMP setup...
 S XTMP="HLDIE-"_DT
 S:'$D(^XTMP(XTMP,0)) ^XTMP(XTMP,0)=$$FMADD^XLFDT(NOW,7)_U_$$NOW^XLFDT_U_"Data logged by LOG~HLDIE"
 ;
 ; Count number entries...
 I STOP=1 D
 .  S NOXTMP=0,NO=0
 .  F  S NO=$O(^XTMP(XTMP,SUBSV,NO)) Q:'NO  D
 .  .  S NOXTMP=NOXTMP+1
 ;
 ; Incremented sequential store #...
 S NO=$O(^XTMP(XTMP,SUBSV,":"),-1)+1
 ;
 ; STOP now?
 I STOP,NOXTMP'<KEEP QUIT  ;->
 ;
 ; Store all local variables...
 S X="^XTMP("""_XTMP_""","""_SUBSV_""","_NO_"," D DOLRO^%ZOSV
 S ^XTMP(XTMP,SUBSV,NO)=$$NOW^XLFDT
 ;
 I $ZE]"" S ^XTMP(XTMP,SUBSV,NO,"$ZE")=$ZE
 ;
 ; Keep only KEEP instances...
 F NO=NO-KEEP:-1:1 KILL ^XTMP(XTMP,SUBSV,NO)
 ;
 Q
 ;
EOR ;HLDIEDBG - Direct 772 & 773 Sets DEBUG CODE ; 11/18/2003 11:17
