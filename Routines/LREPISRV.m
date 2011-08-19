LREPISRV ;DALOI/RLM-EPI data server ;8/2/2000
 ;;5.2;LAB SERVICE;**260,281**;Sep 27, 1994
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^ICD9( supported by IA #10082
 ; Reference to ^ORD(101 supported by IA #872
START ;
 K ^TMP($J,"LREPDATA")
 S LREPST=$P($$SITE^VASITE,"^",2)
 ;Determine station number
 S X=XQSUB X ^%ZOSF("UPPERCASE") S LREPSUB=Y
 S ^TMP($J,"LREPDATA",1)=LREPSUB_" triggered at "_LREPST_" by "_XMFROM_" on "_XQDATE
 ;The first line of the message tells who requested the action and when
 S ^TMP($J,"LREPDATA",2)="No"_$S(LREPSUB["REPORT":" report generated",1:"thing done")_" at "_LREPST
 ;The second line tells when the server is activated and no data can be gathered from the MailMan message.
 S LREPLNT=1
 I LREPSUB["REPORT" G REPORT
 ;If the subject contains "REPORT" send a report
EXIT ;If all went well, report that too.
 S %H=$H D YMD^%DTC S XMDUN="EPI SYSTEM",XMDUZ=".5",XMSUB=LREPST_" EPI ("_X_%_")",XMTEXT="^TMP($J,""LREPDATA"","
 S XMY("G.EPI-SITE@CINCINNATI.VA.GOV")=""
 ;S XMY("ANZALDUA,CAROL@VAHVSS.FO-ALBANY.MED.VA.GOV")="" ;,XMY("CAROL.ANZALDUA@MED.VA.GOV")=""
 D ^XMD
 ;Mail the errors and successes back to the EPI group at Cincinnati.
 K ^TMP($J,"LREPDATA")
 K %,%DT,%H,D,DIC,X,XMDUN,XMDUZ,XMER,XMFROM,XMREC,XMRG,XMSUB,XMTEXT,XMY,XMZ,XQDATE,XQSUB,Y,LREPA,LREPB,LREPDA,LREPDA1,LREPDATA,LREPDFN,LREPDM,LREPDOC
 K LREPDOM,LREPDTA,LREPED,LREPER,LREPLNT,LREPNM,LREPPT,LREPSD1,LREPSDT,LREPSSN,LREPST,LREPSUB,LREPTC,YSPR,LREPWB,LREPX,ZTQUEUED,ZTSK
 K LRICD9,LRA,LRCOND,LRDATA,LRFILL,LRI,LRPATH,LRTEST
 Q
 ;F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
REPORT ;send report
 S $P(LRFILL," ",256)=""
 S LRA=0 F  S LRA=$O(^LAB(69.5,LRA)) Q:'LRA  D
  . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
  . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="Pathogen                       Ref# Cy LD Protocol FPTF Active"
  . S LRPATH=$G(^LAB(69.5,LRA,0))
  . I LRPATH="" S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="IEN # "_LRA_" damaged. (NULL)" Q
  . I '$P(LRPATH,"^",7) S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="IEN # "_LRA_" damaged. (No Protocol)" Q
  . S LRDATA=$P(LRPATH,"^")_$E(LRFILL,$L($P(LRPATH,"^")),30)_$J($P(LRPATH,"^",9),4)_$J($P(LRPATH,"^",5),3)_$J($P(LRPATH,"^",3),3)_$J($P(^ORD(101,$P(LRPATH,"^",7),0),"^"),9)_$J($P(LRPATH,"^",8),4)_$J($P(LRPATH,"^",2),4)
  . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)=LRDATA
  . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="   Lab Test                                          Indicator      Value"
LTEST  . S LRI=0 F  S LRI=$O(^LAB(69.5,LRA,1,LRI)) Q:'LRI  D
  . . S LRTEST=$G(^LAB(69.5,LRA,1,LRI,0))
  . . I $P(LRTEST,"^")="" S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="IEN # "_LRA_" damaged. (No Test)" Q
  . . S LRCOND=$P(LRTEST,"^",2),LRCOND=$S(LRCOND=1:"Ref. Range",LRCOND=2:"Contains",LRCOND=3:"Greater Than",LRCOND=4:"Less Than",LRCOND=5:"Equal To",1:"Unknown")
  . . S LRDATA=$P($G(^LAB(60,$P(LRTEST,"^"),0),0),"^")_$E(LRFILL,$L($P($G(^LAB(60,$P(LRTEST,"^"),0),0),"^")),40)_$J(LRCOND,20)_$J($P(LRTEST,"^",3),10)
  . . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)=LRDATA
  . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="   Etiology"
ETIO  . S LRI=0 F  S LRI=$O(^LAB(69.5,LRA,2,LRI)) Q:'LRI  D
  . . S LRTEST=$G(^LAB(69.5,LRA,2,LRI,0))
  . . I $P(LRTEST,"^")="" S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="IEN # "_LRA_" damaged. (No Etiology)" Q
  . . S LRCOND=$P(LRTEST,"^",2),LRCOND=$S(LRCOND=1:"Ref. Range",LRCOND=2:"Contains",LRCOND=3:"Greater Than",LRCOND=4:"Less Than",LRCOND=5:"Equal To",1:"Unknown")
  . . S LRDATA=$P($G(^LAB(61.2,$P(LRTEST,"^"),0),0),"^")
  . . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)=LRDATA
 .  S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="    ICD9"
ICD9  . S LRI=0 F  S LRI=$O(^LAB(69.5,LRA,3,LRI)) Q:'LRI  D
  . . S LRICD9=$G(^LAB(69.5,LRA,3,LRI,0))
  . . I $P(LRICD9,"^")="" S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="IEN # "_LRA_" damaged. (No ICD9)" Q
  . . S LRDATA=$P($G(^ICD9($P(LRICD9,"^"),0),0),"^")
  . . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)=LRDATA
  . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="      Microbial Susceptibility                      Indicator       Value"
MICROB  . S LRI=0 F  S LRI=$O(^LAB(69.5,LRA,4,LRI)) Q:'LRI  D
  . . S LRTEST=$G(^LAB(69.5,LRA,4,LRI,0))
  . . I $P(LRTEST,"^")="" S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)="IEN # "_LRA_" damaged. (No Microbial Susceptibility)" Q
  . . S LRCOND=$P(LRTEST,"^",2),LRCOND=$S(LRCOND=1:"Contains",LRCOND=2:"Greater Than",LRCOND=3:"Less Than",LRCOND=4:"Equal To",1:"Unknown")
  . . S LRDATA="      "_$P($G(^LAB(62.06,$P(LRTEST,"^"),0),0),"^")_$E(LRFILL,$L($P($G(^LAB(62.06,$P(LRTEST,"^"),0),0),"^")),33)_$J(LRCOND,20)_$J($P(LRTEST,"^",3),11)
  . . S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)=LRDATA
 G EXIT
OUT S LREPLNT=$G(LREPLNT)+1,^TMP($J,"LREPDATA",LREPLNT)=XMRG_LREPER_LREPST Q
 ;Build the text for the return message here.
ZEOR ;LREPISRV
