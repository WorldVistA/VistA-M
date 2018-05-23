RAUTODC ;HISC/GJC discontinue expired rad orders ;30 Jan 2018 9:01 AM
 ;;5.0;Radiology/Nuclear Medicine;**135**;Mar 16, 1998;Build 7
 ;
 ; *** WORKING: INTERNAL ONLY ***
 ;
EN1 ;entry point for initial mass discontinue action
 ;check for all imaging types no bulletins/alerts
 ;EN^RABUL is the bulletin routine.
 ;
 ;Routine              IA          Type
 ;-------------------------------------
 ; $$EC^%ZOSV          10097        (S)
 ; ^%ZTER               1621        (S)
 ; $$S^%ZTLOAD         10063        (S)
 ; $$*^XLFDT           10103        (S)
 ; ^XMD                10070        (S) 
 ; EN^XPAR              2263        (S)
 ; ENVAL^XPAR           2263        (S)
 ; $$KSP^XUPARAM        2541        (S)
 ; OUT^XPDMENU(p1,p2)   1157        (S)
 ; ENALL^DIK           10013        (S)
 ;
 ;
 ; *************************************************************
 ; *** now that we've disabled all the notifications we need ***
 ; *** to restore them if we run into an error. so we set    ***
 ; *** the error trap code                                   ***
 S X="ERROR^RAUTODC",@^%ZOSF("TRAP")
 ; *************************************************************
 ;
 ;OE/RR NOTIFICATIONS IEN/NAME: 26/IMAGING REQUEST CANCEL/HELD
 ;
 ;                  *** variable list ***
 ;RA135TIME: flag that mass DC is running (see RABUL)
 ;RAIEN    : IEN of 'IMAGING REQUEST CANCEL/HELD' notification
 ;RADD21   : DATE DESIRED (Not guaranteed) value from "BDD" xref
 ;RADUZ    : the user performing these action on file 75.1 (POSTMASTER)
 ;RAEDTM   : end date for mass DC process (no bulletins; no notifications)
 ;RAENT    : entity USR-DUZ, DIV-DUZ(2), SYS-domain, PKG-package
 ;RAIEN    : IEN of IMAGING REQUEST CANCEL/HELD notification (26)
 ;RANOTE   : array of the 'IMAGING REQUEST CANCEL/HELD' notification setting
 ;RAOIFN   : IEN of the record in RAD/NUC MED ORDERS file 75.1
 ;RAOREQST : the REQUEST STATUS of each order record hit in file 75.1
 ;RAOSTS   : internal FM variable for DISCONTINUED (1) req'd for ^RAORDU
 ;RAQUIT   : indicates if the mass dc has been stopped or ran past time
 ;RAREQSTS : hold (3)/pending (5)/scheduled (8) - the REQUEST STATUS static string
 ;           used to compare against each record's REQUEST STATUS value against
 ;RASAV    : carbon copy of RANOTE, the original notification values (enabled/disabled)
 ;         : used to reset notifications to their original settings when the process
 ;           has finished, has errored or has stopped.
 ;
 ;w/o the reason we cannot go forward.
 S RAOREA(1)=$$GETREA()
 I RAOREA(1)'>0 D  K RAOREA Q
 .N RAX S RAX(1)="'OBSOLETE ORDER-P135 (automated)' not found in file 75.2"
 .D EMAIL(.RAX)
 .Q
 ;
 ; check notifications against: OR PARAM COORDINATOR MENU
 ;
 N RAERR
 ;
 ;prevents bulletins from firing (RABUL in DD 75.1, fld: 5)
 S RA135TIME=1
 ;
 S RAQUIT=0,RAREQSTS="^3^5^8^"
 ;
 ;--- get notifications ---
 K RANOTE S RAPAR="ORB PROCESSING FLAG"
 S RAINT="IMAGING REQUEST CANCEL/HELD"
 D GETNOTE(.RANOTE,RAPAR,RAINT)
 ;
 ;RAERR is returned: RAERR=0 if no error, else error
 I RAERR'=0 D  Q
 .N RAX S RAX(1)="GETNOTE^RAUTODC failed."
 .D EMAIL(.RAX)
 .Q
 ;--- end get notifications ---
 ;
 ;save off the original definition of the notification values in RASAV
 K RASAV M RASAV=RANOTE
 ;
 ;must save off the original IMAGING REQUEST CANCEL/HELD notification definitions
 ;in XTMP to ensure resetting them to their correct values in case of error.
 S RADESC="RA5_0P135: save off the original value of the IMAGING REQUEST CANCEL/HELD notification per parameter"
 K ^XTMP("RA5_0P135",0) S ^XTMP("RA5_0P135",0)=$$FMADD^XLFDT($$DT^XLFDT(),30,0,0,0)_"^"_$$DT^XLFDT()_"^"_RADESC
 K RADESC M ^XTMP("RA5_0P135")=RANOTE
 ;
 ; RASAV save the original values of at each notification value @ each
 ; level: user, team, service, location, division, system & package. 
 ; disable notifications if set to enabled. Use RANOTE as the reference.
 ; Place options 'Cancel a Request' & 'Hold a Request' out of order 
 D DISABLE,OOO(1)
 ;
 K RAERR
 ;
 N RADD21,RADUZ S RADD21=0
 S RADUZ=.5 ;POSTMASTER
 ;
 ;turn off notifications and bulletins for all events up to May 31st 2015@23:59
 S RAEDTM=3150531.2359
 ;
 ; set to 'Discontinue' request status internal value
 ; used when calling ^RAORDU (fixed value)
 S RAOSTS=1
 ;
 ;track statistics: how many records, how long did it take?
 S RAQST=$$NOW^XLFDT() ;start time w/seconds
 S RAQDC=0 ;count the # of orders DC'd.
 ;
 ;"BDD" cross reference on the added w/RA*5.0*135
 F  S RADD21=$O(^RAO(75.1,"BDD",RADD21)) Q:RADD21=""!(RADD21>RAEDTM)  D  Q:RAQUIT
 .;
 .S RAOIFN=0 F  S RAOIFN=$O(^RAO(75.1,"BDD",RADD21,RAOIFN)) Q:RAOIFN=""  D  Q:RAQUIT
 ..S RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0)) Q:RAOIFN(0)=""
 ..;
 ..;only hold (3)/pending (5)/scheduled (8) orders are DC'd
 ..;RAREQSTS="^3^5^8^"
 ..S RAOREQST=$P(RAOIFN(0),U,5)
 ..Q:RAREQSTS'[(U_RAOREQST_U)
 ..;
 ..;
 ..; Request Status='Scheduled' check the 'SCHEDULED DATE/TIME'
 ..; 'DATE DESIRED (not Guaranteed)' fields
 ..; if 'SCHEDULED DATE/TIME' > 05/31/2015@2359 -OR-
 ..; 'DATE DESIRED (not Guaranteed)' > 06/01/2015
 ..; quit
 ..I RAOREQST=8,(($$8()>RAEDTM)) Q
 ..;
 ..;
 ..; RAOIFN & RAOREA(n) are defined above. RAOSTS
 ..; is set above (to a value of one) outside the
 ..; RADD21 FOR loop above RAOIFN, RAOREA(n) & RADD21
 ..; are required when calling ^RAORDU
 ..D ^RAORDU
 ..S RAQDC=RAQDC+1 ;increment the DC'd order total
 ..Q
 .;
 .I $$S^%ZTLOAD() S (ZTSTOP,RAQUIT)=1 D  Q
 ..;re-enable the notifications, place options back in order
 ..D ENABLE,OOO(0)
 ..S RATXT(1)="RA*5.0*135 mass DC process stopped: "_$$NOW^XLFDT()
 ..D EMAIL(.RATXT) K RATXT
 ..Q
 .Q
 ;
 ;only remove the task from the task log if not stopped (ZTSTOP=0)
 S:$D(ZTQUEUED)&($G(ZTSTOP,0)=0) ZTREQ="@"
 ;
 ; the process completed successfully: no error; not stopped
 ; re-enable the notifications, place options back in order 
 D:RAQUIT=0 ENABLE,OOO(0)
 ;
 D STATS ;track DC'd statistics, email results to proper audience
 ;
