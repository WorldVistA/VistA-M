MAGXCVR ;WOIFO/SEB,MLH - Image File Conversion Reports ; 05/18/2007 11:23
 ;;3.0;IMAGING;**17,25,31,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; Entry point for the detail report option (MAG IMAGE INDEX DETAIL REPORT)
REPORT N START,END S (START,END)=0
 D BOUNDS^MAGXCVP(.START,.END) I START="^" Q
 W !!,"Are you sure that you want to run this report for ",(END-START+1)," images? Y // " R RUN:DTIME
 I "Yy"'[RUN W !,"OK, report not printed." G DONE
 N ZTSAVE S ZTSAVE("START")=START,ZTSAVE("END")=END
 U IO(0) W !,"This report must be run on a device at least 132 columns wide."
 D EN^XUTMDEVQ("REPORT1^"_$T(+0),"Print Image Index Detail Report",.ZTSAVE)
 G DONE
 ;
REPORT1 N MAGIEN,LINENUM,PAGE,RET,STARTDT,ENDDT
 I IOM<132 W !,"This report must be run on a device at least 132 columns wide. Goodbye!" Q
 S STARTDT=$$HTE^XLFDT($H,1)
 S LINENUM=0,PAGE=0,RET="" D HEADER(1)
 S START=+$G(START),END=+$G(END)
 I END=0 S END=+$P($G(^MAG(2005,0)),U,3)
 S MAGIEN=START-1 I MAGIEN=-1 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2005,MAGIEN)) Q:MAGIEN>END!(+MAGIEN'=MAGIEN)  D REPONE(MAGIEN,1) I RET="^" Q
 S ENDDT=$$HTE^XLFDT($H,1)
 Q
 ;
 ; Print data for one image (IEN=MAGIEN)
REPONE(MAGIEN,TYPE) N MAGTMP,MAGVALS,GRPIEN,UTYPE,INDXDATA,CHILD1
 N GRPFLG ; ------- true (1) if this image is part of a group
 ;
 S GRPIEN=$$GET1^DIQ(2005,MAGIEN_",",14,"I"),GRPFLG=1
 ; NEW:  Skip child images (for MRs, CTs, etc.)
 I GRPIEN]"" Q
 I GRPIEN="" S GRPIEN=MAGIEN,GRPFLG=0
 S LINENUM=LINENUM+1 I LINENUM>(IOSL-2) D HEADER(TYPE) I RET="^" Q
 W !,MAGIEN
 I '$D(^MAG(2005,GRPIEN)) D  Q
 . W ?9,"<<< "_$S(GRPFLG:"PARENT ",1:"")_"IMAGE RECORD DOES NOT EXIST! >>>"
 . Q
 K MAGTMP
 D GETS^DIQ(2005,GRPIEN_",","3;6;8;10;16;100","EI","MAGTMP")
 K MAGVALS M MAGVALS=MAGTMP(2005,GRPIEN_",")
 S CHILD1=$G(^MAG(2005,GRPIEN,1,1,0))
 I CHILD1'="" S MAGVALS(3,"E")=$$GET1^DIQ(2005,CHILD1_",",3,"E")
 S UTYPE="" I $G(MAGVALS(8,"I"))]"" S UTYPE=$$GET1^DIQ(200,MAGVALS(8,"I")_",",29,"E")
 W ?9,$E($G(MAGVALS(6,"E")),1,16),?27,$E($G(MAGVALS(10,"E")),1,27),?56,$E($G(MAGVALS(16,"E")),1,20)
 W ?78,$E($G(MAGVALS(100,"E")),1,23),?103,$E($G(MAGVALS(3,"E")),1,17),?120,$E(UTYPE,1,10)
 S INDXDATA=$G(^XTMP("MAGIXCVGEN",MAGIEN)) I INDXDATA="" Q
 I TYPE=1 D INDICES(INDXDATA,TYPE) ;I RET'="^" W ! S LINENUM=LINENUM+1 I LINENUM>(IOSL-3) D HEADER(TYPE) I RET="^" Q
 Q
 ;
 ; Print index values for the current image
