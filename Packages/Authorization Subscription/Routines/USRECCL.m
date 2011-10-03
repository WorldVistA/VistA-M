USRECCL ; SLC/PKR,MA - Routines for expanding/collapsing class views ;11/25/09
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**7,18,33**;Jun 20, 1997;Build 7
 ; Patch USR*1*18 additional quit to contract logic in tag EC.
 ; This routine invokes IA #872
 ;======================================================================
COPYCL(LIST,LSTART,START,END) ;Copy elements of ^TMP("USRCLASS",$J) starting
 ;at START going to END.
 N IND,TEXT
 F IND=START:1:END D
 . S LSTART=LSTART+1
 . S TEXT=^TMP("USRCLASS",$J,IND,0)
 . S TEXT=$$SETFLD^VALM1(LSTART,TEXT,"NUMBER")
 . S LIST(LSTART)=TEXT_U_$P($G(^TMP("USRCLASSIDX",$J,IND)),U,2)
 Q LSTART
 ;
 ;======================================================================
EC(USRVALMY) ;Expand or contract the list of classes in VALMY.
 ;Make sure the request is valid.
 I '$$VEXREQ(.USRVALMY) Q
 N ACTION,DIROUT,LISTNUM,REBUILD,START,TSTART,TEXT,USRTMP
 N USRDATA,USRI,USRIEN,USRPICK,TMP0
 S REBUILD=0
 S START=1
 S TSTART=0
 S USRI=""
 F  S USRI=$O(VALMY(USRI)) Q:+USRI'>0  D  Q:$D(DIROUT)
 . S USRDATA=^TMP("USRCLASSIDX",$J,USRI)
 . S LISTNUM=$P(USRDATA,U,1)
 . S USRIEN=$P(USRDATA,U,2)
 . S TEXT=$G(^TMP("USRCLASS",$J,LISTNUM,0))
 . S ACTION=$S(TEXT["+":"+",TEXT["-":"-",1:"")
 . I ACTION="" Q
 .;If ACTION="+" then expand the class, if ACTION="-" shrink the class.
 . I ACTION="+" D
 .. S REBUILD=1
 .. S TSTART=$$COPYCL(.USRTMP,TSTART,START,LISTNUM-1)
 .. S START=LISTNUM+1
 .. S TSTART=TSTART+1
 .. S USRTMP(TSTART)=$$SETFLD^VALM1(TSTART,TEXT,"NUMBER")
 .. S USRTMP(TSTART)=$TR(USRTMP(TSTART),"+","-")
 .. S USRTMP(TSTART)=USRTMP(TSTART)_U_USRIEN
 .. S TSTART=$$INSSUB(.USRTMP,TSTART,USRIEN)
 . ; -- ACTION="-" --
 . I ACTION="-" D
 .. N TEMP,CONTRACT
 .. S REBUILD=1
 .. S TSTART=$$COPYCL(.USRTMP,TSTART,START,LISTNUM-1)
 .. S TSTART=TSTART+1
 .. S USRTMP(TSTART)=$$SETFLD^VALM1(TSTART,TEXT,"NUMBER")
 .. S USRLEVEL=$L(TEXT,"|")
 .. S USRTMP(TSTART)=$TR(USRTMP(TSTART),"-","+")_U_USRIEN
 .. S START=USRI+1
 .. S CONTRACT=1
 .. ; Patch 18 added the second quit.
 .. F  Q:'CONTRACT  Q:'$D(^TMP("USRCLASS",$J,START,0))  D
 ... S TEMP=^TMP("USRCLASS",$J,START,0)
 ...;Contract if at a or higher level than the main line
 ... I TEMP["|",$L(TEMP,"|")>USRLEVEL S START=START+1
 ... E  S CONTRACT=0
 .;
 .;Restore the original video attributes.
 . D RESTORE^VALM10(USRI)
 ;No more classes to expand or contract, add the rest of the list.
 I 'REBUILD Q
 S TMP0=^TMP("USRCLASS",$J,0)
 S LISTNUM=$P(TMP0,U)
 S TSTART=$$COPYCL(.USRTMP,TSTART,START,LISTNUM)
 ;Rebuild the ^TMP arrays.
 K ^TMP("USRCLASS",$J),^TMP("USRCLASSIDX",$J),^TMP("USRCLASS",$J,"PICK")
 S VALMCNT=0
 S START=0
 F  S START=$O(USRTMP(START)) Q:START=""  D
 . S VALMCNT=VALMCNT+1
 . S TEXT=$P(USRTMP(START),U,1)
 . S USRIEN=$P(USRTMP(START),U,2)
 . S ^TMP("USRCLASS",$J,START,0)=TEXT
 . S ^TMP("USRCLASS",$J,"IDX",START,START)=""
 . S ^TMP("USRCLASSIDX",$J,START)=START_U_USRIEN
 S ^TMP("USRCLASS",$J,0)=VALMCNT_U_$P(TMP0,U,2)_$P(TMP0,U,3)_$P(TMP0,U,4)
 S USRPICK=+$O(^ORD(101,"B","USR ACTION SELECT LIST ELEMENT",0))
 S ^TMP("USRCLASS",$J,"#")=USRPICK_U_"1:"_+$G(VALMCNT)
 Q
 ;
 ;======================================================================
INSSUB(LIST,TSTART,USRIEN) ;Insert the subclasses into the list.
 N ACTIVE,CLN,CLNS,DATA,IND,IEN,USRLEVEL,MSG,TEXT
 ;Determine the level of the subclass and create the appropriate
 ;diagram.
 S USRLEVEL=$L(LIST(TSTART),"|")
 I USRLEVEL=1 S CLNS=" "
 E  S CLNS=""
 F IND=2:1:USRLEVEL S CLNS=CLNS_" | "
 I USRLEVEL>1 S CLNS=CLNS_" |_"
 E  S CLNS=CLNS_"|_"
 S IND=0
 F  S IND=$O(^USR(8930,USRIEN,1,IND)) Q:+IND=0  D
 . S IEN=^USR(8930,USRIEN,1,IND,0)
 . S DATA=$G(^USR(8930,IEN,0))
 . S TSTART=TSTART+1
 . S TEXT=$$SETFLD^VALM1(TSTART,"","NUMBER")
 . S CLN=CLNS
 . I $D(^USR(8930,IEN,1,0))&$D(^USR(8930,IEN,1,"B")) S CLN=CLN_"+"
 . E  S CLN=CLN_" "
 . S CLN=CLN_$P(DATA,U) ; Use .01 name, not dipsplay name
 . S TEXT=$$SETFLD^VALM1(CLN,TEXT,"CLASS NAME")
 . S TEXT=$$SETFLD^VALM1($P(DATA,U,2),TEXT,"ABBREVIATION")
 . S ACTIVE=$$EXTERNAL^DILFD(8930,.03,"",$P(DATA,U,3),"MSG")
 . S TEXT=$$SETFLD^VALM1(ACTIVE,TEXT,"ACTIVE")
 .;NEED USRCLASSIDX INFO
 . S LIST(TSTART)=TEXT_U_IEN
 Q TSTART
 ;
 ;======================================================================
ISSUB(CLASS1,CLASS2,USRLEVEL) ;Return true if CLASS2 is sub to CLASS1.
 N IND,ISSUB
 I USRLEVEL(CLASS1)'<USRLEVEL(CLASS2) Q 0
 ;Check sublevel links between class1 and class2
 S ISSUB=1
 F IND=(CLASS1+1):1:(CLASS2-1) D
 . I USRLEVEL(IND)=1 D  Q
 .. S ISSUB=0
 Q ISSUB
 ;
 ;======================================================================
VEXREQ(VALMY) ;Check for valid expand/contract requests.
 N END,START
 S START=$O(VALMY(""))
 S END=$O(VALMY(""),-1)
 I START=END Q 1
 ;
 N ACTION,ACTIND,ACTJND,CIND,CN,IND,JND,USRLEVEL,MSG,TEXT,VALID
 ;Build the level list.
 F IND=START:1:END D
 . S USRLEVEL(IND)=$L(^TMP("USRCLASS",$J,IND,0),"|")
 S VALID=1
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:IND=""  D
 . S TEXT(IND)=$G(^TMP("USRCLASS",$J,IND,0))
 . S ACTIND=$S(TEXT(IND)["+":"+ ",TEXT(IND)["-":"-",1:"")
 . I ACTIND="" Q
 . S ACTION(IND)=$S(TEXT(IND)["+":"expand ",TEXT(IND)["-":"collapse ",1:"")
 . S JND=IND
 . F  S JND=$O(VALMY(JND)) Q:JND=""  D
 .. S TEXT(JND)=$G(^TMP("USRCLASS",$J,JND,0))
 .. S ACTJND=$S(TEXT(JND)["+":"+",TEXT(JND)["-":"-",1:"")
 .. I ACTJND="" Q
 .. S ACTION(JND)=$S(TEXT(JND)["+":"expand ",TEXT(JND)["-":"collapse ",1:"")
 .. I $$ISSUB(IND,JND,.USRLEVEL) D
 ... I ACTION(IND)'=ACTION(JND) D  Q
 .... S CIND(IND)=$P(^TMP("USRCLASSIDX",$J,IND),U,2)
 .... S CN(IND)=$P(^USR(8930,CIND(IND),0),U,1)
 .... S CIND(JND)=$P(^TMP("USRCLASSIDX",$J,JND),U,2)
 .... S CN(JND)=$P(^USR(8930,CIND(JND),0),U,1)
 .... S MSG="You cannot "_ACTION(IND)_CN(IND)_" and "_ACTION(JND)_CN(JND)
 .... D MSG^VALM10(MSG)
 .... H 4
 .... S VALID=0
 Q VALID
 ;
