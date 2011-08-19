VAFCQRY4 ;BIR/CMC-CONT TO BLD PID 2.4 SEGMENT ;1/23/06
 ;;5.3;Registration;**707**;Aug 13, 1993;Build 14
 ;
CONT(DFN,APID,PID,HL,HLES,SARY,SEQ,ERROR,REP,COMP) ; continue to bld pid segment
 N X,LVL,LVL2,PDOD,NXT,LNGTH
 D DEM^VADPT
 I $D(SARY(10))!(SEQ="ALL") D
 .N RACE,IEN
 .;**575 ADDING RACE FROM THE NEW RACE INFORMATION MULTIPLE
 .I VADM(12)>0 D
 ..S RACE="",IEN=0
 ..D SEQ10^VAFHLPI1("N",HL("Q"))
 ..F  S IEN=$O(VAFY(10,IEN)) Q:IEN=""  D
 ...I IEN>1 S RACE=RACE_REP
 ...S RACE=RACE_VAFY(10,IEN,1)_COMP_VAFY(10,IEN,2)_COMP_VAFY(10,IEN,3)_COMP_$P(VAFY(10,IEN,1),"-",1,2)_COMP_COMP_"CDC"
 .I VADM(12)=0 S RACE=HL("Q")
 .K VAFY(10)
 .S APID(11)=RACE
 I $D(SARY(22))!(SEQ="ALL") D
 .;**575 ADDING ETHNICITY FROM THE NEW ETHNICITY INFORMATION MULTIPLE
 .I $G(VADM(11))'=0 D
 ..D SEQ22^VAFHLPI1("N",HL("Q"))
 ..S APID(23)=VAFY(22,1,1)_COMP_VAFY(22,1,2)_COMP_VAFY(22,1,3)_COMP_$P(VAFY(22,1,1),"-",1,2)_COMP_COMP_"CDC"
 .I $G(VADM(11))=0 S APID(23)=HL("Q")  ;ethnic group
 .K VAFY(22)
 I $D(SARY(16))!(SEQ="ALL") D
 .S APID(17)="" I +VADM(10)>0 S X=$P($G(^DIC(11,+VADM(10),0)),"^",3),APID(17)=$S(X="S":"A",X="N":"S",X="U":"",X="":HL("Q"),1:X) ;marital status (DHCP N=HL7 S, DHCP S=HL7 A, U="") ;**477 **575
 .I APID(17)="" S APID(17)=HL("Q")
 I $D(SARY(17))!(SEQ="ALL") D
 .S APID(18)="" I +VADM(9)>0 S APID(18)=$P($G(^DIC(13,+VADM(9),0)),"^",4) I APID(18)="" S APID(18)=29  ;religious pref (if blank send 29 (UNKNOWN))
 .I APID(18)="" S APID(18)=HL("Q")
 I $D(SARY(29))!(SEQ="ALL") D
 .S APID(30)="" I $D(^DPT(DFN,.35)) S PDOD=$P(^DPT(DFN,.35),"^") S APID(30)=$$HLDATE^HLFNC(PDOD)  ;date of death
 .I APID(30)="" S APID(30)=HL("Q")
 I $D(SARY(24))!(SEQ="ALL") S APID(25)=$P($G(^DPT(DFN,"MPIMB")),"^")  ;**575 multiple birth indicator
 ;list of fields not currently used or supported (# is 1 more than seq)
 I $D(SARY(4))!(SEQ="ALL") S APID(5)=""  ;Alternate Patient Identifier
 I $D(SARY(9))!(SEQ="ALL") S APID(10)=""  ;patient alias
 I $D(SARY(15))!(SEQ="ALL") S APID(16)=""  ;primary language
 I $D(SARY(18))!(SEQ="ALL") S APID(19)=""  ;patient account #
 I $D(SARY(20))!(SEQ="ALL") S APID(21)=""  ;drivers lic #
 I $D(SARY(21))!(SEQ="ALL") S APID(22)=""  ;mother's id
 I $D(SARY(25))!(SEQ="ALL") S APID(26)=""
 I $D(SARY(26))!(SEQ="ALL") S APID(27)=""
 I $D(SARY(27))!(SEQ="ALL") S APID(28)=""
 I $D(SARY(28))!(SEQ="ALL") S APID(29)=""
 I $D(SARY(30))!(SEQ="ALL") S APID(31)=""
 S PID(1)="PID"_HL("FS")
 S LVL=1,X=1 F  S X=$O(APID(X)) Q:'X  D
 .S PID(LVL)=$G(PID(LVL))
 .S NXT=APID(X) D
 ..I '$O(APID(X,0)) S NXT=NXT_HL("FS")
 ..I $L($G(PID(LVL))_NXT)>245 D
 ... S LNGTH=245-$L(PID(LVL)),PID(LVL)=PID(LVL)_$E(NXT,1,LNGTH)
 ... S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),LVL=LVL+1
 ..I $L($G(PID(LVL))_NXT)'>245 S PID(LVL)=$G(PID(LVL))_NXT
 .S LVL2=0 F  S LVL2=$O(APID(X,LVL2)) Q:'LVL2  D
 ..S NXT=APID(X,LVL2) D
 ...I $L($G(PID(LVL))_NXT)>245 S LNGTH=245-$L(PID(LVL)),PID(LVL)=PID(LVL)_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),LVL=LVL+1
 ...I $L($G(PID(LVL))_NXT)'>245 S PID(LVL)=$G(PID(LVL))_NXT
 ...I '$O(APID(X,LVL2)) S PID(LVL)=PID(LVL)_HL("FS")
 K VADM
 Q
