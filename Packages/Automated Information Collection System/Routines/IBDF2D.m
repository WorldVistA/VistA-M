IBDF2D ;ALB/CJM - ENCOUNTER FORM - WRITE SELECTION LIST ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15**;APR 24, 1997
 ;prints a selection list
PRINTLST(IBLIST) ;writes the selection list to the print array
 ;IBLIST - pointer to a selection list
 ;
 N GROUPODR,SLCTNODR,GROUP,SLCTN,PRRGROUP,QUIT,COL,CWIDTH,CUTLEFT,CUTRIGHT,BOX,LINE,NEEDUPR,ALL,CNT,DRWBBL,TRACKBBL,LOCATION,HDR,SUBHDR
 ;CWIDTH=the width of the entries, including end "|"
 ;BOX=1 if the block is outlined
 ;LINE=1 if the separator between subcolumns has "|"
 ;NEEDUPR=1 if, when printing a group header, the row above should be underlined also - cures a defect caused when some subcolumns NOT underlined
 ;ALL=0 if list is dynamic and only data should be printed
 ;DRWBBL=1 while printing bubbles - can turn off printing of bubbles by setting DRWBBL=0
 ;TRACKBBL=1 if bubbles are going into form tracking - for dynamic lists
 ;HDR=text of group header
 ;SUBHDR=text of subheader within group (defined as a place holder)
 ;
 S (TRACKBBL,GROUPODR,SLCTNODR,GROUP,SLCTN,PRRGROUP,COL,QUIT,NEEDUPR,CNT,SUBHDR,HDR)=""
 S (DRWBBL,ALL)=1
 ;
 Q:$$LSTDESCR^IBDFU1(.IBLIST)
 Q:IBLIST("BLK")'=IBBLK
 S BOX=$S(IBBLK("BOX")=2:0,1:1)
 S LINE=(IBLIST("SEP")["|")
 I 'IBLIST("NUMCOL") S IBLIST("NUMCOL")=8
 D SCDESCR^IBDFU1(.IBLIST,.CWIDTH)
 I IBLIST("DYNAMIC"),'IBPRINT("ENTIRE") S ALL=0
 I IBLIST("DYNAMIC"),IBPRINT("WITH_DATA") D GETDATA(.LOCATION)
 ;
 ;should the bubbles be written to form tracking?
 I IBLIST("DYNAMIC") I $G(IBPFID),$G(IBFORM("SCAN",IBBLK("PAGE"))),IBLIST("INPUT_RTN"),IBDEVICE("PCL") S TRACKBBL=1
 ;
 ;get the first column
 D GETCOL^IBDF2D1(.COL) I 'COL D:IBDEVICE("LISTMAN")  Q
 .W !!,"The LIST="_IBLIST("NAME")_" in BLOCK="_IBBLK("NAME")_" requires at least",!,CWIDTH_" columns in order to display!",!
 .D PAUSE^IBDFU5
 ;
 D:ALL OTHER^IBDF2D2
 D DRWCOL^IBDF2D1(.COL)
 F  D  Q:QUIT
 .S PRRGROUP=GROUP
 .D NEXT(.GROUP,.GROUPODR,.SLCTNODR,.SLCTN) I 'SLCTN S QUIT=1 Q
 .I COL("ROWSLEFT")<(1+IBLIST("BTWN")) D GETCOL^IBDF2D1(.COL) S:'COL QUIT=1 Q:QUIT  D DRWCOL^IBDF2D1(.COL)
 .D DISPLAY^IBDF2D3(SLCTN,.COL,HDR,.SUBHDR)
 ;
 ;for dynamic lists, if full data is needed, add to overflow report if there is more data
 ;
 I 'IBDEVICE("LISTMAN"),IBLIST("DYNAMIC"),IBLIST("OVERFLOW"),SLCTN S @IBARRAY("OVERFLOW")@(IBBLK,IBLIST,"DYNAMIC LIST")=""
 ;
 ;no selections left - fill in with blank selections, unless dynamic and just filling in with data
 I ALL S SLCTN="",QUIT=0 S:('IBLIST("DYNAMIC"))!('IBLIST("INPUT_RTN")) DRWBBL=0 F  Q:'COL  D
 .F  Q:(COL("ROWSLEFT")<(IBLIST("BTWN")+1))  D DISPLAY^IBDF2D3(SLCTN,.COL,HDR,.SUBHDR)
 .D GETCOL^IBDF2D1(.COL) S:'COL QUIT=1 Q:QUIT  D DRWCOL^IBDF2D1(.COL)
 ;
 I IBDEVICE("LISTMAN"),GROUP D NEXT(.GROUP,.GROUPODR,.SLCTNODR,.SLCTN) I SLCTN W !,"There are entries that do not fit on the ",IBLIST("NAME")," list!",!,"Column width="_CWIDTH,!,"Make more room to display all of the entries!",! D PAUSE^IBDFU5
 ;
 ;
EXIT ;
 Q
 ;
NEXT(GROUP,GROUPODR,SLCTNODR,SLCTN) ;finds the next selction to be printed
 ;** PARAMETERS - must be passed by reference **
 N QUIT S QUIT=0
 I IBLIST("DYNAMIC") D  Q
 .I IBPRINT("WITH_DATA") S:SLCTN="" SLCTN=0 S SLCTN=$O(@LOCATION@(SLCTN))
 S GROUP=$G(GROUP),SLCTN=$G(SLCTN),GROUPODR=$G(GROUPODR),SLCTNODR=$G(SLCTNODR)
 F  Q:QUIT  D
 .I 'GROUP!(SLCTNODR="") D NXTGROUP(.GROUP,.GROUPODR) S (SLCTNODR,SLCTN)="" S:'GROUP QUIT=1 Q:QUIT  I COL D  Q:QUIT
 ..I COL("ROWSLEFT")<1 D GETCOL^IBDF2D1(.COL) S:'COL QUIT=1 Q:QUIT  D DRWCOL^IBDF2D1(.COL)
 ..D GROUPHDR(GROUP,.COL,.HDR,.SUBHDR)
 .I SLCTNODR="" S SLCTNODR=$O(^IBE(357.3,"APO",IBLIST,GROUP,"")) I SLCTNODR="" Q
 .S SLCTN=$O(^IBE(357.3,"APO",IBLIST,GROUP,SLCTNODR,SLCTN)) S:SLCTN QUIT=1 S:'SLCTN SLCTNODR=$O(^IBE(357.3,"APO",IBLIST,GROUP,SLCTNODR))
 Q
NXTGROUP(GROUP,GROUPODR) ;
 ;** PARAMETERS - must be passed by reference **
 ;
 N QUIT S QUIT=0
 F  Q:QUIT  D
 .I (GROUPODR="")!('GROUP) S GROUPODR=$O(^IBE(357.4,"APO",IBLIST,GROUPODR)),GROUP="" I GROUPODR="" S QUIT=1 Q
 .S GROUP=$O(^IBE(357.4,"APO",IBLIST,GROUPODR,GROUP)) S:GROUP QUIT=1
 Q
 ;
GROUPHDR(GROUP,COL,HDR,SUBHDR) ;writes the group header to the list
 ;COL is the column to write at
 ;returns HDR=displayed text if passed by reference
 ;
 N WIDTH,OPTIONS,OFFSET,NODE
 S HDR=""
 S SUBHDR=""
 S NODE=^IBE(357.4,GROUP,0)
 ;don't print invisible headers
 Q:$P(NODE,"^",4)="I"
 S HDR=$P(NODE,"^")
 ;some other special cases
 I (HDR="BLANK")!(HDR="") S HDR="" Q
 ;
 S OPTIONS="",OFFSET=$L(IBLIST("SEP1")),WIDTH=CWIDTH-(2*OFFSET)
 S HDR=$E(HDR,1,WIDTH)
 S OPTIONS=$TR(IBLIST("DGHDR"),"C","")
 S OPTIONS=$TR(OPTIONS,"SR","ss")
 ;
 ;only affects forms with big print - bold otherwise not available
 ;??? do we really want to assume bold not available for small fonts?
 ;I OPTIONS["s",OPTIONS'["B",IBFORM("WIDTH")<100 S OPTIONS=OPTIONS_"B"
 ;I IBFORM("WIDTH")>100 S OPTIONS=$TR(OPTIONS,"B")
 ;
 I HDR=" " S OPTIONS=$TR(OPTIONS,"s","") S:'IBLIST("ULSLCTNS") OPTIONS=$TR(OPTIONS,"U","")
 I IBLIST("DGHDR")["C" S OFFSET=OFFSET+((WIDTH-$L(HDR))\2)
 I OPTIONS["U",$L(HDR)<WIDTH,'IBLIST("ULSLCTNS") D
 .D DRWSTR^IBDFU($$Y,($$X)+OFFSET,"","U",$L(HDR))
 .S OPTIONS=$TR(OPTIONS,"U","")
 ;want to apply options over entire column width?
 ;I IBLIST("ULSLCTNS")!(LINE&(OPTIONS["s")) D
 I IBLIST("ULSLCTNS")!(OPTIONS["s") D
 .D DRWSTR^IBDFU($$Y,($$X)+LINE,$J("",OFFSET-LINE)_HDR,OPTIONS,CWIDTH-(2*LINE))
 .I OPTIONS["U",NEEDUPR D DRWSTR^IBDFU($$Y-1,($$X)+LINE,"","U",CWIDTH-(2*LINE)) S NEEDUPR=0
 E  D DRWSTR^IBDFU($$Y,($$X)+OFFSET,HDR,OPTIONS)
 D DECREASE(.COL)
 Q
 ;
DECREASE(COL) ;
 S COL("ROWSLEFT")=COL("ROWSLEFT")-1
 S COL("NEXTROW")=COL("NEXTROW")+1
 Q
X() ;
 Q COL("X")
Y() ;
 Q COL("NEXTROW")+COL("Y")
 ;
GETDATA(LOCATION) ;gets the dynamic data at print time,@LOCATION=where the list was put
 ;
 N RTN
 S RTN=IBLIST("RTN")
 D RTNDSCR^IBDFU1B(.RTN)
 S LOCATION=RTN("DATA_LOCATION")
 I RTN("ACTION")=3,RTN("DYNAMIC") D
 .I $G(REPRINT),($G(RTN("INPUT_RTN"))]"") D REPRINT^IBDFN11(IBPFID,IBLIST,.LOCATION) Q
 .I '$D(RTNLIST(RTN("RTN"))) Q:'$$DORTN^IBDFU1B(.RTN)
 .S:'IBDEVICE("LISTMAN") RTNLIST(RTN("RTN"))=""
 .K RTNLIST(RTN("RTN"))
 Q
