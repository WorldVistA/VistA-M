ALPBHL1U ;OIFO-DALLAS MW,SED,KC -HL7 MESSAGE SEGMENT PARSER AND UPDATE ;2/6/21  15:41
 ;;3.0;BAR CODE MED ADMIN;**7,69,59,73,87,127,108,129**;May 2002;Build 16
 ;
 ; passed parameters common to all functions:
 ;   IEN   = patient's internal entry number in file 53.7
 ;   OIEN  = the order number's internal entry number in file 53.7
 ;   DATA  = the HL7 message line
 ;   FS    = the HL7 field separator character (e.g., "|" or "^")
 ;   CS    = the HL7 component separator character (e.g., "~")
 ;   ECH   = the HL7 encoding characters
 ;   ERR   = an array passed by reference, returned containing
 ;           FileMan DBS call error array (if any)
 ;
 ;*69 - A New NTE segment will now contain WP unlimited text.  This
 ;      text will also contain formatted text escape character \.br\
 ;      NTE tag will now rebuild work arrays honoring the line break
 ;      escape character prior to storing into BCMA BACKUP DATA #53.7.
 ;**73- Add Clinic name to Order multiple for orders that were placed
 ;       in a clinic vs. a Ward.
 ;*87 - Add Remove logic to pull out new fields and store to DB
 ;*108- add ZZZ segment for Hazardous drug flags
 ;
AL1(IEN,DATA,FS,CS,ERR) ; process AL1 (allergies) segment...
 I +$G(IEN)'>0!($G(DATA)="")!($G(FS)="")!($G(CS)="") D ERRBLD^ALPBUTL1("AL1","",.ERR) Q
 N ALPBALG,ALPBALGN,ALPBFILE,ALPBNEXT,ALPBSCHD,ALPBX,SCS,ALPBXX,ALPBSCHDLE1,ALPBX2,ALPBYY
 S ALPBALG=+$P(DATA,FS,4)
 I ALPBALG'>0 D ERRBLD^ALPBUTL1("AL1","Undefined allergy "_DATA,.ERR) Q
 S ALPBALGN=$P($P(DATA,FS,4),CS,2)
 ; is this allergy already on file for this patient?...
 I $D(^ALPB(53.7,IEN,1,"B",ALPBALG)) S ERR("DIERR")=0 Q
 ; if not, file it...
 S ALPBNEXT=+$O(^ALPB(53.7,IEN,1," "),-1)+1
 S ALPBFILE(53.701,"+"_ALPBNEXT_","_IEN_",",.01)=ALPBALG
 S ALPBFILE(53.701,"+"_ALPBNEXT_","_IEN_",",1)=ALPBALGN
 D UPDATE^DIE("","ALPBFILE","ALPBNEXT","ERR")
 Q
 ;
