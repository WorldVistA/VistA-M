SRSDT ;B'HAM ISC/MAM - CHANGE DATE OF OPERATION REQUEST; [ 06/14/01  9:54 AM ]
 ;;3.0; Surgery ;**3,16,34,67,77,103,114,100**;24 Jun 93
CHANGE ; change date of request
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) Q:'SRLCK
 D ^SRSTCH I SRSOUT Q
 W !! S CON=0,SRDT=SRSDATE,%DT="AEFX",%DT("A")="Change to which Date ? " D ^%DT K %DT Q:Y<1  S SRSDATE=+Y
 I SRSDATE<DT W !!,"Requests cannot be made for past dates.  Please select another date." K Y S SRSDATE=SRDT G CHANGE
 K SRLATE S SRDTCH=1 D LATE^SRSREQ I $D(SRLATE) G CHANGE
NEWDT I SRSDATE=SRDT Q
 K ^SRF("AC",SRDT,SRTN)
 K DR,DIE,DA S DIE=130,DA=SRTN,DR=".09////"_SRSDATE D ^DIE K DR
 K DR,X S SRSREQ=1,SRSATT=$S($D(^SRF(SRTN,.1)):$P(^(.1),"^",13),1:""),SRTS=$P(^SRF(SRTN,0),"^",4),DIE=130,DA=SRTN,DR=".04////"_SRTS_";.164////"_SRSATT D ^DIE K DR D ^SROXRET
 S SRINVDT=9999999.999999-SRDT K ^SRF("ADT",DFN,SRINVDT,SRTN),SRINVDT
 N SREQ D NOW^%DTC S SREQ(130,SRTN_",",1.098)=+$E(%,1,12),SREQ(130,SRTN_",",1.099)=DUZ D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 I SRTS K ^SRF("ASP",SRTS,SRDT,SRTN)
 S SROERR=SRTN K SRTX D ^SROERR0
 I CON=0,$D(^SRF(SRTN,"CON")),$P(^("CON"),"^")'="" D CC I SRBOTH=1 S SRTN=$P(^SRF(SRTN,"CON"),"^") Q:SRTN=""  S CON=1 G NEWDT
 S Y=SRSDATE D D^DIQ S SRSDATE=Y W !!,"The request for "_SRNM_" has been changed to "_SRSDATE_"."
 D UNLOCK^SROUTL(SRTN)
 Q
CC ; concurrent case check
 W !!,"There is a concurrent case associated with this operation.  Do you want to",!,"change the date of it also ?  YES//  " R SRBOTH:DTIME I '$T S SRBOTH="Y"
 I SRBOTH="^" W !!,"Please answer 'YES' or 'NO'.  A '^' is not allowed. " G CC
 S:SRBOTH="" SRBOTH="Y" S SRBOTH=$E(SRBOTH) I "YyNn"'[SRBOTH W !!,"Enter RETURN if these cases will remain concurrent, or 'NO' if they will no",!,"longer be associated together." G CC
 I SRBOTH["Y" S SRBOTH=1 Q
 S DIE=130,DA=$P(^SRF(SRTN,"CON"),"^"),DR="35///@" D ^DIE,UNLOCK^SROUTL(DA)
 S DA=SRTN D ^DIE
 Q
