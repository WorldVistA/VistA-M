GMRCP5 ;SLC/DCM,RJS - Print Consult form 513 (main entry) ;5/14/98  11:09
 ;;3.0;CONSULT/REQUEST TRACKING;**4,13,12**;Dec 27, 1997
 ;
TIUEN(GMRCIEN) ;Entry point for TIU to print 513
 ;
 N GMRCPLEN,GMRCTASK,GMRCX
 ;
 F GMRCX="OUTPUT","SF513" K ^TMP("GMRC",$J,GMRCX)
 F GMRCX="GMRCTIU","RES" K ^TMP("GMRCR",$J,GMRCX)
 ;
 Q:'+GMRCIEN  D PRNT^GMRCP5A(GMRCIEN,1,0,"",0)
 ;
 Q
 ;
GUI(ROOT,GMRCIFN) ;Entry point into routine for the GUI
 ;
 ; GMRCIFN = IFN of the record from file 123.
 ;
 N GMRCCPY,GMRCPLEN,GMRCX
 ;
 S GMRCPLEN=99998
 S GMRCCPY="W"
 F GMRCX="OUTPUT","SF513" K ^TMP("GMRC",$J,GMRCX)
 F GMRCX="GMRCTIU","RES" K ^TMP("GMRCR",$J,GMRCX)
 ;
 D PRNT^GMRCP5A(GMRCIFN,0,0,GMRCCPY,GMRCPLEN)
 ;
 S ROOT=$NA(^TMP("GMRC",$J,"SF513"))
 ;
 Q
 ;
EN(GMRCIFN,GMRCCPY,GMRCDEV,GMRCSTAT) ;Entry point into routine -GMRCIFN=IFN from file 123
 ;GMRCIFN = IFN of the record from file 123.
 ;
 N GMRCPLEN,GMRCTASK
 ;
 S GMRCSTAT=0
 F GMRCX="OUTPUT","SF513" K ^TMP("GMRC",$J,GMRCX)
 F GMRCX="GMRCTIU","RES" K ^TMP("GMRCR",$J,GMRCX)
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 ;
 I $D(GMRCDEV) D  Q
 .S GMRCTASK=$$QUEUE(GMRCIFN,GMRCCPY,GMRCDEV)
 .I GMRCTASK S GMRCSTAT="0^Queued as task # "_GMRCTASK
 .E  S GMRCSTAT="-1^Not Queued"
 ;
 I '$D(GMRCCPY) S GMRCCPY=$$CCOPY Q:(GMRCCPY=U)
 Q:'$$DEVICE
 ;
 I $D(IO("Q")) D  Q
 .S GMRCTASK=$$QUEUE(GMRCIFN,GMRCCPY)
 .I GMRCTASK S GMRCSTAT="0^Queued as task # "_GMRCTASK
 .E  S GMRCSTAT="-1^Not Queued"
 .W "  ",$P(GMRCSTAT,U,2) H 2
 ;
 D PRNT^GMRCP5A(GMRCIFN,0,0,GMRCCPY,0)
 ;
 Q
 ;
