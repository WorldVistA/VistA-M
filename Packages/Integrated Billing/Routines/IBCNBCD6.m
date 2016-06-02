IBCNBCD6 ;ALB/AWC - MCCF FY14 Subscriber Display Screens ;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Input Parameters:
 ;  See routine IBCNBCD1
 ;
SUB(IBBUFDA,IBEXTDA,IBRIEN,IBSEL,IBTYPE,IBRESULT,DFN,IBFNAM,IBVAL,IBHOLD,IBXHOLD) ; called from routine SUB^IBCMBMI
 ; Move patient data(file #2) <or> income person data(408.13) into existing Patient Policy (file 2.312)
 ;
 N IBX,IBSET,IBXFILE,BUFARR,EXTARR,IBFLDS,IBLBLS,IBADDS,IBDRB,IBDRX,IBERR,IBCHNG,IBCHNGN,IBBFDA
 S IBBFDA=IBBUFDA_","
 S IBEXTDA=$G(IBEXTDA)_","_DFN_","
 ;
 I IBSEL=18 D
 . I IBFNAM="DPT" S IBSET="DPT" D SELF(IBSET,IBBFDA,IBRIEN,IBEXTDA,IBTYPE,.BUFARR,.EXTARR,.IBCHNG,.IBCHNGN,.IBFLDS,.IBLBLS,.IBADDS,.IBRESULT,.IBHOLD,.IBXHOLD)
 ;
 ; -- if user selected "spouse" use income person file(#408.13) to get specific data/fields
 I IBSEL=1 D
 . I IBFNAM="DGPR" S IBSET="DGPR" D SPOUSE(IBSET,IBBFDA,IBRIEN,IBEXTDA,IBTYPE,.BUFARR,.EXTARR,.IBCHNG,.IBCHNGN,.IBFLDS,.IBLBLS,.IBADDS,.IBRESULT,.IBHOLD,.IBXHOLD) Q
 . I IBFNAM']"" S IBSET="N" D NSPOUSE(IBSET,IBBFDA,IBRIEN,IBEXTDA,IBTYPE,.BUFARR,.EXTARR,.IBCHNG,.IBCHNGN,.IBFLDS,.IBLBLS,.IBADDS,.IBRESULT,.IBHOLD,.IBXHOLD)
 ;
 ; -- update policy fields with nulls
 I $D(IBCHNGN)>9 D FILE^DIE("E","IBCHNGN","IBERR") I $D(IBERR) W !,"Error... SUB-IBCNBCD6  Could not file fields with nulls" K DIR D PAUSE^VALM1 Q
 ; -- update policy fields with data
 I $D(IBCHNG)>9 D FILE^DIE("E","IBCHNG","IBERR") I $D(IBERR)>0 W !,"Error... SUB-IBCNBCD6  Could not file fields with data" K DIR D PAUSE^VALM1 Q
 ;
 ; -- update policy fields with user information
 D STUFF("POL",IBEXTDA,.IBRESULT)
 ; -- update policy with verified-by information
 D POLOTH(IBBFDA,IBEXTDA,.IBRESULT)
 Q
 ;
SELF(IBSET,IBBUFDA,IBRIEN,IBEXTDA,IBTYPE,BUFARR,EXTARR,IBCHNG,IBCHNGN,IBFLDS,IBLBLS,IBADDS,IBRESULT,IBHOLD,IBXHOLD) ; get data for "self" relationship
 N IBX,IB1,IB2,IBXARY,IBFARY,IBDRB,IBDRX,IBBUFVAL,IBEXTFLD,IBEXTVAL,IBXFILE
 ;
 ; -- get corresponding fields to populate data
 D FIELDS(IBSET_"FLD",.IBFLDS,.IBLBLS,.IBADDS)
 S IBX=$P($T(@(IBSET_"DR")+1),";;",2),IBXFILE=+$P(IBX,U,1),IBDRB=$P(IBX,U,2),IBDRX=$P(IBX,U,3)
 ;
 I +$G(IBTYPE) F IBX=1:1:$L(IBDRB,";") D
 . ;
 . S IB1=$P(IBDRB,";",IBX),IB2=$P(IBDRX,";",IBX)
 . ;
 . S IBBUFVAL=$G(@IBHOLD@(2,IB1)),IBEXTVAL=$G(@IBXHOLD@(2,IB2))
 . ;
 . I IBBUFVAL=IBEXTVAL Q
 . I IBTYPE=1,IBEXTVAL'="" Q
 . I IBTYPE=2,IBBUFVAL="" Q
 . I IBTYPE=4,'$D(^TMP($J,"IB BUFFER SELECTED",IB1)) Q
 . ;
 . ;
 . S IBCHNG(IBXFILE,IBEXTDA,IB2)=IBBUFVAL
 . ;
 . ; -- for ACCEPAPI^IBCNICB do not delete the .01 field. This prevents a Data Dictionary Deletion Write message
 . Q:IB2=".01"!(IB2="4.03")!(IB2="6")!(IB2="7.01")
 . ;
 . S IBCHNGN(IBXFILE,IBEXTDA,IB2)=""
 Q
 ;
SPOUSE(IBSET,IBBUFDA,IBRIEN,IBEXTDA,IBTYPE,BUFARR,EXTARR,IBCHNG,IBCHNGN,IBFLDS,IBLBLS,IBADDS,IBRESULT,IBHOLD,IBXHOLD) ; get data for "spouse" relationship
 N IBX,IBXARY,IBFARY,IBDRB,IBDRX,IBBUFVAL,IBEXTFLD,IBEXTVAL,IBXFILE
 ;
 ; -- get corresponding fields to populate data
 D FIELDS(IBSET_"FLD",.IBFLDS,.IBLBLS,.IBADDS)
 S IBX=$P($T(@(IBSET_"DR")+1),";;",2),IBXFILE=+$P(IBX,U,1),IBDRB=$P(IBX,U,2),IBDRX=$P(IBX,U,3)
 ;
 I +$G(IBTYPE) F IBX=1:1:$L(IBDRB,";") D
 . ;
 . S IB1=$P(IBDRB,";",IBX),IB2=$P(IBDRX,";",IBX)
 . ;
 . S IBBUFVAL=$G(@IBHOLD@(2,IB1)),IBEXTVAL=$G(@IBXHOLD@(2,IB2))
 . ;
 . I IBBUFVAL=IBEXTVAL Q
 . I IBTYPE=1,IBEXTVAL'="" Q
 . I IBTYPE=2,IBBUFVAL="" Q
 . I IBTYPE=4,'$D(^TMP($J,"IB BUFFER SELECTED",IB1)) Q
 . ;
 . S IBCHNG(IBXFILE,IBEXTDA,IB2)=IBBUFVAL
 . ;
 . ; -- for ACCEPAPI^IBCNICB do not delete the .01 field. This prevents a Data Dictionary Deletion Write message
 . Q:IB2=".01"!(IB2="4.03")!(IB2="6")!(IB2="7.01")
 . ;
 . S IBCHNGN(IBXFILE,IBEXTDA,IB2)=""
 Q
 ;
NSPOUSE(IBSET,IBBFDA,IBRIEN,IBEXTDA,IBTYPE,BUFARR,EXTARR,IBCHNG,IBCHNGN,IBFLDS,IBLBLS,IBADDS,IBRESULT,IBHOLD,IBXHOLD) ; no spuse data
 N IBX,IBXARY,IBFARY,IBDRB,IBDRX,IBBUFVAL,IBEXTFLD,IBEXTVAL,IBXFILE
 ;
 ; -- left side of screen get data from income person(#408.13) fields
 D FIELDS(IBSET_"FLD",.IBFLDS,.IBLBLS,.IBADDS)
 S IBX=$P($T(@(IBSET_"DR")+1),";;",2),IBXFILE=+$P(IBX,U,1),IBDRB=$P(IBX,U,2),IBDRX=$P(IBX,U,3)
 ;
 I +$G(IBTYPE) F IBX=1:1:$L(IBDRB,";") D
 . ;
 . S IB1=$P(IBDRB,";",IBX),IB2=$P(IBDRX,";",IBX)
 . ;
 . S IBBUFVAL=$G(@IBHOLD@(2,IB1)),IBEXTVAL=$G(@IBXHOLD@(2,IB2))
 . ;
 . I IBBUFVAL=IBEXTVAL Q
 . I IBTYPE=1,IBEXTVAL'="" Q
 . I IBTYPE=2,IBBUFVAL="" Q
 . I IBTYPE=4,'$D(^TMP($J,"IB BUFFER SELECTED",IB1)) Q
 . ;
 . S IBCHNG(IBXFILE,IBEXTDA,IB2)=IBBUFVAL
 . ;
 . ; -- for ACCEPAPI^IBCNICB do not delete the .01 field. This prevents a Data Dictionary Deletion Write message
 . Q:IB2=".01"!(IB2="4.03")!(IB2="6")!(IB2="7.01")
 . ;
 . S IBCHNGN(IBXFILE,IBEXTDA,IB2)=""
 Q
 ;
STUFF(IBSET,IBEXTDA,IBRESULT) ; update fields in insurance files that 
 N IBX,IBFLDS,IBLBLS,IBADDS,EXTFILE,IBEXTFLD,IBEXTVAL,IBFDA,IBFDAX,IBERR
 ;
 D FIELDS(IBSET_"A",.IBFLDS,.IBLBLS,.IBADDS)
 S IBX=$P($T(@(IBSET_"DR")+1),";;",2),EXTFILE=+$P(IBX,U,1)
 ;
 S IBEXTFLD=0 F  S IBEXTFLD=$O(IBFLDS(IBEXTFLD)) Q:'IBEXTFLD  D
 . S IBEXTVAL=IBFLDS(IBEXTFLD) I IBEXTVAL="DUZ" S IBEXTVAL="`"_DUZ
 . S IBFDA(EXTFILE,IBEXTDA,IBEXTFLD)=IBEXTVAL
 . S IBFDAX(EXTFILE,IBEXTDA,IBEXTFLD)=""
 ;
 ; -- update fields with nulls (external values)
 D FILE^DIE("E","IBFDAX","IBERR") I $D(IBERR)>0 D EHANDLE(IBSET,.IBERR,.IBRESULT)
 ; -- update fields with data (external values)
 D FILE^DIE("E","IBFDA","IBERR") I $D(IBERR)>0 D EHANDLE(IBSET,.IBERR,.IBRESULT)
 Q
 ;
POLOTH(IBBUFDA,IBEXTDA,IBRESULT) ; other special cases that can not be transferred using the generic code above, usually because of dependencies
 N IB0,IBFDA,IBFDAX,IBERR
 S IB0=$G(^IBA(355.33,+IBBUFDA,0))
 ;
 ;  -- if buffer entry was verified before the accept step, then add the correct verifier info to the policy
 I +$P(IB0,U,10) D
 . S IBFDA(2.312,IBEXTDA,1.03)=$E($P(IB0,U,10),1,12),IBFDAX(2.312,IBEXTDA,1.03)=""
 . S IBFDA(2.312,IBEXTDA,1.04)=$P(IB0,U,11),IBFDAX(2.312,IBEXTDA,1.04)=""
 ;
 ; -- update fields with nulls (internally)
 I $D(IBFDAX)>9 D FILE^DIE("","IBFDAX","IBERR") I $D(IBERR)>0 D EHANDLE("POL",.IBERR,.IBRESULT)
 ; -- update fields data (internally)
 I $D(IBFDA)>9 D FILE^DIE("","IBFDA","IBERR") I $D(IBERR)>0 D EHANDLE("POL",.IBERR,.IBRESULT)
 Q
 ;
FIELDS(IBSET,IBFLDS,IBLBLS,IBADDS) ; return array of corresponding fields: IBFLDS(Buffer #)=Ins #
 N IBI,IBLN,IBB,IBE,IBG
 ;
 F IBI=1:1 S IBLN=$P($T(@(IBSET)+IBI),";;",2) Q:IBLN=""  I $E(IBLN,1)'=" " D
 . S IBB=$P(IBLN,U,1),IBE=$P(IBLN,U,2),IBG=$P(IBLN,U,4)
 . I IBB'="",IBE'="" D
 . . S IBFLDS(IBB)=IBE
 . . I IBSET["FLD" S IBLBLS(IBB)=$P(IBLN,U,3) I +IBG S IBADDS(IBB)=IBE
 Q
 ;
EHANDLE(IBSET,FMERR,IBRESULT) ;
 ;Fileman Error Processing tracking added for ACCEPAPI^IBCNICB API.
 ; INPUT:
 ;   IBSET - File where fileman error occurred
 ;      Value = "INS" --> File 36    --> IBRESULT(1)
 ;      Value = "GRP" --> File 355.3 --> IBRESULT(2)
 ;      Value = "POL" --> File 2.312 --> IBRESULT(3)
 ;   FMERR  - Array that is returned by FM with error messages
 ; OUTPUT:
 ;   IBRESULT - Passed array to return FM error message if there are
 ;            errors when filing the data buffer data
 ;
 I $G(IBSET)']""!($D(FMERR)'>0) Q
 N SUB1,RNUM,ERRNUM,LINENUM
 ;
 ; -- numeric 1st subscript of IBRESULT array based on file being updated. File 36 = 1, 355.3 = 2, 2.312 = 3 
 S SUB1=$S(IBSET="INS":1,IBSET="GRP":2,IBSET="POL":3,1:"") Q:SUB1']""
 ;
 S RNUM=$O(IBRESULT(SUB1,"ERR",9999999999),-1),ERRNUM=0
 F  S ERRNUM=$O(FMERR("DIERR",ERRNUM)) Q:+ERRNUM'>0  D
 . S LINENUM=0
 . F  S LINENUM=$O(FMERR("DIERR",ERRNUM,"TEXT",LINENUM)) Q:+LINENUM'>0  D
 . . S RNUM=RNUM+1
 . . S IBRESULT(SUB1,"ERR",RNUM)=FMERR("DIERR",ERRNUM,"TEXT",LINENUM)
 Q
 ;
REMOVDEL(FMERR) ;
 ; Removed field delete errors. SET and STUFF API delete data first and
 ; then update with new data from Insurance Buffer file. Error Code 712
 ; "Deletion was attempted but not allowed" errors will be removed from
 ; the returned FM error array
 ; 
 ; INPUT/OUTPUT:
 ;   FMERR  - Array that is returned by FM with error messages
 ;
 Q:$D(FMERR)'>0
 N ERRNUM
 S ERRNUM=0
 F  S ERRNUM=$O(FMERR("DIERR",ERRNUM)) Q:+ERRNUM'>0  D
 . I FMERR("DIERR",ERRNUM)=712 K FMERR("DIERR",ERRNUM)
 Q
 ;
DPTDR ; -- insurance type subfile(#2.312) ^ insurance verificaiton processor(#355.33) fields ^ insurance type subfile(#2.312) fields
 ;;2.312^90.03;60.05;60.14;60.15;60.16;91.01;.03;.09;.02;60.1;60.11;60.12;62.01;.111;.112;.114;.115;.116;.1173;.131^7.02;6;4.03;4.05;4.06;7.01;3.01;3.05;3.12;4.01;4.02;.2;5.01;3.06;3.07;3.08;3.09;3.1;3.13;3.11
 ;
DPTFLD ; -- insurance verification processor(#355.33) field ^ insurance type subfile(#2.312)
 ;;90.03^7.02^Subscriber Id^          ; Subscriber Id
 ;;60.05^6^Whose Insurance^           ; Whose Insurance
 ;;60.14^4.03^Relationship^             ; Pt. Relationship to Insured
 ;;60.15^4.05^Rx Relationship^        ; Pharmacy Relationship Code
 ;;60.16^4.06^Rx Person Code^         ; Pharmacy Person Code
 ;;91.01^7.01^Subscriber Name^        ; Name of Insured
 ;;.03^3.01^Subscriber's DOB^         ; Insured's DOB
 ;;.09^3.05^Subscriber's SSN^         ; Insured's SSN
 ;;.02^3.12^Subscriber's Sex^         ; Insured's Sex
 ;;60.1^4.01^Primary Provider^        ; Primary Care Provider
 ;;60.11^4.02^Provider Phone^         ; Primary Care Provider Phone
 ;;60.12^.2^Coor of Benefits^         ; Coordination of Benefits
 ;;62.01^5.01^Patient Id^             ; Patient Id
 ;;.111^3.06^Subscr Str Ln 1^         ; Subscriber Address Line 1
 ;;.112^3.07^Subscr Str Ln 2^         ; Subscriber Address Line 2
 ;;.114^3.08^Subscr City^             ; Subscriber City
 ;;.115^3.09^Subscr State^            ; Subscriber State
 ;;.116^3.1^Subscr Zip^               ; Subscriber Zip Code
 ;;.1173^3.13^Subscr Country^         ; Subscriber Country Code
 ;;.131^3.11^Subscr Phone^            ; Subscriber Phone Number
 ;
DGPRDR ; -- insurance type subfile(#2.312) ^ insurance verificaiton processor(#355.33) fields ^ insurance type subfile(#2.312) fields
 ;;2.312^90.03;60.05;60.14;60.15;60.16;.01;.03;.09;.02;60.1;60.11;60.12;62.01;1.2;1.3;1.5;1.6;1.7;1.99;1.8^7.02;6;4.03;4.05;4.06;7.01;3.01;3.05;3.12;4.01;4.02;.2;5.01;3.06;3.07;3.08;3.09;3.1;3.13;3.11
 ;
DGPRFLD ; -- insurance verification processor(#355.33) field ^ insurance type subfile(#2.312)
 ;;90.03^7.02^Subscriber Id^          ; Subscriber Id
 ;;60.05^6^Whose Insurance^           ; Whose Insurance
 ;;60.14^4.03^Relationship^             ; Pt. Relationship to Insured
 ;;60.15^4.05^Rx Relationship^        ; Pharmacy Relationship Code
 ;;60.16^4.06^Rx Person Code^         ; Pharmacy Person Code
 ;;.01^7.01^Subscriber Name^          ; Name of Insured
 ;;.03^3.01^Subscriber's DOB^         ; Insured's DOB
 ;;.09^3.05^Subscriber's SSN^         ; Insured's SSN
 ;;.02^3.12^Subscriber's Sex^         ; Insured's Sex
 ;;60.1^4.01^Primary Provider^        ; Primary Care Provider
 ;;60.11^4.02^Provider Phone^         ; Primary Care Provider Phone
 ;;60.12^.2^Coor of Benefits^         ; Coordination of Benefits
 ;;62.01^5.01^Patient Id^             ; Patient Id
 ;;1.2^3.06^Subscr Str Ln 1^          ; Subscriber Address Line 1
 ;;1.3^3.07^Subscr Str Ln 2^          ; Subscriber Address Line 2
 ;;1.5^3.08^Subscr City^              ; Subscriber City
 ;;1.6^3.09^Subscr State^             ; Subscriber State
 ;;1.7^3.1^Subscr Zip^                ; Subscriber Zip Code
 ;;1.99^3.13^Subscr Country^          ; Subscriber Country Code
 ;;1.8^3.11^Subscr Phone^             ; Subscriber Phone Number
 ;
NDR ; -- insurance type subfile(#2.312) ^ insurance verificaiton processor(#355.33) fields ^ insurance type subfile(#2.312) fields
 ;;2.312^90.03;60.05;60.14;60.15;60.16;.01;.03;.09;.02;60.1;60.11;60.12;62.01;1.2;1.3;1.5;1.6;1.7;1.99;1.8^7.02;6;4.03;4.05;4.06;7.01;3.01;3.05;3.12;4.01;4.02;.2;5.01;3.06;3.07;3.08;3.09;3.1;3.13;3.11
 ;
NFLD ; -- insurance verification processor(#355.33) field ^ insurance type subfile(#2.312)
 ;;90.03^7.02^Subscriber Id^          ; Subscriber Id
 ;;60.05^6^Whose Insurance^           ; Whose Insurance
 ;;60.14^4.03^Relationship^             ; Pt. Relationship to Insured
 ;;60.15^4.05^Rx Relationship^        ; Pharmacy Relationship Code
 ;;60.16^4.06^Rx Person Code^         ; Pharmacy Person Code
 ;;.01^7.01^Subscriber Name^          ; Name of Insured
 ;;.03^3.01^Subscriber's DOB^         ; Insured's DOB
 ;;.09^3.05^Subscriber's SSN^         ; Insured's SSN
 ;;.02^3.12^Subscriber's Sex^         ; Insured's Sex
 ;;60.1^4.01^Primary Provider^        ; Primary Care Provider
 ;;60.11^4.02^Provider Phone^         ; Primary Care Provider Phone
 ;;60.12^.2^Coor of Benefits^         ; Coordination of Benefits
 ;;62.01^5.01^Patient Id^             ; Patient Id
 ;;1.2^3.06^Subscr Str Ln 1^          ; Subscriber Address Line 1
 ;;1.3^3.07^Subscr Str Ln 2^          ; Subscriber Address Line 2
 ;;1.5^3.08^Subscr City^              ; Subscriber City
 ;;1.6^3.09^Subscr State^             ; Subscriber State
 ;;1.7^3.1^Subscr Zip^                ; Subscriber Zip Code
 ;;1.99^3.13^Subscr Country^          ; Subscriber Country Code
 ;;1.8^3.11^Subscr Phone^             ; Subscriber Phone Number
 ;
POLDR ;
 ;;2.312
POLA ; auto set fields
 ;;1.03^NOW^                          ; Date Last Verified (default is person that accepts entry)
 ;;1.04^DUZ^                          ; Verified By        (default is person that accepts entry)
 ;;1.05^NOW^                          ; Date Last Edited
 ;;1.06^DUZ^                          ; Last Edited By
 ;
