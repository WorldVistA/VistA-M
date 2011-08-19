GMRAOR4 ;HIRMFO/WAA,FPT-OERR HL7 UTILITY ; 2/9/95
 ;;4.0;Adverse Reaction Tracking;**4,16**;Oct 10, 2000
 ;MSG = HL7 Message array
 ;GMRANODE = IEN of MSG array
 ;GMRAND = Date from MSG(GMRANODE)
 ;GMRAMTP = Message type
EN1(MSG) ; MSG is the array that is passed to ART should be pass by
 ; reference
 N GMRANODE,GMRAND,GMRAMTP
 S GMRANODE=0
 F  S GMRANODE=$O(MSG(GMRANODE)) Q:GMRANODE<1  D
 .S GMRAND=MSG(GMRANODE),GMRAMTP=$E(GMRAND,1,3)
 .I "^MSH^PID^PV1^AL1^ZAL^ZAO^ZAS^NTE^"'[("^"_GMRAMTP_"^") S GMRAMTP="ERROR"
 .D @GMRAMTP
 .Q
 K %,DL1,DL2,DL3,DL4,DL4,GMRAI,GMRAID,GMRAIDC,GMRAIDN,GMRAIDO,GMRAIDS,I
 D EN1^GMRAOR5
 K GMRADFN,GMRAL
 Q
MSH ;Message Header Information
 ;Set up delimiters DL1-DL5
 N GMRADL
 F I=1:1:5 S GMRADL="DL"_I,@GMRADL=$E(GMRAND,(3+I)) ; Assign all delimiters
 Q
PID ;Patient Id Information
 ;GMRADFN = DFN of patient in ^DPT(DFN) Patient (2) file
 S GMRADFN=$P(GMRAND,DL1,4)
 Q
PV1 ;Allergy Information
 Q
AL1 ;Allergy informaton
 ;building GMRAL Array to be used to stuff only new data
 ;GMRAID=sequence number of allergy
 ;~=continuation
 ;     Allergy AL1 Segment
 ;   GMRAL(GMRAID)=type^file ien^VA Free text drug^file^OERR entry date^~
 ;   GMRAL(1)="D^5^SHELL FISH^99ALL^2940415.06^~
 ;     ZAL Segment
 ;   GMRAL(GMRAID)=~NKA Status^Originator Pt to 200^Observed/Historical
 ;   GMRAL(1)=~y^1270^o"
 S GMRAID=$P(GMRAND,DL1,2)
 S %=$P(GMRAND,DL1,3)
 S %=$S(%="DA":"D",%="FA":"F",%="MA":"O",%="MC":"O",%="AT":"DFO","^DF^DO^FO^"["^"_%_"^":%,1:"")
 S GMRAL(GMRAID)=%
 S %="" F GMRAI=4:1:6 S %=%_U_$P($P(GMRAND,DL1,4),DL2,GMRAI)
 S GMRAL(GMRAID)=GMRAL(GMRAID)_%
 S %=$$HL7TFM^XLFDT($P(GMRAND,DL1,7))
 S GMRAL(GMRAID)=GMRAL(GMRAID)_U_%
 Q
ZAL ;Allergy type information
 S GMRAL(GMRAID)=GMRAL(GMRAID)_U_$S($P(GMRAND,DL1,3)="YES":"n",$P(GMRAND,DL1,3)="NO":"y",1:"")_U_$P(GMRAND,DL1,4)
 S GMRAL(GMRAID)=GMRAL(GMRAID)_U_$S($P(GMRAND,DL1,5)="OB":"o",$P(GMRAND,DL1,5)="HI":"h",1:"")
 Q
ZAO ;Observed allergy information
 ;GMRAIDO = Sequence #
 ;   ZAO Observed reaction section
 ; GMRAL(GMRAID,"O",GMRAIDO)=Observed date^Severity^Observer's DUZ
 ; GMRAL(1,"O",1)="2940401.1^3^1234"
 ;S GMRAIDO=$P(GMRAND,DL1,2)
 S GMRAIDO=1
 S %=$$HL7TFM^XLFDT($P(GMRAND,DL1,3))
 S GMRAL(GMRAID,"O",GMRAIDO)=%
 S %=$P(GMRAND,DL1,4)
 S GMRAL(GMRAID,"O",GMRAIDO)=GMRAL(GMRAID,"O",GMRAIDO)_U_$S(%="MI":1,%="MO":2,%="SV":3,1:"")_U_$P(GMRAND,DL1,5)
 Q
ZAS ;Allergy Signs/Symptoms
 ;GMRAIDS = Sequence #
 ;   ZAS Observed reaction section
 ; GMRAL(GMRAID,"S",GMRAIDS)=IEN of file^Free Text of entry^File of SS
 ;                           ^Date of the SS
 ; GMRAL(1,"S",1)="32^SEVERE RASH^99ALS^2951211.1120"
 S GMRAIDS=$P(GMRAND,DL1,2)
 S GMRAL(GMRAID,"S",GMRAIDS)=$P($P(GMRAND,DL1,3),DL2,4)_U
 S GMRAL(GMRAID,"S",GMRAIDS)=GMRAL(GMRAID,"S",GMRAIDS)_$P($P(GMRAND,DL1,3),DL2,5)_U
 S GMRAL(GMRAID,"S",GMRAIDS)=GMRAL(GMRAID,"S",GMRAIDS)_$P($P(GMRAND,DL1,3),DL2,6)_U
 S %=$P(GMRAND,DL1,4)
 I %'="" S %=$$HL7TFM^XLFDT($P(GMRAND,DL1,4)),GMRAL(GMRAID,"S",GMRAIDS)=GMRAL(GMRAID,"S",GMRAIDS)_%
 Q
NTE ;Comments
 ;GMRAIDN = Sequence #
 ;GMRAIDC = the next line of text from the HL7 script
 ;   NTE Comments section
 ; GMRAL(GMRAID,"N",GMRAIDN)=Source of comments(Originator always)
 ; GMRAL(1,"N",1)="n"
 ; GMRAL(1,"N",1,1)=FREE TEXT
 S GMRAIDN=1
 ; old Code S GMRAIDN=$P(GMRAND,DL1,2)
 S GMRAL(GMRAID,"N",GMRAIDN)="O"
 ; old code S GMRAL(GMRAID,"N",GMRAIDN,1)=$P(GMRAND,DL1,3)
 S GMRAL(GMRAID,"N",GMRAIDN,1)=$P(GMRAND,DL1,4)
 ; old code S GMRAIDC="0" F  S GMRAIDC=$O(MSG(GMRANODE,GMRAIDC)) Q:GMRAIDC<1  Q:$P(MSG(GMRANODE,GMRAIDC),DL1)'="NTE"  D
 S GMRAIDC="0" F  S GMRAIDC=$O(MSG(GMRANODE,GMRAIDC)) Q:GMRAIDC<1  D
 .S GMRAL(GMRAID,"N",GMRAIDN,GMRAIDC+1)=MSG(GMRANODE,GMRAIDC)
 .Q
 Q
ERROR ;Error handling
 Q