SEL ;Select the consult/request to print
 K GMRCQUT,DTOUT,DIRUOUT,GMRCSEL
 I '$D(^TMP("GMRCR",$J,"CS","AD")) W $C(7),!,"No Orders To Print!",! S GMRCQUT=1 Q
 I $D(GMRC("NMBR")) S GMRCSEL=GMRC("NMBR") I $S(GMRCSEL<1:1,GMRCSEL>BLK:1,1:0) K GMRCSEL D AGAIN^GMRCSLMV(GMRC("NMBR"))
 I '$O(^TMP("GMRCR",$J,"CS","AD")),BLK=1 S GMRCSEL=BLK
 I $S('$D(GMRCSEL):1,'$L(GMRCSEL):1,1:0) D SEL^GMRCA2 I $D(DTOUT)!($D(DIRUOUT)) S GMRCQUT=1 Q
 I $S(GMRCSEL<1:1,GMRCSEL>BLK:1,GMRCSEL="":1,1:0) W $C(7),!,"Select A Number In The Range 1 To "_BLK G SEL
 I GMRCSEL="" S GMRCQUT=1 Q
 S GMRCND=$O(^TMP("GMRCR",$J,"CS","AD",GMRCSEL,GMRCSEL,0))
 I $S('$L(GMRCND):1,1:0) S GMRCMSG="The Consult to print is not defined in the list to select from!" D EXAC^GMRCADC(GMRCMSG) S GMRCQUT=1 Q
 Q
 ;
QUEUE(GMRCIFN,GMRCCPY,GMRCDEV) ;
 ;
 N ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTPAR,ZTPRE,ZTPRI,ZTRTN
 N ZTSAVE,ZTSK,ZTUCI
 ;
 S ZTDESC="CONSULT/REQUEST PACKAGE PRINT FORM 513"
 ;
 I $D(GMRCDEV) S ZTIO=GMRCDEV
 E  S ZTIO=ION
 ;
 S ZTDTH=$H
 S ZTRTN="PRNT^GMRCP5A("_(+GMRCIFN)_",0,1,"""_(GMRCCPY)_""",0)"
 D ^%ZTLOAD
 D:'$D(GMRCDEV) ^%ZISC
 ;
 Q $G(ZTSK)
 ;
CCOPY() ; Determine if this is a "Chart" copy or a "Working" copy
 ;
 N GMRCSTAT,GMRCX,GMRCDEF
 ;
 ;  GMRCDEF=1   CHART
 ;  GMRCDEF=0   WORKING
 ;
 S GMRCSTAT=$G(^GMR(123,GMRCIFN,0)) Q:'$L(GMRCSTAT) ""
 S GMRCSTAT=$P(GMRCSTAT,U,12)
 S GMRCDEF=(GMRCSTAT=2)
 ;
 F  D  Q:$L(GMRCX)
 .;
 .W !,$$COPY(GMRCDEF)_" Copy (Y/N)? Y//"
 .R GMRCX:DTIME E  S GMRCX=U
 .Q:(GMRCX[U)
 .;
 .S:'$L(GMRCX) GMRCX="Y"
 .S GMRCX=$E(GMRCX,1)
 .S GMRCX=$TR(GMRCX,"ynwc","YNWC")
 .;
 .I '("YNWC"[GMRCX) S GMRCX="?"
 .;
 .I GMRCX["?" D  S GMRCX="" Q
 ..W !
 ..W !,"    Type 'Y' To Print A '"_$$COPY(GMRCDEF)_"' Copy Of The Form 513,"
 ..W !," or Type 'N' To Print A '"_$$COPY('GMRCDEF)_"' Copy Of The Form 513,"
 ..W !," or Type 'C' To Print A 'Chart' Copy Of The Form 513,"
 ..W !," or Type 'W' To Print A 'Working' Copy Of The Form 513."
 ..W !
 ;
 I (GMRCX="Y") Q $E($$COPY(GMRCDEF),1)
 I (GMRCX="N") Q $E($$COPY('GMRCDEF),1)
 Q GMRCX
 ;
COPY(X) Q:X "Chart" Q "Working"
 ;
DEVICE() ;Ask output device / set up output device print parameters
 N POP,%ZIS,%IS
 S POP=0,%ZIS="MQ" D ^%ZIS
 Q $S(POP:0,IO="":0,1:1)
 ;
 ;
SETUP ;
 ;
 N LINE,%ZIS,%IS,POP,IOP
 ;
 W !!,"Print consults printer setup page.",!
 K IOP S %ZIS="MQ" D ^%ZIS Q:POP
 ;
 I $D(IO("Q")) D  Q
 .;
 .N ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTPAR,ZTPRE,ZTPRI,ZTRTN
 .N ZTSAVE,ZTSK,ZTUCI
 .;
 .S ZTDESC="CONSULT/REQUEST PACKAGE PRINTER TEST PAGE"
 .S ZTIO=ION,ZTDTH=$H,ZTRTN="SETPRNT^GMRCP5"
 .S ZTSAVE("DUZ")=""
 .;
 .D ^%ZTLOAD,^%ZISC
 .;
 .I ZTSK W !!,"Queued as task #",ZTSK
 .E  W !!,"  not queued."
 ;
SETPRNT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 N LINE
 U IO D
 .W @IOF,1
 .W !,2
 .W !,3,"           *******CONSULTS PRINT SETUP PAGE*******"
 .W !,4
 .W !,5,?4,$$REPEAT^XLFSTR("*",70)
 .W !,6,?4," Printed by: ",$$GET1^DIQ(200,+$G(DUZ),.01)," on "
 .W $$FMTE^XLFDT($$NOW^XLFDT)
 .W !,7,?4,$$REPEAT^XLFSTR("*",70)
 .W !,8
 .W !,9,"     Print Device: ",$G(ION)
 .W !,10,"    Terminal Type: ",$G(IOST)
 .W !,11,"    Defined lines per page for this device: ",+$G(IOSL)
 .W !,12,"    Defined margin width for this device: ",+$G(IOM)
 .W !,13
 .W !,14," There should be numbers listed down the lefthand side of"
 .W !,15," this page all the way to the bottom. The number at the"
 .W !,16," bottom of the page is the number of lines the PRINTER"
 .W !,17," thinks there are on a page. The COMPUTER thinks there are ",+$G(IOSL)
 .W !,18," lines on a page. The number at the bottom of the page needs to"
 .W !,19," be EQUAL to ",+$G(IOSL)," so the consults program can print"
 .W !,20," without running off the end of the page. If the number at the"
 .W !,21," bottom of the page is NOT EQUAL to ",+$G(IOSL)," then have"
 .W !,22," someone in IRM adjust the"
 .W !,23
 .W !,24," DEVICE file (file 3.5) *PAGE LENGTH field (#11)"
 .W !,25,"           for device: ",$G(ION)
 .W !,26
 .W !,27," and the TERMINAL TYPE file (file 3.2) PAGE LENGTH field (#3)"
 .W !,28,"    for terminal type: ",$G(IOST)
 .W !,29
 .W !,30," to be a value EQUAL to the number at the bottom of the page."
 .F LINE=31:1:100 W !,LINE
 U IO(0) D ^%ZISC
 ;
 I $G(ZTSK) D KILL^%ZTLOAD
 ;
 Q
