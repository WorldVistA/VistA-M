HLEVREP1 ;O-OIFO/LJA - Event Monitor REPORTS ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
CTRL ; Menu map display...
 N CT,DATE,DATEFRST,DATELAST,DATENXT,DATESEL,IOINHI,IOINORM
 N LINE,NO,TXT,X,Y
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 KILL ^TMP($J,"HLMAP")
 D HD("Event Monitor Display")
 D EX
 D PURGING
 W !
 QUIT:$$BTE^HLCSMON("Press RETURN to collect data, or '^' to exit... ")  ;->
 W !!,"Collecting..."
 D MAPALL
 D MONVALL^HLEVREP2
 ;
 I '$D(^TMP($J,"HLMAP","S","D")) D  QUIT  ;->
 .  D TELL^HLEVMST0("No data exists!","1^2^999")
 ;
 S DATEFRST=$O(^TMP($J,"HLMAP","S","D",0))
 S (DATELAST,DATENXT)=$O(^TMP($J,"HLMAP","S","D",":"),-1)
 ;
 W !!,"Data found for ",$$FMTE^XLFDT(DATEFRST)
 I DATELAST=DATEFRST W "."
 I DATELAST'=DATEFRST W " to ",$$FMTE^XLFDT(DATELAST),"."
 W !!,"Loading most recent date..."
 ;
 H 2
 ;
 S CT=0
 F  D  QUIT:DATE']""  ;->
 .  S CT=CT+1
 .  S (DATE,DATESEL)=$S(CT=1:DATELAST,1:$$MAPDATE(DATENXT)) QUIT:DATE'?7N  ;->
 .  S DATENXT=$$FMADD^XLFDT(DATE,-1) ; Next date to be prompted...
 .  S TXT="Event Monitor Map - "_$$FMTE^XLFDT(DATE)
 .  S LINE=$O(^TMP($J,"HLMAP","S","D",DATE,":"),-1)
 .  I LINE<22 D
 .  .  W @IOF,$$CJ^XLFSTR(TXT,IOM),!,$$REPEAT^XLFSTR("=",IOM)
 .  .  S NO=0
 .  .  F  S NO=$O(^TMP($J,"HLMAP","S","D",DATE,NO)) Q:'NO  D
 .  .  .  W !,^TMP($J,"HLMAP","S","D",DATE,NO)
 .  I LINE'<22 D
 .  .  D BROWSE^DDBR("^TMP($J,""HLMAP"",""S"",""D"","_DATE_")","N",TXT)
 .  D CTRLMON^HLEVREP3 ; All user to call up individual monitor run info...
 .  I DATENXT<DATEFRST D  QUIT  ;->
 .  .  W !!,"You just viewed the ",IOINHI,"earliest",IOINORM
 .  .  W " day on record.  (You must manually enter the"
 .  .  W !,"next date to view.)"
 .  .  W !
 .  .  S DATENXT=""
 .  I DATENXT=DATEFRST D  QUIT  ;->
 .  .  W !!,$$FMTE^XLFDT(DATENXT)," is the earliest date on record."
 .  .  W !
 .  W !!,"The next earlier date is prompted below."
 .  W !
 ;
 Q
 ;
MAPDEVCE ; Just dump to screen...
 N ABRT,CT,DAY,NO,X
 S DAY=0,ABRT=0,CT=0
 F  S DAY=$O(^TMP($J,"HLMAP","S","D",DAY)) Q:'DAY!(ABRT)  D
 .  W !!,$$CJ^XLFSTR(" Event Monitor Information - "_$$FMTE^XLFDT(DAY)_" ",IOM,"=")
 .  S CT=CT+2
 .  S NO=0
 .  F  S NO=$O(^TMP($J,"HLMAP","S","D",DAY,NO)) Q:NO'>0  D
 .  .  S CT=CT+1
 .  .  W !,^TMP($J,"HLMAP","S","D",DAY,NO)
 .  .  QUIT:CT<22  ;->
 .  .  R X:999 S CT=0
 R:CT X:999
 Q
 ;
