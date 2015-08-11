PRCAP298 ;BIRM/EWL ALB/hrubovcak - ePayment Lockbox Post-Installation Processing ;Dec 20, 2014@14:08:45
 ;;4.5;Accounts Receivable;**298**;Jan 21, 2014;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; References to ^XPDMENU supported by DBIA 1157
 Q
 ;
PRE ; pre-installation processing
 ; delete old "C" cross-reference in ERA file (#344.4)
 D DELIX^DDMOD(344.4,.06,1,"K")
 D BMES^XPDUTL("Removed old cross-reference in file #344.4")
 Q
 ;
POST ; PRCA*4.5*298 post-installation processing
 D DELOPT ; remove RCDPE EOB TRANSFER REPORTS option
 D SETPARMS ; set parameters in RCDPE PARAMETER file (#344.61)
 D INITPRMS ; initialize file #344.6, cross-ref. files #344.31 & #344.4
 Q
 ;
DELOPT ; remove RCDPE EOB TRANSFER REPORTS option
 N DA,DIK,MEN,OPT,RET
 ; RET - value returned from
 S MEN="RCDPE EDI LOCKBOX REPORTS MENU"
 S OPT="RCDPE EOB TRANSFER REPORTS"
 D BMES^XPDUTL("Updating ["_MEN_"]")
 S RET=$$DELETE^XPDMENU(MEN,OPT)  ; delete option from menu
 S DA=+$$LKOPT^XPDMENU(OPT)  ; get option IEN
 I DA>0 S DIK="^DIC(19," D ^DIK  ; code can be re-run if already deleted
 D MES^XPDUTL("Menu update "_$S(RET:"completed.",1:"not needed."))
 ;
 Q
 ;
SETPARMS ; update RCDPE PARAMETER file (#344.61)
 N PRFDA,PRIENS,SITE,X
 ; PRFDA - Array for the ^DIE call
 ; PRIENS - IENS value for ^DIE
 ; SITE - site number from file #342,.01 SITE (POINTER TO INSTITUTION FILE (#4))
 ;
 D MES^XPDUTL("Updating RCDPE PARAMETER file (#344.61)")
 S SITE=$$GET1^DIQ(342,1,.01,"I")
 I 'SITE D  Q
 .; This should never happen.  If it does, there are bigger problems. 
 .D MES^XPDUTL("*******************************************************************************")
 .D MES^XPDUTL("**                                                                           **")
 .D MES^XPDUTL("** There is a problem with the AR SITE PARAMETER file.  This will need to be **")
 .D MES^XPDUTL("** fixed.  The RCDPE PARAMETER file cannot be initialized.                   **")
 .D MES^XPDUTL("**                                                                           **")
 .D MES^XPDUTL("** Once the AR SITE PARAMETER file is fixed, re-run SETPARMS^PRCAP298        **")
 .D MES^XPDUTL("**                                                                           **")
 .D MES^XPDUTL("*******************************************************************************")
 ;
 S X=$G(^RCY(344.61,1,0))
 ; if parameters already initialized set cutoff date and exit
 I $P(X,U) S $P(X,U,9)=DT,^RCY(344.61,1,0)=X D MES^XPDUTL("Updated PHARMACY EFT CUTOFF DATE") Q
 D MES^XPDUTL("Initializing parameters.")
 S PRIENS=$S($D(^RCY(344.61,1)):"1,",1:"+1,")
 S PRFDA(344.61,PRIENS,.01)=SITE  ; pointer to INSTITUTION file (#4)
 S PRFDA(344.61,PRIENS,.03)=0  ; AUTO-DECREASE MED ENABLED
 S PRFDA(344.61,PRIENS,.06)=21  ; MEDICAL EFT POST PREVENT DAYS
 S PRFDA(344.61,PRIENS,.07)=999 ; PHARMACY EFT POST PREVENT DAYS
 S PRFDA(344.61,PRIENS,.09)=DT  ; PHARMACY EFT CUTOFF DATE
 ;
 I PRIENS="+1," D UPDATE^DIE(,"PRFDA")  ; create new entry
 I PRIENS="1," D FILE^DIE(,"PRFDA")  ; update existing entry
 ;
 D MES^XPDUTL("Finished updates to RCDPE PARAMETER file (#344.61)")
 Q
 ;
INITPRMS ; Task jobs to initialize file #344.6, cross-ref. files #344.31 & #344.4
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ; set ^XTMP zero node for 180 day retention
 S ^XTMP($T(+0),0)=$$HTFM^XLFDT($H+180)_U_DT_"^PRCA*4.5*298 post-installation"
 D BMES^XPDUTL("Post-installation tasks "_$$FMTE^XLFDT($$NOW^XLFDT))  ; add date/time to log
 D BMES^XPDUTL("Queueing tasks for files #344.6 and #344.4")
 S ZTRTN="ERAPSTIN^"_$T(+0),ZTDESC="ERA (#344.4) post-init work",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 D MES^XPDUTL($S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task."))
 I $G(ZTSK)  D MES^XPDUTL("A MailMan message will be sent on completion.")
 ;
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK  ; delete residual values
 D BMES^XPDUTL(" "_$$FMTE^XLFDT($$NOW^XLFDT))  ; add date/time to log
 D MES^XPDUTL("Queueing EDI THIRD PARTY EFT DETAIL file cross-ref. task.")
 S ZTRTN="E3PDXREF^"_$T(+0),ZTDESC="EDI THIRD PARTY EFT DETAIL file cross-ref.",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 D MES^XPDUTL($S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task."))
 I $G(ZTSK) D MES^XPDUTL("A MailMan message will be sent on completion.")
 ;
 D BMES^XPDUTL("Done queuing tasks "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
ERAPSTIN ; entry point from TaskMan to initialize file #344.6 and cross-ref. file #344.4
 ; sends MailMan message on completion, this subroutine can be called manually
 ;
 N ERA0,ERAIEN,PRADD,PRATRI,PRCXREF,PRDNLZ,PRHXREF,PRERATTL,PRID,PRNODE,PRPAYER,PRXMBODY,PRXMSUBJ,PRXMTO,PRXMZR,X,X2,X3,XMINSTR,XR,XRS
 ; ERA0 - zero node of ERA
 ; ERAIEN - IEN in file #344.4
 ; PRADD - total updated in file #344.6 counter
 ; PRATRI - 'ATRIDUP' cross-ref. counter
 ; PRDNLZ - 'DNLZ' cross-ref. counter
 ; PRHXREF - 'H' cross-ref. counter
 ; PRID - Payer ID
 ; PRNODE - ^XTMP storage node
 ; PRPAYER - payer name
 ; PRXMBODY - root of message body
 ; PRXMSUBJ - message subject
 ; PRXMTO - array of MailMan message recipients
 ;
 S PRNODE="ERAPOST4"
 ; loop through ELECTRONIC REMITTANCE ADVICE file #344.4
 S PRADD=0  ; payers added to file #344.6
 S PRDNLZ=0  ; 'DNLZ' cross-refs. added this run
 S PRATRI=0  ; 'ATRIDUP' cross-refs. added this run
 S PRCXREF=0  ; 'C' cross-refs. added this run
 S PRHXREF=0  ; 'H' cross=refs. added this run
 S PRERATTL=0  ; ERA entries examined
 S PRNODE("BEG")=$$NOW^XLFDT
 S ERAIEN=$G(^XTMP($T(+0),PRNODE,"LAST"))
 I ERAIEN="" S ERAIEN=$C(1)  ; iterating backwards, set to value past numbers
 ; if not already run, clean up old 'C' and 'H' cross-refs., they will be re-created
 I '$G(^XTMP($T(+0),PRNODE,"FINISHED")) K ^RCY(344.4,"C"),^RCY(344.4,"H")
 ; run only once
 I '$G(^XTMP($T(+0),PRNODE,"FINISHED")) F  S ERAIEN=$O(^RCY(344.4,ERAIEN),-1) Q:'ERAIEN  S ERA0=$G(^RCY(344.4,ERAIEN,0)) D:ERA0]""
 .S PRERATTL=PRERATTL+1
 .;add Payer Name and Payer ID to #344.6
 .S PRPAYER=$P(ERA0,U,6),PRID=$P(ERA0,U,3) D
 ..Q:(PRPAYER="")!(PRID="")  ; must have name and ID
 ..I '$D(^RCY(344.6,"CPID",$E(PRPAYER,1,60),$E(PRID,1,30))) D PAYRINIT^RCDPESP(ERAIEN) S PRADD=PRADD+1  ; only if entry doesn't exist
 .;
 .;set 'ATRIDUP' cross-ref. for TRACE # field (#.02) and INSURANCE CO ID (#.03)
 .S X2=$P(ERA0,U,2),X3=$P(ERA0,U,3) D:(X2]"")&(X3]"")  ; both fields must have values
 ..S X2=$$UP($E(X2,1,50)),X3=$$UP($E(X3,1,30))  ; set case and length
 ..S ^RCY(344.4,"ATRIDUP",X2,X3,ERAIEN)="",PRATRI=PRATRI+1
 .; set 'DNLZ' cross-reference
 .S X=$P(ERA0,U,2) I X]"" D:X?.N!($E(X)=0)  ; TRACE # field (#.02), numerics or leading zero
 ..I $E(X)=0&($L(X)>2) F  S X=$E(X,2,$L(X)) Q:$L(X)<2!'($E(X)=0)  ; strip extra leading zeroes
 ..S:X]"" ^RCY(344.4,"DNLZ",X_" ",ERAIEN)="",PRDNLZ=PRDNLZ+1
 .; set 'C' cross-reference for PAYMENT FROM field (#.06)
 .S X=$P(ERA0,U,6) S:$TR(X," ")]"" ^RCY(344.4,"C",$$UP($E(X,1,60)),ERAIEN)="",PRCXREF=PRCXREF+1
 .; set 'H' cross-reference for ERA Detail
 .D:$D(^RCY(344.4,ERAIEN,1,"RECEIPT"))
 ..S XR=0 F  S XR=$O(^RCY(344.4,ERAIEN,1,"RECEIPT",XR)) Q:XR=""  S XRS="" D
 ...F  S XRS=$O(^RCY(344.4,ERAIEN,1,"RECEIPT",XR,XRS)) Q:XRS=""  S ^RCY(344.4,"H",XR,ERAIEN,XRS)="",PRHXREF=PRHXREF+1
 .;
 .S ^XTMP($T(+0),PRNODE,"LAST")=ERAIEN  ; last IEN processed
 ;
 S PRNODE("END")=$$NOW^XLFDT
 I '$G(^XTMP($T(+0),PRNODE,"FINISHED")) S ^("FINISHED")=PRNODE("END")
 ; create MailMan message text
 S PRXMBODY(0)=0
 D ADD2TXT(.PRXMBODY,"Finished file #344.4 post-initialization tasks.")
 D ADD2TXT(.PRXMBODY,"  Process begun: "_$$FMTE^XLFDT(PRNODE("BEG")))
 D ADD2TXT(.PRXMBODY,"  Process ended: "_$$FMTE^XLFDT(PRNODE("END")))
 D ADD2TXT(.PRXMBODY," ")  ; blank line
 D ADD2TXT(.PRXMBODY,"         Total ERA entries checked: "_$FN(PRERATTL,",")) ;PRERATTL
 D ADD2TXT(.PRXMBODY," 'ATRIDUP' cross-refs. file #344.4: "_$FN(PRATRI,","))
 D ADD2TXT(.PRXMBODY,"       'C' cross-refs. file #344.4: "_$FN(PRCXREF,","))
 D ADD2TXT(.PRXMBODY,"    'DNLZ' cross-refs. file #344.4: "_$FN(PRDNLZ,","))
 D ADD2TXT(.PRXMBODY,"       'H' cross-refs. file #344.4: "_$FN(PRHXREF,","))
 D ADD2TXT(.PRXMBODY," ")  ; blank line
 D ADD2TXT(.PRXMBODY,"      Entries added to file #344.6: "_$FN(PRADD,","))
 D ADD2TXT(.PRXMBODY," ")  ; blank line
 I $G(ZTSK) D ADD2TXT(.PRXMBODY," * Queued as Task #"_ZTSK_" *")
 D ADD2TXT(.PRXMBODY,"Report generated by the "_$T(+0)_" post-initialization routine.")
 ;
 ; save MailMan message text
 M ^XTMP($T(+0),PRNODE,"MAIL MSG",$$NOW^XLFDT)=PRXMBODY
 ; send via MailMan
 S PRXMSUBJ="PRCA*4.5*298 files #344.4 & #344.6 post-init completed"
 S PRXMTO(.5)="",PRXMTO(DUZ)=""  ; POSTMASTER and user who queued it
 S PRXMTO("G.RCDPE PAYMENTS MGMT")=""
 S XMINSTR("FROM")="POSTMASTER"
 ;
 D SENDMSG^XMXAPI(DUZ,PRXMSUBJ,"PRXMBODY",.PRXMTO,.XMINSTR,.PRXMZR)  ; send message
 I $G(PRXMZR),'$G(ZTSK),$E(IOST,1,2)="C-" W !,"MailMan message number: "_PRXMZR
 Q
 ;
 ;
E3PDXREF ; set 'ADR', 'F', and 'FNLZ' cross-refs. in EDI THIRD PARTY EFT DETAIL file (#344.31)
 ; sends MailMan message on completion, this subroutine can be called manually
 ;
 N PR310,PR31IEN,PRADR,PRF,PRFNLZ,PRNODE,PRTOTL,PRXMBODY,PRXMSUBJ,PRXMTO,PRXMZR,X,XMINSTR
 ; PR310 - zero node for entry
 ; PR31IEN - IEN in ELECTRONIC REMITTANCE ADVICE
 ; PRADR -  count of "ADR" cross-refs. set
 ; PRF - count of "F" cross-refs. set
 ; PRFNLZ - count of "F" cross-refs. set
 ; PRNODE - ^XTMP storage node
 ; PRTOTL - count of entries checked
 ; PRXMSUBJ - message subject
 ; PRXMTO - array of MailMan message recipients
 ; PRXMZR - message number returned
 ;
 S PRNODE="E3PDXREF"
 S (PRF,PRFNLZ,PRADR,PRTOTL)=0,PRNODE("BEG")=$$NOW^XLFDT
 ;
 S PR31IEN=$G(^XTMP($T(+0),PRNODE,"LAST"))
 I PR31IEN="" S PR31IEN=$C(1)  ; iterating backwards, set to value past numbers
 ; run only once
 I '$G(^XTMP($T(+0),PRNODE,"FINISHED")) F  S PR31IEN=$O(^RCY(344.31,PR31IEN),-1) Q:'(PR31IEN>0)  D
 .S PR310=$G(^RCY(344.31,PR31IEN,0)) Q:PR310=""  ; zero node of entry
 .S PRTOTL=PRTOTL+1,X=$P(PR310,U,4) S:X]"" ^RCY(344.31,"F",$E(X,1,50),PR31IEN)="",PRF=PRF+1
 .I X]"" D:X?.N!($E(X)=0)  ; TRACE # field (#.02), only numerics or leading zero
 ..I $E(X)=0&($L(X)>2) F  S X=$E(X,2,$L(X)) Q:$L(X)<2!'($E(X)=0)  ; strip extra leading zeroes
 ..S:X]"" ^RCY(344.31,"FNLZ",X_" ",PR31IEN)="",PRFNLZ=PRFNLZ+1
 .;
 .S X=$P(PR310,U,13) S:X]"" ^RCY(344.31,"ADR",X,PR31IEN)="",PRADR=PRADR+1
 .S ^XTMP($T(+0),PRNODE,"LAST")=PR31IEN
 ;
 ; disable 'D' new-style cross-ref., replaced by traditional 'F' cross-ref.
 I '$G(^XTMP($T(+0),PRNODE,"FINISHED")) D:$D(^RCY(344.31,"D"))
 .N PRDIERR,PRDIMSG  ; error root, message root
 .D DELIXN^DDMOD(344.31,"D","KW","PRDIMSG","PRDIERR")  ; supported FileMan database server API
 ;
 S PRNODE("END")=$$NOW^XLFDT
 I '$G(^XTMP($T(+0),PRNODE,"FINISHED")) S ^("FINISHED")=PRNODE("END")
 ; create MailMan message text
 S PRXMBODY(0)=0
 D ADD2TXT(.PRXMBODY,"Updated cross-references for file #344.31")
 D ADD2TXT(.PRXMBODY," Work begun: "_$$FMTE^XLFDT(PRNODE("BEG")))
 D ADD2TXT(.PRXMBODY," Work ended: "_$$FMTE^XLFDT(PRNODE("END")))
 D ADD2TXT(.PRXMBODY," ")  ; blank line
 D ADD2TXT(.PRXMBODY,"  Total Entries examined: "_$FN(PRTOTL,","))
 D ADD2TXT(.PRXMBODY," ")  ; blank line
 D ADD2TXT(.PRXMBODY,"    'F' cross-ref. total: "_$FN(PRF,","))
 D ADD2TXT(.PRXMBODY," 'FNLZ' cross-ref. total: "_$FN(PRFNLZ,","))
 D ADD2TXT(.PRXMBODY,"  'ADR' cross-ref. total: "_$FN(PRADR,","))
 D ADD2TXT(.PRXMBODY," ")  ; blank line
 I $G(ZTSK) D ADD2TXT(.PRXMBODY," * Queued as Task #"_ZTSK_" *")
 D ADD2TXT(.PRXMBODY,"Report generated by the "_$T(+0)_" post-initialization routine.")
 ;
 ; save MailMan message text
 M ^XTMP($T(+0),PRNODE,"MAIL MSG",$$NOW^XLFDT)=PRXMBODY
 ; send report via MailMan
 S XMINSTR("FROM")="POSTMASTER"
 S PRXMSUBJ="PRCA*4.5*298 file #344.31 post-init completed"
 S PRXMTO(.5)="",PRXMTO(DUZ)=""  ; POSTMASTER and user who queued it
 S PRXMTO("G.RCDPE PAYMENTS MGMT")=""
 ;
 D SENDMSG^XMXAPI(DUZ,PRXMSUBJ,"PRXMBODY",.PRXMTO,.XMINSTR,.PRXMZR)  ; send message
 I $G(PRXMZR),'$G(ZTSK),$E(IOST,1,2)="C-" D MES^XPDUTL("MailMan message number: "_PRXMZR)
 ;
 Q
 ;
ADD2TXT(TXARY,LN) ; add LN to TXARY for MailMan Message
 ; TXARY passed by ref.
 Q:$G(LN)=""
 S TXARY(0)=$G(TXARY(0))+1,TXARY(TXARY(0),0)=LN Q
 ;
 ; function, returns uppercase
UP(T) Q $TR(T,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
