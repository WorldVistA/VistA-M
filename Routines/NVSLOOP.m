NVSLOOP ;WJW@OIOFO for CACHE ;1/3/05 mod: 2/24/05
 ;;1.5;NVS works with "%" subscripts now
 ;Credit to "The Highly Esteemed Kevin Kearney" for starting the routine
 ;Loops through global to determine how many nodes exist
 ;
 ; -- added to NVSMENU KIDs BUILD  jls/oiofo         1/21/06  NOON
 ;
 S U="^"
 S:'$D(DTIME) DTIME=300
LMT R !,"Enter Threshold to report: 500// ",NVSLMT:DTIME
 G:$T=0 EXIT
 G:NVSLMT[U EXIT
 I NVSLMT="" S NVSLMT=500 G GBL
 I NVSLMT["?" D HELPL G LMT
 G:+NVSLMT'>0 EXIT
GBL R !,"Enter 1 for TMP, 2 for XTMP, 3 for Custom: 2// ",NVSGBL:DTIME
 G:$T=0 EXIT
 G:NVSGBL[U EXIT
 I NVSGBL="2" S NVSGBL=2,NVSGBR="^XTMP" G SUBS
 I NVSGBL="" S NVSGBL=2,NVSGBR="^XTMP" G SUBS
 I NVSGBL["?" D HELP G GBL
 I NVSGBL=1 S NVSGBR="^TMP" G SUBS
 I NVSGBL=3 R !,"Enter global in ^NAME format: ",NVSGBR:DTIME
 G:$T=0 EXIT
 I NVSGBR'[U W !!,"Global must start with ^ ",! G GBL
 G:$L(NVSGBR)=1 EXIT
 I NVSGBR["(" W !!,"Subscripts not allowed",! G GBL
 I '$D(@NVSGBR) W !!,"Global does not exist.  Please try again.",! G GBL
SUBS W !,"Do you want counts on 2nd level subscript also" S %=1 D YN^DICN
 G:%<0 EXIT
 S NVSCKSUB=%
 S %ZIS="Q" D ^%ZIS
 G:IO="" EXIT
 D:$D(IO("Q"))
 .S ZTRTN="MAIN^NVSLOOP",ZTION=ION,ZTDESC="NVSLOOP "_NVSGBR
 .S ZTSAVE("NVS*")="" D ^ZTLOAD W !!,*7,"REQUEST (",ZTSK,") QUEUED!!"
 G:$D(IO("Q")) EXIT
MAIN U IO W !,"Working...",!
 s ref=NVSGBR
 s tot=0
 D TOTAL,SUBTOT
 D:NVSCKSUB=1 SUBTOT2
 D ^%ZISC
EXIT K ref,tot,oref,Z,x,I,Y,X,NVSGBR,NVSGBL,NVSLMT,NVSCKSUB
 Q
TOTAL f x=0:0 s ref=$Q(@ref) q:ref=""  s tot=tot+1
 U IO W !,"TOTAL NODES ","= ",tot,!
 Q
SUBTOT ;total by first level subscript.
 S I=-1
 F  S Y=NVSGBR_"("_""""_I_""""_")",I=$O(@Y) Q:I=""  D
 . s:($A(I,1)>57)!($A(I,1)<48) ref=NVSGBR_"("_""""_I_""""_")"
 . s:($A(I,1)<58)&($A(I,1)>47) ref=NVSGBR_"("_I_")"
 . s Z=0,oref=$e(ref,1,$l(ref)-1)
 . f x=0:0 s ref=$Q(@ref) q:ref'[oref  D
 .. s Z=(Z+1)
 . i Z>NVSLMT U IO w ! D ^%T w ": ",oref," has "_Z_" nodes."
 Q
SUBTOT2 ;total by 2nd level subscript
 U IO W !!!,?40,"Working on 2nd level Subscripts....",!!!
 S I=-1
 S Y=NVSGBR_"("_""""_I_""""_")",I=$O(@Y) Q:I=""
 s:($A(I,1)>57)!($A(I,1)<48) ref=NVSGBR_"("_""""_I_""""_")"
 s:($A(I,1)<58)&($A(I,1)>47) ref=NVSGBR_"("_I_")"
 D
 . F  Q:ref=""  s X=$e(ref,1,$l(ref)-1)_",-1)" S X=$Q(@X) Q:X=""  D
 .. s Z=1,oref=$P(ref,",",1,2)
 .. ;W !,"x= ",X,?20,"ref= ",ref,?40,"oref= ",oref,?60,"I= ",I
 .. f x=0:0 s ref=$Q(@ref) q:ref'[oref  D
 ... ;W !,"ref= ",ref,?40,"oref= ",oref
 ... s Z=(Z+1)
 ... q
 .. i Z>NVSLMT U IO w ! D ^%T w ": ",oref," has "_Z_" nodes."
 .. q
 .
 Q
HELP ;
 W !!,"This routine loops through globals to count the number"
 W !,"of nodes.  It gives a Grand Total, Total for each top"
 W !,"level subscript, and a Total for each second level."
 W !,"Enter 1 to check ^TMP, 2 to check ^XTMP, or 3 to enter"
 W !,"a global of your choice.  You must enter the ^ and it"
 W !,"must be the global name only, no subscripts allowed."
 W !!,"You can queue the output to a printer or HFS device.",!
 Q
HELPL ;
 W !!,"This number is used to limit the amount of output. Only"
 W !,"those first and second level subsripts with this number"
 W !,"of nodes will be reported.",!
 Q
