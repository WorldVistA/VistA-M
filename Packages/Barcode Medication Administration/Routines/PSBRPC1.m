PSBRPC1 ;BIRMINGHAM/VN - BCMA RPC BROKER CALLS ;12/3/12 1:17pm
 ;;3.0;BAR CODE MED ADMIN;**42,70**;Mar 2004;Build 101
 ;
 ; Reference/IA
 ; ^%ZIS/812
 ; ^XUSEC/10076
 ; File 200/10060
 ;
 ;*70 - Add new RPC at tag MEDSONPT, to return true/false flags for 3
 ;      key med types and actions:   IV Infusing, IV Stopped, and
 ;      Patch on not removed.
 ;    - add Tags to perform Witness verification, RPC:PSB WITNESS
 ;
DEVICE(RESULTS,FROM,DIR) ;
 ;
 ; RPC: PSB DEVICE
 ;
 ; Return a subset of entries from the Device file
 ;
 ; .LST(n)=IEN;Name^DisplayName^Location^RMar^PLen
 ; FROM=text to $O from, DIR=$O direction
 K RESULTS
 N I,IEN,SHOW,X S I=0,CNT=20
 I FROM["<" S FROM=$RE($P($RE(FROM),"<  ",2))
 F  Q:I'<CNT  S FROM=$O(^%ZIS(1,"B",FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^%ZIS(1,"B",FROM,IEN)) Q:'IEN  D
 .. N X0,X1,X90,X91,X95,XTYPE,XSTYPE,XTIME,%A,%X,POP
 .. Q:'$D(^%ZIS(1,IEN,0))
 .. S X0=$G(^%ZIS(1,IEN,0)),X1=$G(^(1)),X90=$G(^(90)),X91=$G(^(91)),X95=$G(^(95)),XSTYPE=$G(^("SUBTYPE")),XTIME=$G(^("TIME")),XTYPE=$G(^("TYPE"))
 .. I $E($G(^%ZIS(2,+XSTYPE,0)))'="P" Q  ;Printers only
 .. S X=$P(XTYPE,"^")                    ;Device Types
 .. I $G(DUZ("AG"))="V",X'="TRM",X'="HG",X'="HFS",X'="CHAN" Q
 .. I $G(DUZ("AG"))="I",X'="OTH" Q
 .. S X=X0 I ($P(X,U,2)="0")!($P(X,U,12)=2) Q  ;Queuing allowed
 .. S X=+X90 I X,(X'>DT) Q  ;Out of Service
 .. I XTIME]"" S %A=$P(XTIME,"^"),%X=$P($H,",",2),%=%X\60#60+(%X\3600*100),%X=$P(%A,"-",2) I %X'<%A&(%'>%X&(%'<%A))!(%X<%A&(%'<%A!(%'>%X))) Q  ;Prohibited Times
 .. S POP=0
 .. I X95]"" S %X=$G(DUZ(0)) I %X'="@" S POP=1 F %A=1:1:$L(%X) I X95[$E(%X,%A) S POP=0 Q
 .. Q:POP  ;Security check
 .. S SHOW=$P(X0,U) I SHOW'=FROM S SHOW=FROM_"  <"_SHOW_">"
 .. S I=I+1,RESULTS(I)=IEN_";"_$P(X0,U)_U_SHOW_U_$P(X1,U)_U_$P(X91,U)_U_$P(X91,U,3)
 .. S RESULTS(0)=I
 I '$D(RESULTS(0)) S RESULTS(0)=1,RESULTS(1)="-1^No printers on file"
 Q
 ;
