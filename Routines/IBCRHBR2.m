IBCRHBR2 ;ALB/ARH - RATES: UPLOAD HOST FILES (RC) READ ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,138**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;LOAD -> A -> SET...
 ;
 ;for each file -> open/close and read a line -> parse the line -> save the data to XTMP
 ;
 ;
LOAD(IBPATH,IBFILE,IBNAME,PARSE,VERS) ; open and read a host file, returns true if file loaded ok
 N IBOK,IBI,IBFLINE,IBSYS,X,Y S IBOK=1,IBSYS=0,VERS=$G(VERS)
 ;
 S X=$G(^%ZOSF("OS")) I X["OpenM" S IBSYS=1,X="ERROR^IBCRHBR2",@^%ZOSF("TRAP") ; reset error trap for OpenM
 ;
 ;W !,IBNAME,?45,IBFILE ;I PARSE="OC" Q 0 ;  *****  AND IBI ;Q 1
 ;
 D OPEN^%ZISH(IBFILE,IBPATH,IBFILE,"R") I POP W !!,?20,"**** Unable to open ",IBPATH,IBFILE,! S IBOK=0 G LOADQ
 ;
 U IO(0) W !,IBNAME,?45,IBFILE
 ;
 S IBI=0 F  S IBI=IBI+1 U IO R IBFLINE:5 Q:$$ENDF  D @(PARSE_"^IBCRHBR3") I '(IBI#100) U IO(0) W "." ;Q:IBI>100
 ;
CLOSE D CLOSE^%ZISH(IBFILE) ;W "  Done, ",(IBI-1)," lines processed."
 ;
LOADQ I IBSYS=1 S X="",@^%ZOSF("TRAP")  ; reset error trap for OpenM
 Q $G(IBOK)
 ;
ENDF() N IBX S IBX=1 I $T S IBX=0
 I $$STATUS^%ZISH S IBX=1
 Q IBX
 ;
ERROR ; process EOF and errors for OpenM
 N IBERROR S IBERROR=$$EC^%ZOSV
 I IBERROR["ENDOFFILE" S IBOK=1 G CLOSE
 U IO(0) W !!,"Error reading file: ",IBERROR,!!
 D ^%ZTER
 S IBOK=0
 G CLOSE
 Q