ORC(IEN,OIEN,DATA,MLOG,FS,CS,ERR) ; process ORC (common order) segment...
 ; MLOG = if 1 then this is an ORC segment with a Med Log update
 ;        if 0 then this is a common order update
 I +$G(IEN)'>0!(+$G(OIEN)'>0)!($G(DATA)="")!($G(MLOG)="")!($G(FS)="")!($G(CS)="") D ERRBLD^ALPBUTL1("ORC","",.ERR) Q
 N ALPBFIEN,ALPBFILE,ALPBMREC,ALPBNEXT,ALPBTEXT,ALPBX,SVZERO      ;*87
 S ALPBFIEN=OIEN_","_IEN_","
 ; ORC segment with NO MedLog data...
 I +MLOG=0 D
 .S ALPBX=$P(DATA,FS,1)
 .; order status...
 .S ALPBFILE(53.702,ALPBFIEN,2)=$P(DATA,FS,6)
 .; provider...
 .S ALPBFILE(53.702,ALPBFIEN,5)=$P($P(DATA,FS,13),CS,2)
 .; entry person/rph...
 .S ALPBFILE(53.702,ALPBFIEN,5.1)=$P($P(DATA,FS,11),CS,2)
 .; verified by...
 .S ALPBFILE(53.702,ALPBFIEN,5.2)=$P($P(DATA,FS,12),CS,2)
 .; set clinic name in new DD field 3.5 if a clinic order         ;*73
 .S ALPBFILE(53.702,ALPBFIEN,3.5)=$P(DATA,FS,22)
 .D UPDATE^DIE("","ALPBFILE","","ERR")
 .; if this is a pending order, add special instructions...
 .I $P($P(DATA,FS,6),CS,1)="IP" D
 ..S ALPBTEXT(1)="CAUTION!  THIS IS A PENDING ORDER :: CHECK WITH PROVIDER OR PHARMACIST!"
 ..D WP^DIE(53.702,ALPBFIEN,8,"A","ALPBTEXT","ERR")
 ..K ALPBTEXT
 ; ORC segment with specific MedLog data...
 I +MLOG=1 D
 .; ALPBX = med log date/time...
 .S ALPBX=$$FMDATE^HLFNC($P(DATA,FS,10))
 .I ALPBX="" K ALPBX Q
 .; ALPBMREC = med log record number...
 .S ALPBMREC=+$P($P(DATA,FS,3),CS,1)
 .;
 .;UPDATE, If the med log entry is already on file, update and quit.
 .;  check for both an entry on file for the log date/time ("B" xref)
 .;  or med log record number ("C" xref)...
 .S ALPBNEXT=+$O(^ALPB(53.7,IEN,2,OIEN,10,"B",ALPBX,""),-1)
 .I ALPBNEXT'>0 S ALPBNEXT=+$O(^ALPB(53.7,IEN,2,OIEN,10,"C",ALPBMREC,""))
 .I ALPBNEXT>0 D  Q
 ..S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,.01)=ALPBX
 ..S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,1)=$P($P(DATA,FS,11),CS,2)
 ..S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,2)=$P($P(DATA,FS,6),CS,2)
 ..I ALPBMREC>0 S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,3)=ALPBMREC
 ..;if remove status, save associated Given info for storing       *87
 ..D:$P($P(DATA,FS,6),CS,2)["REMOVE"
 ...S SVZERO=$G(^ALPB(53.7,IEN,2,OIEN,10,ALPBNEXT,0))
 ...S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,4)=$P(SVZERO,U,1)
 ...S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,5)=$P(SVZERO,U,2)
 ...S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,6)=$P(SVZERO,U,3)
 ..;if Given cur action, then always set assoc Give fields to null *87
 ..D:$P($P(DATA,FS,6),CS,2)["GIVEN"
 ...S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,4)=""
 ...S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,5)=""
 ...S ALPBFILE(53.70213,ALPBNEXT_","_ALPBFIEN,6)=""
 ..;
 ..D UPDATE^DIE("","ALPBFILE","","ERR")
 .K ALPBNEXT
 .;
 .;ADD, If not...
 .S ALPBNEXT=+$O(^ALPB(53.7,IEN,2,OIEN,10," "),-1)        ;bug fix *87
 .S ALPBFILE(53.70213,"+"_ALPBNEXT_","_ALPBFIEN,.01)=ALPBX
 .; med log entry person...
 .S ALPBFILE(53.70213,"+"_ALPBNEXT_","_ALPBFIEN,1)=$P($P(DATA,FS,11),CS,2)
 .; med log transaction message...
 .S ALPBFILE(53.70213,"+"_ALPBNEXT_","_ALPBFIEN,2)=$P($P(DATA,FS,6),CS,2)
 .; med log record number...
 .I ALPBMREC>0 S ALPBFILE(53.70213,"+"_ALPBNEXT_","_ALPBFIEN,3)=ALPBMREC
 .;if Given cur action, then always init assoc. fields to null     *87
 .D:$P($P(DATA,FS,6),CS,2)["GIVEN"
 ..S ALPBFILE(53.70213,"+"_ALPBNEXT_","_ALPBFIEN,4)=""
 ..S ALPBFILE(53.70213,"+"_ALPBNEXT_","_ALPBFIEN,5)=""
 ..S ALPBFILE(53.70213,"+"_ALPBNEXT_","_ALPBFIEN,6)=""
 .;
 .D UPDATE^DIE("","ALPBFILE","ALPBNEXT","ERR")
 Q
 ;
PV1(IEN,DATA,FS,CS,ERR) ; process PV1 (patient visit/movement) segment...
 I +$G(IEN)=0!($G(DATA)="") D ERRBLD^ALPBUTL1("PV1","",.ERR) Q
 N ALPBFIEN,ALPBFILE,ALPBX
 S ALPBFIEN=IEN_","
 S ALPBX=$P(DATA,FS,4)
 ; ward...
 S ALPBFILE(53.7,ALPBFIEN,4)=$P(ALPBX,CS)
 ; room...
 S ALPBFILE(53.7,ALPBFIEN,5)=$P(ALPBX,CS,2)
 ; bed...
 S ALPBFILE(53.7,ALPBFIEN,6)=$P(ALPBX,CS,3)
 D FILE^DIE("","ALPBFILE","ERR")
 Q
 ;
RXO(IEN,OIEN,DATA,FS,CS,ERR) ; process RXO (pharmacy prescription order) segment...
 ; for inpatient meds, this segment contains an orderable item.  this
 ; module is ONLY called if the order is "P"ending.  it only files the
 ; orderable item if no drug is on file for the order.
 N ALPBDIEN,ALPBDRUG,ALPBFILE,ALPBNEXT
 I +$G(IEN)'>0!(+$G(OIEN)'>0)!($G(DATA)="")!($G(FS)="")!($G(CS)="") D ERRBLD^ALPBUTL1("RXO","",.ERR) Q
 S ALPBDIEN=+$P($P(DATA,FS,2),CS,4)
 S ALPBDRUG=$P($P(DATA,FS,2),CS,5)
 I ALPBDIEN'>0 D ERRBLD^ALPBUTL1("RXO","Invalid drug IEN in RXO segment",.ERR) Q
 ; if there is ANY drug already on file, quit...
 I +$O(^ALPB(53.7,IEN,2,OIEN,7,0))>0 Q
 ; if not, file it...
 S ALPBNEXT=+$O(^ALPB(53.7,IEN,2,OIEN,7," "),-1)+1
 S ALPBFILE(53.703,"+"_ALPBNEXT_","_OIEN_","_IEN_",",.01)=ALPBDIEN
 S ALPBFILE(53.703,"+"_ALPBNEXT_","_OIEN_","_IEN_",",1)=ALPBDRUG
 D UPDATE^DIE("","ALPBFILE","ALPBNEXT","ERR")
 Q
 ;
