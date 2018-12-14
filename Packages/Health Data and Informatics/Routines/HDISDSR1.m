HDISDSR1 ;BPFO/DTG - HDI MAILMAN SERVER COLLECT SDO DATA; Apr 07, 2018@12:42
 ;;1.0;HEALTH DATA & INFORMATICS;**22**;Feb 22, 2005;Build 26
 ;
 ;
INIT ; initialize vars and file
 ;
 ; Uses ICR 5812 to read file 4.3 field 8.3
 ;
 K @HDISV
 S HDITXT=0,HDICRLF=$C(13,10),HDITAB=$C(9),HDIJB=$J,U="^"
 S HDISTR=""
 S HDISITE=$$SITE^VASITE,HDISTN=$P(HDISITE,"^",2),HDIST=$P(HDISITE,"^",3)
 I HDIST="" S HDIST="???"
 ;
 S HDISUB=$$UP^XLFSTR(XQSUB)
 ;get max lines and make character count
 N A,B S A=$$GET1^DIQ(4.3,"1,",8.3,"I") S B=$S((+A=0):5469,(A>15000):15000,1:A)
 S HDIMAX=((B*250)-((B*250)*.3))\1
 ;
 Q
 ;
MAILSEND(HDISUBJ) ; Send extract back to requestor.
 ;
 N HDINSTR,HDITASK,HDITO,XMERR,XMZ,A
 ;
 ;ZEXCEPT: XQSND
 ;
 ;S 1=1
 S HDITO(XQSND)=""
 S HDINSTR("ADDR FLAGS")="R"
 S HDINSTR("FROM")="HDI_SDO_CODES"
 S HDISUBJ=$E(HDISUBJ,1,65)
 D SENDMSG^XMXAPI(.5,HDISUBJ,"^TMP($J,""HDIDATA"")",.HDITO,.HDINSTR,.HDITASK)
 S A=$G(^DTGHD("A",0)),A=A+1,^DTGHD("A",0)=A,^DTGHD("A",A)=HDITASK
 Q
 ;
ENCODE(HDISTR) ; Encode a string, keep remainder for next line
 ; Call with ORSTR by reference, Remainder returned in LRSTR
 ;
 S HDIQUIT=0,HDILEN=$L(HDISTR)
 F  D  Q:HDIQUIT
 . I $L(HDISTR)<45 S HDIQUIT=1 Q
 . S HDIX=$E(HDISTR,1,45),LT=LT+$L(HDIX)
 . S HDINODE=HDINODE+1,@HDISV@(HDINODE)=$$UUEN(HDIX)
 . S HDISTR=$E(HDISTR,46,HDILEN)
 Q
 ;
UUEN(STR) ; Uuencode string passed in.
 N J,K,LEN,HDII,HDIX,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F HDII=1:3:LEN D
 . S HDIX=$E(STR,HDII,HDII+2)
 . I $L(HDIX)<3 S HDIX=HDIX_$E("   ",1,3-$L(HDIX))
 . S S=$A(HDIX,1)*256+$A(HDIX,2)*256+$A(HDIX,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
UUBEGFN(HDFILENM) ; Construct uuencode "begin" coding
 ; Call with HDFILENM = name of uuencoded file attachment
 ; 
 ; Returns HDIX = string with "begin..."_file name
 ;
 N HDIX
 S HDIX="begin 644 "_HDFILENM
 Q HDIX
 ;
 ;
SETDATA ; Set data into report structure
 S HDINODE=$O(^TMP($J,"HDIDATA",""),-1)
 I HDITXT S HDINODE=HDINODE+1,@HDISV@(HDINODE)=HDISTR,HDISTR="" Q
 I 'HDITXT D ENCODE(.HDISTR)
 Q
 ;
CLEAN ; clean up
 D CLEAN^HDISDSR
 D ^%ZISC
 Q
 ;
DISER ; display return error type
 I RERROR=0 Q
 N MSG,A,I,B,J,RR
 ; remove multi's of repeating error #'s
 F I=1:1 S A=$P(RERROR,",",I) Q:A=""  S B(A)=""
 ;
 S J=$O(@HDISV@(""),-1),J=J+1
 S @HDISV@(J)=$$UUBEGFN(HDIFER)
 S HDISTR="ERROR ITEMS FROM HDI SDO LOOKUP"_HDICRLF
 D SETDATA
 S A=0 F  S A=$O(B(A)) Q:'A  S HDISTR=HDISTR_A_") "_$P($T(DISTXT+A),";",3)_HDICRLF D SETDATA
 I $O(RERRARY(0))>0 D  ;<
 . S HDISTR=HDISTR_HDICRLF_"Error Array Display"_HDICRLF D SETDATA
 . S A=0 F  S A=$O(RERRARY(A)) Q:'A  S HDISTR=HDISTR_RERRARY(A)_HDICRLF D SETDATA
 I HDISTR'="" S HDINODE=HDINODE+1,@HDISV@(HDINODE)=$$UUEN(HDISTR)
 S @HDISV@(HDINODE+1)=" "
 S @HDISV@(HDINODE+2)="end"
 Q
 ;
DISTXT ; error text
 ;;Area Not Sent.
 ;;Lookup Value Not Sent.
 ;;Return Value Not Sent.
 ;;Improper Search Area
 ;;Single Item Not Found in ORDERABLE ITEMS File 101.43.
 ;;Single Item Not in Area.
 ;;Partial Lookup Error.
 ;;Orderable Items File Does Not Have Lab Pointer for Item.
 ;;Orderable Item Lab Pointer Not Found in Lab File.
 ;;
 ;;
 ;;Type of Lookup not Sent
