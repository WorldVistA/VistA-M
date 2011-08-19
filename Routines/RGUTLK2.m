RGUTLK2 ;CAIRO/DKM - Continuation of RGUTLKP;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
LKP(%RGDX) ;
 N %RGD,%RGZ,%RGN
 S %RGXRN=0,%RGTRUNC=0,%RGIEN="",%RGSCT=0,%RGD=%RGDX
 W:'%RGHTML $$XY(%RGX+$L(%RGPRMPT),%RGY),$S(%RGOPT["X":"",1:%RGD),%RGEOS,!,"Searching"_$S(%RGOPT[U:" (press ^ to abort)",1:"")_"...",*13
 I $E(%RGD)="`" S %RGSLCT=%RGD G:'%RGHTML NR5 D SHOW($E(%RGD,2,999)) Q 1
NXTREF S %RGXRN=%RGXRN+1,%RGXRF=$P(%RGXRFS,U,%RGXRN),%RGD=%RGDX
 I %RGXRF="" G:%RGSCT NR3 W:'%RGHTML *7,*13,%RGEOL,"Not found"_$S(%RGD="":".",1:": ")_$S(%RGD'=+%RGD:%RGD,%RGOPT["D":$$ENTRY^RGUTDT(%RGD),1:%RGD) S %RGD1=$S(%RGOPT["X":U,1:"") Q ""
 S %RGOPT(0)=%RGOPT_%RGXRFS(%RGXRF)
 I %RGOPT(0)["D",$L(%RGDX) D  G:%RGD<1 NXTREF
 .S %RGD=$$%DT^RGUT(%RGDX)
 I %RGOPT(0)["W" D MTL G NXTREF
 S %RGKEY=$S(%RGOPT(0)["P":$P(%RGD," "),1:%RGD)_$S(%RGDIR<0:$C(255),1:""),%RGNUM=$S(%RGKEY=+%RGKEY:%RGKEY,1:"")
 I %RGD'="",$D(@%RGDIC@(%RGXRF,%RGD)) S %=%RGSCT+1 D ADD(%RGD) I %RGSCT=%,%RGOPT(0)["A" D SLCT(%RGSCT) Q %RGIEN
NR2 I %RGOPT(0)[U R %#1:0 I %=U S %RGTRUNC=1 G NR3:%RGSCT Q ""
 S %RGKEY=$O(@%RGDIC@(%RGXRF,%RGKEY),%RGDIR)
 I (%RGNUM="")=(%RGKEY=+%RGKEY),%RGD'="" S %RGKEY=""
 I %RGKEY'="",%RGOPT(0)["P",%RGKEY'=%RGD S %=$$PARTIAL(%RGD,%RGKEY) D ADD(%RGKEY):%>0 G:%'<0 NR2:%RGSCT<100
 I %RGKEY'="",%RGOPT(0)'["P",$E(%RGKEY,1,$L(%RGD))=%RGD D ADD(%RGKEY) G:%RGSCT<100 NR2
 I %RGNUM'="" S %RGKEY=%RGNUM_$C($S(%RGDIR<0:255,1:1)),%RGNUM="" G NR2
 I %RGSCT'<100 W:'%RGHTML *7 S %RGXRALL=0,%RGTRUNC=1
 G:'%RGSCT!%RGXRALL NXTREF
NR3 I %RGSCT=1,%RGOPT(0)[1,'%RGTRUNC D SLCT(1) Q %RGIEN
 S %RGKEY=%RGSLT,%RGSLT=1,%RGSMAX=$S(%RGHTML:99999,1:17-%RGY)
NR4 W:'%RGHTML $$XY(0,%RGY+1),%RGEOS,!
 F %RGN=%RGKEY:1:%RGKEY+%RGSMAX-1 D  Q:%RGN=%RGSCT
 .F %RGZ=0:1:%RGCOL-1 D
 ..S %1=IOM/%RGCOL*%RGZ\1,%RGLAST=%RGZ*%RGSMAX+%RGN
 ..Q:%RGLAST>%RGSCT
 ..W:'%RGHTML $$XY(%1,$Y),%RGEOL,%RGLAST,?5
 ..D SHOW(^TMP(%RGPID,%RGLAST),%1+4)
 .W:'%RGQUIET !
 Q:%RGHTML $S(%RGTRUNC:-%RGSCT,1:%RGSCT)
 W:%RGLAST<%RGSCT !,%RGSCT-%RGLAST," more choice(s)..."
 W:%RGTRUNC "  (list was truncated)",!
 W %RGEOS_%RGBEL,!!
 R "Enter selection: ",%RGSLCT:DTIME
 S:'$T %RGSLCT=U
 W *13
 I %RGOPT["K",%RGSLCT="" Q -1
 I "Nn"[%RGSLCT S %RGKEY=$S(%RGLAST<%RGSCT:%RGLAST+1,1:1) G NR4
 I "Bb"[%RGSLCT S %RGKEY=$S(%RGKEY=1:%RGSCT-%RGSMAX+1,%RGKEY'>%RGSMAX:1,1:%RGKEY-%RGSMAX) S:%RGKEY<1 %RGKEY=1 G NR4
 I "?"[%RGSLCT D HELP2 G NR4
 I "^^"[%RGSLCT S %RGD2="",%RGD1=$S(%RGOPT(0)["X":%RGSLCT,%RGSLCT="^^":%RGSLCT,1:"") Q ""
NR5 F  D  Q:%RGSLCT=""
 .I %RGOPT(0)["M" S %RGD=$P(%RGSLCT,";"),%RGSLCT=$P(%RGSLCT,";",2,999)
 .E  S %RGD=%RGSLCT,%RGSLCT=""
 .Q:'$L(%RGD)
 .I %RGD?1.N D SLCT(%RGD) Q
 .I %RGOPT(0)["M",%RGD?1.N1"-".N D  Q
 ..N %1,%2
 ..S %1=+%RGD,%2=+$P(%RGD,"-",2)
 ..S:'%2 %2=%RGSCT
 ..S:%1>%2 %RGD=%1,%1=%2,%2=%RGD
 ..S:%2>%RGSCT %2=%RGSCT
 ..F %=%1:1:%2 D SLCT(%)
 .I %RGOPT["X",%RGOPT'["L" S (%RGSLCT,%RGD1,%RGIEN)="" Q
 .I $E(%RGD)="`" D  Q
 ..S %RGD=+$E(%RGD,2,999)
 ..I $$VALD(%RGD) D DISV(%RGD) S %RGIEN=%RGD
 .S %RGD1=%RGD1_";"_%RGD
 W $$XY(0,%RGY+1),%RGEOS,!
 Q %RGIEN
 ; Add list selection to output
SLCT(%RGSLCT) ;
 I %RGSLCT>0,%RGSLCT'>%RGSCT D
 .S %RGIEN=+^TMP(%RGPID,+%RGSLCT)
 .D DISV(%RGIEN)
 Q
 ; Add IEN to output
DISV(%RGIEN) ;
 Q:%RGIEN=""
 I %RGMUL'="",'$D(@%RGMUL@(%RGIEN)) S @%RGMUL@(%RGIEN)="" D:'%RGQUIET APP(%RGIEN)
 D:%RGMUL="" APP(%RGIEN)
 Q:%RGOPT(0)["F"
 K:%RGSAME ^DISV(DUZ,%RGDISV)
 S %RGSAME=0,^DISV(DUZ,%RGDISV)=%RGIEN,^(%RGDISV,%RGIEN)=""
 Q
 ; Append primary key to key list
APP(%RGIEN) ;
 N %RGKEY
 S %RGKEY=$S(%RGIEN=+%RGIEN:$P($G(@%RGDIC@(%RGIEN,0)),U),1:%RGIEN)
 S %RGKEY=$$FMT(%RGIEN,%RGKEY)
 Q:'$L(%RGKEY)!($L(%RGKEY)+$L(%RGD2)'<250)
 S %RGD2=%RGD2_$S($L(%RGD2):";",1:"")_%RGKEY
 I %RGOPT(0)'["J",%RGOPT(0)'["M" S %RGD2=%RGD2_"  "_$$SID(%RGIEN)
 Q
 ; Multi-term lookup
MTL N %
 S %=$S(%RGDIC[")":$TR(%RGDIC,")",","),1:%RGDIC_"(")_"%RGXRF)"
 S %=$$LKP^RGUTMTL(%,%RGD,"^TMP(""MTL"",%RGPID)",%RGOPT(0)[U)
 S:%<0 %RGTRUNC=1
 D:% ADD(%RGPID,"^TMP","MTL")
 K ^TMP("MTL",%RGPID)
 Q
 ; Add key to selection list
ADD(%RGKEY,%RGIDX,%RGSUB) ;
 N %S
 S:'$D(%RGIDX) %RGIDX=%RGDIC,%RGSUB=%RGXRF
 F %S=0:0 S %S=$O(@%RGIDX@(%RGSUB,%RGKEY,%S)) Q:'%S  D
 .I %RGOPT(0)["O",$D(^TMP(%RGPID,0,%S)) Q
 .I $$VALD(%S) D
 ..S %RGSCT=%RGSCT+1,^TMP(%RGPID,%RGSCT)=%S_U_$S(%RGOPT(0)["W":"",1:%RGKEY),^(0,%S)=""
 ..I %RGOPT(0)["S",$G(^DISV(DUZ,%RGDISV))=%S S %RGSLT=%RGSCT
 Q
 ; Check entry against screening criteria
VALD(%S) Q:'$D(@%RGDIC@(%S))!'%S 0
 Q:%RGSCN="" 1
 N %,%1
 S %1=1,@$$TRAP^RGUTOS("V3^RGUTLK2")
 F %=0:0 S %=$O(@%RGSCN@(%)) Q:'%  D  Q:%1
 .S %1=0,@$$TRAP^RGUTOS("V2^RGUTLK2")
 .X "S %1="_@%RGSCN@(%)
V2 .Q
 Q %1
V3 Q 0
 ; Show the specified selection
SHOW(%RGSLCT,%RGCOL1,%RGCOL2) ;
 N %S,%Z,%P,%I
 S %S=+%RGSLCT,%Z=$G(@%RGDIC@(%S,0)),%P=$$FMT(%S,$S(%RGOPT["I":$P(%RGSLCT,U,2),1:$P(%Z,U)))
 ;S %I=$$SID(%S,$P(%RGSLCT,U,2)),%I=$S(%I="":%P,1:%I)
 S %I=$$SID(%S,%P),%I=$S(%I="":%P,1:%I)
 I %RGHTML D  Q
 .I '%RGQUIET W $$MSG^RGUT(%RGPRMPT,"|"),!
 .E  D DISV(%S)
 S %RGCOL1=+$G(%RGCOL1,$X)
 I %RGOPT(0)["Y" S %RGCOL2=+$G(%RGCOL2,IOM\%RGCOL+%RGCOL1-8-$L(%I))
 E  S %RGCOL2=+$G(%RGCOL2,IOM\%RGCOL\$S(%RGOPT(0)["D":3,1:2)-3+%RGCOL1)
 W $$XY(%RGCOL1,$Y)
 I %RGOPT(0)'["J",%I'=%P W $$TRUNC^RGUT(%P,IOM\%RGCOL-6),?%RGCOL2," "_$$TRUNC^RGUT(%I,IOM-%RGCOL2-2)
 E  W $$TRUNC^RGUT(%I,IOM\%RGCOL-6)
 Q
 ; Return external form of result
FMT(%S,%RGKEY) ;
 Q:%RGKEY="" %RGKEY
 I %RGTRP'="",$D(@%RGTRP@(%RGKEY)) Q @%RGTRP@(%RGKEY)
 S:%RGOPT(0)["D" %RGKEY=$$ENTRY^RGUTDT(%RGKEY)
 I %RGOPT(0)["Z",%RGSCN'="",$G(@%RGSCN)'="" S @("%RGKEY="_@%RGSCN)
 S:%RGOPT["J" %RGKEY=$$SID(%S,%RGKEY)
 Q %RGKEY
 ; Return secondary identifier
SID(%S,%RGKEY) ;
 S %RGKEY=$G(%RGKEY)
 N %Z
 S %Z=$G(@%RGDIC@(%S,0)),@("%Z="_$S(%RGSID<0:$S(%RGKEY=$$UP^XLFSTR($P(%Z,U)):"""""",1:"%RGKEY"),%RGSID="":"%RGSID",1:%RGSID))
 Q %Z
 ; Partial key lookup
PARTIAL(%RGD,%RGKEY) ;
 N %,%1,%2
 S (%(1),%(2))=0,%1(1)=%RGD,%1(2)=%RGKEY
 F %=1,2 S %1(%)=$TR(%1(%),".,;:?/!-","        ")
P1 S (%2(1),%2(2))=""
 F %=1,2 D
 .F %(%)=%(%)+1:1:$L(%1(%)," ") S %2(%)=$P(%1(%)," ",%(%)) Q:%2(%)'=""
 Q:%2(1)="" 1
 Q:%2(1)'=$E(%2(2),1,$L(%2(1))) -(%(1)=1)
 G P1
HELP(X) ; Application-specific help
 N %
 S %=""
 F  S %=$O(X(%)) Q:%=""  D:$Y>20 PAUSE W $G(X(%)),!
 Q
 ; Generic help
HELP1 N %
 W !!
 D:%RGHLP'="" @%RGHLP
 W !,"Enter a blank line for default action.",!
 D:$Y>20 PAUSE
 W:%RGOPT'["W" "Enter ?? to see all possible selections.",!
 D:$Y>20 PAUSE
 W "Enter a space to retrieve previous selection.",!
 D:$Y>20 PAUSE
 W "Enter a valid identifier for lookup."
 W:(%RGOPT'["*")&(%RGXRFS[U) "  Append a * to include all indices."
 W !
 I %RGOPT["M" D
 .D:$Y>20 PAUSE
 .W "Separate multiple selections by semicolons."
 R !!,"Press any key to continue...",*%:DTIME
 Q
 ; Help at choice prompt
HELP2 N %
 W $$XY(0,16),%RGEOS,!
 W $S(%RGOPT(0)["K":"Enter N for next choices.",1:"Press RETURN for more choices.")
 W ?35,"Enter B for previous choices.",!
 W "Enter ^ to abort lookup.",?35,"Enter choice number to select.",!
 W "Any other entry = new lookup."
 W:%RGOPT(0)["M" ?35,"Separate multiple selections by semicolons."
 R !!,"Press any key to continue...",*%:DTIME
 Q
PAUSE N %
 R !,"Press any key for more...",*%:DTIME
 W $$XY(0,%RGY+2),%RGEOS
 Q
XY(X,Y) Q $S(%RGRS:"",1:$$XY^RGUT(X,Y))
