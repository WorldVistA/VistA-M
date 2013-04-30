LA7VHLU9 ;DALOI/JMC - HL7 segment builder utility ;09/14/11  15:56
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**68,74**;Sep 27, 1994;Build 229
 ;
 ; Reference to NPI^XUSNPI supported by DBIA #4532
 ; Reference to QI^XUSNPI supported by DBIA #4532
 ;
 ;
XCN(LA7DUZ,LA7DIV,LA7FS,LA7ECH,LA7DMT,LA7IDTYP) ; Build composite ID and name for person
 ; Call with   LA7DUZ = DUZ of person
 ;                      If not pointer to #200, then use as literal
 ;             LA7DIV = Institution of user
 ;              LA7FS = HL field separator
 ;             LA7ECH = HL encoding characters
 ;             LA7DMT = flag to indicate delimiters should be demoted
 ;           LA7IDTYP = id type to return (0:DUZ 1:VPID 2:NPI)
 ;
 N I,LA7CS,LA7NPI,LA7SITE,LA7VAF,LA7VPID,LA7X,LA7Y,LA7Z,NAME
 ;
 S (LA7Y,LA7Z)="",LA7DMT=+$G(LA7DMT),LA7IDTYP=+$G(LA7IDTYP)
 ; If demoting delimiters then use sub-component delimiter instead of component delimiter.
 S LA7CS=$E(LA7ECH,$S(LA7DMT=1:4,1:1))
 ;
 ; Check if this field has been built previously for this person
 I LA7DUZ'="",$D(^TMP($J,"LA7VHLU","99VA200",LA7DUZ,LA7FS_LA7ECH,LA7DMT,LA7IDTYP)) S LA7Y=^TMP($J,"LA7VHLU","99VA200",LA7DUZ,LA7FS_LA7ECH,LA7DMT,LA7IDTYP)
 ;
 ; Build from file #200
 I LA7Y="",LA7DUZ>0,LA7DUZ?1.N D
 . S NAME("FILE")=200,NAME("FIELD")=.01,NAME("IENS")=LA7DUZ
 . S LA7Z=$$HLNAME^XLFNAME(.NAME,"S",LA7CS)
 . I LA7IDTYP=2 D  Q:LA7NPI>0
 . . S LA7NPI=$$NPI^XUSNPI("Individual_ID",LA7DUZ,DT)
 . . I LA7NPI>0 S $P(LA7Y,LA7CS)=$P(LA7NPI,"^"),$P(LA7Y,LA7CS,9)="USDHHS",$P(LA7Y,LA7CS,11)=$E(LA7NPI,10),$P(LA7Y,LA7CS,12,13)="NPI"_LA7CS_"NPI"
 . I LA7IDTYP>0 D  Q:LA7VPID'=""
 . . S LA7VPID=$$VPID^XUPS(LA7DUZ)
 . . I LA7VPID'="" S $P(LA7Y,LA7CS)=LA7VPID,$P(LA7Y,LA7CS,9)="USVHA",$P(LA7Y,LA7CS,13)="PN"
 . ; If no institution, use Kernel Site default
 . I LA7DIV="" S LA7DIV=+$$KSP^XUPARAM("INST")
 . S LA7SITE=$$RETFACID^LA7VHLU2(LA7DIV,0,1)
 . I LA7SITE'="" D
 . . S LA7VAF=$$GET1^DIQ(4,LA7DIV_",","AGENCY CODE","I")
 . . I LA7VAF="V" S LA7SITE="VA"_LA7SITE
 . . S LA7DUZ=LA7DUZ_"-"_LA7SITE,$P(LA7Y,LA7CS,8)="99VA4"
 . S $P(LA7Y,LA7CS)=LA7DUZ
 ;
 ; If only name passed
 I LA7Y="",'LA7DUZ D
 . S NAME=LA7DUZ
 . I LA7DUZ["[",LA7DUZ["]" D
 . . S NAME=$P(LA7DUZ,"["),NAME(1)=$P(LA7DUZ,"[",2),NAME(1)=$P(NAME(1),"]")
 . . I $P(NAME(1),":",2)?1(1"NPI",1"PN") S $P(LA7Y,LA7CS)=$P(NAME(1),":"),$P(LA7Y,LA7CS,9)=$P(NAME(1),":",4),$P(LA7Y,LA7CS,13)=$P(NAME(1),":",2)
 . . I $P(NAME(1),":",2)?1(1"99"1.E,1"L") S $P(LA7Y,LA7CS)=$P(NAME(1),":"),$P(LA7Y,LA7CS,8)=$P(NAME(1),":",2)
 . S NAME=$$CHKDATA^LA7VHLU3(NAME,LA7FS_LA7ECH)
 . S LA7Z=$$HLNAME^XLFNAME(NAME,"S",LA7CS)
 ;
 I LA7Z'="" F I=1:1:6 S $P(LA7Y,LA7CS,I+1)=$P(LA7Z,LA7CS,I)
 ;
 ; Save this field to TMP global to use for subsequent calls.
 I LA7DUZ'="" S ^TMP($J,"LA7VHLU","99VA200",LA7DUZ,LA7FS_LA7ECH,LA7DMT,LA7IDTYP)=LA7Y
 ;
 Q LA7Y
 ;
 ;
 ;
XCNTFM(LA7X,LA7ECH) ; Resolve XCN data type to FileMan (last name, first name, mi [id])
 ; Call with LA7X = HL7 field containing name
 ;         LA7ECH = HL7 encoding characters
 ;
 ; Returns   LA7Y = ID code^DUZ^FileMan name (DUZ=0 if name not found on local system).
 ;
 N LA7DUZ,LA7IDC,LA7Y,LA7Z,X
 ;
 ;
 S LA7DUZ=0
 ;
 ; Check for VPID
 S (LA7IDC,LA7Z)=$P(LA7X,$E(LA7ECH))
 I $P(LA7X,$E(LA7ECH),9)="USVHA",$P(LA7X,$E(LA7ECH),13)="PN" D
 . S X=$$IEN^XUPS(LA7IDC)
 . I X>0 S LA7DUZ=X
 ;
 ; Check for NPI
 I $P(LA7X,$E(LA7ECH),9)="USDHHS",$P(LA7X,$E(LA7ECH),13)="NPI" D
 . S X=$$QI^XUSNPI(LA7IDC)
 . I $P(X,"^")="Individual_ID",$P(X,"^",2)>0 S LA7DUZ=$P(X,"^",2)
 ;
 ; Check for coding that indicates DUZ from a VA facility
 I 'LA7DUZ,LA7Z?.(1.N1"-VA"3N,1.N1"-VA"3N2U) D
 . N LA7J,LA7K
 . S LA7Z(1)=$P(LA7Z,"-"),LA7Z(2)=$P(LA7Z,"-",2)
 . S LA7K=$$FINDSITE^LA7VHLU2(LA7Z(2),1,1)
 . S LA7J=$$DIV4^XUSER(.LA7J,LA7Z(1))
 . I LA7K,$D(LA7J(LA7K)) S LA7DUZ=LA7Z(1)
 . I LA7K,'LA7DUZ,'LA7J D  ;ccr_5591n - If user is not assigned any divisions, try find match based off default institution
 . . I $$KSP^XUPARAM("INST")=LA7K,$$ACTIVE^XUSER(LA7Z(1))'="" S LA7DUZ=LA7Z(1)
 ;
 ; Check if code resolves to a valid user.
 I 'LA7DUZ,LA7Z=+LA7Z D
 . S X=$$ACTIVE^XUSER(LA7Z)
 . I X,$P(X,"^",2)'="" S LA7DUZ=LA7Z
 ;
 S LA7Y=$$FMNAME^HLFNC($P(LA7X,$E(LA7ECH),2,6),LA7ECH)
 ; HL function sometimes returns trailing "," on name
 S LA7Y=$$TRIM^XLFSTR(LA7Y,"R",",")
 ;
 ; Put identifying code at end of name in "[code:id type:va id type:issuing authority]".
 I $P(LA7X,$E(LA7ECH))'="",LA7Y'="" D
 . S X=""
 . I $P(LA7X,$E(LA7ECH),8)?1(1"99"1.E,1"L") S X=$P(LA7X,$E(LA7ECH),8)
 . I $P(LA7X,$E(LA7ECH),9)="USVHA",$P(LA7X,$E(LA7ECH),13)="PN" S X="PN:VPID:USVHA"
 . I $P(LA7X,$E(LA7ECH),9)="USDHHS",$P(LA7X,$E(LA7ECH),13)="NPI" S X="NPI:NPI:USDHHS"
 . S LA7Y=LA7Y_" ["_$P(LA7X,$E(LA7ECH))_":"_X_"]"
 ;
 Q LA7IDC_"^"_LA7DUZ_"^"_LA7Y
