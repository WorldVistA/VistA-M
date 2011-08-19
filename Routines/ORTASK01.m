ORTASK01 ; SLC/RJS - Look for orders to purge; [1/2/01 11:44am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**98**;Dec 17, 1997
 ;
 ; QUIT added below by PKS (SLC) on 11/27/2000 to prevent potential 
 ;    for any sites using unfinished ORTASK PURGE as scheduled option:
 ;
 Q
 ;
S ;
 N ORCNT,ORT0,ORT3,ORTERR,ORTGRC,ORTNOW,ORTORD,ORTPDT,ORTRUN,X,%DT
 ;
 I '$G(ZTSK) D HELP S ORTRUN=$$READ("Y","Want to run the purge now ","NO") Q:(ORTRUN[U)  Q:('ORTRUN)
 ;
 S ORTORD=$$GET^XPAR("ALL","ORPF LAST ORDER PURGED") S:(ORTORD<1) ORTORD=0
 S ORTGRC=$$GET^XPAR("ALL","ORPF GRACE DAYS BEFORE PURGE") S:(ORTGRC<1) ORTGRC=90
 S %DT="",X="T-"_ORTGRC D ^%DT S ORTPDT=+Y
 S %DT="",X="T" D ^%DT S ORTNOW=+Y
 ;
 S ORTERR=0 D  F ORCNT=0:1 S ORTORD=$O(^OR(100,ORTORD)) Q:'ORTORD  D  Q:ORTERR
 .Q:'ORTORD  Q:ORTERR
 .;
 .D EN^XPAR("SYS","ORPF LAST ORDER PURGED",1,"`"_ORTORD,.ORTERR) Q:ORTERR
 .;
 .S ORT0=$G(^OR(100,ORTORD,0))
 .S ORT3=$G(^OR(100,ORTORD,3))
 .;
 .Q:(ORTPDT<ORT3)                                       ; DATE OF LAST ACTIVITY IS AFTER PURGE DATE
 .;
 .Q:(ORTNOW<$P(ORT0,U,8))                               ; ORDER START DATE IS IN THE FUTURE
 .;
 .Q:'("^0^1^2^7^12^13^14^"[("^"_(+$P(ORT3,U,3))_"^"))   ; LAST ACTIVITY STATUS IS NOT TERMINAL
 .;
 .Q:$P(ORT3,U,9)                                        ; CHILD ORDER
 .;
 .D PURGE^ORMEVNT(ORTORD)
 .;
 ;
 D EN^XPAR("SYS","ORPF LAST ORDER PURGED",1,"",.ORTERR) Q:ORTERR
 D PUT^XPAR("SYS","ORPF LAST PURGE DATE",1,DT,.ORTERR) Q:ORTERR
 ;
 D:$G(ZTSK) KILL^%ZTLOAD
 ;
 Q
 ;
HELP ;
 N LINE,TEXT
 W !!
 F LINE=1:1:999 S TEXT=$P($T(HELPTEXT+LINE),";",2,999) Q:TEXT  W !,$P(TEXT,";",2,999)
 W !!
 Q
 ;
HELPTEXT ;;
 ;; Option: ORTASK PURGE  (Old Orders Batch Purge)
 ;;
 ;;   This is a purge of all orders that have a 'Last Activity Date' of more
 ;;  than the number of 'Grace days' ago. It also checks to make sure the
 ;;  orders that are purged are 'Child' orders, have an order start date in
 ;;  the past, and have a 'Terminal' status.
 ;;
 ;;   As this option scans the entire Orders file, it should be sheduled to
 ;;  run after hours.
 ;1;
 ;
READ(OCXZ0,OCXZA,OCXZB,OCXZL) ;
 N OCXLINE,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(OCXZ0)) U
 S DIR(0)=OCXZ0
 S:$L($G(OCXZA)) DIR("A")=OCXZA
 S:$L($G(OCXZB)) DIR("B")=OCXZB
 F OCXLINE=1:1:($G(OCXZL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
