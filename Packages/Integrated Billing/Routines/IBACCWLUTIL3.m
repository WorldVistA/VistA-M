IBACCWLUTIL3 ;EDE/TPF - ACC (Automated Community Care) Encounters utility APIs (Cont.) ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-2024;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;
GREATERTHAN(FILE,FIELDNUM,FIELDNAME) ;EP - > GREATER THAN
 ;
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" Q "Invalid Parameters!"
 ;
 N LOGIC,RETURNCODE,DIR,DUOUT,DIROUT,DTOUT,GETFIELDCODE,VALUE,X,Y
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_$S(FIELDNAME="Amount Paid":"PAID AMOUNT",1:FIELDNAME)_""",""E"")"  ;TPF;IB*2*770v22;EBILL-5003
 ;
 W !!,"For field "_$G(FIELDNAME)_", values greater than the value you enter will be displayed."
 ;
 N DIR
 S DIR("A")="Enter a "_$G(FIELDNAME)
 I FIELDNAME="DAYS ON GROUP WORKLIST" D
 .S DIR(0)="NO^0:999999"   ;TPF;IB*2*770v27;EBILL-5351
 E  S DIR(0)="NO^0:999999:2"   ;TPF;IB*2*770v25;EBILL-5125
 S DIR("?")="Values greater than the value you enter will be displayed. No commas"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1  ;TPF;IB*2*770v27;EBILL-5297
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q RETURNCODE
 ;TPF;IB*2*770v26;EBILL-5208
 S X=+X  ;GET RID OF LEADING ZEROES
 ;S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")
 I FIELDNAME'="DAYS ON GROUP WORKLIST" S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")   ;TPF;IB*2*770v27;EBILL-5351
 S VALUE=X
 S RETURNCODE="I "_GETFIELDCODE_">"""_VALUE_""""
 ;
 S LOGIC="For field "_$G(FIELDNAME)_", values greater than "_$G(VALUE)_" will be displayed."
 ;
 Q RETURNCODE_"|"_LOGIC
 ;
GREATTHANEQUALTO(FILE,FIELDNUM,FIELDNAME) ;EP - >=
 ;
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" Q "Invalid Parameters!"
 ;
 N LOGIC,RETURNCODE,DIR,DUOUT,DIROUT,DTOUT,GETFIELDCODE,VALUE,X,Y
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_$S(FIELDNAME="Amount Paid":"PAID AMOUNT",1:FIELDNAME)_""",""E"")"  ;TPF;IB*2*770v22;EBILL-5003
 ;
 W !!,"For field "_$G(FIELDNAME)_", values greater than or equal to the value"
 W !,"you enter will be displayed. No commas."
 ;
 N DIR
 I FIELDNAME="DAYS ON GROUP WORKLIST" D
 .S DIR(0)="NO^0:999999"   ;TPF;IB*2*770v27;EBILL-5351
 E  S DIR(0)="NO^0:999999:2"   ;TPF;IB*2*770v25;EBILL-5125
 S DIR("A")="Enter a "_$G(FIELDNAME)
 S DIR("?")="Values greater than or equal to the value you enter will be displayed. No commas."
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1  ;TPF;IB*2*770v27;EBILL-5297
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q RETURNCODE
 ;TPF;IB*2*770v26;EBILL-5208
 S X=+X  ;GET RID OF LEADING ZEROES
 I FIELDNAME'="DAYS ON GROUP WORKLIST" S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")   ;TPF;IB*2*770v27;EBILL-5351
 S VALUE=X
 S RETURNCODE="I "_GETFIELDCODE_">="""_VALUE_""""
 ;
 S LOGIC="For field "_$G(FIELDNAME)_", values greater than or equal to "_$G(VALUE)_" will be displayed."
 ;
 Q RETURNCODE_"|"_LOGIC
 ;
EQUALTO(FILE,FIELDNUM,FIELDNAME) ;EP - =
 ;
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" Q "Invalid Parameters!"
 ;
 N LOGIC,RETURNCODE,DIR,DUOUT,DIROUT,DTOUT,GETFIELDCODE,VALUE,X,Y
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_$S(FIELDNAME="Amount Paid":"PAID AMOUNT",1:FIELDNAME)_""",""E"")"  ;TPF;IB*2*770v22;EBILL-5003
 ;
 W !!,"For field "_$G(FIELDNAME)_", values equal to the value you enter will be displayed."
 ;
 N DIR
 I FIELDNAME="DAYS ON GROUP WORKLIST" D
 .S DIR(0)="NO^0:999999"   ;TPF;IB*2*770v27;EBILL-5351
 E  S DIR(0)="NO^0:999999:2"   ;TPF;IB*2*770v25;EBILL-5125
 S DIR("A")="Enter a "_$G(FIELDNAME)
 S DIR("?")="Values equal to the value you enter will be displayed. No commas"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1  ;TPF;IB*2*770v27;EBILL-5297
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q RETURNCODE
 ;TPF;IB*2*770v26;EBILL-5208
 S X=+X  ;GET RID OF LEADING ZEROES
 I FIELDNAME'="DAYS ON GROUP WORKLIST" S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")   ;TPF;IB*2*770v27;EBILL-5351
 S VALUE=X
 S RETURNCODE="I "_GETFIELDCODE_"="""_VALUE_""""
 ; 
 S LOGIC="For field "_$G(FIELDNAME)_", values equal to "_$G(VALUE)_" will be displayed."
 ;
 Q RETURNCODE_"|"_LOGIC
 ;
LESSTHAN(FILE,FIELDNUM,FIELDNAME) ;EP - < LESS THAN
 ;
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" Q "Invalid Parameters!"
 ;
 N DIR,LOGIC,RETURNCODE,DUOUT,DIROUT,DTOUT,GETFIELDCODE,VALUE,X,Y
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_$S(FIELDNAME="Amount Paid":"PAID AMOUNT",1:FIELDNAME)_""",""E"")"  ;TPF;IB*2*770v22;EBILL-5003
 ;
 W !!,"For field "_$G(FIELDNAME)_", values less than the value you enter will be displayed."
 ;
 I FIELDNAME="DAYS ON GROUP WORKLIST" D
 .S DIR(0)="NO^0:999999"   ;TPF;IB*2*770v27;EBILL-5351
 E  S DIR(0)="NO^0:999999:2"   ;TPF;IB*2*770v25;EBILL-5125
 S DIR("A")="Enter a "_$G(FIELDNAME)
 S DIR("?")="Values less than the value you enter will be displayed. No commas."
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1  ;TPF;IB*2*770v27;EBILL-5297
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q RETURNCODE
 ;TPF;IB*2*770v26;EBILL-5208
 S X=+X  ;GET RID OF LEADING ZEROES
 ;S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")
 I FIELDNAME'="DAYS ON GROUP WORKLIST" S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")   ;TPF;IB*2*770v27;EBILL-5351
 S VALUE=X
 S RETURNCODE="I "_GETFIELDCODE_"<"""_VALUE_""""
 ;
 S LOGIC="For field "_$G(FIELDNAME)_", values less than "_$G(VALUE)_" will be displayed."
 ;
 Q RETURNCODE_"|"_LOGIC
 ;
LESSTHANEQUALTO(FILE,FIELDNUM,FIELDNAME) ;EP - <=
 ;
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" Q "Invalid Parameters!"
 ;
 N LOGIC,RETURNCODE,DIR,DUOUT,DIROUT,DTOUT,GETFIELDCODE,VALUE,X,Y
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_$S(FIELDNAME="Amount Paid":"PAID AMOUNT",1:FIELDNAME)_""",""E"")"  ;TPF;IB*2*770v22;EBILL-5003
 ;
 W !!,"For field "_$G(FIELDNAME)_", values less than or equal to the value you enter will be displayed."
 ;
 N DIR
 I FIELDNAME="DAYS ON GROUP WORKLIST" D
 .S DIR(0)="NO^0:999999"   ;TPF;IB*2*770v27;EBILL-5351
 E  S DIR(0)="NO^0:999999:2"   ;TPF;IB*2*770v25;EBILL-5125
 S DIR("A")="Enter a "_$G(FIELDNAME)
 S DIR("?")="Values less than or equal to the value you enter will be displayed. No commas."
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1  ;TPF;IB*2*770v27;EBILL-5297
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q RETURNCODE
 ;TPF;IB*2*770v26;EBILL-5208
 S X=+X  ;GET RID OF LEADING ZEROES
 I FIELDNAME'="DAYS ON GROUP WORKLIST" S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")   ;TPF;IB*2*770v27;EBILL-5351
 S VALUE=X
 S RETURNCODE="I "_GETFIELDCODE_"<="""_VALUE_""""
 ;
 S LOGIC="For field "_$G(FIELDNAME)_", values less than or equal to "_$G(VALUE)_" will be displayed."
 ;
 Q RETURNCODE_"|"_LOGIC
 ;
NUMRANGE(FILE,FIELDNUM,FIELDNAME) ;EP - NUMERIC RANGE
 ;
 N DIR
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" Q "Invalid Parameters!"
 ;
 N LOGIC,RETURNCODE,DIR,DUOUT,DIROUT,DTOUT,GETFIELDCODE,FROMVALUE,TOVALUE,X,Y
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_$S(FIELDNAME="Amount Paid":"PAID AMOUNT",1:FIELDNAME)_""",""E"")"  ;TPF;IB*2*770v22;EBILL-5003
 ;
 W !!,"For field "_$G(FIELDNAME)_", values that fall between the low and high"
 W !,"values you enter will be displayed."
 ;
