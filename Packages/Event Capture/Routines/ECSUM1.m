ECSUM1 ;BIR/JLP,RHK-Category and Procedure Summary (cont'd) ;Oct 14, 2020@14:27:23
 ;;2.0;EVENT CAPTURE;**4,19,23,33,47,95,100,119,122,126,131,139,152**;8 May 96;Build 19
ALLU ;
 N UCNT,ECDO,ECCO,ECNT,ECD,ECMORE,ECEDN,ECEDNST,ECCPT,ECDNPCE,ECDNDEPT ;119,122,126
 S (ECD,ECMORE,ECNT,ECDO,ECCO)=0,ECPG=$G(ECPG,1),ECSCN=$G(ECSCN,"B")
 F  S ECD=$O(^ECJ("AP",ECL,ECD)) Q:'ECD  D  Q:ECOUT
 .Q:'$D(ECUNITS(ECD))  ;139 Stop if DSS unit isn't in list
 .D SET,CATS I $G(ECPTYP)'="E" D PAGE:'ECOUT&UCNT ;119
END Q:$G(ECPTYP)="E"  I 'ECNT N ECNOCNT S ECNOCNT=1 D HEADER W !!!,"Nothing Found." ;119
 S ECPG=$G(ECPG,1)
 Q
SUM2 ;Prints Categories and Procedures for a DSS Unit
 N UCNT,ECDO,ECCO,ECNT,ECMORE,ECEDN,ECEDNST,ECCPT,ECDNPCE,ECDNDEPT ;119,122,126
 S (ECDO,ECMORE,UCNT,ECNT,ECCO)=0,ECPG=$G(ECPG,1),ECSCN=$G(ECSCN,"B")
 D SET ;126
 I ECC="ALL" D CATS G END
 I 'ECJLP S ECC=0,ECCN="None",ECCO=999
 D PROC
 D END
 Q
SET ;set var
 S (ECDN,ECEDN)=$S($P($G(^ECD(+ECD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),UCNT=0 ;119
 S ECDN=ECDN_" ("_+ECD_")"_$S($P($G(^ECD(+ECD,0)),"^",6):" **Inactive**",1:"") ;131
 S ECEDNST=$S($P($G(^ECD(+ECD,0)),U,6):"INACTIVE",1:"") ;119
 S ECDNPCE=$$GET1^DIQ(724,+ECD,13,"E") ;126 send to pce
 S ECDNDEPT=$$GET1^DIQ(724,+ECD,4,"E") ;126 DSS Dept
 S ECS=+$P($G(^ECD(+ECD,0)),"^",2)
 S ECSN=$S($P($G(^DIC(49,ECS,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 Q
SETC ;set cats
 I ECC=0 S ECCN="None" Q
 S ECCN=$S($P($G(^EC(726,+ECC,0)),"^")]"":$P(^(0),"^"),1:"ZZ #"_ECC_" MISSING DATA")
 S ECCN=ECCN_$S($P($G(^EC(726,+ECC,0)),"^",3):" **Inactive**",1:"")
 S ECMORE=1
 Q
HEADER ;
 W:$E(IOST,1,2)="C-"!(ECPG>1) @IOF
 W !!,?25,$S($G(ECDIS):"DISABLED ",1:""),"CATEGORY AND PROCEDURE SUMMARY",?122,"Page: ",ECPG,! ;131 added conditional print of disabled;152 changed to 132 characters
 W ?27,$S(ECSCN="I":"INACTIVE",ECSCN="A":"ACTIVE",1:" ALL")_" EVENT CODE"
 W " SCREENS",!?25,"Run Date:    ",ECRDT,!?25,"LOCATION:    "_ECLN ;126
 I $G(ECNOCNT) W ! S ECPG=ECPG+1
 I '$G(ECNOCNT) D  ;126
 .W !,?25,"SERVICE:     ",ECSN,!?25,"DSS UNIT:    "_ECDN,!,?25,"SEND STATUS: ",ECDNPCE,!,?25,"DSS DEPT:    ",ECDNDEPT ;126
 .;W !!,"PROC",?7,"PROCEDURE NAME",!,"CODE",?7,"SYNONYM",!,?9,"CLINIC IEN/CLINIC/STOP CODE/CREDIT STOP/CHAR4/MCA LABOR CODE",! S ECPG=ECPG+1 ;126,139
 .W !!,"PROC",?7,"PROCEDURE NAME/SYNONYM",?74,"CLINIC IEN/CLINIC/STOP CODE/CREDIT STOP/",!,?74,"CHAR4/MCA LABOR CODE",! S ECPG=ECPG+1 ;126;139;152
 F I=1:1:132 W "-" ;152 Report Layout changed to 132 characters
 Q
CATS ;
 S ECC="",ECCO=0
 F  S ECC=$O(^ECJ("AP",ECL,ECD,ECC)) Q:ECC=""  D  Q:ECOUT  ;131 Moved calls to dot structure
 .I '$G(ECDIS),ECC,'$P(^ECD(ECD,0),U,11) Q  ;131 If running the category and procedure summary report, and there's a category, and the DSS unit is set to "no categories" then quit
 .D SETC,PROC ;131 Moved calls here from for loop
 S ECMORE=0
 Q
PROC ;
 S ECP=""
 F  S ECP=$O(^ECJ("AP",ECL,ECD,ECC,ECP)) Q:ECP=""  D SETP Q:ECOUT
 S ECMORE=0
 Q
SETP ;set procs
 N ECSC,ECSSC,EC4CHAR,NODE0,ECINDT,ECMCA ;122,126,139
 S ECPSY=+$O(^ECJ("AP",ECL,ECD,ECC,ECP,""))
 S ECINDT=$P($G(^ECJ(ECPSY,0)),"^",2)
 I ECSCN="A",ECINDT'="" Q
 I ECSCN="I",ECINDT="" Q
 I ECD'=ECDO D:$G(ECPTYP)'="E" HEADER S ECDO=ECD ;119
 I ECC'=ECCO D  S ECCO=ECC I ECOUT Q
 .I $G(ECPTYP)="E" Q  ;119
 .W !!,$S($G(ECDIS):"Disabled ",1:""),"Category:  "_ECCN D:$Y+4>IOSL PAGE,HEADER:ECPG,MORE:$D(ECCN) ;122,131 Removed white space from front of line
 S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2),EC4=+$P($G(^("PRO")),"^",4)
 S EC2="" I EC4 S EC2=$S($P($G(^SC(EC4,0)),"^")]"":$P(^(0),"^"),1:"NO ASSOCIATED CLINIC")
 S (ECSC,ECSSC,EC4CHAR,ECMCA)="" ;122,139
 I EC4 D  ;139
 .S NODE0=$G(^ECX(728.44,EC4,0)),ECSC=$P(NODE0,U,2),ECSSC=$S($P(NODE0,U,3)'="":$P(NODE0,U,3),$G(ECPTYP)="E":"",1:"000"),EC4CHAR=$P($G(^ECX(728.441,+$P(NODE0,U,8),0)),U) ;122,139 Get stop code, credit stop code, char4 code
 .S ECMCA=$$GET1^DIQ(728.442,$P(NODE0,U,14),.01) ;139 Get MCA labor code
 S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 I ECFILE="UNKNOWN" S ECPN="UNKNOWN",NATN="UNKNOWN"
 I ECFILE=81 S ECPI=$$CPT^ICPTCOD(+ECP) D
 .S ECPN=$S($P(ECPI,"^",3)]"":$P(ECPI,"^",3),1:"UNKNOWN"),NATN=$S($P(ECPI,"^",2)]"":$P(ECPI,"^",2),1:"NOT LISTED") K ECPI
 I ECFILE=725 S ECPN=$S($P($G(^EC(725,+ECP,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),NATN=$S($P($G(^EC(725,+ECP,0)),"^",2)]"":$P(^(0),"^",2),1:"NOT LISTED")
 I ECFILE=725 S ECCPT=$$CPT^ICPTCOD(+$P($G(^EC(725,+ECP,0)),U,5)),ECCPT=$S($P(ECCPT,U)=-1:"",1:$P(ECCPT,U,2)) ;119
 S ECNT=ECNT+1,UCNT=UCNT+1 ;126
 I $G(ECPTYP)="E" D  Q  ;119
 .D SET ; SET THE DSS UNIT AND UNIT STATUS VARIABLES 119
 .S CNT=CNT+1 ;119
 .S ^TMP($J,"ECRPT",CNT)=$S($P($G(^ECJ(+ECPSY,0)),U,2):"INACTIVE",1:"ACTIVE")_U_ECLN_U_ECSN_U_ECEDN_U_+ECD_U_ECDNDEPT ;119,122,126,131
 .S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_ECDNPCE_U_ECEDNST_U_ECCN_U_$S(ECFILE=81:NATN_U,1:ECCPT_U_NATN)_U_ECPN_U_ECPSYN_U_$S(EC4:EC4,1:"")_U_EC2_U_ECSC_U_ECSSC_U_EC4CHAR_U_ECMCA ;119,122,126,139
 W !,NATN,?7,ECPN,"  (",$S(ECFILE=81:"CPT",1:"EC"),")" ;122,126,139
 ;***152 Begins
 ;I $P($G(^ECJ(+ECPSY,0)),"^",2),ECSCN="B" W ?70,"*INACTIVE*"
 ;W:ECPSYN'="" !,?7,ECPSYN ;139 Moved line here from above
 ;W:EC2]"" !,?9,EC4_"/"_EC2_"/"_ECSC_"/"_ECSSC_"/"_EC4CHAR_"/"_ECMCA ;122,126,139
 W:ECPSYN'="" "/",ECPSYN  ;152 Moved Synonym to same line with Procedure Name
 W:EC2]"" ?74,EC4_"/"_EC2_"/"_ECSC_"/"_ECSSC_"/"_EC4CHAR_"/"_ECMCA ;122,126,139,152 - Report Layout changed to 132 chars.
 I $P($G(^ECJ(+ECPSY,0)),"^",2),ECSCN="B" W ?122,"*INACTIVE*"
 ;*** 152 Ends
 D:($Y+3)>IOSL PAGE,HEADER:ECPG,MORE:$D(ECCN) Q:ECOUT
 Q
PAGE ;
 N SS,JJ
 I $D(ECPG),$E(IOST,1,2)="C-" D
 . S SS=22-$Y F JJ=1:1:SS W !
 . S DIR(0)="E" W ! D ^DIR K DIR I 'Y S ECOUT=1
 Q
MORE I ECMORE W !!,$S($G(ECDIS):"Disabled ",1:""),"Category:  "_ECCN ;122,131 Removed white space from front of line
 Q
