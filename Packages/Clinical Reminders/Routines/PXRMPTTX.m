PXRMPTTX ; SLC/PKR - Routines for taxonomy print templates ;02/27/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;References to ICDAPIU DBIA #3991.
 ;References to ICPTAPIU DBIA #1997.
 ;References to ICDCODE DBIA #3990.
 ;References to ICPTCOD DBIA #1995.
 ;=======================================================
CHKEXP ;Check the expansion
 I '$D(^PXD(811.3,D0)) W !!,"Expansion check; expansion does not exist." Q
 N CODE,EXPOK,EXTRA,FNUM,LMAX,LOW,HIGH,HMAX,LIST,NEWLINE,NEXTRA,NMISS
 N OEXTRA,PTR,TLEN,TYPE
 ;Store 811.3 expansion in EXTRA, "current" one is in ^TMP
 I $D(^PXD(811.3,D0,80,"ICD9P")) M EXTRA("ICD 9")=^PXD(811.3,D0,80,"ICD9P")
 I $D(^PXD(811.3,D0,80.1,"ICD0P")) M EXTRA("ICD 0")=^PXD(811.3,D0,80.1,"ICD0P")
 I $D(^PXD(811.3,D0,81,"ICPTP")) M EXTRA("CPT")=^PXD(811.3,D0,81,"ICPTP")
 S EXPOK=1
 W !!,"Expansion check; expansion was last built on ",$$FMTE^XLFDT($P(^PXD(811.3,D0,0),U,2),"5Z")
 F FNUM=80,80.1,81 D
 . S TYPE=$S(FNUM=80:"ICD 9",FNUM=80.1:"ICD 0",FNUM=81:"CPT",1:"")
 . K LIST
 . S PTR=""
 . F  S PTR=$O(^TMP($J,"TAXEXP",FNUM,PTR)) Q:PTR=""  D
 .. I $D(EXTRA(TYPE,PTR)) K EXTRA(TYPE,PTR),^TMP($J,"TAXEXP",FNUM,PTR)
 . I $D(^TMP($J,"TAXEXP",FNUM)) D
 .. S (HMAX,LMAX)=0
 .. S PTR=""
 .. F  S PTR=$O(^TMP($J,"TAXEXP",FNUM,PTR)) Q:PTR=""  D
 ... S CODE=""
 ... F  S CODE=$O(^TMP($J,"TAXEXP",FNUM,PTR,CODE)) Q:CODE=""  D
 .... S LOW=""
 .... F  S LOW=$O(^TMP($J,"TAXEXP",FNUM,PTR,CODE,LOW)) Q:LOW=""  D
 ..... S TLEN=$L(LOW)
 ..... I TLEN>LMAX S LMAX=TLEN
 ..... S HIGH=""
 ..... F  S HIGH=$O(^TMP($J,"TAXEXP",FNUM,PTR,CODE,LOW,HIGH)) Q:HIGH=""  D
 ...... S TLEN=$L(HIGH)
 ...... I TLEN>HMAX S HMAX=TLEN
 ...... S LIST(CODE_" ",PTR,LOW,HIGH)=""
 . K ^TMP($J,"TAXEXP",FNUM)
 . I $D(LIST) D
 .. W !!,"The following ",TYPE," codes are missing from the expansion:"
 .. W !,?5,"Code",?14,"Range"
 .. S (EXPOK,NMISS)=0
 .. S CODE=""
 .. F  S CODE=$O(LIST(CODE)) Q:CODE=""  D
 ... S NMISS=NMISS+1
 ... W !,$$RJ^XLFSTR(NMISS,4)," ",$$LJ^XLFSTR(CODE,8)
 ... S PTR=""
 ... F  S PTR=$O(LIST(CODE,PTR)) Q:PTR=""  D
 .... S LOW="",NEWLINE=-1
 .... F  S LOW=$O(LIST(CODE,PTR,LOW)) Q:LOW=""  D
 ..... S HIGH=""
 ..... F  S HIGH=$O(LIST(CODE,PTR,LOW,HIGH)) Q:HIGH=""  D
 ...... S NEWLINE=NEWLINE+1
 ...... I NEWLINE=0 W ?14,$$LJ^XLFSTR(LOW,LMAX),"-",$$LJ^XLFSTR(HIGH,HMAX),"  "," (IEN="_PTR_")"
 ...... I NEWLINE>0 W !,?14,$$LJ^XLFSTR(LOW,LMAX),"-",$$LJ^XLFSTR(HIGH,HMAX)
 . I $D(EXTRA(TYPE)) D
 .. S EXPOK=0,NEXTRA=0
 .. W !!,"The following ",TYPE," codes are in the expansion and they should not be:"
 .. K OEXTRA
 .. S PTR=""
 .. F  S PTR=$O(EXTRA(TYPE,PTR)) Q:PTR=""  D
 ... S CODE=$S(FNUM=81:$$CPT^ICPTCOD(PTR,DT),1:$$ICDDX^ICDCODE(PTR,DT))
 ... S OEXTRA($P(CODE,U,2)_" ")=$P(CODE,U,4)_" (IEN="_PTR_")"
 .. S CODE=""
 .. F  S CODE=$O(OEXTRA(CODE)) Q:CODE=""  D
 ... S NEXTRA=NEXTRA+1
 ... W !,$$RJ^XLFSTR(NEXTRA,4),"  ",CODE,?10,OEXTRA(CODE)
 I EXPOK W !,"The expansion is correct."
 Q
 ;
 ;=======================================================
