XLFIPV ;ISD/HGW - IPv4 and IPv6 Utilities ;06/17/14  08:20
 ;;8.0;KERNEL;**605,638**;Aug 6, 2012;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
VALIDATE(IP) ; EXTRINSIC. ICR #5844 (supported)
 ; Validate the format of an IP address (either IPv4 or IPv6).
 ; Usage:  S Y=$$VALIDATE^XLFIPV(IP)
 ; Input:  IP (string) - IPv4 or IPv6 Address to be validated.
 ; Output: returns:
 ;           1 - if the IP address is in a valid format.
 ;           0 - if the format is invalid or null input.
 ;
 N I,J,X,XLFIELD
 S X=1
 I '$D(IP) Q 0
 I IP?1.3N1P1.3N1P1.3N1P1.3N1P.N S IP=$P(IP,":",1) ;p638 Strip off port information from IPv4 address
 ; If IP address contains both ":" and "." delimiters, then check IPv4 embedded in IPv6.
 I (IP[":")&(IP[".") D  Q X  ; IPv4-Mapped.
 . S IP=$$EXPAND6(IP,6) I IP="" S X=0 Q  ; Change the format of the first six high-order bytes
 . F I=1:1:6 Q:X=0  D  ; Examine field by field, first six bytes
 . . S X=$$EXAMINE6($P(IP,":",I))
 . S XLFIELD=$P(IP,":",7) ; Get last two bytes, IPv4 format
 . F I=1:1:4 Q:X=0  D  ; Examine field by field, last two bytes
 . . S X=$$EXAMINE4($P(XLFIELD,".",I))
 ; If IP address contains ":" delimiter, then IPv6. Otherwise IPv4.
 I IP[":" D  Q X  ; IPv6 address
 . S IP=$$EXPAND6(IP,7) I IP="" S X=0 Q  ; Change to a common format
 . F I=1:1:8 Q:X=0  D  ; Examine field by field
 . . S X=$$EXAMINE6($P(IP,":",I))
 I IP'[":" D  Q X  ; IPv4 address
 . S IP=$$EXPAND4(IP) ; Change to a common format
 . F I=1:1:4 Q:X=0  D  ; Examine field by field
 . . S X=$$EXAMINE4($P(IP,".",I))
 Q 0
 ;
FORCEIP4(IP) ; EXTRINSIC. ICR #5844 (supported)
 ; Convert an IP address (either IPv4 or IPv6) into an IPv4 address in a standardized format: "127.0.0.1".
 ; Usage:  S Y=$$FORCEIP4^XLFIPV(IP)
 ; Input:  IP (string) IPv4 or IPv6 Address to be converted.
 ; Output: returns:  An IPv4 address in "ddd.ddd.ddd.ddd" notation if the input address is valid and has an
 ;           IPv4 equivalent, or the null address "0.0.0.0" if the input address is invalid, or the null address
 ;           "0.0.0.0" if an IPv6 address is input which does not have an IPv4 equivalent.
 ;
 N I,XLFIELD,XLMAP
 ; Return null address "0.0.0.0" if address is invalid
 Q:'$$VALIDATE(IP) "0.0.0.0"
 I IP?1.3N1P1.3N1P1.3N1P1.3N1P.N S IP=$P(IP,":") ;p638 Strip off port information from IPv4 address
 S XLMAP="0000:0000:0000:0000:0000:FFFF:"
 ; If IP address contains both ":" and "." delimiters, then IPv4-Mapped IPv6 address.
 I (IP[":")&(IP[".") D  Q IP  ; IPv4-Mapped.
 . S IP=$$EXPAND6(IP,6) I IP="" S IP="0.0.0.0" Q  ; Change the format of the first six high-order bytes
 . S IP=$$EXPAND4($E(IP,31,49)) ; Get last two bytes, IPv4 format (not interested in first six bytes)
 I IP[":" D  Q IP  ; IPv6 address (last two bytes might be IPv4-Mapped)
 . S IP=$$EXPAND6(IP,7) I IP="" S IP="0.0.0.0" Q  ; Change the format to standardized
 . I IP="0000:0000:0000:0000:0000:0000:0000:0001" S IP="127.0.0.1" Q  ; Loopback address
 . I $E(IP,1,30)'=XLMAP S IP="0.0.0.0" Q  ; Invalid IPv4-Mapped address
 . S IP=$$DEC^XLFUTL($E(IP,31,32),16)_"."_$$DEC^XLFUTL($E(IP,33,34),16)_"."_$$DEC^XLFUTL($E(IP,36,37),16)_"."_$$DEC^XLFUTL($E(IP,38,39),16)
 I IP'[":" D  Q IP  ; IPv4 address
 . S IP=$$EXPAND4(IP) ; Change to a common format
 Q "0.0.0.0"
 ;
FORCEIP6(IP) ; EXTRINSIC. ICR #5844 (supported)
 ; Convert an IP address (either IPv4 or IPv6) into an IPv6 address in a standardized format: "2001:0DB8:0000:0000:0000:8A2E:0370:7334".
 ; Usage:  S Y=$$FORCEIP6^XLFIPV(IP)
 ; Input:  IP (string) IPv4 or IPv6 Address to be converted.
 ; Output: returns:  An IPv6 address in "hhhh:hhhh:hhhh:hhhh:hhhh:hhhh:hhhh:hhhh" notation if the
 ;           input address is valid, or the null address "::0" if the input address is invalid.
 ;
 N XLMAP
 ; Return expanded null address "0000:0000:0000:0000:0000:0000:0000:0000" if address is invalid
 Q:'$$VALIDATE(IP) "0000:0000:0000:0000:0000:0000:0000:0000"
 S XLMAP="0000:0000:0000:0000:0000:FFFF:"
 I IP?1.3N1P1.3N1P1.3N1P1.3N1P.N S IP=$P(IP,":") ;p638 Strip off port information from IPv4 address
 ; If IP address contains both ":" and "." delimiters, then IPv4 embedded in IPv6.
 I (IP[":")&(IP[".") D  Q IP  ; IPv4-Mapped address.
 . S IP=$$EXPAND6(IP,6) I IP="" S IP="0.0.0.0" Q  ; Change the format of the first six high-order bytes
 . S IP=$E(IP,1,30)_$$CNVF($$EXPAND4($E(IP,31,49))) ; Get last two bytes, IPv4 format -> IPv4-Mapped Address
 ; If IP address contains ":" delimiter, then IPv6. Otherwise IPv4.
 I IP[":" D  Q IP  ; IPv6 address
 . S IP=$$EXPAND6(IP,7) I IP="" S IP="0000:0000:0000:0000:0000:0000:0000:0000" Q  ; Change to a common format
 I IP'[":" D  Q IP  ; IPv4 address
 . S IP=XLMAP_$$CNVF($$EXPAND4(IP)) ; IPv4-Mapped IPv6 Address
 . I IP="0000:0000:0000:0000:0000:FFFF:0000:0000" S IP="0000:0000:0000:0000:0000:0000:0000:0000" Q  ; Null address
 . I IP="0000:0000:0000:0000:0000:FFFF:7F00:0001" S IP="0000:0000:0000:0000:0000:0000:0000:0001" Q  ; Loopback address
 Q IP
 ;
CONVERT(IP) ; EXTRINSIC. ICR #5844 (supported)
 ; Convert an IP address (either IPv4 or IPv6) into an IPv6 address in a standardized format, either IPv4 or IPv6 depending
 ;   upon the Cache system settings.
 ; Usage:  S Y=$$CONVERT^XLFIPV(IP)
 ; Input:  IP (string) IPv4 or IPv6 Address to be converted.
 ; Output: returns:
 ;           - An IPv4 address if IPv6 is disabled on the system.
 ;           - An IPv6 address if IPv6 is enabled on the system.
 ;           - An IPv4 or IPv6 null address if the input cannot be converted.
 ;
 N XLV6
 S XLV6=$$VERSION() ; Is IPv6 enabled on this system?
 I XLV6=1 S IP=$$FORCEIP6(IP) ; Yes
 I XLV6=0 S IP=$$FORCEIP4(IP) ; No
 Q IP
 ;
VERSION() ; EXTRINSIC. ICR #5844 (supported)
 ; Determine the Cache system settings for IPv6.
 ; Usage:  S Y=$$VERSION^XLFIPV()
 ; Input:  None.
 ; Output: returns:
 ;           1 - if IPv6 is enabled.
 ;           0 - if IPv6 is disabled.
 ;
 N %
 S %=0
 I $$VERSION^%ZOSV(1)["Cache" I +$$VERSION^%ZOSV()>2009 S %=$SYSTEM.Process.IPv6Format()
 Q %
 ;
VAL ; OPTION. "Validate IPv4 and IPv6 address" [XLFIPV VALIDATE]
 N DIR,X,XLFX
 S DIR(0)="F^3:60",DIR("A")="Enter an IP address to be validated",DIR("B")="127.0.0.1"
 S DIR("?")="   Validate the format of an IP address."
 S DIR("??")="^D VALH^XLFIPV"
 D ^DIR S XLFX=$$VALIDATE(X)
 I XLFX=0 W !!,?3,X," is NOT a valid address."
 I XLFX=1 W !!,?3,X," is a valid address."
 Q
 ;
VALH ; Extended help for VAL^XLFIPV
 W !!,"   This option will validate the format of an IP address (either IPv4 or IPv6)"
 W !,"   and return ""IP is NOT a valid address"" if the address is in an invalid"
 W !,"   format, or return ""IP is a valid address"" if the format is correct."
 Q
 ;
IP4 ; OPTION. "Convert any IP address to IPv4" [XLFIPV FORCEIP4]
 N DIR,X
 S DIR(0)="F^3:60",DIR("A")="Enter an IP address to be converted to IPv4",DIR("B")="127.0.0.1"
 S DIR("?")="   Convert an IP address into an IPv4 address in a standardized format."
 S DIR("??")="^D IP4H^XLFIPV"
 D ^DIR W !!,?3,$$FORCEIP4(X)
 Q
 ;
IP4H ; Extended help for IP4^XLFIPV
 W !!,"   This option will take an IP address (either IPv4 or IPv6) and return an"
 W !,"   IPv4 address in a standardized format.  It will return the null address"
 W !,"   0.0.0.0 if the passed IP address is invalid.  If an IPv6 address is input"
 W !,"   which does not have a valid IPv4 equivalent, the null address will be"
 W !,"   returned."
 Q
 ;
IP6 ; OPTION. "Convert any IP address to IPv6" [XLFIPV FORCEIP6]
 N DIR,X
 S DIR(0)="F^3:60",DIR("A")="Enter an IP address to be converted to IPv6",DIR("B")="127.0.0.1"
 S DIR("?")="   Convert an IP address into an IPv6 address in a standardized format."
 S DIR("??")="^D IP6H^XLFIPV"
 D ^DIR W !!,?3,$$FORCEIP6(X)
 Q
IP6H ; Extended help for IP6^XLFIPV
 W !!,"   This option will take an IP address (either IPv4 or IPv6) and return an"
 W !,"   IPv6 address in a standardized format.  It will return the null address"
 W !,"   ::0 if the passed IP address is invalid."
 Q
 ;
CON ; OPTION. "Convert any IP address per system settings" [XLFIPV CONVERT]
 N DIR,X
 S DIR(0)="F^3:60",DIR("A")="Enter an IP address to be converted",DIR("B")="127.0.0.1"
 S DIR("?")="   Convert an IP address depending upon system settings."
 S DIR("??")="^D CONH^XLFIPV"
 D ^DIR W !!,?3,$$CONVERT(X)
 Q
CONH ; Extended help for CON^XLFIPV
 W !!,"   This option will take an IP address (either IPv4 or IPv6) and return an"
 W !,"   IP address in a standardized format, depending on system settings.  If"
 W !,"   IPv6 is disabled on the system, an IPv4 address will be returned.  If"
 W !,"   IPv6 is enabled on the system, an IPv6 address will be returned.  If an"
 W !,"   invalid address is entered, a null address will be returned.  If an IPv6"
 W !,"   is entered, IPv6 is not enabled, and the input address does not have an"
 W !,"   IPv4 equivalent, a null address will be returned."
 Q
 ;
VER ; OPTION. "Show system settings for IPv6" [XLFIPV VERSION]
 N X,XLSYS,XLVER
 S X=$$VERSION,XLSYS=$$VERSION^%ZOSV(1),XLVER=+$$VERSION^%ZOSV()
 W !!,?3,XLSYS," ",XLVER
 I X=0 D  Q
 . I XLSYS["Cache" D  Q
 . . I XLVER>2009 W !!,"   IPv6 is available but is disabled on this system." Q
 . . W !!,"   IPv6 is not available on this version of Cache."
 . W !!,"   IPv6 is not available on this system."
 I X=1 W !!,"   IPv6 is enabled on this system."
 Q
 ;
EXPAND4(IP) ; INTRINSIC.
 ; Changes the format of an IPv4 address to a common format that can be validated
 ; Usage:  S Y=$$EXPAND4^XLFIPV(IP)
 ; Input:  IP (string) IPv4 address to be reformatted.
 ; Output: returns:  An IPv4 address in the format "nnn.nnn.nnn.nnn".
 ;
 N I,XLFIELD
 ; Expand hexadecimal address to IPv4 dotted hexadecimal: "0xc0a8010a" -> "0xc0.0xa8.0x10.0x0a"
 I ($E(IP,1,2)="0x")&(IP'[".") D
 . S IP="0x"_$E(IP,3,4)_".0x"_$E(IP,5,6)_".0x"_$E(IP,7,8)_".0x"_$E(IP,9,10)
 F I=1:1:4 D  ; Examine field by field
 . S XLFIELD=$P(IP,".",I)
 . ; Convert dotted hexadecimal address to IPv4 dotted decimal: "0xc0.0xa8.0x10.0x0a" -> "192.168.16.10"
 . I $E(XLFIELD,1,2)="0x" S XLFIELD=$$DEC^XLFUTL($$UP^XLFSTR($E(XLFIELD,3,4)),16) ; Convert HEX field to DEC
 . S $P(IP,".",I)=XLFIELD
 ; Convert dotted octal address to IPv4 dotted decimal: "0300.0000.0002.0353" -> "192.0.2.235"
 I IP?4N1"."4N1"."4N1"."4N D
 . S IP=$$DEC^XLFUTL($E(IP,1,4),8)_"."_$$DEC^XLFUTL($E(IP,6,9),8)_"."_$$DEC^XLFUTL($E(IP,11,14),8)_"."_$$DEC^XLFUTL($E(IP,16,19),8)
 Q IP
 ;
EXPAND6(IP,ZNUM) ; INTRINSIC.
 ; Changes the format of an IPv6 address to a common format that can be validated
 ; Usage:  S Y=$$EXPAND6^XLFIPV(IP)
 ; Input:  IP (string) IPv6 address to be reformatted.
 ;         ZNUM The number of expected colons
 ; Output: returns:  An IPv6 address in the format "hhhh:hhhh:hhhh:hhhh:hhhh:hhhh:hhhh:hhhh".
 ;
 N I,XLBLANK,XLCNT,XLFIELD
 S IP=$P($G(IP),"%") ;p638 Remove routing information
 I IP[":::" S IP="" Q IP  ; Cannot contain :::
 I $E(IP,1)="[" S IP=$P($P(IP,"[",2),"]") ; Strip brackets [] from around an address string
 S XLCNT=ZNUM-($L(IP)-$L($TR(IP,":",""))) ; Count the number of colons needed to be added in short form address
 I (XLCNT>0)&(IP'["::") S IP="" Q IP  ; If missing a colon, but no "::", then return "" for invalid address
 I XLCNT>0 S XLBLANK="" S IP=$P(IP,"::",1)_$TR($JUSTIFY(XLBLANK,XLCNT+2)," ",":")_$P(IP,"::",2) ; Expand ::
 F I=1:1:(ZNUM+1) D  ; Examine field by field
 . S XLFIELD=$$UP^XLFSTR($P(IP,":",I))
 . S XLFIELD=$TR($JUSTIFY(XLFIELD,4)," ","0") ; Add leading zeros
 . S $P(IP,":",I)=XLFIELD
 Q IP
 ;
EXAMINE4(XLFIELD) ; INTRINSIC.
 ; Examine a single field of an IPv4 address for a valid format
 ; Usage:  S Y=$$EXAMINE4^XLFIPV(XLFIELD)
 ; Input:  XLFIELD (string) Field to be examined.
 ; Output: returns:
 ;           1 - if the field is valid.
 ;           0 - if the field is invalid.
 ;
 I XLFIELD'?1.3N Q 0  ; Test format NNN
 I (XLFIELD>255)!(XLFIELD<0) Q 0  ; Test address range
 Q 1
 ;
EXAMINE6(XLFIELD) ; INTRINSIC.
 ; Examine a single field of an IPv6 address for a valid format
 ; Usage:  S Y=$$EXAMINE6^XLFIPV(XLFIELD)
 ; Input:  XLFIELD (string) Field to be examined.
 ; Output: returns:
 ;           1 - if the field is valid.
 ;           0 - if the field is invalid.
 ;
 N I,X
 S XLFIELD=$$UP^XLFSTR(XLFIELD) I XLFIELD'?4E Q 0  ; Test format EEEE
 S X=1 F I=1:1:4 D
 . I "0123456789ABCDEF"'[$E(XLFIELD,I) S X=0  ; Test address range, contains 0 through F characters only
 Q X
 ;
CNVF(IP) ; INTRINSIC.
 ; Expands a decimal IP address "ddd.ddd.ddd.ddd" to hexadecimal fields
 ; Usage:  S Y=$$CNVF^XLFIPV(IP)
 ; Input:  IP (string) IPv4 address to be reformatted.
 ; Output: returns:  The last two bytes of an IPv6 address in the format "hhhh:hhhh".
 ;
 N I,XLFIELD,XLOUT
 S XLOUT=""
 F I=1:1:4 D  ; Examine field by field
 . S XLFIELD=$$CNV^XLFUTL($P(IP,".",I),16)
 . S XLOUT=XLOUT_$TR($JUSTIFY(XLFIELD,2)," ","0") ; Add leading zeros
 . I I=2 S XLOUT=XLOUT_":"
 Q XLOUT
 ;
