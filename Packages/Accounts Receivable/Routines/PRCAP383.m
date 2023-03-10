PRCAP383 ;EDE/YMG - PRCA*4.5*383 PRE-INSTALL; 08/12/21
 ;;4.5;Accounts Receivable;**383**;Mar 20, 1995;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Pre-Installation routine for PRCA*4.5*383")
 ; update interest / administrative rates
 D UPDRT
 D BMES^XPDUTL(" >>  End of the Pre-Installation routine for PRCA*4.5*383")
 Q
 ;
UPDRT ; update interest / admin. rates in AR site parameters
 N DATA,FDA,IEN,IENS,LN,RATES,TMPDT,TMPDT1
 D MES^XPDUTL("Updating interest / admin. rates...")
 ; load rates from the table
 F LN=1:1 S DATA=$T(RTBL+LN) Q:$P(DATA,";",3)="END"  S RATES($P(DATA,";",3))=$P(DATA,";",4)_U_$P(DATA,";",5)
 ; loop through sub-file 342.04
 L +^RC(342,1):2 I '$T D MES^XPDUTL(" Unable to establish lock on file 342 - exiting.") Q
 S TMPDT=0 F  S TMPDT=$O(^RC(342,1,4,"B",TMPDT)) Q:'TMPDT  D
 .S IEN=0 F  S IEN=$O(^RC(342,1,4,"B",TMPDT,IEN)) Q:'IEN  D
 ..S IENS=IEN_",1,"
 ..S TMPDT1=$S('$D(RATES(TMPDT)):$O(RATES(TMPDT),-1),1:TMPDT) Q:'TMPDT1
 ..; update rates
 ..S FDA(342.04,IENS,.02)=$P(RATES(TMPDT1),U)    ; int. rate
 ..S FDA(342.04,IENS,.03)=$P(RATES(TMPDT1),U,2)  ; adm. rate
 ..D FILE^DIE("","FDA") K FDA
 ..Q
 .Q
 L -^RC(342,1)
 D MES^XPDUTL(" Done.")
 Q
 ;
RTBL ; Rates table (effective date;interest rate;admin. rate)
 ;;2860101;.09;.63
 ;;2870101;.07;.70
 ;;2890101;.07;.99
 ;;2900101;.09;.98
 ;;2910101;.09;.91
 ;;2920101;.06;1.16
 ;;2930101;.04;1.33
 ;;2940101;.03;.60
 ;;2980101;.05;.45
 ;;3000101;.05;.50
 ;;3010101;.06;.50
 ;;3020101;.05;.50
 ;;3020701;.03;.50
 ;;3030101;.02;.50
 ;;3040101;.01;1.50
 ;;3050101;.01;1.55
 ;;3060101;.02;1.60
 ;;3060701;.04;1.60
 ;;3070101;.04;1.65
 ;;3080101;.05;1.70
 ;;3080701;.03;1.70
 ;;3090101;.03;1.76
 ;;3100101;.01;1.83
 ;;3110101;.01;1.87
 ;;3120101;.01;1.87
 ;;3130101;.01;1.87
 ;;3140101;.01;1.87
 ;;3150101;.01;1.87
 ;;3160101;.01;1.87
 ;;3170101;.01;1.90
 ;;3180101;.01;1.93
 ;;3190101;.01;1.94
 ;;3200101;.02;1.64
 ;;3210101;.01;1.52
 ;;END
 Q