RXE(IEN,OIEN,DATA,FS,CS,ECH,ERR) ; process RXE (order detail) segment...
 ; this segment may contain the drug name, though there may not be a drug
 ; because this can also be used for order detail for IV's which are
 ; contained in an RXC segment.  this segment can also contain start/stop
 ; date&time, dosage and schedule
 I +$G(IEN)'>0!(+$G(OIEN)'>0)!($G(DATA)="")!($G(FS)="")!($G(CS)="")!($G(ECH)="") D ERRBLD^ALPBUTL1("RXE","",.ERR) Q
 N ALPBDIEN,ALPBDRUG,ALPBFIEN,ALPBFILE,ALPBNEXT,ALPBSCHD,ALPBX,SCS
 N ALPBDOA,ALPBREMV,ALPBTIMG,ALPBADM              ;*87
 S SCS=$E(ECH,4)
 S ALPBFIEN=OIEN_","_IEN_","
 ; for drug, we'll use the one that came from the Drug file...
 S ALPBDIEN=+$P($P(DATA,FS,3),CS,4)
 S ALPBDRUG=$P($P(DATA,FS,3),CS,5)
 ; is this drug already on file for this order?  if not, add it...
 I ALPBDIEN>0&('$D(^ALPB(53.7,IEN,2,OIEN,7,"B",ALPBDIEN))) D
 .S ALPBNEXT=+$O(^ALPB(53.7,IEN,2,OIEN,7," "),-1)+1
 .S ALPBFILE(53.703,"+"_ALPBNEXT_","_ALPBFIEN,.01)=ALPBDIEN
 .S ALPBFILE(53.703,"+"_ALPBNEXT_","_ALPBFIEN,1)=ALPBDRUG
 .D UPDATE^DIE("","ALPBFILE","ALPBNEXT","ERR")
 .K ALPBFERR,ALPBFILE,ALPBNEXT
 S ALPBX=$P(DATA,FS,2)
 ; start date/time...
 S ALPBFILE(53.702,ALPBFIEN,4)=$$FMDATE^HLFNC($P(ALPBX,CS,4))
 ; stop date/time...
 S ALPBFILE(53.702,ALPBFIEN,4.1)=$$FMDATE^HLFNC($P(ALPBX,CS,5))
 ; dosage...
 S ALPBFILE(53.702,ALPBFIEN,7)=$P(ALPBX,CS,8)
 ; schedule...   alter getting directly from RXE.1.2 pieces       ;*87
 S ALPBTIMG=$P(ALPBX,CS,2)
 S ALPBSCHD=$$UNESC^ALPBGEN($P(ALPBTIMG,SCS,1))
 S ALPBREMV=$P(ALPBTIMG,SCS,3)
 S ALPBDOA=$P(ALPBTIMG,SCS,4)
 ; end                                                            ;*87
 I $P(DATA,FS,24)'="" S ALPBSCHD=ALPBSCHD_" "_$P(DATA,FS,24)
 I $P($P(DATA,FS,25),CS,5)'="" S ALPBSCHD=ALPBSCHD_" "_$P($P(DATA,FS,25),CS,5)
 S ALPBFILE(53.702,ALPBFIEN,7.2)=ALPBSCHD
 ; timing...
 ;convert adm & rem times to 4 digit, store them & DOA to 53.7     *87
 S ALPBADM=$P($P(DATA,FS,22),CS,2)
 S:+ALPBADM ALPBADM=$$CNVRT4(ALPBADM,"-")
 S:+ALPBREMV ALPBREMV=$$CNVRT4(ALPBREMV,"-")
 S ALPBFILE(53.702,ALPBFIEN,7.3)=ALPBADM
 S ALPBFILE(53.702,ALPBFIEN,7.4)=ALPBREMV
 S ALPBFILE(53.702,ALPBFIEN,7.5)=ALPBDOA
 ;
 D UPDATE^DIE("","ALPBFILE","","ERR")
 Q
 ;
RXR(IEN,OIEN,DATA,FS,CS,ERR) ; process RXR (med administration route) segment...
 I +$G(IEN)'>0!(+$G(OIEN)'>0)!($G(DATA)="")!($G(FS)="")!($G(CS)="") D ERRBLD^ALPBUTL1("RXR","",.ERR) Q
 N ALPBFILE
 ; route...
 S ALPBFILE(53.702,OIEN_","_IEN_",",7.1)=$P($P(DATA,FS,2),CS,5)
 D UPDATE^DIE("","ALPBFILE","","ERR")
 Q
 ;