INDICES(INDXDATA,TYPE) N D0,INDXVAL,INDXNUM,TAB,LEN,SPACES
 S SPACES="",$P(SPACES," ",21)=""
 W !
 F D0=1:1:5 D
 . S INDXVAL=$P(INDXDATA,U,D0+1)
 . S INDXNUM=$S(D0=2:2005.82,D0=3:2005.83,D0=4:2005.85,D0=5:2005.84,1:"")
 . I D0>1,INDXVAL]"" S INDXVAL=$$GET1^DIQ(INDXNUM,INDXVAL,.01,"E")
 . S TAB=$P("9^27^36^56^78",U,D0),LEN=$P("20^7^18^20^20",U,D0)
 . I TYPE=1 W ?TAB,$E(INDXVAL,1,LEN),"  "
 . I TYPE=2 W $P("Package^Class^Type^Procedure^Specialty",U,D0),": ",$E(INDXVAL,1,LEN),$E(SPACES,1,LEN-$L(INDXVAL))
 . Q
 S LINENUM=LINENUM+1 I LINENUM>(IOSL-3) D HEADER(TYPE) I RET="^" Q
 Q
 ;
 ; Entry point for the summary report option (MAG IMAGE INDEX SUMMARY REPORT)
SUMMARY N ZTSAVE,DETAIL
ALL R !!,"Display data for all images? N // ",DETAIL:DTIME
 S DETAIL=$$UCASE^MAGXCVP(DETAIL) I DETAIL="^" G DONE
 I DETAIL'="Y" S DETAIL="N"
 S ZTSAVE("DETAIL")=DETAIL
 D EN^XUTMDEVQ("SUMMARY1^"_$T(+0),"Print Image Index Summary Report",.ZTSAVE)
 G DONE
 ;
SUMMARY1 N SUMMARY,SUMDATA,PAGE,LINENUM,RET,MAGIEN
 I IOM'=132 W !,"This report must be run on a 132-column device. Goodbye!" Q
 S SUMMARY="",PAGE=0,LINENUM=0,RET="" D HEADER(2)
 F  S SUMMARY=$O(^XTMP("MAG30P25","SUMMARY",SUMMARY)) Q:SUMMARY=""!(RET="^")  D
 . S SUMDATA=$G(^XTMP("MAG30P25","SUMMARY",SUMMARY))
 . D INDICES(U_SUMMARY,2) I RET="^" Q
 . W ! S LINENUM=LINENUM+1 I LINENUM>(IOSL-3) D HEADER(2) I RET="^" Q
 . I DETAIL="Y" D DETL(SUMMARY) I RET="^" Q
 . I DETAIL="N" D SUMM(SUMDATA) I RET="^" Q
 . W ! F I=1:1:132 W "-"
 . S LINENUM=LINENUM+1 I LINENUM>(IOSL-3) D HEADER(2) I RET="^" Q
 . Q
 I RET="^" Q
 W !!,"Index Commit History:" S LINENUM=LINENUM+1 I LINENUM>(IOSL-3) D HEADER(2) I RET="^" Q
 F I=1:1:+$G(^XTMP("MAG30P25","HISTORY")) Q:I=""  D
 . S SUMDATA=$G(^XTMP("MAG30P25","HISTORY",I))
 . W !?2,I,?8,$P(SUMDATA,U),"-",$P(SUMDATA,U,3)," started on ",$P(SUMDATA,U,2),", finished on ",$P(SUMDATA,U,4)
 . S LINENUM=LINENUM+1 I LINENUM>(IOSL-3) D HEADER(2) I RET="^" Q
 . Q
 Q
 ;
 ; Print the header of the report
