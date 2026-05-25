PXCOMPACTIB ;ALB/BPA,CMC - Routine for COMPACT Act API for Integrated Billing;05/01/2024@14:33
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**241**;Aug 12, 1996;Build 31
 ; Reference to ^SCE in ICR #2065
 ; Reference to ^DGPT in ICR #1372
 ; Reference to ^DGPM in ICR #419
 Q
 ;
REQUEST(FILENM,IEN) ;
 ;FILENM - FileMan File Number
 ;IEN - Reference in the file
 N ANS
 I $G(FILENM)="" S ANS="-1^Missing file number" Q ANS
 I $G(IEN)="" S ANS="-1^Missing IEN number" Q ANS
 ;
 I FILENM=409.68 D VSTCHK(IEN,.ANS)
 I FILENM=45 D PTFCHK(IEN,.ANS)
 I FILENM=405 D PTMVMT(IEN,.ANS)
 ;
 I FILENM=9000010,$D(^PXCOMP(818,"COMPACTVISIT",IEN)) S ANS=1
 ;
 I ANS'=1 S ANS=0
 Q ANS
 ;
VSTCHK(IEN,ANS) ;
 N VSTIEN
 S VSTIEN="",ANS=0 ;Default value of 0 for No
 I '$D(^SCE(IEN,0)) Q
 S VSTIEN=$P(^SCE(IEN,0),U,5)
 I VSTIEN="" Q
 ;This index will be valued if the visit is Y, VISIT related to COMPACT Act
 I $D(^PXCOMP(818,"COMPACTVISIT",VSTIEN)) S ANS=1
 Q
 ;
PTFCHK(IEN,ANS) ;
 S ANS=0 ;Default value of 0 for No
 I '$D(^DGPT(IEN)) Q
 ;Check the 33rd piece of the 70 node in the PTF file (TRT FOR ACUTE SUICIDAL CRISIS) for ANS value
 I $D(^PXCOMP(818,"PTF",IEN)),$D(^DGPT(IEN,70)) S ANS=$P(^DGPT(IEN,70),U,33)
 Q
 ;
PTMVMT(IEN,ANS) ;
 N PTFIEN
 S PTFIEN="",ANS=0 ;Default value of 0 for No
 I '$D(^DGPM(IEN)) Q
 ;Look for piece 27 of the zero level for visit IEN
 I $P(^DGPM(IEN,0),U,27)'="" D
 . I $D(^PXCOMP(818,"COMPACTVISIT",$P(^DGPM(IEN,0),U,27))) S ANS=1
 E  D
 . ;Look for the PTF value in piece 16 of the zero level of the patient movement file
 . I $P(^DGPM(IEN,0),U,16)'="" D
 . . I $D(^DGPT($P(^DGPM(IEN,0),U,16),70)) S ANS=$P(^DGPT($P(^DGPM(IEN,0),U,16),70),U,33)
 . E  D
 . . ;Look for the parent patient movement record that points to the PTF record
 . . I $P(^DGPM(IEN,0),U,14)'="" S PTFIEN=$P(^DGPM($P(^DGPM(IEN,0),U,14),0),U,16)
 . . I $G(PTFIEN)'="",$D(^DGPT(PTFIEN,70)) S ANS=$P(^DGPT(PTFIEN,70),U,33)
 Q
 ;
