DVBAB3 ;ALB/KLB - CAPRI Amis Report ;05/01/00
 ;;2.7;AMIE;**35,42,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Input:  MSG    - Array with report contents/error message 
 ;                 (By Ref)
 ;        BDATE  - Beginning date in a date range to use
 ;                 for retrieving results for the report.
 ;        EDATE  - Ending date in a date range to use for
 ;                 retrieving results for the report.
 ;        RONUMB - Regional Office number '^' Division to 
 ;                 filter result set on (Both Optional)
 ;        SBULL  - A Y/N value indicating whether a bulletin
 ;                 (Report Contents) will be generated when 
 ;                 processing completes.
 ;        DUZ    - IEN of the individual in File #200 to send
 ;                 bulletin to.
 ;      DVBAPRTY - Priority of Exam code that indicates which
 ;                 priorities to filter on.
 ;                    AO  - Agent Orange (A0)
 ;                    BDD - Benefits Delivery at Discharge (BDD)
 ;                          Quick Start (QS)
 ;                    DES - DES Claimed Condition by Service Memeber (DCS)
 ;                          DES Fit For Duty (DFD)
 ;                    ALL - All others (Excludes AO,BDD,DCS,DFD,QS)
STRT(MSG,BDATE,EDATE,RONUMB,SBULL,DUZ,DVBAPRTY) ;
 S BDATE=BDATE+".0000"
 S EDATE=EDATE+".2359"
 S DVBDIV=$P($G(RONUMB),"^",2)
 S RONUMB=$P($G(RONUMB),"^",1)
 S CNT=0
 K ^TMP($J)
 S RONUM=0
SETUP S UPDATE="N",PREVMO=$P(^DVB(396.1,1,0),U,11)
 I '$D(DT) S DT=$$DT^XLFDT
 S DVBCDT(0)=$$FMTE^XLFDT(DT,"5DZ")
INITCNTR ;initialize counter arrays
 N DVBAEXMP,DVBAP
 S DVBAEXMP=$S($G(DVBAPRTY)["BDD":"BDD,QS",($G(DVBAPRTY)["DES"):"DCS,DFD",($G(DVBAPRTY)["AO"):"AO",1:"ALL")
 F JI="3DAYSCH","30DAYEX","PENDADJ" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 F JI="INSUFF","SENT","INCOMPLETE","DAYS","COMPLETED" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 F JI="P90","P121","P151","P181","P365","P366" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 S ^TMP($J,CNT)="REGIONAL OFFICE 2507 AMIS REPORT",CNT=CNT+1
 ;
EN ;
 N DVBAERR
 S ^TMP($J,CNT)="",CNT=CNT+1,^TMP($J,CNT)="",CNT=CNT+1,^TMP($J,CNT)="",CNT=CNT+1
 S:'$D(EDATE) MSG(1)="Please enter a ending date"
 G:'$D(EDATE) EXIT
 S:'$D(BDATE) MSG(1)="Please enter a starting date"
 G:'$D(BDATE) EXIT
 S BDATE1=BDATE-.1,EDATE1=EDATE+.5
 S:EDATE<BDATE MSG(1)="Beginning date must be before ending date"
 G:EDATE<BDATE EXIT
 I (RONUMB]"") D  G:DVBAERR EXIT
 .S DVBAERR=0
 .S RONUM=$O(^DIC(4,"B",RONUMB,RONUM))
 .I RONUM="" S MSG(1)="Invalid Regional Office number",DVBAERR=1 Q
 .S:'$D(^DIC(4,RONUM,99)) MSG(1)="Invalid Regional Office number",DVBAERR=1
 .Q:'$D(^DIC(4,RONUM,99))
 .S RONUM=$S($D(^DIC(4,RONUM,99)):$P(^(99),U,1),1:"000")
 .S RONAME=RONUMB
 D:(RONUMB']"")
 .S (RONUM,RONAME)="ALL"
 ;validate Priority of Exam (Null Allowed and will default to ALL)
 I ((";AO;BDD;DES;ALL;;")'[(";"_$G(DVBAPRTY)_";")) D  G EXIT
 .S MSG(1)="Invalid Priority of Exam Code"
 S:'$D(SBULL) MSG(1)="You need to say if you want a Bulletin or not"
 G:'$D(SBULL) EXIT
 I SBULL="Y" D BULL^DVBAB2
 ;
 D GO^DVBAB2
EXIT K BDATE,BDATE1,DVBCDT,EDATE,CNT,EDATE1,JI,PREVMO,RONAME,RONUM,RONUMB,SBULL,TOT,UPDATE,X,Y,^TMP($J)
 Q
INIT(Y) ;
 ; INITS MAILMAN VARIABLES
 D INIT^XMVVITAE
 S Y=XMV("NETNAME")_"^"
 Q
