DIAUTL ;GFT/GFT - UTILITIES TO TURN ON AND TO ANALYZE FILEMAN AUDITS;24JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,140,1000,1004,1005,1012,1022,1023,1039,1043,1044**
 ;
TURNONDD(DIFILE,DIMODE) ;Turn on DATA DICTIONARY AUDITING  --THIS IS NOW A NO-OP, BECAUSE WE AUDIT ALL DD CHANGES IN FILE .6!!!!
 K:$G(DIMODE)=1 DIMODE S DIMODE=$G(DIMODE,"Y")
 I DIMODE'="Y",DIMODE'="N" D BLD^DIALOG(200) Q
 I DIFILE<1.11 Q
 I '$D(^DIC(+DIFILE)) D BLD^DIALOG(401,DIFILE) Q
 S ^DD(DIFILE,0,"DDA")=DIMODE ;It's really just one SET!
 Q
 ;
DISP(DDB) ;DISPLAY DD CHANGES FROM ^DDA SINCE DATE 'DDB'
 N DIA,FR,BY,TO,DHD,DDHD,DIC,L,POP,DDIO,DIOEND,DDTOUT,DIOSL,DIFIXPT,DIFIXPTH S DIFIXPT=1 ;KEEPS ^%ZIS FROM BEING CALLED IN ^DIP3
 D ^%ZIS Q:POP  S DDIO=IO U IO
 F DIA=0:0 S DIA=$O(^DDA(DIA)) Q:'DIA  S FR=$O(^DDA(DIA,"D",DDB)) D:FR  Q:$D(DDTOUT)
 .U IO W @IOF D DDHD
 .S DIC="^DDA("_DIA_",",BY="-(#.03)@",TO=DT+1,FLDS="[DIAUTL]",L=0
 .S DIOEND="S:$G(DIOO1) DDTOUT=1",DIOSL=IOSL ;DHD="W ?0 D DDHD^DIAUTL",IOP=DDIO
 .D EN1^DIP
 U IO W @IOF D CLOSE^DIO4
 Q
DDHD S DDHD="DATA DICTIONARY CHANGES, "_$P($G(^DIC(DIA,0)),U)_" FILE(#"_DIA_")" S:DDB DDHD=DDHD_" since "_$$DATE^DIUTL(DDB)
 W DDHD,!
 W "FIELD                     ATTRIBUTE                                USER NUMBER",!
 W "------------------------------------------------------------------------------",!
 Q
 ;
 ;
TURNON(DIFILE,FLDS,DIMODE) ;Turn on AUDITING for the FLDS named   --MODE is either "y", "n" or "e"
 N D,DIFIELD,DIE,DR,DA,DIQUIET,DIEZS,D0,DQ,DI,DIC,X
 K:$G(DIMODE)=1 DIMODE S DIMODE=$E($G(DIMODE,"y"))
 I DIMODE'="y",DIMODE'="e",DIMODE'="n" D BLD^DIALOG(200) Q
 S DIQUIET=1,DIEZS=1 Q:DIFILE<1.11&(DIFILE-.4)&(DIFILE-.401)&(DIFILE-.402)&(DIFILE-.403)&(DIFILE-.5)&(DIFILE-.7)&(DIFILE-.84)&(DIFILE-.847)
 D DT^DICRW
 F DIFIELD=0:0 S DIFIELD=$O(^DD(DIFILE,DIFIELD)) Q:'DIFIELD  D:$$FLDSINC(DIFILE,FLDS,DIFIELD) ON
 Q
ON N DIOLD
 S DIOLD=$G(^DD(DIFILE,DIFIELD,"AUDIT")) I DIOLD=DIMODE Q  ;It's already on
 S D=$P($G(^(0)),U,2) Q:D["C"
 I D D TURNON(+D,"**",DIMODE) Q  ;Recursive!
 S DR="1.1////"_DIMODE,DIE="^DD("_DIFILE_",",DA(1)=DIFILE,DA=DIFIELD
 I DA=.001,DIMODE="y" Q  ;CAN'T AUDIT NUMBER FIELD!!
 D ^DIE
 D IN^DIU0(DIFILE,DIFIELD),DDAUDIT(DIFILE,DIFIELD,1.1,DIOLD,DIMODE)
 I $G(^DD(DIFILE,0,"DIK"))]"" D EN2^DIKZ(DIFILE,"",^("DIK")) ;Recompile CROSS-REFS if auditing changes
 Q
 ;
