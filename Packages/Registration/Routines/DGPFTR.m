DGPFTR ;SHRPE/YMG - PRF TRANSFER REQUESTS SCREEN ; 05/08/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This is the main screen for DGPF PRF TRANSFER REQUESTS option.
 ;
 Q
EN ; entry point
 N DSPSTR ; string of filters for display list
 ;
 S DSPSTR="ALL^ALL^ALL^2^ALL" ; default to display all pending requests
 ; load list template 
 D EN^VALM("DGPF PRF TRANSFER REQUESTS")
 Q
 ;
HDR ;Header Code
 D BLDHDR(DSPSTR)
 Q
 ;
INIT ;Init variables and list array
 S VALMBG=1
 ; display list of pending requests by default
 D BLD(DSPSTR)
 Q
 ;
HELP ;Help Code
 D FULL^VALM1
 W @IOF
 W !,"This screen lists PRF transfer requests. It also allows users to review"
 W !,"and subsequently approve / reject a pending transfer request."
 W !
 S VALMBCK="R"
 Q
 ;
EXIT ; exit point
 ;
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
BLD(STR) ; build list of transfer requests for display
 ; STR - string of parameters that limit which entries to include:
 ;   query id ^ patient ^ PRF flag ^ request status ^ start date/time ^ end date/time
 ;   Note: any piece may be set to "ALL" instead of an actual value
 ;
 N EDTM,FLAG,PAT,REQIEN,SDTM,STATUS
 N DIDX,DIDX1,DIDX2,FIDX,FIDX1,FIDX2,PIDX,PIDX1,PIDX2,SIDX,SIDX1,SIDX2
 D CLEAN^VALM10 S VALMCNT=0
 W !!,"Working..."
 I $P(STR,U)'="ALL" D  Q
 .; looking for a specific query id - there's only one entry possible
 .S REQIEN=$$FNDLOG^DGPFHLT3($P(STR,U))
 .I 'REQIEN S VALMCNT=$$NOREC() Q
 .S VALMCNT=$$BLDLN(VALMCNT,REQIEN)
 .Q
 S PAT=$P(STR,U,2),FLAG=$P(STR,U,3),STATUS=$P(STR,U,4),SDTM=$P(STR,U,5),EDTM=$P(STR,U,6)
 ; loop through patient level
 S PIDX1=$S(PAT="ALL":"",1:$O(^DGPF(26.22,"D",PAT),-1))
 S PIDX2=$S(PAT="ALL":"",1:$O(^DGPF(26.22,"D",PAT)))
 S PIDX=PIDX1 F  S PIDX=$O(^DGPF(26.22,"D",PIDX)) Q:PIDX=PIDX2  D
 .; loop through flag level
 .S FIDX1=$S(FLAG="ALL":"",1:$O(^DGPF(26.22,"D",PIDX,FLAG),-1))
 .S FIDX2=$S(FLAG="ALL":"",1:$O(^DGPF(26.22,"D",PIDX,FLAG)))
 .S FIDX=FIDX1 F  S FIDX=$O(^DGPF(26.22,"D",PIDX,FIDX)) Q:FIDX=FIDX2  D
 ..; loop through status level
 ..S SIDX1=$S(STATUS="ALL":"",1:$O(^DGPF(26.22,"D",PIDX,FIDX,STATUS),-1))
 ..S SIDX2=$S(STATUS="ALL":"",1:$O(^DGPF(26.22,"D",PIDX,FIDX,STATUS)))
 ..S SIDX=SIDX1 F  S SIDX=$O(^DGPF(26.22,"D",PIDX,FIDX,SIDX)) Q:SIDX=SIDX2  D
 ...; loop through request date/time level
 ...S DIDX1=$S(SDTM="ALL":"",1:$O(^DGPF(26.22,"D",PIDX,FIDX,SIDX,SDTM),-1))
 ...S DIDX2=$S(SDTM="ALL":"",EDTM="ALL":"",1:$O(^DGPF(26.22,"D",PIDX,FIDX,SIDX,EDTM)))
 ...S DIDX=DIDX1 F  S DIDX=$O(^DGPF(26.22,"D",PIDX,FIDX,SIDX,DIDX)) Q:DIDX=DIDX2  D
 ....S REQIEN=$O(^DGPF(26.22,"D",PIDX,FIDX,SIDX,DIDX,""))
 ....I REQIEN S VALMCNT=$$BLDLN(VALMCNT,REQIEN)
 ....I '(VALMCNT#10) W "."
 ....Q
 ...Q
 ..Q
 .Q
 I VALMCNT=0 S VALMCNT=$$NOREC()
 Q
 ;
