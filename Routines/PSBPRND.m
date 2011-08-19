PSBPRND ;BIRMINGHAM/EFC-BCMA PRN DOCUMENTING ;May 2002
 ;;2.0;BAR CODE MED ADMIN;**32**;May 2002
 ;
 ;Queue the routine
ENV(PSBPRNDT,PSBSTRT,PSBDUZ,PRNMSG) ;
 I $G(DUZ)="" W !,"Your DUZ is not defined. It must be defined." Q
 K ZTSAVE,ZTSK S ZTRTN="PROCESS^PSBPRND(PSBPRNDT,PSBSTRTE,PSBDUZ,PSBPRNM)",ZTDESC="BCMA PRN DOCUMENTATION",ZTIO=""
 W !!
 S ZTSAVE("PSBPRNDT")=""
 S ZTSAVE("PSBSTRTE")=""
 S ZTSAVE("PSBDUZ")=""
 S ZTSAVE("PSBPRNM")=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 .W !!,"The PRN effectiveness documenting process was ",$S($G(ZTSK):"",1:"NOT"),"queued",!
 .W !," TASK#: "_$G(ZTSK)
 Q
PSBPRNS ;Document all administrations of a PRN order that have NOT had
 ; the PRN Effectiveness documented for dates user provided
 ;
 N PSBIEN
 I $G(DUZ)="" W !,"Your DUZ is not defined. It must be defined." Q
 S PSBDUZ=$G(DUZ)
 D HEADER
 ;get start date
 S %DT="AEQ",%DT("A")="Select Date to Process From: "
 S %DT("B")=""
 W ! D ^%DT Q:+Y<1  S PSBDT=Y
 S PSBPRNDT=PSBDT D D^DIQ
 ;Get stop date
 S %DT="AEQ",%DT("A")="Select Date to Process Up to: "
 S %DT("B")=""
 W ! D ^%DT Q:+Y<1  S PSBDTA=Y
 S PSBSTRTE=PSBDTA D D^DIQ
 I PSBPRNDT>PSBSTRTE W !,"Start date cannot be greater than end date"  Q
 ;Write user running routine
 S PSBNAME=$P(^VA(200,PSBDUZ,0),"^",1)
 W !!,"PRN effectiveness entered by: ",PSBNAME,!
 D HEADER
 ;COMMIT OR QUIT
 S Y=PSBDTA D DD^%DT S PSBRDT=Y
 S Y=PSBPRNDT D DD^%DT S PSBRDTA=Y
 W !!!,?10,"**PRN DOCUMENTATION WILL BE FILED FOR THE FOLLOWING**"
 W !!,?5,"PRN START DATE...........: ",PSBRDTA
 W !,?5,"PRN END DATE.............: ",PSBRDT
 W !,?5,"PRN ENTERED BY...........: ",PSBNAME
 W !,?5,"PRN DOCUMENTATION STATEMENT: "
 ;Set mesage to be used
 S PSBPRNM="Administrative Closure"
 I $L(PSBPRNM)>0 D
 .W ?9,$E(PSBPRNM,1,52)
 R !!,"Would you like to CONTINUE ? (Y/N):",PSBANS:30
 S PSBFLAG=""
 I (PSBANS["Y")!(PSBANS="y") S PSBFLAG=1
 I PSBFLAG'=1 D  Q
 .W !!,"You have chosen not to continue! Application ending!!"
 D HEADER
 D ENV(PSBPRNDT,PSBSTRTE,PSBDUZ,PSBPRNM)
 Q
 ;
PROCESS(PSBPRNDT,PSBSTRTE,PSBDUZ,PSBPRNM)  ;
 ;Gather Patient DFN                        
 S PSBSRTD=PSBSTRTE+1
 S PSBPRTA=PSBPRNDT-1
 S PSBCNT="0"
 S DFN=""  F  S DFN=$O(^PSB(53.79,"APRN",DFN)) Q:DFN=""  D 
 .S PSBSTRT="" F  S PSBSTRT=$O(^PSB(53.79,"APRN",DFN,PSBSTRT)) Q:PSBSTRT=""  D
 ..I PSBSTRT>PSBPRTA,PSBSTRT<PSBSRTD  D
 ...S PSBIEN="" F  S PSBIEN=$O(^PSB(53.79,"APRN",DFN,PSBSTRT,PSBIEN)) Q:'PSBIEN  D
 ....I ($P(^PSB(53.79,PSBIEN,0),U,9)'="G")&($P(^PSB(53.79,PSBIEN,0),U,9)'="RM") Q    ;Med was never given
 ....Q:$P($G(^PSB(53.79,PSBIEN,.2)),U,2)]""  ;PRN already entered
 ....D FILEIT(PSBIEN,PSBPRNM)
 ....;increment counter
 ....S PSBCNT=PSBCNT+1
 ;Email the results
 D PSBEMAIL(PSBCNT,PSBPRNM,PSBSTRTE,PSBPRNDT,PSBDUZ)
 K PSBCNT,PSBPRNM,PSBDTA,PSBPRNDT,PSBDUZ,PSBPRMG,PSBSTRTE
 K PSBSRTD,PSBPRTA
 Q
 ;File PRN
FILEIT(PSBIEN,PSBPRNM)   ;
 ;
 S PSBREC(0)=PSBPRNM
 S PSBIEN=PSBIEN_","
 D VAL^PSBML(53.79,PSBIEN,.22,PSBREC(0))
 D FILEIT^PSBML
 Q
 ;
 ;
HEADER ;Header
 W #
 W !,$TR($J("",IOM)," ","-")
 W !,?23,"PRN EFFECTIVENESS DOCUMENTATION ROUTINE"
 W !,$TR($J("",IOM)," ","-")
 Q
 ;
 ;
PSBEMAIL(PSB1,PSB2,PSB3,PSB4,PSB5)        ;
 ; PSB1 = PRN Count
 ; PSB2 = PRN message to file
 ; PSB3 = START date for search
 ; PSB4 = FINISH date for search
 ; PSB5 = DUZ for PRN entered by              
 ; Send PRN documentation changes to user
 S Y=PSB3 D DD^%DT S PSB3X=Y
 S Y=PSB4 D DD^%DT S PSB4X=Y
 S PSB5=$P(^VA(200,PSB5,0),"^",1)
 S PSBMG=DUZ ;
 Q:PSBMG=""
 S PSBMSG(1)=" "
 S PSBMSG(2)="  PRN effectiveness not documented have been fixed. "
 S PSBMSG(3)="  "
 S PSBMSG(4)="  PRN effectiveness entered by.: "_PSB5
 S PSBMSG(5)="  Number of PRNs documented....: "_PSB1
 S PSBMSG(6)="  Start Date.......: "_PSB4X
 S PSBMSG(7)="  Finish Date......: "_PSB3X
 S PSBMSG(8)="  Message documented for PRNs..: "_PSB2
 S PSBMSG(9)="        "
 S PSBMSG(10)="        "
 S PSBMSG(11)="       "
 S PSBMSG(12)=""
 S PSBMSG(13)="     "
 S PSBMSG(14)="     "
 S PSBMSG(15)="                                     "
 S XMY(DUZ)="",XMTEXT="PSBMSG(",XMSUB="BCMA PRN DOCUMENTATION Notification."
 D ^XMD
 K PSB1,PSB2,PSB3,PSB4,PSB5,PSB4X,PSB3X
 K PSBMSG,PSBMG,XMY,XMSUB,XMTEXT
 Q
 ;
 ;
 ;
 ; 
 ;
