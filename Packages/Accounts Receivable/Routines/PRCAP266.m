PRCAP266 ;ALB/TXH - CWT Revenue Source Code Update - Post-Init;07/09/12
 ;;4.5;Accounts Receivable;**266**;Mar 20, 1995;Build 2
 ;
 ;** This routine is used as a Post-Init in a KIDS build for patch 
 ;** PRCA*4.5*266 to inactive 1 existing RSC and add 5 RSCs to the 
 ;** REVENUE SOURCE CODE (#347.3) file.
 Q
 ;
EN ; Add/inactivate RSCs
 ; RCLN is in format: CODE^CODE NAME^INACTIVE
 ;
 D:$P($T(NEW+1),";;",2)'="END" ADD
 D:$P($T(OLD+1),";;",2)'="END" INACT
 Q
 ;
ADD ; Add revenue source codes to file 347.3
 ;
 N DA,DD,DIC,DLAYGO,DO,RCA,RCFL,RCI,RCLN,X,RCCNT
 ;
 D BMES^XPDUTL(">>> Adding new Revenue Source Codes to REVENUE SOURCE CODE file (#347.3)...")
 D MES^XPDUTL("")
 S RCCNT=0,RCFL=0
 ;
 S DIC(0)="L",DLAYGO=347.3,DIC="^RC(347.3,"
 F RCI=1:1 K DD,DO,DA S RCLN=$P($T(NEW+RCI),";;",2) Q:RCLN="END"  D
 . S NCODE=$P(RCLN,U,1)
 . ; Validate source code
 . I $D(NCODE) I $L(NCODE)>4!($L(NCODE)<1)!'(NCODE'?1P.E) S RCFL=3,RCCNT=0 D SET K NCODE Q
 . S DIC("DR")=".01////"_$P(RCLN,U,1)_";.02///"_$P(RCLN,U,2)
 . S X=$P(RCLN,U,1)
 . I $D(^RC(347.3,"B",$P(RCLN,U,1))) S RCFL=0 D SET Q
 . I '$D(^RC(347.3,"B",$P(RCLN,U,1))) D FILE^DICN S RCCNT=RCCNT+1,RCFL=1 D SET Q
 ;
 D BMES^XPDUTL(.RCA)
 D BMES^XPDUTL("    *** Total "_RCCNT_" Revenue Source "_$S(RCCNT>1:"Codes",1:"Code")_" added.")
 K RCCNT,RCFL,DIC,DLAYGO,RCI,DD,DO,DA,RCLN,NCODE,X,RCA,Y
 Q
 ;
INACT ; Inactivate code
 ;
 N RCI,RCLN,PRCADA,DA,DD,DO,DR,DIE,RCFL,RCCNT,RCA
 ;
 D BMES^XPDUTL(">>> Inactivating Revenue Source Code in REVENUE SOURCE CODE file (#347.3)...")
 D MES^XPDUTL("")
 S RCCNT=0
 ;
 F RCI=1:1 K DD,DO,DA S RCLN=$P($T(OLD+RCI),";;",2) Q:RCLN="END"  D
 . I +$P(RCLN,U,3)=1 D
 . . S PRCADA=0
 . . F  S PRCADA=$O(^RC(347.3,"B",$P(RCLN,U,1),PRCADA)) Q:'PRCADA  D
 . . . I $D(^RC(347.3,PRCADA,0)) D
 . . . . I $P($G(^RC(347.3,PRCADA,0)),U,3)=1 S RCFL=0 D SET
 . . . . I $P($G(^RC(347.3,PRCADA,0)),U,3)=""!($P($G(^RC(347.3,PRCADA,0)),U,3)=0) D
 . . . . . L +^RC(347.3,PRCADA):$S($G(DILOCKTM)>5:DILOCKTM,1:5)
 . . . . . S RCCNT=RCCNT+1
 . . . . . S DA=PRCADA,DR=".03///^S X=1",DIE="^RC(347.3,"
 . . . . . D ^DIE
 . . . . . S RCFL=2 D SET
 . . . . . L -^RC(347.3,PRCADA)
 ;
 D BMES^XPDUTL(.RCA)
 D BMES^XPDUTL("    *** Total "_RCCNT_" Revenue Source "_$S(RCCNT>1:"Codes",1:"Code")_" inactivated.")
 D MES^XPDUTL(" ")
 K RCCNT,RCI,DD,DO,DA,RCLN,PRCADA,RCFL,DR,DIE,RCA
 Q
 ;
SET ; Set RCA() for display
 S RCA(RCI)="    "_$P(RCLN,U,1)_"   "_$P(RCLN,U,2)_"     "
 S RCA(RCI)=RCA(RCI)_$S(RCFL=1:"* Code Added *",RCFL=2:"* Code Inactivated *",RCFL=3:"* Error on Code *",1:"* Duplicate *")
 Q
 ;
NEW ; REVENUE SOURCE CODE (#347.3) - CODE^CODE NAME^INACTIVE
 ;;8CW1^CWT SHELTERED WORKSHOPS
 ;;8CW2^CWT/TRANS WORK EXP (VAMC)
 ;;8CW3^CWT/TWE (FED NOT VAMC)
 ;;8CW4^CWT/TRANS WORK EXP (NON FEDERAL)
 ;;8CW5^CWT/VETERANS CONSTRUCTION TEAM
 ;;END
 ;
OLD ;
 ;;8023^^1
 ;;END
