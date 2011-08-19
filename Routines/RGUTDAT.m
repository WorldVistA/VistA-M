RGUTDAT ;CAIRO/DKM - Date range input;12-Oct-1998 12:01;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Prompt for date range (normal format)
NORMAL D D1("P1"),D2("P2")
 Q
 ; Prompt for date range (inverse format)
INVRSE D D1("PI1"),D2("PI2")
 Q
 ; Prompt for starting date
D1(RGOPT) ;
 S RGDAT1=$$ENTRY("Start date: ",.RGOPT,"",0,$Y)
 Q
 ; Prompt for ending date
D2(RGOPT) ;
 S RGDAT2=$$ENTRY("End date  : ",.RGOPT,"",0,$Y+1)
 Q
 ; Prompt for a date
ENTRY(%RGP,%RGOPT,%RGDAT,%RGX,%RGY,%RGTRP,%RGHLP) ;
 N %RGD,%RGI,%RGDT,%RGZ,%RGDISV
 S %RGX=$G(%RGX,$X),%RGY=$G(%RGY,$Y),DUZ=+$G(DUZ),IO=$G(IO,$I),DTIME=$G(DTIME,999999999),%RGOPT=$$UP^XLFSTR($G(%RGOPT)),%RGDISV=""
 S %RGTRP=$G(%RGTRP),%RGDAT=$G(%RGDAT)
 S:$G(%RGHLP)="" %RGHLP="HELP^RGUTDAT"
 S:$G(%RGP)="" %RGP="Enter date: "
 F %RGZ=0:1:9 I %RGOPT[%RGZ S %RGDISV="RGDAT"_%RGZ Q
 U IO
DAT1 S %RGDT="",@$$TRAP^RGZOSF("DAT1^RGUTDAT")
 F %RGZ="P","T","F","X" S:%RGOPT[%RGZ %RGDT=%RGDT_%RGZ
 F  D  Q:$D(%RGI)
 .W $$XY^RGUT(%RGX,%RGY)_%RGP,*27,"[J"
 .S $X=%RGX+$L(%RGP)
 .I %RGOPT["E" S %RGI=$$ENTRY^RGUTEDT(%RGDAT,79-$X,$X,$Y,"","R")
 .E  I %RGDAT'="" S %RGI=%RGDAT,%RGDAT=""
 .E  R %RGI:DTIME
 .I $E(%RGI)="?" D  Q
 ..W !
 ..I %RGI["??" D HELP
 ..E  D @%RGHLP
 ..D PAUSE()
 ..K %RGI
 .I %RGI=" " S %RGI=$S(%RGDISV="":"",1:$G(^DISV(DUZ,%RGDISV))) K:%RGI="" RGZ1
 .W $$XY^RGUT(%RGX+$L(%RGP),%RGY),*27,"[K"
 I %RGI="",%RGTRP'="" S %RGI=$G(@%RGTRP@(" "))
 S %RGI=$$UP^XLFSTR(%RGI),%RGD=""
 Q:"^^"[%RGI -$L(%RGI)
 I %RGTRP'="" D  I %RGD'="" S %RGOPT=$TR(%RGOPT,"I") G DAT2
 .I $D(@%RGTRP@(%RGI)) S %RGD=@%RGTRP@(%RGI)
 .E  D
 ..N X
 ..S X=%RGI,%RGZ=""
 ..F  S %RGZ=$O(@%RGTRP@("?",%RGZ)) Q:%RGZ=""  I %RGI?@%RGZ D  Q
 ...S %RGD=$$MSG^RGUT($G(@%RGTRP@("?",%RGZ)))
 S %RGI=$$%DT^RGUT(%RGI,%RGDT)
 G:%RGI=-1 DAT1
 I %RGOPT["+",%RGI<$S(%RGI=%RGI\1:$$DT^XLFDT,1:$$NOW^XLFDT) D  G DAT1
 .D PAUSE("Must be on or after current date.")
 I %RGOPT["-",%RGI>$S(%RGI=%RGI\1:$$DT^XLFDT,1:$$NOW^XLFDT) D  G DAT1
 .D PAUSE("Must be on or before current date.")
 S %RGD=$$^RGCVTDT(%RGI)
DAT2 W %RGD
 S:%RGDISV'="" ^DISV(DUZ,%RGDISV)=%RGI
 Q $S(%RGOPT["I":9999999-%RGI,1:%RGI)
HELP W ?2,"Enter a valid ",$S(%RGOPT["+":"future ",%RGOPT["-":"past ",1:""),"date using one of the following formats:",!!
 W ?5,"Format",?20,"Example",?35,"Explanation",?60,"Comments",!
 W ?5,"------",?20,"-------",?35,"-----------",?60,"--------",!
 W ?5,"mm/dd/yy",?20,"6/20/93",?35,"June 20, 1993",?60,"If you omit the",!
 W ?5,"dd-mmm-yy",?20,"27-JUL-58",?35,"July 27, 1958",?60,"year, the "_$S(%RGOPT["P":"most",%RGOPT["F":"closest",1:"current"),!
 W ?5,"mmddyy",?20,"070457",?35,"July 4, 1957",?60,$S(%RGOPT["P":"recent past date",%RGOPT["F":"future date",1:"calendar year"),!
 W ?5,"mmm dd yyyy",?20,"JAN 5, 1984",?35,"January 5, 1984",?60,"is assumed.",!
 W ?5,"T-n",?20,"T-5",?35,"Today's date - 5 days.",!!
 Q
PAUSE(%RGZ) ;
 W $$XY^RGUT(0,22),$G(%RGZ)
 I $$PAUSE^RGUT
 Q
