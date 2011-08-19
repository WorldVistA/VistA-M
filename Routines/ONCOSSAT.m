ONCOSSAT ;HInes OIFO/GWB - BEGIN SURVIVAL ANALYSIS ;9/30/93
 ;;2.11;ONCOLOGY;**13,15,45**;Mar 07, 1995
 ;
IN ;CALL SURVIAL ROUTINES
 G ^ONCOSSA
 ;
SEX ;for reference only - NOT an Option entry point
 K ONCOS
 S ONCOS("F")="PRIMARY",ONCOS("T")="ALL"
 S ONCOS("D")="SURVIVAL MONTHS^M^Y"
 S ONCOS("S")="STATUS=""Dead""",ONCOS("G")="2"
 S ONCOS("G",1)=".1^Males^VAL(.1)=""Male"""
 S ONCOS("T")="ONCO-ANALYTIC"
 S ONCOS("G",2)=".1^Females^VAL(.1)=""Female"""
 S ONCOS("L")="PY" G DEV
 ;
 ;
STG ;SURVIVAL BY STAGE GROUPS
 K ONSOS D OV G EX:Y<0 S ONCOS("G")=4,ONCOS("G",1)="38.5^Stage I^VAL(38.5)=""I""",ONCOS("G",2)="38.5^Stage II^VAL(38.5)=""II""",ONCOS("G",3)="38.5^Stage III^VAL(38.5)=""III""",ONCOS("G",4)="38.5^Stage IV^VAL(38.5)=""IV""" G DEV
 K ONCOS D OV S ONCOS("G")="1",ONCOS("G",1)=".01^Prostate^VAL(.01)=""PROSTATE""" G DEV
 ;
TX ;SURVIVAL BY TREATMENT
 K ONCOS D OV G EX:Y<0
 S ONCOS("G")=9
 S ONCOS("G",1)="43^Surgery of primary site^VAL(43)=""SUR"""
 S ONCOS("G",2)="43^Radiation^VAL(43)=""XRT"""
 S ONCOS("G",3)="43^Chemotherapy^VAL(43)=""CMX"""
 S ONCOS("G",4)="43^Hormone therapy^VAL(43)=""HOR"""
 S ONCOS("G",5)="43^Immunotherapy^VAL(43)=""BRM"""
 S ONCOS("G",6)="43^Hema Trans/Endocrine Proc^VAL(43)=""HEM"""
 S ONCOS("G",7)="43^Other treatment^VAL(43)=""OTR"""
 S ONCOS("G",8)="43^Combination treatment^($L(VAL(43))>3)&(VAL(43)'=""NONE"")"
 S ONCOS("G",9)="43^No treatment^(VAL(43)=""NTX"")!(VAL(43)=""NONE"")"
 G DEV
 ;
SP ;SURVIVAL BY SITE/(use Sex to get one curve)
 W !!!,"Enter a package template name (beginning with ONCO) or your own"
 W !,"template name below.",!
 W !,"Search template names begin with ONCOS.  All other ONCO templates"
 W !,"are sort templates.",!
 W !,"If you select a sort template here, you will be prompted for a"
 W !,"search template later.",!
 K ONCOS D OV G EX:Y<0 S ONCOS("G")=1,ONCOS("G",1)=".1^VAL(.1)=""Male""",ONCOS("G",2)=".1^Females^VAL(.1)=""Female""" G DEV
 ;
DEV ;DEVICE SELECTION & TASKING
 D ^ONCOSSA G EX
ZIS K IO("Q") S %ZIS="Q" S:$D(ONCOS("I")) IOP=ONCOS("I") D ^%ZIS I POP S ONCOUT="" G EX
NQ I '$D(IO("Q")) D ^ONCOSSA G EX
 S ZTRTN="PRINT^ONCOSSA",ZTDESC="ONCOLOGY SURVIVAL"
 S ZTSAVE("ONCOS*")="" D ^%ZTLOAD K ZTSK G EX
ZT S ZTRTN="PRINT^ONCOSSA",ZTDESC="ONCOLOGY SURVIVAL",ZTSAVE("ONCOS*")="" D ^%ZTLOAD K ZTSK G EX
 ;
OV S ONCOS("FI")="165.5^ONCOLOGY PRIMARY^ONCO(165.5,",ONCOS("D")="SURVIVAL MONTHS^M^Y",ONCOS("L")="PY",ONCOS("S")="STATUS=""Dead"""
 S DIC="^DIBT(",DIC("A")="     Select Template: ",DIC(0)="AEZ" D ^DIC Q:Y<0  S ONCOS("T")=$P(Y,U,2) W ONCOS("T")
 W !!,?5,"REMINDER: Run Define Search Criteria option",!
 W ?5,"to be sure selected entries are up-to-date!!",!!
 S DIR("A")="Continue ",DIR("B")="Y",DIR(0)="Y" D ^DIR G EX:Y'=1
 Q
 ;
EX ;Exit routine
 K IOP,DIC,ONCOEX,ONCOS,%DT,%ZISOS,GIL,INT,%K,%T,FIL,T,TX D ^%ZISC Q
 K FNAM,GBL,HLAB,OT,W,ROWDEF
 Q
