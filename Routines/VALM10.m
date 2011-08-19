VALM10 ;MJK;09:29 PM  17 Jan 1993;
 ;;1;List Manager;;Aug 13, 1993
 ;
CNTRL(LINE,COL,WIDTH,ON,OFF,SAVE) ; -- set video control chars
 ; input:   LINE := line number
 ;           COL := column to start control
 ;         WIDTH := how many characters should contrl be in effect
 ;            ON := beginninng control code (ex. the value of IOINHI)
 ;           OFF := ending control code (ex. the value of IOINORM)
 ;          SAVE := 1 to save control code for later use
 ;                  otherwise 0 [optional]
 ;
 S X="VALM VIDEO"_$S($G(SAVE):" SAVE",1:"")
 S ^TMP(X,$J,VALMEVL,LINE,COL,WIDTH)=ON
 S ^TMP(X,$J,VALMEVL,LINE,COL+WIDTH,0)=OFF
 Q
 ;
KILL(LINE) ; -- kill off video cntrls for a line
 ; input:   LINE := line number
 ;
 K:'$D(LINE) ^TMP("VALM VIDEO",$J,VALMEVL),^TMP("VALM VIDEO SAVE",$J,VALMEVL)
 K:$D(LINE) ^TMP("VALM VIDEO",$J,VALMEVL,LINE),^TMP("VALM VIDEO SAVE",$J,VALMEVL,LINE)
 Q
 ;
SAVE(LINE) ; -- save video cntrls for a line
 ; input:   LINE := line number
 ;
 D SWAP("^TMP(""VALM VIDEO"",$J,VALMEVL,LINE)","^TMP(""VALM VIDEO SAVE"",$J,VALMEVL,LINE)")
 Q
 ;
RESTORE(LINE) ; -- restore video cntrls for a line
 ; input:   LINE := line number
 ;
 D SWAP("^TMP(""VALM VIDEO SAVE"",$J,VALMEVL,LINE)","^TMP(""VALM VIDEO"",$J,VALMEVL,LINE)")
 Q
 ;
SWAP(FR,TO,SAVE) ; -- swap video cntrl arrays
 ;                    [not a supported call]
 ;
 K @TO
 S COL=0
 F  S COL=$O(@FR@(COL)) Q:'COL  D
 .N WIDTH S WIDTH=""
 .F  S WIDTH=$O(@FR@(COL,WIDTH)) Q:WIDTH=""  S @TO@(COL,WIDTH)=@FR@(COL,WIDTH)
 K:'$G(SAVE) @FR
 Q
 ;
SELECT(LINE,MODE) ; -- highlight/unhighlight a line
 ; input:   LINE := line number
 ;          MODE := 1 to highlight line
 ;                  0 to unhighlight and restore to original state
 ;
 I MODE D
 .D SAVE(.LINE)
 .D CNTRL(.LINE,1,VALM("RM"),.IOINHI,.IOINORM)
 I 'MODE D RESTORE(.LINE)
 D WRITE(.LINE)
 Q
 ;
WRITE(LINE) ; -- re-write line to screen
 ; input:   LINE := line number
 ;
 N DY
 W IOSC
 S DY=LINE-VALMBG+VALM("TM")-1 D IOXY^VALM4(0,.DY)
 D WRITE^VALM4(.LINE,0,1,.DY)
 W IORC
 Q
 ;
FLDTEXT(LINE,FLD,TEXT) ; -- set text for field in line
 ; input:   LINE := line number
 ;           FLD := caption field name
 ;          TEXT := text to insert for field
 ;
 S @VALMAR@(LINE,0)=$$SETFLD^VALM1(.TEXT,@VALMAR@(LINE,0),.FLD)
 Q
 ;
FLDCTRL(LINE,FLD,ON,OFF,SAVE) ; -- set default video ctrls for line
 ;                            or just 1 field
 ; input:   LINE := line number
 ;           FLD := caption field name [optional]
 ;            ON := beginninng control code (ex. the value of IOINHI)
 ;           OFF := ending control code (ex. the value of IOINORM)
 ;          SAVE := 1 to save control code for later use
 ;                  otherwise 0 [optional]
 ;
 I $G(FLD)="" D SWAP("^TMP(""VALM VIDEO SAVE"",$J,VALMEVL,0)","^TMP(""VALM VIDEO"",$J,VALMEVL,LINE)",1) G FLDCTRLQ
 ; -- just a fld
 N COL,WIDTH,X I '$D(ON) N ON,OFF
 S X=VALMDDF(FLD),COL=$P(X,U,2),WIDTH=$P(X,U,3)
 I '$D(ON) D
 .S (ON,OFF)=""
 .D ATRFLD^VALM00(.FLD,.ON,.OFF)
 D:ON]"" CNTRL(LINE,COL,WIDTH,.ON,.OFF,$G(SAVE))
FLDCTRLQ Q
 ;
SET(LINE,TEXT,ENTRY) ; -- set text in array
 ; input:   LINE := line number
 ;          TEXT := text for line
 ;         ENTRY := entry number assoicated with line [optional]
 ;                  >> if defined, then line will also be indexed
 ;
 S @VALMAR@(LINE,0)=TEXT
 S:$G(ENTRY) @VALMAR@("IDX",LINE,ENTRY)=""
 Q
 ;
CLEAN ; -- kill off lines and video cntrls
 K @VALMAR
 K ^TMP("VALM VIDEO",$J,VALMEVL)
 Q
 ;
MSG(VALMSG) ; -- post message immediately
 I VALMCC D INSTR^VALM1(IORVON_$E($S(VALMSG]"":VALMSG,1:$$MSG^VALM())_$J("",50),1,50)_IORVOFF,11,VALM("BM")+1,50,0) S VALMSG="" G MSGQ
 D LBAR^VALM
MSGQ Q
