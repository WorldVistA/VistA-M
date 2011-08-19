FBXIP116 ;DALOI/KML-PATCH INSTALL ROUTINE ; 11/19/2010
 ;;3.5;FEE BASIS;**116**;JAN 30, 1995;Build 30
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q:'$G(XPDENV)  ; routine is to be called only during install package option
 ; check for invoices totaling $0 that exist in batches that are "in-process"
 ; batches to examine are those that are in statuses of:
 ; "C" = CLERK CLOSED 
 ; "R" = REVIEWED AFTER PRICER
 ; "S" = SUPERVISOR CLOSED
 ; if any zero dollar invoices exist 
 ; the invoices will need to be reported and the patch install cannot occur
 W !,"Environmental check routine is executing."
 N DD,DO,DIE,DR,X,Y
 N FBSTAT,FBX,FB0,FBT,FBN,FBBATCH,FBINV
 K ^TMP("FBXIP116")
 F FBSTAT="C","R","S" D
 . S FBN=0
 . F  S FBN=$O(^FBAA(161.7,"AC",FBSTAT,FBN)) Q:'FBN  D
 . . S FB0=$G(^FBAA(161.7,FBN,0))
 . . S FBT=$P(FB0,U,3),FBBATCH=$P(FB0,U)
 . . I FBT]"","B3,B5,B9"[FBT D @FBT
 I $D(FBINV) D GZERO
 I $D(XPDABORT) W !,$C(7),"There are invoices that need further processing before installation of patch can be performed.",!,"Installation of patch has terminated"
 Q
 ;
B3 ; process outpatient/ancillary batch
 Q:FBT'="B3"
 N DA,FBAAIN,FBAMTPD,FBY0
 ; loop thru items in batch and build list of invoices and their $
 S DA(3)=0 F  S DA(3)=$O(^FBAAC("AC",FBN,DA(3))) Q:'DA(3)  D
 . S DA(2)=0 F  S DA(2)=$O(^FBAAC("AC",FBN,DA(3),DA(2))) Q:'DA(2)  D
 . . S DA(1)=0
 . . F  S DA(1)=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1))) Q:'DA(1)  D
 . . . S DA=0
 . . . F  S DA=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1),DA)) Q:'DA  D
 . . . . S FBY0=$G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0))
 . . . . S FBAAIN=$P(FBY0,U,16)
 . . . . S FBAMTPD=$P(FBY0,U,3)
 . . . . I FBAAIN]"" S FBINV(3,FBBATCH,FBAAIN)=$G(FBINV(3,FBBATCH,FBAAIN))+FBAMTPD
 Q
 ;
B5 ; processes pharmacy batch
 Q:FBT'="B5"
 N DA,FBAAIN,FBAMTPD,FBRXY0,FBY0
 ;
 ; loop thru items in batch and build list of invoices and their $
 S DA(1)=0 F  S DA(1)=$O(^FBAA(162.1,"AE",FBN,DA(1))) Q:'DA(1)  D
 . S DA=0 F  S DA=$O(^FBAA(162.1,"AE",FBN,DA(1),DA)) Q:'DA  D
 . . S FBY0=$G(^FBAA(162.1,DA(1),0))
 . . S FBRXY0=$G(^FBAA(162.1,DA(1),"RX",DA,0))
 . . S FBAAIN=$P(FBY0,U)
 . . S FBAMTPD=$P(FBRXY0,U,16)
 . . I FBAAIN]"" S FBINV(5,FBBATCH,FBAAIN)=$G(FBINV(5,FBBATCH,FBAAIN))+FBAMTPD
 Q
 ;
B9 ; processes inpatient batch
 Q:FBT'="B9"
 N DA,FBAAIN,FBAMTPD,FBY0
 ;
 ; loop thru items in batch and save zero dollar invoices
 S DA=0 F  S DA=$O(^FBAAI("AC",FBN,DA)) Q:'DA  D
 . S FBY0=$G(^FBAAI(DA,0))
 . S FBAAIN=$P(FBY0,U)
 . S FBAMTPD=$P(FBY0,U,9)
 . Q:+FBAMTPD>0
 . S FBINV(9,FBBATCH,FBAAIN)=""
 Q
 ;
