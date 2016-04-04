DDUCHK5 ;SFISC/MKO-CHECK KEYS ON FILE ;8/8/03  06:26
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;*130*
 ;
KEY(DDUCFI,DDUCFIX) ;Check and optionally fix structure of Key file entry
 N DDUCKEY
 Q:'$G(DDUCFI)  S DDUCFIX=$G(DDUCFIX)
 ;
 ;Loop through "B" index to find KEYs that reside on this file
 D WCHK
 S DDUCKEY=""
 F  S DDUCKEY=$O(^DD("KEY","B",DDUCFI,DDUCKEY)) Q:DDUCKEY=""  D CHKKEY
 ;
 ;Check "AP","BB", and "F" indexes
 D CHKAP,CHKBB,CHKF
 Q
 ;
CHKKEY ;Check Key DDUCKEY found in "B" index
 ;In:
 ; DDUCKEY  = Key #
 ; DDUCFI   = File #
 ; DDUCFIX  = Flag to fix
 N DDUCIEN,DDUCKEY0,DDUCKID,DDUCNM,DDUCUI
 S DDUCKID=$$KEYID(DDUCKEY,"")
 ;
 ;Check that Key exists
 I '$D(^DD("KEY",DDUCKEY)) D  Q
 . D WNOKEY
 . D:DDUCFIX KILL($NA(^DD("KEY","B",DDUCFI,DDUCKEY)))
 ;
 ;Check that Key has a FILE
 S DDUCKEY0=$G(^DD("KEY",DDUCKEY,0))
 I $P(DDUCKEY0,U)="" D
 . D WMS("FILE (#.01) for "_DDUCKID)
 . D:DDUCFIX FFILE
 ;
 ;Get Name
 S DDUCNM=$P(DDUCKEY0,U,2)
 I DDUCNM]"" S DDUCKID=$$KEYID(DDUCKEY,DDUCNM)
 E  D WMS("NAME for "_DDUCKID)
 ;
 ;Check Priority
 S DDUCPRI=$P(DDUCKEY0,U,3)
 D:DDUCPRI="" WMS("PRIORITY for "_DDUCKID)
 ;
 ;Check Uniqueness Index
 S DDUCUI=$P(DDUCKEY0,U,4)
 I 'DDUCUI D
 . D WMS("Uniqueness Index for "_DDUCKID,1)
 E  D
 . I '$D(^DD("IX",DDUCUI,0)) D  Q
 .. D WMS("Dangling pointer. Uniqueness Index #"_DDUCUI_" pointed to by "_DDUCKID,1)
 . D GETFLD^DIKKUTL2(DDUCKEY,DDUCUI,.DDUCKFLD,.DDUCUFLD)
 . D:'$$GCMP^DIKCU2("DDUCKFLD","DDUCUFLD") WNE
 ;
 ;Check Field multiple
 S DDUCIEN=0
 F  S DDUCIEN=$O(^DD("KEY",DDUCKEY,2,DDUCIEN)) Q:'DDUCIEN  D FLD
 ;
 ;Reindex Key file entry
 I DDUCFIX D
 . N DIC,DIK,DA,X
 . S DIK="^DD(""KEY"",",DA=DDUCKEY
 . D IX^DIK
 Q
 ;
