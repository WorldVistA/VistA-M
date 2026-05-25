PRCAP421 ;EDE/LLB - PRCA*4.5*421 POST INSTALL;05/25/23 2:10pm
 ;;4.5;Accounts Receivable;**421**;Mar 20, 1995;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
POSTINIT ;Post Install for PRCA*4.5*421
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for PRCA*4.5*421")
 ; Updating AR CATEGORIES foand REVENUE SOURCE CODES
 D ARCATUPD
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for PRCA*4.5*421")
 Q
 ;
ARCATUPD ; Initialize the new DISPLAY IN TRANS PROFILE? field in the AR Category file.
 ;
 N LOOP,LIEN,IBDATA
 N X,Y,DIE,DA,DR,DTOUT,RCDATA,RCNM,RCTOP,RCCS
 ;
 ; Grab all of the entries to update
 F LOOP=1:1 S RCDATA=$T(ARDAT+LOOP) Q:$P(RCDATA,";",3)="END"  D
 . ;Extract the new ACTION TYPE to be added.
 . S RCDATA=$P(RCDATA,";;",2)
 . S RCNM=$P(RCDATA,";",1)
 . S RCTOP=$P(RCDATA,";",2),RCCS=$P(RCDATA,";",3)
 . S LIEN=$O(^PRCA(430.2,"B",RCNM,""))  ; find CHARGE REMOVE REASON entry 
 . Q:LIEN=""
 . ;
 . ; File the update along with inactivate the ACTION TYPE
 . S DR="1.01///"_1
 . S DR=DR_";1.02///"_RCTOP
 . S DR=DR_";1.03///"_RCCS
 . S DIE="^PRCA(430.2,",DA=LIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 ;
 S DR=""
 D MES^XPDUTL("     -> Updated the REFER TO CS?, REFER TO TOP?, and REFER TO DMC? fields in the AR Category (430.2) file.")
 Q
 ;
ARDAT ; Cancellation reasons (350.3) to update
 ;;EMERGENCY/HUMANITARIAN;4;5
 ;;INELIGIBLE HOSP.;4;5
 ;;END
