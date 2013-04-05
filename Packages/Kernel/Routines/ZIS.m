%ZIS ;SFISC/AC,RWF -- DEVICE HANDLER ;05/22/12  12:31
 ;;8.0;KERNEL;**18,23,69,112,199,191,275,363,440,499,524,546,599**;JUL 10, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified
 ; ZEXCEPT: %IS,%ZIS,%ZISVT,DTIME,ION,IOP,IOT,POP,ZTIO,ZTQUEUED
 N %ZISOS,%ZISV
 S U="^",%ZISOS=$G(^%ZOSF("OS")),%ZISV=$G(^%ZOSF("VOL")),POP=0 ;p524
 ;Check SPOOLER special case first
INIT ;
 I $G(ZTQUEUED),$G(IOT)="SPL",$D(IOP),$L($G(IO)),IO=$G(IO(0)),$D(IO(1,IO))#2,(IOP[$G(ION)!(IOP[IO)) K %ZIS,%IS,IOP Q  ;p524
 ;p524 Line above for HD141181.
 I '$D(%ZIS),$D(%IS) M %ZIS=%IS
 S:'($D(%ZIS)#2) %ZIS="M" M %IS=%ZIS ;update %IS for now
 I '$D(^XUTL("XQ",$J,"MIXED OS")) S ^XUTL("XQ",$J,"MIXED OS")=$$PRI^%ZOSV
 S %ZIS("PRI")=$G(^XUTL("XQ",$J,"MIXED OS"),1)
 ;
 I $D(ZTQUEUED) D  I '$D(IOP) S POP=1 G EXIT^%ZIS1
 .I $G(ZTIO)="" S:%ZIS'[0 %ZIS=%ZIS_"0",%IS=%ZIS
 I '$D(ZTQUEUED),%ZIS["T",$P($G(IOP),";")="Q" S POP=1 G EXIT^%ZIS1
 N %,%A,%E,%H,%I,%X,%XX,%Y,%Z,%Z1,%Z2,%Z9,%Z90,%Z91,%Z95,%ZISB,%ZTIME,%ZTYPE
 N %ZHFN,%ZISOLD,%ZTOUT,%ZISDTIM,DTOUT,DUOUT
 S %ZISDTIM=$G(DTIME,300)
 ;Save symbols to restore if don't open a device
 D SYMBOL^%ZISUTL(0,$NA(%ZISOLD))
A D CLEAN ;p363
 K IO("P"),IO("Q"),IO("S"),IO("T")
