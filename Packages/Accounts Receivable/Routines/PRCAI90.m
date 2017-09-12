PRCAI90 ;WISC/RFJ-patch 90 post init ;1 Oct 97
 ;;4.5;Accounts Receivable;**90**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;  start of post init for patch 90
 ;  change the following AR categories in file 430.2 from non-accrued
 ;  to accrued.  hard code the sets since the field is un-editable.
 ;    INELIGIBLE HOSP. (cat# 20)
 ;    TORT FEASOR (cat# 22)
 ;    EMERGENCY/HUMANITARIAN (cat# 25)
 ;
 N %,CATEGORY,D,D0,D,DA,DATA,DD,DI,DIC,DIE,DINUM,DO,DLAYGO,DQ,DR,PRCADESC,PRCARSC,X,Y
 F CATEGORY=20,22,25 D
 .   S DA=+$O(^PRCA(430.2,"AC",CATEGORY,0))
 .   S DATA=$G(^PRCA(430.2,DA,0)) I DATA="" Q
 .   S $P(^PRCA(430.2,DA,0),"^",9)=1
 ;
 ;  add new server entry into file 423.5
 I '$O(^PRCF(423.5,"B","CTL-TRI",0)) D
 .   S X="CTL-TRI",DIC="^PRCF(423.5,",DIC(0)="L",DLAYGO=432.5
 .   K DD,DO D FILE^DICN
 .   I Y<0 W !!,"ERROR SETTING UP THE SERVER IN FILE 423.5.  PLEASE RE-INSTALL THE PATCH." Q
 .   S DA=+Y
 .   S DIE="^PRCF(423.5,",DR="2////EN;3////RCXFMSTR;1///FMS"
 .   D ^DIE
 ;
 ;  add revenue source codes to file 347.3
 F PRCARSC=8000,8022,8033,8034,8035 D
 .   I $D(^RC(347.3,PRCARSC,0)) Q
 .   S (DINUM,X)=PRCARSC,DIC="^RC(347.3,",DIC(0)="L",DLAYGO=347.3
 .   S PRCADESC=$S(PRCARSC=8000:"NON MEDICAL REIMBURSEMENTS",PRCARSC=8022:"Q&S - WOC",PRCARSC=8033:"TORT FEASOR - TITLE 38",PRCARSC=8034:"ENHANCED USE LEASE",PRCARSC=8035:"SHARING MED RESOURCES, A/O",1:"")
 .   S DIC("DR")=".02////"_PRCADESC_";"
 .   K DD,DO D FILE^DICN
 .   I Y<0 W !!,"ERROR ADDING REVENUE SOURCE CODES IN FILE 347.3.  PLEASE RE-INSTALL PATCH."
 Q
