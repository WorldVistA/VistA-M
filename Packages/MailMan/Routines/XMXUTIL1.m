XMXUTIL1 ;ISC-SF/GMB-Date & String Utilities ;04/17/2002  14:14
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2735.
ENCODEUP(XMSUBJ) ; Change ^ to ~U~
 F  Q:XMSUBJ'[U  S XMSUBJ=$P(XMSUBJ,U)_"~U~"_$P(XMSUBJ,U,2,999)
 Q XMSUBJ
DECODEUP(XMSUBJ) ; Change ~U~ to ^
 F  Q:XMSUBJ'["~U~"  S XMSUBJ=$P(XMSUBJ,"~U~")_U_$P(XMSUBJ,"~U~",2,999)
 Q XMSUBJ
SCRUB(XMSTRING) ; Strip ctrl chars and leading/trailing blanks
 S:$E(XMSTRING,1)=" "!($E(XMSTRING,$L(XMSTRING))=" ") XMSTRING=$$STRIP(XMSTRING)
 S:XMSTRING?.E1C.E XMSTRING=$$CTRL(XMSTRING)
 Q XMSTRING
STRIP(XMSTRING) ; Strip leading and trailing blanks from a string
 N I
 I $E(XMSTRING,1)=" " D
 . F I=2:1 Q:$E(XMSTRING,I)'=" "
 . S XMSTRING=$E(XMSTRING,I,999)
 I $E(XMSTRING,$L(XMSTRING))=" " D
 . F I=$L(XMSTRING):-1 Q:$E(XMSTRING,I)'=" "
 . S XMSTRING=$E(XMSTRING,1,I)
 Q XMSTRING
MAXBLANK(XMSTRING) ; Reduce 3 or more consecutive blanks in a string to 2
 F  Q:XMSTRING'["   "  D
 . S XMSTRING=$P(XMSTRING,"   ",1)_"  "_$P(XMSTRING,"   ",2,999)
 Q XMSTRING
CTRL(XMSTRING) ; Strip control characters from a string
 N I
 S I=1
 F  Q:XMSTRING'?.E1C.E  D
 . F I=I:1 Q:$E(XMSTRING,I)?1C
 . S XMSTRING=$E(XMSTRING,1,I-1)_$E(XMSTRING,I+1,999)
 Q XMSTRING
MELD(XMSTRING,XMNUMBER,XMLEN) ; Function right-justifies a string and
 ; left-justifies a number in a combined string of a given length.
 ; The string will be truncated, if necessary.
 ; e.g. $$MELD("I just love Lotus, don't you?",123,22) returns:
 ;             "I just love Lotus  123"
 Q:$G(XMNUMBER)="" $E($$LJ^XLFSTR(XMSTRING,XMLEN),1,XMLEN)
 S XMLEN=XMLEN-$L(XMNUMBER)-2
 Q $E($$LJ^XLFSTR(XMSTRING,XMLEN),1,XMLEN)_"  "_XMNUMBER
TSTAMP() ; Timestamp
 N X
 S X=$H
 Q X*86400+$P(X,",",2)
MMDT(XMDT) ; (MailMan Date/Time) Given FM date/time, return external.
 ; time is optional
 Q:XMDT'=+XMDT XMDT
 Q $$FMTE^XLFDT($E(XMDT,1,12),"2Z")  ; return mm/dd/yy@hh:mm
 N MMDT ; return dd mmm yy hh:mm
 I $E(XMDT,4,5)="00" S $E(XMDT,4,5)="01"
 I $E(XMDT,6,7)="00" S $E(XMDT,6,7)="01"
 S MMDT=$E(XMDT,6,7)_" "_$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec",U,$E(XMDT,4,5))_" "_$E(XMDT,2,3)
 S XMDT=$P(XMDT,".",2)_"0000"
 Q:'XMDT MMDT
 Q MMDT_" "_$E(XMDT,1,2)_":"_$E(XMDT,3,4)
