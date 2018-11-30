EDPRPT5 ;SLC/MKB - Shift Report ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
SFT(DAY,CSV) ; Get Shift Report for EDPSITE on DAY
 N BEG,END,IN,OUT,LOG,X,X0,X1,X3,X4,S,SOUT,SHIFT
 N CNT,VA,DX,OTH,HR6,TRG,OCB,MO,DIE,UNK,PREV,NEXT,SUB
 N ELAPSE,ADMDEC,STS,DISP,COL
 D INIT ;set counters to 0, SHIFT(#) = start time in seconds
 I 'SHIFT D ERR^EDPRPT(2300013) Q
 S BEG=$S(SHIFT(1)>0:$$FMADD^XLFDT(DAY,-1,,,SHIFT(1)),1:DAY)
 S END=$S(SHIFT(1)>0:$$FMADD^XLFDT(DAY,,,,SHIFT(1)),1:DAY_".2359")
 ;S BEG=$S(SHIFT(1)>0:$$FMADD^XLFDT(DAY,-1,,,SHIFT(SHIFT)),1:DAY)
 ;S END=$S(SHIFT(1)>0:$$FMADD^XLFDT(DAY,,,,SHIFT(SHIFT)),1:DAY_".2359")
 S IN=BEG-.000001 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  D
 . S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 .. S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3)),X4=$G(^(4,1,0))
 .. S STS=$$ECODE^EDPRPT($P(X3,U,2))
 .. ;TDP - Patch 2 mod to catch all dispositions
 .. S DISP=$$ECODE^EDPRPT($P(X1,U,2))
 .. I DISP="" S DISP=$$DISP^EDPRPT($P(X1,U,2))
 .. S DISP=$$UP^XLFSTR(DISP)
 .. S OUT=$P(X0,U,9) ;S:OUT="" OUT=NOW
 .. S ELAPSE=$S(OUT:($$FMDIFF^XLFDT(OUT,IN,2)\60),1:0) ;#min
 .. S ADMDEC=$$ADMIT^EDPRPT(LOG)
D1 .. ; all visits
 .. S S=$$SHIFT(IN,1),SOUT=$$SHIFT(OUT,1) Q:S<1
 .. S CNT(S)=CNT(S)+1
 .. S:'$P(X3,U,3) TRG(S)=TRG(S)+1
 .. S:ELAPSE>359 HR6(S)=HR6(S)+1
 .. S:DISP="O"!(DISP="NVA") OTH(S)=OTH(S)+1
 .. S:DISP="D" DIE(S)=DIE(S)+1
 .. ;TDP - Patch 2, additional checks for Missed Opportunities added
 .. ;S:$$MISSEDOP^EDPRPT3(DISP) MO(S)=MO(S)+1
 .. I (($$MISSEDOP^EDPRPT3(DISP))!($$MISSOP1^EDPRPT3($P(X1,U,2)))) S MO(S)=MO(S)+1
 .. S:DISP="" UNK(S)=UNK(S)+1
 .. I $L(STS),$$UP^XLFSTR(STS)'="GONE",S'=SOUT S OCB(S)=OCB(S)+1
D2 S OUT=BEG-.000001 F  S OUT=$O(^EDP(230,"ATO",EDPSITE,OUT)) Q:'OUT  Q:OUT>END  D
 . S LOG=0 F  S LOG=+$O(^EDP(230,"ATO",EDPSITE,OUT,LOG)) Q:LOG<1  D
 .. S X0=^EDP(230,LOG,0),X1=$G(^(1))
 .. S SOUT=$$SHIFT(OUT,1),DX(SOUT)=DX(SOUT)+1
 .. S IN=$P(X0,U,8) S:IN<BEG PREV=PREV+1
 .. S DISP=$$ECODE^EDPRPT($P(X1,U,2))
 .. S ADMDEC=$$ADMIT^EDPRPT(LOG)
 .. ;TDP - Patch 2, addition checks for VA Admissions added
 .. I ADMDEC,ADMDEC>BEG,(($$VADMIT^EDPRPT2(DISP))!($$VADMIT1^EDPRPT2($P(X1,U,2)))) S S=$$SHIFT(ADMDEC,1),VA(S)=VA(S)+1
