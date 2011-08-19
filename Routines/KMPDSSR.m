KMPDSSR ;OAK/RAK - Resource Usage Monitor Status ;2/14/05  13:50
 ;;2.0;CAPACITY MANAGEMENT - RUM;**3**;Mar 22, 2002
 ;
FORMAT(KMPRLN) ;-format text for display
 ;-----------------------------------------------------------------------------
 ; KMPRLN.... return number of lines - called by referrence
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
 .S LN=LN+1
 .D SET^VALM10(LN,"The CAPACITY MANAGEMENT - RUM package is not installed!")
 ;
 ; option data
 D OPT^KMPDSSD("KMPR BACKGROUND DRIVER")
 ;
 ; background data
 D BKGRND
 ;
 ; file data
 D FILES
 ;
 ; routine version check
 D ROUCHK^KMPDSSD1("R")
 ;
 ; node/cpu data
 D CPU^KMPDSSD1
 ;
 ; mail group members
 D MGRP^KMPDSSD1
 ;
 ; legend
 D LEGEND
 ;
 S KMPRLN=LN
 ;
 Q
 ;
BKGRND ; rum background info
 ;
 N DATA,DELTA,ENDT,I,STAT,STDT,Z
 ;
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"   Temporary collection global..")
 S LN=LN+1
 D SET^VALM10(LN,"   ^KMPTMP(""KMPR"").............. "_$S('$D(^KMPTMP("KMPR")):"NOT ",1:"")_"Present")
 S LN=LN+1
 D SET^VALM10(LN,"")
 ;
 D PARAMS^KMPDUT("DATA") Q:'$D(DATA)
 S DATA(2)=$G(DATA(2))
 S STDT=$P(DATA(2),U,5),ENDT=$P(DATA(2),U,6),DELTA=$P(DATA(2),U,7)
 S:$E(DELTA)=" " $E(DELTA)="0"
 S LN=LN+1
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
 D TRANSTO^KMPDUTL7(1,2,.Z)
 I '$D(Z) D SET^VALM10(LN,"   RUM Transmit Data to......... <>") S LN=LN+1
 E  D 
 .S I=$O(Z("")) I I'="" S LN=LN+1 D SET^VALM10(LN,"   RUM Transmit Data to......... "_I)
 .F  S I=$O(Z(I)) Q:I=""  S LN=LN+1 D SET^VALM10(LN,$J(" ",33)_I)
 S LN=LN+1
 D SET^VALM10(LN,"")
 ;
 Q
 ;
FILES ;-- file data
 ;
 N TEXT,X
 ;
 S LN=LN+1
 D SET^VALM10(LN,$J(" ",35)_" # of     Oldest     Recent")
 S LN=LN+1
 D SET^VALM10(LN,"   File"_$J(" ",28)_"Entries    Date       Date")
 S LN=LN+1
 D SET^VALM10(LN,"   -------------------------       -------   -------   -------")
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
 S LN=LN+1
 D SET^VALM10(LN,TEXT)
 ;
 Q
 ;
LEGEND ;-- display legend
 ;
 S LN=LN+1 D SET^VALM10(LN,"")
 S LN=LN+1 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"     RUM = Resource Usage Monitor")
 ;
 Q
