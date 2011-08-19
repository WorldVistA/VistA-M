KMPDUT2 ;OAK/RAK - CM Tools Utility ;2/17/04  10:45
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
ID(KMPDIEN) ;--called from ^DD(8973.1,0,"ID","W")
 ;-----------------------------------------------------------------------
 ; KMPDIEN... Ien for file #8973.1 (CM HL7 DATA)
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDIEN)
 Q:'$D(^KMPD(8973.1,+KMPDIEN,0))
 N DATA,TXT
 S DATA=$G(^KMPD(8973.1,+KMPDIEN,0)),DATA(99.2)=$G(^(99.2)) Q:DATA=""
 ; sent to national database
 S TXT(1)=$S($P(DATA,U,2):"sent",1:"not sent")
 S TXT(1)=TXT(1)_$J(" ",11-$L(TXT(1)))
 ; namespace
 S TXT(1)=TXT(1)_$P(DATA,U,3)
 S TXT(1)=TXT(1)_$J(" ",18-$L(TXT(1)))
 ; protocol
 S TXT(1)=TXT(1)_$P(DATA,U,5)
 S TXT(1)=TXT(1)_$J(" ",52-$L(TXT(1)))
 ; synch/asynch
 S TXT(1)=TXT(1)_$S($P(DATA,U,6)=1:"sync",1:"async")
 ; other site number
 I $P(DATA(99.2),U,12)'="" D 
 .S TXT(2)=$P(DATA(99.2),U,12)
 .S TXT(2,"F")="!?41"
 S TXT(1,"F")="?15"
 D EN^DDIOL(.TXT)
 Q
 ;
ID1(KMPDIEN) ;--called from ^DD(8973.2,0,"ID","W")
 ;-----------------------------------------------------------------------
 ; KMPDIEN... Ien for file #8973.2 (CM TIMING)
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDIEN)
 Q:'$D(^KMPD(8973.2,+KMPDIEN,0))
 N DATA,TXT
 S DATA=$G(^KMPD(8973.2,+KMPDIEN,0)) Q:DATA=""
 S TXT(1)=""
 ; date/time
 S TXT(1)=TXT(1)_$$FMTE^XLFDT($P(DATA,U,3),2)
 S TXT(1)=TXT(1)_$J(" ",18-$L(TXT(1)))
 ; title
 S TXT(1)=TXT(1)_$E($P(DATA,U,8),1,16)
 ; client name
 S TXT(2)=$E($P(DATA,U,6),1,30)
 ; person
 S TXT(3)=$P($G(^VA(200,+$P(DATA,U,5),0)),U)
 ; sent to national database
 S TXT(4)="weekly - "_$S($P(DATA,U,2):"sent",1:"not sent")
 S TXT(5)="daily - "_$S($P(DATA,U,10):"sent",1:"not sent")
 ;S TXT(1)=TXT(1)_$J(" ",11-$L(TXT(1)))
 S TXT(1,"F")="?45"
 S TXT(2,"F")="!?48"
 S TXT(3,"F")="!?48"
 S TXT(4,"F")="!?48"
 S TXT(5,"F")="!?48"
 D EN^DDIOL(.TXT)
 Q
 ;
XREF(DA,X,KMPDTYPE) ;-set/kill 'APTDTNM' xref in file #8973.1
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.1 (CM HL7 DATA)
 ; X........ Value of field #.05 (PROTOCOL)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N DATA,DATE,NM
 S DATA=$G(^KMPD(8973.1,DA,0)) Q:DATA=""
 S DATE=$P(DATA,U) Q:'DATE
 S NM=$P(DATA,U,3) Q:NM=""
 I KMPDTYPE=1 S ^KMPD(8973.1,"APTDTNM",X,DATE,NM,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.1,"APTDTNM",X,DATE,NM,DA)
 Q
 ;
XREF1(DA,X,KMPDTYPE) ;-set/kill 'ACSDTPRNM' xref in file #8973.1
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.1 (CM HL7 DATA)
 ; X........ Value of field #99.212 (CONTACTED SITE NAME)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;
 ; variables used:
 ; DATE.. Internal value of field #.01 (DATE)
 ; NM.... Internal value of field #.03 (NAMESPACE)
 ; PR.... Internal value of field #.05 (PROTOCOL)
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N DATA,DATE,NM,PR
 S DATA=$G(^KMPD(8973.1,DA,0)) Q:DATA=""
 S DATE=$P(DATA,U) Q:'DATE
 S NM=$P(DATA,U,3) Q:NM=""
 S PR=$P(DATA,U,5) Q:PR=""
 I KMPDTYPE=1 S ^KMPD(8973.1,"ACSDTPRNM",X,DATE,PR,NM,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.1,"ACSDTPRNM",X,DATE,PR,NM,DA)
 Q
 ;
XREF2(DA,X,KMPDTYPE) ;-set/kill 'ASYNC' xref in file #8973.1
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.1 (CM HL7 DATA)
 ; X........ Value of field #.06 (SYNC/ASYNC)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;
 ; variables used:
 ; DATE.. Internal value of field #.01 (DATE)
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N DATA,DATE
 S DATA=$G(^KMPD(8973.1,DA,0)) Q:DATA=""
 S DATE=$P(DATA,U) Q:'DATE
 I KMPDTYPE=1 S ^KMPD(8973.1,"ASYNC",DATE,X,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.1,"ASYNC",DATE,X,DA)
 Q
 ;
