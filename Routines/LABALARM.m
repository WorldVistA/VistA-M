LABALARM ;SLC/RWF - ALARM FOR LAB ;7/20/90  07:18 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**42**;Sep 27, 1994
 S LRNOW=$$HTE^XLFDT($H,"5MZ")
 F LRI=0:0 S LRI=$O(^LAB(62.4,HOME,4,LRI)) Q:LRI<1  S ZTIO=^(LRI,0),ZTDTH=$H,ZTRTN="WRITE^LABALARM",ZTDESC="Problem on LSI notice",ZTSAVE("LRNOW")="",ZTSAVE("LANM")="" D ^%ZTLOAD
 K LRIO,LRI,LRNOW,IOP,% Q
WRITE ;DEQUEUE ENTRY
 S:$D(ZTQUEUED) ZTREQ="@"
 W $C(7),!!!,$C(7),?18,"********************************************",!!!,$C(7)
 W ?33,"Date/Time: ",LRNOW,!!!
 W ?10,"        THE '",LANM,"' INTERFACE ROUTINE MAY NOT BE RUNNING",$C(7),!!!,$C(7)
 W ?18,"********************************************",$C(7),!!!,$C(7)
 D ^%ZISC Q
