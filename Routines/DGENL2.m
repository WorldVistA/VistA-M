DGENL2 ;ALB/RMO - Patient Enrollment - Build List Area Cont.;16 JUN 1997 ; 7/8/05 1:37pm
 ;;5.3;Registration;**121,147,232,306,417,672**;Aug 13,1993
 ;
HIS(DGARY,DFN,DGENRIEN,DGLINE,DGCNT) ;Enrollment history 
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ;           DGENRIEN Enrollment IEN
 ;           DGLINE   Line number
 ; Output -- DGCNT    Number of lines in the list
 N DGENR,DGNUM,DGPRIEN,DGSTART
 ;
 S DGSTART=DGLINE ;starting line number
 S DGNUM=0 ;selection number
 D SET(DGARY,DGLINE,"Enrollment History",31,IORVON,IORVOFF,,,,.DGCNT)
 ;
 ;Enrollment date, status, priority, date/time entered
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE," Effective Date     Status              Priority    Date/Time Entered",5,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"===============================================================================",1,,,,,,.DGCNT)
 S DGPRIEN=DGENRIEN
 F  S DGPRIEN=$$FINDPRI^DGENA(DGPRIEN) Q:'DGPRIEN  D
 . I $$GET^DGENA(DGPRIEN,.DGENR) D
 . . S DGNUM=DGNUM+1
 . . S DGLINE=DGLINE+1
 . . D SET(DGARY,DGLINE,DGNUM,1,,,"EH",DGNUM,DGPRIEN,.DGCNT)
 . . D SET(DGARY,DGLINE,$S($G(DGENR("EFFDATE")):$$EXT^DGENU("EFFDATE",DGENR("EFFDATE")),1:""),5,,,,,,.DGCNT)
 . . D SET(DGARY,DGLINE,$S($G(DGENR("STATUS")):$E($$EXT^DGENU("STATUS",DGENR("STATUS")),1,19),1:""),25,,,,,,.DGCNT)
 . . D SET(DGARY,DGLINE,$S($G(DGENR("PRIORITY")):DGENR("PRIORITY")_$$EXTERNAL^DILFD(27.11,.12,"F",$G(DGENR("SUBGRP"))),1:""),45,,,,,,.DGCNT)
 . . D SET(DGARY,DGLINE,$S($G(DGENR("DATETIME")):$$EXT^DGENU("DATETIME",DGENR("DATETIME")),1:""),57,,,,,,.DGCNT)
 Q
 ;this SET subroutine is being moved to DGENL2 from DGENL1, which has 
 ;gotten too big.  patch DG*5.3*653
SET(DGARY,DGLINE,DGTEXT,DGCOL,DGON,DGOFF,DGSUB,DGNUM,DGDATA,DGCNT) ; -- set display array
 ; Input  -- DGARY    Global array subscript
 ;           DGLINE   Line number
 ;           DGTEXT   Text
 ;           DGCOL    Column to start at              (optional)
 ;           DGON     Highlighting on                 (optional)
 ;           DGOFF    Highlighting off                (optional)
 ;           DGSUB    Secondary list subscript        (optional)
 ;           DGNUM    Selection number                (optional)
 ;           DGDATA   Data associated with selection  (optional)
 ; Output -- DGCNT    Number of lines in the list
 N X
 S:DGLINE>DGCNT DGCNT=DGLINE
 S X=$S($D(^TMP(DGARY,$J,DGLINE,0)):^(0),1:"")
 S ^TMP(DGARY,$J,DGLINE,0)=$$SETSTR^VALM1(DGTEXT,X,DGCOL,$L(DGTEXT))
 D:$G(DGON)]""!($G(DGOFF)]"") CNTRL^VALM10(DGLINE,DGCOL,$L(DGTEXT),$G(DGON),$G(DGOFF))
 ;Set-up special index for secondary selection list
 S:$G(DGSUB)]"" ^TMP(DGARY_"IDX",$J,DGSUB,DGNUM,DGLINE)=DGDATA,^TMP(DGARY_"IDX",$J,DGSUB,0)=DGNUM
 Q
PHEART(DFN,DGENRIEN,PHENRDT) ;find Purple Heart information based on enrollment date
 N NXTENR,NXTENDT,PRVENR,PRVENDT,PHARY,PHI,PHST,PHRR,PHDIERR
 N NXTDIF,NXTENTM,NXTPHDT,NXTPHTM,PHENTM,PHREC,PRVDIF,PRVPHDT
 S U="^",(PRVDIF,NXTDIF)=""
 Q:'(PHENRDT&DGENRIEN) ""
 S PRVENDT=0,NXTENDT=9999999
 S PRVENR=$O(^DGEN(27.11,"C",DFN,DGENRIEN),-1)
 S:PRVENR PRVENDT=$P($G(^DGEN(27.11,PRVENR,"U")),U)
 S PRVPHDT=$O(^DPT(DFN,"PH","B",PHENRDT),-1)
 S NXTENR=$O(^DGEN(27.11,"C",DFN,DGENRIEN))
 S:NXTENR NXTENDT=$P($G(^DGEN(27.11,NXTENR,"U")),U)
 S NXTPHDT=$O(^DPT(DFN,"PH","B",PHENRDT-.0000001))
 I NXTPHDT<NXTENDT,$P(PHENRDT,".")=$P(NXTPHDT,".")  D
 .I $P(NXTENDT,".")=$P(NXTPHDT,".")  D
 ..S NXTPHTM=$P(NXTPHDT,".",2),NXTENTM=$P(NXTENDT,".",2),PHENTM=$P(PHENRDT,".",2)
 ..S NXTDIF=NXTENTM-NXTPHTM,PRVDIF=NXTPHTM-PHENTM
 ..S:PRVDIF<NXTDIF PHREC=$O(^DPT(DFN,"PH","B",NXTPHDT,""))
 .E  S PHREC=$O(^DPT(DFN,"PH","B",NXTPHDT,""))
 Q:'$D(PHREC)&('PRVPHDT) ""
 S:'$D(PHREC) PHREC=$O(^DPT(DFN,"PH","B",PRVPHDT,""))
 Q:'$D(PHREC) ""
 S PHARY=$G(^DPT(DFN,"PH",PHREC,0))
 S PHI=$$EXTERNAL^DILFD(2,.531,,$P(PHARY,U,2),.PHDIERR)
 S PHST=$$EXTERNAL^DILFD(2,.532,,$P(PHARY,U,3),.PHDIERR)
 S PHRR=$$EXTERNAL^DILFD(2,.533,,$P(PHARY,U,4),.PHDIERR)
 Q PHI_"^"_PHST_"^"_PHRR