KILL ; Kill variables
 K RA135TIME,RADD21,RADUZ,RAEDTM,RAENT,RAIEN,RANOTE,RAOIFN
 K RAOREA,RAOREQST,RAQDC,RAQFIN,RAQST,RAQUIT,RAREQSTS,RASAV
 Q
 ;
 ;                 *** utilities ***
 ;
GETREA() ;get the generic discontinue reason IEN
 ;the record has a .01 of 'OBSOLETE ORDER-P135 (automated)'
 ;the "B" xref stores 'OBSOLETE ORDER-P135 (automated' thirty chars
 Q $O(^RA(75.2,"B","OBSOLETE ORDER-P135 (automated",0))
 ;
DISABLE ;disable the notifications that were enabled
 S RAENT="" F  S RAENT=$O(RANOTE(RAENT)) Q:RAENT=""  D
 .S RAIEN=$O(RANOTE(RAENT,0)) Q:RAIEN=0
 .;RAIEN=IEN of the value 'IMAGING REQUEST CANCEL/HELD' `26
 .D:$G(RANOTE(RAENT,RAIEN))'="D" NOTEVT(RAENT,1) ;disable
 .;note: if not 'D'isabled then the notification
 .;      is either 'E'nabled or 'M'andatory
 .Q
 Q
 ;
ENABLE ;enable the notifications that were disabled
 N RAIEN,RAENT
 S RAENT="" F  S RAENT=$O(RASAV(RAENT)) Q:RAENT=""  D
 .S RAIEN=$O(RANOTE(RAENT,0)) Q:RAIEN=0
 .;RAIEN should be the IEN of the value "IMAGING REQUEST CANCEL/HELD" `26
 .;RASAV is the array of notifications defnitions before our total disable action
 .D:$G(RASAV(RAENT,RAIEN))'="D" NOTEVT(RAENT,0) ;enable
 .;note: if not 'E'nabled or 'M'andatory then the
 .;      notification was 'D'isabled.
 .Q
 Q
 ;
