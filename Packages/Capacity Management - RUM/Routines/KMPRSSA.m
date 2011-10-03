KMPRSSA ;OAK/RAK - Resource Usage Monitor Status ;11/19/04  10:32
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
FORMAT(KMPRLN) ;-format text for dislay
 ;-----------------------------------------------------------------------------
 ; KMPRLN.... return number of lines - called by reference
 ;-----------------------------------------------------------------------------
 ;
 N CHECK,LN,VERSION S LN=0 K TMP
 ;
 ; check environment
 ;D ENVCHECK^KMPRUTL1(.CHECK,1)
 ; if RUM turned on but background job not queued ask user if they want
 ; to queue it at this time.
 ;D:(+CHECK)=200 ENVCHECK^KMPRUTL1(.CHECK)
 ;
 ; if no kmprutl routine
 S X="KMPRUTL" X ^%ZOSF("TEST") I '$T D  Q
 .D SET^VALM10(LN,"The CAPACITY MANAGEMENT - RUM package is not installed!")
 .S LN=LN+1
 ;
 W !," formatting..."
 W "."
 ; option data
 D OPT
 W "."
 ; bacground data
 D BKGRND
 W "."
 ; file data
 D FILES
 W "."
 ; routine version check
 D ROUCHK("R")
 W "."
 ; node/cpu data
 D CPU
 W "."
 ; legend
 D LEGEND
 ;
 S KMPRLN=LN-1
 ;
 Q
 ;
BKGRND ; hl7 background info
 ;
 N DATA,DELTA,ENDT,I,STAT,STDT,Z
 ;
 D SET^VALM10(LN,"   Temporary collection global..")
 S LN=LN+1
 D SET^VALM10(LN,"   ^KMPTMP(""KMPR"").............. "_$S('$D(^KMPTMP("KMPR")):"NOT ",1:"")_"Present")
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 ;
 D PARAMS^KMPDUT("DATA") Q:'$D(DATA)
 S DATA(2)=$G(DATA(2))
 S STDT=$P(DATA(2),U,5),ENDT=$P(DATA(2),U,6),DELTA=$P(DATA(2),U,7)
 S:$E(DELTA)=" " $E(DELTA)="0"
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"   RUM Dly Bckgrnd Last Start... "_$$FMTE^XLFDT(STDT))
 S LN=LN+1
 D SET^VALM10(LN,"   RUM Dly Bckgrnd Last Stop.... "_$$FMTE^XLFDT(ENDT))
 S LN=LN+1
 D SET^VALM10(LN,"   RUM Dly Bkgrnd Total Time.... "_DELTA)
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 S STDT=$P(DATA(2),U,8),ENDT=$P(DATA(2),U,9),DELTA=$P(DATA(2),U,10)
 S:$E(DELTA)=" " $E(DELTA)="0"
 D SET^VALM10(LN,"   RUM Wkly Backgrnd Last Start. "_$$FMTE^XLFDT(STDT))
 S LN=LN+1
 D SET^VALM10(LN,"   RUM Wkly Bckgrnd Last Stop... "_$$FMTE^XLFDT(ENDT))
 S LN=LN+1
 D SET^VALM10(LN,"   RUM Wkly Bckgrnd Total Time.. "_DELTA)
 S LN=LN+1
 D SET^VALM10(LN,"   RUM Purge Data After......... "_$P(DATA(2),U,11)_" weeks")
 S LN=LN+1
 D TRANSTO^KMPDUTL7(1,2,.Z)
 I '$D(Z) D SET^VALM10(LN,"   RUM Transmit Data to......... <>") S LN=LN+1
 E  D 
 .S I=$O(Z("")) D:I'="" SET^VALM10(LN,"   RUM Transmit Data to......... "_I) S LN=LN+1
 .F  S I=$O(Z(I)) Q:I=""  D SET^VALM10(LN,$J(" ",33)_I) S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 ;
 Q
 ;
CPU ;-- cpu/node data
 ;
 N COUNT,DATA,I,LEN,TEXT
 ;
 D CPUGET^KMPDUTL6(.DATA)
 Q:'$D(DATA)
 D SET^VALM10(LN,"")
 S LN=LN+1
 S TEXT="   Node/CPU Data............... "
 S (COUNT,I,LEN)=0
 F  S I=$O(DATA(I)) Q:'I  D 
 .S COUNT=COUNT+1,DATA=$G(DATA(I,0)) Q:DATA=""
 .; length of node name
 .S:'LEN LEN=$L($P(DATA,U))+2
 .S TEXT=$S(COUNT=1:TEXT,1:$J(" ",32))_$P(DATA,U)
 .S TEXT=TEXT_$J(" ",30-$L(TEXT)+LEN)_$P(DATA,U,2)_" ("_$P(DATA,U,3)_")"
 .D SET^VALM10(LN,TEXT)
 .S LN=LN+1
 ;
 Q
 ;
LEGEND ;-- display legend
 ;
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"     RUM = Resource Usage Monitor")
 S LN=LN+1
 ;
 Q
 ;