FLD ;Check a Cross-Reference Value
 ;In:
 ; DDUCKEY = Key #
 ; DDUCIEN = IEN in FIELD multiple
 ; DDUCFIX = Flag to fix
 ; DDUCKID = String that identifies Key
 ; DDUCUI  = Uniqueness index #
 N DDUCFIL,DDUCFLD,DDUCFLD0,DDUCKFLD,DDUCSEQ,DDUCUFLD
 ;
 S DDUCFLD0=$G(^DD("KEY",DDUCKEY,2,DDUCIEN,0))
 S DDUCFLD=$P(DDUCFLD0,U),DDUCFIL=$P(DDUCFLD0,U,2)
 S DDUCSEQ=$P(DDUCFLD0,U,3)
 ;
 ;Check that field, file, and sequence are filled in
 D:'DDUCFLD!'DDUCFIL!'DDUCSEQ WINC
 ;
 ;Make sure file/field exists and is in the "F" index
 I DDUCFLD,DDUCFIL D
 . D:$D(^DD(DDUCFIL,DDUCFLD,0))[0 WFMS
 . I $D(^DD("KEY","F",DDUCFIL,DDUCFLD,DDUCKEY,DDUCIEN))[0 S DDUCGL=$NA(^(DDUCIEN)) D
 .. D WMS(DDUCGL)
 .. D:DDUCFIX SET(DDUCGL)
 Q
 ;
CHKAP ;Check "AP" index (In: DDUCFI = file; DDUCFIX = flag to fix)
 N DDUCGL,DDUCKEY,DDUCKEY0,DDUCPRI,DDUCPRIL
 ;
 S DDUCPRI=""
 F  S DDUCPRI=$O(^DD("KEY","AP",DDUCFI,DDUCPRI)) Q:DDUCPRI=""  D
 . S DDUCKEY=0
 . F  S DDUCKEY=$O(^DD("KEY","AP",DDUCFI,DDUCPRI,DDUCKEY)) Q:'DDUCKEY  D
 .. S DDUCKEY0=$G(^DD("KEY",DDUCKEY,0))
 .. I $D(^DD("KEY",DDUCKEY)),$P(DDUCKEY0,U,3)="" S DDUCPRIL(DDUCKEY,DDUCPRI)=""
 .. E  I $P(DDUCKEY0,U)'=DDUCFI!($P(DDUCKEY0,U,3)'=DDUCPRI) D
 ... S DDUCGL=$NA(^DD("KEY","AP",DDUCFI,DDUCPRI,DDUCKEY))
 ... D WEN(DDUCGL)
 ... D:DDUCFIX KILL(DDUCGL)
 ;
 ;If any of the Keys have null Priorities, check whether a single
 ;priority for it was found in the "AP" index.
 I $D(DDUCPRIL) S DDUCKEY=0 F  S DDUCKEY=$O(DDUCPRIL(DDUCKEY)) Q:'DDUCKEY  D
 . S DDUCPRI=$O(DDUCPRIL(DDUCKEY,""))
 . I $O(DDUCPRIL(DDUCKEY,DDUCPRI))="" D
 .. S DDUCKID=$$KEYID(DDUCKEY)
 .. D WPRI
 .. D:DDUCFIX FPRI
 . E  F  D  S DDUCPRI=$O(DDUCPRIL(DDUCKEY,DDUCPRI)) Q:DDUCPRI=""
 .. S DDUCGL=$NA(^DD("KEY","AP",DDUCFI,DDUCPRI,DDUCKEY))
 .. D WEN(DDUCGL)
 .. D:DDUCFIX KILL(DDUCGL)
 Q
 ;
CHKBB ;Check "BB" index (In: DDUCFI = file; DDUCFIX = flag to fix)
 N DDUCGL,DDUCKEY,DDUCKEY0,DDUCKID,DDUCNM,DDUCNML
 S DDUCNM=""
 F  S DDUCNM=$O(^DD("KEY","BB",DDUCFI,DDUCNM)) Q:DDUCNM=""  D
 . S DDUCKEY=0
 . F DDUCKEY=$O(^DD("KEY","BB",DDUCFI,DDUCNM,DDUCKEY)) Q:'DDUCKEY  D
 .. S DDUCKEY0=$G(^DD("KEY",DDUCKEY,0))
 .. I $D(^DD("KEY",DDUCKEY)),$P(DDUCKEY0,U,2)="" S DDUCNML(DDUCKEY,DDUCNM)=""
 .. E  I $P(DDUCKEY0,U)'=DDUCFI!($P(DDUCKEY0,U,2)'=DDUCNM) D
 ... S DDUCGL=$NA(^DD("KEY","BB",DDUCFI,DDUCNM,DDUCKEY))
 ... D WEN(DDUCGL)
 ... D:DDUCFIX KILL(DDUCGL)
 ;
 ;If any of the Keys have null Names, check whether a single name
 ;for it was found in the "BB" index.
 I $D(DDUCNML) S DDUCKEY=0 F  S DDUCKEY=$O(DDUCNML(DDUCKEY)) Q:'DDUCKEY  D
 . S DDUCNM=$O(DDUCNML(DDUCKEY,""))
 . I $O(DDUCNML(DDUCKEY,DDUCNM))="" D
 .. S DDUCKID=$$KEYID(DDUCKEY,"")
 .. D WNM
 .. D:DDUCFIX FNM
 . E  F  D  S DDUCNM=$O(DDUCNML(DDUCKEY,DDUCNM)) Q:DDUCNM=""
 .. S DDUCGL=$NA(^DD("KEY","BB",DDUCFI,DDUCNM,DDUCKEY))
 .. D WEN(DDUCGL)
 .. D:DDUCFIX KILL(DDUCGL)
 Q
 ;
