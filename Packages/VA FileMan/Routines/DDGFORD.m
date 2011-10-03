DDGFORD ;SFISC/MKO-REORDER THE FIELDS ON BLOCK ;07:13 AM  25 May 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;In: DDGFBK   = Block number
 ;    DDGFPG   = Page number
 ;    DDGFFM   = Form number^Form name
 ;    DDGFREF  = Global reference
 ;
EN(DDGFBK) ;
 N DDO,DA,DIK
 N DDGFLN,DDGFLIST,DDGFR,DDGFC,DDGFN,DDGFO
 ;
 D MSG^DDGF("Reordering ...")
 ;Loop through all fields in DDGFREF and put into DDGFLIST array
 S DDO="" F  S DDO=$O(@DDGFREF@("F",DDGFPG,DDGFBK,DDO)) Q:DDO=""  D
 . S DDGFLN=@DDGFREF@("F",DDGFPG,DDGFBK,DDO)
 . I $P(DDGFLN,U,8)>0 S DDGFLIST(+$P(DDGFLN,U,5),+$P(DDGFLN,U,6),DDO)=""
 . E  I $P(DDGFLN,U,4)]"" S DDGFLIST(+$P(DDGFLN,U),+$P(DDGFLN,U,2),DDO)=""
 ;
 K ^DIST(.404,DDGFBK,40,"B")
 S DDGFN=0
 S DDGFR="" F  S DDGFR=$O(DDGFLIST(DDGFR)) Q:DDGFR=""  D
 . S DDGFC="" F  S DDGFC=$O(DDGFLIST(DDGFR,DDGFC)) Q:DDGFC=""  D
 .. S DDO="" F  S DDO=$O(DDGFLIST(DDGFR,DDGFC,DDO)) Q:DDO=""  D
 ... S DDGFN=DDGFN+1
 ... S DDGFO=$P(^DIST(.404,DDGFBK,40,DDO,0),U)
 ... S:DDGFO'=DDGFN $P(^DIST(.404,DDGFBK,40,DDO,0),U)=DDGFN
 ;
 S DIK="^DIST(.404,DDGFBK,40,",DA(1)=DDGFBK,DIK(1)=".01^B"
 D ENALL^DIK
 D MSG^DDGF("Reordering completed.") H 1
 D MSG^DDGF()
 Q