MAPDATE(DATEPMT) ; Select date...
 N ANS,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="DO^"_DATEFRST_":"_DATELAST_":EX"
 S DIR("A")="Select DATE",DIR("?")="Enter a report date, (but don't enter time of day.)"
 I $G(DATEPMT)?7N S DIR("B")=$$FMTE^XLFDT(DATEPMT)
 D ^DIR
 QUIT:+Y?7N +Y ;->
 S ANS=Y
 I $$UP^XLFSTR($TR(X," ",""))["DUMP" D MAPDEVCE ;->
 Q ""
 ;
PURGING ; How for back does purging start?
 N DATA,PURGEHR
 S PURGEHR=$P($G(^HLEV(776.999,1,0)),U,4)
 S PURGEHR=$S(PURGEHR:PURGEHR,1:96)
 W !!,$$CJ^XLFSTR("--- Data before NOW-"_PURGEHR_" hours has been deleted ---",IOM)
 Q
 ;
HD(TXT) W @IOF,$$CJ^XLFSTR(TXT,IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This option collects all existing event monitor information for review.  You
 ;;can view a "map" of each monitor that ran, showing hour-by-hour when the
 ;;"run" occurred.  You may also select individual monitors for a more detailed
 ;;display.
 QUIT
 ;
MAPALL ; Do everything to get ^TMP($J,"HLMAP") data ready for printing...
 KILL ^TMP($J,"HLMAP")
 D MAPCOLLE ; Find events...
 D MAPCOLLM ; Find master job runs
 D MAPBUILD ; Build date array
 D MAPSCRN ;  Build daily screens
 Q
 ;
MAPCOLLM ; Collect map ^TMP data - Master job runs...
 N DATA,IENM,MONM,STAT,TIME
 S IENM=0
 F  S IENM=$O(^HLEV(776.2,IENM)) Q:'IENM  D
 .  S DATA=$G(^HLEV(776.2,IENM,0)) QUIT:$P(DATA,U)']""  ;->
 .  S STAT=$P(DATA,U,4) QUIT:STAT'="F"  ;->
 .  S TIME=$$ROUNDHR(+$P(DATA,U,2)) QUIT:TIME']""  ;->
 .  S ^TMP($J,"HLMAP","T")=$G(^TMP($J,"HLMAP","T"))+1
 .  S ^TMP($J,"HLMAP","T","M")=$G(^TMP($J,"HLMAP","T","M"))+1
 .  S ^TMP($J,"HLMAP","D",TIME,"M")=$G(^TMP($J,"HLMAP","D",TIME,"M"))+1
 .  S ^TMP($J,"HLMAP","D",TIME,"M",IENM)=""
 Q
 ;
MAPCOLLE ; Collect map ^TMP data - Events...
 N DATA,IENM,IENMST,MONIEN,MONM,STAT,TIME
 S IENM=0
 F  S IENM=$O(^HLEV(776,IENM)) Q:'IENM  D
 .  S DATA=$G(^HLEV(776,IENM,0)) QUIT:$P(DATA,U)']""  ;->
 .  S STAT=$P(DATA,U,4) QUIT:STAT'="F"
 .  S TIME=$$ROUNDHR(+DATA) QUIT:TIME']""  ;->
 .  S MONIEN=$P(DATA,U,3) QUIT:MONIEN'>0  ;->
 .  S MONIEN=MONIEN QUIT:MONIEN'>0  ;->
 .  S MONM=$P($G(^HLEV(776.1,+MONIEN,0)),U) QUIT:MONM']""  ;->
 .  S MONM=MONM_"["_MONIEN_"]"
 .  S IENMST=$P(DATA,U,9),IENMST=$S(IENMST>0:IENMST,1:9999999)
 .  S ^TMP($J,"HLMAP","T")=$G(^TMP($J,"HLMAP","T"))+1
 .  S ^TMP($J,"HLMAP","T","E")=$G(^TMP($J,"HLMAP","T","E"))+1
 .  S ^TMP($J,"HLMAP","D",TIME,"E")=$G(^TMP($J,"HLMAP","D",TIME,"E"))+1
 .  S ^TMP($J,"HLMAP","D",TIME,"E",MONM)=$G(^TMP($J,"HLMAP","D",TIME,"E",MONM))+1
 .  S ^TMP($J,"HLMAP","D",TIME,"E",MONM,IENMST,IENM)=""
 .  S MONM=$P(MONM,"[") QUIT:MONM']""  ;->
 .  S ^TMP($J,"HLMAP","E",+MONIEN,+TIME\1,+IENM)=MONM
 Q
 ;
MAPBUILD ; Make lines for browsing report
 N EVNM,GBL,HOUR
 S GBL=$NA(^TMP($J,"HLMAP","D"))
 S HOUR=""
 F  S HOUR=$O(@GBL@(HOUR)) Q:HOUR']""  D
 .  I $O(@GBL@(HOUR,"M",0))>0 D MAPHOUR("MASTER JOB",HOUR)
 .  S EVNM=""
 .  F  S EVNM=$O(@GBL@(HOUR,"E",EVNM)) Q:EVNM']""  D
 .  .  D MAPHOUR(EVNM,HOUR)
 Q
 ;
MAPHOUR(EVNM,HOUR) ; Store in display global...
 S ^TMP($J,"HLMAP","M",EVNM,+$P(HOUR,"."),+$P(HOUR,".",2))=""
 Q
 ;
MAPSCRN ; Build screen for days...
 N DATA,DAY,EVNM,HOUR,HR,TXT,X
 ;
 S EVNM=""
 F  S EVNM=$O(^TMP($J,"HLMAP","M",EVNM)) Q:EVNM']""  D
 .  S DAY=0
 .  F  S DAY=$O(^TMP($J,"HLMAP","M",EVNM,DAY)) Q:DAY'>0  D
 .  .  S TXT=$$EVNM(EVNM,31)
 .  .  F HOUR=1:1:24 D
 .  .  .  S DATA=$S($D(^TMP($J,"HLMAP","M",EVNM,DAY,HOUR_0)):1,1:0)
 .  .  .  S TXT=TXT_$S(DATA:"-X",1:"--")
 .  .  S ^TMP($J,"HLMAP","X",DAY,EVNM)=TXT
 ;
 S DAY=0
 F  S DAY=$O(^TMP($J,"HLMAP","X",DAY)) Q:DAY'>0  D
 .  D ADDHDR(DAY)
 .  I $D(^TMP($J,"HLMAP","X",DAY,"MASTER JOB")) D
 .  .  D ADDLINE(DAY,^TMP($J,"HLMAP","X",DAY,"MASTER JOB"))
 .  S EVNM=""
 .  F  S EVNM=$O(^TMP($J,"HLMAP","X",DAY,EVNM)) Q:EVNM']""  D
 .  .  QUIT:EVNM="MASTER JOB"  ;->
 .  .  D ADDLINE(DAY,^TMP($J,"HLMAP","X",DAY,EVNM))
 ;
 Q
 ;
ADDHDR(DAY) ; Add HDR code...
 D ADDLINE(DAY,$$CJ^XLFSTR(" "_$$FMTE^XLFDT(DAY)_" ",IOM,"="))
 D ADDLINE(DAY,"                   |"_IOINHI_"  Hours "_IOINORM_"| - 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2")
 D ADDLINE(DAY,"Monitor            |"_IOINHI_" in Day "_IOINORM_"| - 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4")
 D ADDLINE(DAY,$$REPEAT^XLFSTR("=",IOM))
 Q
 ;
ADDLINE(DAY,TXT) ; Add one line of text to screen ^TMP global
 N NO
 S ^TMP($J,"HLMAP","S","D",DAY)=$G(^TMP($J,"HLMAP","S","D",DAY))+1
 S NO=$O(^TMP($J,"HLMAP","S","D",DAY,":"),-1)+1
 I '(NO#24) D  ; Mid-screen extra header
 .  S ^TMP($J,"HLMAP","S","D",DAY,NO)=$$REPEAT^XLFSTR("-",IOM)
 .  S NO=NO+1,^TMP($J,"HLMAP","S","D",DAY,NO)="                        Hours - 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2"
 .  S NO=NO+1,^TMP($J,"HLMAP","S","D",DAY,NO)="Monitor                in Day - 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4"
 .  S NO=NO+1,^TMP($J,"HLMAP","S","D",DAY,NO)=$$REPEAT^XLFSTR("-",IOM)
 .  S NO=NO+1
 S ^TMP($J,"HLMAP","S","D",DAY,+NO)=TXT
 Q
 ;
EVNM(EVNM,LEN) ; Convert event name[ien] to LENgth, truncating name part prn
 N IEN,NM,X
 I EVNM="MASTER JOB" QUIT $$REPEAT^XLFSTR("-",LEN-$L("MASTER JOB")-1)_"MASTER JOB-" ;->
 S NM=$P(EVNM,"["),IEN="["_$P(EVNM,"[",2,99)
 S NM(1)=$E(NM,1,LEN-$L(IEN))
 I NM'=NM(1) S NM(1)=$E(NM(1),1,$L(NM(1))-1)_"~"
 S NM=NM(1)_IEN
 S NM=$E(NM_$$REPEAT^XLFSTR("-",LEN),1,LEN)
 Q NM
 ;
ROUNDHR(FM) ;
 N HR
 S FM=$G(FM)
 I FM'?7N&(FM'?7N1"."1.N) QUIT "" ;->
 S:FM?7N FM=FM_"." S FM=$E(FM_"00",1,10)
 S HR=+$P(FM,".",2)+1 S:HR<10 HR=0_HR
 S FM=FM\1_"."_HR_0
 Q FM
 ;
EOR ;HLEVREP1 - Event Monitor REPORTS ;5/16/03 14:42
