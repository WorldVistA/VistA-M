PXRMG2E2 ;SLC/JVS -GEC #2 EXTRACT #2  ;7/14/05  08:32
 ;;2.0;CLINICAL REMINDERS;**2,4**;Feb 04, 2005;Build 21
 Q
 ;
 ;Variables
 ;CNTREF=The unique counted Referral number
 ;DA    =DA or Ien of the Health Factor
 ;REF   =REFERRAL NUMBER
 ;ARY   =Array that is ordering through
 Q
EN ;Entry Point
 ;SEND IN
 ;BDT,EDT,QUARTER
 ;-----TEMPORARY-----
 ;K ^TMP("PXRMGEC",$J)
 ;-----TEMPORARY-----
 N CR1,CR2,CR3,CR4,CRITER,FOUND,CNT,ARY
 N M1,M2,M3,BDTEDT
 ;---TEMPORARY
 ;S QUARTER=1
 ;---TEMORARY
 S CRITER=0,FOUND=0,CNT=0
 D PROGRAM^PXRMG2E4,CRITER4^PXRMG2E3
 I $D(YEAR),$D(QUARTER) D
 .S BDTEDT=$$FMDATE(YEAR,QUARTER)
 .S BDT=$P(BDTEDT,"^",1)
 .S EDT=$P(BDTEDT,"^",2)
 ;
 D E^PXRMG2E1("HS",1,BDT,EDT,"F",DFNONLY,TPAT)
 K VDOC
 ;This creates the following array besides the HS array
 ;TMP("PXRMGEC",$J,"GEC2",CNTREF,DA,AGE FLAG,APPOINTMENTS,MONTH)=""
 ;
 S ARY="^TMP(""PXRMGEC"",$J,""GEC2"")"
 S REF=0 F  S REF=$O(@ARY@(REF)) Q:REF<1  D
 .I QUARTER=1 S M1=1,M2=2,M3=3
 .I QUARTER=2 S M1=4,M2=5,M3=6
 .I QUARTER=3 S M1=7,M2=8,M3=9
 .I QUARTER=4 S M1=10,M2=11,M3=12
 .D PRE(REF)
 D POST
 Q
 ;======================================
FMDATE(YEAR,QUARTER) ;Get BDT and EDT from year and quarter
 Q:YEAR=""
 Q:QUARTER=""
 Q:QUARTER>4
 Q:QUARTER=0
 N YER,QAR,BDT,EDT
 S YER=YEAR-1700
 I QUARTER=1 S BDT=YER_"0101",EDT=YER_"0331"
 I QUARTER=2 S BDT=YER_"0401",EDT=YER_"0630"
 I QUARTER=3 S BDT=YER_"0701",EDT=YER_"0930"
 I QUARTER=4 S BDT=YER_"1001",EDT=YER_"1231"
 Q BDT_"^"_EDT
 ;======================================
GET(REF) ;Get Criteria
 N DFN,MONTH,NAME,SSN,PROG
 S (CR1,CR2,CR3,CR4,CRITER)=0
 S CR1=$$C1^PXRMG2S1(REF)
 S CR2=$$C2^PXRMG2S1(REF)
 S CR3=$$C3^PXRMG2S1(REF)
 S CR4=$$C4^PXRMG2S1(REF)
 S DFN=$P(CR4,"^",2)
 S MONTH=$P(CR4,"^",3)
 S NAME=$P(^DPT(DFN,0),"^",1)
 S SSN=$P(CR4,"^",4)
 S DATE=$P(CR4,"^",5)
 S PROG=$P(CR4,"^",6)
 S CR4=+CR4
 I CR1=1 S CRITER="1"
 I CR2=1 S CRITER=$S(CRITER=0:2,1:CRITER_",2")
 I CR3=1 S CRITER=$S(CRITER=0:3,1:CRITER_",3")
 I CR4=1 S CRITER=$S(CRITER=0:4,1:CRITER_",4")
 S ^TMP("PXRMGEC",$J,"GEC2","RPT",NAME,SSN,DATE,CRITER,PROG)=""
 Q CRITER
 ;
PRE(REF) ;Pre Process array by Program and Month
 N ARY
 S ARY="^TMP(""PXRMGEC"",$J,""GEC2"")"
 I $D(@ARY@(REF,$O(P441(0)))),$D(@ARY@(REF,$O(P449(0)))) D
 .S @ARY@("ADHC",$$MONTH(REF,ARY),REF,$$PIECE($$GET(REF)))=$$GET(REF)
 I $D(@ARY@(REF,$O(P4410(0)))),$D(@ARY@(REF,$O(P449(0)))) D
 .S @ARY@("HHHA",$$MONTH(REF,ARY),REF,$$PIECE($$GET(REF)))=$$GET(REF)
 I $D(@ARY@(REF,$O(P4412(0)))),$D(@ARY@(REF,$O(P449(0)))) D
 .S @ARY@("VAIHR",$$MONTH(REF,ARY),REF,$$PIECE($$GET(REF)))=$$GET(REF)
 I $D(@ARY@(REF,$O(P451(0)))),$D(@ARY@(REF,$O(P452(0)))) D
 .S @ARY@("CC",$$MONTH(REF,ARY),REF,$$PIECE($$GET(REF)))=$$GET(REF)
 Q
 ;
