AFJXVER ;FO-OAKLAND/GMB-VERIFY NHE DATA MESSAGE IS VALID ;1/09/01  13:51
 ;;5.1;Network Health Exchange;**26,31**;Jan 23, 1996
 ; Totally rewritten 11/2001.  (Previously CIOFO-SLC/RJS.)
 ; Entry point:
 ; ENTER - Invoked by option AFJX PATID REPORT
ENTER ;
 D EN^XUTMDEVQ("ALL^AFJXVER","Network Health Exchange Data Message Report")
 Q
ALL ; ALL MESSAGES
 N AXBSKT,AXCNT,AXMZ,AXDATA,AXDATE,AXLIST,AXMZ,AXSEG,AXSITE,AXNHEDUZ,AXBSKTN,AXTXT
 W !!,"Network Health Exchange Data Message report"
 W !,?20,"for ",^XMB("NETNAME"),!,?24,"on ",$$HTE^XLFDT($H)
 S AXNHEDUZ=$$FIND1^DIC(200,"","X","NETWORK,HEALTH EXCHANGE","B")
 I 'AXNHEDUZ W !,"NETWORK,HEALTH EXCHANGE user not in New Person file." Q
 W !!,"Checking NETWORK,HEALTH EXCHANGE messages..."
 I '$D(^XMB(3.7,AXNHEDUZ)) W !,"No Mail Box for this user defined..." Q
 S AXBSKT=.9
 F  S AXBSKT=$O(^XMB(3.7,AXNHEDUZ,2,AXBSKT)) Q:'AXBSKT  D  ;  Loop through mail baskets.
 . S AXBSKTN=$$BSKTNAME^XMXUTIL(AXNHEDUZ,AXBSKT)
 . S AXLIST(2,AXBSKTN)=0
 . W !,?3,"Checking ",AXBSKTN," basket..."
 . S (AXMZ,AXCNT)=0
 . F  S AXMZ=$O(^XMB(3.7,AXNHEDUZ,2,AXBSKT,1,AXMZ)) Q:'AXMZ  D  ;  Check each message.
 . . S AXCNT=AXCNT+1 W:($X>50) ! W:'(AXCNT#100) "."
 . . S AXLIST(2,AXBSKTN)=AXLIST(2,AXBSKTN)+1  ;  Update basket Message Counter
 . . S AXDATA=$$MSG(AXMZ) Q:'$L(AXDATA)
 . . S AXLIST(1,$P(AXDATA,U,2),"T")=$G(AXLIST(1,$P(AXDATA,U,2),"T"))+1
 . . S AXTXT=$$VALID(AXMZ)
 . . I AXTXT D  Q  ;  Message is valid.
 . . . S AXLIST(1,$P(AXDATA,U,2),"V")=$G(AXLIST(1,$P(AXDATA,U,2),"V"))+1
 . . ;W !," Data discrepancy in message #",+AXMZ,"  ",$P(AXTXT,U,2)
 . . ;   Message has data discrepancies.
 . . S AXLIST(1,$P(AXDATA,U,2),+AXDATA)=$G(AXLIST(1,$P(AXDATA,U,2),+AXDATA))+1
 . . S AXLIST(1,$P(AXDATA,U,2),+AXDATA,AXMZ)=$P(AXTXT,U,2)
 . . S AXLIST(1,$P(AXDATA,U,2),"N")=$G(AXLIST(1,$P(AXDATA,U,2),"N"))+1
 W !!,"Message count"
 S AXBSKTN=""
 F  S AXBSKTN=$O(AXLIST(2,AXBSKTN)) Q:AXBSKTN=""  D
 . W !,?3,$J(+AXLIST(2,AXBSKTN),8)
 . W " message",$S((+AXLIST(2,AXBSKTN)=1):"",1:"s")
 . W " in the '",AXBSKTN,"' basket."
 W !!,"Site",?49,$J("Not Valid",10),$J("Valid",10),$J("Total",10),!
 S AXSITE=""
 F  S AXSITE=$O(AXLIST(1,AXSITE)) Q:AXSITE=""  D
 . W !,$E(AXSITE,1,48),?49
 . F AXSEG="N","V","T" W $J(+$G(AXLIST(1,AXSITE,AXSEG)),10)
 . S AXDATE=0
 . F  S AXDATE=$O(AXLIST(1,AXSITE,AXDATE)) Q:'AXDATE  D
 . . W !,?3,"Problems for ",$$FMTE^XLFDT(AXDATE,5),": ",$G(AXLIST(1,AXSITE,AXDATE))
 . . S AXMZ=0
 . . F  S AXMZ=$O(AXLIST(1,AXSITE,AXDATE,AXMZ)) Q:'AXMZ  D
 . . . W !,$J(AXMZ,15),"   ",AXLIST(1,AXSITE,AXDATE,AXMZ)
 Q
