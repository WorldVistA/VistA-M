PSX41PST ;BIR/PDW-New indexes in PSX patch 41, MOVE 550.1 INTO 550.21 ;08/12/2002
 ;;2.0;CMOP;**41**;11 Apr 97
 ;; Reference to ^PS(52.5, supported by DBIA #1978
 ;; Reference to ^PSOCMOP  supported by DBIA #2476
 Q
EN ;
 I ^XMB("NETNAME")?1"CMOP-".E Q
 D EN^PSX41NDX ; clear and build indexes in *41
 ;
5501 ; REMOVE ENTRIES FROM 550.1
 I ^XMB("NETNAME")?1"CMOP-".E Q
 K ^PSX(550.1) S ^PSX(550.1,0)="CMOP RX QUEUE^550.1^0^0"
 ;
5502 D COR5502
 D CMPNDX
MSG ; print reminder to use Kernel tasking
 I ^XMB("NETNAME")?1"CMOP-".E Q
 W !
 F I=1:1 S X=$T(TXT+I) Q:X["END"  W !,$P(X,";;",2)
 W !!,"^^^  PLEASE NOTE THE ABOVE  ^^^^"
 W !,"Pausing 20 seconds" F I=1:1:20 W "." H 1
 Q
TXT ;
 ;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 ;;
 ;;The following PSX options must be placed into the Option Scheduling File
 ;;using the Kernel Taskman menu Schedule/Unschedule Options.
 ;; 
 ;;     PSXR SCHEDULED CS TRANS
 ;;     PSXR SCHEDULED NON-CS TRANS
 ;; 
 ;;This must be done so they can be accessed through the CMOP menus.
 ;;
 ;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 ;;END
 Q
COR5502 ;correct Total RXs field from PSX*2*41 v25
 S PSXDT=$O(^PSX(550.2,"D",3030325)) Q:'PSXDT
 S PSXTDA=$O(^PSX(550.2,"D",PSXDT,0))
 S BATDA=PSXTDA-.1 F  S BATDA=$O(^PSX(550.2,BATDA)) Q:BATDA'>0  S XX=$P($G(^PSX(550.2,BATDA,1)),"^",8) I XX'=+XX,XX["5///" D
 . S TOTRX=$P(XX,"5///"),$P(^PSX(550.2,BATDA,1),"^",8)=TOTRX
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
 .... I STAT'="",'$D(^PS(52.5,"CMP",STAT,TYP,DIV,SDT0,DFN,REC)) D
 ..... S ^PS(52.5,"CMP",NDX,TYP,DIV,SDT,DFN,REC)=""
 Q
PIECE(REC,DLM,VP) ; VP="Variable^Piece" : S Variable=$P(REC,DLM,Piece)
 N V,P S V=$P(VP,DLM),P=$P(VP,DLM,2),@V=$P(REC,DLM,P)
 Q
