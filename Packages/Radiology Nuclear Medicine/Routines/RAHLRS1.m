RAHLRS1 ;HIRMFO/ROB/PAVEL - Resend HL7 messages for selected Timeframe ; 10/27/08 11:01
 ;;5.0;Radiology/Nuclear Medicine;**80,84,95**;Mar 16, 1998;Build 7
 ; Utility to RESEND HL7 messages for selected Timeframe
 ;
 ;Integration Agreements
 ;----------------------
 ;^%DT(10003); C^%DTC(10000); H^%DTC(10000); ^%ZISC(10089); ^%ZTLOAD(10063); $$GET1^DIQ(2056)
 ;^DIR(10026); ^XMD(10070)
 ;all access to ^ORD(101 to maintain application specific protocols(872)
 ;read w/FileMan HL7 APPLICATION PARAMETER(10136)
 ;
 N RACNI,RADFN,RADTI,RARPT,X,RAED,RABD,RASHBD,RASHED,RASHTD,RASHTM,DIC,DA,XX,YY
 N RALOCK,RASSS,RASSSX,RASSSL,I,X S RALOCK=0
CHECK ;
 D SETVARS Q:$G(RAIMGTY)=""
 W !!,"This option re-sends HL7 messages for a date range and for designated Recipients.",!
 W !,"It is strongly recommended you task this to run off hours.",!!
 S:'$D(U) U="^" S:'$D(DTIME) DTIME=9999
1 W ! K %DT S %DT="AEX",%DT("A")="Beginning Date: " D ^%DT
 G:Y<0!($D(DTOUT))!($D(DUOUT)) STOP
 S RABD=Y
 X ^DD("DD") S RASHBD=Y
 S X1=RABD,X2=-1 D C^%DTC S RABD=X
 S RABD=RABD_"."_9999
 ;
 W ! K %DT S %DT="AEX",%DT("A")="Ending Date: ",%DT("B")="NOW" D ^%DT
 G:Y<0!($D(DTOUT))!($D(DUOUT)) STOP
 S RAED=Y
 X ^DD("DD") S RASHED=Y
 S RAED=RAED_"."_9999
 K XX G:'$$GETAP(.XX) STOP
 W !!,"*** Pick the application in which to send the radiology data ***",!!
 F I=1:1 Q:'$D(XX(I))  W !,"  #",I,"   ",$O(XX(I,""))
2 ;user selects the application
 S DIR(0)="N^1:"_(I-1)
 W ! S DIR("?")="Please select an available application from the list."
 D ^DIR Q:$D(DIRUT)
 W !!,"The: ",$O(XX(+X,"")),"   will be the recipient"
 W !!,"Reviewing exams for selected time period... (This may take a few minutes)... "
 S Y=$$GETSUM(RABD,RAED)
 I 'Y W !!,"No exams exist for selected period, change the time frame !!!" H 3 W ! G 1
 W !!,"During this period of time ",Y," Exams were performed and app Run time= ",Y\5000," Hours."
 S RAPICK=$O(XX(+X,"")) ;appl. recipient name, RA*5*95
 S RASSS(XX(X,$O(XX(+X,""))))="" D GETSUB(.RASSS,.RASSSX,.RASSSL)
 K ZTSAVE
 S ZTSAVE("RAPICK")="" ;include appl. recipient name in task, RA*5*95
 S ZTSAVE("RASSSX(")="",ZTSAVE("RASSSL(")="",ZTSAVE("RABD")="",ZTSAVE("RAED")="",ZTSAVE("RADFN")=""
 S ZTSAVE("RADTI")="",ZTSAVE("RACNI")="",ZTSAVE("RASHBD")="",ZTSAVE("RASHED")="",ZTIO=""
 S ZTDESC="Rad/Nuc Med Compiling HL7 Common Order",ZTRTN="TM^RAHLRS1"
 W ! K %DT S %DT="AEXT",%DT("A")="Scheduled time to run: ",%DT("B")="TODAY@23:59" D ^%DT
 G:Y<0!($D(DTOUT))!($D(DUOUT)) STOP
 S X=Y,YY=Y D H^%DTC S ZTDTH=$G(%H)_","_$G(%T)
 S Y=YY X ^DD("DD") S RASHTM=Y
 D ^%ZTLOAD
 W !,"Task ",$S('$D(ZTSK):" Has Not been Tasked !!!",1:"#:"_ZTSK_" Has been Tasked")
 D:$D(ZTSK)
 .N RAX,RAMPG,XMSUB,XMY,XMTEXT
 .S RAX(1)="Task #"_$G(ZTSK)_" is scheduled to run the option: "
 .S RAX(2)=">>Re-send HL7 messages for a date range and for designated Recipient.<<"
 .S RAX(3)=" Scheduled time to run: "_RASHTM
 .S RAX(4)="Date range from: "_$G(RASHBD)_" to: "_$G(RASHED)
 .S XMSUB="TASKMAN SCHEDULE NOTIFICATION/INFO"
 .S RAMPG="G.RAD HL7 MESSAGES"
 .S XMY(RAMPG)="",XMDUZ=.5
 .S XMTEXT="RAX("
 .D ^XMD
 Q
 ;
TM ;Taskman Entry...
 N RASTIME,RASUM7,RASUM7R,RASUM7E
 S RASTIME=$H,(RASUM7,RASUM7R,RASUM7E)=0
 F  S RABD=$O(^RADPT("AR",RABD)) Q:'RABD!(RABD>RAED)  D
 .S RADFN=0 F  S RADFN=$O(^RADPT("AR",RABD,RADFN)) Q:'RADFN  D
 ..S RADTI=0 F  S RADTI=$O(^RADPT("AR",RABD,RADFN,RADTI)) Q:'RADTI  D
 ...S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D RESEND(RADFN,RADTI,RACNI)
 K RAX S RAX(1)="Task #"_$G(ZTSK)_" successfully completed the option: "
 S RAX(2)=">>Re-send HL7 messages for a date range and for designated Recipient.<<"
 S RAX(3)="Date range from: "_$G(RASHBD)_" to: "_$G(RASHED)
 S RAX(4)="# Of RAD Reports transferred: "_$G(RASUM7R)
 S RAX(5)="# Of Exams transferred:      "_$G(RASUM7)
 S:$G(RASUM7E) X(6)="# Of Exams not transferred because of ""BAD DATA"": "_$G(RASUM7E)
 S XMSUB="TASKMAN ""RESEND HL7 OPTION"" COMPLETED/INFO"
 S RAMPG="G.RAD HL7 MESSAGES"
 S XMY(RAMPG)="",XMDUZ=.5
 S XMTEXT="RAX("
 D ^XMD
 G STOP
 Q
 ;
RESEND(RADFN,RADTI,RACNI) ; re-send exam message(s) to HL7 subscribers
 ; for every 10 messages sent, make sure queue is not clogged... $$HANG
 N RAXAMP80 S RAXAMP80=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 I '(+$P(RAXAMP80,U))!'($P(RAXAMP80,U,2)) S RASUM7E=RASUM7E+1 Q
 N RABD,RAEDP80,QUIT,RARPST ;added RARPST, RA*5*95
 ;
 I '$D(DT) D ^%DT S DT=Y
 ;
 S RAEDP80=$$RAED(RADFN,RADTI,RACNI)
 I '$L(RAEDP80) S RASUM7E=RASUM7E+1 Q
 D:RAEDP80[",REG,"
 .D CHSUM N RASUM7,RASUM7R,RASUM7E D REG^RAHLRPC
 D:RAEDP80[",CANCEL,"
 .D CHSUM N RASUM7,RASUM7R,RASUM7E D CANCEL^RAHLRPC
 D:RAEDP80[",EXAM,"
 .D CHSUM
 .S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",30)="" ;Reset sent flag
 .N RASUM7,RAEXMDUN,RASUM7R,RASUM7E D 1^RAHLRPC
 ;if EF report and recipient is VR, then don't re-send, RA*5*95
 I RARPST="EF",((RAPICK["RA-TALK")!(RAPICK["RA-PSCRIBE")!(RAPICK["RA-SCIMAGE")!(RAPICK["RA-RADWHERE")) Q
 D:RAEDP80[",RPT,"
 .D CHSUM N RASUM7,RANOSEND,RASUM7R,RASUM7E,RARPT D RPT^RAHLRPC
 Q
 ;
RAED(RADFN,RADTI,RACNI) ; identify correct ^RAHLRPC entry point(s)
 ;
 N RASTAT,RAIMTYP,RAORD,RETURN,RARPT
 S RASTAT=""
 ;
 S RETURN=",REG,"
 ;
 S RASTAT=$$GET1^DIQ(70.03,RACNI_","_RADTI_","_RADFN,3,"I")
 S RARPT=$$GET1^DIQ(70.03,RACNI_","_RADTI_","_RADFN,17,"I")
 ;
 S RAIMTYP=$$GET1^DIQ(72,+RASTAT,7) Q:'$L(RAIMTYP) ""
 S RAORD=$$GET1^DIQ(72,+RASTAT,3)
 ;
 S:RAORD=0 RETURN=RETURN_"CANCEL,"
 ;
 S:$$GET1^DIQ(72,+RASTAT,8)="YES" RETURN=RETURN_"EXAM," ; Generate Examined HL7 Message
 ;
 D:RETURN'[",EXAM,"
 .; also check previous statuses for 'Generate Examined HL7 Message'
 .F  S RAORD=$O(^RA(72,"AA",RAIMTYP,RAORD),-1) Q:+RAORD<1  D  Q:RETURN[",EXAM,"
 ..S RASTAT=$O(^RA(72,"AA",RAIMTYP,RAORD,0))
 ..S:$$GET1^DIQ(72,+RASTAT,8)="YES" RETURN=RETURN_"EXAM,"
 ;
 ; Check if Verified or Elec. Filed report exists ;RA*5*95
 S RARPST=$$GET1^DIQ(74,RARPT_",",5,"I")
 I RARPT]"",("^V^EF^"[("^"_RARPST_"^")) S RETURN=RETURN_"RPT,",RASUM7R=RASUM7R+1
 ;
 Q RETURN
 ;
SETVARS ; Setup key Rad/Nuc Med variables
 ;
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0)
 Q:'($D(RACCESS(DUZ))\10)  ; user does not have location access
 I $G(RAIMGTY)="" D SETVARS^RAPSET1(1) K:$G(RAIMGTY)="" XQUIT
 Q
STOP ;
 D ^%ZISC
 Q
 ;
GETAP(XX) ;
 ;Get list of Applications in XX
 N XXX,X11,X1,X2,X3,Z,Z1,J
 F X11="RA REG","RA EXAMINED","RA CANCEL","RA RPT" D
 .S X1=$E(X11,1,$L(X11)-1)_$C($A($E(X11,$L(X11)))-1)
 .F  S X1=$O(^ORD(101,"B",X1)) Q:X1'[X11  S X2=$O(^ORD(101,"B",X1,0)) Q:'X2  D
 ..K Z S X3=0 F  S X3=$O(^ORD(101,X2,775,X3)) Q:'X3  S Z(+^(X3,0))=""
 ..Q:'$D(Z)  K Z1 S X3=0 F  S X3=$O(Z(X3)) Q:'X3  D
 ...S Z1=$G(^ORD(101,X3,770)) S:+$P(Z1,U,2) XXX(+$P(Z1,U,2))=""
 S X1=0 F J=1:1 S X1=$O(XXX(X1)) Q:'X1  D
 .N DIERR,RAERR,Y
 .S Y=$$GET1^DIQ(771,X1,.01,"","","RAERR")
 .Q:Y=""!($D(RAERR)#2)  S XX(J,Y)=X1
 .Q
 Q $S($D(XXX):1,1:0)
 ;
GETSUB(APL,SUB,LINK) ;Get all subscribers (not associated with application)... To be excluded as recipients..
 ; Get all logical links to be in business, so we can control flow of messages
 ;Set up SUB() of 4 Radiology protocol IENS in file #101 that 
 ;are NOT associated with applications defined in APL()
 ;
 ;INPUT:
 ;APL(IEN) = Application #771 IENs
 ;
 ;OUTPUT:
 ;SUB(Event Driver #101 IEN,Subscriber #101 IEN)=.01 in file #101
 ;LINK(IEN of logical link #870)
 ;  
 N XX,X11,X1,X2,X3
 Q:'$O(APL(0))
 F X11="RA REG","RA EXAMINED","RA CANCEL","RA RPT" D
 .S X1=$E(X11,1,$L(X11)-1)_$C($A($E(X11,$L(X11)))-1)
 .F  S X1=$O(^ORD(101,"B",X1)) Q:X1'[X11  S X2=$O(^ORD(101,"B",X1,0)) Q:'X2  D
 ..S X3=0 F  S X3=$O(^ORD(101,X2,775,X3)) Q:'X3  S XX=+^(X3,0) D
 ...I '$D(APL(+$P($G(^ORD(101,XX,770)),U,2))) S SUB(X2,XX)=X1 Q
 ...S XX=+$P($G(^ORD(101,XX,770)),U,7) S:XX LINK(XX)=""
 Q
GETHLP(RAEID,HLP,ADR) ; Get excluded subcribers set into HLP array
 N I,J,XX,AA S J=$O(HLP("EXCLUDE SUBSCRIBER",99999999),-1)
 ;XX Set the list of already excluded subscribers, so be sure we don't set it second time
 S AA=ADR_"("_RAEID_",I)"
 S I=0 F I=$O(HLP("EXCLUDE SUBSCRIBER",I)) Q:'I  S XX(HLP("EXCLUDE SUBSCRIBER",I))=""
 S I=0 F  S I=$O(@AA) Q:'I  S:'$D(XX(I)) J=J+1,HLP("EXCLUDE SUBSCRIBER",J)=I
 Q
CHSUM ;CHECKSUM
 S RASUM7=RASUM7+1 I '(RASUM7#50) F  Q:'$$HANG  H 15
 Q
HANG() ; scan all logical links to see if queue is bigger than 100
 N I,S,L,QUIT
 S (QUIT,L)=0
 F  S L=$O(RASSSL(L)) Q:'L  S (S,I)=0 D  Q:QUIT
 .F  S I=$O(^HLMA("AC","O",L,I)) Q:'I  S S=S+1 I S>100 S QUIT=1 Q  ;Quit if more than 100 messages waiting in outgoing queue for link...
 Q QUIT
GETSUM(RABD,RAED) ; Get number of exams for period called from RAHLR RAHLR1 RAHLRPT RAHLRPT1
 N RADFN,RADTI,RACNI,RASUM7
 S RASUM7=0
 F  S RABD=$O(^RADPT("AR",RABD)) Q:'RABD!(RABD>RAED)  D
 .S RADFN=0 F  S RADFN=$O(^RADPT("AR",RABD,RADFN)) Q:'RADFN  D
 ..S RADTI=0 F  S RADTI=$O(^RADPT("AR",RABD,RADFN,RADTI)) Q:'RADTI  D
 ...S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  S:^(RACNI,0) RASUM7=RASUM7+1
 Q RASUM7
 Q
