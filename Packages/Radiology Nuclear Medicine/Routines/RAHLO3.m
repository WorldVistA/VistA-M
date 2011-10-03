RAHLO3 ;HIRMFO/GJC-Process data set from the bridge program ;11/18/97  12:13
 ;;5.0;Radiology/Nuclear Medicine;**4,81,84**;Mar 16, 1998;Build 13
 ;
 ;Integration Agreements
 ;-----------------------
 ;$$GET1^DIQ(2056); $$DT^XLFDT(10103)
 ;
RPTSTAT ; Determine the status to set this report to.
 K RARPTSTS S:$D(RAESIG) RARPTSTS="V" Q:$D(RARPTSTS)
 ; $D(RAESIG)=0 now figure out report status
 N RASTAT S RASTAT=$E($G(^TMP("RARPT-REC",$J,RASUB,"RASTAT")))
 I RASTAT="A" S RARPTSTS="V" Q
 I RASTAT]"",("FR"[RASTAT) D
 . S:RASTAT="F" RARPTSTS="V" Q:$D(RARPTSTS)
 . I $G(RATELE) S RARPTSTS="R" Q  ;Always allow 'Released/Unverified' reports for teleradiology
 . ; do we allow 'Released/Unverified' reports for this location?
 . S RARPTSTS=$S($P($G(^RA(79.1,RAMLC,0)),"^",17)="Y":"R",1:"D")
 . Q
 ; if no status, & there's physician data (verifier/primary),set status
 I '$D(RARPTSTS),($G(RAVERF)!$G(^TMP("RARPT-REC",$J,RASUB,"RASTAFF"))!$G(^("RARESIDENT"))) S RARPTSTS=$S($P($G(^RA(79.1,RAMLC,0)),"^",17)="Y":"R",1:"D")
 ; if still no status, default to draft
 S:'$D(RARPTSTS) RARPTSTS="D"
 Q
TEXT(X) ; Check if the Impression Text and the Report Text contain
 ; valid characters.
 ; Input : X = "I" if Impr Text is being checked, "R" if Rpt Text
 ; Output: 0=invalid, 1=valid
 N CNT,DATA,FLAG,I,I1,J,Y S (FLAG,I)=0
 F  S I=$O(^TMP("RARPT-REC",$J,RASUB,$S(X="I":"RAIMP",1:"RATXT"),I)) Q:I'>0  D  Q:FLAG
 . S CNT=0,DATA=$G(^TMP("RARPT-REC",$J,RASUB,$S(X="I":"RAIMP",1:"RATXT"),I)) Q:DATA']""
 . F J=1:1:$L(DATA) D  Q:FLAG
 .. S:$E(DATA,J)?1AN CNT=CNT+1
 .. S:$E(DATA,J)'?1AN&(CNT>0) CNT=0
 .. S:CNT=2 FLAG=1
 .. Q
 . Q
 Q FLAG
 ;
VERCHK ; Check if our provider can verify reports.
 ; Examine the following four (4) conditions if $D(RAESIG)
 ; 1) Does this person have a resident or staff classification?
 ; 2) If a resident, does the division parameter allow resident
 ;    verification?
 ; 3) Does this person hold the "RA VERIFY" key?
 ; 4) Is this person an activate Rad/Nuc Med user?
 ; 5) Can this person verify reports without staff review?
 ; If 'No' to any of the above questions, kill RAESIG & set the variable
 ; RAERR to the appropriate error message.
 I '$D(^VA(200,"ARC","R",+$G(RAVERF))),('$D(^VA(200,"ARC","S",+$G(RAVERF)))),'$G(RATELE) D  Q
 . ; neither a resident or staff
 . K RAESIG S RAERR="Provider not classified as resident or staff."
 . Q
 I $D(^VA(200,"ARC","R",+$G(RAVERF))),('$P(RAMDV,"^",18)),'$G(RATELE) D  Q
 . ; residents can't verify reports linked to this division
 . K RAESIG S RAERR="Residents are not permitted to verify reports."
 . Q
 I '$D(^XUSEC("RA VERIFY",+$G(RAVERF))),'$G(RATELE) D  Q
 . ; verifier MUST have the RA VERIFY key.
 . K RAESIG S RAERR="Provider does not meet security requirements to verify report."
 . Q
 I '$G(RATELE),$P($G(^VA(200,+$G(RAVERF),"RA")),"^",3),($P(^("RA"),"^",3)'>$$DT^XLFDT()) D
 . ; Rad/Nuc Med user has been inactivated.
 . K RAESIG S RAERR="Inactive Rad/Nuc Med Classification for Interpreting Physician."
 . Q
 I '$G(RATELE),'$S('$D(^VA(200,+$G(RAVERF),"RA")):1,$P(^("RA"),"^")'="Y":1,1:0) D
 . K RAESIG S RAERR="Staff review required to verify report."
 . Q
 Q
