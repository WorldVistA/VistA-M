PXQFV ;ISL/ARS,JVS - DEPENDENT ENTRY COUNT-VISITS(AUPNVSIT) ;5/1/97  08:30
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**4,29**;Aug 12, 1996
 ;
DEC(VISIT,VISUAL,EXPAND) ;Test looking through DD to find fields pointing to the visit entries.
 ; VISIT=Visit ien to looked up and counted
 ; VISUAL= Set to 1 if you want and interactive display of what is found
 ; EXPAND= SET TO 1 TO EXPAND ENTRIES
 ;
 ; Look for file and field
 ;
 N DD,BECKY,COUNT,FIELD,FILE,GET,PIECE,PX,REF,SNDPIECE,STOP,SUB,VAUGHN
 N DEC,DECF,ENTRY,VAR
 ;
 S DD="^DD"
 S FILE=""
 F  S FILE=$O(@DD@(9000010,0,"PT",FILE)) Q:FILE=""  D
 .S FIELD=""
 .F  S FIELD=$O(@DD@(9000010,0,"PT",FILE,FIELD)) Q:FIELD=""  D
 ..S VDD(FILE,FIELD)=""
 D REF,QUE
 K VDDN,VDDR
 I $G(VISUAL) S VAR="COUNT= "_COUNT W $$RE^PXQUTL(VAR)
 Q ""
 ;
REF ;Look for all of the regular cross references and other
 ;
 S FILE="" F  S FILE=$O(VDD(FILE)) Q:FILE=""  D
 .S FIELD="" F  S FIELD=$O(VDD(FILE,FIELD)) Q:FIELD=""  D
 ..D REG
 K VDD
 Q
 ;
REG ;Look for regular cross references
 ;
 S STOP=0
 I '$D(@DD@(FILE,FIELD,1)) S VDDN(FILE,FIELD)="" Q
 S SUB=0 F  S SUB=$O(@DD@(FILE,FIELD,1,SUB)) Q:SUB=""  D
 .S GET=$G(@DD@(FILE,FIELD,1,SUB,0)) D
 .I $P(GET,"^",3)']"" S VDDR(FILE,SUB)=FILE_"^"_FIELD_"^"_SUB S STOP=1
 .E  S VDDN(FILE,FIELD)=""
 Q