NOREC() ; show message when display list is empty
 ; returns line count in the created array
 ;
 D SET^VALM10(1,"")
 D SET^VALM10(2,"")
 D SET^VALM10(3,$$SETSTR^VALM1("No transfer request(s) found.","",26,29))
 Q 3
 ;
BLDLN(LNUM,REQIEN) ; build one line to display
 ; LNUM - last line number
 ; REQIEN - request ien in file 26.22
 ;
 ; returns current line number
 ;
 N DGFDA,FLAG,IENS,LINE,LN,PAT,REQDTM,STATUS
 ; get data from 26.22
 S IENS=REQIEN_"," D GETS^DIQ(26.22,IENS,".01;.03:.05","EI","DGFDA")
 S PAT=$G(DGFDA(26.22,IENS,.03,"E"))
 S FLAG=$G(DGFDA(26.22,IENS,.04,"E"))
 S STATUS=$G(DGFDA(26.22,IENS,.05,"E"))
 S REQDTM=$$FMTE^XLFDT($G(DGFDA(26.22,IENS,.01,"I")),"2DZ")
 ; build line
 S LINE="",LN=LNUM+1
 S LINE=$$SETSTR^VALM1(LN,LINE,1,3)
 S LINE=$$SETFLD^VALM1(PAT,LINE,"PATIENT")
 S LINE=$$SETFLD^VALM1(FLAG,LINE,"FLAG")
 S LINE=$$SETFLD^VALM1(STATUS,LINE,"STATUS")
 S LINE=$$SETFLD^VALM1(REQDTM,LINE,"DATE")
 D SET^VALM10(LN,LINE,LN)
 S @VALMAR@("IDX",LN,LN)=$G(REQIEN)
 Q LN
 ;
BLDHDR(STR) ; build display header
 ; STR - string of parameters for the current view (see tag BLD)
 ;
 N EDTM,FLAG,PAT,QID,SDTM,STATUS
 S QID=$P(STR,U),PAT=$P(STR,U,2),FLAG=$P(STR,U,3),STATUS=$P(STR,U,4),SDTM=$P(STR,U,5),EDTM=$P(STR,U,6)
 S VALMHDR(1)="Current view:"
 S VALMHDR(2)="Query Id: "_$$LJ^XLFSTR(QID,4) I QID'="ALL" Q
 S VALMHDR(2)=VALMHDR(2)_"Req. Status: "_$$LJ^XLFSTR($S(STATUS="ALL":STATUS,1:$$EXTERNAL^DILFD(26.22,.05,,STATUS)),8)
 S VALMHDR(2)=VALMHDR(2)_" Dates: "_$$FMTE^XLFDT(SDTM,"2Z")_$S(SDTM="ALL":"",+$P(SDTM,".",2)'>0:"@00:00:00",1:"")
 I EDTM'="" S VALMHDR(2)=VALMHDR(2)_" - "_$$FMTE^XLFDT(EDTM,"2Z")_$S(+$P(EDTM,".",2)'>0:"@00:00:00",1:"")
 S VALMHDR(3)="Patient: "_$$LJ^XLFSTR($S(PAT="ALL":PAT,1:$$EXTERNAL^DILFD(26.22,.03,,$P(STR,U,2))),39)
 S VALMHDR(3)=VALMHDR(3)_"Flag: "_$$LJ^XLFSTR($S(FLAG="ALL":FLAG,1:$$EXTERNAL^DILFD(26.22,.04,,$P(STR,U,3))),39)
 S VALMHDR(4)=""
 Q
