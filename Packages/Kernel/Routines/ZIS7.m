%ZIS7 ;SFISC/AC - DEVICE HANDLER HELP ;05/05/10  15:58
 ;;8.0;KERNEL;**205,546**;JUL 10, 1995;Build 9
EN1 W !,"Specify a device with optional parameters in the format"
 W !,?8,"Device Name;Right Margin;Page Length"
 W !,?21,"or"
 W !,?5,"Device Name;Subtype;Right Margin;Page Length"
 W !!,"Or in the new format"
 W !,?14,"Device Name;/settings"
 W !,?21,"or"
 W !,?10,"Device Name;Subtype;/settings"
 W !,"For example"
 W !,?17,"HOME;80;999"
 W !,?21,"or"
 W !,?13,"HOME;C-VT320;/M80L999"
 W !!,"Enter ?? for more information"
 Q
EN2 S X=0 I $D(^%ZOSF("TEST")) S X="XQH" X ^("TEST")
 I $T S X=$O(^DIC(9.2,"B","XUDOC DEVICE PROMPT*",0)),X=$D(^DIC(9.2,+X,0)) I X S X=($P(^(0),"^",1)="XUDOC DEVICE PROMPT*")
 W !,"The following information is available:"
 ;W !?20,"Printer Listing",!?20,"Complete Device Listing",!?20,"Extended Help"_$S(X:"",1:" [UNAVAILABLE]")
 W !?20,"All Printers",!?20,"Printers only on '"_%ZISV_"'",!?20,"Complete Device Listing",!?20,"Devices only on '"_%ZISV_"'"
 W !,?20,"New Format for Device Specification",!?20,"Extended Help"_$S(X:"",1:" [UNAVAILABLE]")
R W !!?15,"Select one (A,P,C,D,N, or E): " D SBR^%ZIS1 S %X=$$UP^%ZIS1(%X) ;p546
 I $D(DTOUT)!$D(DUOUT) K DTOUT,DUOUT Q
 Q:%X=""  S %X=$E(%X_"?")
 I %X="?"!("APCDNE"'[%X) W !,"Enter 'A', 'P', 'C', 'D', 'N' or 'E'" G R
 I 'X,%X="E" W *7," [UNAVAILABLE]" G R
 I "APCD"[%X D LD1^%ZIS5 Q
 I "EN"'[%X W *7," [ERROR]" Q
 N %ZIS,%H,%E,%ZISB,%ZISV,IO ;p546
 S U="^",XQH=$S(%X="E":"XUDOC DEVICE PROMPT*",1:"XUDOC DEVICE ALT SYNTAX")
 D DT^DICRW:'$D(DUZ)#2!'$D(DTIME),EN^XQH
 Q
