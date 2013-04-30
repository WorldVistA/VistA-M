FBAAVR3 ;WOIFO/SAB - FINALIZE BATCH (CONT) ;4/10/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
CHKSPLT ; check for split invoices for batch
 ; input FBN - batch IEN (file 161.7), must be type B3
 ; output FBLNLST(FBIENS) - array of line items still in batch for
 ;                          split invoices
 N DIR,DIROUT,DIRUT,DTOUT,FBINLST,X,Y
 ;
 ; build list of split invoices
 D LSTSPIN(FBN,.FBINLST)
 ; build list of line items for split invoices
 D LSTLN(FBN,.FBINLST,.FBLNLST)
 ;
 I $D(FBINLST) D
 . W !,"This batch contains split invoice(s)."
 . W !," An invoice is split when some lines on invoice are flagged as"
 . W !," rejected and other lines are not flagged as rejected."
 . W !," Current policy is to keep all invoice lines together."
 . ;
 . S DIR(0)="Y",DIR("A")="Do you want a list of split invoices"
 . S DIR("B")="YES"
 . D ^DIR Q:$D(DIRUT)
 . ;
 . I Y D
 . . N FBDFN,FBIN,FBX
 . . ; loop thru split invoices
 . . S FBIN="" F  S FBIN=$O(FBINLST(FBIN)) Q:FBIN=""  D
 . . . W !,"  Invoice ",FBIN," is split"
 . . . S FBDFN=0 F  S FBDFN=$O(FBINLST(FBIN,FBDFN)) Q:'FBDFN  D
 . . . . S FBX=FBINLST(FBIN,FBDFN)
 . . . . W !,"    Patient: ",$P(FBX,"^")," with ",$P(FBX,"^",2)," line",$S($P(FBX,"^",2)'=1:"s that are",1:" that is")," not rejected."
 . ;
 . W !
 ;
 Q
 ;
LSTSPIN(FBN,FBINLST) ; build list of split invoices for a batch
 ; input
 ;   FBN - batch IEN file 161.7. must be type B3
 ;   FBINLST - array, passed by reference
 ; output
 ;   FBLST - initialized and updated
 ;     FBINLST(FBIN)=""
 ;       where FBIN is an invoice number
 ;       note: FBINLST will not be defined if batch is empty
 ;
 N FBDA,FBIENS,FBIN
 K FBINLST
 Q:'$G(FBN)
 ;
 ; loop thru rejected lines for batch
 S FBDA(3)=0 F  S FBDA(3)=$O(^FBAAC("AH",FBN,FBDA(3))) Q:'FBDA(3)  D
 . S FBDA(2)=0
 . F  S FBDA(2)=$O(^FBAAC("AH",FBN,FBDA(3),FBDA(2))) Q:'FBDA(2)  D
 . . S FBDA(1)=0
 . . F  S FBDA(1)=$O(^FBAAC("AH",FBN,FBDA(3),FBDA(2),FBDA(1))) Q:'FBDA(1)  D
 . . . S FBDA=0
 . . . F  S FBDA=$O(^FBAAC("AH",FBN,FBDA(3),FBDA(2),FBDA(1),FBDA)) Q:'FBDA  D
 . . . . S FBIENS=FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_","
 . . . . S FBIN=$$GET1^DIQ(162.03,FBIENS,14) ; INVOICE NUMBER
 . . . . Q:FBIN=""
 . . . . Q:'$D(^FBAAC("AJ",FBN,FBIN))  ; no unrejected lines in batch
 . . . . S FBINLST(FBIN)="" ; add to list of split invoices
 ;
 Q
 ;
LSTLN(FBN,FBINLST,FBLNLST) ; build list of line items
 ; input
 ;   FBN     - batch IEN file 161.7. must be type B3
 ;   FBINLST - array of invoices, passed by reference
 ;             FBINLST(FBIN)
 ;             where FBIN is an invoice number
 ;   FBLNLST - array of line items, passed by reference
 ; output
 ;   FBINLST - array of invoices, passed by reference
 ;             will be updated by adding the following node
 ;             FBINLST(FBIN,FBDFN)=patient name^line item count
 ;             where FBDFN is the patient IEN (file 161 & file 2)
 ;   FBLNLST - array of line items, passed by reference
 ;             FBLNLST(FBIENS)=""
 ;             where FBIENS is the IENS for a line item,
 ;               FileMan DBS format
 ;             this array will contain a list of line items still in
 ;             input batch FBN for the invoices in input array FBINLST 
 ;             Note: array is initialized and will not be defined
 ;               if there are no line items
 ;
 N FBC,FBDA,FBIN
 K FBLNLST
 Q:'$G(FBN)
 ;
 ; loop thru invoices in array
 S FBIN="" F  S FBIN=$O(FBINLST(FBIN)) Q:FBIN=""  D
 . ; loop thru patients for invoice in batch
 . S FBDA(3)=0
 . F  S FBDA(3)=$O(^FBAAC("AJ",FBN,FBIN,FBDA(3))) Q:'FBDA(3)  D
 . . S FBC=0 ; init line count for invoice & patient
 . . S FBDA(2)=0
 . . F  S FBDA(2)=$O(^FBAAC("AJ",FBN,FBIN,FBDA(3),FBDA(2))) Q:'FBDA(2)  D
 . . . S FBDA(1)=0
 . . . F  S FBDA(1)=$O(^FBAAC("AJ",FBN,FBIN,FBDA(3),FBDA(2),FBDA(1))) Q:'FBDA(1)  D
 . . . . S FBDA=0 F  S FBDA=$O(^FBAAC("AJ",FBN,FBIN,FBDA(3),FBDA(2),FBDA(1),FBDA)) Q:'FBDA  D
 . . . . . ; add to line item array
 . . . . . S FBLNLST(FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_",")=""
 . . . . . ; increment line count for invoice & patient
 . . . . . S FBC=FBC+1
 . . ;
 . . ; update invoice array with save patient name and line count
 . . S FBINLST(FBIN,FBDA(3))=$$GET1^DIQ(161,FBDA(3),.01)_"^"_FBC
 ;
 Q
 ;
 ;FBAAVR3
