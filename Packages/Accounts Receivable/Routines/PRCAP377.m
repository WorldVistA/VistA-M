PRCAP377 ;EDE/YMG - PRCA*4.5*377 POST INSTALL; 12/04/20
 ;;4.5;Accounts Receivable;**377**;Mar 20, 1995;Build 45
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*377")
 ; Add 2 new entries to the Transaction Type file
 D UPD4303
 ; Initialize the Repayment Plan Process field in the Transaction Type File
 D ADDRPP
 ; convert repayment plans in file 430 to entries in file 340.5
 D CONVERT
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*377")
 Q
 ;
CONVERT ; convert repayment plans in file 430 to entries in file 340.5
 N AMNT,BILL,CAT,CNT,DEBTOR,FDA,FDAIEN,IENS,N0,N4,N15,NEWTOT,NUMPMNT,RCRPIEN,REFDMC,REFTOP,RPPCNT,RPPID,STARTDT,TOTAL,Z
 D MES^XPDUTL("Converting existing repayment plans...")
 K ^TMP("PRCAP377",$J)
 S (CNT,RPPCNT)=0
 ; loop through AR bills with ACTIVE status
 S BILL=0 F  S BILL=$O(^PRCA(430,"AC",16,BILL)) Q:BILL=""  D
 .S N0=^PRCA(430,BILL,0),CAT=+$P(N0,U,2) I CAT'>0 Q
 .S TOTAL=$$BALANCE^RCRPRPU(BILL) I TOTAL'>0 Q  ; skip if total balance is 0
 .S N4=$G(^PRCA(430,BILL,4)) I N4="" Q          ; skip if node 4 in file 430 is blank - no repayment plan
 .I +$P(N4,U,5)>0 Q                             ; skip if 430/45 is populated - this entry has been converted already
 .S N15=$G(^PRCA(430,BILL,15))
 .I +$P(N15,U)>0,$P(N15,U,3)="" Q               ; skip if bill was referred to TSCP and was not recalled
 .S DEBTOR=+$P($G(^PRCA(430,BILL,0)),U,9) ; file 340 ien
 .I '$$GET1^DIQ(430.2,CAT_",",1.06,"I") D  Q    ; skip if not eligible for RPP and add to exception report
 ..S ^TMP("PRCAP377",$J,"CAT",DEBTOR,BILL)=CAT  ; AR category - ien in file 430.2
 ..Q
 .S RCRPIEN=+$O(^RCRP(340.5,"E",DEBTOR,""))
 .S AMNT=+$P(N4,U,3) I 'AMNT Q
 .S CNT=CNT+1 I '$D(ZTQUEUED) W:CNT#500=0 "."
 .S STARTDT=$$GETSTART^RCRPU(DT)
 .I 'RCRPIEN D
 ..; no entry in 340.5, create new plan
 ..S Z="000000"_($P($G(^RCRP(340.5,0)),U,3)+1)
 ..S RPPID=$$GETID^RCRPU(DEBTOR)_$E(Z,$L(Z)-5,$L(Z))
 ..S FDA(340.5,"+1,",.01)=RPPID    ; RPP ID
 ..S FDA(340.5,"+1,",.02)=DEBTOR   ; ptr to file 340
 ..S FDA(340.5,"+1,",.03)=DT       ; creation date
 ..S FDA(340.5,"+1,",.04)=STARTDT  ; start date
 ..S FDA(340.5,"+1,",.06)=AMNT     ; amount per month (from 430/43)
 ..S FDA(340.5,"+1,",.07)=2        ; status (set to "current")
 ..S FDA(340.5,"+1,",.08)=DT       ; status date
 ..S FDA(340.5,"+1,",.09)=0        ; # of forbearances
 ..D UPDATE^DIE("","FDA","FDAIEN")
 ..S RCRPIEN=FDAIEN(1) K FDAIEN I 'RCRPIEN Q
 ..D NEWAUDT(RCRPIEN) ; update sub-file 340.54
 ..D UPDDBTR^RCRPU(RCRPIEN,DEBTOR) ; update debtor file (340)
 ..S RPPCNT=RPPCNT+1
 ..S ^TMP("PRCAP377",$J,"CNV",RCRPIEN)=RPPID_U_DEBTOR
 ..Q
 .; skip bills with monthly amount that differs from the rest of repayment plan, add them to exception report
 .I AMNT'=$P(^RCRP(340.5,RCRPIEN,0),U,6) D  Q
 ..I '$D(^TMP("PRCAP377",$J,"AMNT")) S ^TMP("PRCAP377",$J,"AMNT")=$P(^RCRP(340.5,RCRPIEN,0),U,6)  ; monthly amount in repayment plan
 ..S ^TMP("PRCAP377",$J,"AMNT",DEBTOR,BILL)=AMNT  ; monthly amount for this bill
 ..Q
 .; if bill was referred to TOP or DMC, add it to TOP/DMC report
 .S REFDMC=+$P($G(^PRCA(430,BILL,12)),U)
 .S REFTOP=+$P($G(^PRCA(430,BILL,14)),U)
 .I REFTOP!REFDMC S ^TMP("PRCAP377",$J,"REF",DEBTOR,RCRPIEN,BILL)=$S(REFTOP:"TOP",1:"DMC")
 .;
 .D UPDBILL^RCRPU(RCRPIEN,BILL)  ; update sub-file 340.56
 .; update fields 430/41 and 430/45
 .S IENS=BILL_","
 .S FDA(430,IENS,41)=DT
 .S FDA(430,IENS,45)=RCRPIEN
 .D FILE^DIE("","FDA")
 .; add new transaction to file 433
 .D TRAN^RCRPU(BILL,TOTAL,67)
 .; update field 340.5/.11 (plan amount owed)
 .S FDA(340.5,RCRPIEN_",",.11)=TOTAL+$P(^RCRP(340.5,RCRPIEN,0),U,11) D FILE^DIE("","FDA")
 .; update schedule (sub-file 340.52)
 .I AMNT D
 ..S NEWTOT=$P(^RCRP(340.5,RCRPIEN,0),U,11)
 ..S NUMPMNT=NEWTOT\AMNT I NEWTOT#AMNT S NUMPMNT=NUMPMNT+1 ; # of payments (amount owed / amount per month, rounded up)
 ..D UPDSCHED(RCRPIEN,+$P(^RCRP(340.5,RCRPIEN,0),U,5),NUMPMNT,$S('$D(^RCRP(340.5,RCRPIEN,2)):STARTDT,1:""))
 ..; update # of payments
 ..S FDA(340.5,RCRPIEN_",",.05)=NUMPMNT D FILE^DIE("","FDA")
 ..Q
 .Q
 D MES^XPDUTL(" Done.")
 D MSG(CNT,RPPCNT),MSG1,MSG2
 K ^TMP("PRCAP377",$J)
 Q
 ;
UPDSCHED(RCIEN,RCORLN,RCNEWLN,RCSTDT) ; Update RPP schedule.
 ;
 ; RCRPIEN - IEN of the Repayment Plan being adjusted
 ; RCORLN - Original Term Length of the payments
 ; RCNEWLN - New Term Length
 ; RCSTDT - Plan start date (required for initial schedule, optional for adjustments)
 ;
 N DA,DIK,RCFLG,RCLP,RCLP1,RCPD,RCSUB
 ;
 S RCSTDT=$G(RCSTDT)
 S RCFLG=0
 ; Find the last date by looking for the last entry and grabbing the first piece.
 I RCSTDT="" S RCSTDT=$P($G(^RCRP(340.5,RCIEN,2,RCORLN,0)),U,1),RCFLG=1
 ; Clear RPP Temp array
 K ^TMP("RCRPP",$J)
 ;find all of the payments paid, stop on the first unpaid.
 S RCLP=0 F  S RCLP=$O(^RCRP(340.5,RCIEN,2,RCLP)) Q:'RCLP  S RCPD=$P($G(^RCRP(340.5,RCIEN,2,RCLP,0)),U,2) Q:'RCPD 
 ; Count the new remaining payment out.
 S RCLP1=RCLP+RCNEWLN-1   ;first missing payment + new length of payment - 1 for the first missing payment)
 ; remove the remaining payments from schedule
 F  S RCLP1=$O(^RCRP(340.5,RCIEN,2,RCLP1)) Q:'RCLP1  D
 .S DA(1)=RCIEN,DA=RCLP1,DIK="^RCRP(340.5,"_DA(1)_",2,"
 .D ^DIK K DA,DIK
 .Q
 ; add new payments to schedule.
 D BLDPLN^RCRPU(RCSTDT,(RCNEWLN-RCORLN),RCFLG)
 ; Add the new months to the Schedule
 ; Update the Schedule Node
 S RCSUB=0 F  S RCSUB=$O(^TMP("RCRPP",$J,"PLAN",RCSUB)) Q:'RCSUB  D UPDSCHED^RCRPU(RCIEN,RCSUB)
 ; Clear temp array
 K ^TMP("RCRPP",$J)
 ;
 Q
 ;
NEWAUDT(RCRPIEN) ; create new entry in sub-file 340.54
 ;
 ; RCRPIEN - file 340.5 ien
 ;
 N FDA,IENS
 S IENS="+1,"_RCRPIEN_","
 S FDA(340.54,IENS,.01)=DT  ; date of change
 S FDA(340.54,IENS,1)="N"   ; type of change = "NEW"
 S FDA(340.54,IENS,2)=.5    ; who changed = POSTMASTER
 S FDA(340.54,IENS,3)="N"   ; comment = "NEW PLAN"
 D UPDATE^DIE("","FDA")
 Q
 ;
MSG(BILCNT,RPPCNT) ; send Mailman notification for # of bills converted
 ;
 ; BILCNT - number of converted bills
 ; RPPCNT - number of repayment plans created
 ;
 N BAL,CNT,DEBTOR,DIFROM,IENS,RPIEN,RPPID,SSN,STAT,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,Z
 D MES^XPDUTL("Sending conversion message...")
 S CNT=1,^TMP("PRCAP377",$J,"MSG",CNT)="Conversion of existing repayment plans has been completed"
 S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="Total number of repayment plans created: "_RPPCNT
 S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="Total number of bills converted: "_BILCNT
 S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)=""
 ;
 I RPPCNT>0 D
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="The following repayment plans have been created:"
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)=""
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="Repayment Plan ID        Debtor                    SSN   Status   Balance"
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="-------------------------------------------------------------------------------"
 .S RPIEN="" F  S RPIEN=$O(^TMP("PRCAP377",$J,"CNV",RPIEN)) Q:RPIEN=""  D
 ..S Z=$G(^TMP("PRCAP377",$J,"CNV",RPIEN)),RPPID=$P(Z,U),DEBTOR=$P(Z,U,2)
 ..S IENS=RPIEN_",",STAT=$$GET1^DIQ(340.5,IENS,.07),BAL=$$GET1^DIQ(340.5,IENS,.11)
 ..S Z=$$SSN^RCFN01(DEBTOR),SSN=$E(Z,$L(Z)-3,$L(Z)) I SSN'>0 S SSN=" N/A" ; last 4 of ssn
 ..S CNT=CNT+1
 ..S ^TMP("PRCAP377",$J,"MSG",CNT)=RPPID_"  "_$$LJ^XLFSTR($$NAM^RCFN01(DEBTOR),"30T")_"  "_SSN_"  "_STAT_"  $"_$FN(BAL,"",2)
 ..Q
 .Q
 S XMSUB="PRCA*4.5*377 AR REPAYMENT PLAN CONVERSION",XMDUZ="AR PACKAGE"
 S XMY("G.RC REPAY PLANS")="",XMTEXT="^TMP(""PRCAP377"","_$J_",""MSG"","
 D ^XMD
 I $G(XMMG) D MES^XPDUTL(XMMG)
 K ^TMP("PRCAP377",$J,"MSG")
 D MES^XPDUTL(" Done.")
 Q
 ;
