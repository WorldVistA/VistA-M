DDUCHK4 ;SFISC/MKO-CHECK INDEXES ON FILE ;6:36 AM  28 Dec 2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;*130*
 ;
INDEX(DDUCFI,DDUCFIX) ;Check and optionally fix structure of Index file entry
 N DDUCIX
 Q:'$G(DDUCFI)  S DDUCFIX=$G(DDUCFIX)
 ;
 ;Loop through "B" index to find INDEXes that reside on this file
 D WCHK
 S DDUCIX=""
 F  S DDUCIX=$O(^DD("IX","B",DDUCFI,DDUCIX)) Q:DDUCIX=""  D CHKIX
 ;
 ;Check "AC","BB", and "F" indexes
 D CHKAC,CHKBB,CHKF
 Q
 ;
CHKIX ;Check Index DDUCIX found in "B" index
 ;In:
 ; DDUCIX  = index #
 ; DDUCFI  = file #
 ; DDUCFIX = flag to fix
 N DDUCIX0,DDUCIXID,DDUCNM,DDUCRF,DDUCRV
 S DDUCIXID=$$IXID(DDUCIX,"")
 ;
 ;Check that Index exists
 I '$D(^DD("IX",DDUCIX)) D  Q
 . D WNOIX
 . D:DDUCFIX KILL($NA(^DD("IX","B",DDUCFI,DDUCIX)))
 ;
 ;Check that index has a FILE
 S DDUCIX0=$G(^DD("IX",DDUCIX,0))
 I $P(DDUCIX0,U)="" D
 . D WMS("FILE (#.01) for "_DDUCIXID)
 . D:DDUCFIX FFILE
 ;
 ;Get Name
 S DDUCNM=$P(DDUCIX0,U,2)
 I DDUCNM]"" S DDUCIXID=$$IXID(DDUCIX,DDUCNM)
 E  D WMS("NAME for "_DDUCIXID)
 ;
 ;Check Root File not null, and "AC" index exists
 S DDUCRF=$P(DDUCIX0,U,9)
 I 'DDUCRF D
 . D WMS("ROOT FILE for "_DDUCIXID)
 . D:DDUCFIX FRF
 ;
 ;Check Cross-Reference Values multiple
 S DDUCRV=0
 F  S DDUCRV=$O(^DD("IX",DDUCIX,11.1,DDUCRV)) Q:'DDUCRV  D CRV
 ;
 ;Reindex Index file entry
 I DDUCFIX D
 . N DIC,DIK,DA,X
 . S DIK="^DD(""IX"",",DA=DDUCIX
 . D IX^DIK
 Q
 ;
