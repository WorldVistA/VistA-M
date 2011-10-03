PRCHITM2 ;WOIFO/LKG-NIF Items Descriptions Extract ;9/14/04  16:11
V ;;5.1;IFCAP;**63**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
PRT ;VA FileMan Print Output
 N PRCTXT S PRCTXT(1)="This option displays item records via FileMan print utilities."
 S PRCTXT(1,"F")="!!?5"
 S PRCTXT(2)="It supports up to 5 levels of sort based on displayed fields."
 S PRCTXT(2,"F")="!?5"
 D EN^DDIOL(.PRCTXT) K PRCTXT
 K L,DIC,FLDS,BY,FR,TO,DIS,DHD S DHD="IFCAP ITEM DESCRIPTIONS STATION "_$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S L=0,DIC=441,DIS(0)="I $P($G(^PRC(441,D0,0)),U,15)>0",BY=$$SORTKEYS
 I $D(DTOUT)!$D(DUOUT) G PRTX
 S FLDS=".01;C1;""IMF ITEM #"",51;C20;""NIF ITEM #"",14;C40;""EDIT DATE"",16;C60;""INACTIVE FLAG"",""SHORT DESCRIPTION:"";C1;"""",.05;C5;"""",""PRE-NIF SHORT DESCRIPTION:"";C1;"""",52;C5;"""""
 S FLDS(1)="""DESCRIPTION:"";C1;"""",.1;C5;"""",""PRE-NIF DESCRIPTION:"";C1;"""",50;C5;"""","" "";C1;"""""
 N PRCTR S PRCTR=0,DHIT="S PRCTR=PRCTR+1",DIOEND="W !!,""Count = "",PRCTR R:$E(IOST,1,2)=""C-"" !,""Press RETURN to continue... "",PRCX:DTIME",DIPCRIT=1
 S DIOBEG="W:$E(IOST,1,2)=""C-"" @IOF"
 D EN1^DIP
PRTX K L,DIC,DIS,FLDS,BY,FR,TO,DHD,DHIT,DIOBEG,DIOEND,DIPCRIT,DTOUT,DUOUT,DIROUT,PRCX
 Q
SORTKEYS() ;Returns sort key string
 N PRCCNT,PRCX S PRCCNT=0,PRCX=""
SORTIN K DIR,X,Y
 S DIR(0)="SO^.01:IMF Item# (NUMBER);51:NIF Item#;14:Edit Date (DATE ITEM CREATED);.05:Short Description;52:Pre-NIF Short Description"
 S DIR("A")=$S(PRCCNT=0:"Sort",1:"Then sort")_" by"
 S DIR("L",1)="   .01  IMF Item# (NUMBER)"
 S DIR("L",2)="    51  NIF Item#"
 S DIR("L",3)="    14  Edit Date (DATE ITEM CREATED)"
 S DIR("L",4)="   .05  Short Description"
 S DIR("L",5)="    52  Pre-NIF Short Description"
 S DIR("L",6)=""
 S DIR("L")="Press RETURN at the prompt when you have finished selecting sort fields."
 S DIR("?")="Enter "_$S(PRCCNT<1:"major",1:"minor")_" sort key"
 D ^DIR I $D(DUOUT)!$D(DTOUT)!$D(DIROUT) S PRCX="" G SORTX
 I Y'="" S PRCX=PRCX_$S(PRCCNT>0:",",1:"")_Y S PRCCNT=PRCCNT+1 G:PRCCNT<5 SORTIN
 S:PRCX="" PRCX=".01"
SORTX K DIR,DIRUT,DIROUT,X,Y
 Q PRCX