OPT ;-- option data
 ;
 ; daily/weekly background job info
 N DIR,KMPRX,KMPRX1,TEXT,X,Y
 ;
 ; if background option is missing
 I '$O(^DIC(19,"B","KMPR BACKGROUND DRIVER",0)) D 
 .D SET^VALM10(LN,"   The 'RUM Background Driver' option [KMPR BACKGROUND DRIVER] is missing!")
 .S LN=LN+1
 ; background option is present
 E  D 
 .S KMPRX=+$O(^DIC(19,"B","KMPR BACKGROUND DRIVER",0))
 .S KMPRX=+$O(^DIC(19.2,"B",KMPRX,0))
 .; if not scheduled or no task id
 .I 'KMPRX!('$G(^DIC(19.2,+KMPRX,1))) D  Q:'Y
 ..K DIR S DIR(0)="YO",DIR("B")="YES"
 ..S DIR("A")="Do you want to queue this option to run each night at 1am"
 ..W ! D ^DIR I 'Y D  Q
 ...D SET^VALM10(LN,"   The 'RUM Background Driver' [KMPR BACKGROUND DRIVER] is not scheduled")
 ...S LN=LN+1
 ...D SET^VALM10(LN,"   to run!"),SET^VALM10(LN,"")
 ...S LN=LN+1
 ..D QUEBKG^KMPRUTL1
 .S KMPRX=+$O(^DIC(19,"B","KMPR BACKGROUND DRIVER",0))
 .S KMPRX=+$O(^DIC(19.2,"B",KMPRX,0))
 .S KMPRX=$G(^DIC(19.2,KMPRX,0)),KMPRX1=$G(^(1))
 .S $P(KMPRX,U,2)=$$FMTE^XLFDT($P(KMPRX,U,2))
 .D SET^VALM10(LN,"   RUM Background Driver........ KMPR BACKGROUND DRIVER")
 .S LN=LN+1
 .D SET^VALM10(LN,"   QUEUED TO RUN AT............. "_$P(KMPRX,U,2))
 .S LN=LN+1
 .D SET^VALM10(LN,"   RESCHEDULING FREQUENCY....... "_$P(KMPRX,U,6))
 .S LN=LN+1
 .D SET^VALM10(LN,"   TASK ID...................... "_+KMPRX1)
 .S LN=LN+1
 .; user info.
 .S KMPRX1=$G(^%ZTSK(+KMPRX1,0))
 .S TEXT="   QUEUED BY.................... "_$P($G(^VA(200,+$P(KMPRX1,U,3),0)),U)
 .; if user
 .I (+$P(KMPRX1,U,3)) D 
 ..; user 'active' or 'terminated'
 ..S KMPRX1=$$ACTIVE^XUSER(+$P(KMPRX1,U,3))
 ..S TEXT=TEXT_"  ("_$S($P(KMPRX1,U,2)["TERMINATED":"Terminated - "_$$FMTE^XLFDT($P(KMPRX1,U,3),2),1:"Active")_")"
 .D SET^VALM10(LN,TEXT)
 .S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 ;
 Q
 ;
 ;
FILES ;-- file data
 ;
 N TEXT,X
 ;
 D SET^VALM10(LN,$J(" ",35)_" # of     Oldest     Recent")
 S LN=LN+1
 D SET^VALM10(LN,"   File"_$J(" ",28)_"Entries    Date       Date")
 S LN=LN+1
 D SET^VALM10(LN,"   -------------------------       -------   -------   -------")
 S LN=LN+1
 ; file name
 S TEXT="   8971.1-"_$P($G(^DIC(8971.1,0)),U)
 ; number of entries
 S TEXT=TEXT_$J(" ",35-$L(TEXT))_$J($FN($P($G(^KMPR(8971.1,0)),U,4),",",0),7)
 ; oldest date
 S X=$$FMTE^XLFDT(+$O(^KMPR(8971.1,"B",0)),2)
 S X=$S(X=0:"---",1:X)
 S TEXT=TEXT_$J(" ",45-$L(TEXT))_X
 ; current date
 S X=$$FMTE^XLFDT(+$O(^KMPR(8971.1,"B","A"),-1),2)
 S X=$S(X=0:"---",1:X)
 S TEXT=TEXT_$J(" ",55-$L(TEXT))_X
 D SET^VALM10(LN,TEXT)
 S LN=LN+1
 ;
 Q
 ;
ROUCHK(KMPDPKG) ;--display routine version info
 ;-----------------------------------------------------------------------
 ; KMPDPKG... CM Package:
 ;            "D" - CM Tools
 ;            "R" - RUM
 ;            "S" - SAGG
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPDPKG)=""
 Q:KMPDPKG'="D"&(KMPDPKG'="R")&(KMPDPKG'="S")
 ;
 N I,TEXT,X
 ;
 ; routine check
 D VERPTCH^KMPDUTL1(KMPDPKG,.X)
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 S TEXT="   "_$S(KMPDPKG="D":"CM TOOLS",KMPDPKG="R":"RUM",1:"SAGG")_" routines"
 S TEXT=TEXT_$$REPEAT^XLFSTR(".",31-$L(TEXT))_" "
 I '$P($G(X(0)),U,3) D SET^VALM10(LN,TEXT_+X(0)_" Routines - No Problems") S LN=LN+1 Q
 D SET^VALM10(LN,TEXT)
 S LN=LN+1
 D SET^VALM10(LN,$J(" ",20)_"Current Version"_$J(" ",20)_"Should be")
 S LN=LN+1
 S I=0 F  S I=$O(X(I)) Q:I=""  I $P(X(I),U) D 
 .S TEXT="   "_I
 .S TEXT=TEXT_$J(" ",20-$L(TEXT))_$P(X(I),U,4)
 .S:$P(X(I),U,5)]"" TEXT=TEXT_" - "_$P(X(I),U,5)
 .S TEXT=TEXT_$J(" ",55-$L(TEXT))_$P(X(I),U,2)
 .S:$P(X(I),U,3)]"" TEXT=TEXT_" - "_$P(X(I),U,3)
 .D SET^VALM10(LN,TEXT)
 .S LN=LN+1
 ;
 Q