CRV ;Check a Cross-Reference Value
 ;In:
 ; DDUCIX   = Index #
 ; DDUCRV   = CRV #
 ; DDUCFIX  = Flag to fix
 ; DDUCRF   = Root file #
 ; DDUCIXID = String that identifies Index
 N DDUCFIL,DDUCFLD,DDUCGL,DDUCOID,DDUCORD,DDUCRV0
 ;
 S DDUCRV0=$G(^DD("IX",DDUCIX,11.1,DDUCRV,0))
 Q:$P(DDUCRV0,U,2)="C"
 S DDUCORD=$P(DDUCRV0,U),DDUCFIL=$P(DDUCRV0,U,3),DDUCFLD=$P(DDUCRV0,U,4)
 ;
 ;Check .01 of CRV
 I DDUCORD="" D
 . D WMS("ORDER NUMBER of Cross-Reference Value #"_DDUCRV_" of "_DDUCIXID)
 . D:DDUCFIX FON
 S DDUCOID=$$OID(DDUCORD,"","",DDUCIXID)
 ;
 ;Make sure FILE is not null
 I 'DDUCFIL D
 . D WMS("FILE for "_DDUCOID,1)
 ;
 ;If there's a File, make sure it is equal to Root File
 ;and that referenced field exists.
 E  D
 . D:DDUCFIL'=DDUCRF WNE
 . D:$D(^DD(DDUCFIL,DDUCFLD,0))[0 WFMS
 . I $D(^DD("IX","F",DDUCFIL,DDUCFLD,DDUCIX,DDUCRV))[0 S DDUCGL=$NA(^(DDUCRV)) D
 .. D WMS(DDUCGL)
 .. D:DDUCFIX SET(DDUCGL)
 Q
 ;
CHKAC ;Check "AC index (In: DDUCFI = file; DDUCFIX = flag to fix)
 N DDUCGL,DDUCIX
 S DDUCIX=0 F  S DDUCIX=$O(^DD("IX","AC",DDUCFI,DDUCIX)) Q:'DDUCIX  D
 . I $P($G(^DD("IX",DDUCIX,0)),U,9)]"",$P(^(0),U,9)'=DDUCFI D
 .. S DDUCGL=$NA(^DD("IX","AC",DDUCFI,DDUCIX))
 .. D WEN(DDUCGL)
 .. D:DDUCFIX KILL(DDUCGL)
 Q
 ;
CHKBB ;Check "BB" index (In: DDUCFI = file; DDUCFIX = flag to fix)
 N DDUCGL,DDUCIX,DDUCIX0,DDUCIXID,DDUCNM,DDUCNML
 S DDUCNM=""
 F  S DDUCNM=$O(^DD("IX","BB",DDUCFI,DDUCNM)) Q:DDUCNM=""  D
 . S DDUCIX=0
 . F DDUCIX=$O(^DD("IX","BB",DDUCFI,DDUCNM,DDUCIX)) Q:'DDUCIX  D
 .. S DDUCIX0=$G(^DD("IX",DDUCIX,0))
 .. I $D(^DD("IX",DDUCIX)),$P(DDUCIX0,U,2)="" S DDUCNML(DDUCIX,DDUCNM)=""
 .. E  I $P(DDUCIX0,U)'=DDUCFI!($P(DDUCIX0,U,2)'=DDUCNM) D
 ... S DDUCGL=$NA(^DD("IX","BB",DDUCFI,DDUCNM,DDUCIX))
 ... D WEN(DDUCGL)
 ... D:DDUCFIX KILL(DDUCGL)
 ;
 ;If any of the Indexes have null Names, check whether a single name
 ;for it was found in the "BB" index.
 I $D(DDUCNML) S DDUCIX=0 F  S DDUCIX=$O(DDUCNML(DDUCIX)) Q:'DDUCIX  D
 . S DDUCNM=$O(DDUCNML(DDUCIX,""))
 . I $O(DDUCNML(DDUCIX,DDUCNM))="" D
 .. S DDUCIXID=$$IXID(DDUCIX,"")
 .. D WNM
 .. D:DDUCFIX FNM
 . E  F  D  S DDUCNM=$O(DDUCNML(DDUCIX,DDUCNM)) Q:DDUCNM=""
 .. S DDUCGL=$NA(^DD("IX","BB",DDUCFI,DDUCNM,DDUCIX))
 .. D WEN(DDUCGL)
 .. D:DDUCFIX KILL(DDUCGL)
 Q
 ;
CHKF ;Check "F" index (In: DDUCFI = file; DDUCFIX = flag to fix)
 N DDUCFLD,DDUCGL,DDUCIX,DDUCRV
 S DDUCFLD=0
 F  S DDUCFLD=$O(^DD("IX","F",DDUCFI,DDUCFLD)) Q:'DDUCFLD  D
 . S DDUCIX=0
 . F  S DDUCIX=$O(^DD("IX","F",DDUCFI,DDUCFLD,DDUCIX)) Q:'DDUCIX  D
 .. S DDUCRV=0
 .. F  S DDUCRV=$O(^DD("IX","F",DDUCFI,DDUCFLD,DDUCIX,DDUCRV)) Q:'DDUCRV  D
 ... I $P($G(^DD("IX",DDUCIX,11.1,DDUCRV,0)),U,3)'=DDUCFI!($P($G(^(0)),U,4)'=DDUCFLD) D
 .... S DDUCGL=$NA(^DD("IX","F",DDUCFI,DDUCFLD,DDUCIX,DDUCRV))
 .... D WEN(DDUCGL)
 .... D:DDUCFIX KILL(DDUCGL)
 Q
 ;
 ;---------------
