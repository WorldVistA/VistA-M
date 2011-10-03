PRCNINST ;SSI/ALA-Install Equipment/Turn-In Request Module ;[ 08/05/96  12:53 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
 I '$G(DUZ)!($G(DUZ(0))'["@") W !,"USER 'DUZ' VARIABLES **NOT** CORRECTLY DEFINED.  D ^XUP." G EXT
 I $$VERSION^XPDUTL("PRC")<5 W !!,"VERSION 5.0 OF IFCAP HAS NOT BEEN LOADED" G EXT
 I $$VERSION^XPDUTL("EN")<7 W !!,"VERSION 7.0 OF ENGINEERING HAS NOT BEEN LOADED" G EXT
 ;
 ;  Check for Engineering patch
 I $D(^%ZOSF("TEST")) S QFL=0 D  G EXT:QFL
 . F X="ENFAUTL","ENWONEW2" X ^%ZOSF("TEST") I '$T W !!,"Engineering Patch 25 not loaded yet!" S QFL=1
 ;
PCM ; Print bad data from the CMR file
 D MES^XPDUTL("A Report on the State of Your CMR file (6914.1) follows.")
 S %ZIS="Q" D ^%ZIS I POP>0 W !,"No device selected or device unavailable!",$C(7) G PCM
 I $D(IO("Q")) D  Q
 . S ZTRTN="CMR^PRCNINST",ZTDESC="Erroneous CMR Data"
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTSK,%ZTLOAD,ZTREQ
CMR ;  Check CMR file
 S CMRT="" W !!,"CMR FILE (6914.1) REPORT",!!
CMT S CMRT=$O(^ENG(6914.1,"B",CMRT)) G EXIT:CMRT=""
 S CMRN=0 F  S CMRN=$O(^ENG(6914.1,"B",CMRT,CMRN)) Q:'CMRN  D
 . S CMRO=$P(^ENG(6914.1,CMRN,0),U,2),CMRS=$P(^(0),U,5),CMR=$P(^(0),U)
 . I CMRO="" W !,"NO CMR OFFICIAL DEFINED FOR "_CMR
 . I CMRS="" W !,"NO CMR SERVICE DEFINED FOR "_CMR
 . I CMRS=""!(CMRO="") Q
 . I CMRO'?.N W !,"CMR OFFICIAL IS NOT POINTER FOR "_CMR
 . I CMRS'?.N W !,"CMR SERVICE IS NOT POINTER FOR "_CMR
 . I CMRO'?.N!(CMRS'?.N) Q
 . I $G(^VA(200,CMRO,0))="" W !,"PERSON POINTED TO DOES NOT EXIST FOR "_CMR
 . I $G(^DIC(49,CMRS,0))="" W !,"SERVICE POINTED TO DOES NOT EXIST FOR "_CMR
 G CMT
EXIT K TMP,OPT,CMRN,CMRS,CMRO D ^%ZISC
 Q
EXT S XPDQUIT=1
 Q
