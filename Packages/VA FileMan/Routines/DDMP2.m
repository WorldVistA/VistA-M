DDMP2 ;SFISC/DPC-Import Device, Queuing, Reports ;11/5/97  08:10
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
DEV(DDMPIOIN,DDMPIOP) ;
 ;Device selection for printed report.
 ;DDMPIOIN might contain preselected info.
 ;DDMPIOP will contain device data for later use with ^%ZIS.
 I $D(DDMPIOIN("IOP")) D
 . I $P(DDMPIOIN("IOP"),";")'="Q" S DDMPIOP=DDMPIOIN("IOP")
 . E  D
 . . S DDMPIOP=$P(DDMPIOIN("IOP"),";",2,99),DDMPIOP("Q")=1
 . . I $D(DDMPIOIN("QTIME")) D SETQTIME
 E  D
 . N %ZIS,POP
 . S %ZIS="QN"
 . S %ZIS("A")="Device for Import Results Report: "
 . D ^%ZIS
 . I POP S DDMPIOP("NG")=1 Q
 . I $E(IOST,1,2)="C-" S DDMPIOP("HOME")=1 Q
 . D SETIOP
 . I $G(IO("Q")) S DDMPIOP("Q")=1 Q
 . D HOME^%ZIS
 . I $P(DDMPIOP,";",2)="P-BROWSER" Q
 . N DIR,DIRUT,Y
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to queue this data import"
 . D ^DIR
 . I $G(DIRUT) S DDMPIOP("NG")=1 Q
 . I Y S DDMPIOP("Q")=1
 Q
 ;
SETIOP ;
 ;Sets up IOP, etc., from variables returned by ^%ZIS.
 S DDMPIOP=ION
 I $G(IOST)]"" S DDMPIOP=DDMPIOP_";"_IOST
 I $G(IO("DOC"))]"" S DDMPIOP=DDMPIOP_";"_IO("DOC") Q
 I $G(IOM) S DDMPIOP=DDMPIOP_";"_IOM
 I $G(IOSL) S DDMPIOP=DDMPIOP_";"_IOSL
 I $G(IOT)="HFS" S DDMPIOP("HFSNAME")=IO,DDMPIOP("HFSMODE")="W"
 Q
 ;
SETQTIME ;
 ;Sets time for queuing from value passed in ("QTIME")
 N X,Y,%DT
 S X=DDMPIOIN("QTIME")
 I X="NOW" S DDMPIOP("QTIME")=$H
 E  D
 . I X'["@" S X="T@"_X
 . S %DT="XT",%DT(0)="NOW"
 . D ^%DT
 . I Y<0 S DDMPIOP("NG")=1 Q
 . S DDMPIOP("QTIME")=Y
 Q
 ;
QUE(DDMPIOP) ;
 ;Queues the import.
 S ZTRTN="TASK^DDMP"
 S ZTIO=""
 S ZTDESC="Queued data import."
 I $D(DDMPIOP("QTIME")) S ZTDTH=DDMPIOP("QTIME")
 S ZTSAVE("^TMP($J,""DDMP"",")=""
 S ZTSAVE("DDMPIOP(")=""
 S ZTSAVE("DDMPIOP")=""
 S ZTSAVE("DDMPF")=""
 S ZTSAVE("DDMPSQ(")=""
 S ZTSAVE("DDMPFMT(")=""
 S ZTSAVE("DDMPFLG")=""
 S ZTSAVE("DDMPFLG(")=""
 S ZTSAVE("DDMPNCNT")=""
 S ZTSAVE("DDMPFSRC(")=""
 D ^%ZTLOAD
 I $G(ZTSK) D
 . W !,"Import queued.  Task number: "_ZTSK
 E  W !,"Queuing of import failed.  Import aborted."
 Q
 ;
