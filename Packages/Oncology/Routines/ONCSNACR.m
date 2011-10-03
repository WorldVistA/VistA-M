ONCSNACR ;Hines OIFO/SG - NACCR TOOLS  ; 3/9/07 10:40am
 ;;2.11;ONCOLOGY;**47**;Mar 07, 1995;Build 19
 ;
 ; ONC8DST ------------- DESCRIPTOR OF THE DESTINATION BUFFER
 ;                       (a parameter of BEGIN, END, FLUSH, and
 ;                       WRITE).  See also the ^ONCSAPIR.
 ;
 ; ONC8DST(              Closed root of the destination buffer
 ;   "BUF")              Output buffer
 ;   "LBA")              Available space in the output buffer
 ;   "PTR")              Pointer in the destination buffer
 ;   "PTRC")             Continuation pointer (optional)
 ;
 Q
 ;
 ;***** STARTS THE NAACCR RECORD OUTPUT
 ;
 ; [.ONC8DST]    Reference to a descriptor of the destination buffer
 ;
BEGIN(ONC8DST) ;
 Q:$G(ONC8DST)=""
 K ONC8DST("BUF"),ONC8DST("LBA")
 S:'$D(ONC8DST("PTR")) ONC8DST("PTR")=+$O(@ONC8DST@(""),-1)
 ;--- Open tag for the NAACCR record
 D PUT^ONCSAPIR(.ONC8DST,"NAACCR-RECORD",,1)
 D FLUSH(.ONC8DST)
 Q
 ;
 ;***** RETURNS CRC32 VALUE FOR THE NAACCR RECORD
 ;
 ; [.ONC8DST]    Reference to a descriptor of the destination buffer
 ;
 ; Return values:
 ;        0  NAACCR record data has not been found
 ;      ...  CRC32 value
 ;
CRC32(ONC8DST) ;
 N BUF,CRC,FLT,FLTL,PI
 S FLTL=$L(ONC8DST)-1,FLT=$E(ONC8DST,1,FLTL)
 ;--- Search for beginning of the record data
 S PI=ONC8DST
 F  S PI=$Q(@PI)  Q:$E(PI,1,FLTL)'=FLT  Q:$E(@PI,1,14)="<NAACCR-RECORD"
 Q:$E(PI,1,FLTL)'=FLT 0
 ;--- Calculate the checksum
 S CRC=4294967295
 F  S PI=$Q(@PI)  Q:$E(PI,1,FLTL)'=FLT  S BUF=@PI  Q:BUF="</NAACCR-RECORD>"  D
 . S CRC=$$CRC32^XLFCRC(BUF,CRC)
 ;--- Success
 Q CRC
 ;
 ;***** FINISHES THE NAACCR RECORD OUTPUT
 ;
 ; [.ONC8DST]    Reference to a descriptor of the destination buffer
 ;
END(ONC8DST) ;
 I $G(ONC8DST)=""  W !  Q
 ;--- Close tag for the NAACCR record
 D FLUSH(.ONC8DST),APPEND^ONCSAPIR(.ONC8DST,"</NAACCR-RECORD>",1)
 K ONC8DST("BUF"),ONC8DST("LBA")
 Q
 ;
 ;***** FLUSHES THE OUTPUT BUFFER
 ;
 ; [.ONC8DST]    Reference to a descriptor of the destination buffer
 ;
FLUSH(ONC8DST) ;
 Q:$G(ONC8DST)=""
 D:$G(ONC8DST("BUF"))'="" APPEND^ONCSAPIR(.ONC8DST,ONC8DST("BUF"),1)
 S ONC8DST("BUF")="",ONC8DST("LBA")=250
 Q
 ;
 ;***** OUTPUTS THE PIECE OF THE NAACCR RECORD
 ;
 ; [.ONC8DST]    Reference to a descriptor of the destination buffer
 ;
 ; VAL           A piece of the NAACCR record
 ;
WRITE(ONC8DST,VAL) ;
 I $G(ONC8DST)=""  W VAL  Q
 N ENCTXT,LT
 S ENCTXT=$$SYMENC^MXMLUTL(VAL),LT=$L(ENCTXT)
 F  Q:LT'>0  D
 . I LT>ONC8DST("LBA")  D
 . . S ONC8DST("BUF")=ONC8DST("BUF")_$E(ENCTXT,1,ONC8DST("LBA"))
 . . S $E(ENCTXT,1,ONC8DST("LBA"))=""
 . . S LT=LT-ONC8DST("LBA"),ONC8DST("LBA")=0
 . E  D
 . . S ONC8DST("BUF")=ONC8DST("BUF")_ENCTXT
 . . S ONC8DST("LBA")=ONC8DST("LBA")-LT,LT=0
 . D:ONC8DST("LBA")'>0 FLUSH(.ONC8DST)
 Q