RXC(IEN,OIEN,DATA,FS,CS,ERR) ; process RXC (IV orders: additives/solutions) segment...
 I +$G(IEN)'>0!(+$G(OIEN)'>0)!($G(DATA)="")!($G(FS)="")!($G(CS)="") D ERRBLD^ALPBUTL1("RXC","",.ERR) Q
 N ALPBFILE,ALPBFNOD,ALPBGNOD,ALPBNAM,ALPBNEXT,ALPBNUM,ALPBTYP,ALPBUNIT
 S ALPBTYP=$P(DATA,FS,2)
 S ALPBGNOD=$S(ALPBTYP="A":8,ALPBTYP="B":9,1:0)
 I ALPBGNOD=0 D ERRBLD^ALPBUTL1("RXC","Unable to determine Additive or Solution in RXC segment",.ERR) Q
 S ALPBFNOD="53.7021"_$S(ALPBGNOD=8:1,1:2)
 S ALPBNUM=$P($P(DATA,FS,3),CS,4)
 ; is this additive or solution already on file?...
 I $D(^ALPB(53.7,IEN,2,OIEN,ALPBGNOD,"B",ALPBNUM)) S ERR("DIERR")=0 Q
 ; if not, file it...
 S ALPBNAM=$P($P(DATA,FS,3),CS,5)
 S ALPBUNIT=$P(DATA,FS,4)_$P($P(DATA,FS,5),CS,5)
 S ALPBNEXT=+$O(^ALPB(53.7,IEN,2,OIEN,ALPBGNOD," "),-1)+1
 S ALPBFILE(ALPBFNOD,"+"_ALPBNEXT_","_OIEN_","_IEN_",",.01)=ALPBNUM
 S ALPBFILE(ALPBFNOD,"+"_ALPBNEXT_","_OIEN_","_IEN_",",1)=ALPBNAM
 S ALPBFILE(ALPBFNOD,"+"_ALPBNEXT_","_OIEN_","_IEN_",",2)=ALPBUNIT
 D UPDATE^DIE("","ALPBFILE","ALPBNEXT","ERR")
 Q
 ;
