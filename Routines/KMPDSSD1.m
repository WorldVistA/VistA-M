KMPDSSD1 ;OAK/RAK - CM Tools Status ;5/1/07  15:07
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**3,6**;Mar 22, 2002;Build 3
 ;
CPU ;-- cpu/node data
 ;
 N COUNT,DATA,I,LEN,TEXT
 ;
 D CPUGET^KMPDUTL6(.DATA)
 Q:'$D(DATA)
 S LN=LN+1
 D SET^VALM10(LN,"")
 S TEXT="   Node/CPU Data............... "
 S (COUNT,I,LEN)=0
 F  S I=$O(DATA(I)) Q:'I  D 
 .S COUNT=COUNT+1,DATA=$G(DATA(I,0)) Q:DATA=""
 .; length of node name
 .S:'LEN LEN=$L($P(DATA,U))+2
 .S TEXT=$S(COUNT=1:TEXT,1:$J(" ",32))_$P(DATA,U)
 .S TEXT=TEXT_$J(" ",32-$L(TEXT)+LEN)_$P(DATA,U,2)_" ("_$P(DATA,U,3)_")"
 .S LN=LN+1
 .D SET^VALM10(LN,TEXT)
 ;
 Q
 ;
MGRP ;-- mail group members
 ;
 N MEMBER,MEMBER1,NAME,NMARRY
 ;
 S IEN=$O(^XMB(3.8,"B","KMP-CAPMAN",0)) Q:'IEN
 ;
 S LN=LN+1
 D SET^VALM10(LN,"")
 ;
 S TEXT="   KMP-CAPMAN Mail Group......."
 ; check MEMBER field #2
 S MEMBER=0
 F  S MEMBER=$O(^XMB(3.8,IEN,1,"B",MEMBER)) Q:'MEMBER  D
 .S NAME=$P($G(^VA(200,MEMBER,0)),U)
 .I NAME'="" S NMARRY(NAME)=MEMBER
 ; remote members
 S MEMBER="",MEMBER1=0
 F  S MEMBER=$O(^XMB(3.8,IEN,6,"B",MEMBER)) Q:MEMBER=""  D 
 .S MEMBER1=0
 .F  S MEMBER1=$O(^XMB(3.8,IEN,6,"B",MEMBER,MEMBER1)) Q:'MEMBER1  D 
 ..S NAME=$P($G(^XMB(3.8,IEN,6,MEMBER1,0)),U)
 ..I NAME'="" S NMARRY(NAME)=MEMBER
 ;
 I '$D(NMARRY) S LN=LN+1 D SET^VALM10(LN,TEXT_" No Users") Q
 ;
 S NAME=""
 F  S NAME=$O(NMARRY(NAME)) Q:NAME=""  D
 .S MEMBER=NMARRY(NAME)
 .S TEXT=TEXT_$J(" ",32-$L(TEXT))_NAME
 .; if not a remote user
 .I NAME'["@" D 
 ..S MEMBER=$$ACTIVE^XUSER(MEMBER) I '+MEMBER S TEXT=TEXT_" ("_$P(MEMBER,U,2)_")"
 .S LN=LN+1
 .D SET^VALM10(LN,TEXT)
 .S TEXT=""
 ;
 Q
 ;
ROUCHK(KMPDPKG) ;--display routine version info
 ;-----------------------------------------------------------------------
 ; KMPDPKG... CM Package:
 ;            "D" - CM Tools
 ;            "R" - RUM
 ;            "S" - SAGG
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPDPKG)=""
 Q:KMPDPKG'="D"&(KMPDPKG'="R")&(KMPDPKG'="S")
 ;
 N I,TEXT,X
 ;
 ; routine check
 D VERPTCH^KMPDUTL1(KMPDPKG,.X)
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"")
 S TEXT="   "_$S(KMPDPKG="D":"CM TOOLS",KMPDPKG="R":"RUM",1:"SAGG")_" routines"
 S TEXT=TEXT_$$REPEAT^XLFSTR(".",31-$L(TEXT))
 I '$P($G(X(0)),U,3) S LN=LN+1 D SET^VALM10(LN,TEXT_" "_+X(0)_" Routines - No Problems") Q
 S LN=LN+1
 D SET^VALM10(LN,TEXT)
 S LN=LN+1
 D SET^VALM10(LN,$J(" ",20)_"Current Version"_$J(" ",20)_"Should be")
 S I=0 F  S I=$O(X(I)) Q:I=""  I $P(X(I),U) D 
 .S TEXT="   "_I
 .S TEXT=TEXT_$J(" ",20-$L(TEXT))_$P(X(I),U,4)
 .S:$P(X(I),U,5)]"" TEXT=TEXT_" - "_$P(X(I),U,5)
 .S TEXT=TEXT_$J(" ",55-$L(TEXT))_$P(X(I),U,2)
 .S:$P(X(I),U,3)]"" TEXT=TEXT_" - "_$P(X(I),U,3)
 .S LN=LN+1
 .D SET^VALM10(LN,TEXT)
 ;
 Q
 ;
PKG(KMPDNMSP) ;-- extrinsic function - return package name
 ;-----------------------------------------------------------------------------
 ; KMPDNMSP... H - HL7
 ;             R - RUM
 ;             S - SAGG
 ;             T - Timing
 ;
 ; Return: Package name
 ;         "" if not found
 ;-----------------------------------------------------------------------------
 ;
 Q:$G(KMPDNMSP)="" ""
 ;
 N IEN,NMSP
 S NMSP="KMP"_$S(KMPDNMSP="H"!(KMPDNMSP="T"):"D",1:KMPDNMSP)
 S IEN=$O(^DIC(9.4,"C",NMSP,0))
 Q $S(IEN:$P($G(^DIC(9.4,+IEN,0)),U),1:"")
