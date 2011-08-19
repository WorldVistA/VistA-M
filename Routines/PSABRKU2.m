PSABRKU2 ;BHM/DB - Automatic processing of invoices;16 DEC 99
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**26**; 10/24/97
 ;This routine is a continuation of the Upload GUI
 ;the program will attempt to process as much of the invoice
 ;data as it can.
 ;
 ;Order Unit matching, supply item identification, and location
 ;assignment are attempted.
 ;
 K PSACTRL,PSALOC,PSAMV,PSACS,PSANCS
 I '$D(^XTMP("PSAPV")) G Q
CNT ;Count invoices that need a pharm location or master vault assigned.
 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:PSACTRL=""  D
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .I $G(PSASORT)'=0,$G(PSASORT)'="",$D(^XTMP("PSAPV",PSACTRL,"ST")),$P(^XTMP("PSAPV",PSACTRL,"ST"),"^",1)'=PSASORT Q
 .S PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 .I $P(PSAIN,"^",10)="ALL CS",$P(PSAIN,"^",12)="" S PSACNT=PSACNT+1,PSACS(PSACTRL)="" Q
 .I $P(PSAIN,"^",10)'="ALL CS" D
 ..I $P(PSAIN,"^",9)="CS" S:$P(PSAIN,"^",7)="" PSANCS(PSACTRL)="" S:$P(PSAIN,"^",12)="" PSACS(PSACTRL)="" S:$P(PSAIN,"^",7)=""!($P(PSAIN,"^",12)="") PSACNT=PSACNT+1 Q
 ..I $P(PSAIN,"^",9)="",$P(PSAIN,"^",7)="" S PSACNT=PSACNT+1,PSANCS(PSACTRL)=""
 I 'PSACNT G Q
 ;
 ;Gets pharmacy locations
 S (PSALOC,PSANUM)=0 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .S PSANUM=PSANUM+1,PSAONE=PSALOC,PSAISIT=+$P(^PSD(58.8,PSALOC,0),"^",3),PSAOSIT=+$P(^(0),"^",10)
 .D SITES^PSAUTL1 S PSACOMB=$S('$D(PSACOMB):"NO COMBINED IP/OP",1:PSACOMB),PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=PSAISIT_"^"_PSAOSIT
 ;
 ;Gets master vaults
 S (PSAMVN,PSAMV)=0 F  S PSAMV=+$O(^PSD(58.8,"ADISP","M",PSAMV)) Q:'PSAMV  D
 .Q:'$D(^PSD(58.8,PSAMV,0))!($P($G(^PSD(58.8,PSAMV,0)),"^")="")
 .I +$G(^PSD(58.8,PSAMV,"I")),+^PSD(58.8,PSAMV,"I")'>DT Q
 .S PSAMVN=PSAMVN+1,PSAONEMV=PSAMV,PSAMV($P(^PSD(58.8,PSAMV,0),"^"),PSAMV)=""
 I 'PSANUM G 2
 I PSANUM=1 D ONE
 G 2
ONE ;Only one location
 S PSACNT=0,PSALOC=PSAONE,PSALOCN=$O(PSALOCA(""))
 S PSACTRL="" F  S PSACTRL=$O(PSANCS(PSACTRL)) Q:PSACTRL=""  D
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)=PSALOC,PSACNT=1
 S PSA=$O(PSACS("")) D:PSA'="" MASTER
 Q
 ;
MASTER ;Assigns invoice to Master Vault
 I 'PSAMVN G 2
 ;
 I PSAMVN=1 D
 .S PSACTRL=$O(PSACS(""))
 .S PSACTRL="" F  S PSACTRL=$O(PSACS(PSACTRL)) Q:PSACTRL=""  D
 ..Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 ..S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)=PSAONEMV
2 ;Match order units
 K X1,X2,X3,X4
 ;Loop through TMP("PSA ORDER",CMT,0)
 Q
Q Q
