BPS10P17 ; ALB/hrubovcak - BPS*1.0*17 Post-Installation Processing ;Jun 06, 2014@19:13:53
 ;;1.0;E CLAIMS MGMT ENGINE;**17**; 15 May 2014;Build 99
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; References to ^XPDMENU supported by DBIA 1157
 Q
 ;
PRE ; pre-installation processing
 ;
 Q
 ;
POST ; post-installation processing
 D XREF ; cross-ref. file #9002313.57
 Q
 ;
XREF ; Task job to cross-ref. #9002313.57
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 D MES^XPDUTL(" "),MES^XPDUTL(" "_$$FMTE^XLFDT($$NOW^XLFDT))  ; add blank line and date/time to log
 D MES^XPDUTL("Queueing the BPS LOG OF TRANSACTIONS file (#9002313.57) cross-reference task.")
 S ZTRTN="AECXREF^BPS10P17",ZTDESC="BPS LOG OF TRANSACTIONS file cross-ref.",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 D MES^XPDUTL($S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task."))
 I $G(ZTSK) D MES^XPDUTL("A MailMan message will be sent on completion.")
 ;
 Q
 ;
AECXREF ; set "AEC" cross-ref. for PRESCRIPTION NUMBER field (#1.11) in BPS LOG OF TRANSACTIONS file (#9002313.57)
 ; sends MailMan message on completion, this subroutine can be called manually
 ;
 N BPSCNTR,BPSDA,BPTOTL,BPXMBODY,BPXMSUBJ,BPXMTO,BPXMZR,DA,DIK,X
 ; DA, DIK used for ^DIK call
 ; BPSDA - IEN in BPS LOG OF TRANSACTIONS
 ; BPSCNTR - count of cross-refs. set
 ; BPTOTL - count of entries checked
 ; BPXMSUBJ - message subject
 ; BPXMTO - array of MailMan message recipients
 ; BPXMZR - message number returned
 ;
 ; loop through BPS LOG OF TRANSACTIONS file (#9002313.57), find PRESCRIPTION NUMBER
 S (BPSCNTR,BPTOTL)=0,BPSCNTR("BEG")=$$NOW^XLFDT
 ;
 S BPSDA=$C(1)  ; iterating backwards, set to value past numbers
 F  S BPSDA=$O(^BPSTL(BPSDA),-1) Q:'(BPSDA>0)  D
 .S BPTOTL=BPTOTL+1,X=$P($G(^BPSTL(BPSDA,1)),U,11) Q:X=""
 .Q:$D(^BPSTL("AEC",X,BPSDA))  ; cross-ref. exists
 .S DA=BPSDA,DIK="^BPSTL(",DIK(1)="1.11^AEC",BPSCNTR=BPSCNTR+1 D IX1^DIK
 ;
 S BPSCNTR("END")=$$NOW^XLFDT
 ; create MailMan message text
 S BPXMBODY(1,0)="Finished cross-reference of BPS LOG OF TRANSACTIONS file (#9002313.57)"
 S BPXMBODY(2,0)="for the PRESCRIPTION NUMBER field (#1.11)"
 S BPXMBODY(3,0)="          Total Entries examined: "_$FN(BPTOTL,",")
 S BPXMBODY(4,0)="  Prescriptions cross-referenced: "_$FN(BPSCNTR,",")
 S BPXMBODY(5,0)=" Work begun: "_$$FMTE^XLFDT(BPSCNTR("BEG"))
 S BPXMBODY(6,0)=" Work ended: "_$$FMTE^XLFDT(BPSCNTR("END"))
 S:$G(ZTSK) BPXMBODY(7,0)=" * Queued as Task #"_ZTSK_" *"
 ;
 ; send via MailMan
 S BPXMSUBJ="Updated cross-reference of BPS LOG OF TRANSACTIONS"
 S BPXMTO(.5)="",BPXMTO(DUZ)=""  ; POSTMASTER and user who queued it
 S BPXMTO("G.RCDPE PAYMENTS MGMT")=""
 ;
 D SENDMSG^XMXAPI(DUZ,BPXMSUBJ,"BPXMBODY",.BPXMTO,,.BPXMZR)  ; send message
 I $G(BPXMZR),'$G(ZTSK),$E(IOST,1,2)="C-" D MES^XPDUTL("MailMan message number: "_BPXMZR)
 ;
 Q
 ;