XREFT1(DA,X,KMPDTYPE) ;-set/kill 'ASVDTSS' xref in file #8973.2
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.2 (CM TIMING)
 ; X........ Value of field #.07 (SERVER SUBSCRIPT)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N DATA,DATE
 S DATA=$G(^KMPD(8973.2,DA,0)) Q:DATA=""
 ; strip off time
 S DATE=$P($P(DATA,U,3),".") Q:'DATE
 I KMPDTYPE=1 S ^KMPD(8973.2,"ASVDTSS",X,DATE,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.2,"ASVDTSS",X,DATE,DA)
 Q
 ;
XREFT2(DA,X,KMPDTYPE) ;-set/kill 'ASSDTPT' xref in file #8973.2
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.2 (CM TIMING)
 ; X........ Value of field #.07 (SERVER SUBSCRIPT)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;
 ; ^KMPD(8973.2,"ASSDTPT",ServerSubscript,ServerStartDate,PrimeTime,DA)
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N DATA,DATE,PTNP
 S DATA=$G(^KMPD(8973.2,DA,0)) Q:DATA=""
 ; server start date/time
 S DATE=$P(DATA,U,3) Q:'DATE
 ; prime time / non-prime time
 S PTNP=$$PTNP^KMPDHU03(DATE) Q:'PTNP
 ; strip off time
 S DATE=$P(DATE,".") Q:'DATE
 I KMPDTYPE=1 S ^KMPD(8973.2,"ASSDTPT",X,DATE,PTNP,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.2,"ASSDTPT",X,DATE,PTNP,DA)
 Q
 ;
XREFT3(DA,X,KMPDTYPE) ;-set/kill 'ASSDTTM' xref in file #8973.2
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.2 (CM TIMING)
 ; X........ Value of field #.07 (SERVER SUBSCRIPT)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;
 ; ^KMPD(8973.2,"ASSDTTM",ServerSubscript,ServerStartDate,PrimeTime,DA)
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N DATA,DATE
 S DATA=$G(^KMPD(8973.2,DA,0)) Q:DATA=""
 ; server start date/time
 S DATE=$P(DATA,U,3) Q:'DATE
 I KMPDTYPE=1 S ^KMPD(8973.2,"ASSDTTM",X,DATE,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.2,"ASSDTTM",X,DATE,DA)
 Q
 ;
XREFT4(DA,X,KMPDTYPE) ;-set/kill 'ASSCLDTTM' xref in file #8973.2
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.2 (CM TIMING)
 ; X........ Value of field #.07 (KMPTMP SUBSCRIPT)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;
 ; ^KMPD(8973.2,"ASSCLDTTM",KmptmpSubscript,ClientName,ServerDateTime,DA)
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N CLNM,DATA,DATE
 S DATA=$G(^KMPD(8973.2,DA,0)) Q:DATA=""
 ; server start date/time
 S DATE=$P(DATA,U,3) Q:'DATE
 ; client name
 S CLNM=$P(DATA,U,6) Q:CLNM=""
 I KMPDTYPE=1 S ^KMPD(8973.2,"ASSCLDTTM",X,CLNM,DATE,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.2,"ASSCLDTTM",X,CLNM,DATE,DA)
 Q
XREFT5(DA,X,KMPDTYPE) ;-set/kill 'ASSNPDTTM' xref in file #8973.2
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.2 (CM TIMING)
 ; X........ Value of field #.07 (KMPTMP SUBSCRIPT)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;
 ; ^KMPD(8973.2,"ASSNPDTTM",KmptmpSubscript,NewPerson,ServerDateTime,DA)
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N NP,DATA,DATE
 S DATA=$G(^KMPD(8973.2,DA,0)) Q:DATA=""
 ; server start date/time
 S DATE=$P(DATA,U,3) Q:'DATE
 ; new person
 S NP=$P(DATA,U,5) Q:NP=""
 I KMPDTYPE=1 S ^KMPD(8973.2,"ASSNPDTTM",X,NP,DATE,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.2,"ASSNPDTTM",X,NP,DATE,DA)
 Q
 ;
XREFT6(DA,X,KMPDTYPE) ;-set/kill 'ASSIPDTTM' xref in file #8973.2
 ;-----------------------------------------------------------------------
 ; DA....... Ien for file #8973.2 (CM TIMING)
 ; X........ Value of field #.07 (KMPTMP SUBSCRIPT)
 ; KMPDTYPE. 1 - set xref
 ;           2 - kill xref
 ;
 ; ^KMPD(8973.2,"ASSIPDTTM",KmptmpSubscript,IpAddress,ServerDateTime,DA)
 ;-----------------------------------------------------------------------
 Q:'$G(DA)
 Q:$G(X)=""
 Q:'$G(KMPDTYPE)
 N IP,DATA,DATE
 S DATA=$G(^KMPD(8973.2,DA,0)) Q:DATA=""
 ; server start date/time
 S DATE=$P(DATA,U,3) Q:'DATE
 ; ip address
 S IP=$P(DATA,U,9) Q:IP=""
 I KMPDTYPE=1 S ^KMPD(8973.2,"ASSIPDTTM",X,IP,DATE,DA)=""
 I KMPDTYPE=2 K ^KMPD(8973.2,"ASSIPDTTM",X,IP,DATE,DA)
 Q
