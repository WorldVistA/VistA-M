TIUPRPN3 ;SLC/MJC-Sort PNs for Prting;;6/26/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,121**;Jun 20, 1997
 ;
SETUP(TITLE) ;displays centered option hdr
 N TIULINE
 S $P(TIULINE,"-",80)=""
 W @IOF,!!?(IOM-$L(TITLE)\2),TITLE,!,TIULINE,!
 Q
PT ;sorts PNs to prt by pt for selected date range
 ;these notes are chartable either contiguous or separate pgs
 ;[TIU PRINT PN PT]
 ;
 N TIUDFN,TIUQT,DIC,Y,TIUXREF,CTR1
 D SETUP("Print Progress Notes for a Selected PATIENT")
 F  W ! S DIC=2,DIC(0)="AEQMN" D ^DIC Q:Y<0  D  K TIUQT
 .N TIUFLAG,TIUSPG
 .S CTR1=0,TIUDFN=Y,TIUXREF="APTP" ;pt/pt x-ref
 .D FETCH(TIUXREF,TIUDFN,.CTR1) Q:$D(TIUQT)
 .S TIUFLAG=$$FLAG() Q:TIUFLAG']""
 .I +$G(TIUFLAG),CTR1>1 S TIUSPG=$$PAGE Q:TIUSPG']""
 .S TIUSPG=$S(+$G(TIUSPG):0,1:1)
 .D DEVICE^TIUPRPN(TIUFLAG,TIUSPG)
 Q
 ;
AUTHOR ;sorts PNs to prt by author for selected date range
 ;these guys are only chartable if prted on separate pages
 ;[TIU PRINT PN AUTHOR]
 ;
 N TIUDUZ,TIUQT,DIC,Y,TIUXREF
 D SETUP("Print Progress Notes for a Selected AUTHOR")
 S DIC=200,DIC(0)="AEQMN",DIC("A")="AUTHOR: "
 F  W ! D ^DIC Q:Y<0  D  K TIUQT
 .N TIUFLAG,TIUSPG
 .S TIUDUZ=Y,TIUXREF="AAUP" ;author/author x-ref
 .D FETCH(TIUXREF,TIUDUZ) Q:$D(TIUQT)
 .S TIUFLAG=$$FLAG() Q:TIUFLAG']""
 .S TIUSPG=$S(+$G(TIUFLAG):0,1:1)
 .D DEVICE^TIUPRPN(TIUFLAG,TIUSPG)
 Q
 ;
LOC ;sorts PNs to prt by location for selected date range
 ;they are only chartable if prted on separate pages
 ;[TIU PRINT PN LOC]
 ;
 N TIUDUZ,TIUQT,DIC,Y,TIUXREF
 D SETUP("Print Progress Notes for a Selected LOCATION")
 S DIC=44,DIC(0)="AEQMN"
 F  W ! D ^DIC Q:Y<0  D  K TIUQT
 .N TIUFLAG,TIUSPG
 .S TIULOC=Y,TIUXREF="ALOCP" ;location/location x-ref
 .D FETCH(TIUXREF,TIULOC) Q:$D(TIUQT)
 .S TIUFLAG=$$FLAG() Q:TIUFLAG']""
 .S TIUSPG=$S(+$G(TIUFLAG):0,1:1)
 .D DEVICE^TIUPRPN(TIUFLAG,TIUSPG)
 Q
 ;