GPROV(RESULTS,DUMMY) ;
 K ^TMP("PSB",$J)
 S RESULTS=$NAME(^TMP("PSB",$J)),PSBCNT=1,^TMP("PSB",$J,0)=0
 D NOW^%DTC
 S X="" F  S X=$O(^XUSEC("PROVIDER",X)) Q:X=""  D
 .S PSBIACT=$$GET1^DIQ(200,X_",",53.4,"I") I PSBIACT'="",+PSBIACT'<% Q  ;if Inactive date and date is less than now Q
 .S PSBTERM=$$GET1^DIQ(200,X_",",9.2,"I") I PSBTERM'="",+PSBTERM'<% Q  ;if termination date and date is less than now Q
 .Q:'$$GET1^DIQ(200,X_",",53.1,"I")  ;is authorized to write med orders
 .Q:'$$GET1^DIQ(200,X_",",53.2)  ;must have DEA#
 .S ^TMP("PSBL",$J,$$GET1^DIQ(200,X_",",.01),X)=""
 S X="^TMP(""PSBL"","_$J_")",PSBCNT=1,^TMP("PSB",$J,0)=0
 F  S X=$Q(@X) Q:$QS(X,1)'="PSBL"  S ^TMP("PSB",$J,PSBCNT)=$QS(X,3)_"^"_$QS(X,4),^TMP("PSB",$J,0)=PSBCNT,PSBCNT=PSBCNT+1
 K ^TMP("PSBL",$J),PSBIACT,PSBTERM,PSBAUTH,PSBCNT,DUMMY
 Q
 ;
 ;*70 new tag below attached to RPC: PSB MEDS ON PATIENT
MEDSONPT(RESULTS,DFN) ; Return indicators for 3 types of meds on the patient
 S RESULTS(0)=1
 S $P(RESULTS(1),U,1)=$$INFUSING^PSBVDLU1(DFN)     ;IV's infusing flag
 S $P(RESULTS(1),U,2)=$$STOPPED^PSBVDLU1(DFN)      ;IV's stopped flag
 S $P(RESULTS(1),U,3)=$$PATCHON^PSBVDLU1(DFN)      ;patch on flag
 Q
 ;
WITNESS(RESULTS,PSBACC,PSBVER) ; Validate a witness to a BCMA action    ;*70
 ;
 ;     RPC: PSB WITNESS
 ;   Descr: RPC for validating Acces and Verify codes for a Witness
 ; Used by: frmWitness to validate an witness(s) at the client via
 ;          encrypted A/V Code.
 ;
 N LOGPERS,WITNESS,GUIIEN,PSBGUI,ERR
 S PSBACC=$$DECRYP^XUSRB1(PSBACC)
 S PSBVER=$$DECRYP^XUSRB1(PSBVER)
 S PSBWITN=$$CHECKAV^XUSRB(PSBACC_";"_PSBVER)
 ;
 ; valid ACC & VER code test
 I PSBWITN<1 D WITERR("Invalid Witness sign-on") K PSBWITN Q
 ;
 ; authorized tests
 I $D(^XUSEC("PSB STUDENT",PSBWITN)) D  Q
 . D WITERR("A student does not have authority to witness a High Risk/High Alert administration.")
 I $D(^XUSEC("PSB NO WITNESS",PSBWITN)) D  Q
 . D WITERR("You do not have authority to witness a High Risk/High Alert administration.")
 I $D(^XUSEC("PSB READ ONLY",PSBWITN)) D  Q
 . D WITERR("Read-Only users do not have authority to witness a High Risk/High Alert administration.")
 I DUZ=PSBWITN D WITERR("Cannot Witness for yourself") K PSBWITN Q
 ;** workaround bug in kernel XQCHK, if fixed remove logic ref to
 ;** checking "AP" xref and quits thereof
 N ACCESS
 S ACCESS=$$ACCESS^XQCHK(PSBWITN,"PSB GUI CONTEXT - USER")
 I ACCESS="N" D  Q
 . D WITERR("Invalid VistA user - No Primary menu setup for this user in the NEW PERSON file.")
 ;
 ;Code with ;** comments are extra checks to work around a bug in the
 ;Kernel API used above, and can be removed when this API is fixed.
 I +ACCESS<1 D  Q:ERR         ;can be 0 or negative
 . S ERR=1                                                 ;**
 . S PSBGUI=$O(^DIC(19,"B","PSB GUI CONTEXT - USER",""))   ;**
 . I $D(^VA(200,"AP",PSBGUI,PSBWITN)) S ERR=0 Q            ;**
 . D WITERR("A non-BCMA user does not have authority to witness a High Risk/High Alert administration.")
 ;
 ;error - instructor trying to witness for their student, is handled
 ; by the gui client.
 ;
 ; passed all tests
 S PSBWITN(0)=$$GET1^DIQ(200,PSBWITN_",",.01)
 S RESULTS(0)=PSBWITN_U_PSBWITN(0)
 Q
 ;
WITERR(MSG) ;build witness error msg                                   ;*70
 S RESULTS(0)="-1^"_MSG
 K PSBWITN
 Q
