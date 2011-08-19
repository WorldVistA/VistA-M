ECRRPT ;ALB/JAM - Event Capture Report RPC Broker ; 10 JUL 2008
 ;;2.0; EVENT CAPTURE ;**25,32,41,56,61,82,94,95,108**;8 May 96;Build 3
 ;
REQCHK(ECV) ;Required data check
 N I,C
 S C=1
 F I=1:1:$L(ECV,U) I '$D(@$P(ECV,U,I)) D
 . S ^TMP("ECMSG",$J,C)="0^Required data missing "_$P(ECV,U,I)
 . S C=C+1,ECERR=1
 Q
DATECHK(ECSD,ECED) ;Check human format date and converts to FileMan format
 ;    Input  ECSD  - Start Date (ex. 10/9/01)
 ;           ECED  - End Date
 N ECI,X,Y
 S %DT="X" F ECI="ECSD","ECED" S X=@ECI D ^%DT S @ECI=Y
 S ECSD=$S(ECSD=-1:DT,1:ECSD),ECED=$S(ECED=-1:DT,1:ECED)
 S ECDATE=$$FMTE^XLFDT(ECSD)_"^"_$$FMTE^XLFDT(ECED)
 Q
QUEUE ;Queues report to printer
 N ZTIO,ZTDESC,ZTRTN,ZTDTH,ZTSAVE,%ZIS,I,IOP,POP
 S XNAM=$P($G(^%ZIS(1,ECDEV,0)),U,2)
 S IOP="Q;`"_ECDEV,%ZIS="Q" D ^%ZIS I POP D  Q
 . ;S IOP="Q;"_XNAM,%ZIS="Q" D ^%ZIS I POP D  Q
 . S ^TMP("ECMSG",$J,1)="0^Device selection unsuccessful"
 S ZTIO=ION,ZTDESC=ECDESC,ZTRTN=ECROU
 S ZTDTH=$$FMTH^XLFDT(ECQDT)
 ;D NOW^%DTC S ZTDTH=$S(%'<ECQDT:%+.0002,1:ECQDT)
 F I=1:1:$L(ECV,U) I $D(@$P(ECV,U,I)) S ZTSAVE($P(ECV,U,I))=""
 M ZTSAVE=ECSAVE
 D ^%ZTLOAD,HOME^%ZIS,^%ZISC ;K IO("Q")
 I $D(ZTSK) S ^TMP("ECMSG",$J)="1^Report queued. Task #"_ZTSK Q
 S ^TMP("ECMSG",$J)="0^Task Rejected"
 Q
 ;
ECPAT ;Patient Summary Report for RPC Call
 ;     Variables passed in
 ;       ECDFN  - Patient IEN for file #2
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECRY   - Print Procedure Reason (optional)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECDATE,ECPAT,ECV,DIC,X,Y,ECROU,ECDESC
 S ECV="ECDFN^ECSD^ECED" D REQCHK(ECV) I ECERR Q
 S DIC=2,DIC(0)="QNMZX",X=ECDFN D ^DIC Q:Y<0  S ECPAT=$P(Y,U,2)
 ;EC*2.0*108 - Convert Date/Time to Date only
 S ECSD=$P(ECSD,"."),ECED=$P(ECED,".")
 D DATECHK(.ECSD,.ECED)
 S ECSD=ECSD-.0001,ECED=ECED+.9999
 I $E($G(ECRY))'="Y" K ECRY
 I ECPTYP="P" D  Q
 . S ECV="ECDFN^ECPAT^ECDATE^ECSD^ECED^ECRY",ECROU="SUM^ECPAT"
 . S ECDESC="EVENT CAPTURE PATIENT SUMMARY"
 . D QUEUE
 D SUM^ECPAT
 Q
ECRDSSU ;DSS Unit Workload Summary Report
 ;     Variables passed in
 ;       ECL    - Location to report (1 or ALL)
 ;       ECD    - DSS Unit to report (1, some or ALL)
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECDUZ  - User IEN from file (#200)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECLOC,ECDSSU,ECV,ECI,ECSTDT,ECENDDT,ECKEY,ECROU,ECSAVE,ECDESC,ECNT
 N ECDATE,ECX,DIC,X,Y
 S ECV="ECL^ECD0^ECSD^ECED^ECDUZ" D REQCHK(ECV) I ECERR Q
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . I ECL="ALL" D LOCARRY^ECRUTL Q
 . S DIC=4,DIC(0)="QNZX",X=ECL D ^DIC Q:Y<0  S ECLOC(1)=+Y_"^"_$P(Y,U,2)
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU^ECRUTL
 . S (ECI,ECNT)=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNZX",X=@ECX D ^DIC I Y<0 Q
 . . S ECNT=ECNT+1,ECDSSU(ECNT)=Y
 D DATECHK(.ECSD,.ECED)
 S ECSTDT=ECSD-.0001,ECENDDT=ECED+.9999
 I ECPTYP="P" D  Q
 . S ECV="ECDATE^ECSTDT^ECENDDT",ECROU="STRPT^ECRDSSU"
 . S (ECSAVE("ECLOC("),ECSAVE("ECDSSU("))=""
 . S ECDESC="DSS UNIT WORKLOAD SUMMARY REPORT"
 . D QUEUE
 D STRPT^ECRDSSU
 Q
PROSUM ;Provider (1-3) Summary Report for RPC Call
 ;     Variables passed in
 ;       ECU    - Provider IEN for file #200
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECRY   - Print Procedure Reason (optional)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDATE,ECUN,ECROU,ECDESC,DIC,X,Y
 S ECV="ECU^ECSD^ECED" D REQCHK(ECV) I ECERR Q
 S DIC=200,DIC(0)="QNZX",X=ECU D ^DIC D:Y<0  Q:Y<0  S ECUN=$P(Y,U,2)
 . S ^TMP("ECMSG",$J)="1^Invalid Provider."
 D DATECHK(.ECSD,.ECED)
 I ECRY'="Y" K ECRY
 I ECPTYP="P" D  Q
 . S ECV="ECU^ECUN^ECDATE^ECSD^ECED^ECRY"
 . S ECROU="EN^ECPRSUM1",ECDESC="Event Capture Provider Summary"
 . D QUEUE
 D EN^ECPRSUM1
 Q
ECPROV ;Provider Summary Report for RPC Call
 ;     Variables passed in
 ;       ECL    - Location to report (1 or ALL)
 ;       ECD    - DSS Unit to report (1 or ALL)
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECRY   - Print Procedure Reason (optional)
 ;       ECDUZ  - User DUZ (ien in #200)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDN,ECDATE,ECLN,ECSAVE,ECDESC,ECROU,DIC,X,Y,CNT,UNIT
 S ECDN="ALL",ECV="ECL^ECD^ECSD^ECED^ECDUZ" D REQCHK(ECV) I ECERR Q
 I ECL'="ALL" D  I ECERR Q
 . ;The line below was changed by VMP for NOIS ANN-1003-42305
 . S DIC=4,DIC(0)="QNZX",X=ECL D ^DIC D:Y<0  Q:Y<0  S ECLN=$P(Y,U,2)
 . . S ^TMP("ECMSG",$J)="1^Invalid Location.",ECERR=1
 I ECD'="ALL" K DIC D  I ECERR Q
 . S DIC=724,DIC(0)="QNMZX",X=ECD D ^DIC D:Y<0  Q:Y<0  S ECDN=$P(Y,U,2)
 . . S ^TMP("ECMSG",$J)="1^Invalid Location.",ECERR=1
 I ECD="ALL",'$D(^XUSEC("ECALLU",ECDUZ)) D
 . S (ECD,ECDN)="SOME",(X,CNT)=0
 . F  S X=$O(^VA(200,ECDUZ,"EC",X)) Q:'X  D
 . . S CNT=CNT+1,UNIT=$P(^VA(200,ECDUZ,"EC",X,0),"^")
 . . S UNIT(CNT)=UNIT_"^"_$P(^ECD(UNIT,0),"^")
 I $E($G(ECRY))'="Y" K ECRY
 D DATECHK(.ECSD,.ECED)
 S ECSD=ECSD-.0001,ECED=ECED+.9999 S:'$D(UNIT) UNIT=""
 I ECPTYP="P" D  Q
 . S ECV="ECDATE^ECSD^ECED^ECRY",ECROU="START^ECPROV2"
 . S (ECSAVE("ECL*"),ECSAVE("ECD*"),ECSAVE("UNIT*"))=""
 . S ECDESC="EVENT CAPTURE PROVIDER SUMMARY"
 . D QUEUE
 U IO D START^ECPROV2
 Q
ECOSSUM ;Ordering Section Summary Report for RPC Call
 ;     Variables passed in
 ;       ECOS   - Ordering Section
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECL    - Location to report (1 or ALL)
 ;       ECD    - DSS Unit to report (1, some or ALL)
 ;       ECDUZ  - User ien (#200)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECI,ECOSN,ECLOC,ECDSSU,ECDATE,ECNT,ECSAVE,ECROU,ECDESC,DIC,X,Y
 S ECV="ECOS^ECL^ECD0^ECSD^ECED^ECDUZ" D REQCHK(ECV) I ECERR Q
 S DIC=723,DIC(0)="QNMZX",X=ECOS D ^DIC D:Y<0  Q:Y<0  S ECOSN=$P(Y,U,2)
 . S ^TMP("ECMSG",$J)="1^Invalid Ordering Section.",ECERR=1
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location.",ECERR=1 Q
 . K DIC I ECL="ALL" D LOCARRY^ECRUTL Q
 . S DIC=4,DIC(0)="QNZX",X=ECL D ^DIC Q:Y<0  S ECLOC(1)=+Y_"^"_$P(Y,U,2)
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU^ECRUTL
 . S (ECI,ECNT)=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNMZX",X=@ECX D ^DIC I Y<0 Q
 . . S ECNT=ECNT+1,ECDSSU(ECNT)=Y
 D DATECHK(.ECSD,.ECED)
 S ECSD=ECSD-.0001,ECED=ECED+.9999
 I ECPTYP="P" D  Q
 . S ECV="ECOS^ECSD^ECED^ECOSN",ECROU="START^ECOSSUM"
 . S (ECSAVE("ECLOC("),ECSAVE("ECDSSU("))=""
 . S ECDESC="EC Ordering Section Summary"
 . D QUEUE
 D START^ECOSSUM
 Q
ECPCER ;PCE Data Summary Report for RPC Call
 ;     Variables passed in
 ;       ECDFN  - Patient IEN for file #2
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDATE,ECPAT,ECROU,ECDESC,X,DIC,Y
 S ECV="ECDFN^ECSD^ECED" D REQCHK(ECV) I ECERR Q
 S DIC=2,DIC(0)="QNMZX",X=ECDFN D ^DIC D:Y<0  Q:Y<0  S ECPAT=$P(Y,U,2)
 . S ^TMP("ECMSG",$J)="1^Invalid Provider."
 D DATECHK(.ECSD,.ECED)
 S ECSD=ECSD-.0001,ECED=ECED+.9999
 I ECPTYP="P" D  Q
 . S ECV="ECDFN^ECPAT^ECDATE^ECSD^ECED",ECROU="SUM^ECPCER"
 . S ECDESC="ECS/PCE PATIENT SUMMARY"
 . D QUEUE
 D SUM^ECPCER
 Q
ECRDSSA ;DSS Unit Activity Report
 ;     Variables passed in
 ;       ECL    - Location to report (1 or ALL)
 ;       ECD0   - DSS Unit to report (1, some or ALL)
 ;       ECSORT  - Sort type(P,S or R)
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECDUZ  - User IEN from file (#200)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECLOC,ECDSSU,ECV,ECI,ECSTDT,ECENDDT,ECKEY,ECROU,ECSAVE,ECDESC,ECNT
 N ECDATE,ECX,DIC,X,Y
 S ECV="ECL^ECD0^ECSORT^ECSD^ECED^ECDUZ" D REQCHK(ECV) I ECERR Q
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . I ECL="ALL" D LOCARRY^ECRUTL Q
 . S DIC=4,DIC(0)="QNZX",X=ECL D ^DIC Q:Y<0  S ECLOC(1)=+Y_"^"_$P(Y,U,2)
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU^ECRUTL
 . S (ECI,ECNT)=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNZX",X=@ECX D ^DIC I Y<0 Q
 . . S ECNT=ECNT+1,ECDSSU(ECNT)=Y
 D DATECHK(.ECSD,.ECED)
 S ECSTDT=ECSD-.0001,ECENDDT=ECED+.9999
 I ECPTYP="P" D  Q
 . S ECV="ECSORT^ECDATE^ECSTDT^ECENDDT",ECROU="STRPT^ECRDSSA"
 . S (ECSAVE("ECLOC("),ECSAVE("ECDSSU("))=""
 . S ECDESC="DSS UNIT ACTIVITY REPORT"
 . D QUEUE
 D STRPT^ECRDSSA
 Q
