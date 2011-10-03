VAQPST02 ;ALB/JFP - PDX, POST INIT ROUTINE ;01JUN93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
PARM ; -- Initialization of VAQ Parameter file 394.81
 N CNT,FILENO,FILE,ENTRY
 W !!,"Initialization of VAQ - Parameter file",!
 I '$D(^VAT(394.81)) W !,"Error...VAQ - Parameter file missing, post init halted" S POP=1 QUIT
P1 S FILENO=394.81,FILE="^VAT(394.81,"
 S ENTRY=0,ENTRY=$O(^VAT(394.81,ENTRY))
 I ENTRY="" D P2 QUIT
 I $D(^VAT(394.81,ENTRY)) D MISSING^VAQPST01,PROMPT^VAQPST01,PEXIT QUIT
P2 S ENTRY=+$O(^VAT(394.2,0))
 I ENTRY>0 D COPV1 Q:CNT=0  D P1 QUIT
 ; -- Add entry
 S DIC="^VAT(394.81,"
 S DIC(0)="L"
 S DIC("DR")=".02;10;20;21;30;31"
 S X=+$$SITE^VASITE()
 S DLAYGO=394.81
 K DD,DO
 D FILE^DICN K DIC,DLAYGO,X
 I Y<0 W !,"Error...Could not make an entry on VAQ - Parameter file" S POP=1 QUIT
 W !!," ** Initialization of VAQ - Parameter file complete"
 D PEXIT
 QUIT
 ;
COPV1 ; -- Copy version 1 fields to version 1.5
 S CNT=0
 S ND=$G(^VAT(394.2,ENTRY,0))
 S FAC=$P(ND,U,5) I FAC="" S CNT=CNT+1 QUIT
 S LFDATA=$P(ND,U,3) I LFDATA="" S CNT=CNT+1
 S DOM=$P(ND,U,4) I DOM="" S CNT=CNT+1
 S DIC="^VAT(394.81,"
 S DIC(0)="L"
 ;S DIC("DR")=".02////"_DOM_";10///"_LFDATA_";20///NO;21///Kernal-Hasing"
 S DIC("DR")=".02////"_DOM_";10///"_LFDATA_";20///NO;21///Kernel Hashing"
 S X=FAC
 S DLAYGO=394.81
 K DD,DO
 D FILE^DICN K DIC,DLAYGO,X
 I Y<0 W !,"Error...Could not make an entry on VAQ - Parameter file" S POP=1 QUIT
 W !!," ** Initialization of VAQ - Parameter file complete"
 D PEXIT
 QUIT
 ;
PEXIT ; -- Clean up variables
 K FILNO,FILE,ENTRY
 K ND,FAC,DOM,LFDATA
 QUIT
 ;
AUTO ; -- Initialization of VAQ - Auto-numbering file 394.86
 W !!,"Initialization of VAQ - Auto-numbering file",!
 I '$D(^VAT(394.86)) W !,"Error...VAQ - Auto-numbering file missing, post init halted" S POP=1 QUIT
 S FILENO=394.86,FILE="^VAT(394.86,"
 S ENTRY=0 S ENTRY=$O(^VAT(394.86,ENTRY))
 I ENTRY="" D A1 QUIT
 I $D(^VAT(394.86,ENTRY)) D MISSING^VAQPST01,PROMPT^VAQPST01 QUIT
A1 ; -- Add entry
 S DIC="^VAT(394.86,"
 S DIC(0)="L"
 S DIC("DR")="10///100;20///0;30///0"
 S X=1
 S DINUM=1
 S DLAYGO=394.86
 K DD,DO
 D FILE^DICN K DIC,DLAYGO,DINUM,X
 I Y<0 W !,"Error...Could not make an entry on VAQ - Auto-numbering file" S POP=1 QUIT
 W !!," ** Initialization of VAQ - Auto-numbering file complete"
 K FILENO,FILE,ENTRY
 QUIT
END ; -- End of code
 QUIT
