RGUTDT ;CAIRO/DKM - FM date to formatted date;04-Sep-1998 12:46;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Inputs:
 ;   RGDAT = date to format (DHCP format or $H format)
 ;   RGFMT = date and time format control (optional)
 ;      xxx0 = dd-mmm-yyyy
 ;      xxx1 = mmm dd,yyyy
 ;      xxx2 = mm/dd/yyyy
 ;      xxx3 = mm-dd-yyyy
 ;      xx0x = hh:mm
 ;      xx1x = hh:mm xx
 ;      x0xx = use space to separate date/time
 ;      x1xx = use @ to separate date/time
 ;      0xxx = allow leading zeros
 ;      1xxx = remove leading zeros
 ; Outputs:
 ;   Returns formatted date
 ;=================================================================
ENTRY(RGDAT,RGFMT) ;
 S RGDAT=$G(RGDAT,$H)
 Q:'RGDAT ""
 N RGZ1,RGZ2,RGZ3,RGZ4,RGDLM,RGTM
 S:RGDAT?1.N1",".N RGDAT=$$HTFM^XLFDT(RGDAT)
 S RGFMT=$G(RGFMT)#100000,RGFMT=RGFMT#10000,RGZ4=RGFMT\1000,RGFMT=RGFMT#1000,RGDLM=$S(RGFMT>99:"@",1:" "),RGFMT=RGFMT#100,RGTM=RGFMT\10,RGFMT=RGFMT#10
 I RGDAT\1 D
 .S RGZ3=RGDAT\1+17000000,RGZ1=$E(RGZ3,7,8),RGZ2=$E(RGZ3,5,6),RGZ3=$E(RGZ3,1,4)
 .S:RGZ4 RGZ1=+RGZ1,RGZ2=+RGZ2
 .S:RGFMT<2 RGZ2=$P("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",",",RGZ2)
 .S RGZ1=$S('RGFMT:RGZ1_"-"_RGZ2_"-"_RGZ3,RGFMT=1:RGZ2_" "_RGZ1_","_RGZ3,RGFMT=2:RGZ2_"/"_RGZ1_"/"_RGZ3,1:RGZ2_"-"_RGZ1_"-"_RGZ3)
 E  S RGZ1=""
 S RGZ2=RGDAT#1*10000+10000\1
 I RGZ2=10000!(RGZ2>12400) S RGZ2=""
 E  D
 .S:RGTM RGZ2=$S(RGZ2=12400:RGZ2-1200_" am",RGZ2>11299:RGZ2-1200_" pm",RGZ2>11199:RGZ2_" pm",RGZ2<10099:RGZ2+1200_" am",1:RGZ2_" am")
 .S RGZ3=$S(RGZ4:+$E(RGZ2,2,3),1:$E(RGZ2,2,3)),RGZ2=RGZ3_":"_$E(RGZ2,4,8)
 Q RGZ1_$S('$L(RGZ2):"",$L(RGZ1):RGDLM,1:"")_RGZ2
