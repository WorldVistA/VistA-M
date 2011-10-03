MCDUPP ;WASH/DCB-Post process for the Duplicatation ;Nov 3, 1993
 ;;2.3;Medicine;;09/13/1996
START ;
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I '$D(^TMP($J,"DUP")) W !,"You must first D ^MCDUPE" Q
 W @IOF,!,"This process will repoint your files and "
 W !,"remove the duplicates from the static table."
 S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO" D ^DIR
 Q:((Y=0)!$D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 D REP
 Q
REP ;do the repointing of the files
 N TEMP,REC,LOC,TMP S FILE="",TMP(0)="Re-Indexing global"
 F  S FILE=$O(^TMP($J,"DUP","F",FILE)) Q:FILE=""  D  ;go through the file list 
 .I ^TMP($J,"DUP","F",FILE)=1 D REPOINT(FILE,.TMP),DELETE(FILE) ;if the statics files has duplicates do the repointing
 Q
REPOINT(FILE,TMP) ;Repoints the file
 N TEMP,LOOP,VAL,LOC,CO,DIE,DA,DR,MCSUB,MCDR,MCDIE,MCDA,TYPE,MCVAL
 Q:'$D(^TMP($J,"DUP","J",FILE))
 W !,"----------------------------------------------------------"
 W !,"Repointing File pointing to ",FILE S VAL="",CO=","
 F  S VAL=$O(^TMP($J,"DUP","J",FILE,VAL)) Q:VAL=""  D
 .S TEMP=^TMP($J,"DUP","J",FILE,VAL,1)
 .F LOOP="OLD","NEW" D
 ..S MCVAL=+^TMP($J,"DUP","J",FILE,VAL,LOOP)
 ..S TYPE=$P(TEMP,U,1),LOC="REP"_TYPE_"(TEMP,MCVAL,CO,LOOP)"
 ..D @LOC
 Q
REPM(TEMP,MCVAL,CO,LOOP) ;Repoint in main file
 N DA,DR,DIE,SL0
 S SL0=$P(TEMP,U,2)
 S DIE=$$GET1^DID($P(TEMP,U,2),"","","GLOBAL NAME")
 S DA=$P(TEMP,U,3),DR=$P(TEMP,U,4)_"////"_MCVAL
 I LOOP="NEW" D
 .W !,"----------------------------------------------------------"
 .W !,"   Updating:     File: ",SL0,?30,"        record # ",DA
 .W !,"                 With: ",MCVAL
 D ^DIE
 Q
REPS(TEMP,MCVAL,CO,LOOP) ;Repoint in a sub-file
 N DA,DR,DIE,SL1,SL0
 S DIE=$$GET1^DID($P(TEMP,U,2),"","","GLOBAL NAME")_$P(TEMP,U,3)_CO_$P(TEMP,U,5)_CO
 S DA(1)=$P(TEMP,U,3),DA=$P(TEMP,U,7)
 S DR=$P(TEMP,U,8)_"////"_MCVAL
 S LOOK1=$$GET1^DID($P(TEMP,U,2),"","","GLOBAL NAME")_$P(TEMP,U,3)_CO_$P(TEMP,U,5)_CO_"0)"
 S SL0=+$P(TEMP,U,2)
 S SL1=+$P(TEMP,U,6)
 I LOOP="NEW" D 
 .W !,"----------------------------------------------------------"
 .W !,"   Updating:     File: ",SL0,?30,"        record # ",DA(1)
 .W !,"              Subfile: ",SL1,?30,"     subrecord # ",DA
 .W !,"                 With: ",MCVAL
 D ^DIE
 Q
REPSS(TEMP,MCVAL,CO,LOOP) ;Repoint in a sub-sub-file
 N DA,DR,DIE,SL1,SL2,SL0
 S DIE=$$GET1^DID($P(TEMP,U,2),"","","GLOBAL NAME")_$P(TEMP,U,3)_CO_$P(TEMP,U,5)_CO_$P(TEMP,U,7)_CO_$P(TEMP,U,9)_CO
 S SL1=+$P(TEMP,U,10)
 S SL2=$P(TEMP,U,6)
 S SL0=+$P(TEMP,U,2)
 S DR=$P(TEMP,U,12)_"////"_MCVAL
 S DA=$P(TEMP,U,11)
 S DA(1)=$P(TEMP,U,7),DA(2)=$P(TEMP,U,3)
 I LOOP="NEW" D
 .W !,"----------------------------------------------------------"
 .W !,"   Updating:     File: ",SL0,?30,"        record # ",DA(2)
 .W !,"              Subfile: ",SL1,?30,"     subrecord # ",DA(1)
 .W !,"          Sub-Subfile: ",SL2,?30," sub-subrecord # ",DA
 .W !,"                 With: ",MCVAL
 D ^DIE
 Q
DELETE(FILE) ;Delete the Duplicates
 N VAL,NEWREC,OLDREC,DIK,DA
 Q:'$D(^TMP($J,"DUP","RT",FILE))
 W !,"----------------------------------------------------------"
 W !,"  Deleting the static entries in "_FILE
 S OLDREC=0 F  S OLDREC=$O(^TMP($J,"DUP","RT",FILE,OLDREC)) Q:OLDREC=""  D
 .S NEWREC=+^TMP($J,"DUP","RT",FILE,OLDREC)
 .I OLDREC'=NEWREC D
 ..W !,?4,"Entry # ",OLDREC
 ..S DIK=$$GET1^DID(FILE,"","","GLOBAL NAME")
 ..S %X=DIK_OLDREC_",",%Y="^TMP($J,""DUP"",""STAT"",FILE,"
 ..D %XY^%RCR ;Copy the static record to the ^TMP($J,"DUP","STAT")
 ..S DA=OLDREC D ^DIK ;Delete the static entries
 W !
 Q
