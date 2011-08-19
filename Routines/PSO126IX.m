PSO126IX ;BIR/PDW-Execute CMOP INDICATOR Index ;08/12/2002
 ;;7.0;OUTPATIENT PHARMACY;**126**;DEC 1997
 Q
CMPNDX ; new compound index on CMOP Indicator "CMP"
 ;check "A_x" indexes  to CMP index
 W !,"Updating the RX Suspense file's new 'CMP' index."
 W !,"Processing the AQ, AL, AX, AP indexes into the CMP index"
 F NDX="Q","L","X","P" D
 . S INDX="A"_NDX W !!,INDX
 . S SDT=0 F  S SDT=$O(^PS(52.5,INDX,SDT)) Q:'SDT  D
 .. S DFN=0 F  S DFN=$O(^PS(52.5,INDX,SDT,DFN)) Q:'DFN  D
 ... S REC=0 F  S REC=$O(^PS(52.5,INDX,SDT,DFN,REC)) Q:'REC  D
 .... S F=$G(^PS(52.5,REC,0))
 .... I 'F K ^PS(52.5,INDX,SDT,DFN,REC) Q  ;bad index  
 .... S TYP=$$CMPRXTYP^PSOCMOP(REC),CNT=$G(CNT)+1 I '(CNT#100) W "."
 .... F VP="RX^1","SDT0^2","DFN0^3","DIV^6","STAT^7" D PIECE(F,U,VP)
 .... I NDX=STAT,DFN=DFN0,SDT=SDT0
 .... E  K ^PS(52.5,INDX,SDT,DFN,REC)
 .... I STAT'="",$D(^PS(52.5,"CMP",STAT,TYP,DIV,SDT0,DFN,REC)) S ^PS(52.5,"CMP",NDX,TYP,DIV,SDT,DFN,REC)=""
 Q
PIECE(REC,DLM,VP) ; VP="Variable^Piece" : S Variable=$P(REC,DLM,Piece)
 N V,P S V=$P(VP,DLM),P=$P(VP,DLM,2),@V=$P(REC,DLM,P)
 Q
