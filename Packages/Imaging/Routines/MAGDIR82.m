MAGDIR82 ;WOIFO/PMK - Read a DICOM image file ; 10/30/2008 09:20
 ;;3.0;IMAGING;**11,30,51,20,54**;03-July-2009;;Build 1424
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
 ; M2MB server
 ;
 ; This routine is invoked by the ^MAGDIR8 to update statistics & add
 ; an image to the background processor and auto-router queues.
 ;
 ; There are two entry points, one for the "ACQUIRED" RESULT item, and
 ; the other (POSTPROC) for the "PROCESSED" RESULT item.
 ;
ACQUIRED ; update image acquisition statistics
 N INSTNAME,LOCATION,STATUS
 S STATUS=$P(ARGS,"|",1)
 S LOCATION=$P(ARGS,"|",2)
 S INSTNAME=$P(ARGS,"|",3)
 D COUNT("ACQUIRED")
 Q
 ;
POSTPROC ; update image processing statistics and add to BP & AR queues
 N COUNTFLG,ERRCODE,EVAL,I,IMAGEPTR,INSTNAME,LOCATION,MACHID,MSG,STATUS
 S STATUS=$P(ARGS,"|",1)
 S LOCATION=$P(ARGS,"|",2)
 S INSTNAME=$P(ARGS,"|",3)
 S IMAGEPTR=$P(ARGS,"|",4)
 S COUNTFLG=$P(ARGS,"|",5) ; zero for multiframe images
 S EVAL=$P(ARGS,"|",6)
 S MACHID=$P(ARGS,"|",7)
 I COUNTFLG D
 . D COUNT("PROCESSED") ; update the count
 . Q:$T(SAVEUID^MAGDIR81)=""
 . D SAVEUID^MAGDIR81(MACHID,"") ; clear the last image UID
 . Q
 ;
 S ERRCODE=""
 ;
 I $$CONSOLID^MAGDFCNV D
 . D POSTPRO2 ; consolidation code
 . Q
 E  D
 . D POSTPRO1 ; non-consolidation code
 . Q
 I ERRCODE="" D
 . D RESULT^MAGDIR8(OPCODE,"|"_$P(ARGS,"|",2,999))
 . Q
 E  D
 . D ERROR^MAGDIR8(OPCODE,ERRCODE,.MSG,$T(+0))
 . Q
 Q
 ;
