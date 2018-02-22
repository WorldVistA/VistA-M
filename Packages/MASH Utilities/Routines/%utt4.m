%utt4 ; VEN/SMH/JLI - Coverage Test Runner;01/30/17  11:46
 ;;1.5;MASH UTILITIES;;Jul 8, 2017;Build 13
 ; Submitted to OSEHRA Jul 8, 2017 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Sam H. Habiel 07/2013-04/2014
 ; Additions and modifications made by Joel L. Ivey 05/2014-08/2015
 ;
XTMUNITW ; VEN/SMH - Coverage Test Runner;2014-04-17  3:30 PM
 ;;7.3;KERNEL TOOLKIT;;
 ;
 ; This tests code in XTMUNITV for coverage
 D EN^%ut($T(+0),1)
 QUIT
 ;
MAIN ; @TEST - Test coverage calculations
 Q:$D(^TMP("%uttcovr",$J))  ; already running coverage analysis from %uttcovr
 Q:$D(^TMP("%utCOVREPORT",$J))  ; another coverage already running
 S ^TMP("%utt4val",$J)=1
 D COV^%ut("%utt3","D EN^%ut(""%utt3"",1)",-1)  ; Only produce output global.
 D CHKEQ^%ut("14/19",^TMP("%utCOVREPORT",$J))
 D CHKEQ^%ut("2/5",^TMP("%utCOVREPORT",$J,"%utt3","INTERNAL"))
 D CHKTF^%ut($D(^TMP("%utCOVREPORT",$J,"%utt3","T2",4)))
 D CHKEQ^%ut("1/1",^TMP("%utCOVREPORT",$J,"%utt3","SETUP"))
 K ^TMP("%utt4val",$J)
 QUIT
 ;
 ; The following code was copied from the routine XLFDT so that unit tests for LEAKSOK
 ; and LEAKSBAD in %utt5 could be independent of VA KERNEL code'
 ;
HTFM(%H,%F) ;$H to FM, %F=1 for date only
 N X,%,%T,%Y,%M,%D S:'$D(%F) %F=0
 I $$HR(%H) Q -1 ;Check Range
 I '%F,%H[",0" S %H=(%H-1)_",86400"
 D YMD S:%T&('%F) X=X_%T
 Q X
 ;
YMD ;21608 = 28 feb 1900, 94657 = 28 feb 2100, 141 $H base year
 S %=(%H>21608)+(%H>94657)+%H-.1,%Y=%\365.25+141,%=%#365.25\1
 S %D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1
 S X=%Y_"00"+%M_"00"+%D,%=$P(%H,",",2)
 S %T=%#60/100+(%#3600\60)/100+(%\3600)/100 S:'%T %T=".0"
 Q
 ;
NOW() ;Current Date/time in FM.
 Q $$HTFM($H)
 ;
HR(%V) ;Check $H in valid range
 Q (%V<2)!(%V>99999)
 ;