REDONR ;REDO RANGE FROM/TO ASK
 I FIELDNAME="DAYS ON GROUP WORKLIST" D
 .S DIR(0)="NO^0:999999"   ;TPF;IB*2*770v27;EBILL-5351
 E  S DIR(0)="NO^0:999999:2"   ;TPF;IB*2*770v25;EBILL-5125
 S DIR("A")="Enter a low "_$G(FIELDNAME)_" amount."
 S DIR("?")="Enter the low dollar amount. No commas."
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1  ;TPF;IB*2*770v27;EBILL-5297
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q RETURNCODE
 ;TPF;IB*2*770v26;EBILL-5208
 S X=+X  ;GET RID OF LEADING ZEROES
 I FIELDNAME'="DAYS ON GROUP WORKLIST" S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")   ;TPF;IB*2*770v27;EBILL-5351
 S FROMVALUE=X
 ;
 I FIELDNAME="DAYS ON GROUP WORKLIST" D
 .S DIR(0)="NO^0:999999"   ;TPF;IB*2*770v27;EBILL-5351
 E  S DIR(0)="NO^0:999999:2"   ;TPF;IB*2*770v25;EBILL-5125
 S DIR("B")=FROMVALUE
 S DIR("A")="Enter a high "_$G(FIELDNAME)_" amount"
 S DIR("?")="Enter the high dollar amount. No commas."
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1  ;TPF;IB*2*770v27;EBILL-5297
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q RETURNCODE
 ;TPF;IB*2*770v26;EBILL-5208
 S X=+X  ;GET RID OF LEADING ZEROES
 I FIELDNAME'="DAYS ON GROUP WORKLIST" S $P(X,".",2)=$S($L($P(X,".",2))=2:$P(X,".",2),$L($P(X,".",2))=1:$P(X,".",2)_"0",1:$P(X,".",2)_"00")   ;TPF;IB*2*770v27;EBILL-5351
 S TOVALUE=X
 ;
 I TOVALUE<FROMVALUE W !!,"Please enter a valid range" G REDONR
 ;
 I FROMVALUE=TOVALUE D  Q RETURNCODE_"|"_LOGIC
 .S LOGIC="For field "_$G(FIELDNAME)_", values that equal "_$G(FROMVALUE)_" will be displayed."
 .S RETURNCODE="I "_GETFIELDCODE_"="""_FROMVALUE_""""
 ;
 S LOGIC="For field "_$G(FIELDNAME)_", values that fall between "_$G(FROMVALUE)_" and "_$G(TOVALUE)_" will be displayed."  ;TPF;IB*770v25;EBILL-5125
 W !!,LOGIC  ;TPF;IB*770v25;EBILL-5125
 ;
 S RETURNCODE="I "_GETFIELDCODE_">="""_FROMVALUE_""",("_GETFIELDCODE_"<="""_TOVALUE_""")"  ;TPF;IB*2*770v26;EBILL-5208
 ;
 Q RETURNCODE_"|"_LOGIC
 ;
DOM(MNYR) ;DAYS IN A MONTH
 ;
 N DAYS,MN,YR
 S MN=+$E(MNYR,4,5)
 I "^4^6^9^11^"[("^"_MN_"^") S DAYS=30 Q DAYS
 I MN=2 D  Q DAYS
 .S DAYS=28
 .S YR=$E(MNYR,1,3)+1700
 .S:YR#4=0 DAYS=29
 S DAYS=31
 Q DAYS
