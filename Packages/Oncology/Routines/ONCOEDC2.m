ONCOEDC2 ;HINES OIFO/RTK - ABSTRACT STATUS (165.5,91) Input Transform ;4/29/19
 ;;2.2;ONCOLOGY;**10,12,17**;Jul 31, 2013;Build 6
 ;
OBS2018 ;Remove data in fields that are obsolete for 2018+ cases
 D OBS2023
 K OBSLIST S ONCOBSO=0 D FLDS I ONCOBSO=0 Q
 W !!,"  This abstract has data in fields which are obsolete for 2018+ cases."
 W ! D DELETE
 K ONCOBSO,OBSLIST,CNT,EX,LINE,FN
 Q
 ;
FLDS ;Check if data in any of these obsolete (for 2018+) fields
 ;I $$GET1^DIQ(165.5,PRM,361,"I")="" S FDNUM=361 D CMPLT
 F FDNUM=24,35,29.2,30.2,29.1,31.1,32.1,34.3,34.4,44.1,44.2,44.3,44.4,44.5,44.6,44.7,44.8,44.9,44.101,44.11,44.12,44.13,44.14,44.15,44.16,44.17,44.18,44.19,44.201,44.21,44.22,44.23,44.24,44.25  D
 .I $$GET1^DIQ(165.5,PRM,FDNUM,"I")'="" D OLDTA
 F FDNUM=160,161,162,163,164,165,166,160.7,161.7,162.7,163.7,164.7,165.7,166.7,167,168,169,169.1,37.1,37.2,37.3,38,85,86,87,88,241,242,363,363.1,442,443,56,125,34,34.1,34.2  D
 .I $$GET1^DIQ(165.5,PRM,FDNUM,"I")'="" D OLDTA
 Q
OLDTA ;Set ONCOBSO=1 and add field to list of obsolete fields with data
 S FLDNAME=$P($G(^DD(165.5,FDNUM,0)),U,1) S FDNUM=""
 S ONCOBSO=1,OBSLIST(FLDNAME)=""
 Q
DSPLST ;If there are any fields with data display them here
 S EX="",LINE=$S($E(IOST,1,2)="C-":IOSL-2,1:IOSL-6),CNT=0
 S FN=""
 F  S FN=$O(OBSLIST(FN)),CNT=CNT+1 Q:FN=""  W !,?2,FN I CNT>14 D PCHK Q:EX=U
 Q
 ;
PCHK ;Enter RETURN to continue or '^' to exit:
 I ($Y'<(LINE-1)) D  Q:EX=U  W !
 .W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .W @IOF Q
 Q
DELETE ;
 W "  Deleting obsolete data...",!!
 S $P(^ONCO(165.5,PRM,"BLA2"),"^",18)=""
 S $P(^ONCO(165.5,PRM,24),"^",9)=""
 S $P(^ONCO(165.5,PRM,"THY1"),"^",43)=""
 S $P(^ONCO(165.5,PRM,"THY1"),"^",44)=""
 S $P(^ONCO(165.5,PRM,3),"^",20)=""
 S $P(^ONCO(165.5,PRM,3),"^",21)=""
 S $P(^ONCO(165.5,PRM,2),"^",5)=""
 S $P(^ONCO(165.5,PRM,2),"^",20)=""
 S $P(^ONCO(165.5,PRM,2),"^",25)=""
 S $P(^ONCO(165.5,PRM,2),"^",26)=""
 S $P(^ONCO(165.5,PRM,2),"^",27)=""
 S $P(^ONCO(165.5,PRM,2.1),"^",1)=""
 S $P(^ONCO(165.5,PRM,2.1),"^",2)=""
 S $P(^ONCO(165.5,PRM,2.1),"^",3)=""
 S $P(^ONCO(165.5,PRM,2.1),"^",4)=""
 S $P(^ONCO(165.5,PRM,24),"^",22)=""
 S $P(^ONCO(165.5,PRM,24),"^",23)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",1)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",2)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",3)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",4)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",5)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",6)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",7)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",8)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",9)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",10)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",11)=""
 S $P(^ONCO(165.5,PRM,"CS"),"^",12)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",1)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",2)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",3)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",4)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",5)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",6)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",7)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",8)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",9)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",10)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",11)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",12)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",13)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",14)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",15)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",16)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",17)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",18)=""
 S $P(^ONCO(165.5,PRM,"CS1"),"^",19)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",1)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",2)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",3)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",4)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",5)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",6)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",7)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",8)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",9)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",10)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",11)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",12)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",13)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",14)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",15)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",16)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",17)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",18)=""
 S $P(^ONCO(165.5,PRM,"CS2"),"^",19)=""
 S $P(^ONCO(165.5,PRM,2),"^",11)=""
 S $P(^ONCO(165.5,PRM,2),"^",14)=""
 S $P(^ONCO(165.5,PRM,2),"^",15)=""
 S $P(^ONCO(165.5,PRM,2),"^",16)=""
 S $P(^ONCO(165.5,PRM,2),"^",17)=""
 Q
 ;