MSG1 ; send Mailman notification for exception report
 N BILL,CNT,DEBTOR,DIFROM,XMDUZ,XMMG,XMSUB,XMTEXT,XMY
 I '$D(^TMP("PRCAP377",$J,"AMNT")),'$D(^TMP("PRCAP377",$J,"CAT")) Q  ; nothing to send - bail out
 D MES^XPDUTL("Sending exceptions report message...")
 S CNT=1,^TMP("PRCAP377",$J,"MSG",CNT)="The following exceptions were encountered during the conversion:"
 S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)=""
 I $D(^TMP("PRCAP377",$J,"AMNT")) D
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="Bills not added to converted plan. Repay amount associated"
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="with individual bill differs from plan. Please review."
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)=""
 .S DEBTOR="" F  S DEBTOR=$O(^TMP("PRCAP377",$J,"AMNT",DEBTOR)) Q:DEBTOR=""  D
 ..S BILL="" F  S BILL=$O(^TMP("PRCAP377",$J,"AMNT",DEBTOR,BILL)) Q:BILL=""  D
 ...S CNT=CNT+1
 ...S ^TMP("PRCAP377",$J,"MSG",CNT)=$$LJ^XLFSTR($$NAM^RCFN01(DEBTOR),"30T")_"   "_$$LJ^XLFSTR($$GET1^DIQ(430,BILL_",",.01),"15T")_"    $"_$FN(^TMP("PRCAP377",$J,"AMNT",DEBTOR,BILL),"",2)
 ...Q
 ..Q
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)=""
 .Q
 I $D(^TMP("PRCAP377",$J,"CAT")) D
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)="Bills with AR categories not eligible for conversion"
 .S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)=""
 .S DEBTOR="" F  S DEBTOR=$O(^TMP("PRCAP377",$J,"CAT",DEBTOR)) Q:DEBTOR=""  D
 ..S BILL="" F  S BILL=$O(^TMP("PRCAP377",$J,"CAT",DEBTOR,BILL)) Q:BILL=""  D
 ...S CNT=CNT+1
 ...S ^TMP("PRCAP377",$J,"MSG",CNT)=$$LJ^XLFSTR($$NAM^RCFN01(DEBTOR),"30T")_"   "_$$LJ^XLFSTR($$GET1^DIQ(430,BILL_",",.01),"15T")_"   "_$$LJ^XLFSTR($$GET1^DIQ(430.2,^TMP("PRCAP377",$J,"CAT",DEBTOR,BILL)_",",.01),"15T")
 ...Q
 ..Q
 .Q
 S XMSUB="PRCA*4.5*377 AR REPAYMENT PLAN CONVERSION EXCEPTIONS",XMDUZ="AR PACKAGE"
 S XMY("G.RC REPAY PLANS")="",XMTEXT="^TMP(""PRCAP377"","_$J_",""MSG"","
 D ^XMD
 I $G(XMMG) D MES^XPDUTL(XMMG)
 K ^TMP("PRCAP377",$J,"MSG")
 D MES^XPDUTL(" Done.")
 Q
 ;