FFILE ;Set the .01 of index to DDUCFI
 S $P(^DD("IX",DDUCIX,0),U)=DDUCFI
 D WRITE("FILE (#.01) for "_DDUCIXID_" set to "_DDUCFI_".",10)
 Q
 ;
FRF ;Set Root File equal to File and Root Type to 'INDEX FILE'
 S $P(^DD("IX",DDUCIX,0),U,8)="I"
 S $P(^DD("IX",DDUCIX,0),U,9)=DDUCFI
 S DDUCRF=DDUCFI
 D WRITE("ROOT FILE for "_DDUCIXID_" set to "_DDUCFI_".",10)
 D WRITE("ROOT TYPE for "_DDUCIXID_" set to 'INDEX FILE'.",10)
 Q
 ;
FON ;Determine Order Number
 N DDUCI,DDUCO
 ;
 ;Look for Order Number in "B" index
 S DDUCORD=0
 F  S DDUCORD=$O(^DD("IX",DDUCIX,11.1,"B",DDUCORD)) Q:'DDUCORD  Q:$O(^DD("IX",DDUCIX,11.1,"B",DDUCORD,0))=DDUCRV
 ;
 ;If not found, just pick an unused Order Number
 I 'DDUCORD D
 . S DDUCI=0
 . F  S DDUCI=$O(^DD("IX",DDUCIX,11.1,DDUCI)) Q:'DDUCI  S:$P($G(^(DDUCI,0)),U)]"" DDUCO($P(^(0),U))=""
 . S DDUCORD=$O(DDUCO(""),-1)
 . S:'DDUCORD DDUCORD=1
 ;
 S $P(^DD("IX",DDUCIX,11.1,DDUCRV,0),U)=DDUCORD
 D WRITE("ORDER NUMBER for Cross-Reference Value #"_DDUCRV_" of "_DDUCIXID_" set to "_DDUCORD_".",10)
 Q
 ;
FNM ;Set the NAME for the Index
 S $P(^DD("IX",DDUCIX,0),U,2)=DDUCNM
 D WRITE("NAME for "_DDUCIXID_" set to '"_DDUCNM_"'.",10)
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
WCHK Q  ;D WRITE("Checking Indexes.",5) Q
WNOIX D WRITE(DDUCIXID_" does not exist.",7) Q
WMS(S,N) D WRITE("*"_S_" is missing."_$S($G(N):" ",1:""),7) Q
WNE D WRITE("*FILE does not equal ROOT FILE in "_DDUCOID_".",7) Q  ;22*130
WFMS D WRITE("*File/Sub-file #"_$S($G(FIL)'="":FIL,1:DDUCFIL)_", Field #"_$S($G(FLD)'="":FLD,1:DDUCFLD)_" referenced in "_DDUCOID_" is missing.",7) Q  ;22*130
WEN(GL) D WRITE("Erroneous node "_GL_" is set.",7) Q
WNM D WRITE("NAME for "_DDUCIXID_" looks like it should be '"_DDUCNM_"'.",7) Q
 ;
WRITE(TXT,TAB) ;Write text, wrap at word boundaries.
 N I
 D WRAP^DIKCU2(.TXT,-TAB-2,-TAB)
 W !?TAB,$G(TXT,$G(TXT(0))) F I=1:1 Q:'$D(TXT(I))  W !?TAB+2,TXT(I)
 Q
 ;
IXID(IX,NM) ;Return string that identifies an Index
 S:'$D(NM) NM=$P($G(^DD("IX",IX,0)),U,2)
 Q $S(NM]"":"'"_NM_"' Index (#"_IX_")",1:"Index #"_IX)
 ;
OID(ORD,IX,NM,IXID) ;Return string that identifies Cross-Reference Value
 I '$D(IXID),$G(IX) S IXID=$S($D(NM)#2:$$IXID(IX,NM),1:$$IXID(IX))
 Q "Order #"_ORD_" of "_$S($G(IXID)]"":IXID,1:"")
