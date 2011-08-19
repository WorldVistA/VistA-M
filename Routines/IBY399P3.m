IBY399P3 ;ALB/ARH - IB*2*399 POST-INSTALL - FTF UPDATE ; 09-MAR-2009
 ;;2.0;INTEGRATED BILLING;**399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Add Standard Filing Time Frames to file #355.13
 ; Convert Insurance and Plan Filing Time Frames to Standard Filing Time Frames
 ;
 Q
FTF ; Add and Convert to Standard Filing Time Frames
 ;
 D NEWF ; add Standard Filing Time Frames (#355.13)
 D CONVF^IBY399P4 ; Convert Company (#36) and Plan (#355.3) Filing Time Frames
 ;
 Q
 ;
NEWF ; Add Standard Filing Time Frames to the new file INSURANCE FILING TIME FRAME (#355.13)
 N IBI,IBLN,IBNAME,IBVAL,IBDA,DIC,DIE,DR,DA,DD,DO,X,Y,DLAYGO,IBTOT,IBTNC,IBTCH S (IBTOT,IBTNC,IBTCH)=0
 ;
 D MSG(" "),MSG("Add 8 Standard Filing Time Frames (#355.13)...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(NEW+IBI),";;",2,999) Q:IBLN=""  D
 . S IBNAME=$P(IBLN,U,1),IBVAL=+$P(IBLN,U,2)
 . ;
 . S IBTOT=IBTOT+1 I $O(^IBE(355.13,"B",IBNAME,0)) S IBTNC=IBTNC+1 Q
 . ;
 . K DD,DO S DLAYGO=355.13,DIC="^IBE(355.13,",DIC(0)="L",X=IBNAME D FILE^DICN K DIC S IBDA=+Y I Y<1 K X,Y Q
 . ;
 . I +IBVAL S DIE="^IBE(355.13,",DA=+IBDA,DR=".02////"_IBVAL D ^DIE K DIE,DA,DR,X,Y
 . ;
 . S IBTCH=IBTCH+1 D MSG(IBNAME_" added")
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" New FTFs Already Exist",2)
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" New FTFs Added"_$S(+IBTNC:", "_IBTNC_" Already Exist",1:""),2)
 Q
 ;
 ;
MSG(X,Y) ; set lines into patch install message, X is message, Y is line type (1-header, 2-result line)
 N CNT,IBA S CNT=1,IBA(1)="        " I +$G(Y) S CNT=2,IBA(2)=IBA(1) I +$G(Y)=1 S IBA(2)="     >> "
 S IBA(CNT)=IBA(CNT)_$G(X) D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
NEW ; List of Standard Filing Time Frames to be added (#355.31)
 ;;DAYS^1
 ;;MONTH(S)^1
 ;;YEAR(S)^1
 ;;DAYS PLUS ONE YEAR^1
 ;;DAYS OF FOLLOWING YEAR^1
 ;;MONTHS OF FOLLOWING YEAR^1
 ;;END OF FOLLOWING YEAR
 ;;NO FILING TIME FRAME LIMIT
 ;;