GZERO ; loop thru invoices and save invoices with 0.00 payment
 N FBT,FBAAIN,FBBN
 S (FBBN,FBAAIN)=0
 F FBT=3,5,9 D
 . F  S FBBN=$O(FBINV(FBT,FBBN)) Q:FBBN=""  D
 . . F  S FBAAIN=$O(FBINV(FBT,FBBN,FBAAIN)) Q:FBAAIN=""  D
 . . . I +FBINV(FBT,FBBN,FBAAIN)'>0 S FBINV(FBT,FBBN,FBAAIN)="" Q
 . . . K FBINV(FBT,FBBN,FBAAIN)
 I $D(FBINV) S XPDABORT=2 D BULLETIN
 Q
 ;
BULLETIN ;
 N FBT,FBI,FBBN,FBL,FBTYP
 S ^TMP("FBXIP116",$J,1)="The Fee Basis patch FB*3.5*116 did not get installed because there exist"
 S ^TMP("FBXIP116",$J,2)="invoice(s) in Fee Basis payment batches that have a total AMOUNT PAID of "
 S ^TMP("FBXIP116",$J,3)="$0.00.  Once patch 116 is installed the system will not allow an invoice"
 S ^TMP("FBXIP116",$J,4)="that totals $0.  The patch will also begin the transmission of 0.00"
 S ^TMP("FBXIP116",$J,5)="payment lines to Central Fee in Austin; however, $0 invoices are not"
 S ^TMP("FBXIP116",$J,6)="accepted by FMS.  There are one or two actions that must be taken before"
 S ^TMP("FBXIP116",$J,7)="patch 116 can be installed on your system:"
 S ^TMP("FBXIP116",$J,8)="1.  Execute the Queue Data for Transmission option to transmit the"
 S ^TMP("FBXIP116",$J,9)="    batches with the $0 invoices since pre-patched software will prevent"
 S ^TMP("FBXIP116",$J,10)="    $0 payment lines from being transmitted to Central Fee."
 S ^TMP("FBXIP116",$J,11)="2.  If a given batch is in a pre-released state ('CLOSED' or 'REVIEWED"
 S ^TMP("FBXIP116",$J,12)="    AFTER PRICER'), the batch can be re-opened and the invoice(s) can be"
 S ^TMP("FBXIP116",$J,13)="    edited to have an AMOUNT PAID greater than 0.00 or the invoice(s)"
 S ^TMP("FBXIP116",$J,14)="    will need to be removed from the associated batch."
 S ^TMP("FBXIP116",$J,15)=""
 S ^TMP("FBXIP116",$J,16)="Once the invoices have been reconciled, the Fee Basis patch can be installed."
 S ^TMP("FBXIP116",$J,17)=""
 S ^TMP("FBXIP116",$J,18)="            Invoice(s) Totaling Zero Dollars"
 S ^TMP("FBXIP116",$J,19)="Batch Type          Batch       Invoice"
 S ^TMP("FBXIP116",$J,20)="====================================================="
 S FBL=20,(FBBN,FBI)=0
 F FBT=3,5,9 D
 . S FBTYP=$S(FBT=3:"Medical Fee",FBT=5:"Pharmacy",FBT=9:"Civil Hospital",1:"*****")
 . I $D(FBINV(FBT)) F  S FBBN=$O(FBINV(FBT,FBBN)) Q:'FBBN  D
 . . F  S FBI=$O(FBINV(FBT,FBBN,FBI)) Q:'FBI  D
 . . . S FBL=FBL+1,^TMP("FBXIP116",$J,FBL)=FBTYP_"      "_FBBN_"        "_FBI
 D SENDMAIL
 Q
 ;
SENDMAIL ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="FB*3.5*116 - Zero Dollar Invoices exist."
 S XMDUZ=.5
 S XMTEXT="^TMP(""FBXIP116"",$J,"
 S XMY("G.FEE")="",XMY(DUZ)=""
 D ^XMD
 Q
 ;
TEST ; loop thru invoices and save invoices with 0.00 payment
 S CNT=0,BN=12300,INV=17900
 F FBT=3,5,9 D
 . F I=1:1:25 S CNT=CNT+1,BN=BN+CNT,INV=INV+CNT,FBINV(FBT,BN,INV)=""
 D BULLETIN
 Q
 ;
 ;FBXIP116
