ONCORIS1 ;HINES OIFO/RTK - ONCORIS MIGRATION NON-ONC MULTIPLES ;11/18/25
 ;;2.2;ONCOLOGY;**23**;Jul 31, 2013;Build 6
 ;
MULT2 ;Handle multiples for file #2
 S ONCMUFLG=""
 S DDSUB=+$P($G(^DD(FILENUM,DDNUM,0)),"^",2)
 S SUBNODEN=$P($G(^DD(FILENUM,DDNUM,0)),"^",4)
 S SUBNODE=$P(SUBNODEN,";",1)
 I $O(^DPT(RECNUM,SUBNODE,0))="" Q
 W ","  ;write the comma for previous field; assume first field not MULT/WP
 W !,"      "_ONCQ_DDNUM_ONCQ_" :"
 W !,"      {"
 S SBRECNUM=0 F  S SBRECNUM=$O(^DPT(RECNUM,SUBNODE,SBRECNUM)) Q:SBRECNUM'>0  D
 .I $P($G(^DPT(RECNUM,SUBNODE,SBRECNUM,0)),"^",1)="" Q
 .S ONCMUFLG=""
 .W !,"        "_ONCQ_SBRECNUM_ONCQ_" :"
 .W !,"        {"
 .S DDSUBNUM=0 F  S DDSUBNUM=$O(^DD(DDSUB,DDSUBNUM)) Q:DDSUBNUM'>0  D
 ..N DATYPE,FDNAME,NODE,NODEPC,PIECE,RECDATA
 ..S FDNAME=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",1)  ;sub-field name
 ..S DATYPE=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",2)  ;sub-field data type
 ..S NODEPC=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",4)  ;sub-field position
 ..I NODEPC=" ; " Q  ; skip multiples within multiples
 ..S NODE=$P(NODEPC,";",1),PIECE=$P(NODEPC,";",2)
 ..I $P(NODEPC,";",2)=0 Q  ; skip word processing within multiples
 ..S RECDATA=$P($G(^DPT(RECNUM,SUBNODE,SBRECNUM,NODE)),"^",PIECE)
 ..I RECDATA="" Q
 ..I ONCMUFLG'="" W ","
 ..S ONCMUFLG=1
 ..I DATYPE["F" S OLDLINE=RECDATA D ESCAPE^ONCORIS S RECDATA=NEWLINE
 ..I DATYPE'["N" W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 ..I DATYPE["N" D
 ...S RECDATA=+RECDATA
 ...I RECDATA?1".".N S RECDATA="0"_RECDATA
 ...W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_RECDATA
 ..Q
 .W !,"        }" I $O(^DPT(RECNUM,SUBNODE,SBRECNUM))>0 W ","
 W !,"      }"
 Q
 ;
MULT200 ;Handle multiples for file #200
 S ONCMUFLG=""
 S DDSUB=+$P($G(^DD(FILENUM,DDNUM,0)),"^",2)
 S SUBNODEN=$P($G(^DD(FILENUM,DDNUM,0)),"^",4)
 S SUBNODE=$P(SUBNODEN,";",1)
 I $O(^VA(200,RECNUM,SUBNODE,0))="" Q
 W ","  ;write the comma for previous field; assume first field not MULT/WP
 W !,"      "_ONCQ_DDNUM_ONCQ_" :"
 W !,"      {"
 S SBRECNUM=0 F  S SBRECNUM=$O(^VA(200,RECNUM,SUBNODE,SBRECNUM)) Q:SBRECNUM'>0  D
 .I $P($G(^VA(200,RECNUM,SUBNODE,SBRECNUM,0)),"^",1)="" Q
 .S ONCMUFLG=""
 .W !,"        "_ONCQ_SBRECNUM_ONCQ_" :"
 .W !,"        {"
 .S DDSUBNUM=0 F  S DDSUBNUM=$O(^DD(DDSUB,DDSUBNUM)) Q:DDSUBNUM'>0  D
 ..N DATYPE,FDNAME,NODE,NODEPC,PIECE,RECDATA
 ..S FDNAME=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",1)  ;sub-field name
 ..S DATYPE=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",2)  ;sub-field data type
 ..S NODEPC=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",4)  ;sub-field position
 ..I NODEPC=" ; " Q  ; skip multiple within multiple
 ..S NODE=$P(NODEPC,";",1),PIECE=$P(NODEPC,";",2)
 ..I $P(NODEPC,";",2)=0 Q  ; skip word processing within multiples
 ..S RECDATA=$P($G(^VA(200,RECNUM,SUBNODE,SBRECNUM,NODE)),"^",PIECE)
 ..I RECDATA="" Q
 ..I ONCMUFLG'="" W ","
 ..S ONCMUFLG=1
 ..I DATYPE["F" S OLDLINE=RECDATA D ESCAPE^ONCORIS S RECDATA=NEWLINE
 ..I DATYPE'["N" W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 ..I DATYPE["N" D
 ...S RECDATA=+RECDATA
 ...I RECDATA?1".".N S RECDATA="0"_RECDATA
 ...W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_RECDATA
 ..Q
 .W !,"        }" I $O(^VA(200,RECNUM,SUBNODE,SBRECNUM))>0 W ","
 W !,"      }"
 Q
 ;
MULT5   ;Handle multiples for file #5
 S ONCMUFLG=""
 S DDSUB=+$P($G(^DD(FILENUM,DDNUM,0)),"^",2)
 S SUBNODEN=$P($G(^DD(FILENUM,DDNUM,0)),"^",4)
 S SUBNODE=$P(SUBNODEN,";",1)
 I $O(^DIC(5,RECNUM,SUBNODE,0))="" Q
 W ","  ;write the comma for previous field; assume first field not MULT/WP
 W !,"      "_ONCQ_DDNUM_ONCQ_" :"
 W !,"      {"
 S SBRECNUM=0 F  S SBRECNUM=$O(^DIC(5,RECNUM,SUBNODE,SBRECNUM)) Q:SBRECNUM'>0  D
 .S ONCMUFLG=""
 .W !,"        "_ONCQ_SBRECNUM_ONCQ_" :"
 .W !,"        {"
 .S DDSUBNUM=0 F  S DDSUBNUM=$O(^DD(DDSUB,DDSUBNUM)) Q:DDSUBNUM'>0  D
 ..N DATYPE,FDNAME,NODE,NODEPC,PIECE,RECDATA
 ..S FDNAME=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",1)  ;sub-field name
 ..S DATYPE=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",2)  ;sub-field data type
 ..S NODEPC=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",4)  ;sub-field position
 ..I NODEPC=" ; " Q  ; skip multiples within multiples
 ..S NODE=$P(NODEPC,";",1),PIECE=$P(NODEPC,";",2)
 ..I $P(NODEPC,";",2)=0 Q  ; skip word processing within multiples
 ..S RECDATA=$P($G(^DIC(5,RECNUM,SUBNODE,SBRECNUM,NODE)),"^",PIECE)
 ..I RECDATA="" Q
 ..I ONCMUFLG'="" W ","
 ..S ONCMUFLG=1
 ..I DATYPE["F" S OLDLINE=RECDATA D ESCAPE^ONCORIS S RECDATA=NEWLINE
 ..I DATYPE'["N" W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 ..I DATYPE["N" D
 ...S RECDATA=+RECDATA
 ...I RECDATA?1".".N S RECDATA="0"_RECDATA
 ...W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_RECDATA
 ..Q
 .W !,"        }" I $O(^DIC(5,RECNUM,SUBNODE,SBRECNUM))>0 W ","
 W !,"      }"
 Q
 ;
MULT50 ;Handle multiples for file #50
 S ONCMUFLG=""
 S DDSUB=+$P($G(^DD(FILENUM,DDNUM,0)),"^",2)
 S SUBNODEN=$P($G(^DD(FILENUM,DDNUM,0)),"^",4)
 S SUBNODE=$P(SUBNODEN,";",1)
 I $O(^PSDRUG(RECNUM,SUBNODE,0))="" Q
 W ","  ;write the comma for previous field; assume first field not MULT/WP
 W !,"      "_ONCQ_DDNUM_ONCQ_" :"
 W !,"      {"
 S SBRECNUM=0 F  S SBRECNUM=$O(^PSDRUG(RECNUM,SUBNODE,SBRECNUM)) Q:SBRECNUM'>0  D
 .S ONCMUFLG=""
 .W !,"        "_ONCQ_SBRECNUM_ONCQ_" :"
 .W !,"        {"
 .S DDSUBNUM=0 F  S DDSUBNUM=$O(^DD(DDSUB,DDSUBNUM)) Q:DDSUBNUM'>0  D
 ..N DATYPE,FDNAME,NODE,NODEPC,PIECE,RECDATA
 ..S FDNAME=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",1)  ;sub-field name
 ..S DATYPE=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",2)  ;sub-field data type
 ..S NODEPC=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",4)  ;sub-field position
 ..I NODEPC=" ; " Q  ; skip multiples within multiples
 ..S NODE=$P(NODEPC,";",1),PIECE=$P(NODEPC,";",2)
 ..I $P(NODEPC,";",2)=0 Q  ; skip word processing within multiples
 ..S RECDATA=$P($G(^PSDRUG(RECNUM,SUBNODE,SBRECNUM,NODE)),"^",PIECE)
 ..I RECDATA="" Q
 ..I ONCMUFLG'="" W ","
 ..S ONCMUFLG=1
 ..I DATYPE["F" S OLDLINE=RECDATA D ESCAPE^ONCORIS S RECDATA=NEWLINE
 ..I DATYPE'["N" W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 ..I DATYPE["N" D
 ...S RECDATA=+RECDATA
 ...I RECDATA?1".".N S RECDATA="0"_RECDATA
 ...W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_RECDATA
 ..Q
 .W !,"        }" I $O(^PSDRUG(RECNUM,SUBNODE,SBRECNUM))>0 W ","
 W !,"      }"
 Q
 ;
 Q  ;exit
