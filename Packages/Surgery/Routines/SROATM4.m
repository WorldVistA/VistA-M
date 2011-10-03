SROATM4 ;BIR/MAM - CREATE MESSAGES ;03/22/06
 ;;3.0; Surgery ;**27,38,62,125,153**;24 Jun 93;Build 11
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 S SHEMP=3,SRAMNUM=0 F I=0:0 S SRAMNUM=$O(^TMP("SRA",$J,SRAMNUM)) Q:'SRAMNUM  D MSG
STATUS ; update status
 S (SRAMNUM,SRASS)=0
 F  S SRAMNUM=$O(^TMP("SRA",$J,SRAMNUM)) Q:'SRAMNUM  S SRACNT=0 F  S SRACNT=$O(^TMP("SRA",$J,SRAMNUM,SRACNT)) Q:'SRACNT  S CURLEY=$E(^TMP("SRA",$J,SRAMNUM,SRACNT,0),12,14),CURLEY=$P(CURLEY," ",3) I +CURLEY=1 D UPDATE
 I 'SRASS G END
 S X=$$ACTIVE^XUSER(DUZ) I '+X S XMDUZ=.5
 S XMSUB="RISK ASSESSMENT TRANSMISSION COMPLETE"
 S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 D NOW^%DTC S Y=% D D^DIQ S SRATIME=$E($P(Y,"@",2),1,5)
 S ^TMP("SRAMSG",$J,1,0)="The Surgery Risk Assessment Transmission was completed at "_SRATIME_".  A total",^TMP("SRAMSG",$J,2,0)="of "_SRASS_$S(SRASS=1:" assessment was ",1:" assessments were ")_"sent."
 S ^TMP("SRAMSG",$J,3,0)="  "
 S XMTEXT="^TMP(""SRAMSG"",$J," N I D ^XMD
END K ^TMP("SRA",$J),^TMP("SRAMSG",$J),SRTN D ^SRSKILL
 Q
MSG ; send message to G.SURGERY RISK at Hines
 S ISC=0,NAME=$G(^XMB("NETNAME")) I NAME["FORUM"!(NAME["ISC-")!($E(NAME,1,3)="ISC")!(NAME["ISC.")!(NAME["TST")!(NAME["FO-") S ISC=1
 I ISC S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 I 'ISC S XMY("G.RISK ASSESSMENT@FO-HINES.MED.VA.GOV")=""
 S SRATDATE=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S X=$$ACTIVE^XUSER(DUZ) I '+X S XMDUZ=.5
 S XMSUB=$P($$SITE^SROVAR,"^",2)_": NSQIP ("_SRAMNUM_" OF "_SRATOTM_")  "_SRATDATE,XMTEXT="^TMP(""SRA"",$J,"_SRAMNUM_"," N I D ^XMD
 Q
UPDATE ; Updating is done by the server SROASITE after acknowledgement message is received at the site from the National Database
 ; Notification message of assessments transmitted is built below
 S MM=$E(^TMP("SRA",$J,SRAMNUM,SRACNT,0),5,11) F X=1:1 S EMILY=$P(MM," ",X) Q:EMILY
 S SRASS=SRASS+1
 S DFN=$P(^SRF(EMILY,0),"^") D DEM^VADPT S SRANAME=$P(VADM(1),"^") K VADM S X=$P(^SRF(EMILY,0),"^",9),SRADT=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S SHEMP=SHEMP+1,^TMP("SRAMSG",$J,SHEMP,0)="ASSESSMENT: "_EMILY_"   "_$J(SRANAME,20)_"        OPERATION DATE: "_SRADT
 Q
