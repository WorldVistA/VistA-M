PRCAP382 ;EDE/YMG - PRCA*4.5*382 POST INSTALL; 04/26/21
 ;;4.5;Accounts Receivable;**382**;Mar 20, 1995;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*382")
 ; reverse interest / administrative charges
 D FINDCHRG(3200328) ; 03/28/2020
 ; update interest / administrative rates
 D UPDRATES
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*382")
 Q
 ;
FINDCHRG(STRTDT) ; find charges to reverse
 ;
 ; STRTDT - start date (internal)
 ;
 N ADMCHRG,BILL,CNT,EXTYPE,INTCHRG,N2,TMPDT,TRIEN,TYPARY,TYPE,Z,ACCTYPE,RCARCT
 D MES^XPDUTL("Exempting interest / admin. charges...")
 K ^TMP("PRCAP382",$J)
 S ACCTYPE=0,EXTYPE=""
 S Z=+$O(^PRCA(430.3,"B","ADMIN.COST CHARGE",0)) I Z S TYPARY(Z)="",ACCTYPE=1
 S Z=+$O(^PRCA(430.3,"B","INTEREST/ADM. CHARGE",0)) I Z S TYPARY(Z)=""
 S Z=+$O(^PRCA(430.3,"B","EXEMPT INT/ADM. COST",0)) I Z S TYPARY(Z)="",EXTYPE=Z
 S (CNT,TYPE)=0 F  S TYPE=$O(TYPARY(TYPE)) Q:'TYPE  D
 .S TMPDT=0 F  S TMPDT=$O(^PRCA(433,"AT",TYPE,TMPDT)) Q:'TMPDT  D
 ..S TRIEN=0 F  S TRIEN=$O(^PRCA(433,"AT",TYPE,TMPDT,TRIEN)) Q:'TRIEN  D
 ...S CNT=CNT+1 I '$D(ZTQUEUED) W:CNT#500=0 "."
 ...I +$P($G(^PRCA(433,TRIEN,1)),U)<STRTDT Q  ; transaction date (433/11) is prior to the start date
 ...S BILL=+$P($G(^PRCA(433,TRIEN,0)),U,2) I 'BILL Q  ; file 430 ien
 ...I $$GET1^DIQ(430,BILL_",",8)'="ACTIVE" Q  ; only check active bills
 ...S RCARCT=$$GET1^DIQ(430,BILL_",",2,"I")
 ...S N2=$G(^PRCA(433,TRIEN,2)),INTCHRG=+$P(N2,U,7),ADMCHRG=+$P(N2,U,8)
 ...I (INTCHRG'=0),$$GET1^DIQ(430.2,RCARCT_",",9,"I") D
 .... I ACCTYPE,INTCHRG<0 Q
 .... S ^TMP("PRCAP382",$J,BILL,"INT")=$G(^TMP("PRCAP382",$J,BILL,"INT"))+$S(TYPE=EXTYPE:-INTCHRG,1:INTCHRG)
 ...I ADMCHRG'=0,$$GET1^DIQ(430.2,RCARCT_",",10,"I") D
 .... I ACCTYPE,ADMCHRG<0 Q
 .... S ^TMP("PRCAP382",$J,BILL,"ADM")=$G(^TMP("PRCAP382",$J,BILL,"ADM"))+$S(TYPE=EXTYPE:-ADMCHRG,1:ADMCHRG)
 ...Q
 ..Q
 .Q
 I $D(^TMP("PRCAP382",$J)) S (CNT,BILL)=0 F  S BILL=$O(^TMP("PRCAP382",$J,BILL)) Q:'BILL  D
 .S CNT=CNT+1 I '$D(ZTQUEUED) W:CNT#500=0 "."
 .S INTCHRG=+$G(^TMP("PRCAP382",$J,BILL,"INT")),ADMCHRG=+$G(^TMP("PRCAP382",$J,BILL,"ADM"))
 .I INTCHRG>0!(ADMCHRG>0) D REVCHRG(BILL,INTCHRG,ADMCHRG,EXTYPE)
 .Q
 K ^TMP("PRCAP382",$J)
 D MES^XPDUTL(" Done.")
 Q
 ;
REVCHRG(BILL,INTCHRG,ADMCHRG,TRNTYPE) ; reverse (exempt) a charge
 ;
 ; BILL - file 430 ien
 ; INTCHRG - interest charge to reverse (amount)
 ; ADMCHRG - admin. charge to reverse (amount)
 ; TRNTYPE - transaction type to use (file 430.3 ien)
 ;
 N FDA,IENS,N7,OLDADM,OLDINT
 N DA,DD,DIC,DINUM,DLAYGO,DO,PRCAEN,RCDA,X,Y  ; vars used by SETTR^PRCAUTL
 S N7=$G(^PRCA(430,BILL,7))  ; file 430, node 7
 S OLDINT=+$P(N7,U,2)  ; current int. balance on the bill
 S OLDADM=+$P(N7,U,3)  ; current adm. balance on the bill
 D SETTR^PRCAUTL  ; create new transaction in file 433, set PRCAEN to ien of the new entry
 I PRCAEN'>0 Q
 ; lock entry in 430
 L +^PRCA(430,BILL):2 Q:'$T
 ; lock new entry in 433 just in case
 L +^PRCA(433,PRCAEN):2 Q:'$T
 ; update transaction in file 433
 S IENS=PRCAEN_","
 S FDA(433,IENS,.03)=BILL            ; bill #
 S FDA(433,IENS,4)=2                 ; transaction status
 S FDA(433,IENS,5.02)="PANDEMIC REVERSAL"  ; Brief Comment to indicate why the reversal occurred.
 S FDA(433,IENS,11)=DT               ; transaction date
 S FDA(433,IENS,12)=TRNTYPE          ; transaction type
 S FDA(433,IENS,15)=INTCHRG+ADMCHRG  ; transaction amount
 S FDA(433,IENS,27)=INTCHRG          ; interest charge
 S FDA(433,IENS,28)=ADMCHRG          ; admin charge
 D FILE^DIE("","FDA")
 L -^PRCA(433,PRCAEN) ; unlock file 433
 ;
 I $D(^PRCA(430,"TCSP",BILL)) D DECADJ^RCTCSPU(BILL,PRCAEN)
 ; update file 430 entry
 S IENS=BILL_"," K FDA
 S FDA(430,IENS,72)=OLDINT-INTCHRG
 S FDA(430,IENS,73)=OLDADM-ADMCHRG
 D FILE^DIE("","FDA")
 L -^PRCA(430,BILL) ; unlock file 430
 D UPDBAL^RCRPU1(BILL,PRCAEN) ; update RPP balance
 Q
 ;
UPDRATES ; update interest / admin. rates in AR site parameters
 N IEN,TMPDT
 D MES^XPDUTL("Updating interest / admin. rates...")
 ; update all entries, starting with year 2013
 S TMPDT=0 F  S TMPDT=$O(^RC(342,1,4,"B",TMPDT)) Q:'TMPDT  D
 .S IEN=0 F  S IEN=$O(^RC(342,1,4,"B",TMPDT,IEN)) Q:'IEN  D SETRATES(IEN)
 .Q
 D MES^XPDUTL(" Done.")
 Q
 ;
SETRATES(IEN) ; set interest / admin. rates in a specific entry
 ;
 ; IEN - ien in sub-file 342.04
 ;
 N FDA,IENS
 S IENS=IEN_",1,"
 S FDA(342.04,IENS,.02)=""
 S FDA(342.04,IENS,.03)=0
 L +^RC(342,1):2 Q:'$T
 D FILE^DIE("","FDA")
 L -^RC(342,1)
 Q
