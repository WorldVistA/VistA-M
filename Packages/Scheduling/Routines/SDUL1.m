SDUL1 ;ALB/MJK - Screen Malipulation Utilities ; 12/1/91
 ;;5.3;Scheduling;**140**;Aug 13, 1993
 ;
INSTR(STR,X,Y,LENGTH,ERASE) ; -- insert text
 ;    STR := string to insert
 ;      X := X coordinate
 ;      Y := Y coordinate
 ; LENGTH := clear # of characters
 ;  ERASE := erase chars first
 ;
 W IOSC
 I $G(ERASE) S DY=Y-1,DX=X-1 X IOXY W $J("",LENGTH)
 S DY=Y-1,DX=X-1 X IOXY W STR
 W IORC
 Q
 ;
FLDUPD(STR,FLD,ENTRY) ; -- update entry and field on screen
 ;    STR := string to insert
 ;    FLD := col name
 ;  ENTRY := entry # in list
 ;
 D INSTR(.STR,+$P(SDULDDF(FLD),U,2),ENTRY-SDULBG+SDUL("TM"),$P(SDULDDF(FLD),U,3),1)
 Q
 ;
SETFLD(STR,VAR,FLD) ; -- set field in var
 ; input: STR := string to insert
 ;        VAR := destination string
 ;        FLD := col name
 Q $$SETSTR^SDUL1(STR,VAR,+$P(SDULDDF(FLD),U,2),+$P(SDULDDF(FLD),U,3))
 ;
SETSTR(S,V,X,L) ; -- insert text(S) into variable(V)
 ;    S := string to insert
 ;    V := destination string
 ;    X := insert @ col X
 ;    L := clear # of chars (length)
 ;
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
FULL ; set full scrolling region
 I '$D(IOSTBM) D TERM^SDUL0
 I IOSTBM]"" S IOTM=1,IOBM=IOSL W IOSC W @IOSTBM W IORC
 Q
 ;
CLEAR ; -- clear screen
 D FULL,ERASE W @IOF
 Q
 ;
ERASE ;
 F X="IOUOFF","IOINORM" W $G(@X)
 Q
 ;
FDATE(Y) ; -- return formatted date
 ;   input:          Y := field name
 ;  output: [returned] := formatted date only
 Q $TR($$FMTE^XLFDT(Y,"5DF")," ","0")
 ;
FTIME(Y) ; -- return formatted date/time
 ;   input:          Y := internal date/time
 ;  output: [returned] := formatted date and time
 D DD^%DT
 Q Y
 ;
FDTTM(Y) ; -- return formatted date/time
 ;   input:          Y := internal date/time
 ;  output: [returned] := formatted date and time
 N SDY
 S SDY=$TR($$FMTE^XLFDT(Y,"5DF")," ","0")
 D DD^%DT
 Q SDY_$S($P(Y,"@",2)]"":"@"_$P(Y,"@",2),1:"")
 ;
NOW() ; -- return now
 D NOW^%DTC
 Q $$FTIME(%)
 ;
RANGE ; -- change date range
 ; input: ^TMP("SDUL DATA",$J SDULEVL,"DAYS") := number of days allowed
 ;                 SDB := default beginning date {optional}
 ;
 I $D(SDB) S Y=SDB D DD^%DT S:Y]"" %DT("B")=Y
 W ! S:$D(SDMIN) %DT(0)=SDMIN S %DT="AEX",%DT("A")="Select Beginning Date: " D ^%DT K %DT
 G RANGEQ:Y<0 S (X1,SDX)=Y,X2=+$G(^TMP("SDUL DATA",$J,SDULEVL,"DAYS")) D C^%DTC S SDX1=X,X=""
 I SDX'>DT,SDX1>DT S X="TODAY"
 I X="" S Y=SDX D DD^%DT S X=Y
 S DIR("B")=X
 S DIR(0)="DA"_U_SDX_":"_SDX1_":EX",DIR("A")="Select    Ending Date: "
 S DIR("?",1)="Date range can be a maximum of "_+$G(^TMP("SDUL DATA",$J,SDULEVL,"DAYS"))_" days long.",DIR("?",2)=" "
 S DIR("?",3)="Enter a date between "_$$FDATE(SDX)_" and "_$$FDATE(SDX1)_".",DIR("?")=" "
 D ^DIR K DIR G RANGEQ:Y'>0 S SDEND=Y,SDBEG=SDX
