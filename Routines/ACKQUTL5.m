ACKQUTL5 ;HCIOFO/BH-Quasar utilities routine ; 12/24/09 2:15pm
 ;;3.0;QUASAR;**1,4,6,8,18**;Feb 11, 2000;Build 1
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
SETREF(X,ACKVIEN,ACKTYPE) ;
 ; Maintains APCE xRef When 3 of the 4 entries are present & the 4TH
 ; has been entered a new entry will be set up. If any of the 4 data 
 ; items used within the X ref are changed the entry will be deleted & a
 ; new 1 set up
 N ACKTME,ACKCLIN,ACKVD,ACKPAT
 D GETVAL
 I ACKTME="",ACKTYPE'="T" Q
 I ACKCLIN="",ACKTYPE'="C" Q
 I ACKVD="",ACKTYPE'="D" Q
 I ACKPAT="",ACKTYPE'="P" Q
 ;
 S ^ACK(509850.6,"APCE",ACKPAT,ACKCLIN,ACKVD,ACKTME,ACKVIEN)=""
 Q
KILLREF(X,ACKVIEN,ACKTYPE) ;
 ; When any of the 4 var values that make up the APCE xRef are deleted
 ; or when the visit record is deleted the APCE xRef will be deleted
 N ACKTME,ACKCLIN,ACKVD,ACKPAT
 D GETVAL
 ;
 I ACKTYPE'="T",ACKTME="" Q   ;  If any of the 4 field values other than
 I ACKTYPE'="C",ACKCLIN="" Q  ;  the field being edited are null the
 I ACKTYPE'="D",ACKVD="" Q    ;  xRef will not have been set up
 I ACKTYPE'="P",ACKPAT="" Q
 ;
 I ACKTYPE="D" S ACKVD=X      ;  X=Old field value
 I ACKTYPE="P" S ACKPAT=X
 I ACKTYPE="C" S ACKCLIN=X
 I ACKTYPE="T" S ACKTME=X
 ;
 I $D(^ACK(509850.6,"APCE",ACKPAT,ACKCLIN,ACKVD,ACKTME,ACKVIEN)) D
 . K ^ACK(509850.6,"APCE",ACKPAT,ACKCLIN,ACKVD,ACKTME,ACKVIEN)
 Q
 ;
GETVAL ; Used with SETREF & KILLREF - Gets The Clinic, Visit Date, Visit
 ; time and Patient from the visit file currently being processed
 N ACKTGT
 D GETS^DIQ(509850.6,ACKVIEN_",",".01;1;2.6;55","I","ACKTGT")
 S ACKVD=$G(ACKTGT(509850.6,ACKVIEN_",",.01,"I"))
 S ACKPAT=$G(ACKTGT(509850.6,ACKVIEN_",",1,"I"))
 S ACKCLIN=$G(ACKTGT(509850.6,ACKVIEN_",",2.6,"I"))
 S ACKTME=$G(ACKTGT(509850.6,ACKVIEN_",",55,"I"))
 Q
 ;
EXCEPT(ACKVIEN,ACKFLD,ACKVAL) ;  Called from xRefs within the LAST SENT TO PCE, LAST
 ;  EDITED IN QSR and PCE VISIT IEN fields
 N ACKTGT,ACKPIEN,ACKSENT,ACKEDIT,ACKARR,ACKEXCP
 I ACKFLD=125 D
 . S ACKPIEN=ACKVAL
 . S ACKSENT=$$GET1^DIQ(509850.6,ACKVIEN_",",135,"I")
 . S ACKEDIT=$$GET1^DIQ(509850.6,ACKVIEN_",",140,"I")
 I ACKFLD=135 D
 . S ACKPIEN=$$GET1^DIQ(509850.6,ACKVIEN_",",125,"I")
 . S ACKSENT=ACKVAL
 . S ACKEDIT=$$GET1^DIQ(509850.6,ACKVIEN_",",140,"I")
 I ACKFLD=140 D
 . S ACKPIEN=$$GET1^DIQ(509850.6,ACKVIEN_",",125,"I")
 . S ACKSENT=$$GET1^DIQ(509850.6,ACKVIEN_",",135,"I")
 . S ACKEDIT=ACKVAL
 ;
 ; if PCE visit ien known and PCE updated last then no exception
 I ACKPIEN'="",ACKEDIT'="",ACKSENT'="",ACKEDIT<ACKSENT D  Q
 . S ACKARR(509850.6,ACKVIEN_",",900)="@"
 . D FILE^DIE("","ACKARR")
 ; else this visit is an exception - only update if null or
 ; earlier than today
 S ACKEXCP=$$GET1^DIQ(509850.6,ACKVIEN_",",900,"I")
 D NOW^%DTC
 I (ACKEXCP="")!(ACKEXCP\1<(%\1)) D
 . S ACKARR(509850.6,ACKVIEN_",",900)=%
 . D FILE^DIE("","ACKARR")
 Q
