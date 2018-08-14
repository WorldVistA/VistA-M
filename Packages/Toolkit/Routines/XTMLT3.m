XTMLT3 ;JLI/FO-OAK - TEST ROUTINES FOR XTMLOG ;2017-07-25  10:32 AM
 ;;2.4;LOG4M;;Jul 25, 2017;Build 3
 ; Code authored by Joel Ivey 2008-2017. Minor changes by Sam Habiel in 2017 for bug fixes.
 D EN^%ut("XTMTSTL1")
 Q
ENT1 ;
PARSE ;
 N XTMNAME,GLOBLOC,RESULTS
 S XTMNAME="TESTNAME"
 S GLOBLOC=$NA(^TMP("XTMTSTL1",$J,"PARSE")) K @GLOBLOC
 S @GLOBLOC@(1)="log4j.rootLogger=debug, stdout, R"
 S @GLOBLOC@(2)=""
 S @GLOBLOC@(3)="log4j.appender.stdout=org.appache.log4j.ConsoleAppender"
 S @GLOBLOC@(4)="log4j.appender.stdout.layout=org.apache.log4j.PatternLayout"
 S @GLOBLOC@(5)=""
 S @GLOBLOC@(6)="# Pattern to output the caller's file name and line number."
 S @GLOBLOC@(7)="log4j.appender.stdout.layout.ConversionPattern=%5p [%t] (%F:%L) - %m%n"
 S @GLOBLOC@(8)=""
 S @GLOBLOC@(9)="log4j.appender.R=org.apache.log4j.RollingFileAppender"
 S @GLOBLOC@(10)="log4j.appender.R.File=example.log"
 S @GLOBLOC@(11)=""
 S @GLOBLOC@(12)="log4j.appender.R.MaxFileSize=100KB"
 S @GLOBLOC@(13)="# Keep one backup file"
 S @GLOBLOC@(14)="log4j.appender.R.MaxBackupIndex=1"
 S @GLOBLOC@(15)=""
 S @GLOBLOC@(16)="log4j.appender.R.layout=org.apache.log4j.PatternLayout"
 S @GLOBLOC@(17)="log4j.appender.R.layout.ConversionPattern=%p %t %c - %m%n"
 ;
 D PARSE^XTMLOG(XTMNAME,GLOBLOC,.RESULTS)
 ;
 D CHKEQ^%ut("DEBUG",$G(RESULTS(XTMNAME,"PRIORITY")),"Incorrect Level ID")
 D CHKEQ^%ut("CONSOLEA",$G(RESULTS(XTMNAME,"APPENDER","STDOUT","TYPE")),"Incorrect Output Type")
 D CHKEQ^%ut("PATTERNLAYOUT",$G(RESULTS(XTMNAME,"APPENDER","STDOUT","LAYOUT")),"Incorrect Layout")
 D CHKEQ^%ut("%5p [%t] (%F:%L) - %m%n",$G(RESULTS(XTMNAME,"APPENDER","STDOUT","LAYOUT.CONVERSIONPATTERN")),"Incorrect Conversion Pattern")
 D CHKEQ^%ut("ROLLINGF",$G(RESULTS(XTMNAME,"APPENDER","R","TYPE")),"Incorrect Output Type")
 D CHKEQ^%ut("example.log",$G(RESULTS(XTMNAME,"APPENDER","R","FILE")),"Incorrect Output File Name")
 D CHKEQ^%ut("100KB",$G(RESULTS(XTMNAME,"APPENDER","R","MAXFILESIZE")),"Incorrect MaxFileSize")
 D CHKEQ^%ut("1",$G(RESULTS(XTMNAME,"APPENDER","R","MAXBACKUPINDEX")),"Incorrect MaxBackupIndex")
 D CHKEQ^%ut("PATTERNLAYOUT",$G(RESULTS(XTMNAME,"APPENDER","R","LAYOUT")),"Incorrect Layout")
 D CHKEQ^%ut("%p %t %c - %m%n",$G(RESULTS(XTMNAME,"APPENDER","R","LAYOUT.CONVERSIONPATTERN")),"Incorrect Conversion Pattern")
 ;
 K @GLOBLOC
 Q
 ;
APPEND ;
 N XTLOGSET,XTLOGSEQ,XTMINFO,XTMLNAME,XTLOGINP,ROOT
 S XTLOGSET="",XTLOGSEQ=0,XTMINFO("COUNT")=0
 S ROOT=$NA(XTLOGINP("NAME1","APPENDER","A1"))
 S @ROOT@("TYPE")="CONSOLEA",@ROOT@("LAYOUT")="PATTERNLAYOUT",@ROOT@("LAYOUT.CONVERSIONPATTERN")="%p %t %c - %m%n"
 S ROOT=$NA(XTLOGINP("NAME1","APPENDER","A2")),@ROOT@("TYPE")="GLOBAL",@ROOT@("LAYOUT")="PATTERNLAYOUT"
 S @ROOT@("LAYOUT.CONVERSIONPATTERN")="%d [%p] %L - %m%n"
 S @ROOT@("CLOSEDROOT")=$NA(^TMP("XTMLROOT",$J))
 D LOG^XTMLOG("This is the message")
 Q
 ;
ENABLED ;
 N XTLOGINP
 K XTLOGINP("XTMLOG")
 D CHKEQ^%ut(0,$$ENABLED^XTMLOG("XTMLOG"),"Should have returned zero")
 S XTLOGINP("XTMLOG")=""
 D CHKEQ^%ut(1,$$ENABLED^XTMLOG("XTMLOG"),"Should have returned one")
 Q
 ;
XTROU ;
 ;;XTMLT4;TESTS FOR XTMLOG
 ;;XTMLT1;
XTENT ;
 ;;PARSE;CHECK PARSING OF PARAMETER FILE
 ;;ENABLED;Check return value for Enabled entry point
 ;;APPEND;Check functioning for appenders
