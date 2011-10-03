KMPDHU03 ;OAK/RAK - CM Tools Compile & File HL7 Daily Stats ;2/17/04  08:59
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
COMPILE ;-compile synchronous data into GLB1
 ;-----------------------------------------------------------------------
 ; DATA.... data from GBL array
 ; DATE.... date.hr
 ; ND...... node where data will be filed in file #8973.1
 ; LC...... up-arrow (^) piece location of data to be filed
 ; NM....... namespace
 ; PT...... protocol name~ien
 ; PTNP.... prime time - 1
 ;          non-prime time 2
 ;-----------------------------------------------------------------------
 ;
 N DATA,DATE,I,ND,LC,NM,PT,PTNP
 ;
 Q:'$D(@GBL@(SS1,SS2,SS3,SS4,SS5,SS6))  S DATA=$G(^(SS6)) Q:DATA=""
 ; namespace
 S NM=$S(SS1="HR"!(SS1="PROT"):SS5,SS1="NMSP":SS4,1:"") Q:NM=""
 ; protocol
 S PT=$S(SS1="HR"!(SS1="NMSP"):SS6,SS1="PROT":SS4,1:"") Q:PT=""
 ; prime time - 1, non-prime time - 2
 S DATE=$S(SS1="HR":SS4,SS1="NMSP":SS5,SS1="PROT":SS6,1:"") Q:'DATE
 ; DATE is set by using the 'next highest' hour
 ; 3030509.0811 is returned as 3030509.09
 ; use $$fmadd to go back to previous hour
 S PTNP=$$PTNP^KMPDHU03($$FMADD^XLFDT(DATE,,-1)) Q:'PTNP
 ;
 I SS1="HR" D 
 .S ND=$S(SS2="TM":1,1:""),ND=ND+(PTNP-1)
 .S LC=$S(SS3="T":0,SS3="M":3,SS3="U":6,1:"")
 I SS1="NMSP" D 
 .S ND=$S(SS2="IO":1.1,SS2="LR":1.2,1:""),ND=ND+(PTNP-1)
 .S LC=$S(SS3="I"!(SS3="L"):0,SS3="O"!(SS3="R"):3,SS3="U":6,1:"") Q:LC=""
 I SS1="PROT" D 
 .S ND=99,LC=$S(PTNP=1:0,PTNP=2:3,1:"")
 ;
 ; quit if not node (ND) or location (LC)
 Q:'$P(DATE,".")!('ND)!(LC="")
 ;
 F I=1,3 D 
 .S $P(@GBL1@($P(DATE,"."),PT,NM,ND),U,(I+LC))=$P($G(@GBL1@($P(DATE,"."),PT,NM,ND)),U,(I+LC))+$P(DATA,U,I)
 S $P(@GBL1@($P(DATE,"."),PT,NM,ND),U,(2+LC))=$P($G(@GBL1@($P(DATE,"."),PT,NM,ND)),U,(2+LC))+$P(DATA,U,4)
 ;
 Q
 ;
FILE(KMPDSYNC) ;-file data into file 8973.1 (CM HL7 DATA)
 ;-----------------------------------------------------------------------
 ; KMPDSYNC... 1 - synchronous
 ;             2 - asynchronous
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDSYNC)
 Q:KMPDSYNC<1!(KMPDSYNC>2)
 Q:'$D(@GBL1)
 ;
 W:'$D(ZTQUEUED) !,"Filing ",$S(KMPDSYNC=2:"asynchronous",1:"synchronous")," HL7 stats into file 8973.1 (CM HL7 DATA)..."
 ;
 ; file data
 D @("FILE"_KMPDSYNC) Q:'$D(FDA)
 ;
 Q
 ;
FILE1 ;-- file synchronous data
 ;
 Q:'$D(@GBL1)
 ;
 N DATE,ERROR,FDA,I,IEN,INDEX,NM,PT,PT1,ZIEN
 ;
 S DATE=0
 F  S DATE=$O(@GBL1@(DATE)) Q:'DATE  S PT="" D 
 .F  S PT=$O(@GBL1@(DATE,PT)) Q:PT=""  S NM="" D 
 ..; remove ien (name~123) from protocol
 ..S PT1=$P(PT,"~") Q:PT1=""
 ..F  S NM=$O(@GBL1@(DATE,PT,NM)) Q:NM=""  S ND=0 D 
 ...K ERROR,FDA,IEN,ZIEN
 ...; determine if data has already been filed (if ien)
 ...S IEN=$O(^KMPD(8973.1,"APTDTNM",PT1,DATE,NM,0))
 ...;     if filed set IEN="ien," - edit entry
 ...; if not filed set IEN="+1," - add entry
 ...S IEN=$S(IEN:IEN_",",1:"+1,")
 ...S FDA($J,8973.1,IEN,.01)=DATE
 ...S FDA($J,8973.1,IEN,.03)=NM
 ...S FDA($J,8973.1,IEN,.05)=PT1
 ...S FDA($J,8973.1,IEN,.06)=1
 ...F  S ND=$O(@GBL1@(DATE,PT,NM,ND)) Q:'ND  D 
 ....S DATA=@GBL1@(DATE,PT,NM,ND) Q:DATA=""
 ....S INDEX=$S(ND=99:6,ND=99.2:13,ND=99.5:3,$E(ND)=5:24,1:9)
 ....F I=1:1:INDEX S:$P(DATA,U,I)'="" FDA($J,8973.1,IEN,ND+(I*.001))=$P(DATA,U,I)
 ...; file data
 ...D UPDATE^DIE("","FDA($J)","ZIEN","ERROR")
 ...; if error
 ...I $D(ERROR) D 
 ....D MSG^DIALOG("HA",.KMPDERR,60,5,"ERROR")
 ....D EMAIL^KMPDUTL2("CM TOOLS - HL7 DAILY Error","KMPDERR(")
 ;
 Q
 ;
