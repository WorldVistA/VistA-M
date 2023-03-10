HBHCEDSP ; LR VAMC(IRMS)/MJT-HBHC Edit System Parameters; Apr 30, 2021@17:39
 ;;1.0;HOSPITAL BASED HOME CARE;**6,8,32**;NOV 01, 1993;Build 58
 ;
 ; Reference to:
 ;     ^DG(40.8 supported by ICR #7024
 ;     ^DIC(4 supported by ICR #10090
 ;
EN ;
 K DIE S DIE="^HBHC(631.9,",DA=1,DR="3;6" D ^DIE
 N HBHCPREV,HBHCPRNM,HBHCPREVX,HBHCQUIT
 S HBHCQUIT=0
 ;Determine which site was sent to AITC before the
 ;install of HBH*1.0*32.
 S HBHCPREV=$P(^HBHC(631.9,1,0),"^",5)
 S HBHCPRNM=$P(^DIC(4,HBHCPREV,0),"^")
 ;Retrieve the name from file 40.8 because it could
 ;differ from the name in file 4.
 S HBHCPREVX=$O(^DG(40.8,"AD",HBHCPREV,""))
 ;The previous site should be in file 40.8.
 ;But if not, use the name from file 4.
 I HBHCPREVX]"" D
 . S HBHCPRNM=$P(^DG(40.8,HBHCPREVX,0),"^")
 ;
PARENT ;
 ;The parent site field is a multiple which points to the
 ;MEDICAL CENTER (#40.8) file.
 N HBHCFLG,HBHCNUM,Y,DTOUT,DUOUT
 S HBHCFLG=1
 W !!,"The ""Parent Site"" prompt selection should reflect the Austin"
 W !,"Mainframe HBPC Sanctioned Program facility number at your VA."
 W !,"You must select a VA HBPC sanctioned site number or the HBPC"
 W !,"Admission Form will be rejected in Austin when the non-sanctioned"
 W !,"site number is used.",!
 K DIE S DIE="^HBHC(631.9,",DA=1
 S DR=9 D ^DIE
 K DA,DIE,DR,X,Y
 S HBHCNUM=+$P($G(^HBHC(631.9,1,1,0)),"^",4)
 I HBHCNUM=1 D CHECK1
 Q:HBHCQUIT
 I 'HBHCFLG G PARENT
 D CHECKALL
 Q:HBHCQUIT
 I 'HBHCFLG G PARENT
 Q
 ;
CHECK1 ;if only one parent site defined and it's not the same as
 ;the site which the site already had defined in the now unused
 ;HOSPITAL NUMBER (#4) field (after install of HBH*1.0*32, 
 ;force user to verify the entry.
 N HBHCPR1
 S HBHCPR1=$O(^HBHC(631.9,1,1,"B",""))
 ;stop if for some unknown reason HBHCPR1 is null - shouldn't be, though.
 Q:HBHCPR1=""
 S HBHCPR1=$P(^DG(40.8,HBHCPR1,0),"^",7)
 I HBHCPR1'=HBHCPREV D
 . W !!,"Only one parent site is defined, and it is not ",HBHCPRNM," (",HBHCPREV,")."
 . W !,"Site ",HBHCPRNM," was previously transmitted to AITC."
 . N DIR
 . S DIR("A")="Are you sure site "_HBHCPRNM_" should not be added"
 . S DIR("B")="NO",DIR(0)="YN"
 . D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S HBHCQUIT=1 Q
 I $D(Y) S HBHCFLG=+Y
 Q
 ;
CHECKALL ;
 ;Ask user to verify again that these sites are valid.
 I $P($G(^HBHC(631.9,1,1,0)),"^",4)>0 D
 . W !!,"Parent Site",$S(HBHCNUM>1:"s",1:""),":"
 . W !!,"Institution ID   Name of Site"
 . W !,"--------------   -----------------------------------"
 N HBHCSQ,HBHCSTR,HBHCHIT
 ;HBHCHIT determines whether any parent site is the same site
 ;which previously transmitted to AITC prior to install of HBH*1.0*32.
 S HBHCSQ="",HBHCHIT=0
 F  S HBHCSQ=$O(^HBHC(631.9,1,1,"B",HBHCSQ)) Q:HBHCSQ=""  D
 . S HBHCSTR=$G(^DG(40.8,HBHCSQ,0))
 . W !,$P(HBHCSTR,"^",7),?17,$P(HBHCSTR,"^")
 . I $P(HBHCSTR,"^",7)=HBHCPREV S HBHCHIT=1
 I 'HBHCHIT D
 . W !!,"A parent site for ",HBHCPRNM," (",HBHCPREV,") is not defined."
 . W !,HBHCPRNM," was previously transmitted to AITC."
 . W !!,"Are you sure ",HBHCPRNM," should not be"
 . N DIR
 . S DIR("A")="defined as a parent site"
 . S DIR("B")="NO",DIR(0)="YN"
 . D ^DIR
 . I $G(DTOUT)!($G(DUOUT)) S HBHCQUIT=1 Q
 . S HBHCFLG=+Y
 Q:HBHCQUIT
 Q:'HBHCFLG
 Q:$P($G(^HBHC(631.9,1,1,0)),"^",4)'>0
 N DIR
 S DIR("A")="Are you sure "_$S(HBHCNUM>1:"these are",1:"this is a")_" VA HBPC sanctioned site"_$S(HBHCNUM>1:"s",1:"")
 S DIR("B")="NO",DIR(0)="YN"
 W !
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S HBHCQUIT=1 Q
 W !
 S HBHCFLG=+Y
 I 'HBHCFLG D
 . W !,"You are being taken back to the Parent Site prompt."
 . W !,"Delete entries (using ""@"") which are not VA HBPC sanctioned sites."
 Q
