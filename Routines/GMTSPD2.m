GMTSPD2 ; SLC/JER,SBW - Interactive Print-by-Loc (cont)     ; 02/27/2002
 ;;2.7;Health Summary;**49**;Oct 20, 1995
 ;                     
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10076  ^XUSEC("GMTS VIEW ONLY"
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10089  ^%ZISC
 ;                     
RXAP() ; Ask about inclusion of OP Rx Action Profile
 N %,DIR,X,Y
 I $P($G(^GMT(142.99,1,0)),U,2)'="Y" S Y=0 G RXAPX
 S DIR(0)="YO",DIR("A")="Include Outpatient Pharmacy Action Profile (Y/N)"
 S DIR("B")="NO" D ^DIR
RXAPX ; Rx Action Profile Exit
 Q Y
HSOUT ; Device Handling/Output control
 N IOP,%ZIS
 I $D(^XUSEC("GMTS VIEW ONLY",DUZ)) D NOQUE Q
 S %ZIS="Q",%ZIS("B")="HOME" D ^%ZIS Q:POP
 D @$S(+$G(GMPSAP)&(IO'=IO(0)):"QUE",$D(IO("Q")):"QUE",1:"NOQUE")
 Q
QUE ; Set ZT parameters and tasks ^GMTSPL
 N ZTSAVE,ZTDESC,ZTDTH,ZTIO,ZTRTN,% K IO("Q")
 F %="U","GMTSTYP","GMTSCDT","GMTSSC(","GMPSAP" S ZTSAVE(%)=""
 S ZTRTN="^GMTSPL",ZTDESC="HEALTH SUMMARY (BY LOCATION)",ZTIO=ION
 D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!")
 D ^%ZISC
 Q
NOQUE ; Calls ^GMTSPL in interactive mode
 U:IO'=IO(0) IO D ^GMTSPL,^%ZISC
 Q
LOCTXT(LOC) ; Change hospital location code to text name
 Q $S(LOC="W":"Ward",LOC="OR":"Operating Room",LOC="C":"Clinic",1:"Hospital Location")