QUE ;CHECK OUT CROSS REFERENCE
 ;
 N PFILE
 W:($G(EXPAND)&('$G(BROKEN))) $$EXP("^AUPNVSIT(",VISIT)
 S FILE="",FIELD="",STOP="",COUNT=0
 F  S FILE=$O(VDDR(FILE)) Q:FILE=""  D
 .S SUB=0,STOP="" F  S SUB=$O(VDDR(FILE,SUB)) Q:SUB=""  Q:STOP=1  S GET=$G(VDDR(FILE,SUB)) D
 ..S REF=$G(@DD@($P(GET,"^",1),$P(GET,"^",2),1,$P(GET,"^",3),1))
 ..I $P(REF,"""",1)["DA(1)" Q
 ..S PIECE=$P(REF," ",2)
 ..S SNDPIECE=$P(PIECE,"""",1,2)_""""
 ..S VAUGHN=$P(PIECE,"""",1,2)_""")"
 ..I $D(@VAUGHN) D  S STOP=1
 ...S PX=SNDPIECE_",VISIT)"
 ...I $D(@PX) D
 ....I '$G(EXPAND) S BECKY=0 F  S BECKY=$O(@PX@(BECKY)) Q:BECKY=""  S COUNT=COUNT+1 S DEC=SNDPIECE_","_VISIT_","_BECKY S DECF=$$FILE(SNDPIECE,FILE) W:$G(VISUAL) $$RE^PXQUTL(DEC_" - - - - "_DECF) D
 .....I $G(BROKEN),SNDPIECE["AUPNVCPT" S (DFN,PATIENT)=$P($G(^AUPNVCPT(BECKY,0)),"^",2)
 .....I $G(BROKEN),SNDPIECE["SCE" S DATE=$P($G(^SCE(BECKY,0)),"^",1)
 .....W:$G(EXPAND) $$EXP^PXQUTL(SNDPIECE,BECKY)
 .....W:$G(PXQSOR) $$SOR(SNDPIECE,BECKY),$$SOR^PXQFE(SNDPIECE,BECKY)
 .....W:$G(PXQAUDIT) $$AUDIT(SNDPIECE,BECKY)
 ....I $G(EXPAND) S BECKY=0 F  S BECKY=$O(@PX@(BECKY)) Q:BECKY=""  S COUNT=COUNT+1 S PFILE=$$FILE(SNDPIECE,FILE) W:$G(VISUAL) $$RE^PXQUTL("          "_PFILE_" ") D
 .....W:$G(EXPAND) $$EXP^PXQUTL(SNDPIECE,BECKY)
 .....W:$G(PXQSOR) $$SOR(SNDPIECE,BECKY),$$SOR^PXQFE(SNDPIECE,BECKY)
 .....W:$G(PXQAUDIT) $$AUDIT(SNDPIECE,BECKY)
 Q
LINE() ;
 Q:'$G(PXQAUDIT) ""
 W "- - - - -"
 Q ""
AUDIT(ROOT,IEN) ;---AUDIT TRAIL OF ENTRIES
 N I,REF,REF2,SOURCE,ACTION,PERSON,NOD,J
 S REF=$P(ROOT,"""",1)_IEN_")"
 S REF2=$P(ROOT,"""",1)_IEN
 F  S REF=$Q(@REF) Q:REF'[REF2  D
 .I REF[",801" S NOD=$P(@REF,"^",2) Q:NOD']""  D
 ..;W "ACTION",?26,"SOURCE",?52,"PERSON"
 ..W $$RE^PXQUTL("ACTION                   SOURCE                    PERSON")
 ..F I=1:1:$L(NOD,";") S J=$P(NOD,";",I) Q:J']""  D
 ...S SOURCE=$P(^PX(839.7,$P(J,"-",1),0),"^",1)
 ...S ACTION=$P($P(J,"-",2)," ",1) S ACTION=$S(ACTION="E":"EDIT",ACTION="A":"CREATED",1:"")
 ...S PERSON=$P(^VA(200,$P(J," ",2),0),"^",1)
 ...W $$RE^PXQUTL(""""_ACTION_""",?16,"""_SOURCE_""",?45,"""_PERSON_"""")
 W $$RE^PXQUTL("___________________________________________________________")
 Q ""
 ;----FUNCTIONS
SOR(ROOT,IEN) ;---EXPAND ENTRIES
 N I,REF,REF2,PKG,SOR,ADD,EDT
 ;I ROOT["SCE",$P($G(^SCE(IEN,0)),"^",6)="",$G(PXQPRM)=1 D
 ;.W $$RE^PXQUTL("    ~~~~ERROR~~~")
 ;.W $$RE^PXQUTL("** There is more Than 1 PARENT OUTPATIENT ENCOUNTER pointing to the same VISIT**")
 ;.W $$RE^PXQUTL(" ")
 ;I ROOT["SCE",$P($G(^SCE(IEN,0)),"^",6)="" S PXQPRM=1
 S (PKG,SOR)=""
 S REF=$P(ROOT,"""",1)_IEN_")"
 S REF2=$P(ROOT,"""",1)_IEN
 F  S REF=$Q(@REF) Q:REF'[REF2  D
 .I REF[",812" S PKG=$P(@REF,"^",2),SOR=$P(@REF,"^",3) D
 ..I PKG>0,$D(^DIC(9.4,$G(PKG))) S PKG=$P(^DIC(9.4,$G(PKG),0),"^",1)
 ..I SOR>0 S SOR=$P(^PX(839.7,$G(SOR),0),"^",1)
 ..S PKG="PACKAGE ="_$G(PKG)
 ..W $$RE^PXQUTL(PKG)
 ..S SOR="SOURCE  ="_$G(SOR)
 ..W $$RE^PXQUTL(SOR)
 S (PKG,SOR)=""
 K ADD,EDT
 Q ""
EXP(ROOT,IEN) ;---EXPAND ENTRIES
 N I,REF,REF2
 S REF=$P(ROOT,"""",1)_IEN_")"
 S REF2=$P(ROOT,"""",1)_IEN
 F  S REF=$Q(@REF) Q:REF'[REF2  S ENTRY=REF_" = "_@REF W $$RE^PXQUTL(ENTRY)
 I '$G(PXQSOR) W $$RE^PXQUTL("___")
 I REF["AUPNVSIT" W $$RE^PXQUTL(" ")
 Q ""
FILE(RT,FILENUM) ;
 N FILE S FILE=""
 I '$D(FILENUM) Q "UNKNOWN"
FF I $D(^DIC(FILENUM)) D
 .S FILE=$P($G(^DIC(FILENUM,0)),"^",1)
 E  I $D(^DD(FILENUM)) S FILENUM=+$G(^DD(FILENUM,0,"UP")) G FF
 Q FILE_" FILE"
PL ;--CHECK PAGE LENGTH
 N ANS,DX,DY
 I IOST["C-",$Y>22 S DX=0,DY=0 X ^%ZOSF("XY") R !,"Press ENTER to continue: ",ANS:DTIME
 Q
