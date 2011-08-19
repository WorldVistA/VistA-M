FHZDOC ; HISC/REL - Produce Documentation ;5/16/91  09:24
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 ;
OP K G F I=1:1 S A=$P($T(PGMS+I),";",3,99) Q:A=""  I @$P(A,";",2) S G($E(A,1,2))=A
 W !! Q:$O(G(""))=""  S A="" F I=0:0 S A=$O(G(A)) Q:A=""  W !?6,$P(G(A),";",1)
O1 R !!?6,"Select Option: ",A:DTIME Q:'$T!("^"[A)  I A'?2U W *7,"  Enter 2 Letters of Option" G O1
 I '$D(G(A)) W *7,"  ??" G O1
 S X=$P(G(A),";",3) K A,I,G D @X K X G OP
PGMS ;;
 ;;FL  First Line Listing;1;^FHZDOC1
 ;;DM  Diagram Menus;1;^FHZDOC2
 ;;FF  File List;1;EN1^FHZDOC3
 ;;FS  File Security;1;EN2^FHZDOC3
 ;;PD  Package Definition;1;EN3^FHZDOC3
