EEO0210 ;HISC/JWR - GENERATES EEO COUNSELORS COMPLAINT INTAKE FORM (0210) ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;**1,2**;Apr 27, 1995
 I '$D(DUZ) W !,"YOUR DUZ (user number) IS NOT DEFINED CONTACT IRM",!! Q
 S EEOVA=$G(^VA(200,DUZ,20)),EEONAME=$P(EEOVA,U,2),EEOTITL=$P(EEOVA,U,3)
EN ;The entry point for each additional Complaint
 K EEOQ D ^EEOEOSE,HOME^%ZIS W !!! S EEOII=IOS,EEOQUIT=""
 S EEOIOF="I IOS=EEOII D TERMIOF^EEO211"
 S DIC("A")="Select Complainant: ",DIC="^EEO(785,",DIC(0)="AEMQZ",DIC("S")="I $$SCREEN^EEOEOSE(Y)"
 S:$G(EEOCOUNS)>0 DIC("S")="I $P($G(^EEO(785,Y,""SEC"")),U)=DUZ"
 D ^DIC I Y'>1 D EXIT Q
 S DA=+Y I DA'>0 D EX1^EEO211 Q
BLANK ;Gathers complaint information and sets up print variables
 D GATHER^EEO211
 S %ZIS="Q" K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP=1 EXIT
 I $D(IO("Q")) S EEOQ=1,ZTRTN="START^EEO0210",ZTSAVE("EEO*")="",ZTSAVE("^TMP("_"""EEOJ"""_",")="",ZTDESC="EEO FORM 0210" D ^%ZTLOAD G EN
 D START,EXIT G EN
START ;Opens the device and prints the report
 U IO I IOS=EEOII W @IOF
 S OE="|",$P(EO,"_",79)="" D HEAD W " 2.Complainant's Service or Department",$J(OE,7) S EEO("C")="",EEO("WP")=""
 W !,OE," ",EEONA,$J(OE,33-$L(EEONA)),"     ",EEOSE,$J(OE,40-$L(EEOSE)),!,OE,EO,OE
 W !,OE,"3.Complainant's Job Title/Grade",OE," DT of Initial Contact",OE," DT Final Interview    ",OE
 W !,OE," ",EEOJO,$J(OE,31-$L(EEOJO)),"     ",EEOIN,$J(OE,18-$L(EEOIN)),"     ",EEOFI,$J(OE,19-$L(EEOFI))
 W !,OE," ",EEOPO,$J(OE,31-$L(EEOPO)),$J(OE,23),$J(OE,24)
 W !,OE,EO,OE,!,OE,"6.Basis of Complaint",$J(OE,59)
 W !,OE,$J(OE,40),$J(OE,39) D BOXB^EEO211 X EEOIOF Q:EEOQUIT=1 
 W !,OE,EO,OE,!,OE,"7.Issue of Complainant",$J(OE,57),!,OE,EO,OE
 W !,OE," Issue                  ",OE,"Date Occurred|| Issue                  ",OE,"Date Occurred|"
 W !,OE,$J(OE,25),$J("||",15),$J(OE,25),$J(OE,14) D BOX^EEO211
 W !,OE,EO,OE
 D BACK X EEOIOF Q:EEOQUIT=1 
 W !,OE,"9.Corrective Action (what resolution are you seeking)",$J(OE,26)
 W !,OE,$J(OE,79) D BOXC^EEO211
 W !,OE,EO,OE X EEOIOF Q:EEOQUIT=1 
 W !,OE,"10.Narrative Information (list names, documents, and records)                 |" D WPB^EEO211 X EEOIOF Q:EEOQUIT=1
 W !,OE,EO,OE
 W !,OE,"11.Is The Complainant Represented   |12.Name and Address of Representative    |"
 W !,OE,$J(OE,37),$J(OE,42)
 W !,OE,$J(OE,37),"     ",EEORE,$J(OE,37-$L(EEORE))
 W !,OE," ",$S(EEORE'="":"YES",1:"NO "),$J(OE,33),"     ",EEOSTR,$J(OE,37-$L(EEOSTR)) S EOI=$L(EEOCI)+$L(EEOST)+$L(EEOZI)
 W !,OE,$J(OE,37),"     ",EEOCI," ",EEOST," ",EEOZI,$J(OE,35-EOI)
 W !,OE,EO,OE
 X EEOIOF Q:EEOQUIT=1  W !,OE,"13.Has the Complainant Filed a Union Grievance: ","     ",$S(EEOUN'="":"[X] YES [ ] NO",1:"[ ] YES [X] NO"),"           |"
 W !,OE,"14.Has the Complainant Filed an MSPB Appeal: ","     ",$S(EEOMS'="":"   [X] YES [ ] NO",1:"   [ ] YES [X] NO"),"           |"
 D FOOT D:$G(EEO("WP"))=1 LEND^EEO211
EXIT ;Kills variables and returns to entry
 D KILL,^%ZISC K EEOSEC,EEOQ,^TMP("EEOJ",$J)
 Q
HEAD ;Writes the Header of Form 0210
 X EEOIOF Q:EEOQUIT=1  W:$D(IO("S")) !
 W " ",EO,!,OE,"VA Department of Veterans Affairs",OE,"  EEO COUNSELOR'S REPORT: COMPLAINT INTAKE  ",OE,!,OE,EO,OE
 S BOX="[ ]" W !,OE,"1.Name of Complainant   ",$J(OE,10)
 Q
FOOT ;Writes the footer block of Form 0210
 W !,OE,EO,OE X EEOIOF Q:EEOQUIT=1 
 W !,OE,"15.Typed Name and Signature of EEO Counselor     |16.Date           |Control# |"
 W !,OE," ",EEONAME,$J(OE,49-$L(EEONAME)),$J(OE,19),$J(OE,10)
 W !,OE," ",EEOTITL,$J(OE,49-$L(EEOTITL)),$J(EEODT,12),"    ",$J("|"_EEOCT,9),"   ",OE,!,OE,EO,OE
 Q
KILL ;Kills variables for Complaint Intake Form (0210)
 K BOX,DIR,EEO,EEOCI,EEOCT,EEODT,EEOFI,EEOIN,EEOJO,EEOMS,EEONA,EEONAME,EEOPO,EEORE,EEOSE,EEOSEC,EEOST,EEOSTR,EEOTITL,EEOUN,EEOZI,EO,EOI,OE,CN,CNT,CNZ,CT,CX,EEO1,EEO1J,EEO1L,EEO2J,EEOCE,EEOCI,EEOCO,EEOCT,EEODT,EEOFI,EEOH,EEOIN
 K EEOJO,EEOMS,EEONA,EEONAME,EEOPH,EEOPO,EEORE,EEOSE,EEOST,EEOSTR,EEOTITL,EEOUN,EEOVA,EEOZI,EN,EO,EOC,EOE,EOE2,EOI,CO,OE,EEOD,EEOII,EEOIOF,EEOQUIT,EEOCAS,ECN,EEOFIL,NO
 Q
BACK X EEOIOF Q:EEOQUIT=1  W !,OE,"8.BACKGROUND INFORMATION (In section 10 of this form summarize the circum     |",!,OE,"stances which led up to the event(s) in dispute.  If the date of the event    |" X EEOIOF Q:EEOQUIT=1 
 W !,OE,"was more than 45 calendar days before initial contact with you, also record   |",!,OE,"the complainant's explanation for his/her untimeliness.)",$J(OE,23),!,OE,EO,OE
