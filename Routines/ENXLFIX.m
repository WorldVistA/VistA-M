ENXLFIX ;WISC/SAB-FIX POINTERS TO ENG SPACE FILE ;1-24-94
 ;;7.0;ENGINEERING;**1**;Aug 17, 1993
EN S DIR(0)="S^EQ:EQUIPMENT FILE;WO:WORK ORDER FILE;"
 S DIR("A")=$S(ENCVTM:"Convert",1:"Report of")_" location fields in which file"
 S DIR("?")="Enter EQ or WO to select the desired file."
 S DIR("?",1)="You must choose which file to process. The LOCATION"
 S DIR("?",2)="field of the selected file will be checked and"
 I ENCVTM D
 .S DIR("?",3)="any free-text values which match an entry in the space"
 .S DIR("?",4)="file will be converted to pointers. Any unconverted"
 .S DIR("?",5)="free-text values will be identified by a leading '*'"
 E  D
 .S DIR("?",3)="the number and type of free-text entries in this"
 .S DIR("?",4)="pointer field will be reported."
 S DIR("?",9)=" "
 D ^DIR K DIR I $D(DIRUT) G EXIT
 S ENFL=Y
 S ENDETAIL=1
 I ENCVTM D  D ^DIR K DIR S ENDETAIL=Y I $D(DIRUT) G EXIT
 .S DIR(0)="Y",DIR("A")="Should locations be listed on output? Y/N"
 .S DIR("?")="Enter Y or N"
 .S DIR("?",1)="If you answer yes a line will be printed for each"
 .S DIR("?",2)="unique free-text location. The line will contain"
 .S DIR("?",3)="the location, the number of entries with that location,"
 .S DIR("?",4)="and if the location was converted to a pointer."
 S %ZIS="QM" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D  G EXIT
 .S ZTRTN="DQ^ENXLFIX"
 .S ZTSAVE("ENCVTM")="",ZTSAVE("ENFL")="",ZTSAVE("ENDETAIL")=""
 .S ZTDESC=$S(ENCVTM:"Convert",1:"Report of")_" Locations in "_$S(ENFL="EQ":"EQUIP",1:"W.O.")_" file"
 .D ^%ZTLOAD D HOME^%ZIS K IO("Q")
DQ ; queued entry
 S Y=DT D DD^%DT S ENDATE=Y
 S (END,ENPG,ENT("LOC"),ENT("REC"),ENT("LOC_CVT"),ENT("REC_CVT"))=0
 S ENFLNM=$S(ENFL="EQ":"Equipment File",1:"Work Order File")
 S ENXRF=$S(ENFL="EQ":"^ENG(6914,""D"",",1:"^ENG(6920,""C"",")
 S ENODE=$S(ENFL="EQ":"^ENG(6914,ENDA,3)",1:"^ENG(6920,ENDA,0)")
 S ENPIECE=$S(ENFL="EQ":5,1:4)
 U IO D HDR
 I 'ENDETAIL W !,"  Locations not listed by user request",!
 ; loop thru free-text locations
 S ENLOC=" " F  S ENLOC=$O(@(ENXRF_"ENLOC)")) Q:ENLOC=""!END  D LOCAT
 I 'END D
 .I ENCVTM,$Y+6+$S(ENT("REC"):6,1:2)+$S(ENT("REC_CVT"):3,1:0)>IOSL D HDR
 .I 'ENCVTM,$Y+6+$S(ENT("REC"):7,1:2)+$S(ENT("REC_CVT"):6,1:0)>IOSL D HDR
 I END W !,"HALTED BY USER REQUEST",!
 E  D RFTR^ENXLFIX0
 D ^%ZISC
EXIT I $D(ZTQUEUED),'$D(ZTSTOP) S ZTREQ="Q"
 K %ZIS,DA,DIE,DIRUT,DR
 K ENCVTM,ENCVTS,END,ENDA,ENDATE,ENDETAIL,ENFL,ENFLNM,ENLOC,ENODE
 K ENPG,ENPIECE,ENSPDA,ENSPLOC,ENT,ENXRF,POP,X,Y
 Q
