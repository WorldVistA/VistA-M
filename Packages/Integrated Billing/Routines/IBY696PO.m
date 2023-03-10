IBY696PO ;EDE/WCJ - POST-INSTALL FOR IB*2.0*696 ;07-FEB-2021
 ;;2.0;INTEGRATED BILLING;**696**;21-MAR-94;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IA# 10141 - MES^XPDUTL
 ;
EN ;Entry Point
 N IBA
 S IBA(2)="IB*2*696 Post-Install...",(IBA(1),IBA(3))=" "
 D MES^XPDUTL(.IBA) K IBA
 ;
 N IBSITE,IBFAC
 D SITE^IBAUTL
 ;
 ;If site doing the billing is not the main site
 I $$STA^XUAF4(IBFAC)'=IBSITE D ZERO($$IEN^XUAF4(IBSITE)) ; fix the zero problem
 ;
 N SITEINFO
 S SITEINFO=$$SITE^VASITE   ; returns pointer^name^external
 ;
 ;If IEN to file 4 is not the same as site number. 
 I +SITEINFO'=+$P(SITEINFO,U,3) D FIXIT(SITEINFO)
 ;
 S IBA(2)="IB*2*696 Post-Install Complete.",(IBA(1),IBA(3))=" "
 D MES^XPDUTL(.IBA) K IBA
 Q
 ;
ZERO(IENF4) ;
 ; IENF4 - IEN file 4
 N IBUCIEN
 S IBUCIEN=0 F  S IBUCIEN=$O(^IBUC(351.82,IBUCIEN)) Q:'+IBUCIEN  D
 . N ZNODE
 . S ZNODE=$G(^IBUC(351.82,IBUCIEN,0))
 . Q:$P(ZNODE,U,2)'=0  ; quit if this not the site=0 problem
 . ; update site (#.02) and set the UPDATED flag and get out. Let the daily push to the rest.
 . D UPDATE(IBUCIEN,".02////"_IENF4_";")
 .Q
 Q
 ;
FIXIT(SITE) ;
 ; SITE - IEN File 4^Site Name^Station #
 N IBUCIEN
 S IBUCIEN=0 F  S IBUCIEN=$O(^IBUC(351.82,IBUCIEN)) Q:'+IBUCIEN  D
 . N ZNODE
 . S ZNODE=$G(^IBUC(351.82,IBUCIEN,0))
 . Q:$P(ZNODE,U,2)'=+SITE  ; quit if this is not the originating site
 . ; set the UPDATED flag and get out. Let the daily push to the rest.
 . D UPDATE(IBUCIEN,"")
 .Q
 Q
 ;
UPDATE(IBUCIEN,INDR) ;update UPDATED field
 ; IBUCIEN - File 351.82 ien
 ; INDR - Incoming DR String
 N DIE,DA,DR,D0,DIC
 S DIE="^IBUC(351.82,"
 S DA=IBUCIEN,DR=INDR_"1.01////1"
 D ^DIE
 Q 
