VBECA5A ;DALOI/BNT/RLM - BLOOD PRODUCT LOOKUP FOR SURGERY ;08/23/2001
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to IX^DIC supported by DBIA #10006
 ; Reference to LIST^DIC supported by DBIA #2051
 ; Reference to ^DIR supported by DBIA #10026
 ;
 ; ------------------------------------------------------
 ;      Private method supports IA #3631
 ; ------------------------------------------------------
ITRAN ; -- Input Transform lookup
 G COMPCL^VBECA5B ;Old code below for reference
 N DIC,DA,Y,Z,D,DIE,DO,DICR,Q,DR
 S DIC="^LAB(66,",DIC(0)="EQSZ"
 S DIC("S")="I $P(^(0),U,15)"
 S D="B" D IX^DIC
 K DIQUIET,VBDIC
 I $D(DTOUT)!($D(DUOUT)) K X Q
 S X=$G(Y(0,0)) K:X="" X
 I $G(Y)'=-1 S VBECSEL=+Y
 Q
DIR ;I can't find a reference to this in the surgery code.
 N DIC,DA,Y,Z,D,DIE,DO,DICR,DIR
 S DIC="^LAB(66,",DIC(0)="EQ",D="B"
 D IX^DIC
 Q
 ;
 ; ------------------------------------------------------
 ;      Private method supports IA #3631
 ; ------------------------------------------------------
OUT66 ;
 G LIST^VBECA5B ;Old code below for reference
 K ERROR,DIERR,VBECO
 D LIST^DIC(66,,.01,,,,,,"I $P(^(0),U,15)",,"VBECO","ERROR")
 S VBEC=0 F VBECL=1:1 S VBEC=$O(VBECO("DILIST",1,VBEC)) Q:'VBEC  D  Q:$D(DUOUT)!$D(DTOUT)
  . W !,VBECO("DILIST",1,VBEC)
  . I '(VBECL#5) S DIR(0)="E" D ^DIR
 K VBEC,VBECL,VBECO
 ;
 ; ------------------------------------------------------
 ;      Private method supports IA #3631
 ; ------------------------------------------------------
LIST66 ;
 G LIST^VBECA5B ;Old code below for reference
 N D,DO,DIC,X
 K ^TMP("DILIST",$J),VBECO
 S X="?",DIC="^LAB(66,",DIC(0)="EQS",D="B"
 S DIC("S")="I $P(^(0),U,15)"
 D IX^DIC
 K DIBTDH
 Q