K2 D K2^%ZIS1
 S %ZISB=%ZIS'["N",(%E,%H)=0,%Y="" S:'$D(IO(0)) IO(0)=$I
 I $D(IOP),IOP=$I!(IOP="HOME")!(0[IOP),$D(^XUTL("XQ",$J,"IO")) D HOME K %IS,%Y,%ZIS,%ZISB,%ZISV,IOP Q
 ;Don't worry about HOME if %ZIS[0
 D:%ZIS'[0 GETHOME G EXIT^%ZIS1:POP,^%ZIS1 ;Jump to next part
GETHOME I $D(IO("HOME")),$P(IO("HOME"),"^",2)=IO(0) S (%E,%H)=+IO("HOME") Q
 I $D(^XUTL("XQ",$J,"IOS")),$D(^("IO")),IO(0)=^("IO") S (%E,%H)=^("IOS") Q
 ;CALL LINEPORT CODE HERE---
 S %=$$LINEPORT^%ZISUTL I % S (%E,%H)=% Q
 S %ZISVT=$I D VTLKUP I '%E S %ZISVT=$I D VIRTUAL
 I %ZISVT=""!(%E'>0) I %ZIS'[0 O IO(0)::0 I $T U IO(0) W !,"HOME DEVICE ("_$I_") DOES NOT EXIST IN THE DEVICE FILE",!,"PLEASE CONTACT YOUR SYSTEM MANAGER!",*7
 S %H=%E S:'%H&(%ZIS'[0) POP=1 S:(%H>0)&('$D(IO("HOME"))) IO("HOME")=%H_"^"_$I
 Q
VIRTUAL ;See if a Virtual Terminal (LAT, TELNET)
 ; ZEXCEPT: %ZISI,%ZISVT
 F %ZISI=$L(%ZISVT):-1:1 D:$D(^%ZIS(1,"C",%ZISVT))  Q:$S('%E:0,$G(^%ZIS(1,%E,"TYPE"))="VTRM":1,1:0)  S %ZISVT=$E(%ZISVT,1,%ZISI)
 .D VTLKUP Q  ;Q:$S('%E:0,'$D(^%ZIS(1,%E,"TYPE")):0,^("TYPE")="VTRM":1,1:0)
 Q
VTLKUP ;
 ; ZEXCEPT: %E,%ZISV,%ZISVT,%ZISX
 F %ZISX=%ZISV,"" S %E=+$O(^%ZIS(1,"G","SYS."_%ZISX_"."_%ZISVT,0)) Q:%E
 Q
CURRENT ;Old, Not in current doc's.
 ; ZEXCEPT: %ZISI,%ZISOS,%ZISV,%ZISVT,%ZISX,BS,FF,RM,SL,SUB,XY
 N %ZIS,%IS,%E,%H,%A,%,POP,X
 S FF="#",SL=24,BS="*8",RM=80,(SUB,XY)="",%ZIS=0,%ZISOS=$G(^%ZOSF("OS")),%ZISV=$G(^("VOL")),POP=0
 D GETHOME K %ZISI,%ZISOS,%ZISV,%ZISVT,%ZISX Q:POP
 I $D(^%ZIS(1,%H,"SUBTYPE")) S SUB=+^("SUBTYPE")
 I $D(SUB),SUB,$D(^%ZIS(2,SUB,1)) S SUB=$S($D(^(0)):$P(^(0),"^"),1:""),FF=$P(^(1),"^",2),SL=$P(^(1),"^",3),BS=$P(^(1),"^",4),XY=$P(^(1),"^",5),RM=+^(1)
 E  S SUB=""
 I $D(^%ZOSF("RM")) S X=RM X ^("RM")
 Q
HOME ;Entry point to establish IO* variables for home device.
 ; ZEXCEPT: IOM,IOP
 D CLEAN ;(p363)
 N X I '$D(^XUTL("XQ",$J,"IO")) S IOP="HOME" D ^%ZIS Q
 D RESETVAR
 I $L($G(IO)),$P($G(IO("HOME")),"^",2)=IO,$D(IO(1,IO)) U IO ;p524
 I '$D(IO("C")),$G(IOM),IO=$I,$D(IO(1,IO)),$D(^%ZOSF("RM")) S X=+IOM X ^("RM")
 S X=$$ENDOFILE^%ZISUTL ;p599 Set end-of-file handling for Cache
 Q
 ;IO("Q") is checked by many routines after a call to ^%ZISC, so only clean on call to %ZIS.
CLEAN ;Cleanup env. Called from %ZISC also.
 ; ZEXCEPT: IOPAR,IOT,IOUPAR
 I $G(IOT)'="SPL" K IO("DOC"),IO("SPOOL") ;(p440)
 I $G(IOT)'="HFS" K IO("HFSIO") ;p440
 S (IOPAR,IOUPAR)=""
 Q
RESETVAR ;Reset home IO* variables.
 ; ZEXCEPT: POP
 I '$D(^XUTL("XQ",$J,"IO")) Q
 N %
 F %="IO","IOBS","IOF","IOM","ION","IOS","IOSL","IOST","IOST(0)","IOT","IOXY","IOPAR","IOUPAR" I $D(^XUTL("XQ",$J,%))#2 S @%=^(%)
 F %="IO(""IP"")","IO(""CLNM"")","IO(""DOC"")","IO(""HFSIO"")","IO(""SPOOL"")" I $D(^XUTL("XQ",$J,%))#2 S @%=^(%)
 S POP=0,IO(0)=IO
 Q
SAVEVAR ;Save home IO* variables, called from XUS1,%ZTMS3
 N %
 F %="IO","IOBS","IOF","IOM","ION","IOS","IOSL","IOST","IOST(0)","IOT","IOXY","IOPAR","IOUPAR" I $D(@%) S ^XUTL("XQ",$J,%)=@%
 F %="IO(""IP"")","IO(""CLNM"")","IO(""DOC"")","IO(""HFSIO"")","IO(""SPOOL"")" I $D(@%) S ^XUTL("XQ",$J,%)=@%
 Q
ZISLPC Q  ;No longer called in Kernel v8.
HLP1 G EN1^%ZIS7
HLP2 ;
 ; ZEXCEPT: DTIME
 N %E,%H,%X,%ZISV,X,%ZISDTIM
 S %ZISDTIM=$G(DTIME,60),%ZISV=$S($D(^%ZOSF("VOL")):^("VOL"),1:"") G EN2^%ZIS7
REWIND(IO2,IOT,IOPAR) ;Rewind Device
 N %,X,Y,$ES,$ET S $ET="D REWERR^%ZIS Q 0"
 S %=$I
 I '($D(IO2)#2)!'$D(IOT)!'$D(IOPAR) Q 0
 I "MT^SDP^HFS"'[IOT Q 0
 S @("Y=$$REW"_IOT_"^%ZIS4(IO2,IOPAR)")
 U %
 Q Y
REWERR ;Error encountered
 S IO("ERROR")=$EC
 S $EC="",$ET="Q:$ES>1  S $EC="""" Q 0" S $EC=",U1,"
 Q 0
