SRTPVAN ;BIR/SJA - CHANGE ASSESSMENT TYPE ;02/29/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) Q
 N SRYN,SRSTAT,SRATYPE,SRNTYPE,SRCHG,SRORG,SRVAR
 S SR("RA")=$G(^SRT(SRTPP,"RA")),SRSTAT=$P(SR("RA"),"^"),SRATYPE=$P(SR("RA"),"^",5),SRORG=$P(SR("RA"),"^",2)
 I SRSTAT="T" W !!,"This assessment has already been verified and transmitted.  It cannot be",!,"changed.  If the assessment was transmitted in error, use the option 'Update",!,"an Assessment Transmitted in Error'." D RET Q
 I SRSTAT="V" W !!,"This assessment has already been verified.  It cannot be changed.  If the",!,"assessment was verified in error, use the option 'Update an Assessment Verified",!,"in Error'." D RET Q
CHG W !!,"This assessment has a current status of "_$S(SRSTAT="I":"'Incomplete'",1:"'Complete/Unverified'")
 W !,"The Transplant Assessment Indicator is a "_$S(SRATYPE="V":"VA",SRATYPE="N":"Non-VA",1:"")_" type"
 W !!,"Are you sure that you want to change the indicator to "_$S(SRATYPE="V":"Non-VA",SRATYPE="N":"VA",1:"")_"? NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "Nn"[SRYN W !!,"No action has been taken." D RET S SRSOUT=1 Q
 I "Yy"'[SRYN W !!,"Enter <RET> if this assessment was selected in error and the status should not ",!,"be changed. If you want to change this assessment type, enter 'YES'." G CHG
 I SRATYPE="N" S SRVA="V",SRCHG=1 D START^SRTPNEW I '$D(SRTN) W !!,"No action has been taken." D RET S SRSOUT=1 Q
 I SRATYPE="N" S $P(^SRT(SRTPP,0),"^",3)=SRTN K SRCHG,SRVA
 K DR,DIE,DA S DA=SRTPP,DIE=139.5,DR="185////"_$S(SRATYPE="V":"N",SRATYPE="N":"V",1:"") I SRATYPE="N" S DR=DR_";1////"_SRTPDT
 I SRATYPE="V" S $P(^SRT(SRTPP,0),"^",3)=""
 D ^DIE W !!,"Changing Assessment type..." D CLEAN,RET
 Q
DEL ; delete assessment
 S SRSTAT=$P($G(^SRT(SRTPP,"RA")),"^")
ST W !!,"Are you sure that you want to delete this assessment ? NO//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "Nn"[SRYN W !!,"No action has been taken." S SRSOUT=1 Q
 I "Yy"'[SRYN W !!,"Enter <RET> if this assessment was selected in error and should not be changed.",!,"If you want to delete this assessment, enter 'YES'." G ST
 I SRSTAT="T"!(SRSTAT="C") W !!,"This case has been completed/Transmitted and must remain in the file for your records." D RET Q
 K DR,DIE,DA S DA=SRTPP,DIE=139.5,DR="181///@;182///@;183///@;184///@" D ^DIE W !!,"Deleting Transplant Assessment..."
 K DA,DIK S DA=SRTPP,DIK="^SRT(" D ^DIK K DA,DIK
 Q
CLEAN ; clean up the database after changing the transplant type
 S SRNTYPE=$P(^SRT(SRTPP,"RA"),"^",5),SRVAR=""
 I SRATYPE="V",(SRNTYPE="N") D  ; changed from VA to non-VA
 .S SRVAR=$S(SRORG="LI":"81;82;83;109,110",SRORG="H":"108;153;75;154;115;81;82;90;83;109;110",SRORG="K":"133",1:"")
 I SRATYPE="N",(SRNTYPE="V") D  ; changed from non-VA to VA
 .I SRORG="K" S SRVAR="4;5;147;145;132;146;131;116;117;118;119;192;121;122;123;124;125;126;127" Q
 .I SRORG="LU" S SRVAR="4;5;145;132;146;131;147;116;117;118;119;192;121;122;123;124;125;126;193" Q
 .I SRORG="LI" S SRVAR="4;5;147;116;117;118;119;192;121;122;123;124;125;126;193" Q
 .I SRORG="H" S SRVAR="4;5;76;169;177;173;174;175;176;171;172;179;178;132;41;147;193;170;192;191;190;119;189;148;118;121;122;130;109;110;167;168"
 S DR="",DIE=139.5 F I=1:1:$L(SRVAR) I $P(SRVAR,";",I)'="" S DR=$S(DR]"":DR_";"_$P(SRVAR,";",I)_"///@",1:$P(SRVAR,";",I)_"///@")
 D:DR]"" ^DIE K DR,DA
 Q
RET W !!,"Press <RET> to continue  " R X:DTIME K SRTPP
 Q