POSTPRO1 ; non-consolidation code version of post processing
 Q:IMAGEPTR<0
 ; add the image to the jukebox queue
 D:'$$JUKEBOX^MAGBAPI(IMAGEPTR)
 . S I=$O(MSG(" "),-1)
 . S:I I=I+1,MSG(I)=" "
 . S I=I+1,MSG(I)="JUKEBOX QUEUE CREATION ERROR:"
 . S I=I+1,MSG(I)="An image has not been entered into the jukebox queue."
 . S I=I+1,MSG(I)="Image pointer: "_IMAGEPTR
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=-401
 . Q
 ;
 D:EVAL  ; Add the image to the routing evaluator queue
 . D WARNROUT(0)
 . D:$$EVAL^MAGBAPI(IMAGEPTR)<0
 . . S I=$O(MSG(" "),-1)
 . . S:I I=I+1,MSG(I)=" "
 . . S I=I+1,MSG(I)="AUTOROUTER EVALUATION QUEUE CREATION ERROR:"
 . . S I=I+1,MSG(I)="An image could not be evaluated for autorouting purposes."
 . . S I=I+1,MSG(I)="Image pointer: "_IMAGEPTR
 . . S I=I+1,MSG(I)="Error code is """_Z_"""."
 . . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . . S ERRCODE=ERRCODE_"-402"
 . . Q
 . Q
 Q
 ;
POSTPRO2 ; consolidation code version of post processing
 N PLACE
 Q:IMAGEPTR<0
 S PLACE=$O(^MAG(2006.1,"B",LOCATION,""))
 ;
 ; add the image to the jukebox queue
 D:'$$JUKEBOX^MAGBAPI(IMAGEPTR,PLACE)
 . S I=$O(MSG(" "),-1)
 . S:I I=I+1,MSG(I)=" "
 . S I=I+1,MSG(I)="JUKEBOX QUEUE CREATION ERROR:"
 . S I=I+1,MSG(I)="An image has not been entered into the jukebox queue."
 . S I=I+1,MSG(I)="Image pointer: "_IMAGEPTR_"   Location: "_LOCATION
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=-403
 . Q
 ;
 D:EVAL  ; Add the image to the routing evaluator queue
 . D WARNROUT(PLACE)
 . D:$$EVAL^MAGBAPI(IMAGEPTR,PLACE)<0
 . . S I=$O(MSG(" "),-1)
 . . S:I I=I+1,MSG(I)=" "
 . . S I=I+1,MSG(I)="AUTOROUTER EVALUATION QUEUE CREATION ERROR:"
 . . S I=I+1,MSG(I)="An image could not be evaluated for autorouting purposes."
 . . S I=I+1,MSG(I)="Image pointer: "_IMAGEPTR_"   Place: "_PLACE
 . . S I=I+1,MSG(I)="Error code is """_Z_"""."
 . . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . . S ERRCODE=ERRCODE_"-404"
 . . Q
 . Q
 Q
 ;
COUNT(STEP) ; update today's count
 N D2,NOW,PC,TODAY,X
 S NOW=$$NOW^XLFDT,TODAY=NOW\1
 L +^MAGDAUDT(2006.5762,TODAY):1E9 ; Background job MUST wait
 D:'$D(^MAGDAUDT(2006.5762,TODAY))
 . S X=$G(^MAGDAUDT(2006.5762,0))
 . S $P(X,"^",1,2)="DICOM INSTRUMENT STATISTICS^2006.5762"
 . S $P(X,"^",3)=TODAY
 . S $P(X,"^",4)=$P(X,"^",4)+1
 . S ^MAGDAUDT(2006.5762,0)=X
 . S ^MAGDAUDT(2006.5762,TODAY,0)=TODAY
 . S ^MAGDAUDT(2006.5762,"B",TODAY,TODAY)=""
 . Q
 S D2=$O(^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1,"B",INSTNAME,""))
 D:'D2
 . S D2=$O(^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1," "),-1)+1
 . S X=$G(^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1,0))
 . S $P(X,"^",2)="2006.576211"
 . S $P(X,"^",3)=D2
 . S $P(X,"^",4)=$P(X,"^",4)+1
 . S ^MAGDAUDT(2006.5762,TODAY,1,LOCATION,0)=LOCATION
 . S ^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1,0)=X
 . S ^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1,D2,0)=INSTNAME
 . S ^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1,"B",INSTNAME,D2)=""
 . Q
 S X=$G(^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1,D2,0))
 S PC=$S(STEP="ACQUIRED":2,STEP="PROCESSED":4,1:6)
 S $P(X,"^",PC)=$P(X,"^",PC)+1
 S $P(X,"^",PC+1)=NOW
 S ^MAGDAUDT(2006.5762,TODAY,1,LOCATION,1,D2,0)=X
 L -^MAGDAUDT(2006.5762,TODAY)
 Q
 ;
WARNROUT(PLACE) N LAST,X2,X3
 D:'PLACE
 . S PLACE=$$PLACE^MAGDRPC2(LOCATION)
 . Q
 S LAST=$G(^MAG(2006.1,+PLACE,"LASTROUTE"))
 S (X2,X3)=LAST\1 D:X3
 . N DEST,E,I,PRI,T
 . Q:$$FMDIFF^XLFDT(DT,X2,1)<7
 . S X2=$P(LAST,"^",2) Q:X2'<DT  ; Only send one message per day
 . S (E,T,I)=0 F  S I=$O(^MAGQUEUE(2006.03,"C",PLACE,"EVAL",I)) Q:I=""  S E=E+1
 . S PRI="" F  S PRI=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRI)) Q:PRI=""  D
 . . S DEST="" F  S DEST=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRI,DEST)) Q:DEST=""  D
 . . . S I="" F  S I=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRI,DEST,I)) Q:I=""  S T=T+1
 . . . Q
 . . Q
 . S I=$O(MSG(" "),-1)
 . S:I I=I+1,MSG(I)=" "
 . S I=I+1,MSG(I)="More than a week has elapsed since "_(X3#100)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",X3\100#100)_"-"_(X3\10000+1700)
 . S I=I+1,MSG(I)="when the last activity occurred that is related"
 . S I=I+1,MSG(I)="to the processing of Routed Image files."
 . S I=I+1,MSG(I)=" "
 . S I=I+1,MSG(I)="The site parameter for ""This is a Routing Site"" is"
 . S I=I+1,MSG(I)="currently turned ON."
 . S I=I+1,MSG(I)="If this site is no longer actively routing image files"
 . S I=I+1,MSG(I)="this site parameter must be turned OFF."
 . S I=I+1,MSG(I)="This parameter needs to be turned OFF on each VistA"
 . S I=I+1,MSG(I)="DICOM Gateway that processes incoming images."
 . S I=I+1,MSG(I)=" "
 . S I=I+1,MSG(I)="There are currently "_E_" entr"_$S(E=1:"y",1:"ies")
 . S I=I+1,MSG(I)="waiting to be processed in the evaluation queue."
 . S I=I+1,MSG(I)=" "
 . S I=I+1,MSG(I)="There are currently "_T_" entr"_$S(T=1:"y",1:"ies")
 . S I=I+1,MSG(I)="waiting to be processed in the transmission queue."
 . S I=I+1,MSG(I)=" "
 . S I=I+1,MSG(I)="If this site is still a routing site, then both the"
 . S I=I+1,MSG(I)="Routing Rule Evaluator and the Routing Transmitter"
 . S I=I+1,MSG(I)="must be restarted."
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=ERRCODE_"-405"
 . S $P(^MAG(2006.1,PLACE,"LASTROUTE"),"^",2)=DT
 . Q
 Q
 ;