CHKF ;Check "F" index (In: DDUCFI = file; DDUCFIX = flag to fix)
 N DDUCFLD,DDUCGL,DDUCKEY,DDUCIEN
 S DDUCFLD=0
 F  S DDUCFLD=$O(^DD("KEY","F",DDUCFI,DDUCFLD)) Q:'DDUCFLD  D
 . S DDUCKEY=0
 . F  S DDUCKEY=$O(^DD("KEY","F",DDUCFI,DDUCFLD,DDUCKEY)) Q:'DDUCKEY  D
 .. S DDUCIEN=0
 .. F  S DDUCIEN=$O(^DD("KEY","F",DDUCFI,DDUCFLD,DDUCKEY,DDUCIEN)) Q:'DDUCIEN  D
 ... I $P($G(^DD("KEY",DDUCKEY,2,DDUCIEN,0)),U,2)'=DDUCFI!($P($G(^(0)),U)'=DDUCFLD) D
 .... S DDUCGL=$NA(^DD("KEY","F",DDUCFI,DDUCFLD,DDUCKEY,DDUCIEN))
 .... D WEN(DDUCGL)
 .... D:DDUCFIX KILL(DDUCGL)
 Q
 ;
 ;---------------
FFILE ;Set the .01 of Key to DDUCFI
 S $P(^DD("KEY",DDUCKEY,0),U)=DDUCFI
 D WRITE("FILE (#.01) for "_DDUCKID_" set to "_DDUCFI_".",10)
 Q
 ;
FNM ;Set the NAME for the Key
 S $P(^DD("KEY",DDUCKEY,0),U,2)=DDUCNM
 D WRITE("NAME for "_DDUCKID_" set to '"_DDUCNM_"'.",10)
 Q
 ;
FPRI ;Set the PRIORITY for the Key
 S $P(^DD("KEY",DDUCKEY,0),U,3)=DDUCPRI
 D WRITE("PRIORITY for "_DDUCKID_" set to '"_DDUCPRI_"'.",10)
 Q
 ;
KILL(GL) ;Kill a global and print a message
 Q:'$D(@GL)
 K @GL
 W !?10,GL_" was killed."
 Q
 ;
SET(GL,VAL) ;Set a global and print a message
 Q:$D(@GL)
 S VAL=$G(VAL),@GL=VAL
 W !?10,GL_" was set"_$S(VAL]"":" to "_VAL,1:"")_"."
 Q
 ;
 ;Write messages
WCHK Q  ;D WRITE("Checking Keys.",5) Q
WNOKEY D WRITE(DDUCKID_" does not exist.",7) Q
WMS(S,N) D WRITE(S_" is missing."_$S($G(N):" Nothing done.",1:""),7) Q
WINC D WRITE("Field information in "_DDUCKEY_" is incomplete. Nothing done.",7) Q
WFMS D WRITE("*File #"_DDUCFIL_", Field #"_DDUCFLD_" referenced in "_DDUCKEY_" is missing.",7) Q  ;22*130
WNE D WRITE("*Fields in "_DDUCKID_" don't match fields in Uniqueness Index.",7) Q  ;22*130
WEN(GL) D WRITE("Erroneous node "_GL_" is set.",7) Q
WNM D WRITE("NAME for "_DDUCKID_" looks like it should be '"_DDUCNM_"'.",7) Q
WPRI D WRITE("PRIORITY for "_DDUCKID_" looks like it should be '"_DDUCPRI_"'.",7) Q
 ;
WRITE(TXT,TAB) ;Write text, wrap at word boundaries.
 N I
 D WRAP^DIKCU2(.TXT,-TAB-2,-TAB)
 W !?TAB,$G(TXT,$G(TXT(0))) F I=1:1 Q:'$D(TXT(I))  W !?TAB+2,TXT(I)
 Q
 ;
KEYID(KEY,NM) ;Return string that identifies a Key
 S:'$D(NM) NM=$P($G(^DD("KEY",KEY,0)),U,2)
 Q $S(NM]"":"Key '"_NM_"' (#"_KEY_")",1:"Key #"_KEY)
