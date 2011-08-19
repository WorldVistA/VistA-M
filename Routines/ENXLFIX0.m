ENXLFIX0 ;WISC/SAB-FIX POINTERS TO ENG SPACE FILE (continued) ;1-6-94
 ;;7.0;ENGINEERING;**1**;Aug 17, 1993
SPACES ; handle locations with leading spaces here (convert mode only)
 ;
 ; if location only has spaces then delete it from all records
 ; otherwise remove the leading spaces from the location.
 ; The modified location will be processed later during the
 ; main $Order thru the location x-ref.
 ;
 ; lets get the location without leading spaces
 S ENLOCN=ENLOC,ENDA=""
 F  Q:$E(ENLOCN,1)'=" "  S ENLOCN=$E(ENLOCN,2,$L(ENLOCN))
 ; if nothing left then delete the location
 I ENLOCN']"" F  S ENDA=$O(@(ENXRF_"ENLOC,ENDA)")) Q:'ENDA  D
 .S DIE=$S(ENFL="EQ":"^ENG(6914,",1:"^ENG(6920,"),DA=ENDA
 .S DR=$S(ENFL="EQ":"24",1:"3")_"///@" D ^DIE
 ; if something left then change current location
 I ENLOCN]"" F  S ENDA=$O(@(ENXRF_"ENLOC,ENDA)")) Q:'ENDA  D
 .S $P(@ENODE,U,ENPIECE)=ENLOCN ; update location
 .K @(ENXRF_"ENLOC,ENDA)") ; kill old x-ref
 .S @(ENXRF_"ENLOCN,ENDA)")="" ; set new x-ref
 K ENLOCN
 Q
RFTR ; report footer
 W !,"# of different free-text locations    = ",ENT("LOC"),"  (# convertible = ",ENT("LOC_CVT"),")",!
 W "# of records with free-text locations = ",ENT("REC"),"  (# convertible = ",ENT("REC_CVT"),")",!!
 I ENT("REC") D
 .W "Free-Text values were found in the LOCATION field of",!
 .W ENFLNM," records. These free-text values",!
 .I ENCVTM D
 ..W "were either converted to pointers or identified",!
 ..W "by a leading '*'. The leading astrisk ensures",!
 ..W "that these values will not be inappropriately",!
 ..W "evaluated as a pointer.",!
 .E  D
 ..W "should be converted to pointer values. If an exact match",!
 ..W "exists in the ENG SPACE file ROOM NUMBER or SYNONYM fields",!
 ..W "then option 'Convert Free-Text Locations' can be used to",!
 ..W "perform the conversion. A leading '*' will be removed from",!
 ..W "the free-text location before checking for a match.",!
 I ENT("REC_CVT") D
 .W !,"Convertable free-text entries were found in the ",!
 .I ENCVTM D
 ..W ENFLNM,". They have been converted to pointers.",!
 .E  D
 ..W ENFLNM,". You must use the 'Convert Free-Text Locations'",!
 ..W "option for the ",ENFLNM," to actually convert",!
 ..W "these values to pointers.",!
 I 'ENT("REC") D
 .W "The ",ENFLNM," LOCATION field does not contain any",!
 .W "Free-Text values. No further action is required on this file.",!
 Q