SEND(ACKVIEN) ;  Called when entering/editing any of the PCE fields.
 ; inputs: ACKVIEN - visit ien 
 ; this s/r is used in the xRef of any data field that, if changed,
 ; should be sent to PCE to keep PCE up to date. The edit triggers the 
 ; xRef call to this s/r. It ensures that the LAST EDITED IN QSR date is
 ; after the LAST SENT TO PCE date so that the visit becomes a PCE 
 ; EXCEPTION. NB. The LAST EDITED IN QSR date will only be updated if
 ; a. it is currently earlier than the LAST SENT TO PCE and by updating 
 ; it the visit becomes a PCE Exception. or b. the current value is 
 ; earlier than today this saves the system from constantly updating 
 ; this field and checking the exception status each time a pce field 
 ; is changed
 N ACKARR,ACKEDIT,ACKSENT
 ; get current value of LAST EDITED IN QSR and LAST SENT TO PCE
 S ACKEDIT=$$GET1^DIQ(509850.6,ACKVIEN_",",140,"I")
 S ACKSENT=$$GET1^DIQ(509850.6,ACKVIEN_",",135,"I")
 D NOW^%DTC
 ; if qsr edit currently earlier than sent to pce update
 I ACKEDIT<ACKSENT D  Q
 . S ACKARR(509850.6,ACKVIEN_",",140)=%
 . D FILE^DIE("","ACKARR")
 ;
 ; if last edit is earlier than today update
 I (ACKEDIT\1)<(%\1) D  Q
 . S ACKARR(509850.6,ACKVIEN_",",140)=%
 . D FILE^DIE("","ACKARR")
 ; nothing to do - QSR date must already be after LAST SENT and for today
 Q
MOD ; Creates an array of valid CPT Modfrs.  gets all valid Mods for the 
 ; Proc then disgards any that are not on the A&SP Proc Mod file or that
 ; are on file but Inactive
 K ACKMOD,ACKMODD
 N CDT,ACKMOD1,ACKM1,ACKK2
 I $$PATCH^XPDUTL("PX*1.0*73") S ACKMOD1=$$CODM^ICPTCOD(ACKPC,"ACKMODD","",ACKVD)
 I '$$PATCH^XPDUTL("PX*1.0*73") S ACKMOD1=$$CODM^ICPTCOD(ACKPC,"ACKMODD")
 S ACKM1=""
 F  S ACKM1=$O(ACKMODD(ACKM1)) Q:ACKM1=""  D
 . S ACKK2=$P(ACKMODD(ACKM1),U,2)
 . I '$D(^ACK(509850.5,ACKK2,0)) K ACKMODD(ACKM1) Q
 . I $P(^ACK(509850.5,ACKK2,0),U,2)=0 K ACKMODD(ACKM1) Q
 . K ACKMODD(ACKM1) S ACKMOD(ACKPC,ACKK2)=""
 S ACKMOD(ACKPC)=""
 Q
MODW ; Called from x ref of Modfr field within 509850.6
 I X'["?" Q
 N ACKQDDD
 S ACKQDDD=$G(ACKVD)
 S DIC("W")="W ""  "",$$MODTXT^ACKQUTL8(Y,"_ACKQDDD_"),?48,$$GET1^DIQ(81.3,Y,.04)"
 Q
 ;
 ;
MODS ; Screen for Modfrs input within Modifrs field of Modfrs File
 N ACKQDDD,ACKMOD,ACKMOD1
 S ACKQDDD=$G(ACKVD)
 S DIC("S")="D GETS^DIQ(81.3,Y,"".01"",""I"",""ACKARR"",""ACKMSG"") S ACKMOD=$G(ACKARR(81.3,Y_"","","".01"",""I"")),ACKMOD1=$$MOD^ICPTMOD(ACKMOD) I $P($G(ACKMOD1),""^"",5)=""C""!($P($G(ACKMOD1),""^"",5)=""H""),$P($G(ACKMOD1),""^"",7)=1"
 S DIC("W")="W ""  "",$$MODTXT^ACKQUTL8(Y,"_ACKQDDD_")"
 Q
 ;
 ;
