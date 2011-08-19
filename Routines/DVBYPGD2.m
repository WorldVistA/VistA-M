DVBYPGD2 ;ALB/CMM; New Disability Codes file 31 ;9/25/95
 ;;V4.0;HINQ;**27**;03/25/92
 ;
EN ;start of routine
 N LP,LP1,JCNT,CODE,TEXT
 S JCNT=0
 W !!,"Adding to the Disability Condition file.",!!
 F LP=1:1 S LP1=$T(TXT+LP) Q:LP1=""  DO
 .S CODE=$P(LP1,";;",2)
 .S TEXT=$P(CODE,";",2)
 .S CODE=$P(CODE,";",1)
 .I $L(TEXT)>45 S TEXT=$E(TEXT,1,45)
 .K JSTOP
 .D CHK
 .I $D(JSTOP) Q
 .S DIC="^DIC(31,",DIC("DR")="2///"_CODE,X=TEXT,DLAYGO=31,DIC(0)="L"
 .K DD,DO
 .D FILE^DICN
 .K DO,DD,DLAYGO
 .I +Y>0 S JCNT=JCNT+1 W "."
 .I +Y<0 W !,"Not able to add Disability Condition "_CODE_"."
 W !!!,"The Disability Condition file (31) update has finished.  ",!,"     "_JCNT_" disability codes were added."
 K DIC,JSTOP,DLAYGO,X,Y,DIE,DR,DA
 Q
 ;
CHK ;checks for the existance of the codes in the c cross ref.
 I $D(^DIC(31,"C",CODE)) S JSTOP=1
 I $D(^DIC(31,"B",$E(TEXT,1,30))) S JSTOP=1
 I $D(JSTOP) W !,"Disability Condition "_CODE_" was not added.  Entry already exists."
 Q
 ;
TXT ;new exams to be added.
 ;;6354;CHRONIC FATIGUE SYNDROME (CFS)
 ;;7628;BENIGN NEOPLASMS OF THE GYNECOLOGICAL SYSTEM OR BREAST
 ;;7629;ENDOMETRIOSIS
