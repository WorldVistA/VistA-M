RGUTLKP ;CAIRO/DKM - File lookup utility;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Inputs:
 ;   %RGDIC  = Global root or file #
 ;   %RGOPT  = Options
 ;      A allow automatic selection of exact match
 ;      B sound bell with selection prompt
 ;      C use roll & scroll mode
 ;      D index is in date/time format
 ;      E use line editor
 ;      F forget the entry (i.e., ^DISV not updated)
 ;      G start with prior entry
 ;      H HTML-formatted output
 ;      I show only lookup identifiers
 ;      J show only secondary identifiers
 ;      K null entry at select prompt exits
 ;      L like X, but allows lookup at select prompt
 ;      M allow multiple selection
 ;      O show entry only once
 ;      P partial lookup
 ;      Q silent lookup
 ;      R reverse search through indices
 ;      S start selection list at last selection
 ;      T forget trapped inputs
 ;      U force uppercase translation
 ;      V extended DISV recall (prompt-specific)
 ;      W use multi-term lookup algorithm
 ;      X do not prompt for input
 ;      Y right justify secondary identifiers
 ;      Z perform special formatting of output
 ;      1 automatic selection if one match only
 ;      2-9 # of columns for selection display (default=1)
 ;      * force all indices to be searched
 ;      ^ allow search to be aborted
 ;   %RGPRMPT = Prompt (optional)
 ;   %RGXRFS  = Cross-references to examine (all "B"'s by default)
 ;   %RGDATA  = Data to lookup (optional)
 ;   %RGSCN   = Screening criteria (optional)
 ;   %RGMUL   = Local variable or global reference to
 ;              store multiple hits
 ;   %RGX     = Column position for prompt (optional)
 ;   %RGY     = Row position for prompt (optional)
 ;   %RGSID   = Piece # of secondary identifier (optional)
 ;              or executable M code to display same
 ;   %RGTRP   = Special inputs to trap (optional)
 ;   %RGHLP   = Entry point to invoke help
 ; Outputs:
 ;    Return value = index of selected entry or:
 ;      -1 for forced exit by ^
 ;      -2 for forced exit by ^^
 ;       0 for null entry
 ;=================================================================
ENTRY(%RGDIC,%RGOPT,%RGPRMPT,%RGXRFS,%RGDATA,%RGSCN,%RGMUL,%RGX,%RGY,%RGSID,%RGTRP,%RGHLP) ;
 N %,%1,%N,%S,%Z,%RGPID,%RGXRF,%RGSCT,%RGKEY,%RGKEY1,%RGDISV,%RGSLCT,%RGXRALL,%RGXRN,%RGSMAX,%RGTRUNC,%RGD,%RGD1,%RGD2,%RGBEL,%RGNUM,%RGDIR,%RGSLT,%RGCOL,%RGLAST,%RGSAME,%RGEOS,%RGEOL,%RGHTML,%RGRS,%RGQUIET
 I $$NEWERR^%ZTER N $ET S $ET=""
 S (%RGOPT,%RGOPT(0))=$$UP^XLFSTR($G(%RGOPT)),%RGPID="%RGLKP"_$J,%RGBEL=$S(%RGOPT["B":$C(7),1:""),%RGDIR=$S(%RGOPT["R":-1,1:1),%RGSLT=1,%RGCOL=1,%RGEOS=$C(27,91,74),%RGEOL=$C(27,91,75),%RGHTML=0,%RGLAST=0,%RGRS=%RGOPT["C",%RGQUIET=%RGOPT["Q"
 S:%RGRS (%RGEOL,%RGEOS)=""
 S:%RGQUIET %RGOPT=%RGOPT_"XHM"
 S:%RGOPT["H" (%RGBEL,%RGEOL,%RGEOS)="",%RGOPT=%RGOPT_"X",%RGHTML=1
 S:%RGOPT["L" %RGOPT=%RGOPT_"X"
 S U="^",DUZ=$G(DUZ,0),IO=$G(IO,$I),IOM=$G(IOM,80),%RGMUL=$G(%RGMUL),%RGHLP=$G(%RGHLP),%RGTRP=$G(%RGTRP),%RGSCN=$G(%RGSCN),%RGSAME=%RGOPT["M"&(%RGMUL'="")
 F %=2:1:9 S:%RGOPT[% %RGCOL=%
 S:%RGOPT'["M" %RGMUL=""
 K:%RGMUL'="" @%RGMUL
 S:%RGDIC=+%RGDIC %RGDIC=$$ROOT^DILFD(%RGDIC)
 S:$E(%RGDIC,$L(%RGDIC))="(" %RGDIC=$E(%RGDIC,1,$L(%RGDIC)-1)
 S:$E(%RGDIC,$L(%RGDIC))="," %RGDIC=$E(%RGDIC,1,$L(%RGDIC)-1)
 I %RGDIC["(",$E(%RGDIC,$L(%RGDIC))'=")" S %RGDIC=%RGDIC_")"
 S %RGPRMPT=$G(%RGPRMPT,$S(%RGOPT["X":"",1:"Enter identifier: "))
 S %RGDISV=$S(%RGDIC[")":$TR(%RGDIC,")",","),1:%RGDIC_"(")_$S(%RGOPT["V":";"_%RGPRMPT,1:"")
 S %RGSID=$G(%RGSID),%RGXRFS=$G(%RGXRFS),%RGDATA=$G(%RGDATA)
 S:%RGSID=+%RGSID %RGSID=$S(%RGSID<0:%RGSID,1:"$P(%Z,U,"_%RGSID_")")
 S %RGX=$G(%RGX,0),%RGY=$G(%RGY,3),DTIME=$G(DTIME,999999999)
 W:'%RGHTML $$XY(%RGX,%RGY),%RGEOS,!
 I %RGOPT["G",$G(^DISV(DUZ,%RGDISV))'="" D
 .S %RGDATA=^(%RGDISV)
 .S:+%RGDATA=%RGDATA %RGDATA=$P($G(@%RGDIC@(%RGDATA,0)),U)
 I %RGXRFS="" D
 .S (%,%RGXRFS)="B"
 .F  S %=$O(@%RGDIC@(%)) Q:$E(%)'="B"  S %RGXRFS=%RGXRFS_U_%
 F %=1:1:$L(%RGXRFS,U) S %1=$P(%RGXRFS,U,%) S:%1'="" %RGXRFS($P(%1,":"))=$P(%1,":",2),$P(%RGXRFS,U,%)=$P(%1,":")
 S (%RGD1,%RGD2)=""
 D RM(0)
 S %RGIEN=$$INPUT
 W:'%RGHTML $$XY(%RGX+$L(%RGPRMPT),%RGY),$$TRUNC^RGUT(%RGD2,IOM-$X),%RGEOS
 D RM(IOM)
 K ^TMP(%RGPID)
 Q %RGIEN
INPUT() ;
INP K ^TMP(%RGPID)
 D READ
 S:%RGOPT["U" %RGD=$$UP^XLFSTR(%RGD)
 S @$$TRAP^RGUTOS("ERROR^RGUTLKP")
 I %RGD="",%RGTRP'="" S %RGD=$G(@%RGTRP@(" "))
 Q:"^^"[%RGD -$L(%RGD)
 I "?"[%RGD D HELP1^RGUTLK2 G INP
 I %RGD=" " D SAME G:%RGD="" INP2
 I %RGTRP'="",$D(@%RGTRP@(%RGD)) D  Q %RGD
 .S %RGSAME=1
 .D:%RGOPT'["T" DISV^RGUTLK2(%RGD)
 .S %RGD2=$G(@%RGTRP@(%RGD))
 .S:%RGD2="" %RGD2=%RGD
 S:%RGD="??" %RGD=""
 I $E(%RGD,$L(%RGD))="*" S %RGXRALL=1,%RGD=$E(%RGD,1,$L(%RGD)-1)
 E  S %RGXRALL=%RGOPT["*"
 S %RGIEN=$$LKP^RGUTLK2(%RGD)
INP2 G INP:%RGIEN=""!$L(%RGD1)
 Q %RGIEN
READ S %RGD=""
 F  Q:%RGD'=""!(%RGD1="")  S %RGD=$P(%RGD1,";"),%RGD1=$P(%RGD1,";",2,999)
 Q:$L(%RGD)
 S %RGD=%RGDATA,%RGDATA=""
 W:'%RGHTML $$XY(0,%RGY+2),%RGEOS,$$XY(%RGX,%RGY),%RGPRMPT_%RGEOL
 I %RGOPT["X" S:%RGOPT["E" %RGOPT=$TR(%RGOPT,"X"),%RGDATA=%RGD Q
 I %RGOPT["E" D
 .N %,%1
 .S:%RGD?1"`"1.N %RGD=+$E(%RGD,2,99),%RGD=$$FMT^RGUTLK2(%RGD,$P($G(@%RGDIC@(%RGD,0)),U))
 .S %1=0,%=%RGX+$L(%RGPRMPT),%=$$ENTRY^RGUTEDT(%RGD,IOM-%-1,%,%RGY,"","RHV",,,,,.%1)
 .S:%1=3 %=U
 .S:%="?" %RGDATA=%RGD
 .S %RGD=%
 E  I '$L(%RGD) R %RGD:DTIME S:'$T %RGD=U
 I %RGOPT["M",%RGD[";" S %RGD1=%RGD G READ
 Q
SAME S %RGSAME=0,%RGIEN="",%RGD="",%RGSCT=0
 I %RGMUL'="" D
 .S %=""
 .F  S %=$O(^DISV(DUZ,%RGDISV,%)) Q:%=""  D SM1
 E  S %=$G(^DISV(DUZ,%RGDISV)) D:%'="" SM1
 S:%RGHTML %RGIEN=%RGSCT
 Q
SM1 I %RGTRP'="",$D(@%RGTRP@(%)) S %RGIEN=%,%RGD=%
 E  I $$VALD^RGUTLK2(%) S %RGIEN=%
 I  D DISV^RGUTLK2(%RGIEN) S %RGSCT=%RGSCT+1
 Q
XY(X,Y) Q $S(%RGRS:"",1:$$XY^RGUT(X,Y))
RM(X) X ^%ZOSF("RM")
 Q
ERROR W:'%RGHTML $$XY(0,%RGY+1),*7,%RGEOL,$$EC^%ZOSV
 S (%RGDATA,%RGD1,%RGD2)=""
 G INP
