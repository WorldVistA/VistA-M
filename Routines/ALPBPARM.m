ALPBPARM ;SFVAMC/JC - Parameter Definitions ;05/02/2003  15:24
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 N DEF,OPR,ZLNK
 N ALPBSCRN,ALPBPARM,ALPBDIVE,ALPBDIVI,ALPBDIVP,ALPBINST,LNK,ERR,DIC,DIE,DA,DR,DIR
 D Q3
 S DIR(0)="Y",DIR("B")="YES" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) G OUT
 S DEF=Y K DA,DIR,Y
 I DEF=1 S ALPBPARM="PSB BKUP DEFAULT"
 ;Associate HL7 Logical Links with division(s)
 I $G(ALPBPARM)']"" S ALPBPARM="PSB BKUP MACHINES"
 S DIR(0)="S^A:Add a Logical Link;D:Delete a Logical Link"
 S DIR("A")="OPERATION",DIR("B")="ADD"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) G OUT
 S OPR=Y K DA,DIR,Y
 I DEF=1 D DLINKS G OUT
DIV ;division
 N ALPBDIVP,ALPBDIVI,ALPBDIVE,ALPBINST
 S ALPBDIVP=""
 ;note-parameter file requires institutions instead of divisions
 ;in DIV class
 D Q1 S DIR(0)="PO^40.8:EMZ" D ^DIR
 Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))
 S ALPBDIVI=+Y ;INTERNAL MEDICAL CENTER DIVISION
 S ALPBDIVE=$P(Y,U,2) ;EXTERNAL MED CTR DIVISION
 S ALPBINST=$P(Y(0),U,7) ;INSTITUTION FILE POINTER
 I $G(ALPBINST)']"" W !,"Medical Ctr Divisions must be associated with an institution." G OUT
 S ALPBDIVP="DIV.`"_ALPBINST ;PARAMETER FILE REFERENCE
 I $G(ALPBDIVP)']"" W !,"Division information is required." G OUT
 K DA,DIR,Y
 D LINKS G DIV
 Q
DLINKS ;What logical links for the DEFAULT parmeter?
 K Y S X="BAR CODE MED ADMIN",DIC="^DIC(9.4,",DIC(0)="X",D="B" D IX^DIC
 S ALPBPKG=+$P($G(Y),U,1)
 I '$G(ALPBPKG) W !,"BAR CODE MED ADMIN MISSING FROM PACKAGE FILE." Q
 S ALPBPKG="PKG.`"_ALPBPKG
 K ZLNK
 D GET(.ZLNK)
 I '$D(ZLNK) W !,"No DEFAULT links defined for this package." Q:OPR="D"
 W !,"The following DEFAULT links are associated with this package:"
 S X="" F  S X=$O(ZLNK("LINKS",X)) Q:X<1  D
 . W !,$P(ZLNK("LINKS",X),U,2)
 . I OPR="D" S ALPSCRN($P(ZLNK("LINKS",X),U,2),X)=ZLNK("LINKS",X)
 F  D  Q:$G(DUOUT)!($G(DTOUT))!($G(DIRUT))
 . D Q2
 . I OPR="D" S DIR("S")="I $D(ALPSCRN($P(^HLCS(870,+Y,0),U,1)))"
 . S DIR("A")="Select WorkStation Link "
 . S DIR(0)="PO^870:EMZ" D ^DIR
 . I $G(DUOUT)!($G(DTOUT))!($G(DIRUT)) K DA,DIR,Y Q
 . I Y>0 S RESULT=$$SET(ALPBPKG,$P(Y,U,2))
 . I $G(RESULT)'<1 W !,RESULT
 . K DA,DIR,Y
 K ZLNK
 Q
LINKS ;What logical links for a division?
 W !,"The Institution associated with this division is ",$$NS^XUAF4(ALPBINST)
 D GET(.LNK,ALPBDIVE,1)
 I '$D(LNK),$G(OPR)="D" W !,"No links defined for this division." Q
 W !,"The following links are associated with this division:"
 S X="" F  S X=$O(LNK("LINKS",X)) Q:X<1  D
 . W !,$P(LNK("LINKS",X),U,2)
 . I OPR="D" S ALPSCRN($P(LNK("LINKS",X),U,2),X)=LNK("LINKS",X)
 K LNK
 F  D  Q:$G(DUOUT)!($G(DTOUT))!($G(DIRUT))
 . D Q2
 . I OPR="D" S DIR("S")="I $D(ALPSCRN($P(^HLCS(870,+Y,0),U,1)))"
 . S DIR("A")="Select WorkStation Link "
 . S DIR(0)="PO^870:EMZ" D ^DIR
 . I $G(DUOUT)!($G(DTOUT))!($G(DIRUT)) K DA,DIR,Y Q
 . I Y>0 S RESULT=$$SET(ALPBDIVP,$P(Y,U,2))
 . I $G(RESULT)'<1 W !,RESULT
 . K DA,DIR,Y,RESULT
 Q
