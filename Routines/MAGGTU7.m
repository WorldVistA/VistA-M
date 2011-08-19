MAGGTU7 ;WOIFO/GEK/SG - Silent calls for Queing functions from GUI ; 3/9/09 12:52pm
 ;;3.0;IMAGING;**8,20,93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ONJBOX(MAGIEN,CODE) ;
 ;Check to see if the image ( Abs, Full, or Big ) is on the worm 
 ;  before queuing it to be copied to HardDrive.
 ; We're testing to see if a pointer to the magnetic exists.
 ;  If not then we assume the Image is on JukeBox
 N ZNODE
 S ZNODE=$G(^MAG(2005,+MAGIEN,0))
 IF '$L(ZNODE) Q 0
 IF $$IMOFFLN^MAGFILEB($P(ZNODE,"^",2)) Q 0
 Q:((+$P(ZNODE,U,11))!(+$P(ZNODE,U,12))) 0
 IF CODE="A" Q '$P(ZNODE,U,4)
 IF CODE="F" Q '$P(ZNODE,U,3)
 IF CODE="B" Q $S('$P(^MAG(2005,+MAGIEN,"FBIG"),U,2):0,1:'$P(^MAG(2005,+MAGIEN,"FBIG"),U,1))
 ;
 Q
QUEIMAGE(MAGRY,CODE,MAGIEN) ;RPC [MAGG QUE IMAGE]
 ; Call to Queue an image for copy from Jukebox
 ;  NOTE : This is also called from other M routines.
 ; 
 ; CODE is a string code for which images to Queue
 ;     ["A" Abatract
 ;     ["F" Full Resolution
 ;     ["B" Big File
 ;
 N Y,QUE
 S QUE=""
 S MAGRY="0^Error setting Que from JukeBox"
 ;S MAGRY="1^Image was Queued to copy from JukeBox"
 ;  GEK 6/27/03  added code (ABS4IMAG) that returns 1|0  1 if this image should have an Abstract
 ;     This will stop the Queing of Canned Bitmaps for Images of type DOC, PDF, WAV, AVI  etc.
 I (CODE["A"),$$ONJBOX(MAGIEN,"A"),$$ABS4IMAG^MAGGSFT(MAGIEN) S Y=$$JBTOHD^MAGBAPI(+MAGIEN_"^ABSTRACT",$$DA2PLC^MAGBAPIP(MAGIEN,"A")) S QUE="A" ; DBI - SEB 9/20/2002
 I (CODE["F"),$$ONJBOX(MAGIEN,"F") S Y=$$JBTOHD^MAGBAPI(+MAGIEN_"^FULL",$$DA2PLC^MAGBAPIP(MAGIEN,"F")) S QUE=QUE_"F" ; DBI - SEB 9/20/2002
 I (CODE["B"),$$ONJBOX(MAGIEN,"B") S Y=$$JBTOHD^MAGBAPI(+MAGIEN_"^BIG",$$DA2PLC^MAGBAPIP(MAGIEN,"B")) S QUE=QUE_"B" ; DBI - SEB 9/20/2002
 I QUE="" S MAGRY="1^Copy from JukeBox not needed, Image was NOT Queued."
 E  S MAGRY="1^Image was Queued to copy from JukeBox ("_QUE_")"
 Q
QPREFET(MAGRY,CODE,MAGIEN) ;
 ; CODE is a string code for which images to Queue
 ;     ["A" Abatract
 ;     ["F" Full Resolution
 ;     ["B" Big File
 ;
 N Y,QUE
 S QUE=""
 S MAGRY="0^Error setting Prefetch Que from JukeBox"
 ;S MAGRY="1^Image was Queued to copy from JukeBox"
 I (CODE["A"),$$ONJBOX(MAGIEN,"A"),$$ABS4IMAG^MAGGSFT(MAGIEN) S Y=$$PREFET^MAGBAPI(+MAGIEN_"^ABSTRACT",$$DA2PLC^MAGBAPIP(MAGIEN,"A")) S QUE="A" ; DBI - SEB 9/20/2002
 I (CODE["F"),$$ONJBOX(MAGIEN,"F") S Y=$$PREFET^MAGBAPI(+MAGIEN_"^FULL",$$DA2PLC^MAGBAPIP(MAGIEN,"F")) S QUE=QUE_"F" ; DBI - SEB 9/20/2002
 I (CODE["B"),$$ONJBOX(MAGIEN,"B") S Y=$$PREFET^MAGBAPI(+MAGIEN_"^BIG",$$DA2PLC^MAGBAPIP(MAGIEN,"B")) S QUE=QUE_"B" ; DBI - SEB 9/20/2002
 I QUE="" S MAGRY="1^Copy from JukeBox not needed, Image was NOT Queued."
 E  S MAGRY="1^Image was Queued to copy from JukeBox"
 Q
QUELIST(MAGRY,CODE,LIST) ;RPC [MAGG QUE LIST]
 ; Call to queue all images in the input list for a copy from jukebox
 ;
 ; CODE is a string code for which images to Queue
 ;     ["A" Abatract
 ;     ["F" Full Resolution
 ;     ["B" Big File
 ; LIST is an array of Image IEN's,  we queue images contained in CODE
 ;
 N Y,CT,XX
 S CT=0
 S X="" F  S X=$O(LIST(X)) Q:X=""  D QUEIMAGE(.XX,CODE,X) S CT=CT+1
 S MAGRY=CT_"^"_CT_" Image"_$S(CT=1:"",1:"'s")_" Queued to copy from JukeBox"
 Q
QUEGROUP(MAGRY,CODE,MAGIEN,QCODE) ;RPC [MAGG QUE IMAGE GROUP]
 ; Call to queue all images of an Image group for a copy from JukeBox.
 ;  This can also be a PREFETCH, in which case the Images being 
 ;  Queued have a lower priority than other copies from JukeBox
 ;
 ; CODE is a string code for which images to Queue
 ;     ["A" Abatract
 ;     ["F" Full Resolution
 ;     ["B" Big File
 ; MAGIEN is assumed to be a group image.
 ; QCODE is a QUEUE code.  If = 1 then this is a prefetch
 ;   here we are queing the images contained in CODE
 ;   for all images in the group.
 N X,Y,Z,CT,XX
 S QCODE=$G(QCODE)
 I '$D(^MAG(2005,+MAGIEN,0)) S MAGRY="0^Invalid Image IEN. Queuing Canceled." Q
 S CT=0,X=0
 F  S X=$O(^MAG(2005,+MAGIEN,1,X)) Q:'X  S Z=+^(X,0) D
 . I QCODE D QPREFET(.XX,CODE,Z) S CT=CT+1
 . I 'QCODE D QUEIMAGE(.XX,CODE,Z) S CT=CT+1
 S MAGRY=CT_"^"_CT_" Group Image"_$S(CT=1:"",1:"'s")_" Queued to copy from JukeBox"
 Q
QUEPAT(MAGRY,CODE,MAGDFN) ;RPC [MAGG QUE PATIENT]
 ; Call to  Prefetch all images for a patient.
 ;  CODE is a string code for which images to Queue
 ;     ["A" Abatract
 ;     ["F" Full Resolution
 ;     ["B" Big File
 ;  this will queue a JBTOHD copy for all images for the patient.
 ;  images queued depend on what is contained in CODE
 ;
 N Y,I,XX
 I '$D(^MAG(2005,"AC",+MAGDFN)) S MAGRY="0^No Images on file for "_$P($G(^DPT(+MAGDFN,0)),U,1) Q
 S I="" F  S I=$O(^MAG(2005,"AC",+MAGDFN,I),-1) Q:'I  D
 . I $P(^MAG(2005,I,0),U,10) Q
 . Q:$$ISDEL^MAGGI11(I)
 . I $P(^MAG(2005,I,0),U,6)="11" D QUEGROUP(.XX,CODE,I,1) Q
 . D QPREFET(.XX,CODE,I)
 S MAGRY="1^"_$P(^DPT(+MAGDFN,0),U)_"'s Images will be copied from the JukeBox."
 Q