HEADER(TYPE) N I,STATUS ; TYPE = 1: Detail, 2: Summary
 S STATUS=$G(^XTMP("MAG30P25","SUMMARY"))
 I PAGE>0,IOT="TRM"!(IOT="VTRM") R !!,"Press <RETURN> to continue, or '^' to exit: ",RET:DTIME I RET="^" Q
 S LINENUM=$P("6^5",U,TYPE),PAGE=PAGE+1
 W:PAGE>0 # W ! F I=1:1:132 W "-"
 W !?53,"Image Index Report ",$S(TYPE=1:"Detail",1:"Summary"),?106,"Page #",PAGE
 I TYPE=1 D
 . W !,"Img ID",?9,"Procedure",?27,"Short Description",?56,"Parent Data File"
 . W ?78,"Document Category",?103,"Obj. Type",?120,"User Type"
 . W !?9,"Package",?27,"Class",?36,"Type",?56,"Procedure/Event",?78,"Specialty"
 . Q
 I TYPE=2 D
 . W !?40,"Compiled: ",$P(STATUS,U,2),"-",$P(STATUS,U,4)
 . W !?(132-11-$L($P(STATUS,U))-$L($P(STATUS,U,3))/2),"Image IDs: ",$P(STATUS,U),"-",$P(STATUS,U,3)
 . Q
 W ! F I=1:1:132 W "-"
 Q
 ;
SUMM(SUMDATA) W !,"Total: ",$P(SUMDATA,U),?15,"First IEN: ",$P(SUMDATA,U,2),?35,"Last IEN: ",$P(SUMDATA,U,3)
 S LINENUM=LINENUM+2 I LINENUM>(IOSL-3) D HEADER(2) I RET="^" Q
 W !,"Img ID",?9,"Procedure",?27,"Short Description",?56,"Parent Data File"
 W ?78,"Document Category",?103,"Obj. Type",?120,"User Type"
 S LINENUM=LINENUM+1 I LINENUM>(IOSL-3) D HEADER(2) I RET="^" Q
 ;D REPONE($P(SUMDATA,U,2),2) I RET="^" Q
 I $P(SUMDATA,U,2)'=$P(SUMDATA,U,3) D  I RET="^" Q
 . ;D REPONE($P(SUMDATA,U,3),2) I RET="^" Q
 . Q
 Q
 ;
DETL(SUMMARY) N MAGIEN
 W !,"Img ID",?9,"Procedure",?27,"Short Description",?56,"Parent Data File"
 W ?78,"Document Category",?103,"Obj. Type",?120,"User Type"
 S LINENUM=LINENUM+2 I LINENUM>(IOSL-3) D HEADER(2) I RET="^" Q
 S MAGIEN="" F  S MAGIEN=$O(^XTMP("MAG30P25","SUMMARY",SUMMARY,MAGIEN)) Q:MAGIEN=""!(RET="^")  D
 . D REPONE(MAGIEN,2) I RET="^" Q
 . Q
 Q
 ;
DONE W !!,"Done!"
 Q
 ;
 ; Entry point for the status report option (MAG IMAGE INDEX STATUS)
STATUS N STDATA,STFLAG,TASKNUM
 S STDATA=$G(^XTMP("MAG30P25","STATUS")),STFLAG=$P(STDATA,U,13),TASKNUM=$P(STDATA,U,14)
 W ! F CT=1:1:80 W "-"
 W !,"Current status: ",$$ST I TASKNUM>0 W " (#",TASKNUM,")"
 W ?60,"Current IEN: ",$P(STDATA,U,((STFLAG>3)+1)*6)
 W !!,"Last generation started on: ",$P(STDATA,U,3),?53,"Starting IEN: ",$P(STDATA,U,2)
 W !?18,"ended on: ",$P(STDATA,U,5),?55,"Ending IEN: ",$P(STDATA,U,4)
 W !!?4,"Last commit started on: ",$P(STDATA,U,9),?53,"Starting IEN: ",$P(STDATA,U,8)
 W !?18,"ended on: ",$P(STDATA,U,11),?55,"Ending IEN: ",$P(STDATA,U,10)
 W ! F CT=1:1:80 W "-"
 Q
 ;
ST() N STDATA,STFLAG,STATUS
 S STDATA=$G(^XTMP("MAG30P25","STATUS"))
 S STFLAG=$P(STDATA,U,13)
 I +STFLAG=0 Q "Image index conversion not started yet"
 S STATUS="Image index "_$S(STFLAG<4:"generation",1:"commit")_" "_$S(STFLAG#3=0:"done",STFLAG#3=1:"in progress",1:"aborted")
 Q STATUS
 ;
