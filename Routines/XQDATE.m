XQDATE ;SEA/MJM - Return Human Readible Date ;04/13/98  13:48
 ;;8.0;KERNEL;**71,46**;Jul 10, 1995
 ;Input: XQD1 contains $H to be converted, defaults to now if not
 ;present.  Output: % contains date in FileMan format, %Y contains
 ;date and time in Human format (Feb. 20, 1991  5:35 PM)
 ;
 ;Modified 1/27/98 to reflect Y2K corrections.
 ;
 S U="^" I '$D(XQD1) S XQD1=$H
 S %=$$HTFM^XLFDT(XQD1)
 S %Y=$$FMTE^XLFDT(%,"1P")
 K XQD1
 Q
 ;
 S %=XQD1>21608+XQD1-.1,XQD2=%\365.25+141,%=%#365.25\1,XQD3=%+306#(XQD2#4=0+365)#153#61#31+1,XQD4=%-XQD3\29+1,XQD5=XQD2_"00"+XQD4_"00"+XQD3
 S %=$P(XQD1,",",2),%=%#60/100+(%#3600\60)/100+(%\3600)/100,%=XQD5_$S(%:%,1:"")
 S XQD1="Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec"
 S %Y=$P(XQD1,U,XQD4),%Y=%Y_$S(%Y["May":"",1:".")_" "_XQD3_", "_(XQD2+1700)
 S XQD2=$E($P(%,".",2),1,4) I $L(XQD2)<4 F XQD5=0:0 S XQD2=XQD2_"0" Q:$L(XQD2)=4
 S XQD4=$S(XQD2>1159:"PM",1:"AM"),XQD3=$E(XQD2,1,2),XQD3=$S(XQD3>12:XQD3-12,1:XQD3),XQD2=$E(XQD2,3,4)
 S %Y=%Y_"  "_+XQD3_":"_XQD2_" "_XQD4
 K XQD1,XQD2,XQD3,XQD4,XQD5
 Q
