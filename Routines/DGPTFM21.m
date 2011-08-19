DGPTFM21 ;ALB/DWS - MASTER PROFESSIONAL SERVICE ENTER/EDIT(CONT.) ;5/24/05 1:04pm
 ;;5.3;Registration;**635**;Aug 13, 1993
GETINFO ;GET PROCEDURE CODE INFORMATION
 N NOKILL,EXITFLAG,DGNIEN
 S NOKILL=1,EXITFLG=0,ERRFLG=0,DGDIAG=0
 D ICDINFO^DGAPI(DFN,PTF)  ;gather all DGN codes for the patient
 D XREF S DIE="^DGCPT(46,"
 D SDR,FMDIE^DGPTFM2  ;prompt for CPT Code and modifiers
 I $D(Y)>9 S DUOUT=1 Q
 I $G(ERRFLG)=1 Q  ;cannot lock REC in DGCPT - exit
 S DGDIAG=1
 S DR="" F PIECE=4:1:7,21:1:24 S:PIECE=24 NOKILL=0 D  Q:EXITFLG!$D(DUOUT)  ;Go thru all existing DGN's in DGCPT file
 . S DIE="^DGCPT(46," D SDR2(PIECE),FMDIE^DGPTFM2 I $D(Y)>9 S DUOUT=1 Q
 . I ('$$CHKDGNS(DA,PIECE))!($D(Y)>9)!($D(DTOUT)) S EXITFLG=1 Q  ;Promt w/existing DGN cd if it exists
 . S DR="",SAVDA=DA,DGNIEN=$P(^DGCPT(46,DA,0),U,$S(PIECE<20:PIECE,1:PIECE-6)) Q:DGNIEN=""
 . I '$D(XREF(DGNIEN)) D  ;the IEN to be added has not yet been defined in DGICD9, it must be added before proceeding
 . . K DO S DIC="^DGICD9(46.1,",DIC(0)="LMZ",DLAYGO=46,X=DGNIEN
 . . D FILE^DICN Q:$D(DUOUT)  I Y<0 S ERRFLG=1
 . . I 'ERRFLG S XREF(DGNIEN)=+Y ; setup info to build "B" xref in DGICD9 for new entry
 . I ERRFLG S EXITFLG=1 Q  ;could not add new DGN ien to DGICD9 - exit loop with error
 . D SCI(DGNIEN):0 S UPDTD=0,(DA,REC)=XREF(DGNIEN) ;determine if any SCI prompts should be done for this DGN
 . K ^TMP("PTF",$J)  ;Clean up TMP file to pass info to be filed in 46.1
 . S DIE="^DGICD9(46.1,",DR="[DG801]"  ;SCI flags to be stored in file 46.1
 . ;prompt for SCI y/n and file in 46.1
 . I DR'="" D FMDIE^DGPTFM2 S DR="",UPDTD=1 I $D(Y)>9 S DUOUT=1 Q
 . I 'UPDTD D
 . . S ^TMP("PTF",$J,46.1,1)="^"_DGNIEN
 . . S X=$$DATA2PTF^DGAPI(DFN,PTF,DGPRD) ;If there were no SCI's prompts, stuff DGN into file 46.1
 . S DA=SAVDA
 K DIR,REC
 Q  ;GETINFO
XREF ;create xref for ^TMP global containing DGICD9 info to have access via DGN IEN in local array XREF
 N SEQ,NODE,INFO,IEN
 K XREF
 S SEQ=0
 F  S SEQ=$O(^TMP("PTF",$J,46.1,SEQ)) Q:'SEQ  S INFO=^(SEQ),NODE=+INFO,IEN=$P(INFO,U,2),XREF(IEN)=NODE
 Q  ;XREF
SDR ;SET DR ARRAY CPT MODIFIERS 1 AND 2
 S DR=DR_"S:'$$CODM^ICPTCOD($P(^DGCPT(46,D0,0),U),,,+DGZPRF(DGZP)) Y=""@10"";"
 S DR=DR_".02;S:$P(^DGCPT(46,D0,0),U,2,3)?.""^"" Y=""@10"";.03;@10;.2//1;"
 Q  ;Exit SDR
SDR2(DGN)       ;Set up DR variable to prompt for DGN Codes
 S DR=DGN/100_";"
 Q  ;Exit SDR2
CHKDGNS(D0,DGNPC)       ;Check to see if there are any more DGN's to edit in a Professional service instance
 S MORE=1 ; Default - more DGN's to process
 I DGNPC=4 S:$P(^DGCPT(46,D0,0),U,4,7)?."^" MORE=0
 I DGNPC=5 S:$P(^DGCPT(46,D0,0),U,5,7)?."^" MORE=0
 I DGNPC=6 S:$P(^DGCPT(46,D0,0),U,6,7)?."^" MORE=0
 I DGNPC=7 S:$P(^DGCPT(46,D0,0),U,7)_$P(^DGCPT(46,D0,0),U,15,18)?."^" MORE=0
 I DGNPC=21 S:$P(^DGCPT(46,D0,0),U,15,18)?."^" MORE=0
 I DGNPC=22 S:$P(^DGCPT(46,D0,0),U,16,18)?."^" MORE=0
 I DGNPC=23 S:$P(^DGCPT(46,D0,0),U,17,18)?."^" MORE=0
 I DGNPC=24 S:$P(^DGCPT(46,D0,0),U,18)?."^" MORE=0
 Q MORE  ;exit w/flag
SCI(IEN)    Q:'$D(SDCLY)  ;Pass the ien of the DGN code being processed
 N NODE,I,SCINUM
 F I=2,8,3:1:7 D  ;Go thru the SCI's
 . S SCINUM=$S(I=2:I+1,((I=3)!(I=4)):I-2,1:I-1)
 . I $G(SDCLY(SCINUM,IEN))=1 Q  ;If the SCI has already been asked for the DGN (ien) don't ask again
 . S:I=6 DR=DR_"@30;"
 . I $D(SDCLY(SCINUM)) S DR=DR_(I/100)_";",(DA,D)=$G(XREF(IEN)),SDCLY(SCINUM,IEN)=1 D:I=2&$O(SDCLY(1))!$D(SDCLY(1))!$D(SDCLY(2))  ;add prompt for SCI Y/N
 . . I I<6 S DR=DR_"S:$P(^DGICD9(46.1,DA,0),U,2) Y=""@30"";"
 K I
 Q  ;SCI