SET(ALPBDIVP,LINK) ;function to set or delete parameter for logical link
 ;and returns error response or zero
 I OPR="A" D EN^XPAR(ALPBDIVP,ALPBPARM,LINK,LINK,.ERR) I ERR=0 W "...Added"
 I OPR="D" D DEL^XPAR(ALPBDIVP,ALPBPARM,LINK,.ERR) I ERR=0 W "...Deleted" I $D(ALPSCRN(LINK)) K ALPSCRN(LINK)
 Q ERR
GET(HLL,DIV,FLG,PR) ;Return HLL("LINKS") array for a given patient division
 ;HLL-HLL("links") array - pass by reference
 ;DIV- DIVISION (OPTIONAL)
 ;FLG-1=DON'T RETURN DEFAULT IF DIV IS EMPTY (OPTIONAL)
 ;PR-SUBSCRIBER PROTOCOL TO INCLUDE WITH THE HLL ARRAY (DEF=BCBU ORM RECV) 
 ;or a default group if div null
 I $G(PR)="" S PR="PSB BCBU ORM RECV"
 I +$G(FLG)'=1 S FLG=0
 N LST S LST=""
 I $G(DIV)="" D  G OUT
 . K Y S X="BAR CODE MED ADMIN",DIC="^DIC(9.4,",DIC(0)="X",D="B" D IX^DIC
 . S ALPBPKG=+$P($G(Y),U,1)
 . Q:'ALPBPKG  S ALPBPKG="PKG.`"_ALPBPKG
 . D GETLST^XPAR(.LST,ALPBPKG,"PSB BKUP DEFAULT","E",.ERR)
 . D GET1
 N INST S INST=$$DV(DIV)
 I INST']"" W !,"Unknown Institiution-please review Medical Ctr Division File." G OUT
 D GETLST^XPAR(.LST,"DIV.`"_INST,"PSB BKUP MACHINES","E",.ERR)
 I $O(LST(0))<1!(ERR) D
 . Q:+FLG=1
 . D GET(.HLL,"") ;Try to use default list if no results.
GET1 ;
 I $O(LST(0)),ERR=0 N X S X=0 F  S X=$O(LST(X)) Q:X<1  D
 . Q:$P(LST(X),U,2)']""
 . N LNK870 S LNK870=$P(LST(X),U,2) Q:$E(LNK870,1,2)="VA"  ;don't init hospital
 . S HLL("LINKS",X)=PR_U_$P(LST(X),U,2)
 Q
DV(DV) ;take internal or external division and return institution
 I +DV>0 S X="`"_DV
 N Y,DIC,DA
 S DIC=40.8,DIC(0)="MQZ",X=DV D ^DIC
 I Y'<1 Q $P(Y(0),U,7)
 Q ""
Q1 ;division help
 S DIR("?")=" "
 S DIR("?",1)="If you are associating different workstations with different"
 S DIR("?",2)="divisions, you must choose a division first, then you will be asked"
 S DIR("?",3)="to enter HL7 Logical Links that correspond to this division."
 Q
Q2 ;Link help
 S DIR("?")=" "
 S DIR("?",1)="Each of the workstations you use for BCMA backups will"
 S DIR("?",2)="have a fixed TCP/IP address assigned and an HL7 Logical"
 S DIR("?",3)="Link associated with it. Now your workstations must be"
 S DIR("?",4)="associated with each division you have defined. If you are not a multi-"
 S DIR("?",5)="divisional facility, all workstations will be associated"
 S DIR("?",6)="with only one facility."
 Q
Q3 ;Ask Default
 W !,"Do you want all backup data to go to the same group of"
 W !,"backup devices regardless of the patient's division?"
 Q
OUT ;EXIT
 Q