CHK(Y,ACKVD,ACKCSC) ;  Screen for EC codes
 N ACKQCD,ACKQQD,ACKQQCPT,ACKPARAM
 I $E($P(^EC(725,+Y,0),"^",2),1,2)'="SP" Q 0
 S ACKQQCPT=$$GET1^DIQ(725,+Y_",",4,"I") I ACKQQCPT="" Q 0
 ;S ACKQCD=$$CONVERT(ACKQQCPT) I ACKQCD="" Q 0
 S ACKQCD=ACKQQCPT
 S ACKPARAM=$P($$CPT^ICPTCOD(ACKQCD,ACKVD),"^",7) I 'ACKPARAM Q 0
 I '$D(^ACK(509850.4,ACKQCD,0)) Q 0
 I $P(^ACK(509850.4,ACKQCD,0),U,2)'[$E(ACKCSC) Q 0
 I $P(^ACK(509850.4,ACKQCD,0),U,4)'=1 Q 0
 S ACKQQD=$P(^EC(725,Y,0),"^",3) I ACKQQD="" Q 1
 I ACKVD<ACKQQD Q 1
 Q 0
EVNTDIS ; Get EC Procs filed and display
 D ENS^%ZISS
 N D0,ACKKEY,ACKEVTDS,ACKK3,ACKPROC,ACKPRV,ACKNME,ACKNATNM
 D LIST^DIC(509850.615,","_ACKVIEN_",",".01;.03;.05","I","*","","","","","","ACKEVTDS")
 I '$D(ACKEVTDS("DILIST",1)) Q
 W !!," ",IOUON,"Event Capture Procedures currently entered for this visit",IOUOFF,!
 S ACKK3=""
 F  S ACKK3=$O(ACKEVTDS("DILIST",1,ACKK3)) Q:ACKK3=""  D
 . S ACKPROC=ACKEVTDS("DILIST",1,ACKK3)
 . S ACKPRV=ACKEVTDS("DILIST","ID",ACKK3,.05)
 . I ACKPRV'="" S ACKPRV=$$CONVERT^ACKQUTL4(ACKPRV)
 . S ACKNME=$$GET1^DIQ(725,ACKPROC_",",.01) S ACKNME=$E(ACKNME,1,29)
 . S ACKNATNM=$$GET1^DIQ(725,ACKPROC_",",1)
 . W !," Nat.#: ",ACKNATNM,?14,"    Name: ",ACKNME,?55,"Vol.: ",ACKEVTDS("DILIST","ID",ACKK3,.03) I ACKPRV'="" W !,?14,"Provider: ",ACKPRV
 . W !
 Q
SETCPT(DA,ACKQQIEN,X) ;  When EC Code is entered create a CPT entry
 I '$D(ACKEVENT) Q   ; "" or 1 ACKEVENT must be defined
 N ACK,ACKARR1,ACKCIEN,ACKQQCPT
 ; Get CPT associated with EC code
 S ACKQQCPT=$$GET1^DIQ(725,X_",",4,"I")
 ;S ACKQQCPT=$$CONVERT(ACKQQCPT)
 S ACKCIEN="" K ACKARR1
 ; Create CPT entry and enter DA as CPT's pter to creating EC entry
 S ACKARR1(509850.61,"+1,"_ACKQQIEN_",",.01)=ACKQQCPT
 S ACKARR1(509850.61,"+1,"_ACKQQIEN_",",.07)=DA
 D UPDATE^DIE("","ACKARR1","ACKCIEN","")
 K ACK
 ; After CPT entry set up get its IEN & set it to the creating EC 
 ; entries CPT ptr field
 S ACK(509850.615,DA_","_ACKQQIEN_",",.07)=ACKCIEN(1)
 D FILE^DIE("","ACK","")
 Q
