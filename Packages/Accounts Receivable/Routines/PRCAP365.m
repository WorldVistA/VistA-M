PRCAP365 ;SAB/Albany - PRCA*4.5*338 POST INSTALL;3/10/20 8:10am
 ;;4.5;Accounts Receivable;**365**;Mar 20, 1995;Build 6
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*669
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*669")
 ; Adding AR CATEGORIES and REVENUE SOURCE CODES
 D ARCATUPD
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*669")
 Q
 ;
ARCATUPD ; Initialize the new DISPLAY IN TRANS PROFILE? field in the AR Category file.
 ;
 N LOOP,LIEN,IBDATA
 N X,Y,DIE,DA,DR,DTOUT,DATA
 ;
 ; Grab all of the entries to update
 F LOOP=1:1:21 D
 . ;Extract the new ACTION TYPE to be added.
 . S RCDATA=$T(ARDAT+LOOP)
 . S RCDATA=$P(RCDATA,";;",2)
 . S RCNM=$P(RCDATA,";",1),RCFLG=$P(RCDATA,";",2)
 . S LIEN=$O(^PRCA(430.2,"B",RCNM,""))  ; find CHARGE REMOVE REASON entry 
 . Q:LIEN=""
 . ;
 . ; File the update along with inactivate the ACTION TYPE
 . S DR="1.04///"_RCFLG
 . S DIE="^PRCA(430.2,",DA=LIEN
 . D ^DIE
 . K DR   ;Clear update array before next use
 ;
 S DR=""
 D MES^XPDUTL("     -> Updated the DISPLAY IN TRANS PROFILE field in the AR Category (430.3) file.")
 Q
 ;
ARDAT ; Cancellation reasons (350.3) to update
 ;;C (MEANS TEST);4
 ;;HOSPITAL CARE (NSC);4
 ;;HOSPITAL CARE PER DIEM;4
 ;;NURSING HOME CARE PER DIEM;3
 ;;NURSING HOME CARE(NSC);3
 ;;OUTPATIENT CARE(NSC);2
 ;;RX CO-PAYMENT/NSC VET;1
 ;;RX CO-PAYMENT/SC VET;1
 ;;CHOICE INPT;4
 ;;CHOICE OPT;2
 ;;CHOICE RX CO-PAYMENT;5
 ;;CC INPT;4
 ;;CC OPT;2
 ;;CC RX CO-PAYMENT;5
 ;;CCN INPT;4
 ;;CCN OPT;2
 ;;CCN RX CO-PAYMENT;5
 ;;CC MTF INPT;4
 ;;CC MTF OPT;2
 ;;CC MTF RX CO-PAYMENT;5
 ;;CC URGENT CARE;2
 ;;END
 ;
