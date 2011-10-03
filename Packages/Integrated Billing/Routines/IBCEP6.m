IBCEP6 ;ALB/TMP/OIFO-BP/RBN - PROVIDER ID MAINT menu and INS CO EDIT hook ;11-02-00
 ;;2.0;INTEGRATED BILLING;**137,232,320,377,436**;21-MAR-94;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point
 N IBRESP,IBFLPFLP,IBCEP6FL
 S IBCEP6FL=1
 D FULL^VALM1
 F  Q:'$$MENU(.IBRESP)  D @IBRESP
ENQ ;
 Q
 ;
EN1 ; Provider maintenance from the billing screen 8
 N DIR,X,Y,IBEDIT
 W !
 I '$D(^XUSEC("IB PROVIDER EDIT",DUZ)) S DIR(0)="EA",DIR("A")="Press ENTER to continue: ",DIR("A",1)="YOU LACK THE SECURITY KEY FOR THIS ACTION" D ^DIR K DIR Q
 D EN
 Q
 ;
PO ; provider's own IDs
 N IBPRV,IBINS
 N IBSLEV,DIR,Y,X,IBPRMPT,IBNVAFL,IBIF
 K IBFASTXT
 S IBIF=""
 S IBPRMPT="PROVIDER"
 D FULL^VALM1
 S IBSLEV=1
 D EN^VALM("IBCE PRVPRV MAINT")
POX ;
 Q
 ;
PI ; provider's IDs provided by an insurance company
 N IBPRV,IBINS
 N IBSLEV,DIR,Y,X,IBPRMPT,IBNVAFL,IBIF
 K IBFASTXT
 S IBIF=""
 S IBPRMPT="PROVIDER"
 D FULL^VALM1
 S IBSLEV=2
 D EN^VALM("IBCE PRVPRV MAINT")
PIX ;
 Q
 ;
BI ; Insurance company batch ID entry
 D EN^IBCEP9
BIX ;
 Q
 ;
II ; Insurance company IDs
 D EN^IBCEP0
IIX ;
 Q
 ;
CP ; Care Unit maintenance - performing providers
 N IBINS,IBALL,IB95
 N IBSLEV,DIR,Y
 K IBFASTXT
 D FULL^VALM1
 S IBSLEV=1
 D EN^VALM("IBCE PRVCARE UNIT MAINT")
CPX ;
 Q
 ;
CB ; Care Unit maintenance - billing provider
 N IBINS,IBALL,IB95
 N IBSLEV,DIR,Y
 K IBFASTXT
 D FULL^VALM1
 S IBSLEV=2
 D EN^VALM("IBCE 2ND PRVID CARE UNIT MAINT")
CBX ;
 Q
 ;
NP ; non-VA individual provider information
 N IBNVPMIF
 S IBNVPMIF="I"
 ;
 ; *** Begin IB*2.0*436 - RBN
 ;
 D EN^DDIOL("For individual type entries: The name should be entered in")
 D EN^DDIOL("                             LAST,FIRST MIDDLE format.")
 D EN^DDIOL(" ")
 ;
 ; *** End IB*2.0*436 - RBN
 ;
 D EN^IBCEP8
NPX ;
 Q
 ;
NF ; non-VA facility provider information
 N IBNVPMIF
 S IBNVPMIF="F"
 ;
 ; *** Begin IB*2.0*436 - RBN
 ;
 D EN^DDIOL("For facility type entries: The name MUST start with an")
 D EN^DDIOL("Alpha character and may contain numerals, spaces, commas, ")
 D EN^DDIOL("periods, and a hyphen or dash.")
 D EN^DDIOL(" ")
 ;
 ; *** End IB*2.0*436 - RBN
 ;
 D EN^IBCEP8
NFX ;
 Q
 ;
MENU(IBSEL) ; display main provider ID maintenance menu and receive response from user
 ; function value returns 0 if user exits from menu or "^" out
 ; function value returns 1 otherwise
 ; IBSEL is the internal value of the user's selection if any (pass by reference)
 N IBQ,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,C,Z
 N IORESET,IORVON,IORVOFF,IOUON,IOUOFF,IOINHI,IOINLOW,IOINORM
 S IBQ=1,IBSEL=""
 S X="IORESET;IORVON;IORVOFF;IOUON;IOUOFF;IOINHI;IOINLOW;IOINORM"
 D ENDR^%ZISS
 ;
 S $P(DIR(0),U,1)="SOA"
 S $P(Z,";",1)="PO:Provider Own IDs"
 S $P(Z,";",2)="PI:Provider Insurance IDs"
 S $P(Z,";",3)="BI:Batch ID Entry"
 S $P(Z,";",4)="II:Insurance Co IDs"
 S $P(Z,";",5)="CP:Care Units for Providers"
 S $P(Z,";",6)="CB:Care Units for Billing Provider"
 S $P(Z,";",7)="NP:Non-VA Provider"
 S $P(Z,";",8)="NF:Non-VA Facility"
 ;
 S $P(DIR(0),U,2)=Z
 ;
 S DIR("L",1)="                "_IOINHI_"Provider IDs"_IOINORM
 S DIR("L",2)="          "_$P($P(Z,";",1),":",1)_"  "_$P($P(Z,";",1),":",2)
 S DIR("L",3)="          "_$P($P(Z,";",2),":",1)_"  "_$P($P(Z,";",2),":",2)
 S DIR("L",4)=""
 S DIR("L",5)="                "_IOINHI_"Insurance IDs"_IOINORM
 S DIR("L",6)="          "_$P($P(Z,";",3),":",1)_"  "_$P($P(Z,";",3),":",2)
 S DIR("L",7)="          "_$P($P(Z,";",4),":",1)_"  "_$P($P(Z,";",4),":",2)
 S DIR("L",8)=""
 S DIR("L",9)="                "_IOINHI_"Care Units"_IOINORM
 S DIR("L",10)="          "_$P($P(Z,";",5),":",1)_"  "_$P($P(Z,";",5),":",2)
 S DIR("L",11)="          "_$P($P(Z,";",6),":",1)_"  "_$P($P(Z,";",6),":",2)
 S DIR("L",12)=""
 S DIR("L",13)="                "_IOINHI_"Non-VA Items"_IOINORM
 S DIR("L",14)="          "_$P($P(Z,";",7),":",1)_"  "_$P($P(Z,";",7),":",2)
 S DIR("L")="          "_$P($P(Z,";",8),":",1)_"  "_$P($P(Z,";",8),":",2)
 ;
 S DIR("?")="^D MENH^IBCEP6"
 S DIR("A")="    Select Provider ID Maintenance Option: "
 ;
 ; paint the screen and display menu first time in
 D MENH
 W !
 S C=0 F  S C=$O(DIR("L",C)) Q:'C  W !,DIR("L",C)
 W !,DIR("L"),!
 D ^DIR K DIR W !
 I $D(DIRUT) S IBQ=0 G MENUX
 S IBSEL=Y
 I IBSEL="" S IBQ=0
MENUX ;
 Q IBQ
 ;
MENH ; menu help
 W @IOF,!?4,"Provider ID Maintenance Main Menu"
 W !!?4,"Enter a code from the list."
MENHX ;
 Q
 ;
