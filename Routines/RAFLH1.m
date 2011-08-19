RAFLH1 ;HISC/CAH,FPT AISC/MJK,RMO-Print Radiology Exam Labels ;6/12/97  11:44
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 Q:'RAEXLBLS  I RAFLHFL S RACNI=RAFLHFL G PRT
 F RACNI=+$P(RAFLHFL,";",2):0 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  I $D(^(RACNI,0)) S RAY3=^(0) D PRT
 Q
PRT S RAFMT=RAEXFM,RANUM=RAEXLBLS D PRT^RAFLH Q
 ;
TEST D SET^RAPSET1 I $D(XQUIT) K XQUIT,POP Q
 S RATEST="",RANUM=1,RAFMT=$S($P(RAMLC,"^",7):$P(RAMLC,"^",7),1:1)
 S ZTRTN="START^RAFLH1" F RASV="RATEST","RANUM","RAFMT","RAMDIV" S ZTSAVE(RASV)=""
 D ZIS^RAUTL G Q:RAPOP
START U IO S RAK=0
 F  S RAK=$O(^RA(78.7,RAK)) Q:RAK'>0  D SETFLH^RAFLH2(RAK)
 G Q:'$D(^RA(78.2,RAFMT,0))
 F RAII=1:1:RANUM W @IOF F RAI=0:0 S RAI=$O(^RA(78.2,RAFMT,"E",RAI)) Q:RAI'>0  D
 . I $G(^RA(78.2,RAFMT,"E",RAI,0))'["@" D
 .. X ^RA(78.2,RAFMT,"E",RAI,0)
 .. Q
 . E  D XECFLH^RAFLH2(RAFMT,RAI)
 . Q
Q ; Quit & kill
 ; RAOPT("RPTPAT") is defined in the entry action field for options
 ; in this case RAOPT("RPTPAT") is defined for the option RA RPTPAT.
 ; RA RPTPAT is allowed to print more than one record.  If multiple
 ; records, this CLOSE^RAUTL will close the device after printing
 ; only one record.  This causes subsequent records to be displayed to
 ; the HOME device.
 D:'$D(RAOPT("RPTPAT")) CLOSE^RAUTL S RAK=0
 F  S RAK=$O(^RA(78.7,RAK)) Q:RAK'>0  D KILFLH^RAFLH2(RAK)
 K %W,%Y1,DUOUT,POP,RAEXFM,RAEXLBLS,RAFLHFL,RAFMT,RAI,RAII,RAK,RAMES,RANUM,RAPOP,RASV,RATEST,RAY0,RAY1,RAY2,RAY3,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,DISYS
 I $D(ZTQUEUED) K RADFN,RADTI,RAFLH
 Q
 ;
CMP ;This code compiles flash card formats into code stored in the
 ;'Compiled Logic' field #100 of file #78.2
 Q:'$D(^RA(78.2,RAFMT,0))  S RAROW=$S($P(^(0),"^",2):$P(^(0),"^",2),1:6) K ^RA(78.2,RAFMT,"E"),^TMP($J,"RAFORM")
 F RAI=0:0 S RAI=$O(^RA(78.2,RAFMT,1,RAI)) Q:RAI'>0  I $D(^(RAI,0)) S XX=^(0),^TMP($J,"RAFORM",+$P(XX,"^",2),+$P(XX,"^",3),$P(XX,"^"))=$P(XX,"^",4,5)
 S RAN=1 F RAI=1:1:RAROW S FL=1 S:'$D(^TMP($J,"RAFORM",RAI)) ^RA(78.2,RAFMT,"E",RAN,0)="W !",RAN=RAN+1 I $D(^(RAI)) F COL=0:0 S COL=$O(^TMP($J,"RAFORM",RAI,COL)) Q:COL'>0  S %="",%=$O(^(COL,%)) S J=^(%) D STORE
 W !!?5,"...format '",$P(^RA(78.2,RAFMT,0),"^"),"' has been compiled."
 K RA787,RAROW,XX,RAI,RAII,RAIV,RADEF,J,TITL,COL,RAN,^TMP($J,"RAFORM")
 Q
 ;
STORE S RAIV="DT",RADEF="" S:$D(^RA(78.7,+%,0)) RAIV=^(0),RADEF=$P(RAIV,"^",3),RAIV=$P(RAIV,"^",5)
 S RA787("E")=$G(^RA(78.7,+%,"E"))
 S TITL=$S(RAIV="RAFREE":"",$P(J,"^")="NONE":"",$P(J,"^")]"":$P(J,"^"),1:RADEF)
 S ^RA(78.2,RAFMT,"E",RAN,0)="W "_$S(FL:"!",1:"")_"?"_(COL-1)_","""_TITL_""","_$S(RAIV="RAFREE":""""_$P(J,"^",2)_"""",RA787("E")["$$BCDE^RAUTL18":"@"_RAIV,1:RAIV)
 S RAN=RAN+1,FL=0
 Q
 ;
 ; Exam labels are printed on the device specified in the location
 ; parameter, FLASH CARD PRINTER NAME in File 79.1. If there is no
 ; value in that field, the user will be prompted for a device. The
 ; number of exam labels printed is defined in the location parameter,
 ; HOW MANY EXAM LABELS PER EXAM. That number is not changed by any
 ; parameter or combination of parameters. If that number is zero (or
 ; null), then no exam labels will be printed.