D3 ; calculate #carried over
 S PREV("one")=PREV
 F I=1:1:SHIFT D
 . S S=SUB(I)
 . S NEXT(S)=PREV(S)+CNT(S)-DX(S)
 . I I<SHIFT S PREV(SUB(I+1))=NEXT(S)
 ;S S=SUB(SHIFT),NEXT(S)=PREV+CNT(S)-DX(S)
 ;S PREV("one")=NEXT(S),PREV(S)=PREV
 ;F I=1:1:(SHIFT-1) S S=SUB(I),X=SUB($S(I>1:I-1,1:SHIFT)),NEXT(S)=NEXT(X)+CNT(S)-DX(S)
 ;F I=2:1:(SHIFT-1) S PREV(SUB(I))=NEXT(SUB(I-1))
 ;S NEXT("three")=PREV+CNT("three")-DX("three")
 ;S NEXT("one")=NEXT("three")+CNT("one")-DX("one")
 ;S NEXT("two")=NEXT("one")+CNT("two")-DX("two")
 ;S PREV("one")=NEXT("three"),PREV("two")=NEXT("one"),PREV("three")=PREV
D4 ; return column info
 F I=1:1:SHIFT D  ;convert #seconds to HH[:MM]
 . N X,Y S X=SHIFT(I),Y=X\60
 . ;S Y=X\3600 S:Y=0 Y=12 S:Y>12 Y=Y-12
 . S SHIFT(I)=$$ETIME^EDPRPT(Y) ;Y_$S(X#3600:":"_(X#3600)\60,1:"")
 F I=1:1:SHIFT D  ;build column captions
 . S COL(I,"name")=SHIFT(I)_" to "_SHIFT($S(I+1>SHIFT:1,1:I+1))
 . S COL(I,"shiftId")=SUB(I)
 ;S COL(1,"name")="7 to 3",COL(1,"shiftId")="one"
 ;S COL(2,"name")="3 to 11",COL(2,"shiftId")="two"
 ;S COL(3,"name")="11 to 7",COL(3,"shiftId")="three"
 I $G(CSV) D CSV Q
 D XML^EDPX("<columns>")
 F S=1:1:SHIFT K X M X=COL(S) S X=$$XMLA^EDPX("column",.X) D XML^EDPX(X)
 D XML^EDPX("</columns>")
D5 ; return counts and averages as XML
 D XML^EDPX("<categories>")
 S X=$$XMLA^EDPX("category",.PREV) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.CNT) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.DX) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.VA) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.OTH) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.HR6) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.TRG) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.OCB) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.MO) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.DIE) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.UNK) D XML^EDPX(X)
 S X=$$XMLA^EDPX("category",.NEXT) D XML^EDPX(X)
 D XML^EDPX("</categories>")
 Q
 ;
CSV ; Return headers, counts and averages as CSV
 N X,TAB S TAB=$C(9)
 S X="Category"
 F I=1:1:(SHIFT) S X=X_TAB_COL(I,"name")
 D ADD^EDPCSV(X) ;headers
 D ROW("Carried over at Report Start",.PREV)
 D ROW("Number of New Patients",.CNT)
 D ROW("Number of Patients Discharged",.DX)
 D ROW("Number Dec to Admit to VA",.VA)
 D ROW("Number Dec to Admit to Other",.OTH)
 D ROW("Number over Six Hours",.HR6)
 D ROW("Number Waiting for Triage",.TRG)
 D ROW("Number of Occupied Beds",.OCB)
 D ROW("Number of Missed Opportunities",.MO)
 D ROW("Number Deceased",.DIE)
 D ROW("Number With No Disposition",.UNK)
 D ROW("Carry over to Next Shift",.NEXT)
 Q
 ;
ROW(NAME,LIST) ; add row
 N S,I
 S X=NAME
 F I=1:1:(SHIFT) S S=SUB(I),X=X_TAB_LIST(S)
 D ADD^EDPCSV(X)
 Q
 ;
INIT ; Initialize counters and sums
 N I,S
 S PREV=0,DAY=$P(DAY,".")
 D SETUP F I=1:1:SHIFT D
 . S S=$$WORD(I),SUB(I)=S
 . S CNT(S)=0,CNT("category")="Number of New Patients"
 . S DX(S)=0,DX("category")="Number of Patients Discharged"
 . S VA(S)=0,VA("category")="Number Dec to Admit to VA"
 . S OTH(S)=0,OTH("category")="Number Dec to Admit to Other"
 . S HR6(S)=0,HR6("category")="Number over Six Hours"
 . S TRG(S)=0,TRG("category")="Number Waiting for Triage" ;no acuity
 . S OCB(S)=0,OCB("category")="Number of Occupied Beds"
 . S MO(S)=0,MO("category")="Number of Missed Opportunities"
 . S DIE(S)=0,DIE("category")="Number Deceased"
 . S UNK(S)=0,UNK("category")="Number With No Disposition"
 . S PREV(S)=0,PREV("category")="Carried over at Report Start"
 . S NEXT(S)=0,NEXT("category")="Carry over to Next Shift"
 Q
 ;
