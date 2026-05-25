IBACCWLUTIL5 ;EDE/TPF - ACC (Automated Community Care) Encounters utility APIs (Cont.) ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-2024;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;TPF;IB*2*770v44*EBILL-5941
PRIMDXTEXT(FILE,FIELDNUM,FIELDNAME,RETURNCODE) ;EP - DO ALPHA FILTER PROMPTS
 ;
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" S RETURNCODE="Invalid Parameters!" Q
 ;
 N DIR,DIROUT,DUOUT,DTOUT,GETFIELDCODE,LENGTH,LOGIC,IBTARGET,TYPE,X,Y
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_FIELDNAME_""",""E"")"
 ;
 W !!,"For field "_$G(FIELDNAME)_", enter a "_$G(FIELDNAME)_" or partial "_$G(FIELDNAME)
 W !,"you wish to include in your worklist."
 ;
 S DIR("A")="Choose a filter type"
 S DIR(0)="SO^N:No Filter;B:Primary Dx Code Begins with;R:Primary Dx Code Range (Inclusive);C:Primary Dx Description Contains"
 S DIR("B")="N"
 D ^DIR
 I X=U S VALMQUIT=1
 ;
 I $D(DIROUT)!$D(DUOUT)!$D(DTOUT)!(X="N") S RETURNCODE="" Q
 ;
 S TYPE=$P(Y,U)
 ;
 I TYPE="R" S FIELD=".14" D DXSTRRANGE(FILE,FIELDNUM,FIELDNAME,.RETURNCODE) Q
 ;
 W !
 K DIR
 I TYPE="B" D
 .S DIR("A")="Include all Primary Dx beginning with"
 .S DIR("?",1)="Enter a complete or partial Primary Dx to include all Primary Dx"
 .S DIR("?",2)="that begin with your entry."
 .S DIR("?",3)="For example, entering E11 would include Primary Dx such as"
 .S DIR("?",4)="E11.00, E11.311 or E11.9"
 .S DIR("?")=" "
 ;
 I TYPE="C" D
 .S DIR("A")="Include all Primary Dx whose description contains"
 .S DIR("?")="For example, entering DIABETES or Diabetes would include all Primary DX that have that word in the ICD Description."
 .S DIR("?",1)="E11.21 - Type 2 diabetes mellitus with diabetic nephropathy"
 .S DIR("?",2)="E11.22 - Type 2 diabetes mellitus w diabetic chronic kidney disease"
 .S DIR("?",3)="E11.622 - Type 2 diabetes mellitus with other skin ulcer"
 .S DIR("?",4)="E11.65 - Type 2 diabetes mellitus with hyperglycemia"
 .S DIR("?",5)="E11.69 - Type 2 diabetes mellitus with other specified complication"
 .S DIR("?",6)="E11.9 - Type 2 diabetes mellitus without complications"
 .S DIR("?",7)=" "
 ;
 S DIR(0)="FO^1:20^K:'(X'?1P.E) X"
 D ^DIR
 I X=U S VALMQUIT=1
 I $D(DIROUT)!$D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q
 ;
 S IBTARGET=$$UPPER^IBACCWLUTIL($P(Y,U))
 S IBTARGET=$TR(IBTARGET,".")
 S LENGTH=$L(IBTARGET)
 ;
 I TYPE="B" S GETFIELDCODE="$E("_GETFIELDCODE_",1,"_LENGTH_")" S RETURNCODE="I "_GETFIELDCODE_"="""_IBTARGET_""""
 ;
 I TYPE="C" D
 .S RETURNCODE=" S IBTARGET="""_IBTARGET_""" I $$PRIMDXSCREEN^IBACCWLUTIL5(Y,IBTARGET)"
 ;
 S LOGIC="For field "_$G(FIELDNAME)_", you entered a "_$G(FIELDNAME)_" or partial "_$G(FIELDNAME)_" value of "_$G(IBTARGET)_" to be included in your worklist."
 S RETURNCODE=RETURNCODE_"|"_LOGIC
 ;
 Q
 ;
ICDCODE(ICD) ;EP -RETURN CODE ONLY
 Q $P($$ICDLKUP^IBACCWLVE1A(ICD)," -")
 ;
DXSTRRANGE(FILE,FIELDNUM,FIELDNAME,RETURNCODE) ;EP - STRING RANGE - THIS IS THE FUNTIONALITY ASKED BY THE USER
 ;
 I $G(FILE)=""!(FIELD)=""!(FIELDNAME)="" S RETURNCODE="Invalid Parameters!" Q
 ;
 N DIR,DUOUT,DIROUT,DTOUT,GETFIELDCODE,FROMVALUE,LOGIC,TOVALUE
 ;
 S GETFIELDCODE="$$GET1^DIQ("_FILE_",Y_"","","""_FIELDNAME_""",""E"")"
 ;
 W !!,"For field "_$G(FIELDNAME)_", you may enter one or several characters"
 W !,"separated by a '-' to filter by a range alphabetically."
 W !!
 ;
REDOSR ;REDO RANGE FROM/TO ASK
 ;
 S DIR(0)="FO^1:40^K:X'?.A.N1""-"".A.N X"  ;K:'(X'?1P.E) X Q:'$D(X)  
 S DIR("?",1)="You may enter one or several characters"
 S DIR("?",2)="separated by a '-'"
 S DIR("?",3)=" "
 S DIR("?",4)="For example:"
 S DIR("?",5)="Enter E11-G to filter for Primary Dx between E11 and G."
 S DIR("?",6)="Enter D-F to filter for Primary Dx between D and F."
 S DIR("?",7)="All filters are inclusive."
 S DIR("?")=" "
 ;
 S DIR("A")=$$TITLE^XLFSTR(FIELDNAME)_" range"
 D ^DIR
 I X=U S VALMQUIT=1
 I $D(DUOUT)!$D(DTOUT)!(X="") S RETURNCODE="" Q
 ;
 S Y=$$UPPER^IBACCWLUTIL(Y)
 S Y=$TR(Y,".")
 I Y[("-") D  Q
 .S FROMVALUE=$P(Y,"-")
 .S TOVALUE=$P(Y,"-",2)
 .I TOVALUE=FROMVALUE!(FROMVALUE]TOVALUE) W !!,"Please enter a valid range of alphanumeric strings." G REDOSR
 .; 
 .S RETURNCODE="I "_GETFIELDCODE_"]"""_FROMVALUE_"""&("_GETFIELDCODE_"']"""_TOVALUE_""")!(($E("_GETFIELDCODE_",1,$L("""_$G(FROMVALUE)_"""))="""_$G(FROMVALUE)_""")!($E("_GETFIELDCODE_",1,$L("""_$G(TOVALUE)_"""))="""_$G(TOVALUE)_"""))"
 .S LOGIC="For field "_$G(FIELDNAME)_", the values that sort aplhabetically between '"_$G(FROMVALUE)_"' and '"_$G(TOVALUE)_"' will be displayed."
 .S RETURNCODE=RETURNCODE_"|"_LOGIC
 E  D
 .S FROMVALUE=Y
 .S RETURNCODE="I $E("_GETFIELDCODE_",1,$L("""_$G(FROMVALUE)_"""))="""_$G(FROMVALUE)_""""
 .S LOGIC="For field "_$G(FIELDNAME)_", the values that sort aplhabetically after '"_$G(FROMVLAUE)_"' will be displayed."
 .S RETURNCODE=RETURNCODE_"|"_LOGIC
 ;
 Q
 ;
PRIMDXSCREEN(Y,IBTARGET) ;EP - LOAD SCREEN FOR PRIMARY DX
 ;
 Q:'Y 0
 N IBDESCIEN,IBENCIFN,IBPRIMDX
 S IBENCIFN=$G(Y)
 ;
 S IBPRIMDX=$$GET1^DIQ(364.9,IBENCIFN_",",.14,"E")
 Q:IBPRIMDX="" 0
 ;
 S IBPRIMDX=$$ICDCODE^IBACCWLUTIL5(IBPRIMDX)
 Q:IBPRIMDX="" 0
 ;
 S IBPRIMDX=$O(^ICD9("AB",IBPRIMDX_" ",""))
 Q:IBPRIMDX="" 0
 ;
 S IBDESCIEN=$O(^ICD9(IBPRIMDX,68,"B"),-1)  ;GET LATEST DESCRIPTION
 Q:IBDESCIEN="" 0
 ;
 I $$UPPER^IBACCWLUTIL($$GET1^DIQ(80.068,IBDESCIEN_","_IBPRIMDX_",","DESCRIPTION","E"))[($G(IBTARGET)) Q 1
 ;
 Q 0
