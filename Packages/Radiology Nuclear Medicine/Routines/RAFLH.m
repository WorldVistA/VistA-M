RAFLH ;HISC/FPT AISC/MJK-Print Radiology Flash Cards ;12/4/97  12:25
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
1 Q:'$D(^RADPT(RADFN,0))  S RAY1=^(0) Q:'$D(^DPT(RADFN,0))  S RAY0=^(0)
 Q:'$D(^RADPT(RADFN,"DT",RADTI,0))  S RAY2=^(0)
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I RAFLHFL S RACNI=RAFLHFL Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))  S RAY3=^(0),X=$S($D(^RAMIS(71,+$P(RAY3,"^",2),0)):^(0),1:"") D RAFMT,PRT G EXIT
 ; pce 2 of RAFLHFL, is set only if 'Add Exams to Last Visit',
 ; so that loop is done only thru newly added exams
 F RACNI=+$P(RAFLHFL,";",2):0 S RAFMT=RAFLH,RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0!($D(RANUMF))  I $D(^(RACNI,0)) S RAY3=^(0),X=$S($D(^RAMIS(71,+$P(RAY3,"^",2),0)):^(0),1:"") D RAFMT D CASE
EXIT D ^RAFLH1,Q^RAFLH1 Q
CASE K RAX S RAFL=$S($P(X,"^",3)="":1,'$D(^%ZIS(1,+$P(X,"^",3),0)):1,1:0) Q:'RAFL
 ; if $D(RADIF) and using img loc's 'how many flash cards each visit',
 ; then RAVISIT1 is ignored, which may result in extra flash cards
 I RAFLHFL["ALL"!($D(RADIF)) D PRT Q
 ; RAVISIT1 defined if img loc param specifies exactly how many
 ; flash cards should print per visit (and div param is 'no') .
 ; When exactly that many cards have been printed, RANUMF is defined.
 D PRT S:$D(RAVISIT1) RANUMF=1
 Q
 ;
RAFMT K RADIF S RAFMT=$S($P(X,"^",4):$P(X,"^",4),1:RAFLH) S:RAFMT'=RAFLH RADIF="" Q
 ;
PRT I '$D(^RA(78.2,RAFMT,0)) W @$S($G(RAFFLF)]"":RAFFLF,1:IOF) Q
 N RACNT,RAIND1,RAIND2 D PSET^%ZISP
 N RAMEMLOW,RAPRTSET,RAEXSPEC,RAVAL
 D EN1^RAUTL20
 ; RAEXSPEC = array to store print fld that's exam specific
 I '$D(RATEST) F RAI=0:0 S RAI=$O(^RA(78.2,RAFMT,1,RAI)) Q:RAI'>0  I $D(^(RAI,0)),$D(^RA(78.7,+^(0),"E")) X ^("E") I $P(^RA(78.7,+^RA(78.2,RAFMT,1,RAI,0),0),"^",6)="Y",$P(^(0),"^",5)]"" S RAEXSPEC($P(^(0),"^",5))=1
 F RAII=1:1:RANUM D
 . F RAI=0:0 S RAI=$O(^RA(78.2,RAFMT,"E",RAI)) Q:RAI'>0  D
 .. I $G(^RA(78.2,RAFMT,"E",RAI,0))'["@" D
 ... X ^RA(78.2,RAFMT,"E",RAI,0)
 ... S RAVAL=$P(^RA(78.2,RAFMT,"E",RAI,0),",RA",2) S:RAVAL]"" RAVAL="RA"_RAVAL
 ... I RAVAL]"",@RAVAL]"",$G(RAEXSPEC(RAVAL)),RAPRTSET W "+"
 ... Q
 .. E  D XECFLH^RAFLH2(RAFMT,RAI)
 .. Q
 . I $G(RAFMT)=$G(RAHDFM) Q
 . W @$S($G(RAFFLF)]"":RAFFLF,1:IOF)
 . Q
 D PKILL^%ZISP K RAI,RAII
 Q
 ;