FETCH(TIUXREF,ENTITY,CTR1) ;get available notes, select date range
 ; Passes back optional CTR1 = # of notes
 N OLD,NEW,BEG,END,HOLD,SORT,DFN,IFN,Y,DATE
 S OLD=0 S OLD=$O(^TIU(8925,TIUXREF,+ENTITY,OLD))
 I 'OLD D  S TIUQT=1 Q
 .W !!,$C(7),"No signed notes available for "_$P(ENTITY,U,2),!
 S OLD=$O(^TIU(8925,TIUXREF,+ENTITY,0))
 S NEW=$O(^TIU(8925,TIUXREF,+ENTITY,9999999),-1)
 W !!,"Available note",$S(OLD'=NEW:"s",1:""),": "
 W $$FMTE^XLFDT(OLD,"D")
 I OLD'=NEW W " thru ",$$FMTE^XLFDT(NEW,"D")
FISH I OLD=NEW S (BEG,END)=$E(OLD,1,7)
 E  D  W ! K %DT G:$D(TIUQT) FETCHX
 .S %DT="AEPTX",%DT(0)="-NOW",%DT("A")="Print Notes Beginning: "
 .D ^%DT I $D(DTOUT)!(Y<0) S TIUQT=1 Q
 .S BEG=Y,%DT("A")="                 Thru: "
 .S %DT="AEPTX" D ^%DT I $D(DTOUT)!(Y<0) S TIUQT=1 Q
 .S END=Y I END<BEG S HOLD=BEG,BEG=END,END=HOLD
 ; load up the notes
 W !!,"Searching for the notes"
 K ^TMP("TIUPR",$J),^TMP("TIUREPLACE",$J)
 S DATE=BEG,END=END+.9999999
 F  S DATE=$O(^TIU(8925,TIUXREF,+ENTITY,DATE)) Q:'DATE!(DATE>END)  D
 .S IFN=0 F  S IFN=$O(^TIU(8925,TIUXREF,+ENTITY,DATE,IFN)) Q:'IFN  D
 ..W "." D REPLACE(IFN,DATE,1501)
 S IFN=0 F  S IFN=$O(^TMP("TIUREPLACE",$J,IFN)) Q:'IFN  Q:'^TMP("TIUREPLACE",$J,IFN)  D
 .S DFN=$P(^TIU(8925,IFN,0),U,2),SORT=$P(^DPT(DFN,0),U)_";"_DFN
 .S DATE=^TMP("TIUREPLACE",$J,IFN,"DT")
 .S ^TMP("TIUPR",$J,SORT,DATE,IFN)="Vice SF 509"
 I '$D(^TMP("TIUPR",$J)) W !!,"No notes found- try again!",! G FISH
 S CTR1=+$G(^TMP("TIUREPLACE",$J))
 W !,">> "_CTR1_" note"_$S(CTR1>1:"s",1:"")_" found for "_$P(ENTITY,U,2)
FETCHX ;
 K ^TMP("TIUREPLACE",$J)
 Q
 ;
REPLACE(TIUDA,DATTIM,DTFIELD,CKCANVW) ; Populate TMP array
 ;w record received, replacing ID kids or addenda with their parents.
 ; Requires TIUDA. 
 ; Sets ^TMP("TIUREPLACE",$J,IFN)=1 or 1^TIUDA, or 0,
 ;where IFN is TIUDA or its ID parent.
 ; If TIUDA is replaced by its parent, then
 ;^TMP("TIUREPLACE",$J,IFN)=1^TIUDA,
 ;to know what child the parent was included in the list for.
 ; If CKCANVW = 1 is received, code checks CAN VIEW before
 ;setting TMP array.
 ; Sets ^TMP("TIUREPLACE",$J) = # of [viewable] elements in array
 ; Optional DATTIM = 
 ;      Signature date/time of record, NOT inverse, if DTFIELD = 1501
 ;      Reference date/time of record, inverse, if DTFIELD = 1301
 ;If DATTIM received=non null, sets
 ; ^TMP("TIUREPLACE",$J,IFN,"DT")=DATTIM
 ;  Optional DTFIELD = 1501 or 1301; default = 1501
 ; 1/11/01 cf REPLACE^TIUSRVLL.
 N IDPRNT,PDATTIM,DTNODE,PCANDO,CANDO
 S ^TMP("TIUREPLACE",$J)=+$G(^TMP("TIUREPLACE",$J))
 S IDPRNT=+$G(^TIU(8925,TIUDA,21)) ; ID parent
 ; -- If user can't view record, quit and
 ;    if it is parent, track it as already processed
 ;    (but not a 'good' record):
 I $G(CKCANVW) D  Q:'$G(CANDO)
 . S CANDO=+$$CANDO^TIULP(TIUDA,"VIEW")
 . I '$G(CANDO),$O(^TIU(8925,"GDAD",TIUDA,0)) S ^TMP("TIUREPLACE",$J,TIUDA)=0
 S DTNODE=$S($G(DTFIELD)=1301:13,1:15)
 ; -- If record is child with nonexistent parent,
 ;    treat record as stand-alone:
 I '$D(^TIU(8925,IDPRNT,0)) S IDPRNT=0
 ; -- If record is child, & parent already in array
 ;    from previous cycle (viewable or not), just quit:
 I IDPRNT,$D(^TMP("TIUREPLACE",$J,IDPRNT)) G REPX
 ; -- If record is child, & parent not viewable,
 ;    track parent as processed but not 'good' & quit:
 I IDPRNT,$G(CKCANVW) D  I '$G(PCANDO) G REPX
 . S PCANDO=+$$CANDO^TIULP(IDPRNT,"VIEW")
 . I '$G(PCANDO) S ^TMP("TIUREPLACE",$J,IDPRNT)=0
 ; -- If record is not child, just put it
 ;    in array and quit: --
 I 'IDPRNT D  G REPX
 . ; -- If record is already in array as parent from previous cycle
 . ;    (viewable or not), and is now received on its own merit,
 . ;    quit & don't consider it there because of a child:
 . I $D(^TMP("TIUREPLACE",$J,TIUDA)) S ^TMP("TIUREPLACE",$J,TIUDA)=+^TMP("TIUREPLACE",$J,TIUDA) Q
 . S ^TMP("TIUREPLACE",$J,TIUDA)=1
 . I $G(DATTIM)'="" S ^TMP("TIUREPLACE",$J,TIUDA,"DT")=DATTIM
 . S ^TMP("TIUREPLACE",$J)=$G(^TMP("TIUREPLACE",$J))+1
 ; -- If record is child, put its parent in array:
 I IDPRNT,$G(DATTIM)'="" D
 . S PDATTIM=+$G(^TIU(8925,IDPRNT,DTNODE))
 . I PDATTIM,DTNODE=13 S PDATTIM=9999999-PDATTIM
 I IDPRNT D  G REPX
 . S ^TMP("TIUREPLACE",$J,IDPRNT)=1_U_TIUDA ;parent in array because of child TIUDA
 . I $G(DATTIM)'="" S ^TMP("TIUREPLACE",$J,IDPRNT,"DT")=PDATTIM
 . S ^TMP("TIUREPLACE",$J)=$G(^TMP("TIUREPLACE",$J))+1
REPX Q
 ;
FLAG() ;asks question for CHART vs. WORK copies
 ;returns TIUFLAG=1 if CHART copy - TIUFLAG=0 if WORK copy - NULL if '^'
 S TIUFLAG=$$READ^TIUU("SA^C:CHART;W:WORK","Do you want WORK copies or CHART copies? ","CHART","^D HELP^TIUPRPN3")
 I $E(TIUFLAG)="^" S TIUFLAG=""
 E  S TIUFLAG=$S($P(TIUFLAG,U)="C":1,1:0)
 Q TIUFLAG
 ;
PAGE() ;asks question for CONTIGUOUS vs. SEPARATE PAGE print
 ;returns TIUSPG=0 for CONTIGUOUS - TIUSPG=1 SEPARATE PAGE - NULL if '^'
 S TIUSPG=$$READ^TIUU("YA","Do you want to start each note on a new page? ","NO","^D HELP1^TIUPRPN3")
 I $E(TIUSPG)="^" S TIUSPG=""
 E  S TIUSPG=$S(+$G(TIUSPG):1,1:0)
 Q TIUSPG
HELP ; answers questions regarding WORK vs. CHART copies
 W !!?5,"The FOOTERS of WORK/CHART copies vary significantly.  The WORK"
 W !?5,"FOOTER has the patient's phone number and is clearly marked:"
 W !?5,"'NOT FOR MEDICAL RECORD'.  Unless you really intend to file the"
 W !?5,"note(s) in the chart- print a WORK copy."
 Q
HELP1 ; answers the 'ea note on a new page' question
 W !!?5,"The option selected will produce CHARTABLE contiguous notes."
 W !?5,"If you are filling in a chart that has handwritten notes, or,"
 W !?5,"you'd prefer to begin each note on a new page; answer 'YES'."
 Q
