ANRVAP ;MUSK/MFW,HCIOFO/NDH - VIST AMIS PRINT ; 30 Jan 98 / 12:10 PM
 ;;4.0; Visual Impairment Service Team ;**2**;12 Jun 98
 S ANRP=0,QFLG=0 U IO D HED G AMIS
HED I $E(IOST)="C",ANRP>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 S ANRP=ANRP+1
 W:$Y!($E(IOST)="C")&('$D(ANRVFILE)) @IOF Q:(ANRP>1)&($E(IOST)="C")
 W !!!,?80-$L("VISUAL IMPAIRMENT SERVICE TEAM (VIST)")/2,"VISUAL IMPAIRMENT SERVICE TEAM (VIST)",!?80-$L("AMIS CODE SHEET")/2,"AMIS CODE SHEET"
 W !!,?15,"FACILITY:  ",^DD("SITE"),?70,"Page ",ANRP
 S Y=ANQBD X ^DD("DD") W !!,?15,"Period Beginning:  ",Y
 S Y=ANQED X ^DD("DD") W !,?15,"Period Ending:     ",Y,!!!,?55,"FIELD",!,?55,"CODE",?65,"TOTAL" Q
AMIS W !!,?15,$P($T(DESC+1),";",4),?56,"001",?65,^TMP("ANRV",$J,1)
 W !,?15,"NON VIST ELIGIBLE VETERANS"
 W !,?20,$P($T(DESC+2),";",4),?56,"002",?65,^TMP("ANRV",$J,2)
 W !,?20,$P($T(DESC+3),";",4),?56,"003",?65,^TMP("ANRV",$J,3)
 W !,?64,"______"
 W !,?65,(^TMP("ANRV",$J,1)+^TMP("ANRV",$J,2)+^TMP("ANRV",$J,3)) D:$Y+8>IOSL HED Q:QFLG
VISACT W !!,?15,"VISUAL ACTIVITY"
 W !,?20,$P($T(DESC+4),";",4),?56,"004",?65,^TMP("ANRV",$J,4)
 W !,?20,$P($T(DESC+5),";",4),?56,"005",?65,^TMP("ANRV",$J,5)
 W !,?20,$P($T(DESC+6),";",4),?56,"006",?65,^TMP("ANRV",$J,6)
 W !,?20,$P($T(DESC+7),";",4),?56,"007",?65,^TMP("ANRV",$J,7)
 W !,?20,$P($T(DESC+8),";",4),?56,"008",?65,^TMP("ANRV",$J,8)
 W !,?64,"______",!,?65,(^TMP("ANRV",$J,4)+^TMP("ANRV",$J,5)+^TMP("ANRV",$J,6)+^TMP("ANRV",$J,7)+^TMP("ANRV",$J,8)) D:$Y+10>IOSL HED Q:QFLG
MAJACT W !!,?15,"MAJOR ACTIVITY"
 W !,?20,$P($T(DESC+9),";",4),?56,"009",?65,^TMP("ANRV",$J,9)
 W !,?20,$P($T(DESC+10),";",4),?56,"010",?65,^TMP("ANRV",$J,10)
 W !,?20,$P($T(DESC+11),";",4),?56,"011",?65,^TMP("ANRV",$J,11)
 W !,?20,$P($T(DESC+12),";",4),?56,"012",?65,^TMP("ANRV",$J,12)
 W !,?20,$P($T(DESC+13),";",4),?56,"013",?65,^TMP("ANRV",$J,13)
 W !,?20,$P($T(DESC+14),";",4),?56,"014",?65,^TMP("ANRV",$J,14)
 W !,?20,$P($T(DESC+15),";",4),?56,"015",?65,^TMP("ANRV",$J,15)
 W !,?64,"_____"
 W !,?65,(^TMP("ANRV",$J,9)+^TMP("ANRV",$J,10)+^TMP("ANRV",$J,11)+^TMP("ANRV",$J,12)+^TMP("ANRV",$J,13)+^TMP("ANRV",$J,14)+^TMP("ANRV",$J,15)) D:$Y+9>IOSL HED Q:QFLG
POS W !!,?15,"PERIOD OF SERVICE"
 W !,?20,$P($T(DESC+16),";",4),?56,"016",?65,^TMP("ANRV",$J,16)
 W !,?20,$P($T(DESC+17),";",4),?56,"017",?65,^TMP("ANRV",$J,17)
 W !,?20,$P($T(DESC+18),";",4),?56,"018",?65,^TMP("ANRV",$J,18)
 W !,?20,$P($T(DESC+19),";",4),?56,"019",?65,^TMP("ANRV",$J,19)
 W !,?20,$P($T(DESC+20),";",4),?56,"020",?65,^TMP("ANRV",$J,20)
 W !,?20,$P($T(DESC+21),";",4),?56,"021",?65,^TMP("ANRV",$J,21)
 W !,?64,"______"
 W !,?65,(^TMP("ANRV",$J,16)+^TMP("ANRV",$J,17)+^TMP("ANRV",$J,18)+^TMP("ANRV",$J,19)+^TMP("ANRV",$J,20)+^TMP("ANRV",$J,21)) D:$Y+8>IOSL HED Q:QFLG
ENT W !!,?15,"ENTITLEMENT"
 W !,?20,"Service Connected"
 W !,?25,$P($T(DESC+22),";",4),?56,"022",?65,^TMP("ANRV",$J,22)
 W !,?25,$P($T(DESC+23),";",4),?56,"023",?65,^TMP("ANRV",$J,23)
 W !,?25,$P($T(DESC+24),";",4),?56,"024",?65,^TMP("ANRV",$J,24)
 W !,?20,$P($T(DESC+25),";",4),?56,"025",?65,^TMP("ANRV",$J,25)
 W !,?64,"______"
 W !,?65,(^TMP("ANRV",$J,22)+^TMP("ANRV",$J,23)+^TMP("ANRV",$J,24)+^TMP("ANRV",$J,25))
 D:$Y+12>IOSL HED Q:QFLG
AGE W !,?15,"AGE CATAGORY"
 W !!,?20,$P($T(DESC+26),";",4),?56,"026",?65,^TMP("ANRV",$J,26)
 W !,?20,$P($T(DESC+27),";",4),?56,"027",?65,^TMP("ANRV",$J,27)
 W !,?20,$P($T(DESC+28),";",4),?56,"028",?65,^TMP("ANRV",$J,28)
 W !,?20,$P($T(DESC+29),";",4),?56,"029",?65,^TMP("ANRV",$J,29)
 W !,?20,$P($T(DESC+30),";",4),?56,"030",?65,^TMP("ANRV",$J,30)
 W !,?20,$P($T(DESC+31),";",4),?56,"031",?65,^TMP("ANRV",$J,31)
 W !,?20,$P($T(DESC+32),";",4),?56,"032",?65,^TMP("ANRV",$J,32)
 W !,?20,$P($T(DESC+33),";",4),?56,"033",?65,^TMP("ANRV",$J,33)
 W !,?20,$P($T(DESC+34),";",4),?56,"034",?65,^TMP("ANRV",$J,34)
 W !,?64,"______"
 W !,?65,(^TMP("ANRV",$J,26)+^TMP("ANRV",$J,27)+^TMP("ANRV",$J,28)+^TMP("ANRV",$J,29)+^TMP("ANRV",$J,30)+^TMP("ANRV",$J,31)+^TMP("ANRV",$J,32)+^TMP("ANRV",$J,33)+^TMP("ANRV",$J,34)) D:$Y+4>IOSL HED Q:QFLG
VISREV W !!,?15,$P($T(DESC+35),";",4),?56,"035",?65,^TMP("ANRV",$J,35)
 W !,?15,$P($T(DESC+36),";",4),?56,"036",?65,^TMP("ANRV",$J,36)
 W !,?15,$P($T(DESC+37),";",4),?56,"037",?65,^TMP("ANRV",$J,37)
 W !,?15,$P($T(DESC+38),";",4),?56,"038",?65,^TMP("ANRV",$J,38)
 W !,?20,$P($T(DESC+38),";",5) D:$Y+9>IOSL HED Q:QFLG
VISREF W !,?15,"VIST REFERRALS"
 W !,?20,"Blind Rehabilitation Center"
 W !,?25,$P($T(DESC+39),";",4),?56,"039",?65,^TMP("ANRV",$J,39)
 W !,?25,$P($T(DESC+40),";",4),?56,"040",?65,^TMP("ANRV",$J,40)
 W !,?20,"Blind Rehabilitation Clinic"
 W !,?25,$P($T(DESC+41),";",4),?56,"041",?65,^TMP("ANRV",$J,41)
 W !,?25,$P($T(DESC+42),";",4),?56,"042",?65,^TMP("ANRV",$J,42)
 W !,?20,"Other Non-VA Agencies"
 W !,?25,$P($T(DESC+43),";",4),?56,"043",?65,^TMP("ANRV",$J,43)
 W !,?25,$P($T(DESC+44),";",4),?56,"044",?65,^TMP("ANRV",$J,44) D:$Y+4>IOSL HED Q:QFLG
BLREH W !,?15,"VETERANS NOT ACCEPTED FOR BLIND"
 W !,?20,"REHABILITATION"
 W !,?25,$P($T(DESC+45),";",4),?56,"045",?65,^TMP("ANRV",$J,45)
 W !,?25,$P($T(DESC+46),";",4),?56,"046",?65,^TMP("ANRV",$J,46) D:$Y+6>IOSL HED Q:QFLG
DISC W !,?15,"VETERANS DISCHARGED DURING"
 W !,?20,"REPORT PERIOD"
 W !,?25,$P($T(DESC+47),";",4),?56,"047",?65,^TMP("ANRV",$J,47)
 W !,?25,$P($T(DESC+48),";",4),?56,"048",?65,^TMP("ANRV",$J,48)
 W !,?25,$P($T(DESC+49),";",4),?56,"049",?65,?65,^TMP("ANRV",$J,49)
 W !,?15,$P($T(DESC+50),";",4),?56,"050",?65,"______ hours"
 W !,?20,$P($T(DESC+50),";",5) D:$Y+5>IOSL HED Q:QFLG
 Q
DESC ; List of field codes and totals descriptions
 ;;001;TOTAL VIST ELIGIBLE VETERANS
 ;;002;Reviewed for BRC Attendance
 ;;003;Other
 ;;004;No Sight
 ;;005;LP up to and including 5/200
 ;;006;LP of 6/200 to 20/200
 ;;007;Legally Blind by field restriction
 ;;008;Not Known
 ;;009;Employed for pay
 ;;010;Engaged in training or school
 ;;011;Volunteer work (10 hrs/wk)
 ;;012;Retired w/approp. activities
 ;;013;Too ill or too disabled
 ;;014;No well defined activity
 ;;015;Not Known
 ;;016;WWI, Spanish American War
 ;;017;WWII
 ;;018;Korean
 ;;019;Vietnam Era
 ;;020;Peacetime
 ;;021;Other/Not known
 ;;022;0% only
 ;;023;Comp. SC, 10% - SMC
 ;;024;SC for blindness
 ;;025;NSC Pension A&A/HB
 ;;026;Under 25
 ;;027;25-34
 ;;028;35-44
 ;;029;45-54
 ;;030;55-64
 ;;031;65-74
 ;;032;75-84
 ;;033;85 and over
 ;;034;Not known
 ;;035;TOTAL NUMBER OF VIST ANNUAL REVIEWS
 ;;036;DECLINED VIST ANNUAL REVIEW
 ;;037;'NO SHOW' FOR VIST ANNUAL REVIEW
 ;;038;VIST COORDINATOR AND COORDINATOR;INITIATED FIELD VISITS
 ;;039;First Experience
 ;;040;Additional Training
 ;;041;First Experience
 ;;042;Additional Training
 ;;043;First Experience
 ;;044;Additional Training
 ;;045;Blind Rehabilitation Center
 ;;046;Blind Rehabilitation Clinic
 ;;047;Blind Rehabilitation Center
 ;;048;Blind Rehabilitation Clinic
 ;;049;Other Non-VA
 ;;050;AVERAGE MAN HOURS EXPENSED BY;VIST COORDINATOR PER WEEK
