PRCNPR2 ;SSI/SEB-Print fields based on their type ;[ 08/05/96  12:53 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
PR ; Print whatever
 S PRCNDD=^DD(N,FN,0),ID=$P(PRCNDD,U,2),PC=$P(PRCNDD,U,4)
 F I=1:1:PRCNDEEP W "    "
 W:ID'="W"&($P(^DD(N,0),U,4)>1) $P(PRCNDD,U),": " I ID["C" D COMP Q
 Q:PC=""!(PC=" ")!(IN'?1N.N)  I +ID D MULT Q
 S VAL=$P($G(@(GLO_IN_","_$P(PC,";")_")")),U,$P(PC,";",2))
 W:ID["W"!(ID["F")!(ID["N") VAL I ID["D"&(VAL]"") S Y=VAL D DD^%DT W Y
 I ID["P" D
 . I VAL=""!(VAL'?.N) W VAL Q
 . I VAL?.N S PGL="^"_$P(PRCNDD,U,3),PV=$P($G(@(PGL_VAL_",0)")),U) W PV Q
 I ID["S" S CODES=$P(PRCNDD,U,3) F I=1:1 S C=$P(CODES,";",I) Q:C=""  W:VAL=$P(C,":") $P(C,":",2)
 Q
COMP ; Deal with computed fields
 F I=0:1 S V=$P(GLO,",",2*(I+1)) Q:V=""  X "S D"_I_"=V"
 X "S D"_I_"=IN",$P(^DD(N,FN,0),U,5,99) W X F J=1:1:I X "K D"_I
 Q
MULT ; Deal with multiples and word-processing fields
 N OFN S OFN=FN
 S OPC=PC,OIN=IN,OID=ID,OGLO=GLO N FN,N,IN,PC,ID,GLO
 S GLO=OGLO_OIN_","_$P(OPC,";")_",",N=+OID
 S IN=0 F  S IN=$O(@(GLO_IN_")")) Q:IN'?1N.N  D
 . S PRCNDEEP=PRCNDEEP+1 X "D SUBS^PRCN"_PROG S PRCNDEEP=PRCNDEEP-1
 Q
QUE ;  When queuing off the display/print of request
 S ZTRTN="BEG^PRCNPRNT",ZTDESC="Equipment Request"
 S ZTSAVE("IN")="",ZTSAVE("PRCNUSR")="",ZTSAVE("PRCNTDA")=""
 D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTSK,%ZTLOAD,ZTREQ
 Q
QUT ;  When queuing off the display/print of a turnin request
 S ZTRTN="TN^PRCNPRNT",ZTSAVE("F")="",ZTSAVE("PRCNDEEP")=""
 S ZTSAVE("N")="",ZTSAVE("GLO")="",ZTSAVE("FF")=""
 D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTSK,%ZTLOAD,ZTREQ
 Q