RANGEQ K SDX,SDX1 Q
 ;
PAUSE ;
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
 ;
PRT ; -- prt screen (PS)
 N SDESC
 S SDULBCK=$S(SDULCC:"",1:"R")
 S %ZIS="Q" D ^%ZIS G PRTQ:POP
 I '$D(IO("Q")),IO=IO(0) S SDULBCK="R" D CLEAR
 I '$D(IO("Q")) G PRTS
 S ZTRTN="PRTS^SDUL1",ZTIO=ION,ZTDESC="Print Screen -- List Manager Action"
 D SAVE,^%ZTLOAD G PRTQ
 ;
PRTS ;
 N SDULCC,SDULCAP
 S SDULCC=0,SDULCAP=$$CAPTION^SDUL
 U IO D HDR^SDUL,LIST^SDUL,FTR
PRTQ D:'$D(ZTQUEUED) ^%ZISC D TERM^SDUL0
 Q
 ;
SAVE ; -- save to queue
 F X="SDULPGE","SDULWD","SDULCNT","SDULBG","SDULDDF(","SDULHDR(","SDUL(","SDULAR",$E(SDULAR,1,$L(SDULAR)-1)_$S($E(SDULAR,$L(SDULAR))=")":",",1:"(") S ZTSAVE(X)=""
 Q
 ;
FTR ; -- footer to print
 S SDESC=""
 I $E(IOST,1,2)="C-" D PAUSE S SDESC='Y
 Q
 ;
PRTL ; -- prt list (PL)
 N SDESC
 S SDULBCK=$S(SDULCC:"",1:"R")
 S %ZIS="Q" D ^%ZIS G PRTQ:POP
 I '$D(IO("Q")),IO=IO(0) S SDULBCK="R" D CLEAR
 I '$D(IO("Q")) G PRTLS
 S ZTRTN="PRTLS^SDUL1",ZTIO=ION,ZTDESC="Print List -- List Manager Action"
 D SAVE,^%ZTLOAD G PRTLQ
 ;
PRTLS ;
 N SDULPGE,SDESC,SDULCC,SDI,SDLINES,SDULCAP
 S SDLINES=SDUL("LINES")
 S SDUL("LINES")=IOSL-5,SDULCC=0,SDULPGE=1,SDULCAP=$$CAPTION^SDUL
 U IO D HDR^SDUL
 F SDI=1:1:SDULCNT S X=$G(@SDULAR@($$GET^SDUL4(SDI),0)) W !,X I IOSL<($Y+6) D FTR G PRTLQ:SDESC S SDULPGE=SDULPGE+1 D HDR^SDUL
 D FTR
PRTLQ D:'$D(ZTQUEUED) ^%ZISC D TERM^SDUL0
 S:$D(SDLINES) SDUL("LINES")=SDLINES
 Q
 ;
UPPER(X) ; -- convert to uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
LOWER(X) ;
 N Y,C,Z,I
 S Y=$E(X)_$TR($E(X,2,999),"ABCDEFGHIJKLMNOPQRSTUVWXYZ@","abcdefghijklmnopqrstuvwxyz ")
 F C=" ",",","/" F I=2:1 S Z=$P(Y,C,I,999) Q:Z=""  S Y=$P(Y,C,1,I-1)_C_$TR($E(Z),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(Z,2,999)
 Q Y
 ;
