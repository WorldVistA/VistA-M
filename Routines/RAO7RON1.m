RAO7RON1 ;HISC/GJC,FPT-Request message from OE/RR. (frontdoor) ; 7/26/05 2:08pm
 ;;5.0;Radiology/Nuclear Medicine;**69,75,98**;Mar 16, 1998;Build 2
 ;
 ;------------------------- Variable List -------------------------------
 ; RADATA=HL7 data minus seg. hdr    RAHDR=Segment header
 ; RAHLFS="|"                        RAMSG=HL7 message passed in
 ; RAOBR12=danger code               RAOBR18=modifier
 ; RAOBR19=Img. Loc. pntr (79.1)     RAOBR30=trans. mode
 ; RAOBR31=Reason for Study          RAOBX2=format of observ. value
 ; RAOBR4=univ. trans. mode          RAOBX5=observ. value
 ; RAOBX3=observ. ID                 RAORC10=entered by (200
 ; RAORC1=order control              RAORC15=order effective D/T
 ; RAORC12=ordering provider (200)   RAORC2=placer order #_"^OR"
 ; RAORC16=order control reason      RAORC7=start dt/freq. of service
 ; RAORC3=filler order #_"^RA"       RAPID5=patient name (2)
 ; RAPID3=patient ID                 RAPV12=patient class
 ; RAPV119=visit #                   RASEG=message seg. including header
 ; RAPV13=patient location (44)
 ; ----------------------------------------------------------------------
 ;
OBR ; breakdown the 'OBR' segment
 S RAOBR4=$P(RADATA,RAHLFS,4)
 F I=1:1:$L(RAOBR4,RAECH(1)) S RAOBR4(I)=$P(RAOBR4,RAECH(1),I)
 I RAOBR4(1)'="" S RACPTIEN=+$O(^ICPT("B",RAOBR4(1),0)) S:'RACPTIEN RAERR=8 Q:RAERR  ;RA*5*69
 S RAERR=$$EN2^RAO7VLD(71,+RAOBR4(4),RAOBR4(5)) S:RAERR RAERR=8 Q:RAERR
 I $$UP^XLFSTR($P($G(^RAMIS(71,+RAOBR4(4),0)),"^",6))="P" D  Q:RAERR
 . S RAERR=$$EN6^RAO7VLD(+RAOBR4(4)) S:RAERR RAERR=32
 . Q
 I RAOBR4(1)'="" S:'$D(^RAMIS(71,"D",RACPTIEN,+RAOBR4(4))) RAERR=8 Q:RAERR  ;RA*5*69
 S RAOBR4(4,"I-TYPE")=+$P($G(^RAMIS(71,+RAOBR4(4),0)),"^",12)
 S RANEW(75.1,"+1,",2)=RAOBR4(4)
 S RAIT=$P(^RAMIS(71,+RAOBR4(4),0),U,12)
 S RAERR=$$EN3^RAO7VLD(79.2,RAIT) Q:RAERR
 S RANEW(75.1,"+1,",3)=RAIT
 S RAOBR12=$P(RADATA,RAHLFS,12)
 S RAOBR12=$S($E(RAOBR12)="":"n","yYiI"[$E(RAOBR12):"y",1:"n")
 S RAERR=$$EN1^RAO7VLD(75.1,24,"E",RAOBR12,"RASULT","") S:RAERR RAERR=10 Q:RAERR
 S RANEW(75.1,"+1,",24)=RAOBR12
 S RAOBR18=$P(RADATA,RAHLFS,18)
 N RASERIES,RAIMAG
 F I=1:1:$L(RAOBR18,RAECH(2)) S:$L($P(RAOBR18,RAECH(2),I))>0 RAOBR18(I)=$P(RAOBR18,RAECH(2),I)
 S I=0 F  S I=$O(RAOBR18(I)) Q:I'>0  D  Q:RAERR
 . S RAMODIEN=+$O(^RAMIS(71.2,"B",RAOBR18(I),0))
 . S:'RAMODIEN RAERR=11 Q:RAERR
 . S RAIMAG=$P($G(^RAMIS(71,+RAOBR4(4),0)),U,12) ; type of imaging
 . S:'$D(^RAMIS(71.2,"AB",RAIMAG,RAMODIEN)) RAERR=33 Q:RAERR
 . S RASERIES=$S($P($G(^RAMIS(71,+RAOBR4(4),0)),"^",6)="S":1,1:0)
 . S:RASERIES&($P($G(^RAMIS(71.2,RAMODIEN,0)),U,2)]"") RAERR=34 Q:RAERR
 . S RAPLCHLD=RAPLCHLD+1
 . S RANEW(75.1125,"+"_RAPLCHLD_",+1,",.01)=RAMODIEN
 . Q
 S RAOBR19=$P(RADATA,RAHLFS,19),RAOBR19(1)=$P(RAOBR19,U,1)
 S RAOBR19(2)=$P(RAOBR19,U,2),RAOBR19(3)=+RAOBR19(1)
 I RAOBR19(3) D  Q:RAERR
 . S RAOBR19(3,"I-TYPE")=+$P($G(^RA(79.1,+RAOBR19(3),0)),"^",6)
 . I RAOBR4(4,"I-TYPE")'=RAOBR19(3,"I-TYPE") S RAERR=31
 . Q
 S RANEW(75.1,"+1,",20)=$S(RAOBR19(3)>0:RAOBR19(3),1:"")
 S X=$P(RADATA,RAHLFS,30)
 S RAOBR30=$S(X="CART":"s",X="PORT":"p",X="WALK":"a",X="WHLC":"w",1:"")
 I RAOBR30']"" S RAERR=13
 S:'RAERR RAERR=$$EN1^RAO7VLD(75.1,19,"E",RAOBR30,"RASULT","")
 S:RAERR RAERR=13 Q:RAERR
 S RANEW(75.1,"+1,",19)=RAOBR30
 ;--- Reason for Study P75 ---
 ;CPRS will not pass 'Reason for Study' data until OR*3.0*243
 ;(GUI CPRS V27) is released. Define a default Reason for Study 
 I '$$PATCH^XPDUTL("OR*3.0*243") S RAOBR31="See Clinical History:"
 E  D  Q:RAERR  ;CPRS V27 is installed
 .S RAOBR31=$P($P(RADATA,RAHLFS,31),RAECH(1),2)
 .S:RAOBR31="" RAERR=38 Q:RAERR
 .S RAERR=$$EN1^RAO7VLD(75.1,1.1,"E",RAOBR31,"RASULT","")
 .S:RAERR RAERR=39
 .Q
 S RAOBR31=$TR(RAOBR31,$C(10)," ")  ;strip 'line feed' - P98
 S RAOBR31=$TR(RAOBR31,$C(13)," ")  ;strip 'carriage return' - P98
 S:'RAERR RANEW(75.1,"+1,",1.1)=RAOBR31
 K RAOBR31
 Q
OBX ; breakdown the 'OBX' segment
 S RAOBX2=$P(RADATA,RAHLFS,2)
 S RAERR=$S(RAOBX2="TX":0,RAOBX2="CE":0,RAOBX2="TS":0,1:1) Q:RAERR=17
 S RAOBX3=$P(RADATA,RAHLFS,3)
 S RAOBX5=$P(RADATA,RAHLFS,5)
 F I=1:1:$L(RAOBX3,RAECH(1)) S RAOBX3(I)=$P(RAOBX3,RAECH(1),I)
 S X=RAOBX3(2) D UPPER^RAUTL4 S RAOBX3(2)=Y
 ;
 ;P75 check to see if CLINICAL HISTORY data is passed. If data is passed, and not yet
 ;determined if valid continue to check for validity until:
 ;1-valid data is found
 ;2-no data left to validate
 I RAOBX3(1)=2000.02 D
 .;check if a null value is sent for CLINICAL HISTORY which is
 .;possible if the CPRS user does not enter a CLINICAL HISTORY
 .I RAOBX5="",$P(RACLIN,U)'=1 Q
 .;now if data was sent (RAOBX5'="") set the data received from CPRS flag
 .S $P(RACLIN,U)=1
 .;now that we know the CPRS user intended to send CLINICAL HISTORY data
 .;radiology has to validate the format of that data. $$EN4^RAO7VLD(str)
 .;returns 1 if the data passed in was valid, else 0. Once we establish
 .;that valid data has been sent, all subsequent data is accepted, valid
 .;or not.
 .S:$$EN4^RAO7VLD(RAOBX5) $P(RACLIN,U,2)=1
 .;now, if the current character string or any other character string
 .;of data representing the CLINICAL HISTORY has been accepted as valid
 .;($P(RACLIN,U,2)=1) save the character string
 .I $P(RACLIN,U,2)=1 S RAWP=RAWP+1,^TMP("RAWP",$J,RAWP)=RAOBX5
 ;
 I RAOBX3(1)=2000.33 D  Q:RAERR
 .S RAERR=$$EN1^RAO7VLD(75.1,13,"E",RAOBX5,"RASULT","") S:RAERR RAERR=14 Q:RAERR
 .S RAPREG=$E(RAOBX5),RAPREG=$S(RAPREG="N"!(RAPREG="n"):"n",RAPREG="Y"!(RAPREG="y"):"y",1:"u")
 .S RANEW(75.1,"+1,",13)=RAPREG
 I RAOBX3(1)=34!(RAOBX2="CE") D  Q:RAERR
 .S RAERR=$$EN2^RAO7VLD(34,$P(RAOBX5,RAECH(1)),$P(RAOBX5,RAECH(1),2)) Q:RAERR
 .S RANEW(75.1,"+1,",9)=+RAOBX5
 I RAOBX3(2)["RESEARCH" D  S:RAERR RAERR=18 Q:RAERR
 .S RAERR=$$EN1^RAO7VLD(75.1,9.5,"E",RAOBX5,"RASULT","") S:RAERR RAERR=19 Q:RAERR
 .S RANEW(75.1,"+1,",9.5)=RAOBX5
 I RAOBX3(2)["PRE-OP" D  Q:RAERR
 .S RAOBX5=$$FMDATE^HLFNC(RAOBX5)
 .S RAERR=$$EN1^RAO7VLD(75.1,12,"E",RAOBX5,"RASULT","") S:RAERR RAERR=20 Q:RAERR
 .S RANEW(75.1,"+1,",12)=RAOBX5
 I $D(RANEW(75.1,"+1,",9))&($D(RANEW(75.1,"+1,",9.5))) S RAERR=29
 Q