REP1(DDMPRPSB,DDMPLN) ;
 N DDMPI,DDMPTXT,DDMPUSR,DDMPFNO,DDMPLEN
 S DDMPLN=0
 I '$D(^XTMP("DDMP1000")) S DDMPRPSB="DDMP1000"
 E  S DDMPRPSB="DDMP"_($P($O(^XTMP("DDMPz"),-1),"DDMP",2)+1)
 S ^XTMP(DDMPRPSB,0)=DT_U_DT_U
 S DDMPUSR=$$GET1^DIQ(200,DUZ_",",.01)
 S ^(0)=^XTMP(DDMPRPSB,0)_"Import report: "_DDMPUSR
 D LDXTMP($P($T(LN1+1),";;",2)_$P(DDMPUSR,",",2)_" "_$P(DDMPUSR,","))
 D LDXTMP("")
 D LDXTMP($P($T(LN1+2),";;",2)_DDMPFSRC("PATH")_DDMPFSRC("FILE"))
 D LDXTMP($P($T(LN1+3),";;",2)_DDMPFMT("FIXED"))
 D LDXTMP($P($T(LN1+4),";;",2)_DDMPFMT("FDELIM"))
 D LDXTMP($P($T(LN1+5),";;",2)_DDMPFMT("QUOTED"))
 D LDXTMP($P($T(LN1+6),";;",2)_$S(DDMPFLG["E":"External",1:"Internal"))
 D LDXTMP("")
 D LDXTMP($P($T(LN1+7),";;",2)_$$GET1^DID(DDMPF,"","","NAME"))
 D LDXTMP("")
 D LDXTMP($P($T(LN1+8),";;",2))
 D LDXTMP($P($T(LN1+9),";;",2))
 F DDMPI=1:1 Q:'$D(DDMPSQ(DDMPI))  D
 . S DDMPFNO=$P(DDMPSQ(DDMPI),"~"),DDMPLEN=$P(DDMPSQ(DDMPI),"~",4)
 . S DDMPTXT=DDMPI_$J("",5-$L(DDMPI))_$S(DDMPLEN:DDMPLEN,1:"n/a")
 . S DDMPTXT=DDMPTXT_$J("",10-$L(DDMPTXT))_$$GET1^DID(DDMPFNO,$P(DDMPSQ(DDMPI),"~",3),"","LABEL")
 . I DDMPF'=DDMPFNO S DDMPTXT=DDMPTXT_$J("",43-$L(DDMPTXT))_$O(^DD(DDMPFNO,0,"NM",""))
 . D LDXTMP(DDMPTXT)
 D LDXTMP("")
 D LDXTMP("")
 D LDXTMP($P($T(LN1+10),";;",2))
 D LDXTMP($P($T(LN1+11),";;",2))
 D LDXTMP("")
 Q
 ;
LDXTMP(DDMPTXT) ;
 S DDMPLN=DDMPLN+1
 S ^XTMP(DDMPRPSB,DDMPLN)=DDMPTXT
 Q
 ;
LN1 ;
 ;;                     Import Initiated By: 
 ;;                             Source File: 
 ;;                            Fixed Length: 
 ;;                            Delimited By: 
 ;;                      Text Values Quoted: 
 ;;                              Values Are: 
 ;;        Primary FileMan Destination File: 
 ;;Seq  Len  Field Name                      Subfile Name (if applicable)
 ;;---  ---  ----------                      ----------------------------
 ;;                                  Error Report
 ;;                                  ------------
 ;
REP2(DDMPRPSB,DDMPLN,DDMPSTAT) ;
 N POP
 I '$G(DDMPSTAT("NG")) D LDXTMP($P($T(LN2+1),";;",2))
 D LDXTMP("")
 D LDXTMP("")
 D LDXTMP($P($T(LN2+2),";;",2))
 D LDXTMP($P($T(LN2+3),";;",2))
 D LDXTMP("")
 I $G(DDMPSTAT("ABORT")) D
 . D LDXTMP($P($T(LN2+4),";;",2))
 . D LDXTMP($P($T(LN2+(4+DDMPSTAT("ABORT"))),";;",2))
 . D LDXTMP("")
 D LDXTMP($P($T(LN2+7),";;",2)_DDMPSTAT("TOT"))
 D LDXTMP($P($T(LN2+8),";;",2)_(DDMPSTAT("TOT")-DDMPSTAT("NG")))
 D LDXTMP($P($T(LN2+9),";;",2)_DDMPSTAT("NG"))
 D LDXTMP("")
 D LDXTMP($P($T(LN2+10),";;",2)_$G(DDMPSTAT("FIEN"),"Nothing filed"))
 D LDXTMP($P($T(LN2+11),";;",2)_$G(DDMPSTAT("LIEN"),"Nothing filed"))
 D LDXTMP("")
 D LDXTMP($P($T(LN2+12),";;",2)_$$HTE^DILIBF(DDMPSTAT("BEG")))
 S DDMPSTAT("END")=$H
 D LDXTMP($P($T(LN2+13),";;",2)_$$HTE^DILIBF(DDMPSTAT("END")))
 D LDXTMP($P($T(LN2+14),";;",2)_$$HDIFF^DILIBF(DDMPSTAT("END"),DDMPSTAT("BEG"),3))
 I $G(DDMPIOP("HOME")) W @IOF D PRNTHM Q
 I $P($G(DDMPIOP),";",2)="P-BROWSER" D BROWSET Q:POP  D PRNTHM Q
 ;Set up queued job for report printing.
 N %ZIS
 S %ZIS="Q"
 S IOP="Q;"_DDMPIOP
 I $D(DDMPIOP("HFSNAME")) S %ZIS("HFSNAME")=DDMPIOP("HFSNAME")
 I $D(DDMPIOP("HFSNODE")) S %ZIS("HFSMODE")=DDMPIOP("HFSMODE")
 D ^%ZIS
 I POP Q  ;ERROR THAT REPORT CANNOT PRINT
 K ZTIO
 S ZTRTN="PRNT^DDMP2"
 S ZTSAVE("DDMPRPSB")=""
 S ZTDTH=$H
 S ZTDESC="Printing of Import Log for User# "_DUZ
 D ^%ZTLOAD
 I '$D(ZTQUEUED) W !,"Task Number for printing: "_ZTSK
 Q
PRNT ;
 ;Tasked print of report.
 S ZTREQ="@"
 U IO
PRNTHM ;Print to home device.  Tasked prints fall through.
 N DDMPCNT,DDMPPG,DDMPIOSL,DDMPOUT
 S DDMPIOSL=$G(IOSL,60)
 S DDMPPG=0,DDMPCNT=0
 D HDR
 F  S DDMPCNT=$O(^XTMP(DDMPRPSB,DDMPCNT)) Q:DDMPCNT=""  D  Q:$G(DDMPOUT)
 . W !,^XTMP(DDMPRPSB,DDMPCNT)
 . I $Y+3>DDMPIOSL D HDR
 I $E(IOST,1,2)'="C-" W @IOF D ^%ZISC
 Q
 ;
BROWSET ;
 N %ZIS
 S IOP=DDMPIOP
 D ^%ZIS
 U IO
 Q
 ;
HDR ;
 I DDMPPG,$E(IOST,1,2)="C-" N DIR,Y S DIR(0)="E" D ^DIR I 'Y S DDMPOUT=1 Q
 I DDMPPG W @IOF
 S DDMPPG=DDMPPG+1
 W $P($T(HDR1+1),";;",2)_DDMPPG
 W !,$P($T(HDR1+2),";;",2)
 W !
 Q
 ;
HDR1 ;
 ;;                         Log for VA FileMan Data Import              Page 
 ;;                         ==============================
LN2 ;
 ;;                   No errors occured during this data import.
 ;;                               Summary of Import
 ;;                               -----------------
 ;;                           <<<IMPORT NOT COMPLETED:
 ;;                              MAXIMUM ERRORS DETECTED>>>
 ;;                              USER ABORT OF TASKED IMPORT>>>
 ;;                     Total Records Read: 
 ;;                    Total Records Filed: 
 ;;                 Total Records Rejected: 
 ;;              IEN of First Record Filed: 
 ;;               IEN of Last Record Filed: 
 ;;                  Import Filing Started: 
 ;;                Import Filing Completed: 
 ;;                  Time of Import Filing:
