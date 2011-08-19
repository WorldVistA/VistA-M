AWCMCPR2        ;VISN7/THM-CPRS MONITOR HTML CODE [07-07-2003] ; 09 Jan 2004  3:43 PM
 ;;7.3;TOOLKIT;**84**;Jan 9, 2004
 ;
PART1 ; HTML section that creates java applet data
 ; Variables are killed in calling program
 ;
 W "<html><head>",!
 W "<META HTTP-EQUIV=""Refresh"""," Content=""300; URL="_$P(^AWC(177100.12,1,0),U,6)_"_"_AWCDIVNM_".htm",""">",!
 W "<title>CPRS Response Time Monitor - "_AWCDIVN1_"</title></head>",!
 W "<body>",!
 S AWCY99=$P(^AWC(177100.12,1,0),U),AWCY99=$P($G(^DIC(4,+AWCY99,0)),U)
 W "<center><H2>"_AWCY99_"</H2>"
 W "<H4>","CPRS Response Time Monitor for facility -- "_AWCDIVN1,!,"</H4>"
 D MENU1
 W "<APPLET CODE=linegraph.class HEIGHT=350 WIDTH="_$S(AWCDHRS=5:800,AWCDHRS=6:850,AWCDHRS=7:900,AWCDHRS=8:950,AWCDHRS=9:1000,AWCDHRS=10:1050,AWCDHRS=11:1100,1:1150)_">",!
 Q
 ;
PART2 ;
 W "<PARAM NAME=KeyWidth VALUE=80>",!
 W "<PARAM NAME=LineColor_R_L1 VALUE="_$P(AWCTIULN,",",1)_">",!
 W "<PARAM NAME=LineColor_G_L1 VALUE="_$P(AWCTIULN,",",2)_">",!
 W "<PARAM NAME=LineColor_B_L1 VALUE="_$P(AWCTIULN,",",3)_">",!
 W "<PARAM NAME=LineColor_R_L2 VALUE="_$P(AWCLABLN,",",1)_">",!
 W "<PARAM NAME=LineColor_G_L2 VALUE="_$P(AWCLABLN,",",2)_">",!
 W "<PARAM NAME=LineColor_B_L2 VALUE="_$P(AWCLABLN,",",3)_">",!
 W "<PARAM NAME=LineColor_R_L3 VALUE="_$P(AWCREMLN,",",1)_">",!
 W "<PARAM NAME=LineColor_G_L3 VALUE="_$P(AWCREMLN,",",2)_">",!
 W "<PARAM NAME=LineColor_B_L3 VALUE="_$P(AWCREMLN,",",3)_">",!
 W "<PARAM NAME=yMax VALUE="_AWCMXSEC_">",!
 W "<PARAM NAME=yMin VALUE=0>",!
 W "<PARAM NAME=Mode VALUE=0>",!
 W "<PARAM NAME=Lines VALUE=3>",!
 W "<PARAM NAME=Title VALUE="""">",!
 W "<PARAM NAME=Border VALUE=""30"""_">",!
 W "<PARAM NAME=Grid VALUE="""_AWCGRDON_""">",!
 W "<PARAM NAME=""lines"" VALUE=1>",!
 W "<PARAM NAME=""bg_r"" VALUE="_$P(AWCBKGRN,",",1)_">",!
 W "<PARAM NAME=""bg_g"" VALUE="_$P(AWCBKGRN,",",2)_">",!
 W "<PARAM NAME=""bg_b"" VALUE="_$P(AWCBKGRN,",",3)_">",!
 F AWCTYPE=0:0 S AWCTYPE=$O(TMP("AWC",AWCTYPE)) Q:AWCTYPE=""  S AWCPCNTR=0 F AWCTIME=-9999:0 S AWCTIME=$O(TMP("AWC",AWCTYPE,AWCTIME)) Q:AWCTIME=""  DO
 .S AWCPCNTR=AWCPCNTR+1,AWCPARAM="VAL"_AWCPCNTR_"_L"_AWCTYPE
 .W "<PARAM NAME="""_AWCPARAM_""" ","VALUE="""
 .S AWCDTA=$G(TMP("AWC",AWCTYPE,AWCTIME)),AWCSEC=$P(AWCDTA,U),AWCCNT=$P(AWCDTA,U,2)
 .S AWCAVG=$S(AWCCNT>0:$J(AWCSEC/AWCCNT,0,2),1:0)
 .I AWCAVG>AWCMXSEC S AWCAVG=AWCMXSEC ;if average is greater than max, set to max
 .I AWCAVG<0 S AWCAVG=0 ;no values <0
 .W +AWCAVG,""">",! ;finish the HTML line
 .; add the time values for the x-axis
 S AWCLBCNT=1
 F YYY=-99999:0 S YYY=$O(^TMP("AWCTTIM",$J,YYY)) Q:YYY=""  DO
 .S Y=YYY
 .I Y<0 S Y=9999+Y
 .; format the time, if necessary
 .I $L(Y)=1 S Y="000"_Y
 .I $L(Y)=2 S Y="00"_Y
 .I $L(Y)=3 S Y="0"_Y
 .W "<PARAM NAME=LAB"_AWCLBCNT_" VALUE="""_$S($E(Y,3,4)=10:"*",$E(Y,3,4)=20:"*",$E(Y,3,4)=40:"*",$E(Y,3,4)=50:"*",1:Y)_""">",! S AWCLBCNT=AWCLBCNT+1
 ; add the remaining values
 S (AWCLBCNT,AWCVCNTR)=(AWCLBCNT-1) ;label count and value count
 W !,"<PARAM NAME=Key_L1 VALUE="_""" -   TIU"">",!
 W "<PARAM NAME=Key_L2 VALUE="_""" -   Lab"">",!
 W "<PARAM NAME=Key_L3 VALUE="_""" -   Reminder"">",!!
 W "<PARAM NAME=NumberOfVals VALUE="_AWCVCNTR_">",!
 W "<PARAM NAME=NumberOfLabs VALUE="_AWCLBCNT_">",!
 W "</applet>","<p><h4><center>Response Time In Seconds for the last "_AWCDHRS_" hours </h4>","</center>",!
 W "<b><h5>Last updated: " D NOW^%DTC S Y=% X ^DD("DD") W Y,!,"</b></h5></body></html>",!
 D CLOSE^%ZISH("AWCCPR1"),^%ZISC
 K AWCY99
 Q
 ;
MENU1 ; java script - makes drop-down menu
 ; goes in <body> portion of page
 Q:$O(AWCFDIV(0))=""  ;only one division at facility
 S AWCWEBRT=$P(^AWC(177100.12,1,0),U,15)  Q:AWCWEBRT=""  ;not set up in param file
 S AWCWL=$L(AWCWEBRT) I $E(AWCWEBRT,AWCWL,AWCWL)'="/" S AWCWEBRT=AWCWEBRT_"/"
 W "<form name=""jump"">",!
 W "<select name=""menu"">",!
 W "<option value=""#"">Other Facilities</option>",!
 S AWCDVNM=""  F  S AWCDVNM=$O(AWCFDIV(AWCDVNM)) Q:AWCDVNM=""  DO
 .S AWCDVDTA=AWCFDIV(AWCDVNM),AWCFDIVN=$P(AWCDVDTA,U),AWCDVNB=$P(AWCDVDTA,U,2)
 .W "<option value=""http://"_AWCWEBRT_$P(AWCFILE,"_")_"_"_AWCDVNB_".htm"_""">"_$P(AWCFDIV(AWCDVNM),U)_"</option>",!
 W "</select>",!
 W "<input type=""button"" onClick=""location=document.jump.menu.options[document.jump.menu.selectedIndex].value;"" value=""GO"">",!
 W "</form>",!
 Q
