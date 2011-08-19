IBDFESP ;ALB/AAS - AICS EDIT SITE PARAMS ; 19-DEC-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15,25**;APR 24, 1997
 ;
EDIT ; -- edit site parameters
 I '$D(DT) D DT^DICRW
 N DIC,DIE,DA,DR,X,Y,HOLD,HOLD2
 I $G(^IBD(357.09,1,0))="" D CREATE
 S DIE="^IBD(357.09,",DA=1
 S HOLD=$P($G(^IBD(357.09,DA,0)),"^",8,9)
 S HOLD2=$P($G(^IBD(357.09,DA,0)),"^",12)
 W !!,"Edit AICS Site Parameters"
 W !!,"Form Tracking Purge Parameters"
 S DR=".02;.03;1.01;W !!,""Data Entry Parameters"";.04;.06;.07;W !!,""Print Parameters"";.05//YES;.1//30;.13//12;.14//25;W !!,""Scanning Parameters"";I '$D(^XUSEC(""IBD MANAGER"",DUZ)) S Y=1.02;.08//20;.09//5;.12//2;1.02;.11"
 D ^DIE
 ;
 ; -- if scanning parameters have changed, force a regen. of all fs
 I (HOLD'=$P($G(^IBD(357.09,DA,0)),"^",8,9))!(HOLD2'=$P($G(^IBD(357.09,DA,0)),"^",12)) D
 .W !!,$C(7),"***SCANNING PERCENTAGES HAVE CHANGED***"
 .W !!,"In order for scanning % changes to take affect, you MUST DELETE ALL",!,"Form Specification files from EVERY workstation.  Delete EF*.FS files using",!,"the FILE, DELETE FORMSPEC options on the AICS Workstation screen!"
 .S ZTRTN="FSPEC^IBDFESP",ZTDESC="IBD - REGENERATE FORM SPECS",ZTDTH=$H,ZTIO="" D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"Form Spec Regeneration task # "_ZTSK,1:"Form Spec Regeneration failed, edit scanning parameters again!") D HOME^%ZIS
 Q
 ;
CREATE ; -- create entry in new parameters file 357.09
 I $G(^IBD(357.09,1,0))'="" Q
 N DLAYGO
 S DIC="^IBD(357.09,",DINUM=1,X=$P($$SITE^VASITE,"^",2),DIC(0)="L",DLAYGO=357.09 D FILE^DICN Q:+Y<1
 S $P(^IBD(357.09,1,0),"^",5)=1 ; set print inpatients to yes
 S ^IBD(357.09,1,"Q",0)="^357.091A^"
 Q
FSPEC ;Form Specs deleted from file 359.2  FORM SPEC file.
 N IBDIFN
 S IBDIFN=0
 F  S IBDIFN=$O(^IBD(359.2,IBDIFN)) Q:IBDIFN']""  I $D(^IBD(357.95,IBDIFN,0)) D SCAN^IBDFBKS(IBDIFN)
 Q
