HMPOR ;ASMR/CK,hrubovcak - Order file support;Feb 01, 2016 14:28:49
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Build 4;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; routine created for US11894, December 17, 2015
 Q
 ;
ADDFLAG(HMRSLT,HMVALS,HMORIFN,HMDFN,HMORLVL) ; LAYGO flag action into HMP SUBSCRIPTION file (#800000)
 ; HMRSLT - result, passed-by-ref.,  1 on success else "-1^error message"
 ;parameters below required
 ; HMVALS - array of values, subscripted by field #, passed-by-ref.
 ; HMORIFN - Order IFN
 ; HMDFN - patient DFN
 ; HMORLVL = ^OR(100,HMORIFN,8,level) OPTIONAL, used from within OE/RR
 ;
 S HMRSLT="-1^parameter missing"  ; initialize return
 Q:'($G(HMORIFN)>0)!'($G(HMDFN)>0)  ; must have Order IFN and patient DFN
 Q:'$G(HMVALS(.01))  ; must have date/time at minimum
 ;
 N FMSG,HMFDA,HMIENS,HMSRVR,J,SUB,X
 S HMSRVR=$$SRVRNO(HMDFN)
 I '(HMSRVR>0) S HMRSLT="-1^HMP server not found to add flag data." Q
 ;
 S X=$$GET1^DIQ(100,HMORIFN_",",.02,"I")  ; (#.02) OBJECT OF ORDER
 I '($P(X,";",2)="DPT(") S HMRSLT="-1^Order DFN not found" Q  ; not a patient
 S HMDFN=+X I '$D(^HMP(800000,HMSRVR,1,HMDFN,0)) S HMRSLT="-1^DFN "_HMDFN_" not subscribed." Q  ; not subscribed
 ;
 ; If Order not in HMP sub-file then LAYGO it in
 I '$D(^HMP(800000,HMSRVR,1,HMDFN,1,HMORIFN,0)) D
 . N HMVALS,RSLT,VALS  ; protect the values in HMVALS
 . S VALS(.15)=$$NOW^XLFDT  ; Order Action Date/Time
 . D ADDORDR(.RSLT,.VALS,HMORIFN,HMDFN,HMORLVL)  ; DE3584 Jan 27, 2016
 ;
 S SUB="+1,"_HMORIFN_","_HMDFN_","_HMSRVR_","
 F J=.01,.02,.03,.04 S:$G(HMVALS(J))]"" HMFDA(800000.142,SUB,J)=HMVALS(J)
 D UPDATE^DIE("","HMFDA","HMIENS","FMSG") ; HMIENS coming back from call
 ;
 D  ; update date and time for lastUpdateTime in HMPSTMP
 . N HMVALS,RSLT,VALS  ; protect the values in HMVALS
 . S VALS(.15)=$$NOW^XLFDT  ; Order Action Date/Time
 . D UPDTORDR(.RSLT,.VALS,HMORIFN,HMDFN)
 ;
 S HMRSLT=$S($D(FMSG):"-^FM error in ADDFLAG",1:1)
 ;
 Q
 ;
ADDORDR(HMRSLT,HMVALS,HMORIFN,HMDFN,HMORLVL) ; LAYGO order into HMP SUBSCRIPTION file (#800000), sub-file 800000.14
 ; HMRSLT - return value passed-by-ref., 1 on success else "-1^error message"
 ;parameters below required
 ; HMVALS - array of values, subscripted by field #, passed-by-ref.
 ;   note: HMVALS(.01) not needed, it's the DINUM value below
 ; HMORIFN - Order IFN
 ; HMDFN - patient's DFN
 ; HMORLVL = ^OR(100,HMORIFN,8,level) OPTIONAL, used from within OE/RR
 ;
 S HMRSLT="-1^parameter missing"  ; initialize return
 Q:'($G(HMORIFN)>0)!'($G(HMDFN)>0)  ; must have Order IFN and DFN
 Q:'$O(HMVALS(0))  ; must have FileMan data array
 ;
 N A,FMSG,HMFDA,HMIENS,HMSRVR,J,L,SUB
 S HMSRVR=$$SRVRNO(HMDFN)  ; server number subscribed to
 I '(HMSRVR>0) S HMRSLT="-1^HMP server not found for DFN "_HMDFN Q  ; not subscribed
 I $D(^HMP(800000,HMSRVR,1,HMDFN,1,"B",HMORIFN)) S HMRSLT="-1^ORDER "_HMORIFN_" already tracked." Q  ; duplicate Order creation
 ;
 S HMIENS(1)=HMORIFN  ; new IEN assignment, DINUM relationship
 S SUB="+1,"_HMDFN_","_HMSRVR_","  ; IENS subscript
 S HMFDA(800000.14,SUB,.01)=HMORIFN
 ; loop below starts after .01 because of line above
 S J=.01 F  S J=$O(HMVALS(J)) Q:'J  S HMFDA(800000.14,SUB,J)=HMVALS(J)
 S HMFDA(800000.14,SUB,1.01)=$$NOW^XLFDT  ; (#1.01) TRACKING START, Jan 26, 2016 - DE3584
 D UPDATE^DIE("","HMFDA","HMIENS","FMSG")
 ; if duplicate IEN FileMan returns error
 S HMRSLT=$S($D(FMSG):"-1^FM error in ADDORDR",1:1)
 ;DE3584 Jan 27, 2016
 S L=+$G(HMORLVL)  ; if >zero then call is from OE/RR (OPTIONAL)
 S A=$P($G(HMORLVL),";",2)  ; second ; piece is FLAG/UNFLAG (OPTIONAL)
 ;
 ; Jan 27, 2016 - DE3584 begin
 D  ; add any flag/unflag activity
 . N RSLT,VALS,Y
 . S J=0 F  S J=$O(^OR(100,HMORIFN,8,J)) Q:'J  D
 ..  S Y=$G(^OR(100,HMORIFN,8,J,3))  ; flag/unflag actions
 ..  I $P(Y,U,3) D  ; always check for flag action first
 ...   I L=J,A="F" Q  ; call from OE/RR, Flag will be added there
 ...   ; (#33) DATE/TIME FLAGGED [3D] ^ (#34) FLAGGED BY [4P:200] ^(#35) REASON FOR FLAG [5F]
 ...   K RSLT,VALS S VALS(.01)=$P(Y,U,3),VALS(.02)="F",VALS(.03)=$P(Y,U,4),VALS(.04)=$P(Y,U,5)
 ...   D ADDFLAG(.RSLT,.VALS,HMORIFN,HMDFN)
 ..  I $P(Y,U,6) D  ; check for unflag action
 ...   ; (#36) DATE/TIME UNFLAGGED [6D] ^ (#37) UNFLAGGED BY [7P:200] ^ (#38) REASON FOR UNFLAG [8F]
 ...   I L=J,A="U" Q  ; call from OE/RR, Unflag will be added there
 ...   K RSLT,VALS S VALS(.01)=$P(Y,U,6),VALS(.02)="U",VALS(.03)=$P(Y,U,7),VALS(.04)=$P(Y,U,8)
 ...   D ADDFLAG(.RSLT,.VALS,HMORIFN,HMDFN)
 ; Jan 27, 2016 - DE3584 end
 Q
 ;
DELORDR(HMPDFN,HMIFN) ; delete entry in ORDERS sub-file
 ;
 N DA,DIK,SRVNM
 S SRVNM=$$SRVRNO(+$G(HMPDFN)) Q:'(SRVNM>0)  ; get server number, quit if not found
 S DIK="^HMP(800000,"_SRVNM_",1,"_(+$G(HMPDFN))_",1,"  ; needs server IEN and patient IEN
 S DA=+$G(HMIFN),DA(1)=+$G(HMPDFN),DA(2)=SRVNM
 D ^DIK
 Q
 ;
ORDRCHK(HMORIFN,HMDFN) ; Boolean function, does ORDER number HMPORIFN exist in ^HMP(800000) for patient HMDFN
 ; DE3504 - Jan 19, 2016
 N RSLT,SRVNM
 S RSLT=0  ; default to zero
 S SRVNM=$$SRVRNO(+$G(HMDFN)) Q:'(SRVNM>0) RSLT  ; server not found, return zero ; Jan 26, 2016 - DE3584
 S:$D(^HMP(800000,SRVNM,1,+$G(HMDFN),1,+$G(HMORIFN),0)) RSLT=1  ; order exists in ^HMP(800000)
 Q RSLT
 ;
ORDRVALS(HMFLDS,HMORIFN) ; map ORDER ACTIONS (#100.008) to ORDERS sub-file (#800000.14) Feb 1, 2016
 ; HMFLDS returned by reference
 ; HMORIFN order IFN (Required)
 ;
 N FLD,HMERR,HMIENS,HMORVALS,IEN,ORENTDT,SUBFL
 K HMFLDS  ; returned by reference
 I '($G(HMORIFN)>0) S HMFLDS("ERR")="ORDER IEN required in routine "_$T(+0) Q
 ;
 S HMIENS=(+HMORIFN)_","  ; IENS for Fileman
 S ORENTDT=$$GET1^DIQ(100,HMIENS,4,"I")  ; WHEN ENTERED, from ORDER file
 D GETS^DIQ(100,HMIENS,".8*","IN","HMORVALS","HMERR")  ; internal values, ignore null values
 I $D(HMERR) M HMFLDS("ERR")=HMERR Q  ; error returned from GETS^DIQ
 ; map HMFLDS (fields from ^OR(100)) to HMFLDS (fields in ^HMP(800000))
 S SUBFL=100.008,IEN=""
 S:ORENTDT HMFLDS(.02)=ORENTDT  ; value stored outside of sub-file
 F  S IEN=$O(HMORVALS(SUBFL,IEN)) Q:'IEN  D
 . S FLD=0 F  S FLD=$O(HMORVALS(SUBFL,IEN,FLD)) Q:'FLD  S Y=HMORVALS(SUBFL,IEN,FLD,"I") D
 .. S:FLD=5 HMFLDS(.03)=Y  ; signed by
 .. S:FLD=6 HMFLDS(.04)=Y  ; signed date/time
 .. S:FLD=8 HMFLDS(.05)=Y  ; verifying nurse
 .. S:FLD=9 HMFLDS(.06)=Y  ; nurse verify date/time
 .. S:FLD=10 HMFLDS(.07)=Y  ; verifying clerk
 .. S:FLD=11 HMFLDS(.08)=Y  ; clerk verify date/time
 .. S:FLD=18 HMFLDS(.09)=Y  ; reviewed by
 .. S:FLD=19 HMFLDS(.1)=Y  ; reviewed date/time
 .. S:FLD=17 HMFLDS(.11)=Y  ; released by
 .. S:FLD=16 HMFLDS(.12)=Y  ; released by date/time
 .. S:FLD=2 HMFLDS(.14)=Y  ; order action
 .. S:FLD=.01 HMFLDS(.15)=Y ; action date/time
 ;
 Q
 ;
SRVRNO(DFN4SRVR) ; function, return server number for patient DFN4SRVR, zero if not subscribed
 N SRVNM
 S SRVNM=$O(^HMP(800000,"AITEM",+$G(DFN4SRVR),""))  ; server name
 Q:SRVNM="" 0  ; patient not found
 Q +$O(^HMP(800000,"B",SRVNM,0))  ; server IEN or zero
 ;
UPDTORDR(HMRSLT,HMVALS,HMORIFN,HMDFN) ; update order in HMP SUBSCRIPTION file (#800000), sub-file 800000.14
 ; HMRSLT - return value passed-by-ref., 1 on success else "-1^error message"
 ;all 3 parameters below required
 ; HMORIFN - Order IFN
 ; HMDFN - patient's DFN
 ; HMVALS - array of values, subscripted by field #, passed-by-ref.
 ;   note: HMVALS(.01) not needed, it's the DINUM value below
 ;
 S HMRSLT="-1^parameter missing"  ; initialize return
 Q:'($G(HMORIFN)>0)!'($G(HMDFN)>0)  ; must have Order IFN and DFN
 Q:'$O(HMVALS(0))  ; must have FileMan data
 ;
 N FMSG,HMFDA,HMSRVR,J,SUB
 S HMSRVR=$$SRVRNO(HMDFN)  ; server number subscribed to
 I '(HMSRVR>0) S HMRSLT="-1^HMP server not found for DFN "_HMDFN Q  ; not subscribed
 I '$D(^HMP(800000,HMSRVR,1,HMDFN,1,"B",HMORIFN)) S HMRSLT="-1^ORDER "_HMORIFN_" not found." Q  ; Order must exist
 ;
 S SUB=HMORIFN_","_HMDFN_","_HMSRVR_","  ; IENS subscript
 ; loop below starts after .01 because order already exists
 S J=.01 F  S J=$O(HMVALS(J)) Q:'J  S HMFDA(800000.14,SUB,J)=HMVALS(J)
 D FILE^DIE("","HMFDA","FMSG")
 ; return minus 1 if FileMan returns error
 S HMRSLT=$S($D(FMSG):"-1^FM error in UPDTORDR",1:1)
 ;
 Q
 ;