VALID(AXMZ) ;  ONE MESSAGE
 N AXAGE,AXCHKAGE,AXDOB,AXLINE,AXDATE,AXTXT
 Q:'$O(^XMB(3.9,AXMZ,2,0)) 1  ;  No text in message?
 S (AXDATE,AXDOB,AXAGE,AXCHKAGE)=""  ;  Initialize key fields.
 S AXLINE=.99999999
 F  S AXLINE=$O(^XMB(3.9,AXMZ,2,AXLINE)) Q:'AXLINE  D  Q:($L(AXDOB)&$L(AXAGE)&$L(AXDATE))  ; Look for key fields.
 . S AXTXT=$G(^XMB(3.9,AXMZ,2,AXLINE,0)) Q:$L(AXTXT)<5  ;  Get a line and Quit if not long enough.
 . S AXTXT=$$UP^XLFSTR(AXTXT)
 . I '$L(AXDOB),AXTXT["DOB: " S AXDOB=$$SPACES($P(AXTXT,"DOB: ",2)) Q
 . I '$L(AXAGE),AXTXT["AGE: " S AXAGE=$$SPACES($P(AXTXT,"AGE: ",2)) Q
 . I '$L(AXDATE),AXTXT["***CONFIDENTIAL PATIENT DATA FROM" S AXDATE=$$SPACES($P(AXTXT,"*",$L(AXTXT,"*")))
 Q:'($L(AXAGE)&$L(AXDOB)&$L(AXDATE)) 1  ;  Quit if missing a key field.
 S AXDATE=$$DT2INT(AXDATE),AXDOB=$$DT2INT(AXDOB)
 I AXDATE=-1!(AXDOB=-1) Q 1  ;  Conversion problem in one of the dates.
 S AXCHKAGE=$$FMDIFF^XLFDT(AXDATE,AXDOB,1)\365.25  ; Calculate age of patient.
 Q:AXCHKAGE=AXAGE 1  ;  If calculated age equals displayed age then data is valid.
 Q "0^Age: "_AXAGE_"   DOB: "_$$FMTE^XLFDT(AXDOB,5)_"   DOR: "_$$FMTE^XLFDT(AXDATE,5)_"   Actual Age: "_AXCHKAGE  ;  If not then return reason.
MSG(AXMZ) ;
 N AXREC,AXFROM,AXDATE,AXSITE
 Q:'$O(^XMB(3.9,AXMZ,2,0)) ""  ;  No text in message?
 S AXREC=$G(^XMB(3.9,AXMZ,0)) Q:AXREC="" ""
 S AXFROM=$P(AXREC,U,2)
 S AXSITE=$S(AXFROM["@":$P($P(AXFROM,"@",2),">"),1:^XMB("NETNAME"))
 S AXDATE=$P(AXREC,U,3)
 I AXDATE?7N1".".N S AXDATE=$P(AXDATE,".")
 E  D
 . S AXDATE=$$CONVERT^XMXUTIL1(AXDATE)
 . I AXDATE=-1 S AXDATE=0
 Q AXDATE_U_AXSITE
DT2INT(X) ; Convert date from external to internal fileman format.
 N Y,%DT S %DT="T" D ^%DT Q Y
SPACES(X) ;   Get rid of leading and trailing spaces
 F  Q:'$L(X)  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X)) ; Leading spaces
 F  Q:'$L(X)  Q:$E(X,$L(X))'=" "  S X=$E(X,1,$L(X)-1) ; Trailing spaces
 Q X