MSG2 ; send Mailman notification for TOP/DMC report
 N BILL,CNT,DEBTOR,DIFROM,RCRPIEN,REF,XMDUZ,XMMG,XMSUB,XMTEXT,XMY
 I '$D(^TMP("PRCAP377",$J,"REF")) Q  ; nothing to send - bail out
 D MES^XPDUTL("Sending TOP/DMC referrals report message...")
 S CNT=1,^TMP("PRCAP377",$J,"MSG",CNT)="The following bills are referred to TOP /DMC:"
 S CNT=CNT+1,^TMP("PRCAP377",$J,"MSG",CNT)=""
 S DEBTOR="" F  S DEBTOR=$O(^TMP("PRCAP377",$J,"REF",DEBTOR)) Q:DEBTOR=""  D
 .S RCRPIEN="" F  S RCRPIEN=$O(^TMP("PRCAP377",$J,"REF",DEBTOR,RCRPIEN)) Q:RCRPIEN=""  D
 ..S BILL="" F  S BILL=$O(^TMP("PRCAP377",$J,"REF",DEBTOR,RCRPIEN,BILL)) Q:BILL=""  D
 ...S REF=^TMP("PRCAP377",$J,"REF",DEBTOR,RCRPIEN,BILL)
 ...S CNT=CNT+1
 ...S ^TMP("PRCAP377",$J,"MSG",CNT)=$$LJ^XLFSTR($$NAM^RCFN01(DEBTOR),"30T")_"   "_$$LJ^XLFSTR($$GET1^DIQ(340.5,RCRPIEN_",",.01),"20T")
 ...S ^TMP("PRCAP377",$J,"MSG",CNT)=^TMP("PRCAP377",$J,"MSG",CNT)_"   "_$$LJ^XLFSTR($$GET1^DIQ(430,BILL_",",.01),"15T")_"  "_REF
 ...Q
 ..Q
 .Q
 S XMSUB="PRCA*4.5*377 AR REPAYMENT PLAN BILLS REFERRED TO TOP/DMC",XMDUZ="AR PACKAGE"
 S XMY("G.RC REPAY PLANS")="",XMTEXT="^TMP(""PRCAP377"","_$J_",""MSG"","
 D ^XMD
 I $G(XMMG) D MES^XPDUTL(XMMG)
 K ^TMP("PRCAP377",$J,"MSG")
 D MES^XPDUTL(" Done.")
 Q
 ;
