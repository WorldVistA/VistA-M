IB20P646 ;SAB/Albany - IB*2.0*646 POST INSTALL;12/11/17 2:10pm
 ;;2.0;Integrated Billing;**646**;Mar 20, 1995;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*618
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*618 ")
 ; Adding AR CATEGORIES and REVENUE SOURCE CODES
 D IBUPD
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*618")
 Q
 ;
IBUPD ; Inactivate FEE Service Entries
 ;
 N LOOP,LIEN,IBDATA
 N X,Y,DIE,DA,DR,DTOUT,DATA
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Activating DG FEE SERVICE (OPT) Action Types (350.1).")
 F LOOP=1:1:3 D
 . ;Extract the new ACTION TYPE to be added.
 . S IBDATA=$T(IBDDAT+LOOP)
 . S IBDATA=$P(IBDATA,";;",2)
 . ;Store in array for adding to the file (#350.1).
 . Q:IBDATA=""    ;go to next entry if Category is not to be updated.
 . S LIEN=$O(^IBE(350.1,"B",IBDATA,""))  ; find ACTION TYPE entry 
 . Q:LIEN=""
 . ;
 . ; File the update along with inactivate the ACTION TYPE
 . S DR=".12////0"
 . I IBDATA="DG FEE SERVICE (OPT) NEW" S DR=DR_";.08////CC URGENT CARE;20////S IBDESC="_$C(34)_"CC URGENT CARE"_$C(34)
 . S DIE="^IBE(350.1,",DA=LIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 ;
 S DR=""
 Q
 ;
IBDDAT ; Fee Service to inactivate
 ;;DG FEE SERVICE (OPT) CANCEL
 ;;DG FEE SERVICE (OPT) NEW
 ;;DG FEE SERVICE (OPT) UPDATE
 Q
