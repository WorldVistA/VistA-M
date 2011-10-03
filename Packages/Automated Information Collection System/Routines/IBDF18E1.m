IBDF18E1 ;ALB/CJM - ENCOUNTER FORM - PCE DEVICE INTERFACE utilities ;04-OCT-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**1,3,38,36**;APR 24, 1997
 ;
GETPI(PI,QLFR,TYPE) ; -- returns information about the package interface 
 ;                    needed to map data to PCE DEVICE INTERFACE
 ;
 ; -- input - PI := pointer to the package interface file
 ;                  MUST be passed by reference
 ;          QLFR := pointer to the data qualifier
 ;          TYPE := pointer to file 359.1, applies to hand print fields
 ;
 ; -- output  PI :="" if the mapping can not be determined
 ;            PI(PI,"NODE")
 ;            PI(PI,"VAL")
 ;            PI(PI,"TXT")
 ;            PI(PI,"HDR")
 ;            PI(PI,"QLFR")
 ;            PI(PI,"QTY")
 ;      - if QLFR is passed, also returns PI(PI,QLFR,"IND")
 ;      - if PI(PI,QLFR,"IND")=1,meaning there is independent mapping
 ;        info for this qualifier - then also returns PI(PI,QLFR,"NODE")=
 ;        <the node>,PI(PI,QLFR,"VAL")=<piece for the value>,
 ;        PI(PI,QLFR,"TXT")=<the piece for txt>,PI(PI,QLFR,"HDR")=
 ;        <piece for the hdr>,
 ;        PI(PI,QLFR,"QLFR")=<piece for the qualifier code>
 ;      - if TYPE is passed , also returns PI(PI,"TYPE",TYPE,"UNIT")=
 ;        <unit code> and PI(PI,"TYPE",TYPE,"VTYPE")=
 ;        <vitals type code>
 ;
 ;NOTE - it is assumed that entries in the PI() may be left hanging around,and if so they are valid
 ;
 N NODE,QNODE,PIECE,IEN
 I '$G(PI) S PI="" G GETPIQ
 ;
 ; -- type of package interface must be for input
 I $P($G(^IBE(357.6,PI,0)),"^",6)'=1 S PI="" G GETPIQ
 ;
 I '$D(PI(PI)) D  Q:'PI ""
 .S NODE=$G(^IBE(357.6,PI,12))
 .S PI(PI,"NODE")=$P(NODE,"^")
 .S PI(PI,"VAL")=$P(NODE,"^",2)
 .S PI(PI,"TXT")=$P(NODE,"^",3)
 .S PI(PI,"HDR")=$P(NODE,"^",4)
 .S PI(PI,"QLFR")=$P(NODE,"^",5)
 .S PI(PI,"QTY")=$P(NODE,"^",6)
 ;
 ; - if there is a 'PCE DIM PIECE, VARIABLE VALUE' node, execute code to
 ; - determine value for PCE DIM PIECE, VALUE (since it is variable, it
 ; - must be asked outside of the above dotted do
 S X="",Y=VALUE X $G(^IBE(357.6,PI,21)) I X S PI(PI,"VAL")=X
 ;
 ;special rules apply for the VITALS node
 I PI(PI,"NODE")="VITALS" D  Q:'PI ""
 .S PI(PI,"VAL")=2 ;the value for the VITALS node goes to piece 2
 .;
 .I 'TYPE D LOGERR^IBDF18E2(35791001,.FORMID,TYPE,$G(VALUE),PI) S PI(PI,"TYPE",+$G(TYPE),"VTYPE")="",PI(PI,"TYPE",+$G(TYPE),"UNIT")="" Q
 .;
 .;may have already gotten
 .I $D(PI(PI,"TYPE",TYPE)) Q
 .;
 .S IEN=$O(^IBE(357.6,PI,13,"B",TYPE_";IBE(359.1,",""))
 .I 'IEN D LOGERR^IBDF18E2(3576001,.FORMID,TYPE,$G(VALUE),PI) S PI(PI,"TYPE",TYPE,"VTYPE")="",PI(PI,"TYPE",TYPE,"UNIT")="" Q
 .S NODE=$G(^IBE(359.1,TYPE,0))
 .S PI(PI,"TYPE",TYPE,"UNIT")=$P(NODE,"^",13)
 .S PI(PI,"TYPE",TYPE,"VTYPE")=$P(NODE,"^",12)
 .S PI(PI,"TYPE",TYPE,"DATATYPE")=$P($G(^IBE(359.1,TYPE,10)),"^",1)
 ;
 ;if not VITALS, and there is a QLFR, get independent mapping info if not gotten previously
 I PI(PI,"NODE")'="VITALS",QLFR I '$D(PI(PI,QLFR,"IND")) D  Q:'PI ""
 .S PI(PI,QLFR,"CODE")=$P($G(^IBD(357.98,QLFR,0)),"^",2)
 .S IEN=$O(^IBE(357.6,PI,13,"B",QLFR_";IBD(357.98,",""))
 .I 'IEN D LOGERR^IBDF18E2(3576002,.FORMID,$G(TYPE),$G(VALUE),PI,$G(QLFR)) S PI(PI,QLFR,"IND")=0 Q
 .S NODE=$G(^IBE(357.6,PI,13,IEN,0))
 .S PI(PI,QLFR,"IND")=$P(NODE,"^",3)
 .Q:'PI(PI,QLFR,"IND")
 .S QNODE=$P(NODE,"^",4) S:QNODE="" QNODE=PI(PI,"NODE") S PI(PI,QLFR,"NODE")=QNODE
 .S PIECE=$P(NODE,"^",8) S:('PIECE)&(PI(PI,"NODE")=PI(PI,QLFR,"NODE")) PIECE=PI(PI,"QLFR") S PI(PI,QLFR,"QLFR")=PIECE
 .;
 .;if the node isn't different for the qualifier then the value,text,and header can not be mapped independently
 .I PI(PI,"NODE")=PI(PI,QLFR,"NODE") D
 ..S PI(PI,QLFR,"VAL")=PI(PI,"VAL"),PI(PI,QLFR,"TXT")=PI(PI,"TXT"),PI(PI,QLFR,"HDR")=PI(PI,"HDR")
 .E  S PI(PI,QLFR,"VAL")=$P(NODE,"^",5),PI(PI,QLFR,"TXT")=$P(NODE,"^",6),PI(PI,QLFR,"HDR")=$P(NODE,"^",7)
 .;must at least know the piece to place the returned value
 .I (PI(PI,QLFR,"NODE")="")!('PI(PI,QLFR,"VAL")) S PI=""
 ;
 ;must at least know the node and the piece to place the returned value
 I 'QLFR I (PI(PI,"NODE")="")!('PI(PI,"VAL")) S PI=""
GETPIQ Q PI
 ;
SETTEMP ; -- sets values for the field into TEMP()
 ;    values are merged for fields that consist of a collection
 ;
 ; -- Output   QCODE := <qualifier code>
 ;              PHDR := <header piece>
 ;              PVAL := <value piece>
 ;              PTXT := <text piece>
 ;             PQLFR := <qualifier piece>
 ;               SUB := <PCE GDI node>
 ;              NODE := <the value of the node>
 ;              PLEX := <clinical lexicon piece, for use with diag.>
 ;
 N QCODE,PHDR,PVAL,PTXT,PQLFR,SUB,NODE,PLEX,PQTY,SAVEPI
 S SAVEPI=PI
 Q:'PI
 S PI=$$GETPI(.PI,QLFR,TYPE) I 'PI D LOGERR^IBDF18E2(3576003,.FORMID,$G(TYPE),$G(VALUE),SAVEPI,$G(QLFR)) Q
 ;
 S QCODE=$S(QLFR:PI(PI,QLFR,"CODE"),1:"")
 ;
 ;determine if QCODE should be passed as VALUE
 I $P($G(^IBE(357.6,PI,20)),"^") N VALUE S VALUE=QCODE
 ;
 S PQTY=PI(PI,"QTY")
 ;mapping info could come from several different sources depending on whether or not a data qualifier is involved or the node=VITALS or ENCOUNTER
 I QLFR,PI(PI,"NODE")'="VITALS",PI(PI,"NODE")'="ENCOUNTER" I PI(PI,QLFR,"IND") D
 .S PHDR=PI(PI,QLFR,"HDR"),PVAL=PI(PI,QLFR,"VAL"),PTXT=PI(PI,QLFR,"TXT"),PQLFR=PI(PI,QLFR,"QLFR"),SUB=PI(PI,QLFR,"NODE")
 E  D
 .S PHDR=PI(PI,"HDR"),PVAL=PI(PI,"VAL"),PTXT=PI(PI,"TXT"),PQLFR=PI(PI,"QLFR"),SUB=PI(PI,"NODE")
 ;
 ;the ENCOUNTER node is treated differently, because there is always just one of them
 S:SUB'="ENCOUNTER" NODE=$G(TEMP(SUB,$P(FID,"("),+ITEM))
 S:SUB="ENCOUNTER" NODE=$G(PXCA("ENCOUNTER"))
 ;
 ; -- define clin lex pointer if from data enty  ($d(ibdf(item)))
 ;    if from scanning clin lex pointer defined in ibdf18e
 S PLEX=0 I SUB="DIAGNOSIS/PROBLEM" D
 .S PLEX=3
 .I $G(ITEM)'="" I $D(IBDF(ITEM)) S LEX=$P(IBDF(ITEM),"^",5)
 ;
 ;the VITALS node is also treated differently
 I SUB="VITALS" D
 .I $G(PI(PI,"TYPE",TYPE,"DATATYPE"))="f" S VALUE=+VALUE ; set floating point values to M values
 .S $P(NODE,"^")=PI(PI,"TYPE",TYPE,"VTYPE"),$P(NODE,"^",3)=PI(PI,"TYPE",TYPE,"UNIT"),$P(NODE,"^",2)=VALUE,$P(NODE,"^",4)=+$G(PXCA("ENCOUNTER"))
 ;these are nodes other than VITALS and ENCOUNTER
 E  D
 .;merge the data into the node
 .;
 .; -- for second provider entry put in provider node, always put
 .;    primary in encounter node
 .I SUB="ENCOUNTER",PVAL=4,$P(NODE,"^",4) D  Q
 ..I QCODE="P",$P(NODE,"^",15)'="P" S PXCA("PROVIDER",$P(NODE,"^",4))=$P(NODE,"^",15),$P(NODE,"^",4)=VALUE,$P(NODE,"^",15)=QCODE Q
 ..S PXCA("PROVIDER",VALUE)=QCODE Q
 .;
 .S NARR=+$G(NARR) ; define Narr for manual data entry
 .;
 .;  -- change to add modifiers to visit code selected
 .;
 .I $P(NODE,"^",PVAL)="" D
 .. S:$S(NARR=0:1,1:$P(FID,"(",2)'="N") $P(NODE,"^",PVAL)=VALUE
 .. ;D MODTEMP
 .I PTXT S:$P(FID,"(",2)="N"&NARR TEXT=VALUE I $S(NARR=0:$L($P(NODE,"^",PTXT))<$L(TEXT),$P(FID,"(",2)="N":TEXT'="",1:0) S $P(NODE,"^",PTXT)=TEXT
 .I PHDR I $L($P(NODE,"^",PHDR))<$L(HEADER) S $P(NODE,"^",PHDR)=HEADER
 .I PQTY S $P(NODE,"^",PQTY)=$G(QUANTITY)
 .;
 .; -- insert clin lex pointer into temp arry and re-initialize
 .I $G(PLEX),$G(LEX) S $P(NODE,"^",PLEX)=LEX
 .S LEX=0
 .;
 .I QCODE'="" S $P(NODE,"^",PQLFR)=$S($P(NODE,"^",PQLFR)'="":$P(NODE,"^",PQLFR)_","_QCODE,1:QCODE)
 ;
 ;- Prevent 'No classification' node from being set in TEMP array
 ;- (not dynamic)
 S:SUB'="ENCOUNTER"&(SUB'="IBD NOCLASSIFICATION") TEMP(SUB,$P(FID,"("),+ITEM)=NODE
 D:SUB="PROCEDURE" MODTEMP
 ;
 ;- Set Encounter and 'No classification' nodes into PXCA array
 S:SUB="ENCOUNTER"!(SUB="IBD NOCLASSIFICATION") PXCA(SUB)=NODE
 D:SUB="ENCOUNTER" MODTEMP
 Q
MODTEMP ;-- Set up TEMP(SUB,$P(FID,"("),+ITEM, "MODIFIER array
 ;   the CPT Modifier information is stored in the selection file(357.3)
 ;
 ;
 N MCOUNT,MOD
 I $D(^IBE(357.3,+$G(SLCTN),3)) D
 . S MCOUNT=0
 . F MOD=0:0 S MOD=$O(^IBE(357.3,SLCTN,3,MOD)) Q:'MOD  D
 .. S MCOUNT=MCOUNT+1
 ..S TEMP(SUB,$P(FID,"("),+ITEM,"MODIFIER",MCOUNT)=$P($G(^IBE(357.3,SLCTN,3,MOD,0)),"^")
 .S:MCOUNT>0 TEMP(SUB,$P(FID,"("),+ITEM,"MODIFIER",0)=MCOUNT
 I $D(IBDF(+ITEM,"MODIFIER")) D
 . S MCOUNT=+$G(TEMP(SUB,$P(FID,"("),+ITEM,"MODIFIER",0))
 . S MOD=0 F  S MOD=$O(IBDF(+ITEM,"MODIFIER",MOD)) Q:'MOD  D
 .. S MCOUNT=MCOUNT+1
 .. S TEMP(SUB,$P(FID,"("),+ITEM,"MODIFIER",MCOUNT)=IBDF(+ITEM,"MODIFIER",MOD)
 . S TEMP(SUB,$P(FID,"("),+ITEM,"MODIFIER",0)=MCOUNT
 Q