NTE(IEN,OIEN,DATA,FS,CS,ERR) ; process NTE (note) segment...
 ; note: in the case of NTE segments, DATA is passed in as an array.
 ; NTE data can be in multiple nodes, the first subscript of which
 ; contains the actual NTE segments itself.
 I +$G(IEN)'>0!(+$G(OIEN)'>0)!($D(DATA)=0)!($G(FS)="")!($G(CS)="") D ERRBLD^ALPBUTL1("NTE","",.ERR) Q
 N ALPBFILE,I
 ; check the status of this order.  if it is pending, abort
 ; and do not file any special comments (note ORC module comments)...
 I $E($P($G(^ALPB(53.7,IEN,2,OIEN,0)),"^",3),1,2)="IP" Q
 ; examine DATA(1) and from the Pharmacy package code in the second
 ; field, insert a header at the first subscript level of our working
 ; array (which we will pass to the FileMan call)...
 S ALPBFILE(1)=$S($P(DATA(1),FS,2)=6:"Provider Comments:",$P(DATA(1),FS,2)=21:"Special Instructions:",1:"Other Info:")
 ;
 ;*69  Rebuild the WP Instructions from the formatted NTE segment.
 ;     The NTE text will be put into the DATA array and can contain
 ;     the escape character \.br\ for line break.  The line break will
 ;     allow this routine to store the WP text exactly how the Rph
 ;     keyed it in IM backdoor.  They may have keyed in hard returns
 ;     and spaces, so to create an aligned columnar table, i.e.
 ;     an Insulin sliding scale.
 S DATA(1)=$P(DATA(1),FS,4)     ;reset DATA(1) from piece 4 of DATA(1)
 ;
 ; Unwrap DATA array into one large field, 64k is limit
 N ALEN,DLEN,ELEN,QUIT,ALLTXT,NEWALPB
 S QUIT=0,ALLTXT=""
 ;
 ; Put formatted NTE array together as one line up to 64k
 F I=0:0 S I=$O(DATA(I)) Q:'I  D  Q:QUIT
 .S ALEN=$L(ALLTXT),DLEN=$L(DATA(I))
 .I ALEN+DLEN>65536 S ELEN=65536-ALEN S ALLTXT=ALLTXT_$E(DATA(I),1,ELEN) S QUIT=1 Q
 .S ALLTXT=ALLTXT_DATA(I)
 ;
 ; Build new work array from the formatted lines of the large field
 D HL7FMT(ALLTXT,.NEWALPB)
 ;
 ; Now add back to the text of the new working array into the original
 ; work array beginning with element 2, as element 1 has the heading
 ; 129 Added condition to check if Other Info and get P4 on line 1
 ; ex. line 1(NEWALPB)has NTE^21^L^TEST order for ZZTEST patient
 ; the rest does not had NTE^21^L segment so get the whole piece
 ; 
 I ALPBFILE(1)="Other Info:" F I=0:0 S I=$O(NEWALPB(I)) Q:'I  D
 . I I=1 S ALPBFILE(I+1)=$P(NEWALPB(I),"^",4)
 . I I>1 S ALPBFILE(I+1)=NEWALPB(I)
 I ALPBFILE(1)'="Other Info:" F I=0:0 S I=$O(NEWALPB(I)) Q:'I  S ALPBFILE(I+1)=NEWALPB(I)
 ;
 ; Store new WP text to field 8
 D WP^DIE(53.702,OIEN_","_IEN_",",8,"","ALPBFILE","ERR")
 Q
 ;
ZZZ(IEN,OIEN,DATA,FS,CS,ERR) ; process Hazardous Drug flags segment                                   *108
 I +$G(IEN)'>0!(+$G(OIEN)'>0)!($G(DATA)="")!($G(FS)="")!($G(CS)="") D ERRBLD^ALPBUTL1("ORC","",.ERR) Q
 N ALPBFIEN,ALPBFILE
 S ALPBFIEN=OIEN_","_IEN_","
 S ALPBFILE(53.702,ALPBFIEN,14)=$S($P(DATA,FS,5)="Y":1,1:0)  ;HAZ Handle
 S ALPBFILE(53.702,ALPBFIEN,15)=$S($P(DATA,FS,6)="Y":1,1:0)  ;HAZ Dispose
 D UPDATE^DIE("","ALPBFILE","","ERR")
 Q
 ;
HL7FMT(NEWLN,AR) ;Unwrap formatted text array lines into a new array
 ;  the escape character, \.br\ ,will cause a new array element to
 ;  begin with the text after the escape character.
 N ESC,LIN,LN,QUIT,I
 S QUIT=0
 F I=1:1 S LN=NEWLN D  Q:QUIT
 . S ESC=$F(LN,"\.br\")
 . I ESC=6 S LIN="",NEWLN=$E(LN,ESC,65536) S AR(I)=LIN Q
 . I ESC=0 S LIN=NEWLN,NEWLN="" S AR(I)=LIN,QUIT=1 Q
 . S LIN=$E(LN,1,ESC-6)
 . S NEWLN=$E(LN,ESC,65536)
 . S AR(I)=LIN
 Q
 ;
CNVRT4(STR,SEP) ;Converts a time string to 4 digit for consistency
 ;  STR - string of times
 ;  SEP - seperator character between times
 ;
 N QQ
 F QQ=1:1:$L(STR,SEP) S $P(STR,SEP,QQ)=$E($P(STR,SEP,QQ)_"0000",1,4)
 Q STR
