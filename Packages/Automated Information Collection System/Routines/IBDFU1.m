IBDFU1 ;ALB/CJM - AICS get list descriptions ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15**;APR 24, 1997
 ;
LSTDESCR(IBLIST) ;parses the IBLIST record pointed to by IBBLK and puts the
 ;descripition in IBLIST - should be called by reference
 ;returns 1 if list description not found
 N NODE,J,C
 S NODE=$G(^IBE(357.2,IBLIST,0))
 Q:NODE="" 1
 S IBLIST("NAME")=$P(NODE,"^",1)
 S IBLIST("BLK")=$P(NODE,"^",2)
 S IBLIST("DSCHDR")=$P(NODE,"^",4)
 S IBLIST("HDR")=$P(NODE,"^",5)
 S IBLIST("DHDR")=$P(NODE,"^",6)
 S IBLIST("SEP")=$P(NODE,"^",7) D
 .;how to separate subcolumns
 .I IBLIST("SEP")=1 S IBLIST("SEP")=" ",IBLIST("SEP1")=" ",IBLIST("SEP2")="" Q
 .I IBLIST("SEP")=2 S IBLIST("SEP")="  ",IBLIST("SEP1")="  ",IBLIST("SEP2")="" Q
 .I IBLIST("SEP")=3 S IBLIST("SEP")="|",IBLIST("SEP1")="|",IBLIST("SEP2")="" Q
 .I IBLIST("SEP")=4 S IBLIST("SEP")=" | ",IBLIST("SEP1")=" |",IBLIST("SEP2")=" " Q
 ;
 S IBLIST("BTWN")=$P(NODE,"^",8)
 S IBLIST("DGHDR")=$P(NODE,"^",9)
 S IBLIST("RTN")=$P(NODE,"^",11)
 S IBLIST("INPUT_RTN")=$S(IBLIST("RTN"):$P($G(^IBE(357.6,IBLIST("RTN"),0)),"^",13),1:"")
 S IBLIST("ULSLCTNS")=$P(NODE,"^",12)
 S IBLIST("NUMCOL")=$P(NODE,"^",13)
 S IBLIST("DYNAMIC")=+$P(NODE,"^",14)
 S IBLIST("OVERFLOW")=+$P(NODE,"^",15)
 S IBLIST("OTHER")=$P(NODE,"^",16)
 S IBLIST("CLRMLIST")=$P(NODE,"^",19)
 S IBLIST("CLRM")=+$P($G(^IBE(357.6,+$P(NODE,"^",11),0)),"^",20)
 S (IBLIST("NAR_READ"),IBLIST("NAR_PRINT"),IBLIST("CODE_READ"),IBLIST("CODE_PRINT"))=0
 I $P(NODE,"^",17)=1 S IBLIST("NAR_PRINT")=1,IBLIST("CODE_PRINT")=0
 I $P(NODE,"^",17)=2 S IBLIST("NAR_PRINT")=0,IBLIST("CODE_PRINT")=1
 I $P(NODE,"^",17)=3 S IBLIST("NAR_PRINT")=1,IBLIST("CODE_PRINT")=1
 I $P(NODE,"^",18)=1 S IBLIST("NAR_READ")=1,IBLIST("CODE_READ")=0
 I $P(NODE,"^",18)=2 S IBLIST("NAR_READ")=0,IBLIST("CODE_READ")=1
 I $P(NODE,"^",18)=3 S IBLIST("NAR_READ")=1,IBLIST("CODE_READ")=1
 ;
 ;go to the package interface
 S NODE="" S:IBLIST("RTN") NODE=$G(^IBE(357.6,IBLIST("RTN"),16))
 S IBLIST("NAR_DATATYPE")=$P(NODE,"^",2),IBLIST("NAR_HDR")=$P(NODE,"^",3),IBLIST("CODE_DATATYPE")=$P(NODE,"^",6),IBLIST("CODE_HDR")=$P(NODE,"^",7)
 ;
 S IBLIST("SC0")=IBLIST("DYNAMIC")&IBLIST("INPUT_RTN")
 ;get column information
 F J=1:1:4 S C=$O(^IBE(357.2,IBLIST,1,"B",J,"")) S NODE=$S('C:"",1:$G(^IBE(357.2,IBLIST,1,C,0))) S IBLIST("Y",J)=$P(NODE,"^",2),IBLIST("X",J)=$P(NODE,"^",3),IBLIST("H",J)=$P(NODE,"^",4)
 ;get subcolumn information
 I IBLIST("SC0") S IBLIST("SCHDR",0)="",IBLIST("SCW",0)=4,IBLIST("SCTYPE",0)=1,IBLIST("SCPIECE",0)=0,IBLIST("SCEDITABLE",0)=0,IBLIST("NOUL",0)=0
 F J=1:1:8 S C=$O(^IBE(357.2,IBLIST,2,"B",J,"")) S NODE=$S('C:"",1:$G(^IBE(357.2,IBLIST,2,C,0))) D
 .S IBLIST("SCTYPE",J)=$P(NODE,"^",4) Q:'IBLIST("SCTYPE",J)
 .S IBLIST("SCHDR",J)=$P(NODE,"^",2) S:IBLIST("SCHDR",J)=" " IBLIST("SCHDR",J)="" S IBLIST("SCW",J)=$P(NODE,"^",3)
 .I IBLIST("SCTYPE",J)=1 S IBLIST("SCPIECE",J)=$P(NODE,"^",5),IBLIST("SCEDITABLE",J)=$P(NODE,"^",7),IBLIST("NOUL",J)=$P(NODE,"^",8) D
 ..I IBLIST("SCPIECE",J)=1,IBLIST("RTN") S IBLIST("SCEDITABLE",J)=$S($P($G(^IBE(357.6,IBLIST("RTN"),2)),"^",2)="":1,1:0)
 .I IBLIST("SCTYPE",J)=2 D
 ..S IBLIST("SCSYMBOL",J)=$P(NODE,"^",6)
 ..S IBLIST("NOUL",J)=$P(NODE,"^",8),IBLIST("ROUTINE",J)=""
 ..S IBLIST("QLFR",J)=$P(NODE,"^",9),IBLIST("RULE",J)=+$P(NODE,"^",10)
 ..I 'IBLIST("SCSYMBOL",J) S IBLIST("SCSYMBOL",I)="",IBLIST("SCW",J)=0 Q
 ..S NODE=$G(^IBE(357.91,IBLIST("SCSYMBOL",J),0))
 ..I '$P(NODE,"^",4) S IBLIST("SCSYMBOL",J)=$P(NODE,"^",2),IBLIST("SCW",J)=$L(IBLIST("SCSYMBOL",J)) D  Q
 ...I $L($G(IBLIST("SCHDR",J)))>IBLIST("SCW",J) S IBLIST("SCW",J)=$L(IBLIST("SCHDR",J)),IBLIST("SCSYMBOL",J)=$J($$CJ^XLFSTR(IBLIST("SCSYMBOL",J),IBLIST("SCW",J)),IBLIST("SCW",J))
 ..;may need to call a special procedure if printing to a PCL printer
 ..I $E($P(NODE,"^"),1,6)="BUBBLE" D
 ...S IBLIST("ROUTINE",J)="BUBBLE",IBLIST("SCW",J)=3,IBLIST("SCSYMBOL",J)="   "
 ...I $L(IBLIST("SCHDR",J))>IBLIST("SCW",J) S IBLIST("SCW",J)=$L(IBLIST("SCHDR",J)),IBLIST("SCSYMBOL",J)=$J(" ",IBLIST("SCW",J))
 Q 0
 ;
LSTDSCR2(IBLIST) ;parses the IBLIST record pointed to by IBBLK and puts the
 ;descripition in IBLIST(just what's needed while editing the selection
 ;list, not for printing it) in- should be called by reference
 ;returns 1 if list description not found
 N NODE,J,C
 S NODE=$G(^IBE(357.2,IBLIST,0))
 Q:NODE="" 1
 S IBLIST("RTN")=$P(NODE,"^",11)
 S IBLIST("DYNAMIC")=+$P(NODE,"^",14)
 S IBLIST("BTWN")=$P(NODE,"^",8)
 S IBLIST("CLRMLIST")=$P(NODE,"^",19)
 S IBLIST("CLRM")=+$P($G(^IBE(357.6,+$P(NODE,"^",11),0)),"^",20)
 ;get subcolumn information
 F J=1:1:8 S C=$O(^IBE(357.2,IBLIST,2,"B",J,"")) S NODE=$S('C:"",1:$G(^IBE(357.2,IBLIST,2,C,0))) D
 .Q:NODE=""  S IBLIST("SCTYPE",J)=$P(NODE,"^",4) Q:'IBLIST("SCTYPE",J)
 .S IBLIST("SCHDR",J)=$P(NODE,"^",2),IBLIST("SCW",J)=$P(NODE,"^",3)
 .I IBLIST("SCTYPE",J)=1 S IBLIST("SCPIECE",J)=$P(NODE,"^",5),IBLIST("SCEDITABLE",J)=$P(NODE,"^",7) I IBLIST("SCPIECE",J)=1,IBLIST("RTN") S IBLIST("SCEDITABLE",J)=$S($P($G(^IBE(357.6,IBLIST("RTN"),2)),"^",2)="":1,1:0)
 Q 0
 ;
SCDESCR(LIST,CWIDTH) ;computes the offsets for each subcolumn and
 ;computes the column width (CWIDTH)
 N I,SCHDR,CHDR,W,FLAG
 ;CHDR will be the line with all the subcolumn headers
 S CWIDTH=LINE+$L($P(LIST("SEP"),"|",2))
 S CHDR="",FLAG=0
 F I=1-LIST("SC0"):1:8 D
 .I (LIST("SCTYPE",I)'=1)&(LIST("SCTYPE",I)'=2) S LIST("SCTYPE",I)="" Q
 .I 'LIST("SCW",I) S LIST("SCTYPE",I)="" Q
 .I LIST("SCHDR",I)'="" S FLAG=1,LIST("SCHDR",I)=$E(LIST("SCHDR",I),1,LIST("SCW",I))
 .S LIST("SCOS",I)=CWIDTH+((LIST("SCW",I)-$L(LIST("SCHDR",I)))\2)
 .S CWIDTH=CWIDTH+LIST("SCW",I)+$L(LIST("SEP"))
 .S SCHDR=LIST("SCHDR",I)
 .S W=$L(SCHDR)
 .S SCHDR=$$PADRIGHT^IBDFU($J(SCHDR,W+((LIST("SCW",I)-W)\2)),LIST("SCW",I))
 .S:CHDR'="" CHDR=CHDR_$J("",$L(LIST("SEP")))
 .S CHDR=CHDR_SCHDR
 ;
 ;calculate the column width
 S CWIDTH=CWIDTH-$L($P(LIST("SEP"),"|"))
 ;
 ;if there were no subcolumn headers then that line is empty, don't print
 I 'FLAG S LIST("CHDR")="" Q
 S LIST("CHDR")=LIST("SEP2")_CHDR
 Q
