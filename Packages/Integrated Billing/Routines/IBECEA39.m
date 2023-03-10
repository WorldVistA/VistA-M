IBECEA39 ;EDE/WCJ-Multi-site maintain UC VISIT TRACKING FILE (#351.82) - PULL; 2-DEC-19
 ;;2.0;INTEGRATED BILLING;**669,678,696**;21-MAR-94;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; DBIA#1621 %ZTER (ERROR RECORDING)
 ;; DBIA#2729 MESSAGE ACTION API
 ;; DBIA#4678 VAFCTFU GET TREATING LIST
 ;; DBIA#3144 DIRECT RPC CALLS
 ;; DBIA#3149 XWBDRPC
 ; 
 G AWAY
 ;
AWAY Q  ;thought I was being figurative??? Guess again!
 ;
PULL ; This will be called from a menu option.
 ; ask the patient and if selected, initiate the pull
 ;
 N IBDFN,IBPULLRESULTS
 ;
AGAIN Q:'$$GETPAT(.IBDFN)
 ;
 D PATIENTPULL(IBDFN,.IBPULLRESULTS)
 ;
 D DISPLAYRES(IBDFN,.IBPULLRESULTS)
 ;
 K IBDFN,IBPULLRESULTS
 G AGAIN   ; I know, I know, it's a goto - please don't judge me
 ;
GETPAT(IBDFN) ; Select a patient.
 ; Return 0 - no patient selected
 ; Return 1 - patient selected
 ; IBDFN will be the patient's IEN in file 2
 ;
 N DIC,X,Y
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC S IBDFN=+Y
 Q Y>0
 ;
PATIENTPULL(IBDFN,IBERR) ; This does a lot of the same stuff the push does only for a specific veteran.
 ; IBDFN - which patient
 ; IBERR - return array of results
 ;
 K ^TMP("IBECEA_COPAY",$J)  ; start fresh
 ;
 N IBSITE,IBFAC,IBTFL,IBT,IBICN,IBH,IBX,IBR,IBHERE,IBC,IBZ
 S IBERR=0
 ;
 D SITE^IBAUTL   ; returns IBSITE (external#) and IBFAC (internal#) based on IB SITE PARAMETERS for this site
 S IBICN=$$ICN^IBARXMU(IBDFN)
 I 'IBICN S IBERR=IBERR+1,IBERR(IBERR)="-1^Failed local ICN lookup." Q  ; no ICN - leave in the index and try again tomorrow since people eventually get ICNs according the MPI documentation
 S IBT=$$TFL^IBECEA37(IBDFN,IBSITE,.IBTFL)
 I 'IBT S IBERR=IBERR+1,IBERR(IBERR)="-1^No record of Veteran being seen at other treating facilities (file #391.91)" Q   ; not seen at other treating facilites so no where to send - done with entry
 ;
 ; send off calls to other treating facilities that this veteran has been seen at
 ; the calls fire off the RPC (stored procedure) at each site
 S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  D
 . W !,"Now sending query to ",$P(IBTFL(IBX),"^",2)," ..."
 . N IBH
 . D EN1^XWB2HL7(.IBH,+IBTFL(IBX),"IBECEA COPAY SYNCH","",IBICN,IBSITE)  ; push a request for all records for a patient (used when playing catch up - possibly adding a treating facility)
 . ; check for handle
 . I $G(IBH(0))="" D  Q
 .. S IBTFL(IBX,"ERR")="-1^No handle returned from RPC"
 .. S IBERR=IBERR+1,IBERR(IBERR)="-1^No handle returned from RPC by site "_$P(IBTFL(IBX),"^",2)
 . S $P(IBTFL(IBX),"^",3)=IBH(0) ; save handle for later.
 ;
 ; now lets look for the remote data
 S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  I '$D(IBTFL(IBX,"ERR")) D
 . ;
 . ; try up to 10 times for 2 seconds each (at each site)
 . N IBR
 . F IBC=1:1:10 D RPCCHK^XWB2HL7(.IBR,$P(IBTFL(IBX),U,3)) Q:$G(IBR(0))["Done"  H 2
 . ;
 . ; If not done at one (or more) facility set a flag so it does not get removed from the index 
 . I $G(IBR(0))'["Done" S IBERR=IBERR+1,IBERR(IBERR)="-1^No reply from site "_+IBTFL(IBX)_"."
 . ; if done get data.
 . I $G(IBR(0))["Done" D
 .. K IBR,IBHERE
 .. W !,"Query to site "_+IBTFL(IBX)_" completed."
 .. D RTNDATA^XWBDRPC(.IBHERE,$P(IBTFL(IBX),"^",3))
 .. I $D(IBHERE)>10 D   ; not sure if was success or failure so save for now
 ... S IBERR=IBERR+1
 ... M IBERR(IBERR,+IBTFL(IBX),"REC")=IBHERE
 .. E  D
 ... S IBERR=IBERR+1
 ... M IBERR(IBERR,+IBTFL(IBX),"ERR")=^TMP($J,"XWB")
 ... K ^TMP($J,"XWB")
 .. D CLEAR^XWBDRPC(.IBZ,$P(IBTFL(IBX),"^",3))
 ; 
 Q
 ;
PARSEPULL(IBPD,IBDFN,ERR) ; parse the record being pulled from the originating site
 ; IBPD is a packed data array
 ; "IEN^.01I^.01^C2^.03I^.04I^.05^.06I^.07I^1.01I^C9"
 ; "ien at originating site^dfn at originating site^patient name^originating site^event date^status^bill #^reason^unique id^update^full icn"
 ; "2^7229593^LASTNAME,FIRSTNAME MIDDLE^529^3190814^2^442-K902Z6L^^^99999999999v999999"
 ; IBDFN is the patient that we asked for
 ; ERR is returned even if it's not an ERROR so kind of a misnomer.
 ;
 ; and then add it, update it, or punt.
 ;
 N IBUID,IBOS,IBIEN,IBRETURN
 ;WCJ;IB696;date added variable
 ;N IBICN,IBED,IBST,IBRS,IBBN,IBEG,IBADDED,IBUPDATED
 N IBICN,IBED,IBST,IBRS,IBBN,IBEG,IBADDED,IBUPDATED,IBDADDRS,IBDADDHERE
 ;
 ; get the patient from their ICN and compare for grins - probably undeeded code but kind of fun - don't ya think
 S IBICN=$P(IBPD,U,11) ; ICN
 I IBDFN'=+$$DFN^IBARXMU($G(IBICN)) S ERR(1)="-1^Something went horribly wrong." Q
 ;
 ; get unique identifier and if not there, make one.
 S IBUID=$P(IBPD,U,9)  ; unique ID
 I IBUID="" D
 . S IBOS=$P(IBPD,U,4)  ; originating site
 . S IBIEN=$P(IBPD,U)  ; 351.82 IEN at originating site
 . S IBUID=IBOS_"_"_IBIEN
 ;
 I IBUID="" S ERR(1)="-1^No UNIQUE ID - this can't actually happen so not sure why I am coding for it." Q
 ;
 S IBED=$P(IBPD,U,5)  ; event date
 S IBST=$P(IBPD,U,6)  ; status
 S IBBN=$P(IBPD,U,7)  ; bill number
 S IBRS=$P(IBPD,U,8)  ; reason
 S IBEG=$P(IBPD,U,12)  ; eligibilty group
 D
 . N X
 . S X=$P(IBPD,U,13)
 . D ^%DT
 . S IBDADDRS=$S(+Y:Y,1:"")   ;date added to patient file at the Remote System
 S IBDADDHERE=$$GET1^DIQ(2,IBDFN,.097,"I")  ; date patient added to this system aka HERE.
 ;
 ;WCJ;IB696;checking if the event date was before the patient was added to the remote system
 ;I IBEG'=$$GETELGP^IBECEA36(IBDFN,IBED) D  Q
 I IBEG'=$$GETELGP^IBECEA36(IBDFN,IBED),$S('IBDADDHERE:1,IBED<IBDADDHERE:0,1:1) D  Q
 . N Y S Y=IBED X ^DD("DD")
 . S ERR(1)="-1^Patient's eligibility group differs between sites for date of service "_Y_"."
 . S ERR(2)="-1^Current Site = "_$$GETELGP^IBECEA36(IBDFN,IBED)
 . S ERR(3)="-1^Site# "_$P(IBUID,"_")_" = "_IBEG
 . Q
 ;
 ; see if the record is already here.
 D FIND^DIC(351.82,"",".01;.02:99;.03I;.04I;.05;.06I;.07I;1.01I","QEPX",IBUID,"","AUID")
 ;
 ; found 1 so attempt to edit it
 I +$G(^TMP("DILIST",$J,0))=1 D  Q
 . N IBDATA,IBIEN351P82
 . S IBDATA=$G(^TMP("DILIST",$J,1,0))
 . S IBIEN351P82=+IBDATA
 . I $P(IBDATA,U,6)=IBST,$P(IBDATA,U,7)=IBBN,$P(IBDATA,U,8)=IBRS S ERR(1)="0^No changes requested" Q
 . S IBUPDATED=$$UPDATE^IBECEA38(IBIEN351P82,IBST,IBBN,IBRS,0,.IBRETURN)
 . I 'IBUPDATED D  Q
 .. N Y
 .. S Y=IBED X ^DD("DD")
 .. S ERR(1)="-1^Unable to ADD record from Originating site# "_$P(IBUID,"_")_" and date: "_Y
 .. S:IBRETURN["MAX free" ERR(2)=-1_U_IBRETURN
 . S ERR(1)="1^successfully updated" Q
 . Q
 ;
 ; found "many" (could be two or a jillion).  Should not happen now that we add a unique identifier (KEYWORDS: should + not + unique)
 I +$G(^TMP("DILIST",$J,0))>1 D  Q
 . S ERR(1)="-1^Could not uniquely identify entry being updated - more than one match.  Originating site# "_$P(IBUID,"_")_" and IEN:"_$P(IBUID,"_",2)
 ;
 ; no matches, feel free to add one
 I '$G(^TMP("DILIST",$J,0)) D  Q
 . S IBADDED=$$ADD^IBECEA38(IBDFN,IBOS,IBED,IBST,IBBN,IBRS,0,IBUID,.IBRETURN)
 . I 'IBADDED D  Q
 .. N Y
 .. S Y=IBED X ^DD("DD")
 .. S ERR(1)="-1^Unable to ADD record from Originating site# "_$P(IBUID,"_")_" and date: "_Y
 .. S:IBRETURN["MAX free" ERR(2)=-1_U_IBRETURN
 . S ERR(1)="1^successfully added" Q
 . Q
 Q
 ;
DISPLAYRES(IBDFN,IBPULLRESULTS) ; display results
 N ARR,IBDATA,IBCNT,IBMAX,IBOUT
 S ARR="IBPULLRESULTS",IBCNT=1,IBMAX=10,IBOUT=0
 F  S ARR=$Q(@ARR) Q:ARR=""  D  Q:IBOUT
 . I ARR["REC" D  Q
 .. I ARR["""REC"")" Q
 .. I ARR[",0)" Q   ; don't need 0 node, info only - IBPULLRESULTS(1,529,"REC",0)="23^*^0^"
 .. I ARR[",1)" Q   ; don't need 1 node, info only - IBPULLRESULTS(1,529,"REC",1)="IEN^.01I^.01^C2^.03I^.04I^.05^.06I^.07I^1.01I^.08"
 .. N IBPULLDATA,IBERR
 .. S IBPULLDATA=$G(@ARR)
 .. D PARSEPULL(IBPULLDATA,IBDFN,.IBERR)  ; parse data coming back - IBPULLRESULTS(1,529,"REC",2)="2^7229593^LASTNAME,FIRSTNAME MIDDLE^529^3190814^2^442-K902Z6L^^^0^1234567890V123456^8"
 .. I $P($G(IBERR(1)),U)<0 D
 ... N I S I=0 F  S I=$O(IBERR(I)) Q:'I  S IBOUT=$$WRITE($P(IBERR(I),U,2,999),.IBCNT) Q:+IBOUT 
 . S IBDATA=$G(@ARR)
 . S:IBDATA[U IBDATA=$P(IBDATA,U,2,999)
 . I IBDATA]"" S IBOUT=$$WRITE(IBDATA,.IBCNT)
 W !!
 Q
 ;
WRITE(DATA,CNT) ;
 N DIRUT,DIROUT
 W !,DATA
 I '(CNT#20) D PAUSE^VALM1
 S CNT=$G(CNT)+1
 Q $G(DIRUT)