VFIER ; Check if the RAVERF string is a partial match to an entry in file
 ; 200.  If if is, check to see that is a partial match to only ONE
 ; active provider entry in file 200.
 I '$L(RAVERF) S RAERR="Missing Provider information" Q
 N RAVCNT,RAVIEN,RAVLGTH,RAVPS
 S RAVLGTH=$L(RAVERF) ; length of the RAVERF string
 S RAVCNT=0,RAVS1=RAVERF,RAVIEN=""
 F  S RAVS1=$O(^VA(200,"B",RAVS1)) Q:RAVS1=""!($E(RAVS1,1,RAVLGTH)'=RAVERF)  D  Q:RAVCNT>1
 . ; return subscripts that have the RAVERF string as the first
 . ; 1 - RAVLGTH chars of RAVS1
 . S RAVIEN=0
 . F  S RAVIEN=$O(^VA(200,"B",RAVS1,RAVIEN)) Q:RAVIEN'>0  D  Q:RAVCNT>1
 .. S RAVPS=$G(^VA(200,RAVIEN,"PS"))
 .. S:'$P(RAVPS,"^",4)!($P(RAVPS,"^",4)>DT) RAVCNT=RAVCNT+1
 .. I RAVCNT=1,('$D(RAVIEN(RAVCNT))#2) S RAVIEN(RAVCNT)=RAVIEN ; when
 .. ; we find the first active provider save the provider ien off
 .. ; in a local array.
 .. Q
 . Q
 ; Added for PowerScribe
 I RAVIEN']"" D
 . ;S RAVIEN=$P(RAVERF,$E(HL("ECH"),4))
 . S RAVIEN=+RAVERF
 . S RAVPS=$G(^VA(200,RAVIEN,"PS"))
 . S:'$P(RAVPS,"^",4)!($P(RAVPS,"^",4)>DT) RAVCNT=RAVCNT+1
 . I RAVCNT=1,('$D(RAVIEN(RAVCNT))#2) S RAVIEN(RAVCNT)=RAVIEN
 . Q
 I RAVCNT=0 S RAERR="Invalid Provider Name: "_RAVERF Q  ; partial match not found
 I RAVCNT>1 S RAERR="Non-Unique Provider Name: "_RAVERF Q  ; >1 partial match
 ;S RAVERF=$G(RAVIEN(1)) S:'RAVERF RAERR="Provider Name Entry Error"
 S:'$G(RAVIEN(1)) RAERR="Provider Name Entry Error: "_RAVERF S RAVERF=$G(RAVIEN(1))
 Q
ESIG ; Added for COTS E-Sig capability
 ;
 Q:"FA"'[^TMP(RARRR,$J,RASUB,"RASTAT")!('$D(^("RAVERF")))!($D(^("RAESIG")))
 S RADFN=+$G(^TMP(RARRR,$J,RASUB,"RADFN"))
 S RADTI=+$G(^TMP(RARRR,$J,RASUB,"RADTI"))
 S RADIV=$P($G(^RADPT(RADFN,"DT",RADTI,0)),"^",3)
 Q:RADIV=""  ; exam has been deleted - will be rejected
 ; Check division parameters for ALLOW E-SIG ON COTS REPORT in file 79
 ; for the division that ordered this procedure.
 I $P(^RA(79,RADIV,.1),"^",27)["Y" D
 . S RAESIG=$$GET1^DIQ(200,RAVERF,20.2)
 . S:RAESIG]"" ^TMP(RARRR,$J,RASUB,"RAESIG")=RAESIG
 . Q
 Q