OBS2023 ;Remove data in data flag fields that are obsolete for 2023+ cases
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3230000 Q
 S $P(^ONCO(165.5,D0,27),"^",8)=""
 S $P(^ONCO(165.5,D0,27),"^",9)=""
 S $P(^ONCO(165.5,D0,27),"^",10)=""
 S $P(^ONCO(165.5,D0,27),"^",11)=""
 S $P(^ONCO(165.5,D0,27),"^",12)=""
 S $P(^ONCO(165.5,D0,27),"^",13)=""
 S $P(^ONCO(165.5,D0,27),"^",14)=""
 S $P(^ONCO(165.5,D0,27),"^",15)=""
 S $P(^ONCO(165.5,D0,27),"^",16)=""
 S $P(^ONCO(165.5,D0,27),"^",17)=""
 S $P(^ONCO(165.5,D0,27),"^",18)=""
 S $P(^ONCO(165.5,D0,27),"^",19)=""
 S $P(^ONCO(165.5,D0,27),"^",20)=""
 S $P(^ONCO(165.5,D0,27),"^",21)=""
 S $P(^ONCO(165.5,D0,27),"^",22)=""
 S $P(^ONCO(165.5,D0,27),"^",23)=""
 S $P(^ONCO(165.5,D0,27),"^",24)=""
 S $P(^ONCO(165.5,D0,27),"^",25)=""
 S $P(^ONCO(165.5,D0,27),"^",26)=""
 S $P(^ONCO(165.5,D0,27),"^",27)=""
 S $P(^ONCO(165.5,D0,27),"^",28)=""
 S $P(^ONCO(165.5,D0,27),"^",29)=""
 S $P(^ONCO(165.5,D0,27),"^",30)=""
 S $P(^ONCO(165.5,D0,"NCR18"),"^",15)=""
 S $P(^ONCO(165.5,D0,"NCR18"),"^",19)=""
 Q
 ;
COCC(DATEDX) ;COC Coding System Current & Original
 N ONCOC
 S ACDANS="99"
 I DATEDX>3180000 S ACDANS="09"
 I (DATEDX>3030000),(DATEDX<3180000) S ACDANS="08"
 I (DATEDX>2980000),(DATEDX<3030000) S ACDANS="07"
 I (DATEDX>2960000),(DATEDX<2980000) S ACDANS="06"
 I (DATEDX>2940000),(DATEDX<2960000) S ACDANS="05"
 I (DATEDX>2900000),(DATEDX<2940000) S ACDANS="04"
 Q ACDANS
CCDTS(IEN) ;COC Cancer Status Date
 N ONCDTS,ONCDTI
 S ACDANS=""
 I '$D(^ONCO(165.5,IEN,"TS","B")) Q ACDANS
 S ONCDTS=$O(^ONCO(165.5,IEN,"TS","B",9999999),-1)
 I ONCDTS="" Q ACDANS
 S ONCDTI=$O(^ONCO(165.5,IEN,"TS","B",ONCDTS,999),-1)
 I ONCDTI="" Q ACDANS
 S ACDANS=$P($G(^ONCO(165.5,IEN,"TS",ONCDTI,0)),U,3)
 Q ACDANS
CCDFL(IEN) ;COC Cancer Status Date Flag
 N ONCDTS,ONCDTI
 S ACDANS=""
 I '$D(^ONCO(165.5,IEN,"TS","B")) Q ACDANS
 S ONCDTS=$O(^ONCO(165.5,IEN,"TS","B",9999999),-1)
 I ONCDTS="" Q ACDANS
 S ONCDTI=$O(^ONCO(165.5,IEN,"TS","B",ONCDTS,999),-1)
 I ONCDTI="" Q ACDANS
 S ACDANS=$P($G(^ONCO(165.5,IEN,"TS",ONCDTI,0)),U,4)
 Q ACDANS