MONTH(REF,ARY) ;Get month out of array
 Q:REF=""
 Q:ARY=""
 N IEN,AGE,APP,DFN,MON
 S IEN=$O(@ARY@(REF,0))
 S AGE=$O(@ARY@(REF,IEN,-1))
 S APP=$O(@ARY@(REF,IEN,AGE,-1))
 S DFN=$O(@ARY@(REF,IEN,AGE,APP,0))
 S MON=$O(@ARY@(REF,IEN,AGE,APP,DFN,0))
 Q MON
 ;
PIECE(CRITER) ;Get the piece in the array the criter goes into
 N PIECE
 I CRITER=0 S PIECE=5
 I CRITER=1 S PIECE=6
 I CRITER=2 S PIECE=7
 I CRITER=3 S PIECE=8
 I CRITER=4 S PIECE=9
 I CRITER="1,2" S PIECE=10
 I CRITER="1,3" S PIECE=11
 I CRITER="1,4" S PIECE=12
 I CRITER="2,3" S PIECE=13
 I CRITER="2,4" S PIECE=14
 I CRITER="3,4" S PIECE=15
 I CRITER="1,2,3" S PIECE=16
 I CRITER="1,2,4" S PIECE=17
 I CRITER="1,3,4" S PIECE=18
 I CRITER="2,3,4" S PIECE=19
 I CRITER="1,2,3,4" S PIECE=20
 Q PIECE
 ;
POST ;Set the Statistical Arrays
 D START
 N PROG,MON,REF,PIE,MONX,SITE,STOP,ARY,X,Y
 S ARY="^TMP(""PXRMGEC"",$J,""GEC2"")"
 S PROG="ADH" F  S PROG=$O(@ARY@(PROG)) Q:PROG=""  D
 .S MON=0 F  S MON=$O(@ARY@(PROG,MON)) Q:MON=""  D
 ..Q:MON'=M1&(MON'=M2)&(MON'=M3)
 ..S CNT=0
 ..S REF=0 F  S REF=$O(@ARY@(PROG,MON,REF)) Q:REF=""  D
 ...S CNT=CNT+1
 ...S PIE=0 F  S PIE=$O(@ARY@(PROG,MON,REF,PIE)) Q:PIE=""  D
 ....I MON=1!(MON=4)!(MON=7)!(MON=10) S MONX=1
 ....I MON=2!(MON=5)!(MON=8)!(MON=11) S MONX=2
 ....I MON=3!(MON=6)!(MON=9)!(MON=12) S MONX=3
 ....S Y=$P($G(STAT(PROG,MONX)),",",PIE)
 ....S Y=Y+1,$P(STAT(PROG,MONX),",",PIE)=Y
 ....S $P(STAT(PROG,MONX),",",2)=MON
 ....S $P(STAT(PROG,MONX),",",4)=CNT
 Q
 ;
START ; Start the STAT(PROG,MON) ARRAYS
 N I,SITE,F,S,T
 I QUARTER=1 S F=1,S=2,T=3
 I QUARTER=2 S F=4,S=5,T=6
 I QUARTER=3 S F=7,S=8,T=9
 I QUARTER=4 S F=10,S=11,T=12
 S SITE=$P($$SITE^VASITE,"^",3)
 F I=1:1:3 S STAT("ADHC",I)=SITE_",,"_"ADHC"_",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" D
 .I I=1 S $P(STAT("ADHC",I),",",2)=F
 .I I=2 S $P(STAT("ADHC",I),",",2)=S
 .I I=3 S $P(STAT("ADHC",I),",",2)=T
 F I=1:1:3 S STAT("HHHA",I)=SITE_",,"_"HHHA"_",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" D
 .I I=1 S $P(STAT("HHHA",I),",",2)=F
 .I I=2 S $P(STAT("HHHA",I),",",2)=S
 .I I=3 S $P(STAT("HHHA",I),",",2)=T
 F I=1:1:3 S STAT("CC",I)=SITE_",,"_"CC"_",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" D
 .I I=1 S $P(STAT("CC",I),",",2)=F
 .I I=2 S $P(STAT("CC",I),",",2)=S
 .I I=3 S $P(STAT("CC",I),",",2)=T
 F I=1:1:3 S STAT("VAIHR",I)=SITE_",,"_"VAIHR"_",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" D
 .I I=1 S $P(STAT("VAIHR",I),",",2)=F
 .I I=2 S $P(STAT("VAIHR",I),",",2)=S
 .I I=3 S $P(STAT("VAIHR",I),",",2)=T
 Q
WRITE ;Write to screen the STAT array
 N PROG,MON
 W !,"An Email containing this information will be sent to all those who are listed"
 W !,"in the ""G.GEC2 NATIONAL ROLLUP"" mail group",!
 S PROG="AD" F  S PROG=$O(STAT(PROG)) Q:PROG=""  D
 .S MON=0 F  S MON=$O(STAT(PROG,MON)) Q:MON=""  D
 ..W !,$G(STAT(PROG,MON))
 W !!,"The above information is a statistical compilation of the"
 W !,"information seen in the local view of this option."
 W !!,"Thanks in advance",!!
 D MAIL^PXRMG2M1
 D EXIT
 Q
 ;=================================================
EXIT ;Exit and Clean up Variables
 K C1101,C1107,C1108
 K C1410,C1412,C1414,C142,C144,C146,C148,C166,C171
 K C2110,C2114,C2118,C212,C2120,C214,C216,C218,C221,C224,C226
 K C2710,C272,C274,C276,C278,C286
 K P441,P4410,P4412,P449,P451,P452
 K STAT
 Q
