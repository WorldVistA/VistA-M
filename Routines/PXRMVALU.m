PXRMVALU ; SLC/KER - Validate Codes (utility)    ; 05/16/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 Q
FILE(X) ; Get File
 ;   
 ; Requires:
 ;   
 ;           X       in the form of a classification code
 ;   
 ; Returns:
 ;   
 ;          <file #>^<DIC>^<code type>
 ;   
 S X=$G(X) Q:'$L(X) "80^ICD9(^ICD-9-CM diagnostic code"
 N FI,DIC,TYPE S (FI,DIC,TYPE)=""
 I +X>0 D  Q (FI_"^"_DIC_"^"_TYPE)
 . I $L($P(X,".",1))>3,X'["." S FI=81,DIC="ICPT(",TYPE="CPT-4 procedure code" Q
 . I $L($P(X,".",1))>2 S FI=80,DIC="ICD9(",TYPE="ICD-9-CM diagnosis code" Q
 . I $L($P(X,".",1))'>2 D
 . . N I,OK,SEARCH,CONTROL S SEARCH=$E(X,1,($L(X)-1))_$C($A($E(X,$L(X)))-1)_"~",CONTROL=X
 . . S OK=0 F I=1:1 D  Q:OK=1!($L($P(SEARCH,".",1))>3)
 . . . I $O(^ICD9("BA",(SEARCH_" ")))=(CONTROL_" ") D  Q
 . . . . S OK=1,FI=80,DIC="ICD9(",TYPE="ICD-9-CM diagnosis code" Q 
 . . . I $O(^ICD0("BA",(SEARCH_" ")))=(CONTROL_" ") D  Q
 . . . . S OK=1,FI=80.1,DIC="ICD9(",TYPE="ICD-9-CM procedure code" Q
 . . . S SEARCH="0"_SEARCH,CONTROL="0"_CONTROL
 . . I 'OK S SEARCH=$E(X,1,($L(X)-1))_$C($A($E(X,$L(X)))-1)_"~",CONTROL=X F I=1:1 D  Q:OK=1!($L($P(SEARCH,".",1))>3)
 . . . I $P($O(^ICD9("BA",(SEARCH_" "))),".",1)=$P(CONTROL,".",1),+($P($O(^ICD9("BA",(SEARCH_" "))),".",2))=0,+($P(CONTROL,".",2))=0 D  Q
 . . . . S OK=1,FI=80,DIC="ICD9(",TYPE="ICD-9-CM diagnosis code" Q 
 . . . I $P($O(^ICD0("BA",(SEARCH_" "))),".",1)=$P(CONTROL,".",1),+($P($O(^ICD0("BA",(SEARCH_" "))),".",2))=0,+($P(CONTROL,".",2))=0 D  Q
 . . . . S OK=1,FI=80.1,DIC="ICD9(",TYPE="ICD-9-CM procedure code" Q
 . . . S SEARCH="0"_SEARCH,CONTROL="0"_CONTROL
 . S:TYPE="" FI=80,DIC="ICD9(",TYPE="ICD-9-CM diagnosis code"
 I +X=0 D  Q (FI_"^"_DIC_"^"_TYPE)
 . I $L($P(X,".",1))>4,X'["." S FI=81,DIC="ICPT(",TYPE="HCPCS procedure code" Q
 . I X["-" S FI=81,DIC="ICPT(",TYPE="HCPCS procedure code" Q
 . I $E(X,1)="E",X["." S FI=80,DIC="ICD9(",TYPE="ICD-9-CM ""E"" code (external causes)" Q
 . I $E(X,1)="E",$L($E(X,2,$L(X)))=3 S FI=80,DIC="ICD9(",TYPE="ICD-9-CM ""E"" code (external causes)" Q
 . I $E(X,1)="V",X["." S FI=80,DIC="ICD9(",TYPE="ICD-9-CM ""V"" code (health factors)" Q
 . I $E(X,1)="V",$L($E(X,2,$L(X)))=2 S FI=80,DIC="ICD9(",TYPE="ICD-9-CM ""V"" code (health factors)" Q
 . S FI=80,DIC="ICD9(",TYPE="ICD-9-CM diagnosis code"
 Q "80^ICD9(^ICD-9-CM diagnostic code"
TYPE(X,Y) ; Code type
 ;
 ; Requires:
 ;   
 ;           X       in the form of a classification code
 ;           Y       file number or global root
 ;   
 ; Returns:
 ;   
 ;         <type>    free text string description of code type
 ;   
 ;                   ICD-9-CM diagnosis
 ;                   ICD-9-CM "E" external causes
 ;                   ICD-9-CM "V" health factors
 ;                   ICD-9-CM procedures
 ;                   CPT-4 procedures
 ;                   HCPCS procedures
 ;   
 N TYPE,FI,CO S FI=$G(Y),CO=$G(X),TYPE="" S:+CO>0&(FI=80!(FI["ICD9")) TYPE="ICD-9-CM diagnosis" S:$E(CO,1)="E"&(FI=80!(FI["ICD9")) TYPE="ICD-9-CM ""E"" external causes"
 S:$E(CO,1)="V"&(FI=80!(FI["ICD9")) TYPE="ICD-9-CM ""V"" health factors" S:+CO>0&(FI=80.1!(FI["ICD0")) TYPE="ICD-9-CM procedures"
 S:+CO>0&(FI=81!(FI["ICPT")) TYPE="CPT-4 procedures" S:+CO=0&(FI=81!(FI["ICPT")) TYPE="HCPCS procedures"
 S X=TYPE Q X
NEXT(X,FILE) ; Next code in file
 ;
 ; Requires:
 ;   
 ;           X       in the form of a classification code
 ;           FILE    file number
 ;   
 ; Returns:
 ;   
 ;         <code>    Next code found in file
 ;               
 N NCODE,NEXT S FILE=+($G(FILE)),X=$$TRIM($G(X)) Q:X="" ""
 I FILE=80 D  Q X
 . Q:$D(^ICD9("BA",X_" "))  S NEXT=$$TRIM($O(^ICD9("BA",(X_" ")))) I $E(NEXT,1,$L(X))=X S X=NEXT Q
 . S:$E(NEXT,1,$L(X))'=X X=""
 I FILE=80.1 D  Q X
 . Q:$D(^ICD0("BA",X_" "))  S NEXT=$$TRIM($O(^ICD0("BA",(X_" ")))) I $E(NEXT,1,$L(X))=X S X=NEXT Q
 . S:$E(NEXT,1,$L(X))'=X X=""
 I FILE=81 D  Q X
 . S NCODE=X I +NCODE>0,$E(NCODE,1)'="0",$L(NCODE)<5 F  Q:$L(NCODE)=5  S NCODE="0"_NCODE
 . S:$D(^ICPT("B",NCODE)) X=NCODE Q:$D(^ICPT("B",X))  S NEXT=$$TRIM($O(^ICPT("B",NCODE))) I $E(NEXT,1,$L(X))=X S X=NEXT Q
 . S:$E(NEXT,1,$L(X))'=X X=""
 Q X
TRIM(X) ; Trim leading/trailing spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