WORD(X) ; Return name of number X
 N Y
 S Y=$S(X=1:"one",X=2:"two",X=3:"three",X=4:"four",X=5:"five",X=6:"six",X=7:"seven",X=8:"eight",X=9:"nine",X=10:"ten",X=11:"eleven",X=12:"twelve",1:"none")
 I Y="none" S Y=$S(X=13:"thirteen",X=14:"fourteen",X=15:"fifteen",X=16:"sixteen",X=17:"seventeen",X=18:"eighteen",X=19:"nineteen",X=20:"twenty",X=21:"twenty_one",X=22:"twenty_two",X=23:"twenty_three",X=24:"twenty_four",1:"none")
 Q Y
 ;
SETUP ; Create SHIFT(#) list of shift times
 N DUR,OVR,STOP,STRT,TA,X1,X
 S (STOP,OVR)=0
 S TA=+$O(^EDPB(231.9,"C",EDPSITE,0)),X1=$G(^EDPB(231.9,TA,1))
 S (STRT,X)=$P(X1,U,6),DUR=$P(X1,U,7)*60 I DUR'>0 S SHIFT=0 Q
 S SHIFT=1,(STRT,SHIFT(1))=X*60 ;seconds
 F  S X=SHIFT(SHIFT)+DUR D  Q:+STOP
 . I +STRT=0,X>86340 S STOP=1 Q
 . ;I +STRT>0,X>86400 S SHIFT=SHIFT+1,SHIFT(SHIFT)=X-(DUR+1) S STOP=1 Q
 . I +STRT>0,X>86400 S STOP=1 D
 .. S X=X-86400,OVR=1
 . I +OVR,+X'<+STRT S STOP=1 Q
 . S SHIFT=SHIFT+1,SHIFT(SHIFT)=X
 Q
SHIFT(X,TXT) ; Return shift # for time X using SHIFT(#)
 I $G(X)="" Q 0
 N TM,Y
 S Y=0
 S TM=$P($$FMTH^XLFDT(X),",",2) ;#seconds since midnight
 ; bwf 2/15/2012: if there is only 1 shift, then this must be the shift given date range
 I +SHIFT=1,TM>SHIFT(1) S Y=1 S:$G(TXT) Y=$$WORD(Y) Q Y
 ; bwf - end changes
 I +SHIFT(1)=0 D
 . I TM<SHIFT(1)!(TM'<SHIFT(SHIFT)) S Y=SHIFT
 I +SHIFT(1)>0 D
 . I +SHIFT(SHIFT)<+SHIFT(1),TM<SHIFT(1),TM>SHIFT(SHIFT) S Y=SHIFT
 . I +SHIFT(SHIFT)>+SHIFT(1),((TM<SHIFT(1))!(TM>SHIFT(SHIFT))) S Y=SHIFT
 I +Y=0 F I=2:1:SHIFT D  Q:+Y>0
 . I SHIFT(1)=0,TM<SHIFT(I) S Y=I-1 Q
 . I SHIFT(1)>0 D
 .. I SHIFT=I S Y=I-1 Q
 .. I SHIFT(I)<SHIFT(I-1),TM>SHIFT(I-1) S Y=I-1 Q
 .. I SHIFT(I)>SHIFT(I-1),TM<SHIFT(I),TM>SHIFT(I-1) S Y=I-1 Q
 S:$G(TXT) Y=$$WORD(Y)
 ;S Y=$S(TM<25200:"three",TM<54000:"one",TM<82800:"two",1:"three")
 Q Y
 ;
ECODE(IEN) ; Return external value for an Acuity code
 N X,Y S X=$P($G(^EDPB(233.1,IEN,0)),U,3) ;code
 S Y=$S(X="":"none",'X:X,X=1:"one",X=2:"two",X=3:"three",X=4:"four",X=5:"five",1:"X")
 Q Y