KILLCPT(DA,ACKQQIEN) ;  Deletes CPT entry if created by an EC entry
 I '$D(ACKEVENT) Q  ; "" or 1 ACKEVENT must be defined
 Q:'ACKEVENT  ; Q if Div set up to use CPT's
 N ACKCIEN,ACK
 S ACKCIEN=$$GET1^DIQ(509850.615,DA_","_ACKQQIEN_",",.07)
 I ACKCIEN="" Q
 S ACK(509850.61,ACKCIEN_","_ACKQQIEN_",",.01)="@" D FILE^DIE("","ACK")
 Q
ECVOLPRV(DA,ACKQQIEN,X,ACKQQVP,ACKQQDS) ; Update CPT rec. when EC data entered 
 ;If CPT entry linked with the EC entry - 
 ;   If ACKQQDS='S'
 ;     If ACKQQVP='V' set EC vol to CPT vol
 ;     If ACKQQVP='P' set EC Prvdr to CPT Prvdr
 ;   If ACKQQDS='D'
 ;     If ACKQQVP='V' delete CPT vol
 ;     If ACKQQVP='P' delete CPT Prvdr
 ;
 I '$D(ACKEVENT) Q   ; "" or 1 ACKEVENT must be defined
 Q:'ACKEVENT
 N ACKFIELD,ACKVAL,ACK,ACKCIEN
 S ACKCIEN=$$GET1^DIQ(509850.615,DA_","_ACKQQIEN_",",.07)
 I ACKCIEN="" Q
 S ACKFIELD=".03" I ACKQQVP="P" S ACKFIELD=".05"
 S ACKVAL=X I ACKQQDS="D" S ACKVAL="@"
 S ACK(509850.61,ACKCIEN_","_ACKQQIEN_",",ACKFIELD)=ACKVAL
 D FILE^DIE("","ACK","")
 Q
CPVOLPRV(DA,ACKQQIEN,X,ACKQQVP,ACKQQDS) ; Update EC rec. when CPT data entered 
 ;If EC entry linked with the CPT entry - 
 ;   If ACKQQDS='S'
 ;     If ACKQQVP='V' set CPT vol to EC vol
 ;     If ACKQQVP='P' set CPT Prvdr to EC Prvdr
 ;   If ACKQQDS='D'
 ;     If ACKQQVP='V' delete EC vol
 ;     If ACKQQVP='P' delete EC Prvdr
 ;
 I '$D(ACKEVENT) Q   ; "" or 1 ACKEVENT must be defined
 Q:ACKEVENT
 N ACKFIELD,ACKVAL,ACK,ACKEIEN
 S ACKEIEN=$$GET1^DIQ(509850.61,DA_","_ACKQQIEN_",",.07)
 I ACKEIEN="" Q
 S ACKFIELD=".03" I ACKQQVP="P" S ACKFIELD=".05"
 S ACKVAL=X I ACKQQDS="D" S ACKVAL="@"
 S ACK(509850.615,ACKEIEN_","_ACKQQIEN_",",ACKFIELD)=ACKVAL
 D FILE^DIE("","ACK","")
 Q
KILLEC(DA,ACKQQIEN) ;  Delets EC entry if CPT entry has EC pter
 I '$D(ACKEVENT) Q   ; "" or 1 ACKEVENT must be defined
 Q:ACKEVENT   ; Q if Div set up to use EC's
 N ACKECIEN,ACK
 S ACKECIEN=$$GET1^DIQ(509850.61,DA_","_ACKQQIEN_",",.07)
 I ACKECIEN="" Q
 S ACK(509850.615,ACKECIEN_","_ACKQQIEN_",",.01)="@" D FILE^DIE("","ACK")
 Q
EVENT(ACKDIV,ACKVD) ; params set up for Divn to use EC Codes ?
 N ACKY,X,Y,ACKM
 S ACKY=$E(ACKVD,2,3),ACKM=$E(ACKVD,4,5)
 I ACKM>9 S ACKY=ACKY+1 I $L(ACKY)=1 S ACKY="0"_ACKY
 I '$D(^ACK(509850.8,1,2,ACKDIV,2,"B",ACKY)) Q 0
 S ACKKEY=0
 S ACKKEY=$O(^ACK(509850.8,1,2,ACKDIV,2,"B",ACKY,ACKKEY))
 S ACKEC=$P(^ACK(509850.8,1,2,ACKDIV,2,ACKKEY,0),"^",2)
 I ACKEC="" S ACKEC="0"
 Q ACKEC
 ;
