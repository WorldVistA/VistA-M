ECXLABRS ;BIR/CML-Set Up the File to Control Extract of Lab Results; [ 02/26/97  2:56 PM ]
 ;;3.0;DSS EXTRACTS;**8,51**;Dec 22, 1997
EN ;entry point from option
 W @IOF
 W !,"This option will assist in the steps that create the files necessary to"
 W !,"control the extract of lab results for DSS. This will probably require"
 W !,"a combined effort between DSS personnel and lab personnel."
 ;
ASKTST ;loop on DSS lab tests multiple in 727.21 and the local lab data name subfile 727.211
 W !!!,"Step #1 - For each of the DSS lab tests, identify the tests as they"
 W !?10,"are named in your laboratory.  There may be more than one"
 W !?10,"test in your laboratory to generate the results asked for,"
 W !?10,"in that case, you should enter all such tests."
 F  W ! S DIC="^ECX(727.2,1,1,",DIC(0)="AEQM" D ^DIC Q:Y<0  S TST=+Y D
 .K EC,ECNM S ECNM=$P(^ECX(727.2,1,1,TST,0),U),EC=$P(^(0),U,2),EC=$S(EC="B":"BLOOD",EC="U":"URINE",1:"FECES")
 .W !,"(for ",ECNM,", select tests that use ",EC," as a specimen)"
 .W ! F  K DA S DA(2)=1,DA(1)=TST,DIC="^ECX(727.2,"_DA(2)_",1,"_DA(1)_",""LOC"",",DIC(0)="QEAMOLZ" K ECXDD D FIELD^DID(727.21,1,,"SPECIFIER","ECXDD") S DIC("P")=ECXDD("SPECIFIER") K ECXDD D ^DIC K DIC Q:Y<0  S LOC=+Y D
 ..S DA(2)=1,DA(1)=TST,DA=LOC,DIE="^ECX(727.2,"_DA(2)_",1,"_DA(1)_",""LOC"",",DR=.01 D ^DIE K DIE
ASKBLD ;loop on blood specimen multiple 727.22  
 G:$D(DTOUT)!($D(DUOUT)) END
 W !!!,"Step #2 - Define all blood specimens used by your facility."
 W ! F  S DA(1)=1,DIC="^ECX(727.2,"_DA(1)_",""BL"",",DIC(0)="QEAMOLZ" K ECXDD D FIELD^DID(727.2,2,,"SPECIFIER","ECXDD") S DIC("P")=ECXDD("SPECIFIER") K ECXDD D ^DIC K DIC Q:Y<0  D
 .S DA=+Y,DA(1)=1,DIE="^ECX(727.2,"_DA(1)_",""BL"",",DR=.01 D ^DIE K DIE
ASKUR ;loop on urine specimen multiple 727.23  
 G:$D(DTOUT)!($D(DUOUT)) END
 W !!!,"Step #3 - Define all urine specimens used by your facility."
 W ! F  S DA(1)=1,DIC="^ECX(727.2,"_DA(1)_",""UR"",",DIC(0)="QEAMOLZ" K ECXDD D FIELD^DID(727.2,3,,"SPECIFIER","ECXDD") S DIC("P")=ECXDD("SPECIFIER") K ECXDD D ^DIC K DIC Q:Y<0  D
 .S DA=+Y,DA(1)=1,DIE="^ECX(727.2,"_DA(1)_",""UR"",",DR=.01 D ^DIE K DIE
ASKFE ;loop on feces specimen multiple 727.24
 G:$D(DTOUT)!($D(DUOUT)) END
 W !!!,"Step #4 - Define all feces specimens used by your facility."
 W ! F  S DA(1)=1,DIC="^ECX(727.2,"_DA(1)_",""FE"",",DIC(0)="QEAMOLZ" K ECXDD D FIELD^DID(727.2,4,,"SPECIFIER","ECXDD") S DIC("P")=ECXDD("SPECIFIER") K ECXDD D ^DIC K DIC Q:Y<0  D
 .S DA=+Y,DA(1)=1,DIE="^ECX(727.2,"_DA(1)_",""FE"",",DR=.01 D ^DIE K DIE
END K DA,DIC,DIE,DR,EC,ECNM,ECXB,ECXS,J,LOC,TST,X,Y Q
