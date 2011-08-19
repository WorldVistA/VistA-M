SCDXUTL1 ;ALB/JRP - GENERAL UTILITY ROUTINES;10-MAY-1996
 ;;5.3;Scheduling;**44,60,132**;AUG 13, 1993
 ;
GETDTRNG(EARLIEST,LATEST,HELPBGN,HELPEND) ;Prompt user for a date range
 ;
 ;Input  : EARLIEST - Earliest date allowed in FileMan format (Optional)
 ;         LATEST - Latest date allowed in FileMan format (Optional)
 ;         HELPBGN - Array containing help information for beginning
 ;                   date (Full global reference) (Optional)
 ;         HELPEND - Array containing help information for ending
 ;                   date (Full global reference) (Optional)
 ;Output : Begin^End - Success
 ;           Begin - Beginning date
 ;           End - Ending date
 ;         -1 - User abort / timed out
 ;Notes  : HELPBGN & HELPEND arrays have same format as DIR("?",#) array
 ;
 ;Check input
 S EARLIEST=$G(EARLIEST)
 S LATEST=$G(LATEST)
 S HELPBGN=$G(HELPBGN)
 S HELPEND=$G(HELPEND)
 ;Declare variables
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,BEGIN,END
 ;Get beginning date
 S DIR(0)="DA^"_EARLIEST_":"_LATEST_":EPX"
 S DIR("A")="Enter beginning date: "
 I (HELPBGN'="") M DIR("?")=@HELPBGN
 D ^DIR
 S BEGIN=+Y
 ;User abort / time out
 Q:($D(DIRUT)) -1
 ;Get ending date
 K DIR
 S DIR(0)="DA^"_BEGIN_":"_LATEST_":EPX"
 S DIR("A")="Enter ending date: "
 I (HELPEND'="") M DIR("?")=@HELPEND
 D ^DIR
 S END=+Y
 ;User abort / time out
 Q:($D(DIRUT)) -1
 ;Done
 Q BEGIN_"^"_END
 ;
REPEAT(CHAR,TIMES) ;Repeat a string
 ;INPUT  : CHAR - Character to repeat
 ;         TIMES - Number of times to repeat CHAR
 ;OUTPUT : s - String of CHAR that is TIMES long
 ;         "" - Error (bad input)
 ;
 ;Check input
 Q:($G(CHAR)="") ""
 Q:((+$G(TIMES))=0) ""
 ;Return string
 Q $TR($J("",TIMES)," ",CHAR)
 ;
INSERT(INSTR,OUTSTR,COLUMN,LENGTH) ;Insert a string into another string
 ;INPUT  : INSTR - String to insert
 ;         OUTSTR - String to insert into
 ;         COLUMN - Where to begin insertion (defaults to end of OUTSTR)
 ;         LENGTH - Number of characters to clear from OUTSTR
 ;                  (defaults to length of INSTR)
 ;OUTPUT : s - INSTR will be placed into OUTSTR starting at COLUMN
 ;             using LENGTH characters
 ;         "" - Error (bad input)
 ;
 ;NOTE : This module is based on $$SETSTR^VALM1
 ;
 ;Check input
 S INSTR=$G(INSTR)
 Q:(INSTR="") $G(OUTSTR)
 S OUTSTR=$G(OUTSTR)
 S:('$D(COLUMN)) COLUMN=$L(OUTSTR)+1
 S:('$D(LENGTH)) LENGTH=$L(INSTR)
 ;Declare variables
 N FRONT,END
 S FRONT=$E((OUTSTR_$J("",COLUMN-1)),1,(COLUMN-1))
 S END=$E(OUTSTR,(COLUMN+LENGTH),$L(OUTSTR))
 ;Insert string
 Q FRONT_$E((INSTR_$J("",LENGTH)),1,LENGTH)_END
 ;
DIAG(SDPOE,SCDXARRY) ;Get diagnoses from V POV file
 ;  Note: Returns Dx from children (if any)
 ;
 ;  SDPOE - pointer to 409.68
 ;  SCDGARRY - output array
 ;
 N SCOPDX,SDCHILD,SDOE
 D KIDS(SDPOE,"SDCHILD")
 ;
 ; -- get parent dxs
 D GETDX^SDOE(+$G(SDPOE),SCDXARRY)
 ;
 ; -- get child dxs
 S SDOE=0
 F  S SDOE=$O(SDCHILD(SDOE)) Q:'SDOE  D
 . D GETDX^SDOE(SDOE,SCDXARRY)
 Q
 ;
PRIMPDX(SDPOE) ; return pointer to ICD9 for primary dx of parent encounter
 ; Note: Includes
 ;    SDPOE - encounter (parent)
 ; return: 
 ;    if one:  ptr to ICD DIAGNOSIS file (ICD9)^pointer to V POV file
 ;    if none: no prim dx
 ;    if two+: -1 (error)
 ;
 N SCDX,SCX,SCDX1,SDCHILD,SDOE
 S SCDX1=0
 D DIAG(.SDPOE,"SCDX")
 S SCX=0
 F  S SCX=$O(SCDX(SCX)) Q:'SCX  IF $P(SCDX(SCX),U,12)="P" S:SCDX1 SCDX1=-1 Q:SCDX1  S SCDX1=(+SCDX(SCX))_U_SCX
 Q SCDX1
 ;
KIDS(SDOE,SCKIDS) ;return children of parent
 ;  Input -  SDOE = ptr to 409.68
 ;  Output-  @SCKIDS@(kid ptr to 409.68) array
 N SCX
 S SCX=0 F  S SCX=$O(^SCE("APAR",SDOE,SCX)) Q:'SCX  S @SCKIDS@(SCX)=""
 Q