ICD0LIST ;Print expanded list of ICD0 codes.
 N ACTDATE,CODE,DATA,IEN,INADATE,LOW,HIGH,PTR,TEMP,TEXT
 S TEMP=^PXD(811.2,D0,80.1,D1,0)
 S (ACTDATE,INADATE)=$$FMTE^XLFDT(DT,"5Z")
 S LOW=$P(TEMP,U,1)
 S HIGH=$P(TEMP,U,2)
 I HIGH="" S HIGH=LOW
 W !!,?2,"Code",?10,"ICD Operation/Procedure",?42,"Activation",?54,"Inactivation"
 W !,?2,"----",?10,"-----------------------",?42,"----------",?54,"------------"
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . K DATA
 . D PERIOD^ICDAPIU(CODE,.DATA)
 . S ACTDATE=0
 . F  S ACTDATE=$O(DATA(ACTDATE)) Q:ACTDATE=""  D
 .. S INADATE=$P(DATA(ACTDATE),U,1)
 .. S TEXT=$P(DATA(ACTDATE),U,2)
 .. S TEXT=$E(TEXT,1,30)
 .. W !,?2,CODE,?10,TEXT,?42,$$FMTE^XLFDT(ACTDATE,"5Z"),?54,$$FMTE^XLFDT(INADATE,"5Z")
 . S IEN=$P($$STATCHK^ICDAPIU(CODE,""),U,2)
 . S ^TMP($J,"TAXEXP",80.1,IEN,CODE,LOW,HIGH)=""
 . S CODE=$$NEXT^ICDAPIU(CODE)
 Q
 ;
 ;=======================================================
ICD9LIST ;Print expanded list of ICD9 codes.
 N ACTDATE,CODE,DATA,IEN,INADATE,LOW,HIGH,PTR,SEL,TEMP,TEXT
 S TEMP=^PXD(811.2,D0,80,D1,0)
 S LOW=$P(TEMP,U,1)
 S HIGH=$P(TEMP,U,2)
 I HIGH="" S HIGH=LOW
 W !!,?2,"Code",?10,"ICD Diagnosis",?42,"Activation",?54,"Inactivation",?67,"Selectable"
 W !,?2,"----",?10,"--------------",?42,"----------",?54,"------------",?67,"----------"
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . K DATA
 . D PERIOD^ICDAPIU(CODE,.DATA)
 . S IEN=$P(DATA(0),U,1)
 . S SEL=$S($D(^PXD(811.2,D0,"SDX","B",IEN)):"X",1:"")
 . S ACTDATE=0
 . F  S ACTDATE=$O(DATA(ACTDATE)) Q:ACTDATE=""  D
 .. S INADATE=$P(DATA(ACTDATE),U,1)
 .. S TEXT=$P(DATA(ACTDATE),U,2)
 .. W !,?2,CODE,?10,TEXT,?42,$$FMTE^XLFDT(ACTDATE,"5Z"),?54,$$FMTE^XLFDT(INADATE,"5Z"),?71,SEL
 . S PTR=$P($$STATCHK^ICDAPIU(CODE,""),U,2)
 . S ^TMP($J,"TAXEXP",80,PTR,CODE,LOW,HIGH)=""
 . S CODE=$$NEXT^ICDAPIU(CODE)
 Q
 ;
 ;=======================================================
