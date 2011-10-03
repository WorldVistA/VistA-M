LRBEBA21 ;DALOI/JAH/FHS - PROCESS PANEL CPT CODE ;8/10/04
 ;;5.2;LAB SERVICE;**291,359**;Sep 27, 1994
 ;Continued LRBEBA2
 ;Process panel test for CPT
 ;Set 13th piece of LRSB(X) to prevent double counting
EN(LRBE21) ;LRBEAR1(LRBETST,
 ;Returns LRBE21
 ;        0 = process as atomic test
 ;        1 = processed (or will be processed in future) as panel
 N LRI,LRY,LRTST,LRNOP,LRNP,LRPEND,LRCANC,LRBSB,LRFDA,ERR,OK
 N LRBECDT,LRBEEDT,LRORREFN,LRPCECNT,LRBEQTY,LRNOREQ,LRBESTG
 S (LRBE21,LRPCECNT,LRNP,LRNOP,LRPEND,LRCANC)=0
 I $D(LRBEAR1(LRBETST)) D
 . ;must be AMA/billable panel
 . Q:'($D(LRBEPAN(LRBETST)))
 . S LRY=$O(^LRO(69,LRODT,1,LRSN,2,"B",LRBETST,0))
 . Q:'LRY
 . S LRY=LRY_","_LRSN_","_LRODT_","
 . ;canceled test
 . I $$GET1^DIQ(69.03,LRY,8,"I")="CA" K LRY Q
 . S LRBECDT=$$GET1^DIQ(69.03,LRY,22,"I")
 . I 'LRBECDT K LRY Q
 . I '$G(LRBERES) S LRPCECNT=$$GET1^DIQ(69.03,LRY,11,"I")
 . I LRPCECNT K LRY Q
 . S LRORREFN=$$GET1^DIQ(69.03,LRY,6,"I")
 . I $G(ORIEN),LRORREFN'=ORIEN K LRY Q
 . ;check status of atomic tests
 . S LRNOREQ=1
 . S LRBSB=0 F  S LRBSB=$O(LRBEAR1(LRBETST,LRBSB)) Q:'LRBSB  I $G(LRIDT) D
 . . ;check only 'required' atomic tests
 . . Q:'$D(LRBEAR1(LRBETST,LRBSB,"R"))
 . . S LRTST=+LRBEAR1(LRBETST,LRBSB,"R")
 . . S X=$G(LRBESB(LRBSB)) I 'LRTST S LRTST=+$P($P(X,"^",3),"!",7)
 . . I X="" S X=$G(^LR(LRDFN,LRSS,LRIDT,LRBSB)) S:(X'="") LRBESB(LRBSB)=X S:(X="") X="pending"
 . . ;check for not performed tests
 . . I $P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTST,0)),U,6)="*Not Performed" S LRNP=1
 . . ;check for tests already sent to pce
 . . I $P(X,U,13)=1 S LRNOP=1 Q
 . . ;check for cancelled tests
 . . I $P(X,U,1)="canc" S LRCANC=1
 . . ;check for tests still pending
 . . I $P(X,U,1)="pending" S LRPEND=1
 . . S LRNOREQ=0
 . ;quit if any 'required' atomic tests not performed or cancelled
 . Q:((LRNOREQ=0)&(LRNP!LRCANC))
 . ;check for resulted tests in panel with no 'required' tests
 . S OK=0
 . I LRNOREQ S LRBSB=0 F  S LRBSB=$O(LRBEAR1(LRBETST,LRBSB)) Q:'LRBSB!($G(LRNP))  D
 . . S X=$G(LRBESB(LRBSB)),LRTST=+$P($P(X,"^",3),"!",7)
 . . I $P(X,U,1)'="",$P(X,U,1)'="canc",$P(X,U,1)'="pending" S OK=1
 . . ;check for not performed tests
 . . I $P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTST,0)),U,6)="*Not Performed" S LRNP=1
 . ;quit if no 'required' tests on panel and no resulted tests
 . Q:(LRNOREQ&'OK)
 . ;if not roll-up to PCE, proceed to panel CPT; 
 . ;including case where none of atomic tests are 'required' (if results available)
 . I '$G(LRBEROLL) D PANEL^LRBEBA4 I $O(LRBECPT(LRBETST,0)) D
 . . S LRI=0 F  S LRI=$O(LRBECPT(LRBETST,LRI)) Q:LRI<1  D
 . . . S LRBECPT=$O(LRBECPT(LRBETST,LRI,0))
 . . . S LRBEMOD=$$GMOD^LRBEBA2(LRAA,LRBECPT)
 . . . S LRBEPOS=DUZ,LRBEQTY=1,LRBEDN=+$O(LRBEAR1(LRBETST,0))
 . . . D GDGX^LRBEBA21(LRBETST,LRBEDN,.LRBEAR,.LRBEAR1,.LRBEDGX)
 . . . S LRBESTG=LRBECPT_U_$G(LRBEMOD)_U_$G(LRBEDGX(LRBETST,1))_U_$G(LRBEDGX(LRBETST,2))_U_$G(LRBEDGX(LRBETST,3))
 . . . S LRBESTG=LRBESTG_U_$G(LRBEDGX(LRBETST,4))_U_LRBECDT_U_LRBEEPRO_U_LRBEOPRO_U_LRBEQTY_U_LRBEPOS
 . . . S LRBESTG=LRBESTG_U_$G(LRBEDGX(LRBETST,5))_U_$G(LRBEDGX(LRBETST,6))_U_$G(LRBEDGX(LRBETST,7))
 . . . S LRBESTG=LRBESTG_U_$G(LRBEDGX(LRBETST,8))_U_LRORREFN
 . . . I $G(LRBECPT(LRBETST,LRI,LRBECPT,"COUNT")) S $P(LRBESTG,U,20)=LRBECPT(LRBETST,LRI,LRBECPT,"COUNT")+1
 . . . S LRBEAR(LRBEDFN,"LRBEDGX",LRI,LRBETST)=LRBESTG
 ;
 Q:$G(LRY)=""
 ;
 ;if PCE rollup, then 'unbundled' in SOP2^LRBEBA2
 I $G(LRBEROLL) D  Q
 . K LRBECPT(LRBETST)
 . ;clear 'pending panel' xref
 . S LRFDA(1,69.03,LRY,22.1)=0
 . D FILE^DIE("KS","LRFDA(1)","ERR")
 ;
 ;if no required tests on panel and panel CPT exists, at least one resulted atomic,
 ;then mark panel as processed; retain LRBECPT array for BAWRK^LRBEBA;
 ;set return to "1" to avoid 'unbundled' processing in SOP2^LRBEBA2
 I $O(LRBECPT(LRBETST,0)),LRNOREQ D  Q
 . S LRBE21=1
 . D LRSB
 . S LRFDA(1,69.03,LRY,11)=1
 . ;clear 'pending panel' xref
 . S LRFDA(1,69.03,LRY,22.1)=0
 . D FILE^DIE("KS","LRFDA(1)","ERR")
 ;
 ;if no required tests on panel and panel has no CPT or inactive CPT,
 ;then return is "0" for 'unbundled' processing in SOP2^LRBEBA2
 I '$O(LRBECPT(LRBETST,0)),LRNOREQ Q
 ;
 ;if resending (from WORK^LRBEBA4) and panel CPT determined,
 ;then return "1" to avoid 'unbundled' processing in SOP2^LRBEBA2
 I $G(LRBERES)&LRNOP&('LRPEND)&($O(LRBECPT(LRBETST,0))) S LRBE21=1 Q
 ;
 ;if required atomic tests not performed, previously sent, or cancelled,
 ;then return is "0" for 'unbundled' processing in SOP2^LRBEBA2
 I (LRNP!LRNOP!LRCANC) D  Q
 . K LRBECPT(LRBETST)
 . ;clear 'pending panel' xref
 . S LRFDA(1,69.03,LRY,22.1)=0
 . D FILE^DIE("KS","LRFDA(1)","ERR")
 ;
 ;if panel has CPT and no required atomic test still pending,
 ;then mark panel as processed; retain LRBECPT array for BAWRK^LRBEBA;
 ;set return to "1" to avoid 'unbundled' processing in SOP2^LRBEBA2
 I $O(LRBECPT(LRBETST,0)),'LRPEND D  Q
 . S LRBE21=1
 . D LRSB
 . S LRFDA(1,69.03,LRY,11)=1
 . ;clear 'pending panel' xref
 . S LRFDA(1,69.03,LRY,22.1)=0
 . D FILE^DIE("KS","LRFDA(1)","ERR")
 ;
 ;if panel has no CPT or inactive CPT, but required atomic test still pending,
 ;then set return to "1" to avoid 'unbundled' processing in SOP2^LRBEBA2
 I '$O(LRBECPT(LRBETST,0)),LRPEND D  Q
 . S LRBE21=1
 . ;set 'pending panel' xref
 . S LRFDA(1,69.03,LRY,22.1)=1
 . D FILE^DIE("KS","LRFDA(1)","ERR")
 ;
 ;if panel has CPT, but required atomic test still pending,
 ;then kill cpt to avoid transmission to PCE,
 ;set return to "1" to avoid 'unbundled' processing in SOP2^LRBEBA2
 I $O(LRBECPT(LRBETST,0)),LRPEND D
 . S LRBE21=1
 . S LRI=$O(LRBECPT(LRBETST,0)) K LRBEAR(LRBEDFN,"LRBEDGX",LRI,LRBETST)
 . K LRBECPT(LRBETST)
 . ;set 'pending panel' xref
 . S LRFDA(1,69.03,LRY,22.1)=1
 . D FILE^DIE("KS","LRFDA(1)","ERR")
 ;
 Q
 ;
LRSB ;Set LRBESB(TEST) 13th piece to 1, counted as part of panel.
 ;Set 13th piece of LRBESB(X) to prevent double counting
 N LRSBX
 S LRSBX=0 F  S LRSBX=$O(LRBEAR1(LRBETST,LRSBX)) Q:LRSBX<1  D
 . I $D(LRBESB(LRSBX))#2 S $P(LRBESB(LRSBX),U,13)=1
 . I $G(LRIDT),$D(^LR(LRDFN,LRSS,LRIDT,LRSBX)) S $P(^(LRSBX),U,13)=1
 Q
 ;
GDGX(LRBETST,LRBEDN,LRBEAR,LRBEAR1,LRBEDGX) ; Set diagnosis LRBEDGX
 N LRBEPOV,LRBEPTDT,LRBETNUM
 S (LRBEPOV,LRBETNUM)=""  F  S LRBEPOV=$O(LRBEAR1(LRBETST,LRBEDN,LRBEPOV)) Q:'LRBEPOV  D
 . S LRBEPTDT=$G(LRBEAR1(LRBETST,LRBEDN,LRBEPOV))
 . S LRBETNUM=$G(LRBETNUM)+1,LRBEDGX(LRBETST,LRBETNUM)=$P(LRBEPTDT,U,1)
  Q:$D(LRBEDGX(LRBETST,1))
 N DGX S DGX=0
 F  S DGX=$O(LRBEAR(LRBEDFN,"LRBEDGX",LRSAMP,LRSPEC,LRBETST,DGX)) Q:DGX<1  D
 . S LRBETNUM=$G(LRBETNUM)+1,LRBEDGX(LRBETST,LRBETNUM)=DGX
 Q
GOREF(LRODT,LRSN,LRBEDN,LRBEAR1,LRORREFN) ;
 ;Get the OERR INTERNAL FILE #
 N LRX1,LRBEIEN1,LRBETST
 S LRBETST=""
 F  S LRBETST=$O(LRBEAR1(LRBETST)) Q:LRBETST=""  D
 .Q:'$D(LRBEAR1(LRBETST,LRBEDN))
 .S LRX1=$O(^LRO(69,LRODT,1,LRSN,2,"B",LRBETST,0))
 .I $G(LRX1) D  Q
 ..S LRBEIEN1=LRX1_","_LRSN_","_LRODT_","
 ..S LRORREFN=$$GET1^DIQ(69.03,LRBEIEN1,6,"I")
 .S LRORREFN=""
 Q
 ;
GMOD(LRBEAA,LRBECPT) ; Get external service modifier
 ;input LRBECPT - ien to #81, not required
 N DIC,LRBEESA,LRBEMOD,MOD,STAT,X,Y
 S LRBEESA=$$GET1^DIQ(68,LRBEAA_",",12,"I"),LRBEMOD=""
 I LRBEESA D
 .S X=90,DIC="^DIC(81.3,",DIC(0)="Z" D ^DIC
 .I +Y<0 K DIC Q
 .S LRBEMOD=$P(Y,U,2),MOD=+Y
 .;if cpt/hcpcs provided, check if modifier is valid to use
 .I $G(LRBECPT) D
 ..S STAT=$$MODP^ICPTMOD(LRBECPT,MOD,"I",DT)
 ..I +STAT=0 S LRBEMOD=""
 Q LRBEMOD