FILE2 ;-- file asynchronous data
 ;
 Q:'$D(@GBL1)
 ;
 N CF,DATE,ERROR,I,IEN,INDEX1,INDEX2,KMPDERR,NM,PT,PT1,ZIEN
 ;
 K ^TMP($J,"KMPDHU03-F2")
 S DATE=0
 F  S DATE=$O(@GBL1@(DATE)) Q:'DATE  S PT="" D 
 .F  S PT=$O(@GBL1@(DATE,PT)) Q:PT=""  S NM="" D 
 ..; remove ien (name~123) from protocol
 ..S PT1=$P(PT,"~") Q:PT1=""
 ..F  S NM=$O(@GBL1@(DATE,PT,NM)) Q:NM=""  S CF="" D 
 ...F  S CF=$O(@GBL1@(DATE,PT,NM,CF)) Q:CF=""  S ND=0 D 
 ....K ERROR,IEN,ZIEN,^TMP($J,"KMPDHU03-F2"),^TMP($J,"KMPDHU03-ERROR")
 ....; determine if data has already been filed (if ien)
 ....S IEN=$O(^KMPD(8973.1,"ACSDTPRNM",CF,DATE,PT1,NM,0))
 ....;     if filed set IEN="ien," - edit entry
 ....; if not filed set IEN="+1," - add entry
 ....S IEN=$S(IEN:IEN_",",1:"+1,")
 ....; date
 ....S ^TMP($J,"KMPDHU03-F2",8973.1,IEN,.01)=DATE
 ....; namespace
 ....S ^TMP($J,"KMPDHU03-F2",8973.1,IEN,.03)=NM
 ....; protocol
 ....S ^TMP($J,"KMPDHU03-F2",8973.1,IEN,.05)=PT1
 ....; 2 = asynchronous
 ....S ^TMP($J,"KMPDHU03-F2",8973.1,IEN,.06)=2
 ....F  S ND=$O(@GBL1@(DATE,PT,NM,CF,ND)) Q:'ND  D 
 .....S DATA=@GBL1@(DATE,PT,NM,CF,ND) Q:DATA=""
 .....; starting index
 .....S INDEX1=1 ;$S($E(ND)=5:9,1:1)
 .....; ending index
 .....S INDEX2=$S(ND=99:6,ND=99.2:13,ND=99.3:9,ND=99.5:3,$E(ND)=5:24,$E(ND)=6:24,1:0)
 .....Q:'INDEX2
 .....F I=INDEX1:1:INDEX2 S:$P(DATA,U,I)'="" ^TMP($J,"KMPDHU03-F2",8973.1,IEN,ND+(I*.001))=$P(DATA,U,I)
 ....;file data
 ....D UPDATE^DIE("",$NA(^TMP($J,"KMPDHU03-F2")),"ZIEN","ERROR")
 ....; if error
 ....I $D(ERROR) D 
 .....D MSG^DIALOG("HA",.KMPDERR,60,5,"ERROR")
 .....D EMAIL^KMPDUTL2("CM TOOLS - HL7 DAILY Error","KMPDERR(")
 ;
 K ^TMP($J,"KMPDHU03-F2")
 ;
 Q
 ;
PTNP(DATE) ;-extrinsic function - determine if date.hr is prime time or non-prime time
 ;-----------------------------------------------------------------------
 ; DATE.... Date.Time in internal FileMan format
 ;
 ; Return: 1 - prime time
 ;         2 - non-prime time
 ;        "" - unable to identify
 ;-----------------------------------------------------------------------
 Q:'$G(DATE) ""
 N DOW,HOUR
 ; day of week in numeric format
 S DOW=$$DOW^XLFDT(DATE,1)
 ; hours
 S HOUR=$E($P(DATE,".",2),1,2)
 ; prime time - not saturday or sunday or holiday and between the hours
 ;              of 8am (0800) to 5 pm (1700)
 Q:DOW'=0&(DOW'=6)&('$G(^HOLIDAY($P(DATE,"."),0)))&(HOUR>7)&(HOUR<17) 1
 ; non-prime time
 Q 2
