MAGTP011 ;WOIFO/FG,MLH - TELEPATHOLOGY RPCS ; 25 Jul 2013 5:41 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
 Q  ;
 ;
 ;***** GET THE USER'S SETTING/PREFERENCES IN XML FORMAT
 ;      FROM THE CONFIGURATION FILE (#2006.13)
 ; RPC: MAGTP GET PREFERENCES
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; ENT           List of inputs:
 ;                 ^01: DUZ of user whose preferences are to be retrieved
 ;                 ^02: LABEL of preference section
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: Total Number of Lines
 ;                ^03: <DUZ>: <LABEL>
 ;
 ; MAGRY(i)     Description
 ;                ^01: XML Line of Text
 ;
GETUPREF(MAGRY,ENT) ; RPC [MAGTP GET PREFERENCES]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 N LDUZ,FILE,FILE2,LABEL,CT,I
 N MAGREC0,MAGREC1,MAGREC2,MAGOUT,MAGERR
 S FILE=2006.13
 S FILE2=2006.1371
 ;
 S LDUZ=$P($G(ENT),U)                          ; First line of ENT is LDUZ^LABEL
 I LDUZ="" S LDUZ=DUZ                          ; Default to user's DUZ if null
 I $$GET1^DIQ(200,LDUZ_",",.01)="" S MAGRY(0)="0^0^Invalid DUZ" Q  ; IA #10060
 ;
 ; Get configuration record IEN or bail
 ;
 S MAGREC0=$O(^MAG(FILE,0))
 I 'MAGREC0 S MAGRY(0)="0^0^No configuration record defined" Q
 ;
 S MAGREC1=$O(^MAG(FILE,MAGREC0,7,"B",LDUZ,""))
 I MAGREC1="" S MAGRY(0)="0^0^No preferences found for "_LDUZ Q
 ;
 S LABEL=$P(ENT,U,2)
 I LABEL="" S MAGRY(0)="0^0^No Label entered" Q
 S MAGREC2=$O(^MAG(FILE,MAGREC0,7,MAGREC1,1,"B",LABEL,""))
 I MAGREC2="" D  Q
 . S MAGRY(0)="0^0^No preferences found for "_LDUZ_": "_LABEL
 ;
 D GET1^DIQ(FILE2,MAGREC2_","_MAGREC1_","_MAGREC0_",",.02,"","MAGOUT","MAGERR")
 I $D(MAGERR) D  Q
 . S MAGRY(0)="0^0^Access Error: "_MAGERR("DIERR",1,"TEXT",1)
 S (CT,I)=0
 F  S I=$O(MAGOUT(I)) Q:I=""  D
 . S CT=CT+1
 . S MAGRY(CT)=MAGOUT(I)
 . Q
 S MAGRY(0)="1^"_CT_U_LDUZ_": "_LABEL
 Q  ;
 ;
 ;***** SET THE USER'S SETTING/PREFERENCES IN XML FORMAT
 ;      IN THE CONFIGURATION FILE (#2006.13)
 ; RPC: MAGTP PUT PREFERENCES
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; .ENT          Input array:
 ;
 ;                 First Line:      DUZ^Label
 ;                 Following Lines: One XML line of text
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: 0
 ;                ^03: <DUZ>: <LABEL> " Preferences Updated"
 ;
PUTUPREF(MAGRY,ENT) ; RPC [MAGTP PUT PREFERENCES]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I $D(ENT)<10 S MAGRY(0)="0^0^No Input" Q
 N LINE,LDUZ,FILE,FILE1,FILE2,LABEL
 N MAGFDA,MAGERR,ORIEN
 N MAGREC0,MAGREC1,MAGREC2,I
 S FILE=2006.13
 S FILE1=2006.137
 S FILE2=2006.1371
 ;
 ; Get configuration record IEN or bail
 ;
 S MAGREC0=$O(^MAG(FILE,0))
 I 'MAGREC0 S MAGRY(0)="0^0^No configuration record defined" Q
 ; 
 S LINE=$O(ENT(""))
 S LDUZ=$P(ENT(LINE),U)                        ; First line of ENT is LDUZ^LABEL
 I LDUZ="" S LDUZ=DUZ                          ; Default to user's DUZ if null
 I $$GET1^DIQ(200,LDUZ_",",.01)="" S MAGRY(0)="0^0^Invalid DUZ" Q  ; IA #10060
 S MAGREC1=$O(^MAG(FILE,MAGREC0,7,"B",LDUZ,""))
 ;
 ; If MAGREC1 is not defined add a DUZ record
 ;
 I MAGREC1="" D  Q:$P($G(MAGRY(0)),U)=0
 . S MAGFDA(1,FILE1,"+1,"_MAGREC0_",",.01)=LDUZ
 . D UPDATE^DIE("","MAGFDA(1)","ORIEN","MAGERR")
 . I $D(MAGERR) D  Q
 . . S MAGRY(0)="0^0^Update Error: "_MAGERR("DIERR",1,"TEXT",1)
 . S MAGREC1=ORIEN(1)                          ; MAGREC1 generated
 . K ORIEN
 . Q
 ;
 S LABEL=$P(ENT(LINE),U,2)
 I LABEL="" S MAGRY(0)="0^0^No Label entered" Q
 S MAGREC2=$O(^MAG(FILE,MAGREC0,7,MAGREC1,1,"B",LABEL,""))
 ;
 ; If MAGREC2 is not defined add a label
 ;
 I MAGREC2="" D  Q:$P($G(MAGRY(0)),U)=0
 . K MAGFDA,MAGERR
 . S MAGFDA(1,FILE2,"+1,"_MAGREC1_","_MAGREC0_",",.01)=LABEL
 . D UPDATE^DIE("","MAGFDA(1)","ORIEN","MAGERR")
 . I $D(MAGERR) D  Q
 . . S MAGRY(0)="0^0^Update Error: "_MAGERR("DIERR",1,"TEXT",1)
 . S MAGREC2=ORIEN(1)                          ; MAGREC2 generated
 . K ORIEN
 . Q
 ;
 ; Set new preferences
 ;
 K MAGFDA,MAGERR
 S I=0
 F  S LINE=$O(ENT(LINE)) Q:LINE=""  D          ; Start from second line
 . S I=I+1
 . S MAGFDA(I)=ENT(LINE)                       ; FDA arrays cannot start from 0
 . Q
 D WP^DIE(FILE2,MAGREC2_","_MAGREC1_","_MAGREC0_",",.02,"K","MAGFDA","MAGERR")
 I $D(MAGERR) D  Q
 . S MAGRY(0)="0^0^Updating Error: "_MAGERR("DIERR",1,"TEXT",1)
 S MAGRY(0)="1^0^"_LDUZ_": "_LABEL_" - Preferences Updated"
 Q
