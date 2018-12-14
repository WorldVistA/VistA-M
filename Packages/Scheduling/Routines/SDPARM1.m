SDPARM1 ;ALB/CAW,SBW - Build Display for Division(s) ; 22/8/2018
 ;;5.3;Scheduling;**27,705**;08/13/93;Build 11
 ;;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
 ;Patch SD*5.3*705 updated this routine to display the SCHEDULING
 ;PARAMETER (#404.91) file ADDITIONAL HEADER TEXT (#1.3) subfile 
 ;data to include INSTITUTION, HEADER TEXT and PRINT STARTING AT 
 ;FIRST LINE? sub fields) 
 ;
CONT ;
 S SDDLN=0
 F SDDIV=0:0 S SDDIV=$O(SDPARM(40.8,SDDIV)) Q:'SDDIV  S SDDLN=SDDLN+1 D DIV S SDDLN(SDDIV)=SDDLN
 Q
 ;
DIV ;
 ;
11 ;
 D SET^SDPARM($$SETSTR^VALM1("Division: "_SDPARM(40.8,SDDIV,.01,"E"),"",1,79))
 D CNTRL^VALM10(SDLN,10,25,IOINHI,IOINORM,0)
 ;
12 S X=""
 S X=$$SETSTR^VALM1("Address Loc. on Letters:",X,1,24)
 S X=$$SETSTR^VALM1(SDPARM(40.8,SDDIV,30.01,"E"),X,26,6)
 S X=$$SETSTR^VALM1("OP Lab Test Start Time:",X,37,23)
 S X=$$SETSTR^VALM1($$TIME(SDPARM(40.8,SDDIV,30.02,"E")),X,SDSCOL,5)
 D SET^SDPARM(X)
 ;
13 S X=""
 S X=$$SETSTR^VALM1("OP EKG Start Time:",X,42,18)
 S X=$$SETSTR^VALM1($$TIME(SDPARM(40.8,SDDIV,30.03,"E")),X,SDSCOL,5)
 D SET^SDPARM(X)
 ;
14 S X=""
 S X=$$SETSTR^VALM1("OP X-ray Start Time:",X,40,20)
 S X=$$SETSTR^VALM1($$TIME(SDPARM(40.8,SDDIV,30.04,"E")),X,SDSCOL,5)
 D SET^SDPARM(X)
 ;
 D SET^SDPARM("")
 Q
HDRTXT ; Additional Header Text is Displayed if it exist. Added
 ; with patch SD*5.3*705 
 ; If there is no additional text display message and quit
 I $D(SDHDR)'>0 D  Q
 . D SET^SDPARM($$SETSTR^VALM1("   *** No Additional Header Text has been entered. ***","",1,79))
 . D CNTRL^VALM10(SDLN,10,25,IOINHI,IOINORM,0)
 ;Display each Institution's additional header text
 N SD1
 S SD1=0
 F  S SD1=$O(SDHDR(SD1)) Q:SD1'>0  D
 . N SD2
 . S SD2=0
 . D SET^SDPARM($$SETSTR^VALM1("Institution/Division: "_SDHDR(SD1),"",1,79))
 . F  S SD2=$O(SDHDR(SD1,SD2)) Q:SD2'>0  D
 . . D SET^SDPARM($$SETSTR^VALM1(" "_$P(SDHDR(SD1,SD2),U,1),"",1,79))
 . . D SET^SDPARM($$SETSTR^VALM1("    Print Starting At First Line?: "_$P(SDHDR(SD1,SD2),U,2),"",1,79))
 . D SET^SDPARM("")
 Q
TIME(X) ; -- format time only :=   hr:min
 I X="" Q X
 Q $E(X_"0000",1,2)_":"_$E(X_"0000",3,4)