ICPTLIST ;Print expanded list of CPT codes.
 N ACTDATE,CODE,DATA,IEN,INADATE,LOW,HIGH,PTR,SEL,TEMP,TEXT
 S TEMP=^PXD(811.2,D0,81,D1,0)
 S LOW=$P(TEMP,U,1)
 S HIGH=$P(TEMP,U,2)
 I HIGH="" S HIGH=LOW
 W !!,?2,"Code",?10,"CPT Short Name",?42,"Activation",?54,"Inactivation",?67,"Selectable"
 W !,?2,"----",?10,"--------------",?42,"----------",?54,"------------",?67,"----------"
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . K DATA
 . D PERIOD^ICPTAPIU(CODE,.DATA)
 . S IEN=$P(DATA(0),U,1)
 . S SEL=$S($D(^PXD(811.2,D0,"SPR","B",IEN)):"X",1:"")
 . S ACTDATE=0
 . F  S ACTDATE=$O(DATA(ACTDATE)) Q:ACTDATE=""  D
 .. S INADATE=$P(DATA(ACTDATE),U,1)
 .. S TEXT=$P(DATA(ACTDATE),U,2)
 .. W !,?2,CODE,?10,TEXT,?42,$$FMTE^XLFDT(ACTDATE,"5Z"),?54,$$FMTE^XLFDT(INADATE,"5Z"),?71,SEL
 . S PTR=$P($$STATCHK^ICPTAPIU(CODE,""),U,2)
 . S ^TMP($J,"TAXEXP",81,PTR,CODE,LOW,HIGH)=""
 . S CODE=$$NEXT^ICPTAPIU(CODE)
 Q
 ;
 ;=======================================================
TAXLIST ;Taxonomy list.
 N CODES,CPT,CPTLIST,IC,ICD0,ICD0LIST,ICD9,ICD9LIST,IND,NCODES
 S (IC,IND)=0
 F  S IND=+$O(^PXD(811.2,D0,80,IND)) Q:IND=0  D
 . S IC=IC+1
 . S CODES=^PXD(811.2,D0,80,IND,0)
 . S ICD9LIST(IC)=CODES
 S NCODES=IC
 ;
 S (IC,IND)=0
 F  S IND=+$O(^PXD(811.2,D0,80.1,IND)) Q:IND=0  D
 . S IC=IC+1
 . S CODES=^PXD(811.2,D0,80.1,IND,0)
 . S ICD0LIST(IC)=CODES
 S NCODES=$$MAX^XLFMTH(NCODES,IC)
 ;
 S (IC,IND)=0
 F  S IND=+$O(^PXD(811.2,D0,81,IND)) Q:IND=0  D
 . S IC=IC+1
 . S CODES=^PXD(811.2,D0,81,IND,0)
 . S CPTLIST(IC)=CODES
 S NCODES=$$MAX^XLFMTH(NCODES,IC)
 ;Print the list.
 F IC=1:1:NCODES D
 . S ICD9=$G(ICD9LIST(IC))
 . S ICD0=$G(ICD0LIST(IC))
 . S CPT=$G(CPTLIST(IC))
 . W !,?9,$P(ICD9,U,1),?19,$P(ICD9,U,2)
 . W ?29,$P(ICD0,U,1),?39,$P(ICD0,U,2)
 . W ?49,$P(CPT,U,1),?59,$P(CPT,U,2)
 Q
 ;