CHANGED(FILE,FLDS,FLAGS,ARRAY,START,END) ;
 ;Returns in @ARRAY the list of entries in FILE who had any of the fields in FLDS changed from START to END
 ;If FLAGS is "O", the Oldest values are saved in @ARRAY@(entry,field)
 N GLO,E,F,T,D,%I
 K @ARRAY
 S FLAGS=$G(FLAGS)
 S GLO=^DIC(FILE,0,"GL")
 I '$G(START) S START=0
 I '$G(END) D NOW^%DTC S END=%
 S T=START D  F  S T=$O(^DIA(FILE,"C",T)) Q:T>END!'T  D
 .F D=0:0 S D=$O(^DIA(FILE,"C",T,D)) Q:'D  D
 ..S E=$G(^DIA(FILE,D,0)) Q:$P(E,U,6)="i"!'E
 ..I $D(@ARRAY@(+E)),FLAGS="" Q
 ..S F=+$P(E,U,3) Q:'$$FLDSINC(FILE,FLDS,F)
 ..I '$D(@(GLO_"+E)")),FLAGS="" Q
 ..S @ARRAY@(+E)="" I FLAGS["O",'$D(@ARRAY@(+E,F)) S @ARRAY@(+E,F)=$G(^DIA(FILE,D,2))
 Q
 ;
FIRST(DIQGR,ENTRY,FLDS) ;
 N LOF S LOF=1 G LOF
LAST(DIQGR,ENTRY,FLDS) ;returns DATE^USER who most recently touched any of the FLDS in ENTRY in File DIQGR
 N LOF S LOF=-1
LOF N E,F,DILAST,DENTRY,L
 S DILAST="",DENTRY=+ENTRY
 I ENTRY["," D
 .F F=2:1 Q:'$D(^DD(DIQGR,0,"UP"))  S DENTRY=$P(ENTRY,",",F)_","_DENTRY
 D E
 S DENTRY=ENTRY_","
 F  S DENTRY=$O(^DIA(DIQGR,"B",DENTRY)) Q:DENTRY-ENTRY  D E
 Q DILAST
 ;
E S E="" F  S E=$O(^DIA(DIQGR,"B",DENTRY,E),LOF) Q:'E  I $$FLDSINC(DIQGR,FLDS,+$P($G(^DIA(DIQGR,E,0)),U,3)) D  Q:DENTRY=ENTRY&DILAST
 .Q:$P(^DIA(DIQGR,E,0),U,6)="i"  ;Ignore INQUIRY
 .S L=$P(^(0),"^",2)_"^"_$P(^(0),"^",4)_"^"_$P($G(^(4.1)),U)
 .I LOF=-1,L>DILAST S DILAST=L
 .I LOF=1,DILAST>L!'DILAST S DILAST=L
 Q
 ;
DATE(FILE,FIELD) ;
 D VALUE(FILE,FIELD,2) Q
 ;
USER(FILE,FIELD) ;
 D VALUE(FILE,FIELD,4) Q
 ;
VALUE(FILE,FIELD,TU) ;FILE' can be SubFile
 N DIACMP,ENTRY,I
 S ENTRY=+$G(D0)
 F I=1:1 Q:'$D(^DD(FILE,0,"UP"))  S ENTRY=ENTRY_","_+$G(@("D"_I)),F=^("UP"),FIELD=$O(^DD(F,"SB",FILE,0))_","_FIELD,FILE=F
 D PRIOR(FILE,ENTRY,FIELD,.DIACMP)
 S D="" F  S D=$O(DIACMP(D),-1) Q:'D  S X=$S($G(TU):$P(^DIA(FILE,D,0),U,TU),1:DIACMP(D)) X DICMX Q:'$D(D)
 S X="" Q
 ;
PRIOR(FILE,ENTRY,FIELD,OUT) ;
 N E
 F E=0:0 S E=$O(^DIA(FILE,"B",ENTRY,E)) Q:'E  I $P($G(^DIA(FILE,E,0)),U,3)=FIELD S OUT(E)=$G(^(2))
 Q
 ;
FLDSINC(DIQGR,DR,DIAUTLF) ;is DIAUTLF within DR?  -- from 'DIQGQ' routine
 I DR=""!'DIAUTLF Q 0
 I DR="*" Q 1
 N DIAUGOT,DIQGCP,DIQGDD,DIQGXDC,DIQGXDF,DIQGXDI,DIQGXDN,DIQGXDD
 S DIQGXDC=0,DIAUGOT=0,DIQGDD=1,DIQGCP="D"
 I '$D(DIQGR) N X S X(1)="FILE" G 202
 S DIQGXDD="^DD("_DIQGR_")"
 S:DIQGR DIQGR=$S(DIQGDD:$$DD(DIQGR),1:$$ROOT^DIQGU(DIQGR,.DA)) I DIQGR="" N X S X(1)="FILE AND IEN COMBINATION" G 202
 F DIQGXDI=1:1 S DIQGXDF=$P(DR,";",DIQGXDI),DIQGXDN=$P(DIQGXDF,":") Q:DIQGXDF=""  D RANGE G GOT:DIAUGOT
NOGOT Q 0
 ;
RANGE I DIQGXDC,$P(^DD(+DIQGXDC,.01,0),"^",2)'["W" S:DR="**" DIQGXDN=DIQGXDN_"*" Q:$L(DIQGXDN,"*")'=2  ;multiple
 I DIQGXDN'?.N,$L(DIQGXDN,"*")=2,$P(DIQGXDN,"*")]"",$D(@DIQGXDD@("B",$P(DIQGXDN,"*"))) S DIQGXDN=$O(^($P(DIQGXDN,"*"),""))_"*"
 I DIQGXDN?1.2"*" S DIAUGOT=1 Q
 Q:DIAUTLF<DIQGXDN  I $P(DIQGXDF,":",2)<DIAUTLF Q:DIAUTLF-DIQGXDN
 S DIAUGOT=1 Q
 ;
GOT Q 1
 ;
DD(X) Q:'$D(^DD(X)) "" Q "^DD("_X_","
202 D BLD^DIALOG(202,.X) Q  ;bad parameter
 ;
 ;
GET(FIL,DA,DATE,TMP,FIELD) ;BUILD 'TMP' ARRAY AS OF DATE
 ;DA is in IEN format    FIELD, optional, means just look at one field
 K @TMP
 N DAT,FLD,FILE,F,D,E,B,C,T
 S F=FIL,FILE=$$FNO^DILIBF(F),@TMP=FILE,D=+$P(DA,",",$L(DA,",")-1) I 'D S D=DA
 I F=FILE F E=0:0 S E=$O(^DIA(FILE,"B",D,E)) Q:'E  D L G Q:$G(@TMP@(F,D_","))
SUBFILES S D=D_"," F  S E=D,D=$O(^DIA(FILE,"B",D)) Q:D-E  D
 .F E=0:0 S E=$O(^DIA(FILE,"B",D,E)) Q:'E  D L
 Q
L I $P($G(^DIA(FILE,E,0)),U)'=D Q
 S FLD=$P(^(0),U,3),DAT=$P(^(0),U,2),I="",F=FILE
 F  S C=$L(FLD,","),I=I_$P(D,",",C)_"," Q:C=1  S T=+FLD G Q:'$D(^DD(F,T,0)) S T=+$P(^(0),U,2) G Q:T'>F!'$D(^DD(T)) S F=T,FLD=$P(FLD,",",2,C)
 I FLD=.01,DAT>DATE,$P(^DIA(FILE,E,0),U,5)="A" K @TMP@(F,I) S @TMP@(F,I)=1 Q  ;THAT ENTRY OR SUB-ENTRY DIDN'T EXIST AS OF DATE  2nd level will only be defined in this case
 I $G(FIELD),FLD-FIELD!(F-FIL) Q
 I '$D(@TMP@(F,I,FLD)) S @TMP@(F,I,FLD)=DAT_U_E Q
 I DAT>DATE Q
 I @TMP@(F,I,FLD)<DAT S @TMP@(F,I,FLD)=DAT_U_E
Q Q
 ;
DIA(DAT,FILE,X,DIAUTLEX) ;FROM DIQG AND DIQGQ
 ;X is a node value from the 'TMP' array built by the GET subroutine, above
 ;DAT is the date/time as of which we want the audited value
 ;DIAUTLEX may contain "E" if we want external value
 I X>DAT Q $$D(2) ;We know what it was before deletion
 Q $$D(3)
D(ON) S X=$G(^DIA(FILE,+$P(X,U,2),ON)) I $G(DIAUTLEX)["E" Q X
 N S,Y S S=$G(^(ON+.1)) I X]"",S="" D  I Y>0 Q Y
 .N %DT S %DT="T" D ^%DT
 S S=$P(S,U) I S]"" Q S
 Q X
 ;
DDAUDIT(B0,DA,A0,A1,A2) ;B0=File or SubFile,  DA=Field, A0=Attribute #, A1=Old value, A2=New value
 N DDA,%,%T,%D,J,B3,I
 Q:'$D(DUZ)!'$G(DT)
 D IJ^DIUTL(B0)
 S A0=+$G(A0),A0=$P($G(^DD(0,A0,0)),U)_U_A0
 K:$G(A1)="" A1 L:$G(A2)="" A2
 D P^DICATTA Q
