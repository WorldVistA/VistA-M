MAGGTLB1 ;WOIFO/LB - RPC routine for Imaging Lab Interface ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;**59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;This routine is called from the Laboratory Image capture window.
 ;After an image is captured and an entry is created in file 2005,
 ;this routine will be called to set the imaging pointers in the 
 ;corresponding Lab subfile (Autopsy/ Organism, Surgical Path, EM,
 ;or Cytology) and update the imaging file with the corresponding
 ;Lab pointers. 
FILE(MAGRY,IMIEN,DATA) ;RPC Call to file pointers in Lab and Image files.
 ;IMIEN - ^MAG(2005,IMIEN image captured.
 ;DATA - piece 1 = stain             piece 2 = micro obj
 ;             3 = Pt name                 4 = ssn
 ;             5 = date/time               6 = acc#
 ;             7 = Pathologist             8 = specimen desc.
 ;             9 = lab section            10 = dfn
 ;            11 = lrdfn                  12 = lri
 ;            13 = spec ien               14 = field#
 ;            15 = global root e.g. ^LR(1,"SP",7069758,1,1
 ;DATA is the result of START^MAGGTLB (the specimen variable during the
 ;image capture window).
 ;Will return a single value on filing success. 
 ;
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 ;
 N ANUM,DA,DA1,DAS,DFN,DIERR,FIELD,I,IMOBJ,LABD,LABFDA,LABIEN,LABIENS
 N LRDFN,LRI,MAGFDA,MAGIEN,MAGNODE,OUT,SECT,SECTLTR,SPEC,SPECD
 N SSUBFILE,SSUBFL,STAIN,SUBFILE,X,Y
 S MAGRY="0^Started filing",MAGIEN=IMIEN
 S SECT=$P(DATA,"^",9),DFN=$P(DATA,"^",10),LRDFN=$P(DATA,"^",11)
 S LRI=$P(DATA,"^",12)
 S SPEC=$P(DATA,"^",13),FIELD=$P(DATA,"^",14)
 S MAGNODE="^"_$P(DATA,"^",15,99),ANUM=$P(DATA,"^",6)
 S SPECD=$P(DATA,"^",8),STAIN=$P(DATA,"^",1),IMOBJ=$P(DATA,"^",2)
 I SECT["~" S SECT=$P(SECT,"~",1)
 ;Check for valid image
 I '$D(^MAG(2005,MAGIEN,0)) D  Q
 . S Y(0)="0^Image entry does not exist."
 ;Check for valid image patient entry.
 I $P(^MAG(2005,MAGIEN,0),"^",7)'=DFN D  Q
 . S MAGRY="0^Image patient does not match Lab patient."
 ;Check if parent file and corresponding fields are filed in file 2005.
 I $D(^MAG(2005,MAGIEN,2)) S X=^MAG(2005,MAGIEN,2) D  Q:OUT
 . S OUT=0
 . I $P(X,"^",6),$P(X,"^",7),$P(X,"^",8) S OUT=1
 . I OUT S MAGRY="0^Report already exist for this image."
 ;Check the Lab entries...do they still exists.
 S MAGNODE=MAGNODE_",0)"
 I '$D(@MAGNODE) S MAGRY="0^Specimen no longer in Lab file." Q
 ;Everything seem okay lets file image pointer in lab file.
 S SECTLTR=$S(SECT=63:"AY",SECT=63.2:"AY",1:$P(^MAG(2005.03,SECT,0),"^",2))
 ;Lab nodes; AY, SP, EM or CY.
 ;
LAB2 ;updating files using silent Fileman DB calls.
 N MAGERR,MAGLVL
 S SUBFILE=$S(SECT=63:63.2,1:SECT)
 S MAGRY="0^Lab's Imaging subfile doesn't exisit." ;default
 ;Laboratory's Autopsy subfile has two imaging fields (2005 & 2005.1)
 ; and file 2005.03 does not reflect this.
 D FIELD^DID(SUBFILE,FIELD,"","SPECIFIER","MAGLVL","MAGERR")
 I $D(MAGERR("DIERR")) Q
 I '$D(MAGLVL("SPECIFIER")) Q
 S SSUBFL=$G(MAGLVL("SPECIFIER"))      ;Lab's Imaging subfile
 I SSUBFL="" Q
 ;Image sub-subfile.
 S SSUBFILE="" F I=1:1:$L(SSUBFL) D
 . I $E(SSUBFL,I)?1N!($E(SSUBFL,I)?1".") S SSUBFILE=SSUBFILE_$E(SSUBFL,I)
 . ;Leave off the alpha characters
 S DA1=$S(SECTLTR="AY":SPEC,1:LRI)  ;Autopsy is by specimen not date/time
 S DAS="+3,"_DA1_","_LRDFN_","
 ;Sets the iens e.g. da,da(1),da(2). The +3 can be any #; it is the 
 ;subscript of the return variable LABIENS.  
 ;Returns IEN for that subfile & use of +3 is because it's 2 levels down.
 S LABFDA(SSUBFILE,DAS,.01)=MAGIEN,LABIENS=""
 D UPDATE^DIE("S","LABFDA","LABIENS")
 I $D(DIERR) S MAGRY="O^Unsuccessful Lab updating." Q
 I '$D(LABIENS(3)) S MAGRY="0^Unsuccessful Lab updating" Q
 S DA=$G(LABIENS(3))
 I 'DA!('$D(^LR(LRDFN,SECTLTR,DA1,FIELD,DA,0))) D  Q
 . S MAGRY="0^Unsuccessful Lab updating"
IMAGE2 ;
 S MAGIEN=MAGIEN_",",LABIEN=DA,LABD=DA1 K DA,DA1
 ;  The following fields are saved in the ADDIMAGE Call.
 ;       50 =ANUM  ;ACCESSION NUMBER FIELD
 ;       51 =SPECD  ;SPECIMEN DESCRIPTION FIELD
 ;       52 =SPEC  ;SPECIMEN DO
 ;       53 =STAIN  ;Histology stain
 ;       54 =IMOBJ  ;MICROSCOPE OBJECTIVE
 N DIK
 S MAGFDA(2005,MAGIEN,16)=SECT     ;LAB SECTION
 S MAGFDA(2005,MAGIEN,17)=LRDFN    ;PARENT FILE DO VALUE
 S MAGFDA(2005,MAGIEN,18)=LABIEN   ;LAB BACKWARD IMAGE POINTER
 S MAGFDA(2005,MAGIEN,63)=LABD  ;If AUTOPSY, it's specimen else date/time
 S I=0 F I=$O(MAGFDA(2005,MAGIEN,I)) Q:'I  D
 . D UPDATE^DIE("S","MAGFDA","")
 I $D(DIERR) S I=0 F  S I=$O(MAGFDA(2005,MAGIEN,I)) Q:'I  D
 . S MAGFDA(2005,MAGIEN,I)="" D UPDATE^DIE("","MAGFDA","")
 I $D(DIERR),$D(^LR(LRDFN,SECTLTR,DA1,FIELD,LABIEN,0)),$G(^LR(LRDFN,SECTLTR,DA1,FIELD,LABIEN,0))=MAGIEN D
 . S DA(2)=LRDFN,DA(1)=DA1,DA=LABIEN
 . S DIK="^LR("_LRDFN_","""_SECTLTR_""","_DA1_","_FIELD_","
 . D ^DIK    ;Remove imaging pointers from lab subfile.
 I $D(DIERR) S MAGRY="0^Unsuccessful both files not updated." K DIERR Q
 S MAGRY="1^Success in filing both parent & image files." K DIERR
 D LINKDT^MAGGTU6(.X,+MAGIEN)
 Q
