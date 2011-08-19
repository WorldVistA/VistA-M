HLTF1 ;AISC/SAW/MTC-Process Message Text File Entries (Cont'd) ;10/17/2007  09:43
 ;;1.6;HEALTH LEVEL SEVEN;**5,8,22,25,19,78,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
MERGE15(ARAYTYPE,MTIEN,SUB1,SUB2) ;Merge Local/Global Array From Application into
 ;Message Text File
 ;
 ;This is a routine call with parameter passing.  There are no output
 ;parameters returned by this call.
 ;
 ;**  Merges incoming data for v1.5 applications only **
 ;
 ;Required input parameters
 ;   MTIEN = The IEN from the Message Text file of the entry to be
 ;             updated
 ;  ARAYTYPE = Array type, G for global or L for local
 ;      SUB1 = The first level subscript of the array.  Must be
 ;               either HLS or HLA
 ;Optional input parameter
 ;      SUB2 = A second subscript associated with the array
 ;
 ;Check for required parameters
 I "GL"'[$G(ARAYTYPE)!($G(SUB1)']"")!('$G(MTIEN)) G MRGE15X
 ;
 N HLCHAR,HLEVN,HLFS,I,X,X1,X2,X3 S (HLCHAR,HLEVN,X)=0
 ;
 ;Merge data from a global array with two subscript
 I ARAYTYPE="G",$G(SUB2)'="" D
 . S X="",I=0
 . F  S X=$O(^TMP(SUB1,$J,SUB2,X)) Q:'X  S I=I+1,X1=^TMP(SUB1,$J,SUB2,X),HLCHAR=HLCHAR+$L(X1) S:$E(X1,1,3)="MSH" HLFS=$E(X1,4),$P(X1,HLFS,8)="",HLEVN=HLEVN+1 S ^HL(772,MTIEN,"IN",I,0)=X1
 ;
 ;Merge data from a global array with one subscripts
 I ARAYTYPE="G",$G(SUB2)="" D
 . S X="",I=0
 . F  S X=$O(^TMP(SUB1,$J,X)) Q:'X  S I=I+1,X1=^TMP(SUB1,$J,X),HLCHAR=HLCHAR+$L(X1) S:$E(X1,1,3)="MSH" HLFS=$E(X1,4),$P(X1,HLFS,8)="",HLEVN=HLEVN+1 S ^HL(772,MTIEN,"IN",I,0)=X1
 ;
 ;Merge data from a local array with one subscript
 I ARAYTYPE="L" D
 . S X="",I=0
 . F  S X=$O(HLA(SUB1,X)) Q:'X  S I=I+1,X1=HLA(SUB1,X),HLCHAR=HLCHAR+$L(X1) S:$E(X1,1,3)="MSH" HLFS=$E(X1,4),$P(X1,HLFS,8)="",HLEVN=HLEVN+1 S ^HL(772,MTIEN,"IN",I,0)=X1
 ;
 ;-- update 0 node for message text
 S ^HL(772,MTIEN,"IN",0)="^^"_I_"^"_I_"^"_$$DT^XLFDT_"^"
 ;
 ;File message statistics
 D STATS^HLTF0(MTIEN,HLCHAR,HLEVN)
 ;
MRGE15X ;-- exit merge 
 Q
 ;
MERGE(ARAYTYPE,MTIEN,SUB1,SUB2) ;Merge Local/Global Array From Application into
 ;Message Text File
 ;
 ;This is a routine call with parameter passing.  There are no output
 ;parameters returned by this call.
 ;
 ;Required input parameters
 ;   MTIEN = The IEN from the Message Text file of the entry to be
 ;             updated
 ;  ARAYTYPE = Array type, G for global or L for local
 ;      SUB1 = The first level subscript of the array.  Must be
 ;               either HLS or HLA
 ;Optional input parameter
 ;      SUB2 = A second subscript associated with the array
 ;
 ;Check for required parameters
 I "GL"'[$G(ARAYTYPE)!($G(SUB1)']"")!('$G(MTIEN)) G MERGEX
 ;
 N HLCHAR,HLEVN,HLFS,I,X,X1,X2,X3 S (HLCHAR,HLEVN,X)=0
 ;
 ; patch HL*1.6*122: MPI-client/server
 F  L +^HL(772,+$G(MTIEN)):10 Q:$T  H 1
 ;
 ;Merge data from a global array with two subscript
 I ARAYTYPE="G",$G(SUB2)'="" D
 . S X="",I=0
 . F  S X=$O(^TMP(SUB1,$J,SUB2,X)) Q:'X  S I=I+1,X1=^TMP(SUB1,$J,SUB2,X),HLCHAR=HLCHAR+$L(X1) S:$E(X1,1,3)="MSH" HLFS=$E(X1,4),$P(X1,HLFS,8)="",HLEVN=HLEVN+1 S ^HL(772,MTIEN,"IN",I,0)=X1,X2=$D(^TMP(SUB1,$J,SUB2,X)) D
 .. I X2=11 S X3="" F  S X3=$O(^TMP(SUB1,$J,SUB2,X,X3)) Q:'X3  D
 ... S I=I+1,X1=$G(^TMP(SUB1,$J,SUB2,X,X3)),HLCHAR=HLCHAR+$L(X1),^HL(772,MTIEN,"IN",I,0)=X1
 .. S I=I+1,^HL(772,MTIEN,"IN",I,0)="" Q
 ;
 ;Merge data from a global array with one subscripts
 I ARAYTYPE="G",$G(SUB2)="" D
 . S X="",I=0
 . F  S X=$O(^TMP(SUB1,$J,X)) Q:'X  S I=I+1,X1=^TMP(SUB1,$J,X),HLCHAR=HLCHAR+$L(X1) S:$E(X1,1,3)="MSH" HLFS=$E(X1,4),$P(X1,HLFS,8)="",HLEVN=HLEVN+1 S ^HL(772,MTIEN,"IN",I,0)=X1,X2=$D(^TMP(SUB1,$J,X)) D
 .. I X2=11 S X3="" F  S X3=$O(^TMP(SUB1,$J,X,X3)) Q:'X3  D
 ... S I=I+1,X1=$G(^TMP(SUB1,$J,X,X3)),HLCHAR=HLCHAR+$L(X1),^HL(772,MTIEN,"IN",I,0)=X1
 .. S I=I+1,^HL(772,MTIEN,"IN",I,0)="" Q
 ;
 ;Merge data from a local array with one subscript
 I ARAYTYPE="L" D
 . S X="",I=0
 . F  S X=$O(HLA(SUB1,X)) Q:'X  S I=I+1,X1=HLA(SUB1,X),HLCHAR=HLCHAR+$L(X1) S:$E(X1,1,3)="MSH" HLFS=$E(X1,4),$P(X1,HLFS,8)="",HLEVN=HLEVN+1 S ^HL(772,MTIEN,"IN",I,0)=X1,X2=$D(HLA(SUB1,X)) D
 .. I X2=11 S X3="" F  S X3=$O(HLA(SUB1,X,X3)) Q:'X3  D
 ... S I=I+1,X1=$G(HLA(SUB1,X,X3)),HLCHAR=HLCHAR+$L(X1),^HL(772,MTIEN,"IN",I,0)=X1
 .. S I=I+1,^HL(772,MTIEN,"IN",I,0)="" Q
 ;
 S:HLEVN=0 HLEVN=1
 ;X=ien in file 773 for TCP messages
 S X=+$O(^HLMA("B",MTIEN,0))
 ;batch message type
 I X,$P($G(^HLMA(X,0)),U,5)="B" D BTS
 I 'X,$P(^HL(772,MTIEN,0),U,8),$P(^HL(772,$P(^(0),U,8),0),U,14)="B" D BTS
 ;
 ;-- update 0 node for message text
 S ^HL(772,MTIEN,"IN",0)="^^"_I_"^"_I_"^"_$$DT^XLFDT_"^"
 ;
 ; patch HL*1.6*122: MPI-client/server
 L -^HL(772,+$G(MTIEN))
 ;
 ;File message statistics
 D STATS^HLTF0(MTIEN,HLCHAR,HLEVN)
 ;
MERGEX ;-- exit merge 
 Q
 ;
BTS ; create batch trailer seg (BTS)
 ;HL*1.6*78 to obtain and insert FIELD SEPARATOR, HLFS
 N HLFS,HLSAN
 S HLFS=$G(HL("FS")) ; obtain from HL array
 ; or obtain from sending application; default to "^"
 I HLFS="" D  S:HLFS="" HLFS="^"
 . S HLSAN=$P($G(^HL(772,MTIEN,0)),U,2)
 . S:HLSAN HLFS=$G(^HL(771,HLSAN,"FS"))
 S I=I+1,^HL(772,MTIEN,"IN",I,0)="BTS"_HLFS_HLEVN,I=I+1,^HL(772,MTIEN,"IN",I,0)=""
 Q
 ;
MRGINT(MTOUT,MTIN,HDR) ;Merge Internal to Internal Message from the
 ; Outbound message in 772 (MTOUT) to an Inbound entry (MTIN). The process
 ; will involve Moving the Header and Text into 772.
 ;
 ;Required input parameters
 ;  MTOUT= Internal entry number of the Outbound message
 ;  MTIN = Internal entry number of the Inbound  message
 ;  HDR  = Name of the array that contains HL7 Header segment
 ;         format: HLHDR - Used with indirection to build message in out
 ;                         queue
 ;  This routine will first take the header information in the array
 ;  specified by HDR and merge into the Message Text field of file 870.
 ;  Then it will move the message contained in 772 (MTIEN) into 870.
 ;
 ;Check for required parameters
 I '$G(MTOUT)!('$G(MTIN))!(HDR="") Q
 ;
 ;-- initilize 
 N I,X
 S I=0
 ;
 ;-- move header into 772 from HDR array
 S X="" F  S X=$O(@HDR@(X)) Q:'X  D
 . S I=I+1,^HL(772,MTIN,"IN",I,0)=@HDR@(X)
 S I=I+1,^HL(772,MTIN,"IN",I,0)=""
 ;
 ;Move data from Message Text (MTOUT) file TO Message Text 772 (MTIN)
 S X=0 F  S X=$O(^HL(772,MTOUT,"IN",X)) Q:X=""  S I=I+1 D
 . S ^HL(772,MTIN,"IN",I,0)=$G(^HL(772,MTOUT,"IN",X,0))
 ;
 ;-- update 0 node of message and format arrays
 S ^HL(772,MTIN,"IN",0)="^^"_I_"^"_I_"^"_$$DT^XLFDT_"^"
 ;
 Q