8() ;get SCHEDULED DATE (TIME optional) fld: #23
 Q $P(RAOIFN(0),U,23)
 ;
GETNOTE(ARY,PAR,INST) ; gets both enabled & disabled
 D ENVAL^XPAR(.ARY,PAR,INST,.RAERR)
 ;RAERR is returned: RAERR=0 if no error, else error
 I RAERR'=0 D
 .N RATXT S RATXT(1)="RAERR = "_$G(RAERR),RATXT(2)="INST = "_INST
 .S RATXT(3)="RANOTE = "_$G(RANOTE),RATXT(4)="PAR = "_PAR
 .S RATXT(5)="Error @ GETNOTE^RAUTODC"
 .D EMAIL(.RATXT)
 Q
 ;
NOTEVT(RAENT,Y) ;
 ;RAENT = array value of notification (#100.9) values
 ; for "IMAGING REQUEST CANCEL/HELD"
 ;Y = 1 disable, 0 enable
 ;
 ;RAIEN is global in scope RAIEN should be 26
 N RAPAR,RAY S RAPAR="48"
 I Y=1 S RAY="D"
 E  S RAY=$G(RASAV(RAENT,RAIEN))
 S RAY(0)=$S(RAY="D":"Disabled",RAY="E":"Enabled",1:"Mandatory")
 D EN^XPAR(RAENT,RAPAR,RAIEN,.RAY,.ERR)
 ;
 Q
 ;
OOO(Y) ;place options 'Cancel a Request' & 'Hold a Request' in/out of order
 ;input: Y = 1 to set options out of order (OOO)
 ;       Y = 0 to set options back in order
 S RAX=$S(Y=1:"<<< RA*5.0*135 >>>",1:"@")
 F RAI="RA ORDERCANCEL","RA ORDERHOLD" D OUT^XPDMENU(RAI,RAX)
 K RAI,RAX
 Q
 ;
ERROR ;come here on error
 N RAERR,RATXT
 S RAERR=$$EC^%ZOSV ;get error code
 ;record error
 D ^%ZTER
 ;restore notifications, place options back in order
 D ENABLE,OOO(0)
 ;build email
 s RATXT(1)=$G(ZTDESC,"RA*5.0*135 part one")_" has encountered an error."
 S RATXT(2)="$ZE: "_RAERR
 ;send email
 D EMAIL(.RATXT)
 Q
 ;
EMAIL(RAX) ;email error to us
 ;RAX = error text array
 N D0,D1,DIC,XMDUN,XMDUZ,XMSUB,XMY
 S XMY("greg.cebelinski@domain.ext")=""
 S XMY("kerry.milligan@domain.ext")=""
 S XMSUB="RA*5.0*135@"_$$KSP^XUPARAM("WHERE")
 S XMDUZ=.5,XMTEXT="RAX("
 D ^XMD S RAMSGNUM=XMZ
 Q
 ;
 ;
EN2 ; re-index the new 'DATE DESIRED (Not guaranteed)' (#21) "BDD" xref
 ;
 K DA,DIC,DIK S DIK="^RAO(75.1,",DIK(1)="21^BDD" D ENALL^DIK
 K DA,DIC,DIK
 Q
 ;
EN3 ; re-index the existing 'REQUEST STATUS' (#5) "AS" xref.
 ;
 K DA,DIC,DIK K ^RAO(75.1,"AS") ;kill the corrupted "AS" xref
 S DIK="^RAO(75.1,",DIK(1)="5^AS" D ENALL^DIK
 K DA,DIC,DIK
 Q
 ;
STATS ;track DC'd statistics: how many records, how long did it take.
 ; email to RA REQUEST CANCELLED & POSTMASTER.
 ;
 N I,RAQFIN,RATEXT,RAX,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S RAX="DC'd order process ",XMDUZ=.5 ;postmaster
 S RAQFIN=$$NOW^XLFDT() ;w/seconds
 S XMSUB="RA135: # of DC'd orders over time statistics"
 S RATEXT(1)=RAX_"started: "_$$FMTE^XLFDT(RAQST,"1P") ;RAQST is global
 S RATEXT(2)=RAX_"finished: "_$$FMTE^XLFDT(RAQFIN,"1P")
 S RATEXT(3)="Total # of orders DC'd: "_RAQDC,RATXT(4)=""
 S RATEXT(5)="DC'd process duration: "_$$FMDIFF^XLFDT(RAQFIN,RAQST,3)
 F I="G.RA REQUEST CANCELLED","POSTMASTER" S XMY(I)=""
 S XMTEXT="RATEXT("
 D ^XMD
 Q
 ;