UPD4303 ; Update the Transaction Type file (#430.3) with 3 new Transaction types.
 N LOOP,RCIEN,RCDATA,RCCNNM
 N X,Y,DIE,DA,DR,DTOUT,EXDATA,RCDATAB,DIK
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Adding new Transaction Types into the ACCOUNTS RECEIVABLE TRANS.TYPE file (430.3).")
 S Y=-1
 F LOOP=1:1 S RCDATA=$T(TRDAT+LOOP) Q:$P(RCDATA,";",3)="END"  D
 . S DR=""
 . ;Extract the new ACTION TYPE to be added.
 . ;Store in array for adding to the file (#350.1).
 . Q:RCDATA=""    ;go to next entry if Category is not to be updated.
 . ;
 . S RCCNNM=$P(RCDATA,";",3)
 . S RCIEN=$O(^PRCA(430.3,"B",RCCNNM,""))
 . Q:RCIEN>0
 . ; File the update along with inactivate the ACTION TYPE
 . S DLAYGO=430.3,DIC="^PRCA(430.3,",DIC(0)="L",X=RCCNNM
 . I '+RCIEN D FILE^DICN S RCIEN=+Y K DIC,DINUM,DLAYGO
 . S DR="1////"_$P(RCDATA,";",4)   ; ABBREVIATION
 . S DR=DR_";2////"_$P(RCDATA,";",5)  ; STATUS NUMBER
 . S DR=DR_";3////"_$P(RCDATA,";",6)  ; CALM CODE
 . S DR=DR_";5////"_$P(RCDATA,";",8)  ; CBO EXTRACT FLAG
 . ;
 . S DIE="^PRCA(430.3,",DA=RCIEN
 . D ^DIE
 . K DR,DA,DIE
 . ;re-index new entry here
 . S DA=RCIEN,DIK="^PRCA(430.3,"
 . D IX^DIK
 . K DR,DA,DIK
 Q
 ;
TRDAT ; Fee Service to inactivate
 ;;EDIT REPAYMENT PLAN;EZ;67;0;;0
 ;;CLOSE REPAYMENT PLAN;RZ;68;0;;0
 ;;RPP TERMINATED;RT;69;0;;0
 ;;END
 Q
 ;
ADDRPP ; Update the Transaction Type file (#430.3) with data for the new Repayment Plan field.
 N LOOP,RCIEN,RCDATA,RCCNNM
 N X,Y,DIE,DA,DR,DTOUT,EXDATA,RCDATAB,DIK
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Updating entries in the ACCOUNTS RECEIVABLE TRANS.TYPE file (430.3). to populate the REPAYMENT PLAN PROCESS field.")
 S Y=-1
 F LOOP=1:1 S RCDATA=$T(RPPDAT+LOOP) Q:$P(RCDATA,";",3)="END"  D
 . S DR=""
 . ;Extract the new ACTION TYPE to be added.
 . ;Store in array for adding to the file (#350.1).
 . Q:RCDATA=""    ;go to next entry if Category is not to be updated.
 . ;
 . S RCCNNM=$P(RCDATA,";",3)
 . S RCIEN=$O(^PRCA(430.3,"B",RCCNNM,""))
 . ; File the update along with inactivate the ACTION TYPE
 . S DLAYGO=430.3,DIC="^PRCA(430.3,",DIC(0)="L",X=RCCNNM
 . I '+RCIEN D FILE^DICN S RCIEN=+Y K DIC,DINUM,DLAYGO
 . S DR="6////"_$P(RCDATA,";",4)   ; ABBREVIATION
 . ;
 . S DIE="^PRCA(430.3,",DA=RCIEN
 . D ^DIE
 . ;re-index new entry here
 . S DA=RCIEN,DIK="^PRCA(430.3," D IX^DIK
 . K DR
 Q
 ;
RPPDAT ; Transaction Types to update
 ;;INCREASE ADJUSTMENT;I
 ;;PAYMENT (IN PART);P
 ;;CASH COLLECTION BY RC/DOJ;P
 ;;TERM.BY FIS.OFFICER;D
 ;;TERM.BY COMPROMISE;D
 ;;WAIVED IN FULL;D
 ;;WAIVED IN PART;D
 ;;ADMIN.COST CHARGE;I
 ;;INTEREST/ADM. CHARGE;I
 ;;EXEMPT INT/ADM. COST;D
 ;;WRITE-OFF;D
 ;;MARSHAL/COURT COST;I
 ;;TERM.BY RC/DOJ;D
 ;;PAYMENT (IN FULL);P
 ;;DECREASE ADJUSTMENT;D
 ;;CHARGE SUSPENDED;D
 ;;RE-ESTABLISH;I
 ;;END
 Q
