IBDF2B ;ALB/CJM - ENCOUNTER FORM - (prints data field);12/15/92
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
DATAFLD(FIELD) ;for printing data fields to the encounter form
 ;IBPRINT("WITH_DATA") means to complete the form with data
 ;RTNLIST is used to keep a list of package interface routines called - it should not be newed
 ;IBPRINT("ENTIRE")=0 means just fill in the data
 ;
 N LASTITEM,RTN,MAXX,MAXY,LABEL,XLAB,YLAB,XIO,YIO,WIO,HIO,BLK,ITEM,PIECE,SPACING,DISPLAY,LAST,VALUE,FLDNAME
 ;LAST - the last subfield read
 Q:'$$FLDDESCR^IBDFU1A(FIELD)  ;get the 0 node of the field description
 Q:BLK='IBBLK  ;check that the field really belongs to correct block
 D RTNDSCR^IBDFU1B(.RTN) ;get the rtn used by the field
 ;if this is not the first time this form is being printed, and the data does not change, quit
 I 'IBPRINT("ENTIRE"),'RTN("CHANGES") Q
 I $G(IBDEVICE("LISTMAN")) D RANGE
 I IBPRINT("WITH_DATA")!('RTN("CHANGES")) D RTN
 I RTN("DATATYPE")=5 D TXTPRINT^IBDF2B1 Q  ;wordprocessing fields treated differently
 ;now do other than wordprocessing
 ;process each subfield
 S LAST=$$SFLDDSCR^IBDFU1A(FIELD,0) Q:'LAST
 F  D  S LAST=$$SFLDDSCR^IBDFU1A(FIELD,LAST) Q:'LAST
 .;print labels unless it's a batch job and the form has already been computed
 .I IBPRINT("ENTIRE"),(LABEL'=""),DISPLAY'["I" D
 ..D DRWSTR^IBDFU(YLAB,XLAB,LABEL,DISPLAY)
 ..I IBDEVICE("LISTMAN"),((XLAB+($L(LABEL)-1))>MAXX)!(YLAB>MAXY) D WARNING
 .D PRNTDATA
 Q
RANGE ;sets MAXX and MAXY to the maximum values allowed for the X,Y coordinates
 N BOX
 S BOX=$S(IBBLK("BOX")'=2:1,1:0)
 S MAXY=IBBLK("H")-(1+BOX)
 S MAXX=IBBLK("W")-(1+BOX)
 Q
PRNTDATA ;displays the correct data to the subfield
 N PVALUE,NODE
 I RTN("DATATYPE")=1!(RTN("DATATYPE")=3) S PIECE=1
 Q:'PIECE
 S NODE=$$DATANODE^IBDFU1B(RTN,PIECE)
 S PVALUE=$P($S(NODE'="":$G(VALUE(NODE)),1:$G(VALUE)),"^",PIECE)
 I WIO,PVALUE="" D
 .;print the underscore only if the data is not variable
 .I IBDEVICE("LISTMAN") S PVALUE=$S(IBPRINT("WITH_DATA")&RTN("CHANGES"):$J("",WIO),1:$$HLINE^IBDFU(WIO)) Q
 .I 'RTN("CHANGES") S PVALUE=$$HLINE^IBDFU(WIO)
 I PVALUE'="" D
 .I ('IBDEVICE("LISTMAN")),($L(PVALUE)>WIO),RTN("FULL") D OVERFLOW("CURRENT")
 .I 'IBDEVICE("LISTMAN"),((RTN("DATATYPE")=3)!(RTN("DATATYPE")=4)),LASTITEM,$O(@RTN("DATA_LOCATION")@(ITEM)),RTN("FULL") D OVERFLOW("NEXT")
 .D DRWSTR^IBDFU(YIO,XIO,$$PADRIGHT^IBDFU(PVALUE,WIO))
 .I IBDEVICE("LISTMAN"),((XIO+WIO-1)>MAXX)!(YIO>MAXY) D WARNING
 Q
RTN ;calls the rtn specified by the pkg interface if ok
 Q:RTN("ACTION")'=2
 Q:RTN("NAME")=""
 ;quit if its not the first time this form has been printed and the data is not changeable
 Q:(('IBPRINT("ENTIRE"))&('RTN("CHANGES")))
 ;
 N NODE S NODE=""
 ;call the interface routine if it has not already been called
 I '$D(RTNLIST(RTN("RTN"))) Q:'$$DORTN^IBDFU1B(.RTN)
 ;
 ;keep a list of rtns called because some routines return multiple data elements
 S:'IBDEVICE("LISTMAN") RTNLIST(RTN("RTN"))=""
 ;
 ;now fetch the value, unless it's wordprocessing field
 I (RTN("DATATYPE")=1)!(RTN("DATATYPE")=2) S VALUE=$G(@RTN("DATA_LOCATION")) F  S NODE=$O(@RTN("DATA_LOCATION")@(NODE)) Q:NODE=""  S VALUE(NODE)=$G(@RTN("DATA_LOCATION")@(NODE)) Q
 I (RTN("DATATYPE")=3)!(RTN("DATATYPE")=4),ITEM S VALUE=$G(@RTN("DATA_LOCATION")@(ITEM)) F  S NODE=$O(@RTN("DATA_LOCATION")@(ITEM,NODE)) Q:NODE=""  S VALUE(NODE)=$G(@RTN("DATA_LOCATION")@(ITEM,NODE))
 Q
 ;
ADDLINES ;if there are unused lines writes blank lines to the form
 ;LNSUSED is the number of lines used already,HIO is the total number of lines allowed
 N I,LSPACING,NUMLEFT
 Q:HIO'>0
 I LNSUSED'<HIO Q
 S LSPACING=1
 I (SPACING=2)!(SPACING=3) S LSPACING=2
 S NUMLEFT=HIO-LNSUSED
 S NUMLEFT=NUMLEFT\LSPACING
 I IBDEVICE("LISTMAN") D
 .I ((XIO+WIO-1)>MAXX)!((YIO+(NUMLEFT*LSPACING)-1)>MAXY) D WARNING
 F I=1:1:NUMLEFT D DRWSTR^IBDFU(YIO+LNSUSED+(I*LSPACING)-1,XIO,$$HLINE^IBDFU(WIO))
 Q
WARNING ; prints a warning that data field prints outside of block - meant only for display while editing a form description
 Q:IBWARN
 W !,"Data Field="_FLDNAME_" in Block="_IBBLK("NAME")_" is printing",!,"outside of the block!"
 D PAUSE^IBDFU5
 S IBWARN=1
 Q
OVERFLOW(TYPE) ;keeps track of data that does not fit on the form
 ;TYPE=="CURRENT" if other than a WP field will not fit
 ;    ="NEXT" if the data is from a list and the last item indicator is set
 S @IBARRAY("OVERFLOW")@(IBBLK,FIELD,TYPE)=$G(ITEM)
 Q