INDT(XMDT) ; (InterNet Date/Time) Given FM date/time, return dd mmm yyyy hh:mm:ss +-hhmm (zone)
 I $E(XMDT,4,5)="00" S $E(XMDT,4,5)="01"
 I $E(XMDT,6,7)="00" S $E(XMDT,6,7)="01"
 S XMDT=$$FMTE^XLFDT(XMDT,"1S")
 ; Convert "Jun 28, 1955@10:10:00" to "28 Jun 1955 10:10:00"
 S XMDT=+$P(XMDT," ",2)_" "_$P(XMDT," ",1)_" "_+$P(XMDT," ",3)_" "_$S(XMDT["@":$P(XMDT,"@",2),1:"00:00:00")
 Q XMDT_" "_^XMB("TIMEDIFF")_" ("_^XMB("TIMEZONE")_")"
CONVERT(X,XMTIME) ; Function to convert Internet dates to FM (returns -1 if error)
 ; X         Internet date
 ; XMTIME    =1 Convert time, too; =0 convert date only
 ; Formats:  Tuesday, 28 June 1955 17:30:45 PDT
 ;           Tue, 28 Jun 1955 17:30:45 PDT
 ;           Tue 28 Jun 1955 17:30:45 PDT
 ;           28 Jun 1955 17:30:45 -0900 (PST)  <== MailMan standard
 ;           28 Jun 55 17:30 PST            <== Previous MailMan standard
 ;           Tue Jun 28 17:30:45 PDT 1955
 ;           28-JUN-1955 17:30:45 -0400
 ;           6/28/55 17:30
 ;           JUN 28 17:30 1955
 N %DT,Y,XMD,XMT
 I $E(X)=" "!($E(X)=$C(9)) F  S X=$E(X,2,99) Q:$E(X)'=$C(9)&($E(X)'=" ")  ; remove leading blanks or tabs
 I X?.E2" ".E D  ; reduce all consecutive blanks to 1 blank
 . N I S I=1
 . F  S I=$F(X,"  ",I) Q:I=0  S X=$E(X,1,I-2)_$E(X,I,99),I=I-1
 I X?3.A.E D
 . I X?3.A1", ".E!(X?3.A1" "3.A.E)!(X?3.A1" "1.2N1" "3.A.E) S X=$P(X," ",2,99) ; remove leading day of week
 I $P(X," ",3)[":" D
 . S XMD=$P(X," ",1,2)_" "_$P(X," ",$L(X," ")) ; time is before year
 . S XMT=$P(X," ",3,$L(X," ")-1)
 E  D
 . S XMD=$P(X," ",1,3) ; year is before time
 . I XMD[":" D
 . . S XMD=$P(X," ",1) ; "28-JUN-1955 17:30:45 -0400" or "6/28/55 17:30"
 . . S XMT=$P(X," ",2,99)
 . E  S XMT=$P(X," ",4,99)
 I $G(XMTIME) Q $$TIMETOO(XMD,XMT)
 S X=XMD
 D ^%DT
 Q Y
TIMETOO(XMD,XMT) ; For internal MailMan use only.  Combine date and time, adjusting for difference from GMT.
 N XMHH,XMMM,X,Y
 I $L(XMT," ")>1 D  Q:XMMM=-1 -1
 . N XMYT           ; 17:30:45 -0800 (PST)
 . S XMYT=$TR($P(XMT," ",2),"()")
 . D ZONEDIFF(XMYT,.XMHH,.XMMM)
 E  D
 . S (XMHH,XMMM)=0  ; 17:30:45
 S XMT=$P(XMT," ",1)
 S:$L($P(XMT,":"))=1 XMT="0"_XMT
 S XMT=$E(XMT,1,5)  ; FM will only handle hh:mm, not :ss
 S:XMT="00:00" XMT="00:01" ; if midnight, add a minute
 S X=XMD_"@"_XMT
 S %DT="T" D ^%DT Q:Y=-1 -1
 I 'XMHH,'XMMM Q Y
 Q $$FMADD^XLFDT(Y,"",XMHH,XMMM)
ZONEDIFF(XMYT,XMHH,XMMM) ; Given a time zone or time difference from GMT,
 ; calculates the hours and minutes difference between that zone and ours
 ; XMYT    IN:  Your Time zone or Time difference from GMT
 ; XMHH    OUT: The time difference between us in hours
 ; XMMM    OUT: The time difference between us in minutes
 ; XMYTHH  Your Time difference from GMT in hours
 ; XMYTMM  Your Time difference from GMT in minutes
 ; XMMT    My Time difference from GMT
 ; XMMTHH  My Time difference from GMT in hours
 ; XMMTMM  My Time difference from GMT in minutes
 N XMMT,XMYTHH,XMYTMM,XMMTHH,XMMTMM
 S XMMT=^XMB("TIMEDIFF")
 I XMYT=^XMB("TIMEZONE")!(XMYT=XMMT) S (XMHH,XMMM)=0 Q
 I XMYT?3A S XMYT=$$GMTDIFF(XMYT) I XMYT="" S XMMM=-1 Q
 S XMYTHH=XMYT\100
 S XMYTMM=XMYT-(XMYTHH*100)
 S XMMTHH=XMMT\100
 S XMMTMM=XMMT-(XMMTHH*100)
 S XMHH=XMMTHH-XMYTHH
 S XMMM=XMMTMM-XMYTMM
 Q
 ; Also, remember, FM will not handle a 1-digit year
 ; If this becomes a problem:
 I $L($P(X," ",3))=1 S $P(X," ",3)="0"_$P(X," ",3)
 ; *****************************************************
GMTDIFF(XMZONE) ; Given time zone, returns standard internet time difference from GMT
 ; XMZONE   3-char time zone name (PST, EDT, etc.)
 ; returns difference in hours and minutes (+-hhmm) from GMT
 ;          e.g. -0230, +1600
 ; If time zone can't be found, returns null string
 N XMIEN
 S XMIEN=$O(^XMB(4.4,"B",XMZONE,0)) Q:'XMIEN ""
 S XMDIFF=$P($G(^XMB(4.4,XMIEN,0)),U,3) Q:XMIEN="" ""
 Q $$TIMEDIFF(XMDIFF)
TIMEDIFF(XMDIFF) ; Given time difference, returns standard internet time difference.
 ; XMDIFF   Difference (in hours) from GMT
 ;          e.g. -2.5 => -0230
 ;                16  => +1600
 N XMSIGN
 I XMDIFF<0 S XMSIGN="-",XMDIFF=-XMDIFF
 E  S XMSIGN="+"
 S XMDIFF=XMDIFF\1*100+(XMDIFF#1*60\1)
 Q XMSIGN_$$RJ^XLFSTR(XMDIFF,4,"0")
CONFIRM(XMDUZ,XMZ,XMIM) ; For internal MailMan use only.  Send confirmation message to sender.
 N XMPARM,XMTO
 S XMPARM(1)=XMIM("SUBJ")
 S XMPARM(2)=XMV("NAME") S:XMDUZ'=DUZ XMPARM(2)=XMPARM(2)_$$EZBLD^DIALOG(38008,XMV("DUZ NAME")) ; (Surrogate: |1|)
 ;S XMPARM(3)=$S($D(^XMB(3.9,XMZ,5)):$P(^(5),U),1:XMZ)
 S XMTO=XMIM("FROM")
 S XMTO=$S(+XMTO=XMTO:XMTO,1:$$RCPTTO(XMZ))
 D TASKBULL^XMXBULL(XMDUZ,"XMRDACK",.XMPARM,"",XMTO)
 Q
RCPTTO(XMZ) ; For internal MailMan use only.  Return-receipt-to a remote address.
 N XMI,XMREC,XMHDR,XMTO
 S XMI=0,XMHDR=""
 F  S XMI=$O(^XMB(3.9,XMZ,2,XMI)) Q:XMI'<1!'XMI  S XMREC=^(XMI,0) D  Q:$D(XMTO)
 . Q:XMREC=""
 . S XMHDR=$P(XMREC,":") Q:XMHDR=""
 . S XMHDR=$$UP^XLFSTR(XMHDR)
 . I XMHDR="RETURN-RECEIPT-TO" S XMTO=$$SCRUB($P(XMREC,":",2,99)) Q
 S:'$D(XMTO) XMTO=$P(^XMB(3.9,XMZ,0),U,2)
 Q $$REMADDR^XMXADDR3(XMTO)
