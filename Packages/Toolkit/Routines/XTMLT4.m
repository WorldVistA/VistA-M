XTMLT4 ;JLI/FO-OAK - UNIT TESTS FOR XTMLOG ;2017-07-25  10:32 AM
 ;;2.4;LOG4M;;Jul 25, 2017;Build 3
 ; Code authored by Joel Ivey 2008-2017. Minor changes by Sam Habiel in 2017 for bug fixes.
 D EN^%ut("XTMLT4")
 Q
 ;
FORMAT ;
 N TSTNAME,ROOT,INFO,XX,ROOTVAL
 S TSTNAME="TEST"
 S ROOT=$NA(ROOTVAL(TSTNAME,"APPENDER","MYAPPENDER"))
 S @ROOT@("LAYOUT.CONVERSIONPATTERN")="%5p [%t] - %m%n"
 S INFO("PRIORITY")="DEBUG"
 S INFO("$H")="59443,57959",INFO("COUNT")=5,INFO("LOCATION")="ENTRY+5^ROUNAME"
 S XX=$$FORMAT^XTMLOG1(ROOT,.INFO,"Text of message")
 D CHKEQ^%ut("DEBUG ["_$J_"] - Text of message",XX,"Did not format correctly")
 ;
 S INFO("PRIORITY")="INFO"
 S XX=$$FORMAT^XTMLOG1(ROOT,.INFO,"Text of message")
 D CHKEQ^%ut(" INFO ["_$J_"] - Text of message",XX,"Did not right justify correctly")
 ;
 S @ROOT@("LAYOUT.CONVERSIONPATTERN")="%-5p [%t] - %m%n"
 S XX=$$FORMAT^XTMLOG1(ROOT,.INFO,"Text of message")
 D CHKEQ^%ut("INFO  ["_$J_"] - Text of message",XX,"Did not left justify correctly")
 ;
 S @ROOT@("LAYOUT.CONVERSIONPATTERN")="%-5p [%t] {%M} [%L] [%F] - %m%n"
 S XX=$$FORMAT^XTMLOG1(ROOT,.INFO,"Text of message")
 D CHKEQ^%ut("INFO  ["_$J_"] {ENTRY} [ENTRY+5] [ROUNAME] - Text of message",XX,"Did not handle locations correctly")
 ;
 S @ROOT@("LAYOUT.CONVERSIONPATTERN")="%d{dd MMM yyyy HH:mm:ss,SSS} ^ %-5p [%t] - %m%n"
 S XX=$$FORMAT^XTMLOG1(ROOT,.INFO,"Text of message")
 D CHKEQ^%ut("01 OCT 2003 16:05:59, ^ INFO  ["_$J_"] - Text of message",XX,"Did not handle date format correctly")
 Q
 ;
LOGGING ;
 N X
 S X=$$INITNONE^XTMLOG("JLITEST")
 D EN^%ut("XTMLT2")
 D ENDLOG^XTMLOG("JLITEST")
 Q
 ;
XTROU ;
 ;;XTMLT1;TESTS FOR XTMLOG
XTENT ;
 ;;FORMAT;TEST FORMAT HANDLING