LOCAT ; process location
 I ENCVTM,$E(ENLOC,1)=" " D SPACES^ENXLFIX0 Q  ; handle leading spaces
 S ENCVTS=0,ENT("LOC")=ENT("LOC")+1
 ; strip * for match
 S ENSPLOC=$E(ENLOC,$S($E(ENLOC,1)="*":2,1:1),$L(ENLOC))
 I ENSPLOC']"" S ENSPLOC=ENLOC
 ; match space .01?
 S ENSPDA=$O(^ENG("SP","B",ENSPLOC,""))
 ; if not match and has lowercase, uppercase match .01?
 I 'ENSPDA,ENSPLOC?.E1L.E D
 .S X=ENSPLOC X ^%ZOSF("UPPERCASE")
 .S ENSPDA=$O(^ENG("SP","B",Y,""))
 ; if we found a match to .01 (either method)
 I ENSPDA S ENCVTS=1,ENT("LOC_CVT")=ENT("LOC_CVT")+1
 ; if not match, match space synonym?
 I 'ENSPDA S ENSPDA=$O(^ENG("SP","F",ENSPLOC,"")) D:ENSPDA
 .I $O(^ENG("SP","F",ENSPLOC,ENSPDA)) S ENCVTS="M"
 .E  S ENCVTS=2,ENT("LOC_CVT")=ENT("LOC_CVT")+1
 ; if still no match and free-text location has *, match synonym?
 I 'ENSPDA,ENSPLOC'=ENLOC S ENSPDA=$O(^ENG("SP","F",ENLOC,"")) D:ENSPDA
 .I $O(^ENG("SP","F",ENLOC,ENSPDA)) S ENCVTS="M"
 .E  S ENCVTS=2,ENT("LOC_CVT")=ENT("LOC_CVT")+1
 ; loop thru records within location
 S ENT("REC_IN_LOC")=0,ENDA=""
 F  S ENDA=$O(@(ENXRF_"ENLOC,ENDA)")) Q:'ENDA  D
 .I '$D(@ENODE) K @(ENXRF_"ENLOC,ENDA)") Q  ; invalid x-ref node
 .S ENT("REC_IN_LOC")=ENT("REC_IN_LOC")+1
 .I ENCVTM,ENCVTS D  ; convert to pointer
 ..I ENFL="EQ",ENLOC["E" K ^ENG(6914,"D",ENLOC,ENDA) S $P(^ENG(6914,ENDA,3),U,5)=""
 ..S DIE=$S(ENFL="EQ":"^ENG(6914,",1:"^ENG(6920,"),DA=ENDA
 ..S DR=$S(ENFL="EQ":"24",1:"3")_"////"_ENSPDA D ^DIE
 .I ENCVTM,'ENCVTS,$E(ENLOC,1)'="*" D  ; add leading *
 ..S $P(@ENODE,U,ENPIECE)="*"_$P(@ENODE,U,ENPIECE)
 ..K @(ENXRF_"ENLOC,ENDA)") ; old x-ref
 ..S @(ENXRF_"""*"_ENLOC_""","_ENDA_")")="" ; new x-ref
 S ENT("REC")=ENT("REC")+ENT("REC_IN_LOC")
 I ENCVTS S ENT("REC_CVT")=ENT("REC_CVT")+ENT("REC_IN_LOC")
 W:ENDETAIL ?5,ENLOC,?30,ENT("REC_IN_LOC"),?40,$S($E(ENLOC,1)=" ":"?? (leading spaces)",ENCVTS=1:"YES, by room number",ENCVTS=2:"YES, by synonym",ENCVTS="M":"NO, multiple synonyms",1:"NO"),!
 I $Y+4>IOSL D HDR
 Q
HDR ; page header
 I $$S^%ZTLOAD S (END,ZTSTOP)=1 Q
 I ENPG,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR S END='Y Q:END
 W:'($E(IOST,1,2)'="C-"&'ENPG) @IOF
 S ENPG=ENPG+1
 W ?5,"Free-Text Values in ",ENFLNM," LOCATION Fields"
 W ?60,ENDATE,?73,"page ",ENPG,!!
 W ?5,"Free-Text Location",?30,"Count"
 W ?40,"Convert"_$S(ENCVTM:"ed?",1:"ible?"),!
 W ?5,"------------------",?30,"-----",?40,"------------",!!
 Q