FLH ; Flash card entry point.
 N RAPRNT S RAPRNT=$$PRINT^RAFLH2(RAMDIV,RAMLC,.RAPX) Q:'RAPRNT
 ; from orig. devlprs -- if NO default flashcard format, set RAFLH to 1
 S (RAEXFM,RAEXLBLS)=0,RANUM=1,RAFLH=$S($P(RAMLC,"^",7):$P(RAMLC,"^",7),1:1)
 K RAFLHCNT
 F I=0:0 S I=$O(RAPX(I)) Q:I'>0  S RAFLHCNT(I)=""
 ; Print a flash card for each proc whose 'Required Flash Card Printer'
 ; field contains a valid printer regardless of other loc and div params
 ; For each card printed, its corresponding RAFLHCNT(I) is deleted.
 ; Any RAFLHCNT() left would mean continuing on to paragragh 1
 F I=0:0 S I=$O(RAPX(I)) Q:I'>0  I $P(RAPX(I),"^",4)]"",$D(^%ZIS(1,+$P(RAPX(I),"^",4),0)) S ION=$P(^(0),"^"),IOP=$S(ION]"":"Q;"_ION,1:"Q"),RAFLHFL=I D  D Q
 .S RAMES="W !!?3,""NOTE: Case No. "",$P(RAPX(I),""^""),"" ("",$E($P(RAPX(I),""^"",2),1,20),"") has been queued to printer "",ION,""."",!"
 .S RAMESCNT=$G(RAMESCNT)+1
 .K RAFLHCNT(I)
 S RAMES="W !?5,""...all needed flash cards and exam labels queued to print on "",ION,""."",!"
 ; known problem inheritied :
 ; when all flash cards have been printed because all the procedures
 ; had REQUIRED FLASH CARD PRINTER defined, then the following msg
 ; should not print, but as inherited, it does
 S:$D(RAMESCNT) RAMES="W !?5,""...all remaining flash cards and exam labels queued to print on "",ION,""."",!"
 K RAMESCNT S ION=$P(RAMLC,"^",3),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 I IOP="Q" S RASELDEV="Select the FLASH CARD/EXAM LABEL Printer"
 ; RAVSTFLG is from 'Add Exams to Last Visit'
 S RAFLHFL=$S($P(RAMDV,"^",2):"ALL",1:"") S:$D(RAVSTFLG) RAFLHFL=RAFLHFL_";"_($O(RAPX(0))-1)
 S RANUM=$S($P(RAMDV,"^",2):1,1:$P(RAMLC,"^",2))
 ; no. flash cards to print :
 ; if from RAMDV = 1 card only for each exam (procedure)
 ; if from RAMLC = n cards for the first procedure
 S RAEXLBLS=+$P(RAMLC,"^",8)
 ; from orig. devlprs -- if NO default flashcard format, set RAEXFM to 1
 S RAEXFM=$S($P(RAMLC,"^",9):$P(RAMLC,"^",9),1:1)
 K RAVISIT1 I '$P(RAMDV,U,2),$P(RAMLC,U,2) S RAVISIT1=1
 ; RAVISIT1 = 1 if paragraph 1's For-loop should be done once only
 I $D(RASELDEV),RANUM=0,RAEXLBLS=0 K IOP,RAMES,RASELDEV Q
 ; known problem inherited :
 ; in the next line, this early quit would mean not printing full amt of
 ; flash cards, if HOW MANY FLASH CARDS PER VISIT > # procs already prt'd
 I '$D(RAFLHCNT),$D(RASELDEV),RAEXLBLS=0 K IOP,RAMES,RASELDEV Q
 I $D(RASELDEV),$D(RAFLHCNT),RAEXLBLS=0 S RASELDEV="Select the FLASH CARD Printer"
 I '$D(RAFLHCNT),$D(RASELDEV),RAEXLBLS>0 S RASELDEV="Select the EXAM LABEL Printer"
 I $D(RAFLHCNT),$D(RASELDEV),RANUM=0,RAEXLBLS>0 S RASELDEV="Select the EXAM LABEL Printer"
 ;
Q S ZTDTH=$H,ZTRTN="DQ^RAFLH" F RASV="RADFN","RADTI","RAFLHFL","RAFLH","RANUM","RAEXLBLS","RAEXFM" S ZTSAVE(RASV)=""
 S:$D(RAVISIT1) ZTSAVE("RAVISIT1")=""
 W ! D ZIS^RAUTL Q:RAPOP
DQ U IO S U="^" S X="T",%DT="" D ^%DT S DT=Y G RAFLH
 ;
 ; If there is a flash card printer associated with the procedure, then
 ; one flash card will print out at that printer regardless of any
 ; division or location parameters concerning flash cards.
 ;
 ; If there is no flash card printer associated with the procedure and
 ; the division parameter is set to YES, then one flash card will print
 ; out at the flash card printer specified in the location parameter.
 ; If there is no printer specified in the location parameter, then
 ; the user will be prompted for a device.
 ;
 ; If there is no flash card printer associated with the procedure and
 ; the division parameter is set to NO, then the number of flash cards
 ; printed out will equal the value in the location parameter field,
 ; HOW MANY FLASH CARDS PER VISIT. The flash cards will print out at the
 ; flash card printer specified in the location parameter. If there is
 ; no printer specified in the location parameter, then the user will be
 ; prompted for a device.
 ;
