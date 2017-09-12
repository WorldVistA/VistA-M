PRCAP214 ;ALB/CXW - PATCH PRCA*4.5*214 PRE/POST-INIT
 ;;4.5;Accounts Receivable;**214**;Mar 20, 1995
 Q
PRE ;pre-init to ensure all entries for the EFTs are DINUMED 
 N Z,DA,DIE,DR,X,Y
 S Z=0 F  S Z=$O(^RCY(344.3,Z)) Q:'Z  I Z'=+$G(^(Z,0)) S DA=Z,DR=".01////"_Z,DIE="^RCY(344.3," D ^DIE
 Q
POST ;post-init to build a list of the ERAs with invalid payment adjustments
 N RC,RC0,RCSEQ,RCIFN,RCOLD,RCT
 ;
 D MES^XPDUTL("LIST OF ERA's WITH INVALID PAYMENT ADJUSTMENTS")
 ;
 S RCOLD=-1,RC=0,RCT=0,RCIFN=""
 F  S RC=$O(^RCY(344.4,RC)) Q:'RC  F RCSEQ=1:1 S RCIFN=+$O(^RCY(344.4,RC,1,"B",RCSEQ,RCIFN)) D  Q:'RCIFN
 . I 'RCIFN Q:RCOLD'<0  S RC0=$G(^RCY(344.4,RC,0)) D MES^XPDUTL("  ERA #:"_RC_"  TRACE #:"_$P(RC0,U,2)_"  REC'D:"_$$FMTE^XLFDT($P(RC0,U,7),"2D")_"  MSG #:"_$P(RC0,U,12)) S RCT=RCT+1 Q
 . S RCOLD=$P($G(^RCY(344.4,RC,1,RCIFN,0)),U,3)
 ;
 D MES^XPDUTL("THERE WERE "_$S(RCT=0:"NO",1:RCT)_" ERA(s) FOUND")
 Q
